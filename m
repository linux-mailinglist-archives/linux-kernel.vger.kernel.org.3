Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A65D56714E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiGEOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiGEOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:39:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBBE1BB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657031941; x=1688567941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SJMBkTRB1axa0QdELzyBl7k5Of9wVjKQw1IYW+6zixg=;
  b=Fmw14KvIUDZZE+DLrTgV66eW78pvY8y/6CI1Sfkr+gDfVlViB2ZLw5VD
   gK9A3VQOHbnyZDBoLUOR6mQASwTi3iYcukJK5lbzC6pCZ76XqZNZlMSjS
   2RkluO3y4ynqlu82VFB8hUOAikZgK2sTkyXjhXYUuj8poWwhu9TjEx/Qg
   ss04WME1Bh2yHN021uxDo2pY+wkeijIz9Bk39ZSWpoUSP1mxGSm6DSrS3
   iKN9mQT2kaBMSp4PFmZf8qlqY8sr3RpOZxgcRtvyi1F8u/V5BAOgDfIn+
   jRCUayUo9stTJ+aCisQkWKCjnHDA4umeaFj57+GU2XWtFs1JzxxGhdvpA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="282124972"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="282124972"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 07:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="650178149"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2022 07:39:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 07:39:00 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 07:39:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 07:39:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 07:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJSkyKFVFSlHYBHpQtjHJiIFpfLJvG+hNqcaQtoYIIam1TeR/9rs3dZGUcY6fr22CKfD0u+ibYmqSHLyoXjUXdX1PRXv6bldXUnag549pLKTaHh3L9LqNGYoQ9mBGAZZF79IqVVaiYQfytrtTjGF7kB8A6ZDvW0e5seOI6zvJ+vOjYCjRkyYQYOJi1ghkpMsvXt4YleCXqgMwF6gYw4fDPBO+RCIPBHU4Vl1nkLi/tXiHuCWBDw5TB06cyxSGfZzNJ7EqoroSmTWV41uG3N+0XBEPEu850kTl7Jpckf1cfqTTNhIqVL3FZ0aIKdwps54hy/Gsby2HzRq/CdO68UMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hypinr/jAB9hO2K50ge6BLh+uIN70B1efnWmvW2DRhM=;
 b=d5zgInhenF0jXGsvuIDvNaEWBkqCT9vdB0LMkwgcSeyigYs4pboA9O3z1ijCze5w4Mgz2WAuW/E47fj8/HDM21HTy39fSEjdDwRRmH+9taUYHt971fc3XVdVWj1syeM84Rt0dh4l9UjxoSFy+1Kbfy0tNj9O7rJ32NeifxbdpBiP0qR22BbxsPHGyVdRo0EX37QLKDyFMMDjy2BCppSxwZ8lp/1iguazpJpbcvdp/gAdtWlKWJjEN4dldDSbNMWtiiUEI5y2KHlmYiQML+TQdJXgqcnxJmKj8RBWAs9hcJqvx78EFV0svIBl7luNtyZWHURwF5qWrcPGtRqoW8corw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SA2PR11MB4858.namprd11.prod.outlook.com (2603:10b6:806:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 14:38:59 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e%7]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 14:38:59 +0000
Message-ID: <7b3e376e-92e0-a178-a8bc-0e985fc97504@intel.com>
Date:   Tue, 5 Jul 2022 16:38:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/4] bus: hisi_lpc: Use devm_platform_ioremap_resource
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <john.garry@huawei.com>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
 <20220705114312.86164-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220705114312.86164-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::20) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d02f9110-6923-4add-bbee-08da5e9418cc
