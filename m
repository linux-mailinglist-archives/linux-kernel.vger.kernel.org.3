Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EDA5AD196
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiIEL1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiIEL1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:27:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849DB57249;
        Mon,  5 Sep 2022 04:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adL3aYGQWYWzOQK0cjO5/5NdOLlltd63Wrr7NgQg1rz6f3Jo+snLDWMnQsD5siCX5wdKjYWe2rjQ3N/XBMSW2ppR90hi1rSOzDpXKHdjU3zrQGoiwnTd7r5Cvrw58fcsCRVfBwIPhM1cFcJEnEfmG1w8r8jT0YmIDtDCnNFhp5LpQhhW5wAv5zcfzes7RpNDoHf8d2RbjZxZDIVSI3Z8vlIMHPO3BIYBJ8mQSekfZg0fiYgvsjsIZcm1W/AfhYMOe96T8wJfzIorxIxAuwoN/nWEfm+yAbUu+KYULiTOPOpzoMhUVf0z1vDxPTFfZe9bj8X3ulprrmdB9MYCB8RGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUX11QeDWf+28gN3R8UYfb9DpulSvwIomnsjPbxH5Mw=;
 b=aRwkjGTKjil4MFJI+OqUlA/BEzCfRovsh0myGiauKvh1jX1fH5Emvy1972K3Ldt7o6lh+qUYh17/82sSA8YDNc9TQ4ajSR+DrpeIH2/kEurVYFo6/j2fPRlRoJDJhSlgsuny/6qONztaMq/RZbKr5/x9yTDoQ0JF+fpEurpaksZ3DVX918P8dvviC13TAxPK5PbNhfYGtH9xLKGB00LzhqcFh9AhYO9kNpHHqZYI+F0IhvB01iItkMvD1eLeXZwsoNqmZUVLnM3ZnYnXLrJrOdofWyXBYg/LERwT5OubbOwtul6lu0+viaNGxREsxiA48KDrXQrQPb1Pkr9dt50oqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUX11QeDWf+28gN3R8UYfb9DpulSvwIomnsjPbxH5Mw=;
 b=XvKgMhgTJpN2Ut7pNXs3bd3dneYLZddOBAp7vyDPui5Q5nC9bGvuPdYW6cv1qWbun5r5He9MX118GA2B+lUL+FvBZ6s2a1W/whmcdiS6zJUs2WaV3Pm3pb10NoQgIfRnkUuJxiW2wuwV7rZeP8E4ibCZSII+HgKMQ6QN6+3bKhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 11:26:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 11:26:57 +0000
Message-ID: <47d30adc-00ac-75ad-106b-18010d8083c5@amd.com>
Date:   Mon, 5 Sep 2022 13:26:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] dma-buf: Add callback and enable signaling on debug
Content-Language: en-US
To:     Arvind Yadav <Arvind.Yadav@amd.com>, andrey.grodzovsky@amd.com,
        shashank.sharma@amd.com, amaranath.somalapuram@amd.com,
        Arunpravin.PaneerSelvam@amd.com, sumit.semwal@linaro.org,
        gustavo@padovan.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20220905105653.13670-1-Arvind.Yadav@amd.com>
 <20220905105653.13670-4-Arvind.Yadav@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220905105653.13670-4-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eb8c5c8-5d34-40e7-5c92-08da8f318aa7
