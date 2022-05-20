Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8852F153
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352068AbiETRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352064AbiETRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:11:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A97818397;
        Fri, 20 May 2022 10:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdO2i9OXZF2zglV80dsNrh/gijdrdbbUy98DA0rI4h3p39nJYr9irIIrBXZacom1HwKyQXi12NOtUoSS/GVmFb63v65H/GI0w1B3sVJqZTdlknFtQi7T5N+gvkLjTp6f78pgzHcGP5NOLKugLYIHYhahZpCC3DUpMBN2Sht9uIG17uvaBThs61dig9imyj8/gn08GD7gTENdyFSYk3TklgxVn3sOCnLgZ2AdNjE4tOEB3mgXbQAijFNdFUQgvxgk7IGOOC90hm9BEsJCz8KH5gkxpNOLqrOy+bCpQ71ZicjysFlSVhhcK+ERvCK5Nw65p+sh2+SIqp/uO7QYfQYJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRf4Q6ap4/NxFvdT8KSKDZOizAdIT3fFMzP2biSGj0A=;
 b=lmya1D3CKPcjbNRujq5of/yXiHqwyXCu2uxkno94syU3E7eXgFWeyNfrZYBCEvNqrtXyzyULEpKIDwej5wgpL5zjIkjaT+Orv5tf1oOqzPyG3kZTxSx40zx6vdaoFTEwegS6SJJ8ORrg3OJuYjo6N79r/X3Q4HnyS9KObC5zKAjXzSz1SF4devOUxLHMPj7ykj5lORSM3+UaXq/XULIzelWLSUpfX8fS1bi6fFjvFPD6+38oXobij5uI/s0iMLHJh68RDKa2g5pM4lhSqn5ZOnkFBMKRImfc3ZFsWv2fu/fIpzJYYH/AO0hclyeDaTjkU/13biNdKHsKdH39LbvvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRf4Q6ap4/NxFvdT8KSKDZOizAdIT3fFMzP2biSGj0A=;
 b=hqwjXRmFzkInGMIg34U6AeadUSSN88m5hr11f86ZR0gEKAo1nQp2yZVhCkp1h/e2Q3+FN4/X7+mi1RfHu2EDFowd1OOiPkxoXdRzypyDVSNOa0zi/JlrzGrBExaDnRlu/ZLo58paHPgRGG5M4Rxwta+sURObcZwnFwfMZuleLqQu/oOO8dnV44tOu4QR/oJX2q+s08Z+13LMOowjCd33ivVPPEYQe4IXwIlB9NMCskalerTLskeo/Fit7xtUMEx33dE/A9xpMHSLc8bA2ilfPh6y+vizgnd29xQis5TdEcyfqxbWuQw1emPoo3QNBjRvguDYjosBTrwkXvrHh4oAFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Fri, 20 May
 2022 17:10:54 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::6c51:327:2e1f:a04c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::6c51:327:2e1f:a04c%7]) with mapi id 15.20.5273.018; Fri, 20 May 2022
 17:10:54 +0000
