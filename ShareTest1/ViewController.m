//
//  ViewController.m
//  ShareTest1
//
//  Created by Ernie Liu on 16/11/29.
//  Copyright (c) 2016年 Ernie Liu. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   }
static ShareType aType ;
- (IBAction)shareTypeClick:(UIButton *)sender
{
    if(sender.tag!=4)
    {//NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        if(sender.tag==1)//微博
        {
            aType = ShareTypeSinaWeibo;
            
        }
        else if (sender.tag==2)//qq好友
        {
            aType = ShareTypeQQ;
        }
        else if (sender.tag==3)//分享到微信朋友圈
        {
            aType = ShareTypeWeixiTimeline;
        }
        else if (sender.tag==5)//分享到QQ空间
        {
            aType = ShareTypeQQSpace;
        }
        else if (sender.tag==6)//分享到微信好友
        {
            aType = ShareTypeWeixiSession;
        }
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"res3" ofType:@"jpg"];
        //构造分享内容
        id<ISSContent> publishContent = [ShareSDK content:@"分享测试"
                                           defaultContent:@""
                                                    image:[ShareSDK imageWithPath:imagePath]
                                                    title:@"阿力demo"
                                                      url:@"http://www.baidu.com"
                                              description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                                mediaType:SSPublishContentMediaTypeNews];
        [ShareSDK clientShareContent:publishContent //内容对象
                                type:aType //平台类型
                       statusBarTips:YES
                              result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {//返回事件
                                  
                                  if (state == SSPublishContentStateSuccess)
                                  {
                                      NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
                                  }
                                  else if (state == SSPublishContentStateFail)
                                  {
                                      NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
                                  }
                              }];
        
    }
    else//弹出
    {
        //        aType = ShareTypeAliPaySocial;
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"晴" ofType:@"png"];
        
        //构造分享内容
        id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                           defaultContent:@"测试一下"
                                                    image:[ShareSDK imageWithPath:imagePath]
                                                    title:@"ShareSDK"
                                                      url:@"http://www.baidu.com"
                                              description:@"这是一条测试信息"
                                                mediaType:SSPublishContentMediaTypeNews];
        //创建弹出菜单容器
        id<ISSContainer> container = [ShareSDK container];
        [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
        
        //弹出分享菜单
        [ShareSDK showShareActionSheet:container
                             shareList:nil
                               content:publishContent
                         statusBarTips:YES
                           authOptions:nil
                          shareOptions:nil
                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                    
                                    if (state == SSResponseStateSuccess)
                                    {
                                        NSLog(@"分享成功");
                                    }
                                    else if (state == SSResponseStateFail)
                                    {
                                        NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
                                    }
                                }];
    }

}
- (IBAction)loginClick:(UIButton *)sender
{
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
