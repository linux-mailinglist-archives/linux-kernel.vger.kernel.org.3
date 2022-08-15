Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A11A592D73
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiHOIvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiHOIvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:51:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2977A13F98
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660553464; x=1692089464;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JYlVxFC8DAiB8p0Tul6dK8A2+B1KQpkIi49ECaOTgNE=;
  b=C7JFcr/BjY1+IAXaFGj5+qTQpHaqD53rIkXm4DTC67D/MQardw5IES+2
   B691qoo0MfPvjPcjjUNtXj2BnUFMyzikS5W2hxM816+2lBvu+EIBn+Mad
   icHIMJ78TUnNEQZARPwnngg3RmBDpu4GLi4jdpoQCFBTDDjQZHFrjofRF
   vDkcR2HNrnVOBe6CSAxXvcln6KBFQZETAQFUr3vIrt9/VlXSYdKiFU/Rg
   GfKyUlYRc39nay9YkOvHk97BdNtmDSTi+BKVftmPKV9tUVVxCJxL5vE+m
   l2jaM8T8Ogo0k44azjh6mLFNXF+ODXG+0DwLlYXEmSJitMu9Q+EY9K32b
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="293191487"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="293191487"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 01:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="639583630"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2022 01:51:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 01:51:02 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 01:51:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 01:51:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 01:51:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2nVyTv3L7ZSx7dXmgOPpiAzrP//44ZZKfLJ55UBVUATQtJUx+Y3Hx28dO7bopyp3D0q54CKJ5xFZ7jGaNMBeM08Jw9cQDJLhvmaRdmRWqaDbRORyz7GPDyMdBFLC/mVoVgJ4Csp3fbSycA+6ergWpsnlCLyzfQYQgLpy3KFff/fhcp3MKBLlzRSblwhDbgorCwGpBgNWGAd8ZchjOw7BZPAv38c2FvlsURPiU/WRRNc7o4bxkq6jdLA8RLGOgt4o1AF+ZvXkpB3TUAP1yNOJEzHpwffihZi4lOSElaLRC4SjiXowLNB8NEaayKkMmKguMbD1tT8qBoKp8zWjZuvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U6dcqajYIdDEQBf1zl9jVvW8GLyri3q6Ga4G/0DR0k=;
 b=hqSnhnU98XnvKnPG4fc/lKJJDpZ72IDtEsTmVybyY8Tc3x+hrmQxHIKcqLiBjy8xUlYPaK944LHTZN3P5mgm+pQ5+lHFspWFzQT60pKWbubVe8LndXkPoOIcYdQ6C1jzBcZuJ7qOE7M9RzkMfMsPjaJe6a42J97IsOVRW6v7CV6pLZNkaA2A/F4uZVwxDr0uUwVRsewJxF3f5QQ9vMfmZlQe8iiYDTaCvbw0z9GEda5M5+cIdK0UPc5z0ELc9609k2KL1CA2IeDCXoLDeuM4UOanevmQeoYVZg1ijbo1wufgA8Lcj0vwxJlfqTZbHBM7j16UICZSoK/YFn6wDLYyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by BL3PR11MB5713.namprd11.prod.outlook.com (2603:10b6:208:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 08:51:01 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e%3]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 08:51:00 +0000
Message-ID: <5dde66a7-2236-a890-aaeb-a45876057bec@intel.com>
Date:   Mon, 15 Aug 2022 16:50:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 1/8] memblock tests: update tests to check if
 memblock_alloc zeroed memory
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>
References: <cover.1660454730.git.remckee0@gmail.com>
 <02d514d86f212c79e52792b8ecd919156d7a9c20.1660454730.git.remckee0@gmail.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <02d514d86f212c79e52792b8ecd919156d7a9c20.1660454730.git.remckee0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b246dc20-47cd-4ed5-de96-08da7e9b46f3