X-MS-TrafficTypeDiagnostic: IA0PR12MB7577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEC1iMSu49kH8LX75XOrhsIg+w9LE/9N8EOUxbKSRotQeVqJD/Ucqyw4KCAwNaVR3VswbeKC1B17K7zpyDjlxgZYT0UyQc4560eOdLuW2sW8F0jp3LM6C0zKFshfXkwlqsqAzDlNp6mJiS9psMoOIweey4p8YUrWQts+4M0THFAVqo3zfNgDoOcAWi+WH8snjuRbD7WgXZdwFt/jNixBSwposLFovLpRS7en7vGqUCsi0R4pSHPLulVqFE0fd2rjZFK7IU7LtiAFq1jAUy5LmwBGz+gk/7Uw90XlNxsoZZx7KvRCPwPGfMUyzuxjQUhtOfOL5CVRmhVOruup7kcWHsYZ9yx0OAYspoaxx1leEmxs0f+oOfygIrfKTOHuMQjF9z4vSIucSF5z/3lYmtp+iRrFgte9R0ZtnsNFBmjvjrcq1Vlt2g6QozUt9ZmtgzBVWIfbzTFCOj2t3taUD2vrKD9oLkd78NuAeaXkUedadJIgnRiR2BYx/rsUGHcBVcLNxNNRZ2F4c9Y2BMvTqdIjf2wqRUM3XmaO+OI6tnFbYE5WyC/MFKl+XSoC2KedGNDlOu6RYFMt6HX7/XERbzZBOj3gjwDUmfZu4/Q7VZ9oHglgQoXTv+i/2RwflbuS+YUFZPqQf0UV2XRYR92OcHzYSUSSe9deA/mJXZuNbu0em2DQy19fJI+bfE4FhZv7GVweCA3MVPOQwh/huq+Wn9NXlvHhLUVR4RYuzEsKj0aU2gjANmEHPefshaTyadM46xKvstGPYsNYZCOtShrPS28SRgw+jxd0ZVhRbP3OUpIpZayxbCFQRcPSbo7k8pxF18pP34RaR0mEEnl30fIkoXMMC9a+bmb4y6gKOXEPvIAg+VpEr4DfHptUmEUpUhHNJvpd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(6512007)(26005)(2906002)(38100700002)(6506007)(6666004)(66946007)(66476007)(8676002)(66556008)(8936002)(31686004)(5660300002)(36756003)(6486002)(478600001)(41300700001)(921005)(316002)(31696002)(86362001)(186003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THZETHZrVkpqK1FLTStGU1dYQXd3WWZEcThSakI2cGdZWS9JbnFvbFdtR3B3?=
 =?utf-8?B?dzZBL3pRV3lhZG9NZVFJRTZJVmNzdndoZkRUUEZ2QWZmcm5Zd2xMYW9ZTmdj?=
 =?utf-8?B?SXF3Q0dXLzdZN3JYa0FVYTBsZVR1VDVtUXZnUmlWNjhYNXJydDZPbkwxa0Zk?=
 =?utf-8?B?WE9ISVVTTFJES1RGWkRHQzAvcHJBa0hyK1FLaUlwMFpQME5CRzhXdzJZR2wz?=
 =?utf-8?B?RU5FYjNPT0xFNHRtYUVyeklrbktyRTR6S3pWZHNDMGxrbkNzZWpCTjVGbE81?=
 =?utf-8?B?SWlRRGhiWnBxYS8zNlVXSVNvMkx3MlFrK0p3Y2RIT1BoUkF1YnJIR291R21v?=
 =?utf-8?B?UE5lUFMyV0c1RjlQUks3RTB0Mkl4aEhSUElNZnZpM3c5dGoyZ3JCNm1oZ2RU?=
 =?utf-8?B?SXN1QUIvSE5wbnlTS2NxakVVdGhGdmhLYjBEeUdXRmJLNXNYQ2xvczFndGls?=
 =?utf-8?B?SVN2Q1lUWWoxR1g3UVNNdUxGeGljSFlmNnF0SkpNM0kxdkVCMVlXVEpvWmg0?=
 =?utf-8?B?TmVpVWFJdzBzeG9CWm1Ka1c1OVhpVXJ1MncvL3psMkpzZUdxdGRZL1plb2lN?=
 =?utf-8?B?dDNoaThKZmdPUTBPeStObXA5NjBYZ2dEczlYZDlYb3BBWEZZYmMwSUdTaWVY?=
 =?utf-8?B?YTdESjNLM3EvRDZJd09tRElpa1RkNWxKOEJCOFNIZmpXL1Jtd2hmR2s4WS9n?=
 =?utf-8?B?aXk4VjBvUFk0eFJsQWxFVjlGMk9qU1BnYWZOMnpkMVFzV3lidS9LNUd6VVVP?=
 =?utf-8?B?VUZ3WXdvWXpYRGNmNkczRURIWGJrWEVuakFkcmtHQWw0cHp2QUlJSU54bzJ6?=
 =?utf-8?B?VHRMdCt5QmpaZ1R2TGxleWRPSGNTMHJ1OE04SE9rV1BQdVBWY0tKK1A5eWZR?=
 =?utf-8?B?TlFzRVNhT3ZhVHhDdDVNcS9iR0xxS24xZ2FDd05INWliY0hlUFNqWjhOa0xj?=
 =?utf-8?B?K1FQTUt6bks1clIyWENWQTAwa0g2aXNPRXdPZ3ZIcDB4d202OXZpc3FBcHhE?=
 =?utf-8?B?VEpXWTd4QmlRQWNxNDBNV3ljdmtsL1NpWEU4eTRBOGhjcEI1NDdtTlI2bWFq?=
 =?utf-8?B?YlhsK3FsMUxyVDU2S0RqQ2hrTEg3V2NsWEZTc0tzZVRtcEhOalJvemVDOUlJ?=
 =?utf-8?B?NDFlbDUyeU1PNFpPZDJ6cFBtRmxXVXo2Vlp4ZFlWVlhucFB4VTVhb3RreVpD?=
 =?utf-8?B?KzQ3VXlTZmlmZmRxbkR5VE56bFVDb29oakN4RlREZzRndVZqVE9tOW1HWEZK?=
 =?utf-8?B?SkpiZWMrQXJWSEpjUnlRcUFJQlVZQkpITCs1SDFKRjcyY05wOFJRU0dGeXlR?=
 =?utf-8?B?bUJuaDc5b05uMWNNUG94eFdMREd2RFE3U1RQcG5MSFRnUVo0K0Q3NE4yOUIz?=
 =?utf-8?B?Q0huTkhjTXdJWFpkc2FGeTVXazR0OUlWYXVzWHRNYU5kMG5YYkVDdDNNbEh2?=
 =?utf-8?B?WSsvcit4Sm05VUY2a2xEcnpRaGZ6QzlneHhzVVByZVRmSDczUlVqV3RWakRr?=
 =?utf-8?B?NWN4WXV5NTRQNTZMWitsbUZGN2ZidDYxcHU1NWMvTjRKL0psdW5NNy9TUjZy?=
 =?utf-8?B?c3BxdDFDS0U2cCtUM3NyZGJtOCtGRnZaWTQvWXVwM1hDSkcrYlZtSzBjY0dP?=
 =?utf-8?B?M0ZxWlpBVDZiNnBiNEczV1ZmeUQ1UkhKaEE0cGIyZERLOTR2SzF4NDJjVncv?=
 =?utf-8?B?VmRuM1l5ZHpSY05pMER0WWJCQ1R5QUNWcmtBSUVZbmZkNUZSbnA0UXVod2xJ?=
 =?utf-8?B?TUpwSHl6cm9sTjNvdlRNaTVqY3JhOWZBMXVMeWZ5djE1cWNCQW5hT1dvOVZj?=
 =?utf-8?B?b3BQUEhsdWxwU1Z1Y2FqajF5Yzd3bm8xMWlQcHU5OG9lOXBWNUpmVGRiY1dp?=
 =?utf-8?B?ajRseDB1NlR2OU1wbjhnUzhsbTJQK09qTkI5aFFKWVhBUDE4L1hGVHVUSTlY?=
 =?utf-8?B?YmdwNks3RDVuUi9TckJDLysvL2JYL29OOVJVbjA1VDVkTkRBWWRwOGZBNlhu?=
 =?utf-8?B?MTh6OExLN0lIWnlNeTFlOFNuOVVqT1hkRmc2LzFCbDd1czdSdnRjR1BXWncr?=
 =?utf-8?B?c2RvVkxSVTVwd20xZ2VpMi8xdTgwS1J4Z2g3a016NDVCQkk2UW9ZNGV6TWE5?=
 =?utf-8?Q?PUAhWReSlB75OX1e4cHycOtiZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb8c5c8-5d34-40e7-5c92-08da8f318aa7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 11:26:57.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XuRUqstimfv0JOCNJEzTgwAVSzrgiVBPtqi9Dsrkz/T6DCP1Cvlk+290cz4nIyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 05.09.22 um 12:56 schrieb Arvind Yadav:
> Here's on debug adding an enable_signaling callback for the stub
> fences and enabling software signaling for the stub fence which
> is always signaled. This fence should enable software signaling
> otherwise the AMD GPU scheduler will cause a GPU reset due to a
> GPU scheduler cleanup activity timeout.
>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>   drivers/dma-buf/dma-fence.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 066400ed8841..0a67af945ef8 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -27,6 +27,10 @@ EXPORT_TRACEPOINT_SYMBOL(dma_fence_signaled);
>   static DEFINE_SPINLOCK(dma_fence_stub_lock);
>   static struct dma_fence dma_fence_stub;
>   
> +#ifdef CONFIG_DEBUG_FS
> +static bool __dma_fence_enable_signaling(struct dma_fence *fence);
> +#endif
> +
>   /*
>    * fence context counter: each execution context should have its own
>    * fence context, this allows checking if fences belong to the same
> @@ -116,9 +120,19 @@ static const char *dma_fence_stub_get_name(struct dma_fence *fence)
>           return "stub";
>   }
>   
> +#ifdef CONFIG_DEBUG_FS
> +static bool dma_fence_stub_enable_signaling(struct dma_fence *f)
> +{
> +	return true;
> +}
> +#endif

Again, adding the callback is unnecessary.

> +
>   static const struct dma_fence_ops dma_fence_stub_ops = {
>   	.get_driver_name = dma_fence_stub_get_name,
>   	.get_timeline_name = dma_fence_stub_get_name,
> +#ifdef CONFIG_DEBUG_FS
> +	.enable_signaling =  dma_fence_stub_enable_signaling,
> +#endif
>   };
>   
>   /**
> @@ -136,6 +150,9 @@ struct dma_fence *dma_fence_get_stub(void)
>   			       &dma_fence_stub_ops,
>   			       &dma_fence_stub_lock,
>   			       0, 0);
> +#ifdef CONFIG_DEBUG_FS
> +		__dma_fence_enable_signaling(&dma_fence_stub);
> +#endif
>   		dma_fence_signal_locked(&dma_fence_stub);
>   	}
>   	spin_unlock(&dma_fence_stub_lock);

