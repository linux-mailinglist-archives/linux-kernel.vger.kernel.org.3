Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4E95952E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiHPGqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiHPGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:46:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AEEA463
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660614386; x=1692150386;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=guAP88duU7/DGQy9Is2jH6jMsrwPdFCg0RV5tpa5VVg=;
  b=iRWn1tRtbpUb9AsQvAKgzxCaRexHNLg77EA0zJv7bEH/bBg2Ed0Jjwua
   s3sl8tTMK6DQd76xBvIfGs0YasIGhuIqTe1aw2cTZwbskCxuYtdF16Z18
   3oGAAWIexyuGYTmp7287Ucl4bdvvxTdVylD3cKO/QqEGuuKWLyRHGskvK
   e5tRFuMONOdktB3kQcxxafAuMbAzI9p9Ps+FDFXWtteW+R4mzMz/DZErQ
   A0x+wWU4HiSp/Kfffbs2LlVXZJo5Aou1WJrsjutRdmIuYySX5WmJLu7SZ
   s/P25eP3WaBC87x/sOedxyq5GChgH8H6gHfLXLUiHqaSHB+P6U1HmYoQ8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356103285"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="356103285"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 18:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="635694032"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2022 18:46:25 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 18:46:25 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 18:46:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 18:46:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 18:46:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbfVdLlRT72Ew385ZhPFPt5mEX12EhogU2KXZZVdylHJstt0TGOyyx/RJ/2oct+DxceNC3bdMcE6GzV3ThcGCR2LOIlF8hIgTooCo32c0CScRFrH/I5K8/S6kNtFPjqTBxr+sxBsWXywE+i6+zgwq+piCZbEG9KrorMY2IjOilf3e+QR3k+G2olWoMWQbgvrTh2+BdxoyF6Ahhn7lMmWTEbXTwgQ2o8s1eIYGNkoiCF550n5i2lmOftz9SRR0J/TTOcaKnQzMPd0h/RAcOq8YstI1+rBjVAgGYEIZ+J66jZ07azuQpn/Mh13gtTaij/ZsUoZjMzjmA3X5cs9vwKJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+nv18sUlBc9Vk0y9cRCKdN1gro3abTmU44SA406ny0=;
 b=TftHfp/7/VYaLUc5JcSrCIXItvjcvfEDQ0mCkEnz7zjWvPLojdTgupC+kmfiIjhNJmYIHNj8bTNAXqiCoMVLzthMfw0CEHJch23jSsA77utnJAzhSGiPZFwNCrGTnKnEMk5WLtLmzc877o2dgbrSxwmtFrQaSYp0vZ1c5zYqo96XrwTkLOwHLe0HcHr0ocKrIYoUTrIpvGJKdJjoZR6lA1tiBStRseJLZiqLHEqcO48JNIx3HjMaHXv63fTXCGr4nokq7B2zh9RkS2PANGdK3Fy95DS7W0F+Rb8gyjSPNnmRGtnhbwYniAiCDTcMcVJFWxHU6/byfafonLRaIAFZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by BYAPR11MB3800.namprd11.prod.outlook.com (2603:10b6:a03:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 16 Aug
 2022 01:46:22 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e%3]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 01:46:22 +0000
Message-ID: <9f6a0b68-6777-dd88-929c-2d4303b28984@intel.com>
Date:   Tue, 16 Aug 2022 09:46:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 8/8] memblock tests: add tests for memblock_trim_memory
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>
References: <cover.1660454730.git.remckee0@gmail.com>
 <ebbd1fd2c2a3d223a744adf24b4293a559a7003a.1660454730.git.remckee0@gmail.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <ebbd1fd2c2a3d223a744adf24b4293a559a7003a.1660454730.git.remckee0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6a96e87-3d8a-4596-c1ee-08da7f291eec