X-MS-TrafficTypeDiagnostic: BL3PR11MB5713:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SglUJizWXx+L1rCv1GPHJbeu4Y3VGkyh6q+iATeV/AklaXwXCocnjhFfNneBex2x8fFo43CfPkf+d62UtWrRb7BYzLY0LkrWL7zRaOG7rxVRbNcmKx6KpajVJzjsv1ad6ZosBt4QmnkBChOBPy0a+iV/UbgglJqdLaWupJkTcySde/fgCljOippAxQJ7FNP30A/TIKcBQNFpa0WvkquUewMRFg06mCnM56V3Vphz3eaSpmUz8HLU88LfwqoXM8650o0lbgjdb+EH47gcx0iMUYnkjv70WtnEVjc4h4bcjFFo+pHUrTQMGg/uzACSXAsrHibYTaq0gZjrY7rXJV1+oWvpVOMPdlK+HqYamM9siaSa5dPK/ZmAIxsiNhdRjaYCPMspitVmlETd3G9AgFNuCn+cuubP/8UtGMQub2AAznFE59LL4T0Ne7u+SAyDpJWDA/Z87xtd059+TjHDYqB0aDtko4jkBlBavyYQqAPfsMEBLp4H874M/u5aadFLedDclxKJ21o0YDJvFqoRU811LKrnaFDLAxDdb3PAwmzduwrARZKFeTAI1k/YaanytXCNFiSrQ4fMAS1CJH3zE1AOaoZ3kav/DDwU66WCFaAgYQTZeR/uNKVlCUdeO9RhhipPfi0uLfI9bDLxrf1zavFhB+AmDN6y7PfYFEppfFcPaDw07ohhGJqEo3FoMeMNGS7Uk7cA1Pp1OT7g1u8jOt7n7z1x/zxBxquMmHJ/lMyZ6+m9Enk0Mv8fCcnwlPl6YiImXDAoW58YT5sDy/9APy+QBX+N6MPgYAI6lHDzo/vPn5t+3Nu46QkZMd7A7fzSEEJh7wegKVihIiPJz3h4bwTMLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(366004)(136003)(39860400002)(83380400001)(82960400001)(38100700002)(5660300002)(4326008)(316002)(66946007)(8676002)(186003)(66476007)(66556008)(31696002)(6512007)(15650500001)(2616005)(26005)(2906002)(41300700001)(31686004)(6486002)(478600001)(36756003)(86362001)(53546011)(110136005)(6666004)(8936002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU1kVnJRQ05qSFNmK1dxOWFyVUVIbUs1YmlYWndnNEdwUlorTUVTQTZJMFRD?=
 =?utf-8?B?Q05WUXVFRUxmNWJwRUExVDJJOWVmM25BRHNyakxVV1lhZTdlT21NNThyalVy?=
 =?utf-8?B?OFRtM3lydjRpeWtWT3hGKzBTeGZWWVJJNVBLZUZIemlOUzB6RFZ6NkFxdm5M?=
 =?utf-8?B?RlRNajFQK0Vxeld5RlBXNWN6dXFHNEJPUWMyQS9oZjdCcHptQmJMV0VJdXlQ?=
 =?utf-8?B?UlZvOVlsZXFhSU9LSi9hamZNRFg3cElEVXllUkdXSm5HWHo1UlE3eENsWi9B?=
 =?utf-8?B?UzRZN0tJbzZEM0hTVmUxTHJoVVIrWnAvRHZnMFpPMkRJRHY1U2VlVkRFbUwr?=
 =?utf-8?B?WkttakZnd01VeEFEMGdpd01lRnBzd3JWUlhnc05rY0Z1bUY4U2FyYWdkVHVi?=
 =?utf-8?B?M0VaNStDVnZXWjQybWJoV2owUStWUlloRUVtNUlGdUVRODJwdXdxaFFPOFRK?=
 =?utf-8?B?QVdJR0NWenU2SittcGU2VzFxcVo3eFJiQmt6RDF3WkdyamtJOC9vSE4wUGVC?=
 =?utf-8?B?RGJzVWNOaTdoL09jT3M5b3pNTXJXMHZqUDhOZ3ZXSzVvbUUxUnNSbHAybTBa?=
 =?utf-8?B?WWtBaXpad2l3MW0wUFVYSWtCZSs1SnVrUm9ySmRLcjRtM3BCMGxuSlkvdXIy?=
 =?utf-8?B?UVFBQkVlZkFscVZqQkpPZ2llbG1jZEZON253QjZCS1RaNldDYVVZN0J1Qytt?=
 =?utf-8?B?VVFtanB1QWlOK21lS3B0YUFLQ05GMXd1Y3RWazNENmQrMWI0ZjlVWVJuK1JS?=
 =?utf-8?B?MVRFRHJrQWp5cFE3aEZ5L1RtL0w4UmMxUG1xaWFIb1JxNEp4eTlOOTRjTGZp?=
 =?utf-8?B?R01zVWpicGg1Szg3Qmt2MEJMZjVNb0NSV3Znc3A0dWozV25hZEdwa2QxQVpO?=
 =?utf-8?B?dlJLK2dUN0lKb1NrQ3VxWUJ5Y3RyV2Y0NlhZWlUzNVF1M3N4ZWs0K29MYWYy?=
 =?utf-8?B?MjlmZTJndUVtVzl2NmVVQkZrbWw0WFB1UFRYWVE2WGlsRjNIT2QrZnIyMVNO?=
 =?utf-8?B?MW5GQUpOSnAvWWJseE1DS2Exbm5BdldqdTdkakdmN3pSSjUyNVpQci9LTjZD?=
 =?utf-8?B?aHJHYmM2b3RaUVBGNTkrWno0cHFQclBLaU0rR3lQaWZYc21WKy81RXhIME1C?=
 =?utf-8?B?aUNzV1FuNnhQVVRXZzczbzFoa2hhN29wcWh5dWYwei9rSy93b2RrS2YvajBi?=
 =?utf-8?B?RDlCM2RscXdmck5CZEhWa21tdnYzRk5TMWlOa1JGdktDRVJRa05nVmRvTHhT?=
 =?utf-8?B?Q0NrU3pvM2tNd0I2YUVwUWNpV0tKWjk1dFRxbE1qcE5QV3pudGJ4YWxVbk05?=
 =?utf-8?B?NG8vSzh4cTZtb3gxcTNRTTVFNFlMd0hwbE9mSmlpcnhXYm9MN1dOcTdIVkZw?=
 =?utf-8?B?aWtib3lPbnBrSFYrc01nRHB2cDZVSVBmbWhBL1FsQ1ZlOHovbm9XcDJ2WUpt?=
 =?utf-8?B?dFN1RHFPTUFjbTdDbFdFNUNydGhzcGhSVDVoYlluTGFVb0V3NHJWUG44TnJh?=
 =?utf-8?B?UG5FU1pFbEdvcHBUaG50a3hiZUZOdzhzTFFRUjNLS0JRZGpaMXVQTEMzY1Fp?=
 =?utf-8?B?K3BlQmlvdVVCU29BWCtZODUwVWNzQlFXWHdUNmc3U2paZm5hbVVXZithays1?=
 =?utf-8?B?dmVVRyt3OGFJRWlleC8xOTN0L0ViRVMzbmw2VTdlL1A3UlhMSkF3UjU1VnFO?=
 =?utf-8?B?d29NYmhFbWlVb0lFWStkMXRYYmVnNEF5eEFWQkRaN3RnYlhtM1c2ZWZ6a3JF?=
 =?utf-8?B?WHh3ZW9yK2NvdGlOZ0pTL3Y2VHZFeGlibFgxTWxmQ2JVdUxLZlpjVktjcktW?=
 =?utf-8?B?eXRlZE1rYk5mTjQ1L0ZlbDh0b2tlRGIrN0s1TkZxNUh1eGg2bmdVbU5ydjBw?=
 =?utf-8?B?SUJBcGE1UHQvNlpQT0ttMGtyc3RaRi9DTjVPYlY5L29UKzRXYjFzVnJRRXM3?=
 =?utf-8?B?dXVqN3JQb2ZmNTdZcWdhcE9RNXlzNU9xYmJBcW95UlhWTjFWQjRiMVlOWURl?=
 =?utf-8?B?RlU4NVE5emFXOG93bUNqMEdHZXRSUUpaSTBTMjBVcTJSbzFqT1VtTE5xOHlu?=
 =?utf-8?B?YnJBS01DTDQzNEY2dExxc1BUSElMTjQxV2UxTE9xUDlMaDNPTThIOTZJMmlI?=
 =?utf-8?B?VzRaSU5WVUk0SDlGNS9YTTRtbDEva0J2MnRXSVA3dndQemowTXBpZXhJL1d4?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b246dc20-47cd-4ed5-de96-08da7e9b46f3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 08:51:00.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cy3/SyHQauiawVn604QKK3Hr26rzVWpbAnsb78GChshfRcZrr8qVD1MUa6SRaL1Xy3txpDxSnEdx8G74D3eJKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5713
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rebecca.

On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> Add an assert in memblock_alloc() tests where allocation is expected to
> occur. The assert checks whether the entire chunk of allocated memory is
> cleared.
> 
> The current memblock_alloc() tests do not check whether the allocated
> memory was zeroed. memblock_alloc() should zero the allocated memory since
> it is a wrapper for memblock_alloc_try_nid().
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   tools/testing/memblock/tests/alloc_api.c | 24 ++++++++++++++++++++++++
>   tools/testing/memblock/tests/common.c    |  7 +++++++
>   tools/testing/memblock/tests/common.h    | 13 +++++++++++++
>   3 files changed, 44 insertions(+)
> 
> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> index a14f38eb8a89..71c89cb9b2a8 100644
> --- a/tools/testing/memblock/tests/alloc_api.c
> +++ b/tools/testing/memblock/tests/alloc_api.c
> @@ -22,6 +22,8 @@ static int alloc_top_down_simple_check(void)
>   	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> +
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, expected_start);
>   
> @@ -80,6 +82,8 @@ static int alloc_top_down_disjoint_check(void)
>   	allocated_ptr = memblock_alloc(r2_size, alignment);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> +
>   	ASSERT_EQ(rgn1->size, r1.size);
>   	ASSERT_EQ(rgn1->base, r1.base);
>   
> @@ -125,6 +129,8 @@ static int alloc_top_down_before_check(void)
>   	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> +
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
>   
> @@ -173,6 +179,8 @@ static int alloc_top_down_after_check(void)
>   	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> +
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, r1.base - r2_size);
>   
> @@ -223,6 +231,8 @@ static int alloc_top_down_second_fit_check(void)
>   	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> +
>   	ASSERT_EQ(rgn->size, r2.size + r3_size);
>   	ASSERT_EQ(rgn->base, r2.base - r3_size);
>   
> @@ -277,6 +287,8 @@ static int alloc_in_between_generic_check(void)
>   	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> +
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
>   
> @@ -418,6 +430,8 @@ static int alloc_limited_space_generic_check(void)
>   	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, available_size);
> +
>   	ASSERT_EQ(rgn->size, MEM_SIZE);
>   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
>   
> @@ -442,6 +456,7 @@ static int alloc_no_memory_generic_check(void)
>   	PREFIX_PUSH();
>   
>   	reset_memblock_regions();
> +	fill_memblock();

