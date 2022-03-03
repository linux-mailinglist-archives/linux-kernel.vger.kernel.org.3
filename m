Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9A94CB9FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiCCJS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiCCJS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:18:26 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50096.outbound.protection.outlook.com [40.107.5.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E93D35DDA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJe+O+RsWvf9rJOgWv1nPg3gj/dyiubxVrBNKl7cpjaytdr8qU/kb6Db/keX2TGTq5m1jYv+h1owRPyh/4z6p/9Xqv90RD6p+1x++t4wRFQTKZ8f1UKlJ8NSN1JC7onw+iTTHgWSVFRrujXgcrQObF3MEj8eU/tDxmQlNLaTO8DzrsPkXR8arGkEsIGUxPFNYvRtfSm/Gfl6XUf2rdGtjnmtwMq6Hru5uGeSq0c83iFByafbYx2k3LGTI+uRKQnWaiDiQ6RLLcNUzSh431okcIk00jGg21yNRXVkvtknpn7RnvUyhyIxf03KYMkU/z3sP3I/UDGflEFShk9W9Yjz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq3Y0u+RXMh5Uzkaq6vn9LPlhy+LBN84Kh4fcsYxs0o=;
 b=XLicNEE5UNGg0Ng6bcyaX2GPX1VmTd6yk2d0LpNr7nV8ATaYwgQcZEewuoUkYotFoUOPZEdczjsCT0/XFVCdLpUqyPw8Qj6Yy399Dfi7+ldv4Q3oYebrVecLEd2HM8474LmWg71EZ4Cr+6f6oW6rCHfO7+hMrLYLaSxy/gGgylSK/pAxg/tuPHOmXN2Z0/R4Pp8bQDWgAZRzZlZO07K6fpA0GQvAel5Ifn4p0UHUYPoTz2Vbbx9asv+9f4d3dMFL40r9UFoxljGQCNTlgGDQUHFjW8VPXxrGtUlrfj9n0QaXT+Xfl+hCOoCIw+0sXN2WIsqW5H+a+I8AImdVVHrodQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq3Y0u+RXMh5Uzkaq6vn9LPlhy+LBN84Kh4fcsYxs0o=;
 b=nMykti3kPyw2YxJzKXl6cIbBorEbJ+/8LqQ2mjBvmOduxExYrw2Wr+w/P1fn64PrLHO5wUZeQkxHgrzOCSDcGm4hv0yFblrUxtnjBZFtM03vEaq7kbQh3+dEK5K1vV9bqYE+CMmkplnjhSWzTmToeqD18kDm4kBdOqcDFicN8nA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM6PR02MB5429.eurprd02.prod.outlook.com (2603:10a6:20b:d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 09:17:31 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 09:17:31 +0000
Message-ID: <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
Date:   Thu, 3 Mar 2022 10:17:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Daniels Umanovskis <du@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0084.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::17) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f55aca98-dfef-4b04-7401-08d9fcf6a532
X-MS-TrafficTypeDiagnostic: AM6PR02MB5429:EE_
X-Microsoft-Antispam-PRVS: <AM6PR02MB5429321CC7306B501477D990BC049@AM6PR02MB5429.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRPfg02wzXOjDcLbTq03Uqi6IFQVLjVVhsPPouYBOOap9JH5LObH1G13GXy1abgaEVTMMSzs+Nm89vMSLhEo2+J6oAAnmbYh7AkCxBf9Ne/NxvBOnq/yc443b5HbrnR+1O96UsWo7Ot/ihS5v4bZJ+cmqITvJ+w5VGh/7XyP1FNaP4rIi0gnWQfWF4t8rPw9RJ63etH4GWMIKJn1TnCq0OgkfA2sk1l7f03nXQTHFZ99cedidJAIPcHs+rStjs1QM5aW+YxcTPVACez7zo991mrAaNgWuOc6jw3VNjVywysYJqlJ24huoJzFZuRrZ2QqA0aSUziTqFCE3uvp3l+dEflaI+pzd/nlnNrTLNLqR4HDJxWJY/zhzahRckHoAPp0e3/NO7T2tP50VXY6Om1yhai5/s8eXg423T8fKsGPkaESTy2VW/nBKGwP+nolyEj6SohNXTPeufbjGg4x3xQlODyqKKNZTtU4953CS9M+Mz200g/3IyeRsBLp9vvM3aajRS/fVRhlx+wGPHnNS4Xx+9PD/rQC0pZAvhX9cN+dOiTHk5EVSCa/gsHzkueo6ugS8Dupa5JGiIKZdh1fJgFpwj0OPFuKz6GQpjnAuh3mRPS/yMBSC6yvc8fdqxhZ99jW5clFDcYDCldvTSuOMt6LVPwP9zodpIBEE+1mmovDLJC0uu0UzNEMYIpCSsERakjXfHfrhD1pbu8d6JmCMyoJoTHLpZznQXJWEDwc+7XPrR4ygwrSH+AoagXlYvWfpGoXNpNoscKWGb3R3WshumNXVwEmNhfkeym5mXOja+Pnz7RTckOw88WvkZGA+jSAPNmA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(39830400003)(346002)(396003)(366004)(136003)(4326008)(53546011)(66476007)(8676002)(66946007)(66556008)(31696002)(86362001)(5660300002)(8936002)(6506007)(36916002)(966005)(6512007)(83380400001)(508600001)(6486002)(6666004)(2906002)(38100700002)(186003)(26005)(31686004)(36756003)(2616005)(316002)(6916009)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTRmemV6R0x5MlJZaUN4NHlmbFhMWDc2QUtwcW1MNDBJYVl4UWNMZ1AyQ2FP?=
 =?utf-8?B?TDdLVDMzYnFSOFZtYVBad0VYcGluUmgyNWtWU09mcWN1KzVMUG5FY2IzQmN5?=
 =?utf-8?B?OCtRNytseXJHYy9sVnQ3YkxNRUNuclBVWDRubmxRbWJ0NjNRSmt4ajBrMkRG?=
 =?utf-8?B?Q2FRenFiUkdzRGZOSGdaVGxra0szdXp6am1YRC9HMCt1ZzBuSXRLTlFtNE1T?=
 =?utf-8?B?eGdqNzJPdnhWaTZ6QkQxdkxKWVFEUVdYV2N0dFloNnVMdnA5blJFa3BzMUZU?=
 =?utf-8?B?NUhrTzhPZG5Wa0xpTDAyNEZTeDFrR0RoeWxZUWtOVURUbXFMcWhNbkw4c0pL?=
 =?utf-8?B?MzdvNnhkY2YzRTlkbUFsTVIraStxZ1o1cTdlNlg0NU9OejZKSUNHdlZMeFZF?=
 =?utf-8?B?UDdBUWNQVUxnY2JpZWZzUGxzNWczeGtodVZVNHRQRFZGanRJbzh4THJJZzhm?=
 =?utf-8?B?TWFCOXlLZFhjZC9TWGM2ZFRXc0R1cE9MempxdnNyZzFpZzloUXRaNWlJZzdt?=
 =?utf-8?B?OExxOEJ4TVVwMGRsc2tHdTJEZmlIT2JrZ2o0aDlhaFcreC9pRVJDRzVNRlBE?=
 =?utf-8?B?Uis5MFFHNmwwN0hjOXUxd3JiQWZ6Rk5wY2NjNFlXekI2cnd3SW11aFZBKzl0?=
 =?utf-8?B?WXFwbklRT1h4UVRNMU0wMkEwQUdQV2orWVpkTzdXTnlBb05Md0xFa2IxN3B3?=
 =?utf-8?B?UDNTYTdLSFBvckFRbEhidGRnZ2R4cjhGaU5takYySytzUFFYZERQM01VR1Z2?=
 =?utf-8?B?SElwaW9OT2o1MlBadnlnL0NQbnY2TTF1SFZVZFUrNFNjWm1TbktwamdsaG1m?=
 =?utf-8?B?VmJGeEw0MmZ5b29BOUNHd1ZmeE5QK1QwRXF0S3JTZU1TeG8ybjRBYUduU0JJ?=
 =?utf-8?B?c292Q1BlSFkzYWU3NC82TDFYajJrNndwNzdXN1RBUzlPL0xpMElMMnAxd2NT?=
 =?utf-8?B?WjJxQ3g3YlBXR2ZLZTFpN2lYelU3WDV1V1k4MG5qMm45R3d3NmVhWU9qZ0cx?=
 =?utf-8?B?cGVmSGZhZEdVVEltOHExZ1FHZWpRNjFzUEhZZlc0NWt4MUcvY1gzbUNqMTZ0?=
 =?utf-8?B?Nng3RU8rcXdCeXZLWG8zMmJLYW1za1RSYXRza3pFQzBjaGQrWVE2L25KWkFm?=
 =?utf-8?B?NUFkaFh4THV6R2VwYmJhQXFTM0tSQk1zT0tSdkQ2akY1d1A5cllic2QwTWdD?=
 =?utf-8?B?RkFQcmZTSjF3RTQvZHNBNHorNi8zY0N6c09pdUFzdHRQeG5LanRxR1YyY1JO?=
 =?utf-8?B?bDdZdEFkNjl2Q2M1SjJjMENoTEV6cFZtM0FGSjRjZHF5dzJnYzBvcElsY2Z3?=
 =?utf-8?B?QW9raStGUlpPb2R1OHp4RGliZCtuZG9YbGlTRFdMbnFEMWN4UUsrdjhSclR4?=
 =?utf-8?B?c1duZEhhVU1rK216VUZFbWRVMEdLQkFqMXc4c2VzKy94d3lwL1pMc0xBRGhC?=
 =?utf-8?B?aUNxU0UwRm15STlYVlhPQVhjb1Z5eVNDeWROUUdiR2h6a3U1QnFwVnMzY1Bw?=
 =?utf-8?B?V21uOTl2a0FXQTJ2K3Q0RE9xYjNiU1J6UTZYNXNKdjBrRWYvRGgrUWcwSWtW?=
 =?utf-8?B?a0ozeEFibE9Oc1NWRDQ4L0FhREhRM3JkS0Z2R0VxWTZwOFdRcmhtTVRqWmRE?=
 =?utf-8?B?ZHdsR3JlY2F6QnphOFRob21sOEhMeEt3Tno1WHZJOVN1ZU5TbUdGMmM0QTEv?=
 =?utf-8?B?WTl1TGUxaW05OTVlWElFclRyd04yM2V3dTlFZ05tdnhVNE1FS1YyczhNdWp5?=
 =?utf-8?B?bCtUMmg3NlBLbFlRdENWVW9CNVBHS3V3RDhWcmlrNE1rUEVFSG1LMGpOZVIv?=
 =?utf-8?B?YUdjTVdpWUNmYTM0Nk5nZ1JIYXdpV0IvUWlJRXU2L2V4ejBQMjBXQ1hxSWVo?=
 =?utf-8?B?R1VlSmVQbFlORWZDUFo2QnR1LzRQYlJ6bE1HVncvaDFLTXBDN3hoZ3diN2Nv?=
 =?utf-8?B?bktCdUJwRTJZcUd4NzNRZFJkbzJGS2liSHJFenJSQnd4QXQrNittRGh6MmMr?=
 =?utf-8?B?TUFDaWlQcTltNUdNSmdXN3dueWhCYWd5NHB0S1A5dWlVamhuRy9aWUpHbnFt?=
 =?utf-8?B?dmFyK0V2ZFo2akc1aTNYV3BiS1dlR0R1ejA2cnRZa1JoN3BZd2hYN3Btd2NZ?=
 =?utf-8?Q?mBOM=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f55aca98-dfef-4b04-7401-08d9fcf6a532
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 09:17:31.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8WMe1aFO1lOGaqcNpp2Fg7HNKGitjGhphYpFq37+qj5R0UN+zfUsOxRLiDhemD6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-03 04:02, Saravana Kannan wrote:
> On Wed, Mar 2, 2022 at 4:29 PM Peter Rosin <peda@axentia.se> wrote:
>>
>> Hi!
>>
>> I'm seeing a weird problem, and I'd like some help with further
>> things to try in order to track down what's going on. I have
>> bisected the issue to
>>
>> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> 
> I skimmed through your email and I'll read it more closely tomorrow,
> but it wasn't clear if you see this on Linus's tip of the tree too.
> Asking because of:
> https://lore.kernel.org/lkml/20210930085714.2057460-1-yangyingliang@huawei.com/
> 
> Also, a couple of other data points that _might_ help. Try kernel
> command line option fw_devlink=permissive vs fw_devlink=on (I forget
> if this was the default by 5.10) vs fw_devlink=off.
> 
> I'm expecting "off" to fix the issue for you. But if permissive vs on
> shows a difference driver issues would start becoming a real
> possibility.
> 
> -Saravana

Thanks for the quick reply! I don't think I tested the very tip of
Linus tree before, only latest rc or something like that, but now I
have. I.e.

5859a2b19911 ("Merge branch 'ucount-rlimit-fixes-for-v5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")

It would have been typical if an issue that existed for a couple of
years had been fixed the last few weeks, but alas, no.

On that kernel, and with whatever the default fw_devlink value is, the
issue is there. It's a bit hard to tell if the incident probability
is the same when trying fw_devlink arguments, but roughly so, and I
do not have to wait for long to get a bad hash with the first
reproducer

   while :; do cat testfile | sha256sum; done

The output is typical:
78464c59faa203413aceb5f75de85bbf4cde64f21b2d0449a2d72cd2aadac2a3  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
e03c5524ac6d16622b6c43f917aae730bc0793643f461253c4646b860c1a7215  -
1b8db6218f481cb8e4316c26118918359e764cc2c29393fd9ef4f2730274bb00  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
7d60bf848911d3b919d26941be33c928c666e9e5666f392d905af2d62d400570  -
212e1fe02c24134857ffb098f1834a2d87c655e0e5b9e08d4929f49a070be97c  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
7e33e751eb99a0f63b4f7d64b0a24f3306ffaf7c4bc4b27b82e5886c8ea31bc3  -
d7a1f08aa9d0374d46d828fc3582f5927e076ff229b38c28089007cd0599c645  -
4fc963b7c7b14df9d669500f7c062bf378ff2751f705bb91eecd20d2f896f6fe  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
9360d886046c12d983b8bc73dd22302c57b0aafe58215700604fa977b4715fbe  -
4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -

Setting fw_devlink=off makes no difference, AFAICT.

So, just to double-check I went back to 5.11.22 with the two
mentioned patches reverted [1], plus an added backport of

c73960bb0a43 ("gpiolib: allow line names from device props to override driver names")

in order to make userspace behave as similarly as possible.
I left that running for an hour or so with 350-ish hashes
calculated correctly. Which is no proof that there is no latent
issue of course, but at the very least a great deal more stable
than later kernels.

Cheers,
Peter

[1]
f9aa460672c9 ("driver core: Refactor fw_devlink feature")
2d09e6eb4a6f ("driver core: Delete pointless parameter in fwnode_operations.add_links")

