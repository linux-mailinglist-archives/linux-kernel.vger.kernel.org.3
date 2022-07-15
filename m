Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D17D575AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 07:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiGOFJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 01:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGOFJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 01:09:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BFB2A268;
        Thu, 14 Jul 2022 22:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZfVZJj9E15EfZ3gqQ5KbIPW4t1asSKkBExmpkUi/ivoOm9FlL/iPx0rLp2om01Z87bj3hDb015GOmKoOnQgKPi1zzOWLFI2Ro7SR1Q6RY/fq13S0l2+Jvb8Nt0WglbCCfl+9bH6mlHkSSVEHNoKBNhy1HzQDLjcIth51MW6f0V0Cn0gh22u/j5uys90L3J/lZSJc6Ism2LYfpJ2kbG++I+N15boikoleJ3+tq6qEZJRdvgB0aauEo47Kl7x28c8VG0ShYqgBOQ/SJVxcQktUS8/D33+sRhU6ajkGVc7zizMHB39yNIFl+ftuI54qzSkVMMEXwmvf4YYmkWr3gVajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqu7tvdzBZ2IieWi1xpysamo0JkSAtC050kdZwYQ7q8=;
 b=Edocb8/jZPGJc23ib+31jPyuzt1CIbnB9kC/K8rueJ4pB9q1kawpCZG6BjsUnWCsH0c0DjnML9EFr60t3JHDItKqk/q40TR34p3dRQIcEePFaM1CariscfAYpTjg7taIkyfuFt9oceDMO6X2PKSfNbytNPQ9+ZGWbdiaLi4y3DfDewn0/fmOT6Kp2ySWJvRtR4Vv8f+K3+S8Lc1OeyI4dXDph4UMnzBW4Sggffb5SnS6v3+7mTAXv2udCravFC76YZIbAWs5I/CFXE3//n/AlYRz0GHQ4UIj7PB8mwyeJk6tvozzeUdud3GeSp5nLtaIoNto5e/DYGjabelTngFqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqu7tvdzBZ2IieWi1xpysamo0JkSAtC050kdZwYQ7q8=;
 b=HiusFIaaw/f55wQ0xQMpEnMmaDeDHDUWmiCPoQMdw2gXMzjWkvfXKM9AR0dYzXxIZP6pZckWFAGIcgE1/FR6fVW/FoWjbnoBuPj9bERlvTrSH/0aF44SHwacIvBr7ErvP4yotejhUviapf0XHmPUzzE0T0s/irB4WRZ104PYWmzRIHSqTYMeQ+yo93HWgs4VmO5IBvAzHjEOrtcRtgE81UBz8JJeKrisnmFi11yXeoN5BoVQrvFDpTMg0me48wC/J+nVHAc1AujRAoTzpNG3qc4JI9W1u8jC1cJbTPnG1eCNIGmF6yP8a00jYqFEf5WFhCNzKzvY7jujylC20ZOWYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN6PR1201MB0196.namprd12.prod.outlook.com (2603:10b6:405:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 15 Jul
 2022 05:09:27 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365%7]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 05:09:27 +0000