Maybe we don't need this line, it has no effect at here. Anyway, Others 
Looks Good to me.

Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>

>   
>   	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
>   
> @@ -472,6 +487,8 @@ static int alloc_bottom_up_simple_check(void)
>   	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, SZ_2);
> +
>   	ASSERT_EQ(rgn->size, SZ_2);
>   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
>   
> @@ -528,6 +545,7 @@ static int alloc_bottom_up_disjoint_check(void)
>   	allocated_ptr = memblock_alloc(r2_size, alignment);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
>   
>   	ASSERT_EQ(rgn1->size, r1.size);
>   	ASSERT_EQ(rgn1->base, r1.base);
> @@ -571,6 +589,8 @@ static int alloc_bottom_up_before_check(void)
>   	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r1_size);
> +
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
>   
> @@ -618,6 +638,8 @@ static int alloc_bottom_up_after_check(void)
>   	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> +
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, r1.base);
>   
> @@ -669,6 +691,8 @@ static int alloc_bottom_up_second_fit_check(void)
>   	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> +
>   	ASSERT_EQ(rgn->size, r2.size + r3_size);
>   	ASSERT_EQ(rgn->base, r2.base);
>   
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index 76a8ad818f3a..0ca26fe12c38 100644
> --- a/tools/testing/memblock/tests/common.c
> +++ b/tools/testing/memblock/tests/common.c
> @@ -60,16 +60,23 @@ void reset_memblock_attributes(void)
>   	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
>   }
>   
> +void fill_memblock(void)
> +{
> +	memset(memory_block.base, 1, MEM_SIZE);
> +}
> +
>   void setup_memblock(void)
>   {
>   	reset_memblock_regions();
>   	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
> +	fill_memblock();
>   }
>   
>   void dummy_physical_memory_init(void)
>   {
>   	memory_block.base = malloc(MEM_SIZE);
>   	assert(memory_block.base);
> +	fill_memblock();
>   }
>   
>   void dummy_physical_memory_cleanup(void)
> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> index d396e5423a8e..7a16a7dc8f2c 100644
> --- a/tools/testing/memblock/tests/common.h
> +++ b/tools/testing/memblock/tests/common.h
> @@ -51,6 +51,18 @@
>   	assert((_expected) < (_seen)); \
>   } while (0)
>   
> +/**
> + * ASSERT_MEM_EQ():
> + * Check that the first @_size bytes of @_seen are all equal to @_expected.
> + * If false, print failed test message (if running with --verbose) and then
> + * assert.
> + */
> +#define ASSERT_MEM_EQ(_seen, _expected, _size) do { \
> +	for (int _i = 0; _i < (_size); _i++) { \
> +		ASSERT_EQ((_seen)[_i], (_expected)); \
> +	} \
> +} while (0)
> +
>   #define PREFIX_PUSH() prefix_push(__func__)
>   
>   /*
> @@ -70,6 +82,7 @@ struct region {
>   
>   void reset_memblock_regions(void);
>   void reset_memblock_attributes(void);
> +void fill_memblock(void);
>   void setup_memblock(void);
>   void dummy_physical_memory_init(void);
>   void dummy_physical_memory_cleanup(void);