X-MS-TrafficTypeDiagnostic: SA2PR11MB4858:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOEn8NPfGu54didANezxCDNtpwNWwLlXn9i47NuALBOMpyL9y+2WrnyO8BQvyvQEm6/oAsuyHMyZrA05bqc3lMpnRbPSyJXWxhVD5vrcAG/6eDLmuPqjB6ve8QCQ9M85Ra4itwOfRIjBe4nQB9ePRk1oNiqgI4MH/AId+WTjK0lh8orCUHVt1jUlEDhl6FkxqDD9dCxG6X7YTNnnSdv0aG0hR69EsuJDcz/U4nvRUI/GMG3/gG9FT5Rx3yPgYTZAJnCCeEWR/Jft4d2SEAX4bSg0EoRiG5SitrluNOYVDdF8wWBTnqAUX1pymwFy5mqkfrG9cvr/J0+bOBwmAXOICcn5FxMShZlzoudtBtErn5GHsU1QDcWLtbNdvLxeaV7AV5OfboMrMCD5+nd06nnhh0bgtH5vS8RDfCSnQ85J7lSJocSa/9UpK/gNb/QUHQPW+/dnKAoA8SNcnJRK2NS9hJvxpj69sumVXxS4QiJM2CabIRAIMzkSlcg7PiVwwa7LdOJM1GLo1x60ukKl7hhMBiKUjjfjmOA1x0FzicTe7xqyA4RxMrv3+taaDREYHDR1VY1vXOffRKxEoKygauhUsusnXCEEwRuv/OTf1ZpQgh6AT2YF69X8lMmwRc44r36NFHbgGqjO8mOFTBErYCcgKSbxpmkfNbLhMdv3E+HxJIcLp7fSjtUOShtzEaoPceZ8UGYRHFg32Dg90G4Yw2ONMcSb9GclaOJBxSDr92U2z0euLIGxbHg1u4FF0mfCF3R7rb9v+yOH2R50pO07qMyTbJgocqA5tBS4NgVFyBCIY1OGYpobwSo+TG4ckwFO+t1Mwe2WLCZkVoVxHuC2c+u2QOw18DP5Lal/jsdfU7zjtNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(396003)(39860400002)(366004)(36756003)(26005)(2616005)(6506007)(6512007)(186003)(6486002)(83380400001)(31686004)(478600001)(53546011)(38100700002)(82960400001)(2906002)(8676002)(66476007)(66556008)(66946007)(4326008)(41300700001)(86362001)(8936002)(36916002)(5660300002)(31696002)(6666004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGVKYWUxNFVmLzFxL0taSzhVOXV4VGRlNkpYVzJETUYvMXIzUkRXeEErTnB4?=
 =?utf-8?B?OEIyVTNPM1hFS3h2U25VQzJLaTVRQUxMU0VqQjhaNTdnanF0SUhYWklRWjFz?=
 =?utf-8?B?NzhkbEdzNExoOFdKUTNYakFMMjFDSkpncFZWOG5BUndaT1JyVDZFSDAraHdl?=
 =?utf-8?B?Mk5HdUJmTHNMbXRBQzlZdDJsck9CMnRwYmkrUEtBRnpNTlJQVlNSTGExOWcy?=
 =?utf-8?B?UnNFMmN3dEVSNStvSXNXQ2F2VjFFZTMwRG1JQnhxelBOQU93YkIzMS9XdWJj?=
 =?utf-8?B?UVpoWjVibGduVGpGWXVGNy9nWXJGeDlkYUFsdmg3WUd5RzhtRER1V2pFYXQ1?=
 =?utf-8?B?SVFqSXV2ZnFUNXVta0lDZFpCRmFTMVFkVzAxbEdhSDhLNnpMZUhMdEZUelBN?=
 =?utf-8?B?SFJqSWRNa05OQlBrYmlSUzM2OXhKdThzcHJrdjl6Vko1ejdnVTdZWVdLdjJt?=
 =?utf-8?B?U1dRUmhmZ2MvZ1NNMHV6aTNEYlBVL2l6bkZZZnlpeVduNTUwS1lWSUxRQ3Rj?=
 =?utf-8?B?bmJVb2Z1ZzAva0ozS1o0SUhGUVpJQ2t6bnByVGtoQWI0YjArZCs2MlJGcm5j?=
 =?utf-8?B?cm9TRkFhbmdHWWZkS2Q0aHhhV0R1a2RFaTRKazVBK1pZYkVpVkpNY0FhT1hH?=
 =?utf-8?B?VEtFeFdVMHJoSnR4Qnl0clZsa2RURzN2a3BjOVU2SEpDQXJMdUlIOXpyeGhY?=
 =?utf-8?B?RHBlTHVFNThjTlBJdzBZQlRNaXB1ZmtyS0JOd005NkJabFBTY1JsOVZIM3RS?=
 =?utf-8?B?OXhDaVovZ1VBRC9MZkxpY0NlcTYwZDA3dVpMYmM3MDRrSzYwdzRmcUFMaTFm?=
 =?utf-8?B?NWlMaC9IdzRBTjBtbDRzS3ZyeUY0aG5YREdYbEVmbXRwaElDUktlcFhPWUdI?=
 =?utf-8?B?dGE3a0d1ZVlNc2dNeVNnZFJNVytkSFRJSFNaSXpLNzNSMytLem1LZDFxZC9r?=
 =?utf-8?B?ZUtHN2pPTTFsUGU1ck5GLzlkZ2xoT2xrcDRIMG5Ub3J5Vk5uYndFSkViSnJ5?=
 =?utf-8?B?eUxrV0dKMzJvbUZBTmRtVXFvWS9yMDJqVVFSOVRFRlEzM1p3WUtpODlDbW1M?=
 =?utf-8?B?eVI1M3dLVDRrcEVxOGFhK0F4Z3JBNXJqR1NyU010WXA3S0RpMVpqUEs1akZW?=
 =?utf-8?B?RCtsdzNlWXZ2MU4wVDdZbXlGcDU0KzR1QlU2ZnRNOU02RUEzaThwSXVzNC9t?=
 =?utf-8?B?ZnhURnYwV3ZXa2twWjJ2UC9vWGNJdlIwUnNqdzdtbmFBV1UxUERkZVJrUkdx?=
 =?utf-8?B?ZUhBTmlHd2FyMGMvd2p3VUxmWXBOMit0cVUwM2o5TGw1RHBYMnZGdGxRcXZo?=
 =?utf-8?B?TnBPektmS3YwNWFpRkU3bzlJYVpFNTU1OWV0KzlOWGV3Q1dHby9aUjhOVFZX?=
 =?utf-8?B?TEg2bUpaS28xTi9LWW9YSWFDeG9YMUJtR2Zoa3lIcUhGVWZHTHlPOWZ2bVlF?=
 =?utf-8?B?eDlveXBGblVZeGpGNkZqU2hEV2YrOEdVZ2NXK1RxZW5NUnNidVFSZCtKV1dQ?=
 =?utf-8?B?b05SbzBPM1F1M0VnTWRLdXdQV0NrWEgwT3hCWHJMK3hKRnllQkNRRGZzSmNm?=
 =?utf-8?B?ZXNtdzBuakNDSVZRQ1hBbGRVRGRUbFBsVXRlV3ZVY0d3bVVzdDZhS1o4TjVM?=
 =?utf-8?B?cDZoV29PVzN4RTJBVkZxYlEzaXM2RnpQeDR4aUVNRFE4aVhpOVFCanhkdFYx?=
 =?utf-8?B?VEl0aFprLzByZytGeEFVQmY5aWVTdWpGY2NsWmdOd3I5dktCVU91VUxST0dP?=
 =?utf-8?B?dldsVkh6R2xMb29ySUNJZHljTWo1TkhNTnBIeHVYT3lmRlRDRmRDYkdIaVll?=
 =?utf-8?B?OWJnblhyYlRaUTg3OWRMR2tCeFMrOEtkSyt3UlFYN3FYYWlpZkdGZTVOM1gw?=
 =?utf-8?B?bklMVS9VM2phblloZVNoVnp5QjNHZUQxYkJUVlQ0NG1MaXY2M1g3ZnNLKytE?=
 =?utf-8?B?UkkzR3VMbnBuVHROa3kvMkJEREFvRlYvb3RrSGtxSFBHMDVIc2Q4M1VLZlhD?=
 =?utf-8?B?bnc3Y1JLd08zZkNNU2xKc2EvTG1OdnhyMmRaK3dvOE1zSjFuSE9XUUJXVWpi?=
 =?utf-8?B?L3lwQm5rSU4zWUNPQVdTTytnZHlNQStUSWVqeUw0a3JwbGI4RHBnM2x0WVc2?=
 =?utf-8?B?T0RxLy9uTTllNWpaLzlTekx5Q0gvejJMaGZYT3JGcnkxem5TRmFyQVp2YWdm?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d02f9110-6923-4add-bbee-08da5e9418cc
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 14:38:59.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44Wo+6LlO2NxBkBtmVYHasSoQa9FibyV8dXvCDsVJ2G9Z7Bofbbb+Z1RwOy7thjPygLCxhYiTzNioXCvqXW28ZOyt+gSGODncOYm2ge6XWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4858
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2022 1:43 PM, Andy Shevchenko wrote:
> The struct resource is not used for anything else, so we can simplify
> the code a bit by using the helper function.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   drivers/bus/hisi_lpc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 6d432a07cbba..03d4d96ff794 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -618,7 +618,6 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>   	struct logic_pio_hwaddr *range;
>   	struct hisi_lpc_dev *lpcdev;
>   	resource_size_t io_end;
> -	struct resource *res;
>   	int ret;
>   
>   	lpcdev = devm_kzalloc(dev, sizeof(*lpcdev), GFP_KERNEL);
> @@ -627,8 +626,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>   
>   	spin_lock_init(&lpcdev->cycle_lock);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	lpcdev->membase = devm_ioremap_resource(dev, res);
> +	lpcdev->membase = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(lpcdev->membase))
>   		return PTR_ERR(lpcdev->membase);
>   


