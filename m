Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C025ABC43
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 04:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiICCNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 22:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiICCNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 22:13:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1D0E42D3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 19:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662171213; x=1693707213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KlmlSFDWR+YqCIfA1ubkvUoLcbmukxm6bLYeucwqDxA=;
  b=IJKkRdWNRB/7I6qnLC5oJt6vDxB6qsqmao5y9rqjX3cYWttHaCteo9oO
   SSa4cPGGK96lr2jkM4EfHZe1aAPIfcdrdwjlWOxcGjAZ8tZSBOzGQTfmK
   SmyZvRo8x5ZislRv9BP9Z7LtfIl2D2M2xxe9a8pZ4jwV8TndriJRKCv9h
   /+SFOdN7b+OJVMn9CDQ0w8IP+MLq2SvEocCTPtxTeM5xYwmQRNHjmi76K
   g0TOI3tAOqxVptmQOgx1/M68DpM5iikL9weYGqdyfmP/TYlRyjC//FOIt
   HEbK8zJfrLJLJJBW9MBD/GtiDxwUyy1NMHnifzP1VbiRNQue0ctzwKfWh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="357836543"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="357836543"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 19:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="609162502"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 02 Sep 2022 19:13:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 19:13:32 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 19:13:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 2 Sep 2022 19:13:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 2 Sep 2022 19:13:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxJkSvM/cmRTiYl2CCsZ89M48XkY38Jns//DDDq7WCmd3TZV4c4a+21qLWyWUPSORPUxWBxbGdrF6Kwzjf+vvWpt3FfbqzvIv3vAo0pyRK821W2VZ818bVdVwlADgE50HEoMhpZE2xIl97UrtctmLdZcnMeTJNgLAPL5LsChRyp45e6UPUOZ+/I9CAAlO6nSriUTIac4WcZ9TIoYGxh1LaW+UfLkWAdQJWBICTityCvaxsFmZr9fXkUXXngDmBKfTIyT0h8sIfm8Po3RPYqdNBh3slkcwBOWxAABWYOW6AP8HiVkRx3LZ4dCUvrdi0q/vtFNHARsbC/piHolevh9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlcMYZVbBbXBP4MVrXRyAdGq6k3vTcA+2GB9Y0HxEi0=;
 b=AOZB4A/exA6/eZs0Jj1ZiUHsRH7hImtb9F2V2fSf+9HRB1vbxk71mYLf4Rweia7fUDRIgc4rLMGc2mmekQTX+2tjaTYzcbcRDb3iiUnA+bQ2eEu84QnAc1Rscm229y6nDfwFsh0lkVGNIJ0wiI/lfA7i2zN3v4YMZs1q12Uln808mMVaEvitBUxuLZUO7u2b7OgFzCXVNQJtAxdC7j2NyqfRV2Af2hme/nzl2tcU1AYq2J3/z24nHEgSZN77qXNY6xxtASsbvNLaEaEPtvE0j76rtPQBh9IbIMhb4EqEcSqRu5nRlblRKdBitWtpXO08RGcCGaZvzY2xuD8Vrtg8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Sat, 3 Sep
 2022 02:13:30 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::d9cb:9341:df01:f8a6]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::d9cb:9341:df01:f8a6%4]) with mapi id 15.20.5566.021; Sat, 3 Sep 2022
 02:13:29 +0000
