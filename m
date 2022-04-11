Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3314FC6D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350218AbiDKVjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiDKVi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:38:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB532ECE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649713002; x=1681249002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ggl1zZLuLd9+tVyEsWTOUD6Ax5QSW9O5vSia3iBasrQ=;
  b=Ls97suzvB/QBXBmdmkUmAKT/ZjdGnzAFkLXP8Vnktf8Wz8jBkDJHHuV6
   InMcELyVT//ddRusKMtuFY4LvB8fPdYmf8BE8tWt9Ky14tMOVlmFCUpqJ
   E4lluSjSCPiEcrYkwS9YzXo/xpeIxxtQTBavwNMzAoRVBpHYyRJmVFohc
   qsyeDeLUErtw6+Y6dMi9tcXHAMXjhqGs0oVAJvJg0Ht83REJaBcv5U6mW
   yyvVvBnsNSsD8mJyprBQUINlQhZ+Ah3x3h52mAZf9jEpO5URnhhKe666V
   1aMuOWPw18m0jt0KFEhs77tOvA2Kvj2bSVTRyAY1f321gptgn6MwkaEkM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259816583"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="259816583"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 14:36:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="551409429"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 11 Apr 2022 14:36:41 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 14:36:41 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 14:36:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Apr 2022 14:36:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Apr 2022 14:36:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9K23/aTBUVABvC2k3fNP5Ze+z+Ro6VM2MpQIs/3TZwJT995yj3oPw5rJXkeJUbTVmZ0oslkJuPMZg7qHKfJbufjZ6I/GG0S7QvvQZ+gc1RC/GnMjtfZFSBHJGFY6YayouinfKAtwmNzJerxlI7rRMFjfmdMqE81JlG2RTk11s2BLigoF/pu4VZ2BqG171UkSeIMoRrItAWmSORSXvOZsMO8tuOJ8oRS+t7oI6+sgxpSVHpaublImEnW3CEFijXSOl7bO16odAgpc8mLf34wfK7bZRzlL6W3kWVHZAcsx0Pd0SzcJym2WCYuCDSvW8tp8modURVYY61luLsPOvvq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QBvEcJK3lbtycvNHWUKiN+ecnA07mG0iCL4fEir2gc=;
 b=ieNAV/CNbErCMt/4AW8r85h3tkWLLGk3qszA/p/ptxXJPhJZWuZTPJGmfKfmssSx4nxy9yVw0W+KCgB86ruzQCYiLEDxTxoj7uUsC2QSGKjsJ7rwvt3vFi3XVttSbrryNY2ZTEeM+e98mJ3NLimYOGn1VWtfKP6S5I6MXXyDaSKwFjWSUaR38ld+xWuVp/S3ye4mWgkAss3cGnVMz228q2asxsc8IhkX9wPA2Xwrjb8XHpVtCO6FR9G31B2FcauuRdEBddJr2rfuee0YmCFsFWGtyC5epOKehrBXRyOMJ21Jp0O4NuCJ79X63PGyr6Y7nEe7bJSFNKiUcoIUpotwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CY4PR11MB1511.namprd11.prod.outlook.com (2603:10b6:910:b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 21:36:35 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::b561:17d8:3112:913f]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::b561:17d8:3112:913f%7]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 21:36:35 +0000
Message-ID: <da3a6762-f4d4-c79e-166d-374af6c160aa@intel.com>
Date:   Mon, 11 Apr 2022 14:36:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Intel-gfx] [PATCH 09/20] drm/i915/gsc: add slow_fw flag to the
 gsc device definition
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-gfx@lists.freedesktop.org>
References: <20220407125839.1479249-1-alexander.usyskin@intel.com>
 <20220407125839.1479249-10-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220407125839.1479249-10-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::17) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476a604a-9811-4ad8-515b-08da1c035a0f