Message-ID: <d796b54d-7559-f9ff-bb4b-4e75a707db2d@nvidia.com>
Date:   Fri, 20 May 2022 10:10:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Fix kernel doc for struct line
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, thierry.reding@gmail.com
References: <20220520164726.60638-1-andriy.shevchenko@linux.intel.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20220520164726.60638-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:180::19) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e175d1f-08cb-4a36-98b5-08da3a83b2d2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5189:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51899C6E7235EDAA7544C51BAED39@BL1PR12MB5189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgVBG0Awf3YM4+DwXhlP0eswfG1+PMfta7iXmYuwwQcq3cZV1fDUSFLzuCkfPmoympf8T3KASsc3/IZ4l2hGdlxVrcnjKN8l0jm0SZrBwagdjsMfVWPcULo/vgJGrX2hnwDoMA7iUxxn5/8t6g1oS07tWbuxiVYXssX7cPDmvpgXFWM98CyJ6gLWHSCmBhOBFRpxr3JLQqoEiuFL131T/m9P6AqdHOKPeNjquTvC5wjUGI+hmPmRhBFDGlYG2+vvpb7nc+HO0JP9HTND8+ip9NJN3eAKqoOGgRBaXjQzqk+BwJaR2MYkcxHLlsDPJPy5VWcaSLSaFFRz7U3EU6mZ1NZyPqLqbNhCgy6avP8WhCVWV/mtEswEVGiPkqZujkIvJcvz21DZZcce4xQkF12KkZW0KKhLplxLveZMHxf9nRrS0BrdJXvWPmNKUxAboIUrgrrlfBSNZS3HPbdO2fgPqQtOIj0HkOAkVcu36OQrJe7HFytPJaGNane3hzIQ0q7bYNidDMFolnAdrJdUtH7za15OcE7t8b9lmQx5MrsvkopCrwT/USXZqB8n16i++hM26obVjaAG9nWAi4aesV9Uyfp92de3Dx5rTymnnU2W8jKKSYUyV8Fco6vrrE83/QfFKnAqK7dGYCDZdf0qtbVz+bH7pxEVDZSZsv1/oY5hOzyf4n+7kKXEO+ANBh/ypmXj9o55MX3jYcT1I35SxiV+snP+tR8dV0RsesM0wOoeebk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(54906003)(8676002)(4326008)(186003)(508600001)(2906002)(66946007)(66476007)(66556008)(6666004)(83380400001)(36756003)(31696002)(6506007)(316002)(53546011)(26005)(6512007)(2616005)(31686004)(86362001)(5660300002)(8936002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1gvaEZGbGYybWh2MHhLTENyaU0xTXQxblI5aGlkTmJQZGdSVmpleU9nRHNC?=
 =?utf-8?B?QmRnYlF4bTA0Z3NtZUREUW9STnlENkVWdFVDY0Y5NU1KRnl3YUJGWFlpZkRP?=
 =?utf-8?B?aGUwbDE5Nm5EZlllTTJXbXlGRVZLbHAxWEx2cUIrZkRQUmkzdFpKeGsxUnhQ?=
 =?utf-8?B?UlNMeWpOcXlaa3U0ekdJZjZpWTRRL2Z3LzhPRmk1SDBFeWovSEpBeW5HOENG?=
 =?utf-8?B?eHllZXVoZjRibjVadEM0UVBUdUxZdnJFbmJKckFpT1k5UlpDalU2TXJiT0RB?=
 =?utf-8?B?RjJUYlBGdWlPR1NwREJndmNVeXdmM1N3T1BjOE5OT2h3Uy82OVc4bU5mRWlx?=
 =?utf-8?B?MWNhZGc2bUFTdDBSVER0UDczWXdLeWZmTGtKY0ovK01KNjV6MGsxQXZxbnVY?=
 =?utf-8?B?T2FDVmNhSVhmUnJMS2FOcWNxTjhMMWJVakFCdW4yZFBiZllVRVdqbGRPOUZS?=
 =?utf-8?B?ZkV5OElKQXZ3TkVKUVExZ0I1TE14ZVZwSUFPWHF2ak1Eb2FLUzd5Vk5GUnZq?=
 =?utf-8?B?THFrVWdEbkYrVGZ3NytqYXgyUXpwNTgyenk3aUIrdUVrVXFYTkN6bWFzM3p6?=
 =?utf-8?B?bStyOU9XbHBBeGlJbVkrMFNmcWRKUHlQUDVmakFCMU1jR2Z1bjFhTUptM1RX?=
 =?utf-8?B?UnpYdk1YRWJaNTVVWnloaU1GR1E2VFR2aWRpSVE3OWE3bjluVTYwa2I0d1Fz?=
 =?utf-8?B?NnFqZTFGa0l0QmU0d2ZwZTF6M0l1Wk9TSEhkK214SVZ4TmxmSnVsNGc3MkVy?=
 =?utf-8?B?VVJ1NjRDUVJhaG91SW43bU5PSVFSc3dPRTNYQTVrd1Fld2lXS2xXYXlqczhI?=
 =?utf-8?B?Ym9SWjJCZ3NGWHVDRDNEM01mY0dmTHk3MnpiUFF1K01LSGJuZzN1WHk3bVlN?=
 =?utf-8?B?ZUVPaUNSeHIzZ3dxU3pzUnNSdVdFK3E3VG55MFRsUUV3VzVabCtpNEhZd3NM?=
 =?utf-8?B?MTZlY3FiZUt0SzhUKzB2cU9LZ0VEVytya1lNcTQ4KzZjL01rU0MyQk9MRk9N?=
 =?utf-8?B?SlV1bzJQTzVwUm4xelg4TXhBeDNRcHRxMjJLT2MwQ0hjR3QvK2ZYQWRnc3Qz?=
 =?utf-8?B?QTB3ZEIwcHN6eEZyOTg4WlpPVm1kMkQ2NElpMHRRMFI2aUdXejM2RW1GdnM0?=
 =?utf-8?B?b1hUdjhhSnMzcHVVdEpvZXJJTjJ4bHFOQkthR0NGa2hBcVZmOHVvcGxRK2E2?=
 =?utf-8?B?ekdZOWFoSFVHSkF4U2RKUlM1NU5QTW5OWlpzU3AyUElNcUF4RVQ4VCtLeDRy?=
 =?utf-8?B?QVVoR0k4N0dWUGlrYmRIa1hZN3NObVV0eEtkYysrUThPY0VJWlRUcUltV25z?=
 =?utf-8?B?UUNOTlhzazNCNU84bFBhcW4vL3VsRjVONzdmSHVxbE9uTUJwZXJ2dnErdmdF?=
 =?utf-8?B?K1BlQ2dHWThWeUFiRmgzYlROd0ZIcWN1L1JCK2Vnb0JuNjJCOE1md1pNSTFq?=
 =?utf-8?B?dDdzYXYxeUJMQWEvRDQ3K0RBQUJhNzlwSStOVnowSnMra0NKQzNqcUhBTHR6?=
 =?utf-8?B?dy9URjJGV1lxWHp5alJQcFR1Sm9pd0pnK29NZTMrdFpmR2tHOWgwK1U1YUpa?=
 =?utf-8?B?TXQ0dGowNHR1Wk1EUXZoQU93S3RBS1A3ckNQV2dwdzFoTjcrQlpBaGVtc2pB?=
 =?utf-8?B?UzFPT0w0WXcvUlB3eExnL2dXTlA1elZMaGFtMEFJQ3hmMTRCeTUrZU1pd2h6?=
 =?utf-8?B?Snh4Yit1QWVNcUd5WWwzRE50Ukx5ZHIwcVlyenMvb0czenlUNEYyUytkNTNk?=
 =?utf-8?B?eXlCUXFzbkppRGp4aHBPUUNyeE9oUVJvaUQzT1dPTWc2L1ZWL1RzWEJGU1Vi?=
 =?utf-8?B?L2Vab2dSL0IrSENySjVTVElyeHpmSjZCL3ZINExsc0I4N0s3RUY2YnVNdEov?=
 =?utf-8?B?N25LcjV3Sjd1NzFZcktoVnliWXprc21Wemd3Q21WQXV6dWxPa2k4ZUJDbDJs?=
 =?utf-8?B?czRjQVl3ZTYrK3NMZDJZak5iVDRYcHlkdDR3K1c2eUlwdVZPeFFGUWNmNnRh?=
 =?utf-8?B?OStTZmZkbWU5elJKYkZaYmZzZ29pUEFKQ1dYUVhEaFhNYTZGWGRLbFJjd3Jt?=
 =?utf-8?B?UE9ucG9lMGJpemQyVk1ibWxmb2tFaGtjMXFsWmY2Yy91RlM2VGowVVBoT1pk?=
 =?utf-8?B?UmMxRnVkbEtuZXlJWmR5R0hPRXJEVkJSTVVpRjRNMWNtWEluMFBxK0c3NVJt?=
 =?utf-8?B?VHlxTG5pOGljOFBBQ2JMY09wenR5Q3FvbnpmZzZkbGs5c1dNTVVJb2VyRjA5?=
 =?utf-8?B?c29WTmU5V05UNEEvclFiYW5rWEs2RGxpMkVETDhrZ0szZGVnbzBTUi9CWVor?=
 =?utf-8?B?KzB4REhNWnEyTi9YUDN1RmV2c2lZeXdWakZEdmZjeUxRaVdZRjU2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e175d1f-08cb-4a36-98b5-08da3a83b2d2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 17:10:54.3337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KXemgT9QBGucmFhVDDhuI/moSTRWOBQWQggQCLmNJbTB0if1muyU0rKK4NxLbQElWt5MOSUhkAJO9FjihovcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Dipen Patel <dipenp@nvidia.com>

On 5/20/22 9:47 AM, Andy Shevchenko wrote:
> Kernel doc validator is not happy:
>   gpiolib-cdev.c:487: warning: Function parameter or member 'hdesc' not described in 'line'
>   gpiolib-cdev.c:487: warning: Function parameter or member 'raw_level' not described in 'line'
>   gpiolib-cdev.c:487: warning: Function parameter or member 'total_discard_seq' not described in 'line'
>   gpiolib-cdev.c:487: warning: Function parameter or member 'last_seqno' not described in 'line'
>
> Describe above mentioned parameters.
>
> Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index f5aa5f93342a..d0dc68d04059 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -421,6 +421,10 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
>   * @work: the worker that implements software debouncing
>   * @sw_debounced: flag indicating if the software debouncer is active
>   * @level: the current debounced physical level of the line
> + * @hdesc: the Hardware Timestamp Engine (HTE) descriptor
> + * @raw_level: the line level at the time of event
> + * @total_discard_seq: the running counter of the discarded events
> + * @last_seqno: the last sequence number before debounce period expires
>   */
>  struct line {
>  	struct gpio_desc *desc;