Message-ID: <3d82deb6-357d-0b54-ffd1-dce157674aad@intel.com>
Date:   Sat, 3 Sep 2022 10:13:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [PATCH] mm: Check writable zero page in page table check
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <pasha.tatashin@soleen.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20220902232732.12358-1-rick.p.edgecombe@intel.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <20220902232732.12358-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 809c0c39-020b-45c4-b514-08da8d51e47e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4896:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PXkI7Mo3XSqOLoEhTTSrqr3b4KZBFtsRD0SzaqkNeXciiy945QQXAgiMv2x4WsUDgynhvcRE2Cf8M3rzZAgmO8jvyJYVrZVY6eWDFTzCZSpHgxD4Jkf1YoHLGk+nUlfE4m3nCWaHkYeBZXaNZw9qdek6QHxs/F09Zdsam6l0g0wAlpY6LLyvoUFXWmFHmuTnIhFTpE1qzH05WSmlpVjhCVfCJsaLsz9RG8hDfrLSEm6JcQxGX10o0oOod1AVHeGMQxx6CLqcYtW/0Aua+bj2Ac5TTyiOT4bpsiqkQTa2FvhCTw9nkYVNBmrBSt8hzfGoBfagfSlXttQ38BZlsTUdrB2FXiJMLl5VY6ROIQ8tjjxYfdAolSU74jvz+bK4I/lsRSDhKTKAnPEGGR9r9l+LPN71IirMEUa9fe/l2mealK5J3F18CHEZFUFpibvpOE28zhuW3M/6ZuFplWlm9fBAqGc8vBOWe4J6879SI59c5FNhyhNJgpirkrz0vUdBE/kMi9LQZhuQqsICeng8JXrgrl8n2l7ez+CO6ckGhUC+D+hNm9yZxf5zBWKE2m/6MJ1iOHILtDNnfkSVA5s2eCxV48ysCqtTImQttRwbLpREodLw27i/211sKeNmwxrfLxg+3B7xw9er+g+EYgiD9obF478uHm2U19oKIjamAjhrvnsrRZd7wTcL6umKWzwe/gPpdo8a9c99nzvWPPydajEFCMN5xt8Ndx/UuuD3KCTYjjreh71ew9AI0Ynf/MAi6LplFn3p2wd7nj+xZXWmrDAqHWANiDfkHcm3tZQpCyu4/W+owzQYT4lrvjiRv9b03yu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(136003)(376002)(396003)(186003)(2616005)(86362001)(31696002)(82960400001)(38100700002)(5660300002)(8676002)(4326008)(8936002)(316002)(66946007)(66556008)(66476007)(31686004)(2906002)(6666004)(6512007)(41300700001)(6506007)(26005)(478600001)(53546011)(36756003)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXdUcWZVM3gwQUFUVWduemZFQytQMWxkYTZ1Q0dWZkp6RXRlNU0wWGY5c2Vq?=
 =?utf-8?B?ZENIQUZzdDBwWlFyODZsVXdkd0NSUGwybHMwRit4MWlTVGZ4Q3N5dmFUSlBl?=
 =?utf-8?B?K0JpY1pxVFJYNWEwaW5kcUdSRzBZUlJXeE1ua3daWmgrOFJadWNmSHVKTXI4?=
 =?utf-8?B?aldFTkRmTVM5aXc3alVzV2tyNlRFNHd2OUlQVnRKS281VWxGcWRRcHZMci9o?=
 =?utf-8?B?QS9jMFVIMzNHS0Q5Y1l6V05RamRneTlRYVA3ZjRIMXIyQi9DWldPTGQwZGNw?=
 =?utf-8?B?UkNhTFdraFlTMTRUUkZzUkM3cmRRRmhWT2kyUWFZaFdWLzIrRFNuVlVRdllQ?=
 =?utf-8?B?eFRIaVJZVnA0aGdiNFFCYm1xbUxkTmVZU1k3K0hoSFJCUU0zSTdGd2JJdDhL?=
 =?utf-8?B?YVJHTVMwL0pESXdxdnBFclArY05RNkltNXNoRkYxa3BsQ1VtMzdiZTBocDJM?=
 =?utf-8?B?Z28wNjVYOWhkSWlxZG85aDNRa1M1TzZUcG1PaWFxZkJYN2syRC9EZk9LclJx?=
 =?utf-8?B?MmdTNmxTZERhcEhncHYzbkFQU0RocHpZdkRjQ2RFdXRXSWF3QUJtaHNBZ2RH?=
 =?utf-8?B?em1qbXRPWWhIWGZrYTExU3hlN3dxVTJZRUU5ZnFWazRzVTVsdlZXY0l6ZDZj?=
 =?utf-8?B?T2RNazFMREJQZUs5S1hIVUt1MVFqV3JseXFTVnM4NkZWYTZiVzJWS2l4UHpi?=
 =?utf-8?B?Ni9taEhRZVR4bytmeWkva1Zja3BxVy9GdUFTQ1QvcUxlTnVKWHZtZ2x2WjJJ?=
 =?utf-8?B?R2d6cFYzcSt1dVkxcnBtdkM4NG5TR3FFaTZTUE81bXJ0My9MUEgwSzZoT1Rn?=
 =?utf-8?B?TythRStBWXpxY2p6UmllRjhHOGJOYlJpSmNQblBNcGUzcmVtaWFaNy9ob0Zk?=
 =?utf-8?B?bGU2L2JzWEpYUnR5ZVh0QWY0a1ZWS1VpdlJJWnYwWnN1azVpeWFsWm16blE5?=
 =?utf-8?B?WGwwWmIrcjRJbzIvbHNhWi83UUE2bzd6TmRKM29MVWlnZS9yc3R1Wm9KYXVk?=
 =?utf-8?B?QzZ1NWthdWo3cmdJb2RWandBNEhhcFhIMnh3T2l2bTFNcnUrcEUrYkY3QVMw?=
 =?utf-8?B?amRRamhrZkxhQytQd0ErRGcwSFVuUG0xOWUzNVFiWURJTDRIbEo5OWdYekpG?=
 =?utf-8?B?cStlV2dlc0YxUkU0Z0cyNk5iTHl5LzdobW5ablg4R1VpQTBuNGpqRUhpNFJN?=
 =?utf-8?B?djAzOE5wZ3ZjTHlCcENTQXU3WUJMUmVFeXM2ajBGYmNQQlRySFplYXg2K3VF?=
 =?utf-8?B?YTZ4d0V6dnJGRjdFb04vRWJDb09ibXNod1dKSVlyU0xZWGJoYzl4UUFESkkv?=
 =?utf-8?B?NHY3NGdqc1h5ZEM2TDg4Nk1teFZqV1A2SnM1RzAraWR1c20rR0FibWZocERk?=
 =?utf-8?B?Qm5mZU5MZGNLdHlPWFR1YVd0N1RwOXhpd3FrZGZkVWxiemk0QjMyQ2hESDRF?=
 =?utf-8?B?VmZRdElVR3VoV1gvejBSVmErQjVuYkYzbDcrWnFjdVVteUVaVzFpeVhXRTVE?=
 =?utf-8?B?eWpIZVA5ejdRZS9XQm9maFdKc0lwejBTNXp0c0ZtYWxhRTIwQ01HakMvNjJJ?=
 =?utf-8?B?dHA0UFg1cm5CNFRvaDdKUStUdUM2aUlIZVlBdktOQTlXbEZ0Q2VRaDNKbnF3?=
 =?utf-8?B?MisvUVIxcXFHcnlNNEdibGx4VTJtc1VaWlgvU2VxZFU3WlhpNkx0WU1EWE82?=
 =?utf-8?B?V09mUHBFNlFDRjJ2L1NUaDZ1bkViZFp1UW5zek93S1ZmZGxic0ZJOWtHZ0VQ?=
 =?utf-8?B?T1NSVkk3WW9ic3huK3dkMmFVZWptMDNFbmNQbFY5SXFjZHdyaHJwaVJldTM4?=
 =?utf-8?B?QTZoTDlKVG12WlBjcC8wOWsvbnl5Q1RyZm83eStrWHZRQ2VTSG9Oa2dkeWtx?=
 =?utf-8?B?ZDBxTlRGZGN6L21SWGtVekZwYmV5TkFsOFlwcWZGWUFyeERRZXNBTEYzREtk?=
 =?utf-8?B?YlVaeEFYL3BQM2NRcXFoUy9MY09TeHY1Kzh4MzdiSUdmU29HZzlEVXJYQ1JI?=
 =?utf-8?B?cmwzbVpmc1RuQjZkNFhZM2RkZTdCeVcycHZSbXd2RnNRajlBeE01djRhc1ls?=
 =?utf-8?B?dW1EaElVejhVMTBsaHhzazAzcHhvbGtESXc3UDFXVy82b0tiQVlWWm1Rb29O?=
 =?utf-8?B?S2EvQkN1NkYrOEtBNWNTN0NMV1hsZEZOaml1Mk1kWGdCbzQ4V0RaMlNyT0pP?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 809c0c39-020b-45c4-b514-08da8d51e47e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2022 02:13:29.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gUhb9BO5Q7v5myMIxJut2Hv1HjZnfgXbVhPQfTatwdw6IeqlWuyfGbplKByOKeDUVZPQpw3tMGpUbsG8LDiCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/2022 7:27 AM, Rick Edgecombe wrote:
> The zero page should remain all zero, so that it can be mapped as
> read-only for read faults of memory that should be zeroed. If it is ever
> mapped writable to userspace, it could become non-zero and so other apps
> would unexpectedly get non-zero data. So the zero page should never be
> mapped writable to userspace. Check for this condition in
> page_table_check_set().
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> 
> Hi,
> 
> CONFIG_PAGE_TABLE_CHECK is pretty explicit about what it checks (and
> doesn't mention the zero page), but this condition seems to fit with the
> general category of "pages mapped wrongly to userspace". I added it
> locally to help me debug something. Maybe it's more widely useful.
> 
>   mm/page_table_check.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index e2062748791a..665ece0d55d4 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -102,6 +102,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
>   	if (!pfn_valid(pfn))
>   		return;
>   
> +	BUG_ON(is_zero_pfn(pfn) && rw);
> +

Why we need use BUG_ON() here? Based on [1], we should avoid to use the 
BUG_ON() due to it will panic the machine.

[1]: https://lore.kernel.org/lkml/20220824163100.224449-1-david@redhat.com/

>   	page = pfn_to_page(pfn);
>   	page_ext = lookup_page_ext(page);
>   	anon = PageAnon(page);
> 
> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