X-MS-TrafficTypeDiagnostic: CY4PR11MB1511:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB1511DFC66F541767E81C76EBF4EA9@CY4PR11MB1511.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLoLCo2WR1+Ff8jsJysdCYWBAY4LQMGtKcIaFgs8o3uqwbKP69uPMKM08l/qVmWx5RNTroQCERu3Lmu0MEo/Q45/asCwfn18y1TnkrwGnTphHWrMpmliNo6du4tgxXbhLuAImtE1tgF2NAzYJ4IysP9leSwQxNrsKZY8eukYBblHnqOndSruy5zbSWbMlAzhukzC8gJqJWCW434j9rRjpiBZJvmUOKWaLKFOUV+ixnUeGJWIKMxW224NNTPZHwdllSVsUbcj2xxbZ9AlL+rsTR0rnw9h+dHxdDxxOd8NOhCvQ22+DOFQQgDuCHQMcjG94oczyU4OTEMa/cVS/ji3QnIK69qwwq0ZF163AKTTiL875F14JGuqAbH4ZOaq+IdgQeAE69VnVPuMuZepvogmXoVO+1Oxgb6PruwGvZczgyjp3OG5KL62ZP/glqVPoQcsO8E37R9ljLsvV4lNhHu84z1Cqe/r3AqeCTU/VNm/ugaYAjrNabdhUWUAKN19qXPPH6TheMItWKtioN9JFyEij3cckvWqAzbz3FY/OdqKDnRKwVni9SBBiF3hz1Bl0pTlO+BAFEcejopoM4FqTmmjsaeWiz5xz12/4496fYw1Az9Q9f64L45fPSgMAD2oZj1/ZjGIZ/SKoIVIYo9CjI5lkuRQ8O5CfDons944YFgt2rJrJRBZG+JN0No3jNfdYKb0oDNK7HqgTQN/LlW+s+iCItF25RuIMeiHApPwC0JR5YTrXm6WtknTAjyDlMDNXjCz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(6666004)(4326008)(110136005)(8676002)(2906002)(82960400001)(186003)(54906003)(26005)(66476007)(66556008)(66946007)(2616005)(31686004)(86362001)(6512007)(508600001)(6506007)(5660300002)(31696002)(36756003)(38100700002)(8936002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk5VN2hES3ZmTTlkR0ppVnFRVU54K1NXTVJjTG8yQ0JibkRXb1NWb09kWHRF?=
 =?utf-8?B?U0F6WG5BOUpFdkhjcm1lMStNNVNZdysrUGFWVW5jV1ZJUnhHMTB5ZWFYTnUx?=
 =?utf-8?B?eWVnVC9abTR5SGg4YTc3S3BpZWE1S3ZueFEydGpTcEFsYnJlZXM3NXNCMmRZ?=
 =?utf-8?B?TFRyNEcybUJWVURnQWErU3dLQ0xIOUZRenBzZG02dHdBOFROWEZJL2xrRGJL?=
 =?utf-8?B?cjZ4bzRzMnNEWk0zUFBobVBHK2t2Z2lyMkwvKzNVY1ViRlJaQVpxQ2Rtd2Ji?=
 =?utf-8?B?YmVnQmEzMEJBTkFXS0JJeGNKdjZUMjdKZm9vQjVQUGc2QkRuUDJNS3pQSVFO?=
 =?utf-8?B?ZDVTZUdPK1pPcmtLRnlZdFFvUjI4Z29OYm9SOTdyN1Z3dDBHVWdUNDBuMXBY?=
 =?utf-8?B?NVR5dVBBZWVQZy85WkVJaFQzN1cwbHpVcENUQlcvNW1icG9aNmk0RFRjRkVx?=
 =?utf-8?B?U015a1RWSVV4VGhJeEk4djVOUlRpZFp6ZTJ3T3dQSEZ5ZlE2SlMrNnNKMCt4?=
 =?utf-8?B?Q1NFVkFXZktxVFdxNmZ4ckM2NUZPMk1MYlUrNDdadHNDY1hleWdvazFpWUdV?=
 =?utf-8?B?cTNCa1N0QStlbTltd2g3UTFpdEhzTU5nRnlBVTM2L1RyRzU0QW93RjB4K1pp?=
 =?utf-8?B?MHlpVmZCY25kRGlxWTlvcVR5aUJzaFEyTCtreldRdExHRkhrVG1VQUVFTTlJ?=
 =?utf-8?B?MjcySm13U0hRS2NvZXZWQTlBdDFaKytwd1gvUEZFaG1RSlM3cEovK3h3MXl2?=
 =?utf-8?B?eElaNmJpYW5sbXVZd3V2Mkg5cVNYbzA0QzBiQkd6SlBuTnpNQWt3MXZDdTc3?=
 =?utf-8?B?eGVjdVFtRzFsdUdDRmlZNWZZb0tpc2U2Z1BUemFuT2Jab3NrME9SVlcrZk95?=
 =?utf-8?B?dE9OMFhVbEprSVIxUEgzRzlQbW96djE2eTVrMFZCd0dyMFVJc2NHVXlkZ1Nt?=
 =?utf-8?B?bmN2c1VIRG5yWXYvWXNGMldyd2hqVXZBVHZNTTlvTGI3OXRjVDVvS2JIZjc2?=
 =?utf-8?B?MnA4aFd0ODBVQVdWL1NjVGxJTFZDSGI0WFFpTStnejhrbVlucHFFb0lqU1FN?=
 =?utf-8?B?MnZqWStCRkZzbklHZFozUDA3U085SkhlUXFraEprOGp3SGNZVUF5NURVWjMx?=
 =?utf-8?B?VjhqWHdtSHlYaGkxeStZQjY2eFkvY0tkOGtBSzB1dEgzRGcyZ2VVV0tIdkFN?=
 =?utf-8?B?cEZEZjZDUGY3a25JS2tiZnpVZWRGRnV4bDdQNFNkK0RjZ3VZZG56SS9sZHhr?=
 =?utf-8?B?Rkxjekp2M3pBS3hSODNnamhxMkRPZWZHZzZoai9QTUxtTkFjMWJ5OXBlRlFI?=
 =?utf-8?B?QysvSmY2ZEpJOGo2MkdrZ1JjeEg2MENPdy9HS2J5NUcwNUt2bktVT2d5SEs2?=
 =?utf-8?B?Z0pkQVZ4MEdLSDNITnVJY1JZTUU5c045SkorczNmNngvWXdyd1B5clBjbmdM?=
 =?utf-8?B?VDJsaXd4d3NzN1l4UmZ1WHRpYU84UGZESGZ1U0NrK0RiWi9PTktWVmNkczJH?=
 =?utf-8?B?b3FaWDIzTzE1N1NRaFBleThkd1lZYTBUVHBPV3lBRGpEOExkdzZiZ0oweUVH?=
 =?utf-8?B?R2dZaWg1YklvOXBELy9RT3RIemhRdERDOUlLZnNjQmJYL2hGQUVUeGxwaHls?=
 =?utf-8?B?eTd0WHZQS1ZNMU1hS05SRkN4blB0eWxHNXQvTE13TEphdUw2M2k3Rk5QQ2tr?=
 =?utf-8?B?NWw0dENwUWVrdzYyWG5POU4rRk1odCt4Zkt4a1pMZG1DTmw0VDIrSGMwQ201?=
 =?utf-8?B?dmdIZ3FxTU4zdDJwWGxBOUZSaHVmTGJHVWJJb1FJTUpYMFk0Ni8wUzREeTRD?=
 =?utf-8?B?azdOR2JmakdqS2tOLzVXNkRiUlJySmtOOU5JemZOeVBsTjZKYWgzQ1lrUVdT?=
 =?utf-8?B?NU51ZEdxbW1xMnBvdlBTUkFPMXpPMUZpS21DeGFVVDVmbXlQa0t4UEZYNGRs?=
 =?utf-8?B?YlIrQjZxdnRkZityQkJCRmNJODFObmVKYWxrODRRSGFaZDJjQjhsZXpFVW14?=
 =?utf-8?B?V2w1RmdwREpCeHBwTDBxazA5OENZWnkwdmxvZmM1QkNnK2pTaXJQbEJmN1M1?=
 =?utf-8?B?NHF2LzVFSWZyeTc1WWdmK1NRV2FLbU9oVTg4OTNPUmdtdjV2c1dzSHNJaHZx?=
 =?utf-8?B?Q1FjcFladTlYcEc2MkZ2Y0NxcCs3czNudVR1U3JPVERzSW9pZnZzdHRONE9W?=
 =?utf-8?B?VUZtOTNpYVhvV0dpUnN2Qmc2UUl2TkE5Zi9MN3NKdXdLcHlkcW94dE0rSlRQ?=
 =?utf-8?B?UThIODR5eDdYUjFtc2F2RjRnNnhXa3BMSGc3a1JKOTdUSHVQdEd3ZTI4aDdS?=
 =?utf-8?B?QytjNEVjcG5NcnE0NGlrQnYrZ3BZNzZIVVp0Rm14ZzdNZlJhQ2dLd2NyL2dN?=
 =?utf-8?Q?qGU5XvagytjnPrwz1dLDCPssSEjvP2HVFz+Bc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 476a604a-9811-4ad8-515b-08da1c035a0f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 21:36:34.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRI6lEgAK6aHsApRjJjv72YJvtP4SPjqHYfxmCidQfwb3vfvxZLTYO3NDvxfEMB4inQboA+9y7sbNjU33HzJ0rcphsb5MDEVhG16FjWBjhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2022 5:58 AM, Alexander Usyskin wrote:
> Add slow_fw flag to the gsc device definition
> and pass it to mei auxiliary device.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/gpu/drm/i915/gt/intel_gsc.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
> index 280dba4fd32d..175571c6f71d 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gsc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -41,6 +41,7 @@ struct gsc_def {
>   	unsigned long bar;
>   	size_t bar_size;
>   	bool use_polling;
> +	bool slow_fw;
>   };
>   
>   /* gsc resources and definitions (HECI1 and HECI2) */
> @@ -125,6 +126,7 @@ static void gsc_init_one(struct drm_i915_private *i915,
>   	adev->bar.end = adev->bar.start + def->bar_size - 1;
>   	adev->bar.flags = IORESOURCE_MEM;
>   	adev->bar.desc = IORES_DESC_NONE;
> +	adev->slow_fw = def->slow_fw;
>   
>   	aux_dev = &adev->aux_dev;
>   	aux_dev->name = def->name;