X-MS-TrafficTypeDiagnostic: BYAPR11MB3800:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5d4aZTRn+h7DqjQ4fJ0g/BPdnamgYiGdzQFZDveSME31hrcw46/y1lqkLsWH5voj2X2Yj18EJHbd05oabkakm/grrXJrcetJPs5iiFeAF7br6p1WXPLG5UDGDS3sHn9nbU9E+KtNJMabHPrh85X4y2709KsOxD5GTMXGGFPUGPohWvVAxk0WXoLfd34IqUnkjBWc/d2YGemObCe+34vi0xMS/KGeEh3gaa/tsI1QsRviroLfZcwUppcYKfShQ+qkfu6QWmGJHe3lb0KxPRHPLZZXTsBXm9QKlkJLG/kZuGpweeMTmRWlOgam2pJSHJjTWsWxG8/WhRkTm0Ybw4fhjgWyrZBBJoQ6ewwzy9Knek+UuvauUzMolHOkKJpCZz/SqR9Q0GLq+JV1Fxed1DmlTew/OB5YyragG9EFP15TcTlcBtxCmPaJjRALbk/2agBzxGPyc2mHshEaQzp6H/XgE/0D57SdD/Oj0gPr2TUI6MrFDwC12Q1r8z8UhNWZ1/lMNyuBo4CcAjUIB6LKKod9GaYNl+2hIpssycbgv5RsOejWmU0Du6/zkrL7EwffZ8hKVj8Kn0lb6xem08G04s6HMFHCtNNFq4dcvJjNLROXljU98aOvaRvIgTPbxY6vovcj+mz6jtgNKBXm24Vs83wZDQoKf4SNXGsljqEN0gOoIYqsxAdSRi/t/q7sAiTA78ogsWvFALcbdc5ffjH6v/mMzuMzLqd5fqqvXoRink6GrpTCicZCUwkaZOmJA2XiAJajHCnRr39I4NSaVYZ03V39/S/EhtVDNgoQlnLoA3Wg5a5B9WyR82qz3XhhIDd7bTBemx6EYblrqsKizVg4q5TwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(136003)(366004)(110136005)(38100700002)(316002)(31686004)(478600001)(66476007)(8676002)(4326008)(66556008)(36756003)(66946007)(6486002)(86362001)(8936002)(2616005)(6512007)(6506007)(26005)(31696002)(41300700001)(5660300002)(186003)(83380400001)(2906002)(53546011)(6666004)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJOdzl0WUNVOEY3d2FpSGdSMlVaY2F2RjQvelNLOVFFU2E5NG1IZ0p1eXlM?=
 =?utf-8?B?WUFtT2pSSEN0c1ZJSllybk5mOWh1MDlXVE1ZdlVudm9yTjJJc1lYQXZyMXJG?=
 =?utf-8?B?aUErcWlBU0htM1lGdXNoSmY2aVpaQVBycmw0MkY0a3NScWF6dUpYS0ZwT2Fl?=
 =?utf-8?B?bXhrMkR5SE9hNi9MSFJkSHc3Q0ZNQlRtSmt1WTB0ZHkrY05VYVZZV1FuMFlO?=
 =?utf-8?B?VlE3L29tbHpkTEprMURUeWk5RDFmZUxZQkI5THR4VGNXVGJJR0NtbTJzcElE?=
 =?utf-8?B?TUNveHRReG40dHdFT01rMmNGOWhLMlJMUU9xeVRZQWQ5VGNMWnN5ZzF3c3Rp?=
 =?utf-8?B?Z2ovc1VrMmp2Q0NSTHFtbmdPR0F0SWhlMWpYczdubzBpenRnQWlOT0V1RDEw?=
 =?utf-8?B?M1RESGpnMlFSNUpIMWtrMEorMFdOSzIwbWVPTzRxWm82QkVCZ0ptU1Rjc3hD?=
 =?utf-8?B?bGZCMUMyTkxhNUk3dnNQUy8vTFFCazNFOWZXcHlJczlhNWo5T1lKZnoveVhL?=
 =?utf-8?B?c0VtZXVvRDdKRDRPTlByenUrYzlFUCtqcURxZ1hCVEE4eHBveTJuYVJ2a3U4?=
 =?utf-8?B?c0tSU2VvTnd4UXVsSTdRRSt1cTBRY1hnZXFGVEp1Rm4zaWxTNGxnaStVZ3Bl?=
 =?utf-8?B?anNmTlQ4aE1XdVljZ2JodDNOaENSalVWUElienZjVkliTnBxRjllOE9nYzlC?=
 =?utf-8?B?QzVhRFdmVTBwajhPU0dDQUlnZkZYN0tMQi9nVnpQSnp4UEFpMHY4cE5JWmw1?=
 =?utf-8?B?bHpoV3dEUit2dVViVmNWSkJCVnpZMVN6ck1EOERDQ210Y2dBOXlJNkJQVGly?=
 =?utf-8?B?bXh4MkpwTy9OQUhHM0xSVGYyNzZkR0krQng3Uk9RNDhTRHg5LzRDSGQwQ2t0?=
 =?utf-8?B?eS8reDVTdDFhM2ZPb3R6b2srbDZGQUgrb2hXQndscys0bWRlT1UvcWkyd2F1?=
 =?utf-8?B?MlduMWo3ckV1SWRUZzVBSmRjK0RFd3FxUzJsb1cyU0xXcHVIdllEZ2p0MFVV?=
 =?utf-8?B?aEJ6YUtqdnlNN09rcTIvVUdsM01iVmtBWmFnSHRvdUZyMWZvL2dRWmhGR0NI?=
 =?utf-8?B?Z0dSYzV0L3NuT2V2amRBQS9WbjlyUWRpYnlXbkJBVWc2T1BPU1dmT0F6SFJj?=
 =?utf-8?B?WnlTRlNqSWVlOFNRT1Vmd2FUMWQyRW1tWS8zNW5xeXh2WTdxL3BmeklKb2s1?=
 =?utf-8?B?R3Y5SWxTM0oyb3hHMGJhR3lWTGpLOTJPbmFzR3RrQUJKRS9IZE9FbkttamJi?=
 =?utf-8?B?V0xEUllKZlY4RTZSc0hzSWhSS1RoWllrNVo5WE1DWXo4NExTOFpTbUEvdDNO?=
 =?utf-8?B?L3pRdEtxOHJaWDd1MHVxUUg5VUtmeSs5cFNZOTRVTGtXbXVrMFN3V1dCTDlX?=
 =?utf-8?B?QUw0UmY2Y2NkSU91ZlREeEdodzhYc1IycjNielBxcXJiNllxdGVzUWxMd0VU?=
 =?utf-8?B?Q0cvRWw0SUNYTXJVdEMyN3FNbXp3R0RVak0raEMweE1OemxTTUdVZzhya2Fq?=
 =?utf-8?B?c0hHclcwL3BaWmpEbHNicGlFazM0UkNGTjlBUkVGc3lkVDJWY0E4UnZ5RDR1?=
 =?utf-8?B?UU5DT3BjRnBjcU83SnVMbGg2TGtZSm01SHpMU3IyRTNNYmV5S0lOSFdNcDhh?=
 =?utf-8?B?UUc5SmZwMDRIN2R2MGtqVG9ZYUZXTTRjd2MxYmI1TlUwMVRjU28yd0thMzgx?=
 =?utf-8?B?OHRzUWJ6MlcrY3dVMW9jYWs1aTh5WlFHRFFlWWhxRUw4VERsdlE5VU9EZW1v?=
 =?utf-8?B?MkpSak5WUFNLZTQvdGVSVDlST3JFRXhFYStnZ3Z5Ri9ZVVVpV1lVb2tIdHFv?=
 =?utf-8?B?TUJQM2J4czBGbUh4NW5saVVXVW1XUXJMK2d0WVVSQWk2K28ycytPanM5M3lo?=
 =?utf-8?B?eXk2US90MVdMOVBscnZOY1lSVVo0RjdZY21tNzN2OFJLUUp1LzRoR2QzQmlK?=
 =?utf-8?B?K21nOHV0cnJwSmNFNThFWGRkbENDUW5PdFBwaGlnMldLTXNtNVVPb2xrdi9G?=
 =?utf-8?B?Y3lXY245OXlFcEFnODZnQkpNVGNld1VLREYrRzZYcGNCRjJkMk14TE5LNVh2?=
 =?utf-8?B?WjJSVGo1WVM2Y0FYbC9JM1FxZTNhcytVRndCRDByVFZ2WVI3dVVKdWFoT2ZX?=
 =?utf-8?B?cGtmWlJQTHNhWmZSY0l3VkhVQ25IZlFGQUFFTkRHQ3p0d0NCZGordFJCSmVP?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a96e87-3d8a-4596-c1ee-08da7f291eec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 01:46:22.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRhIgyJF6emmq9XfBofOodmREdfMl5EORTYxJCbO7FpI3FhkscrUPnpx1G2d4Xt4GpbPUfWo7fe/BvAhQjnZoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3800
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



