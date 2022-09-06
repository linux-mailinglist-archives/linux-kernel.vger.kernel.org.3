Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3B5AE5FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbiIFKyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbiIFKxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:53:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4399A2A9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiCfL5C/wHSj7QNbByWSSM/wg866RbAlbZKC74dps3TgbW3QyJ1DiFdfTCkTpfLiIrbJ7g/74bu3hUT7db73PaRG0gTjNgb2zb2FbUEVL7y2JJHy7GPXDvUIPL1vpgWaHhP9w1mFwBBdSiNFDqQxcpNAY5nl4rNM+k4pk70zg+t3+oTtyr+efhg6lHog3sZHoz2b/zcUA4RV/A5zj2s2v5C3A7QCvfgJwejOoSS9fbeFSLxGRDmsK957HxJi6KHxz85FtDXKsg3gsB5Z6lgy3Saby8/O007a8zubzFPkF1D405BkLqQGIE0kwWNfmPt4b87NlPvdJm7tzDEtuz/BBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKil9DlUp3z2G5pzrb3BG6+pD1Lx9CxBmODAFCT0Cyk=;
 b=iJfM8SuuPz2ehwjRmGO+cG3GSvDj0RoXSKBnwYAdwC99nkDL5BBJJPYvLTVQ2SdNW8J6oIdyHyfB7H7aGDchUe0+ELf5Xa/smAewqwSLstMx2V//c07I4Ws5qjMu0aHxCQVcu36hQhxBe1tBVmHq4eEnECna5Ayae55ZPqcmdXw0IYRoqGzuU0a+OfkvzBfdHM+FJiLDrMtaY8cwjGTff4ethDpdv1EQGHpUvU6cgYz3tcYDDP8Lj+GS/BpgO4K94gLMeAlnSzZ5AC11IAY0jUR2tqgfwTo6SSWYIFPJ907DaFUhd6VrgGAmVoc5jieKyR7JgtOiuw732ulzMvzY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKil9DlUp3z2G5pzrb3BG6+pD1Lx9CxBmODAFCT0Cyk=;
 b=1LCIRndA8Etbsclmr0yQSrzYpwLdHN6viAm1FbNMiYqLXeIpbUrWctuf0/Rj2dgNNTzmyrGtkG26TbDlnpFiOSLNa48jlZPLSEcmPPoJoLDeR7O8zBXhykmjvBSFzzxXRcnrt0CcdR1KFFkyFGM2cq5ML962/nt1lTdUR4hqNB4YqfbNcqfWa/VOA/GhYNNey2YG54og+YgHLqcSPD+2XDBt4ZXezwPg9GTpYdkIacxttEIxCxhkOxluFg7RBKro/eaKuKyeZgsS6nHKFoSQyKNxfN76dtV3e36go4gE+qxOzjOUqM74AEnv7EgsslE7ihfO/x1GWVwZINjxpzvBiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by GV1PR04MB9102.eurprd04.prod.outlook.com (2603:10a6:150:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Tue, 6 Sep
 2022 10:53:47 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::c98c:ae67:148d:bdbb%4]) with mapi id 15.20.5588.012; Tue, 6 Sep 2022
 10:53:46 +0000