Message-ID: <2a42658d-5bbc-7180-2d2f-e92541cc000d@nvidia.com>
Date:   Thu, 14 Jul 2022 22:09:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/6] gpiolib: cdev: simplify linereq_free
Content-Language: en-US
To:     Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, andy.shevchenko@gmail.com
References: <20220714020319.72952-1-warthog618@gmail.com>
 <20220714020319.72952-2-warthog618@gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20220714020319.72952-2-warthog618@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:a03:255::25) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a44100f-48f9-47ed-7d63-08da662030b0
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cdFgW8gqIy61uBZaLubKDh0POFVQRrQ4a3lfW+5NQF37yv/no40iW/dH8Uj/pEtBV+aJQ15QN6a4BzeuZN5TDAb7P0rAY/+WsR0XGGOYogXZ0ecyQXKXbuIizWhyiT7vi3ipcewx4hkdvpdDu6h5YOHfaq5XcluZ/xaDTmZrXLyvhfvfg0jtTHUFvLsN+XjKyLN9UZ9ygphGKT8TcnTlDTkuGRRdqndr3jokqhjTF98lsSaPx/17FdEBXhAITsVrLDzyFiNA/4GQy1jupxW54WiTMzxxrOMXuqnV4+0cRHQtkyiOGpLjbKir8A4MYT5IHODdlF+rRZuQ4RbR0DGFJXtR6/einq3gz2wKN1T/HauefHwcODntrpR2dA06Xdi3Q4Jlmno9IcP2kiE6owDME4WV9iRfmlon754d37qxGhafXeo7kEUhjVb+ks64GJkgjJePjYH1wuUGdax1Aaj30pYmTcxP59ytWGfy/rVO/ISo9y2SP8vZ2fg/jSAQHYFmj5kKrRb5cN0/8Gw4QPJRnk7gFB6Pv/7tUtzdT0944It3b6Evd2uJXb0l7Du3hR4BgKlX25BRa2qb9DDhaUd5kkGdhwBZvhymXvpUy2eEm49W/7qoUBEQuFSn7Ccgnk41VkCO0mCEGf6zwgm6UbrC/ZFXxts0n75zf6gD4lBzSDbHQ2MvqVFjFY11rLoii1aVPkvGOHxhD6erixIvhzK+z9/lkYAS9pStdnXEXNKOZaxPEyANVBBfjs1Xd8W2azYlL1WA8UjY5eP6TX15o3LxLYq2dAkIIH+QseDCi0m1h4THtygipvidzv7m69Igqo/J83MtIyRcpnryAUa775nBph1fwZdWpYugsxKok3UWlsNbnZwcFyZN60CwuzZedm8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(31696002)(86362001)(36756003)(38100700002)(186003)(31686004)(83380400001)(2616005)(8936002)(26005)(5660300002)(6666004)(41300700001)(478600001)(6506007)(53546011)(6486002)(66476007)(66946007)(66556008)(6512007)(8676002)(2906002)(316002)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymp0VThRU1k3cDhDeTBrdzg4ZE1ZRWFBMmJVU080UTRFR2I5OS8zbExiVGNo?=
 =?utf-8?B?SW5IYlBUcGRWY1cvTFFDT2tIMVN0YUI0WnRHdTJPMjdBLzlLbkg3T3lKa0VV?=
 =?utf-8?B?QU1aaHRUVUxIbk00dWV3NjVZNGpNVi82YjhoZVlkcTIrWWpWc1RLcDZZRDFS?=
 =?utf-8?B?cWFpdnZiM05kamlGTUtsaTI5REUwMWdnOTlLeTVDNUtIZ001Sm1KRnE0YjBs?=
 =?utf-8?B?Mit4WlZWdGZLdnU0UTdNQWNyVzJUa0NGTEo1R1p4djdHRnRFR2t0NHp1bG1z?=
 =?utf-8?B?UmJJRFhCdGVjaFdWUlMzSDU5bnJKVjMxdmQraVVNYk50Tis4ZlRYbW1mZ0l0?=
 =?utf-8?B?Umg2eSsyVDVBZmRwSHlSU1hTVDdGRU4za1k0cllLeW9vaythNVQwN1p2dy93?=
 =?utf-8?B?U3NXTDFFMklFVmlrcFhiYThWeXdzWjUxSHA1a1FzNUZXdnJBOG5ZRkxwb2Za?=
 =?utf-8?B?WmVXM2htWUdzeVA4VHRIZ1ZyM2Z1Z2lDQjZWbDVleE5BSGk3SkFHRkNWSGRy?=
 =?utf-8?B?c3hKNVNiUU1YcVRzMjJGckM5OXFPeHQ2U1JSRWQ1RzMrREFQaEZXQ0RFZDhB?=
 =?utf-8?B?ZktneXJkZWQrL1pUTXVxWEFjaURGcCtqMHBROUtoNm1GVnR2WVZQdzZyU0FE?=
 =?utf-8?B?L0NrRnJjOGdsZFdPT2ZiaStNbCtTV3pOa3JxV1F3QnpNa0tUdER2a3V0aU9l?=
 =?utf-8?B?TkNSb1ZhQTZtM09ZS0ZPWHVBL3pvb3FPRDVuVGRlWkRhWHAxandEekwzUzhh?=
 =?utf-8?B?bG03UHhocjZva1djMHFqN2tkSG9jS2JZWGIxczBpakk3d3ZSTmxlQk5YVEdr?=
 =?utf-8?B?Vzk3ZFBWSjkwOXFBbG9hOEdsVEZCMkg4NmNsMnVrWjdCaWJRaC9TY0hDdGV0?=
 =?utf-8?B?L1Z0N0VjVHV1dWE2dlVQekFmSzZlTUt5cWlwcnhYUUxxc1NwV2R2K1Q5ZkF6?=
 =?utf-8?B?ZWJRM1ZqMTEwTVBtM0c3Snh0S2o3ZlJ1OVNjckpnQzMyOW1SOTlHdlhZYkli?=
 =?utf-8?B?SWNYaHpBK0FncGpNdTVuSXY0Z3BZSEdOOUYwZUswT1Z3SVkrU2pWWmd0VHJQ?=
 =?utf-8?B?ZXQrcU5aUTFDVlRqSTZCNUswMU12elBsWm5RcE0yVExjU1U0cG52RWowZktE?=
 =?utf-8?B?eHJJTFpWQ2lsZHNDV0tvZ2hTRm1ETXcvM0xtV002TGtldjFsU1BMYzBKUGRt?=
 =?utf-8?B?dGVnTW5ZL2VDcWZ5U3JWYmV5ZGVacWUwUkdvR0FoczZHT1U3OEl1UEZBNzdu?=
 =?utf-8?B?RWhwdEU5ZmdaWGpwOC9qYmJnUm5nYndzbTRuRE5IOGJhUWlUT2FLZVg0WDBP?=
 =?utf-8?B?SzJMQU13UlBRRXFJZkZWclRYa1ZGQVI2R3ZvaGZWckZ6c3BJVTlORUQ1bWRl?=
 =?utf-8?B?bXRRMmthSHIxZVNoMG1SRTlhaE9pTGhNMDcyZHdDZ0tzWUxwbnE1MENtZjNw?=
 =?utf-8?B?VEhRZE9LdmZkdFYwaTBWd3RneVQ1UjRzVjRLNndMbFg4Zy9BRlY4SzNVWFJ4?=
 =?utf-8?B?OFhmMS9Kb0VJY1NweERBZUpnd2Y0Ym9tNmJZYzliWENucTg1aVRJbHdwNGZJ?=
 =?utf-8?B?ZDlsWTcwSE15QmJYMTBLN0g0NEduRUFqUlJYMUYzUko0QW0vZDl0YWY2YXhm?=
 =?utf-8?B?QXFuZHN6cWlGekh4RXBFVHB4USs2cWtPNW90d1hrUXFxV2dCT1YwNEhRVDJr?=
 =?utf-8?B?c293OHEvZURPc2hPYW9VRFQybTdRaTc0dVFmNnNrdnVMZGdvYlZJMExObUhm?=
 =?utf-8?B?REdwaUxjMzA2N2RNbHhkb1JpbXNoQzJkWGtiN1pyTmFGNkVnYUpGTkZOMm5N?=
 =?utf-8?B?K090WlptSWFqd2lqcmdyVmZYWEdrUWo3dzJRNTROYW9GS3kvaG9ucDZtdkY1?=
 =?utf-8?B?NWc5clptY3gzM3pHeVVNUzNyc3U5YUhRYzY3SXJPdUpFbFM1RERVaUFYNWpC?=
 =?utf-8?B?V3doNlIxUENlUlZERDMxbjBGTTU2RGlNU1A3cElVbHRwbVZtdzVKQkhCM2dB?=
 =?utf-8?B?TFJKN2dLRjJHZk04eklOMW9ISCtKL0JSWko0SGYvMWJ5TDZhUk9TMzZMQmFY?=
 =?utf-8?B?SitkRURKcklVREFMSFU3SnVGYXNZRFM2MnFLYi9jOGNLdVlDSlhmUFAwaFBN?=
 =?utf-8?Q?TSQmfn5dbtmNIaE8DTgsG9/bc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a44100f-48f9-47ed-7d63-08da662030b0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 05:09:26.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNsHBAjL7KLGn9ohvdSlkJfXohZa+ruo8X4aHuooLvC8M6BhnY1Uy81hPj91bykNYmX3agwlEesoensQ7KsjAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0196
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 7:03 PM, Kent Gibson wrote:
> The edge detector is only ever started after the line desc has been
> determined, so move edge_detector_stop() inside the line desc check,
> and merge the two checked regions into one.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 0c9a63becfef..b44526e3630e 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1460,15 +1460,15 @@ static ssize_t linereq_read(struct file *file,
>  static void linereq_free(struct linereq *lr)
>  {
>  	unsigned int i;
> -	bool hte = false;
> +	bool hte;
>  
>  	for (i = 0; i < lr->num_lines; i++) {
> -		if (lr->lines[i].desc)
> +		if (lr->lines[i].desc) {
>  			hte = !!test_bit(FLAG_EVENT_CLOCK_HTE,
>  					 &lr->lines[i].desc->flags);
> -		edge_detector_stop(&lr->lines[i], hte);
> -		if (lr->lines[i].desc)
> +			edge_detector_stop(&lr->lines[i], hte);
>  			gpiod_free(lr->lines[i].desc);
> +		}
>  	}
>  	kfifo_free(&lr->events);
>  	kfree(lr->label);

Acked-by: Dipen Patel <dipenp@nvidia.com>