On 8/14/2022 1:54 PM, Rebecca Mckeever wrote:
> Add tests for memblock_trim_memory() for the following scenarios:
> - all regions aligned
> - one region unalign that is smaller than the alignment
> - one region unaligned at the base
> - one region unaligned at the end
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   tools/testing/memblock/tests/basic_api.c | 223 +++++++++++++++++++++++
>   1 file changed, 223 insertions(+)
> 
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index d7f008e7a12a..c8bb44f20846 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -8,6 +8,7 @@
>   #define FUNC_RESERVE					"memblock_reserve"
>   #define FUNC_REMOVE					"memblock_remove"
>   #define FUNC_FREE					"memblock_free"
> +#define FUNC_TRIM					"memblock_trim_memory"
>   
>   static int memblock_initialization_check(void)
>   {
> @@ -1723,6 +1724,227 @@ static int memblock_bottom_up_checks(void)
>   	return 0;
>   }
>   
> +/*
> + * A test that tries to trim memory when both ends of the memory region are
> + * aligned. Expect that the memory will not be trimmed. Expect the counter to
> + * not be updated.
> + */
> +static int memblock_trim_memory_aligned_check(void)
> +{
> +	struct memblock_region *rgn;
> +	phys_addr_t alignment = SMP_CACHE_BYTES;
> +
> +	rgn = &memblock.memory.regions[0];
> +
> +	struct region r = {
> +		.base = alignment,
> +		.size = alignment * 4
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	reset_memblock_regions();
> +	memblock_add(r.base, r.size);
> +	memblock_trim_memory(alignment);
> +
> +	ASSERT_EQ(rgn->base, r.base);
> +	ASSERT_EQ(rgn->size, r.size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +/*
> + * A test that tries to trim memory when there are two available regions, r1 and
> + * r2. Region r1 is aligned on both ends and region r2 is unaligned on one end
> + * and smaller than the alignment:
> + *
> + *                                     alignment
> + *                                     |--------|
> + * |        +-----------------+        +------+   |
> + * |        |        r1       |        |  r2  |   |
> + * +--------+-----------------+--------+------+---+
> + *          ^        ^        ^        ^      ^
> + *          |________|________|________|      |
> + *                            |               Unaligned address
> + *                Aligned addresses
> + *
> + * Expect that r1 will not be trimmed and r2 will be removed. Expect the
> + * counter to be updated.
> + */
> +static int memblock_trim_memory_too_small_check(void)
> +{
> +	struct memblock_region *rgn;
> +	phys_addr_t alignment = SMP_CACHE_BYTES;
> +
> +	rgn = &memblock.memory.regions[0];
> +
> +	struct region r1 = {
> +		.base = alignment,
> +		.size = alignment * 2
> +	};
> +	struct region r2 = {
> +		.base = alignment * 4,
> +		.size = alignment - SZ_2
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	reset_memblock_regions();
> +	memblock_add(r1.base, r1.size);
> +	memblock_add(r2.base, r2.size);
> +	memblock_trim_memory(alignment);
> +
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, r1.size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +/*
> + * A test that tries to trim memory when there are two available regions, r1 and
> + * r2. Region r1 is aligned on both ends and region r2 is unaligned at the base
> + * and aligned at the end:
> + *
> + *                               Unaligned address
> + *                                       |
> + *                                       v
> + * |        +-----------------+          +---------------+   |
> + * |        |        r1       |          |      r2       |   |
> + * +--------+-----------------+----------+---------------+---+
> + *          ^        ^        ^        ^        ^        ^
> + *          |________|________|________|________|________|
> + *                            |
> + *                    Aligned addresses
> + *
> + * Expect that r1 will not be trimmed and r2 will be trimmed at the base.
> + * Expect the counter to not be updated.
> + */
> +static int memblock_trim_memory_unaligned_base_check(void)
> +{
> +	struct memblock_region *rgn1, *rgn2;
> +	phys_addr_t alignment = SMP_CACHE_BYTES;
> +	phys_addr_t offset = SZ_2;
> +	phys_addr_t r2_base, r2_size;
> +
> +	rgn1 = &memblock.memory.regions[0];
> +	rgn2 = &memblock.memory.regions[1];
> +
> +	struct region r1 = {
> +		.base = alignment,
> +		.size = alignment * 2
> +	};
> +	struct region r2 = {
> +		.base = alignment * 4 + offset,
> +		.size = alignment * 2 - offset
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	r2_base = r2.base + (alignment - offset);
> +	r2_size = r2.size - (alignment - offset);

Also the variable name.

> +
> +	reset_memblock_regions();
> +	memblock_add(r1.base, r1.size);
> +	memblock_add(r2.base, r2.size);
> +	memblock_trim_memory(alignment);
> +
> +	ASSERT_EQ(rgn1->base, r1.base);
> +	ASSERT_EQ(rgn1->size, r1.size);
> +
> +	ASSERT_EQ(rgn2->base, r2_base);
> +	ASSERT_EQ(rgn2->size, r2_size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 2);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +/*
> + * A test that tries to trim memory when there are two available regions, r1 and
> + * r2. Region r1 is aligned on both ends and region r2 is aligned at the base
> + * and unaligned at the end:
> + *
> + *                                             Unaligned address
> + *                                                     |
> + *                                                     v
> + * |        +-----------------+        +---------------+   |
> + * |        |        r1       |        |      r2       |   |
> + * +--------+-----------------+--------+---------------+---+
> + *          ^        ^        ^        ^        ^        ^
> + *          |________|________|________|________|________|
> + *                            |
> + *                    Aligned addresses
> + *
> + * Expect that r1 will not be trimmed and r2 will be trimmed at the base.
								^
							at the end.
> + * Expect the counter to not be updated.
> + */
> +static int memblock_trim_memory_unaligned_end_check(void)
> +{
> +	struct memblock_region *rgn1, *rgn2;
> +	phys_addr_t alignment = SMP_CACHE_BYTES;
> +	phys_addr_t offset = SZ_2;
> +	phys_addr_t r2_size;
> +
> +	rgn1 = &memblock.memory.regions[0];
> +	rgn2 = &memblock.memory.regions[1];
> +
> +	struct region r1 = {
> +		.base = alignment,
> +		.size = alignment * 2
> +	};
> +	struct region r2 = {
> +		.base = alignment * 4,
> +		.size = alignment * 2 - offset
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	r2_size = r2.size - (alignment - offset);
> +
> +	reset_memblock_regions();
> +	memblock_add(r1.base, r1.size);
> +	memblock_add(r2.base, r2.size);
> +	memblock_trim_memory(alignment);
> +
> +	ASSERT_EQ(rgn1->base, r1.base);
> +	ASSERT_EQ(rgn1->size, r1.size);
> +
> +	ASSERT_EQ(rgn2->base, r2.base);
> +	ASSERT_EQ(rgn2->size, r2_size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 2);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +static int memblock_trim_memory_checks(void)
> +{
> +	prefix_reset();
> +	prefix_push(FUNC_TRIM);
> +	test_print("Running %s tests...\n", FUNC_TRIM);
> +
> +	memblock_trim_memory_aligned_check();
> +	memblock_trim_memory_too_small_check();
> +	memblock_trim_memory_unaligned_base_check();
> +	memblock_trim_memory_unaligned_end_check();
> +
> +	prefix_pop();
> +
> +	return 0;
> +}
> +
>   int memblock_basic_checks(void)
>   {
>   	memblock_initialization_check();
> @@ -1731,6 +1953,7 @@ int memblock_basic_checks(void)
>   	memblock_remove_checks();
>   	memblock_free_checks();
>   	memblock_bottom_up_checks();
> +	memblock_trim_memory_checks();
>   
>   	return 0;
>   }

Others looks good.