Message-ID: <edd6e329-7575-ffcb-7e93-0ae881dc71fa@suse.com>
Date:   Tue, 6 Sep 2022 12:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v10 0/6] Raspberry Pi Sense HAT driver
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Joel Slebodnick <jslebodn@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <Yxaul73DR7BVT7/C@debian.me>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <Yxaul73DR7BVT7/C@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3331458-bf80-4ddd-ac45-08da8ff612db
X-MS-TrafficTypeDiagnostic: GV1PR04MB9102:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: refSTkcs/eZFwr7RLRO4GnTv679uDo+JQgkeD9fA28hEmTkqJdvEVfaED15QdQnEzwLxie2R2PMfr4kbPRE+B8rVnBEM5HujnoXDrj3wMosoeM5f+5hXiN0ykIanXxm68r16FhnxhF9IGZaBKczyj7qCHBY5R0zAhXT3MK+b9AErrUVhK64QfFFqz7j1EUH6n46RFLQFzZI4K5TOy65OJMOq+f1UqZH8waTszkCUJdCBdyzkbCZoWuOGwN7ARrivY4EdOcTGOQU/D75i+W93gCcaaZmg3MDRvCtc3AxGUVVjWb+uakfQR1j0wcb/UGucCr/ZJshuEwx3gImevl5eF54tX50HKkBbM1VahpORMBsdcnOhvvnbAfg4mJpwnLLe6LQ2OKo2esOGIsmuE0NOpWQI/3Zq/CtiaKXRD/L26Ysp/kFYoh2V/DytYHV75OlYXO82wDUrQrzyQzXWVsgGUqc6x88wyhrkKMPtv4EScMFvOJCT6OoEkTmZeK8AcH5Ock9eGwkkjLMfs86CC6HGGrhit7QunTKqEC19iBDYavaOoqJqOhYGpn6zjbTLZX7uYQj3WcGv7BpG0EsI/Mxedwbp8MWsh4TwBVgxhZg9xSWSYXq6k3ClNSh8ai3yZXktvzK/GAkg7A/l5MjGdFzfFosbib0y/pwCYEcVmclxZ0ScxtxIl43Ro9S6gwD4YnhNv+HwCUnUURHXaGZ3waHSqmCqNl771s7mA+2cL3pjqpuBBxgCNrouJBJOv05+hpBiIRx7cSmy1Wr8r3rMuY5/O4scCKhkFcAJm4oYNimpL/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(366004)(346002)(376002)(66556008)(66476007)(38100700002)(66946007)(86362001)(53546011)(6512007)(6506007)(26005)(478600001)(6486002)(110136005)(316002)(54906003)(41300700001)(31696002)(2906002)(31686004)(8936002)(186003)(36756003)(5660300002)(2616005)(7416002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1ZqYzUya2YxQXZxb1hVYXZGdGk2emc5RjY1UlJlbm9mUXZ0bkNyTXJjeWZi?=
 =?utf-8?B?OW90Ulp1QmJaYzNyZ0dPOWYyZnN3OHB0UlArL0lTa3NScjFVU2MwZkZ2VXUr?=
 =?utf-8?B?Qzl3RWJLZFFFb2doWDc3aHpyMVN2OFY3Z3JOMElPYkE4YXJvNmxnOGxYM21P?=
 =?utf-8?B?UDJEUmVRaFV0QVYveXR5NU5tU2pDTjRDUFZLbHJBY3g2ck9GN2szTC9MSTQ5?=
 =?utf-8?B?Y0J3cjFIYWU2UkJLeGI3RXJ5WHJGWTRSTSsxUkwrZHlzUFFyZ2h1ekRQWTd4?=
 =?utf-8?B?K1dPb2xDelVwWmI0WHdvRzBsdnZnSEpPU2JxNWhwaVhkR01aUGFUNWdPUW1L?=
 =?utf-8?B?bnFYODV4d09kM2swRlJyaU53d0ttbEViZ2g4dEFBVXdhbHlJeStvRFNVUHoz?=
 =?utf-8?B?UVcyTjJhb0FhV0NyczlvTEMwRGh3VXpCaWFvOTRDQUNEZVZicU45dC93WXNq?=
 =?utf-8?B?TG9NTXlORUd6b2drVmExMWJRRmoyTEJidHpZbW1CUGJyVFlkeVpHdm0wdzdJ?=
 =?utf-8?B?dk80OFBZK24vdDl3ZVI3dXZpWDhBdkI1aU94WkQvd3dwbkRyUmpFTnY1WHNO?=
 =?utf-8?B?TGxtNTE5bnZmdWFmZGhTR21YWHBMRTNmbE1iQTJIazBxVkxVdkVmNk5QS2xr?=
 =?utf-8?B?b3h6bnBCTDdGZzQ2eUR2cTZqQ0xRWEUwZVBuOHRCc3dyRG05UXZ1VEFIMHpw?=
 =?utf-8?B?NVpYVnVBNlU1QXhyZkIybDJycTRGa25QWHJJM2dYbXVpU2ZqYXRIUHNtUklq?=
 =?utf-8?B?MXZBTFJ0YkVmWlFYUi8rNGE0bmwxY0NXOGRrcjBxV3B1MWZwbEFjamJzSnJi?=
 =?utf-8?B?UXAzM3Y4cUN5UFZTVUROL2N4anVMV2k1US9QZ3lWOUZFQlRYcXZoM2JLWkJH?=
 =?utf-8?B?Sy95T0xGRm81L1F3R2hBTkN3d3krbHEweUowQkllc3ZDcGQ0THRQd2pLK1FB?=
 =?utf-8?B?NWtYNTdmR293aXlDbWtOYkFSbXdyNGlnTjc5WXJlZjJ4SmEyazRzMGlRN1d2?=
 =?utf-8?B?aW5WQWc1UWdoKzYzYWsrQXZRQ2pDalU3QkhvcUhlckdCcjZlWDg3ZmJLWk44?=
 =?utf-8?B?NHNKNWdFVkVRc1NacGRsZk5ISmdleG1UdE05MW12UWNKTVlGbzhiRHBqaHFC?=
 =?utf-8?B?QjkycnVob2FLZ0NNaHEzNURMNVkzOU5yM3UvTnZuNmg1L2xvdzkzUUJHY2p6?=
 =?utf-8?B?K1czU25Wckg0SW1QTHhzbVNwSG94VngyNnlDekF6WWJxWmxtS2hkNWMrcEZz?=
 =?utf-8?B?Sk55MzJKYTZJVUpEcUlRMDgrZll4S2gzRFordEcvckpBVzEzNUs5OFJWekpl?=
 =?utf-8?B?NnJJOUFGZXgwZmZ3U3NieXMweHpQeENHaEJJcGp1SHkvYmJhdVpyc3VLQUln?=
 =?utf-8?B?WEhkVXRNekNQTGtFclFUOGYrbHk5TEJqeDZZM3BJdjBuQ2xwY09jSUIrQjdU?=
 =?utf-8?B?TlZqWGxsUm9Kc1VGenVydmVHYUErdmxXNHhZQXdBYWdtNFo0V251N2YxSFFu?=
 =?utf-8?B?MGRNL2cxUWtVeTdTQjlnMTJBRFUxcC90YnljQ3ovelJkNzl6cXl2UHRnaVNJ?=
 =?utf-8?B?NDE2Q3pnZCs3d01wbVRadGpDTFJJdEZJT0VCWjRNQjRJaVN1d2JFWlBveTgw?=
 =?utf-8?B?TGtEZ2tFMEIvbGJwL1VGd1lEZm05eDJFWGJudk03OTZiM09jQUN6bFVISW1F?=
 =?utf-8?B?Wk1UTURnYXVXWGlPQTdTUnJZak1jTWNJR1FqMGJxWE1tTWFnaXJqcmE3MStI?=
 =?utf-8?B?VG82RmZYTjhQVHFHalJadkpQYjFHMEp3aDc3WDNjN094KzFTazZQTGxNSkc3?=
 =?utf-8?B?dUp6cUg0RnFQc01mVVdxeitLZk41STlRei9HZElmN0YvSDFYUmFnTjN2dVNk?=
 =?utf-8?B?V2xtOEhiRkhTRzZyOUttNFdWWWJ5RHdvTVZYRzJMYUZaRTdZNEpoRGpxT2Zy?=
 =?utf-8?B?b2FvejRWWW1pTDY4dXNLVWxmQTErUzE0TXpGUm8vQmpCWGlUTmpRSzJiTEwx?=
 =?utf-8?B?K3ZLNFllNlcvQzhRM3BjeTVJWjVSTVdUcTRNNW05N0JRWkhCZ1NCUlA5cGxz?=
 =?utf-8?B?M0dKVzZZN0Y1YjRzRWtUTFJocGFhbmdRREtraUJkZlcwSmV3ejNhZTdXQzY0?=
 =?utf-8?Q?B4GAZpG2iqqAhwQH0634J4rM5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3331458-bf80-4ddd-ac45-08da8ff612db
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 10:53:46.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwrg0gNo+JvYYUrPd8pdfDY3R4KsYD5LyjywuMcKGPfBSetk4jsgyNpG73aOihOy8FgUzX0j834vM9N0YRaSCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9102
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2022 04:21, Bagas Sanjaya wrote:
> On Tue, Aug 23, 2022 at 01:41:53PM -0400, Charles Mirabile wrote:
>> This patch series adds a set of drivers for operating the Sense HAT
>> peripheral device. This board is an add on for the Raspberry Pi that is
>> designed to connect using the GPIO connector and communicate via I2C.
>>
> 
> Better say "Add a set of drivers for Sense HAT peripheral add-on device
> for Raspberry Pi. The device is connected using GPIO connector and
> communicate via I2C".
> 

The cover letter won't be part of the git log, so as long as it's understandable 
it's OK. It makes no sense to review the wording...

Regards,
Matthias

>> This is a refactor of the work of Serge Schneider, the author of a
>> version of this driver that is currently in the Raspberry Pi downstream
>> kernel. We modified his code to make it suitable for upstream Linux.
>>
> 
> s/We modified his code/The driver code is modified/
> 
> Also, I see that description of individual patches is written in
> descriptive mood. However, it is preferable to write in imperative
> instead (see "Describe your changes" in
> Documentation/process/submitting-patches.rst). The specific suggested
> wordings are in reply to each patch.
> 
> Thanks.
> 
