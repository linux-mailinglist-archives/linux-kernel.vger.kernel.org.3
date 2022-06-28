Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8485D55C674
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbiF1BqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiF1BqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:46:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BCE18E29
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656380774; x=1687916774;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PvIG1sbqFQGv6VN/IzwTP9H3IFl+qA1IFw8zTrnuwNU=;
  b=V9AtNi+7f8XrU0pNRDW4dgJp7ov3HqNllEdFGWlEH2uttshOJIlO++t0
   36fZXSJdmn7+7GHd/Ll2OepVXzpuRl3qQ7cPdToggunp2Uuq5ER+Hwiuw
   3H9oq97xa5qyj35oVWa2S5iDCjHAc7Ffz6iYjOwTIwK2CZSOEa4wpSOMO
   vHWFsGCm9jY7cud5l2rVmmQ/o31raqZpSrh0n/CpTODMk+Ef0/BBt7lF5
   cmlJ7hXrd2BWa3TDOkDH2qjUJEI7KPdzkmCwTtXeTPlAEVIkYhlQyGYWT
   ekkho6GR+O90U88ug11OgPYlDAJnU0wkpcdA5+rd/bIza6vOcDvj39uBA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282342896"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282342896"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:46:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="766990655"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 27 Jun 2022 18:46:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 18:46:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 18:46:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 18:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klUgnZO9OGN7ejM0NSA46R3uGbIA2XcK7qdqAt014B0gsU8xIMN4l5CEP1r+2d4n0eWi0UkKiUjekpm7QDE6qPXSAOZI6ZFX3QwCuvm4gJt8YiAOwi1NiOmUHLXYXqIT5A8y+eP7AyWgwBrEIsmTKTALao2IU9uukvnRxTJhdrX79Wz6yybxigG6hJDEb4F+C6s2uvT5Kfs/IfJIJAAyNXpik85J0cnv1sz5FT+5zy+FeJ4zCbj/uS+UHX6qbs65xpw0F2/jPc9qnBCnaFCMe9O3HuTcwuu5milhdQDNK9OpW6m+KtzfAB+ObkrY96ZqGChB7r/v1J6ruB6TadKYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCXvy30SF260+o933LHcG2CsaKUj+gv6erPTdHeYzac=;
 b=hIrG/kzx+w2DrO6qWGd7/NzRF+VwBQU/NexZknI6pqQNZdcayQ/+k47O1sYNsruwUIuxxvP4+Ndfhdf/asWaiY4w/Q0JKEHn58xtbEXLt2YA7RmKJ0iaZmFjWZYUvhr1Pwl3qHSrK9J+H2xBVkjktN4995QAfv0SVNES9PwaHz0L+vP/ZK8WZeOPNTvpUVY1h8EVGrSd8meMEauarNL1zoibgMoJcCdESWPBgz2yjKBfdn3g1tRMRPwRSvWG5orSd3mVlev2LLLU4n733VqVtpnnMhUopwckLqkPVHsNf1iRE+c3mJMtmphibmyfZIWwSOIiGk0Qxk59KS2faysnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by DM5PR11MB1562.namprd11.prod.outlook.com (2603:10b6:4:6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Tue, 28 Jun 2022 01:46:09 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::dd55:c9f5:fbc7:8a74]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::dd55:c9f5:fbc7:8a74%3]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 01:46:09 +0000
Message-ID: <23926693-c89a-10a1-760c-ef0f3aa0f994@intel.com>
Date:   Tue, 28 Jun 2022 09:45:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/4] memblock tests: add verbose output to memblock
 tests
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>
References: <cover.1656368930.git.remckee0@gmail.com>
 <883c28e34527fd4cdc55df97c791ed8b2e79538d.1656368930.git.remckee0@gmail.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <883c28e34527fd4cdc55df97c791ed8b2e79538d.1656368930.git.remckee0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec8b7b5-1942-42f4-7a8d-08da58a7f8f1
X-MS-TrafficTypeDiagnostic: DM5PR11MB1562:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GHOa7O0ksbQeOtCOfVG8kFN3J0S1HQ9W1m2nVCBzOQyan+9lZ+acqHxEJDFw0CQZQSlacljxh8OezuCc5AgY9QSFTDK03KAB63tqIi0/hh8hHbFD3Ki5xhCN1Pb8w/wI78+yMq9SNyDJFsnAt1zD2zRGcYfZQN2K6HgC5o3fY2b4wl0B5B6wuHktWaCa7TIJFLq0kH69X8vqlLiLTnJ9Ra6/APuj4LBOEqlu/xB6t+jq0XGKMyPu0yxgcfbEp/HnzC4SipPxvfozgNlJb75YSl/onVBS+j0gNenaLF5Jj2tqT4aXIm8baG3mofAI0NZzuE349eP0L1Omkto6xpw03vXxrR1qeuWKIft2cTGDRyFtvmDGwYlElWVCargZvdGgdnQRlbjmLP87BHZGbKvo4JKQfSbGPGrQZmJNyBf4KkHAchu6TT+X1vOvDLV9mpWbo9WmQ+1DM+lRew4ReDfn3d1xFZne5fyITbix0vQTzyAq8OF9NtCySM50kV7chOH9Nv/lmKqs389OsM/NfP5oXhTYFYXvbujjoPF25HSZuAJGqBxlW7TKpcexyTe8AKj9pFRYDgZQ2uK2Tb6D8u+U9By5e7cat2qt0fm0hjq8vpb4guhPTwQuWLIIXhkNndBx7AXRCYK68LjRrgWEt8rXboZxdRWWwBwix6qpEuYpY64OpkDGCDmar55ssYvgKFCoee6ygO0v+XXLiC7mU75RrL79oY3xPsh5JhTcqs5IWG7WfX36nLiwY7YEydum5dm9drqQjBNT3bDLMdqd+66t927bnXnDxvZ49kCRisPbbZudUNYMPr8a7do42sxGGM6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(316002)(4326008)(66946007)(31686004)(6666004)(110136005)(82960400001)(83380400001)(5660300002)(66556008)(36756003)(6506007)(86362001)(66476007)(26005)(53546011)(6512007)(30864003)(478600001)(6486002)(2616005)(31696002)(8936002)(186003)(38100700002)(2906002)(8676002)(43740500002)(45980500001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEV0SVNNRUpCYkN4NDlYbTFoQVFPOVdIcGZEZ1NSM0phdVBKRHRoNFFaWVBT?=
 =?utf-8?B?V1lnbTFEVGZpcloxL1NiNUZDQVRWWlhWSW0wZ0p2VFlwbWlIT0o3dEVjS1o5?=
 =?utf-8?B?WERHby96ZjdpSXAzaFQ1NStWTjl0OUdKZXhEUU5zQWtVcnRLT0ZZWjg4THNw?=
 =?utf-8?B?MmhSa2V5V1NHUndKVXp0UUQyckdreUkzeUNFQkZ3SlJCY3VpNHcvQS9VSjRV?=
 =?utf-8?B?cnRDc0U4THVpT2NJUUJCOVVoRTlDUStxVUxiZXE1MWUvdTZPRk51a0lnRU52?=
 =?utf-8?B?YVQ4cWdrZzg1ZWszN3NnMFVoZ2s5aFpLKzRVbU4wa0M4VTdSdysxb1RLc1Fl?=
 =?utf-8?B?akJ1YUtEdGJmOFhGYzBvb255WS9JaDdTM1BjNGFvTHd4MjUwSUMrb1hPUkdx?=
 =?utf-8?B?STVjcmFWMnowQzFDRXliRHpCek1FeURaMTBXQVhGNDVHTDJMSUdrSlhGM3Ew?=
 =?utf-8?B?N080UEdxdllFNXV6Q0laTkYxM3E5OVBoV0QyYkhwaGg3NkxHN2ZUQUtXbUZR?=
 =?utf-8?B?U1Fxc3prMDhyeTNPNlN6VlMzMTBKSWdxY0Y0NTEyejZ5bWQ4Ky9ka0dXZzQ5?=
 =?utf-8?B?N2JnM1I0aUdQWXBNR1FkTFF3T1BsM1ZCZWNCeVJma0VjMWJ1YUpML1JtR0F6?=
 =?utf-8?B?RjlwcDBUSmdLWjFiRE5JWUZTbU9WcTlEajZOSHRvMFEzSE9uQndtYzBGa055?=
 =?utf-8?B?eHdraGtWNFIrLzNISU4vOUIzSEo0SkMzZkF3dmJoZ1g3NVhZYXZFSWlZMHVw?=
 =?utf-8?B?b25zYVBnY0ljWGk0QlpiY2J2VHZDQTVLSDNVSWkzZjI0SXg0eDN3OFNLeDFl?=
 =?utf-8?B?bS9YT2JVV3hyMVo4NVQ2bkVsRU5lL1FyeG96U1plUTdjSy9GbGNzWWJVQzFr?=
 =?utf-8?B?RUdnaFpHMXNpOGh3NzhmbDFnVWdaTmlIYU1YaDZ5SzZDMFlOZncwVHdGRjNq?=
 =?utf-8?B?dytzUTJGT1pXaG5hbytMRzdtYjBoWERnZnVyUkw3U2NUbUxRejBYa0JtTjNP?=
 =?utf-8?B?cUVFbEFMam80UHhQQ2FiYlBrMzUwakVidjVuSzRic2tNM1plQzIyMzRnK1NU?=
 =?utf-8?B?czNLZkwyRHhLZGZQMkpja2ZaWVdOMlNib2JsYWxibDhzRTVBaWpWalBRL3Vx?=
 =?utf-8?B?S21PVUhDTGswU2dBUEZLZ3hLK2txMmJ0emhQdy9OMzVlRzFGVnk5YmEvSjJ2?=
 =?utf-8?B?UW5INThVS051SVM3T2tHY3ZRSjlRNXZXRUtWcW5FT0hVSCtNczFqZGZuL1B2?=
 =?utf-8?B?Ym1FOHFVOHNLVStmY3BqYVRTWUJQQXJTY3BUaEdxMHh2ZnhiQUZ4aWR2eHdr?=
 =?utf-8?B?RVpZdzhDREo5amVvWU5XS29NQmp5cVlYZ1JoT1p5cUM5b2JVZlJkbGlhQ1Z4?=
 =?utf-8?B?NWNlMXhJQ1QvL0tvT2lWNE9iRjdnK0RxZEFlLzlzQ0Zaak9XYnBkWWREb3ND?=
 =?utf-8?B?U3ZiT2dVdUZpWWh2em15QTdQdXFibmlPVGZYQ1dwRndQckpFY21Wd1NnZU1N?=
 =?utf-8?B?RDRYRDVDSjd6d2F4QTA2TiszamlRa1JCOHRzNWxrUWx1WC9WYi9uMGRQTW91?=
 =?utf-8?B?WnY3WGEyUjZ0KzFlYXlvT2s5Z0lpc3M0U0YzZGg4NTNteElDMmNjMnloenht?=
 =?utf-8?B?aGU3a04wZ3BqNFRmUmlQYThtdWRMeEpMQkJWQk9hUTViWlptRE56RVliY0k2?=
 =?utf-8?B?bmpxTEhaVmJWNVcraHlDQit2K0g2MmdCUGdFM3BBaXkxcUFqNThLMDJ4dXBX?=
 =?utf-8?B?VnVCVlhkZUpEWVRibXF5TXdPUjRUbXBlV0NBa054UEJ5bi92YjFBcVV4M2E3?=
 =?utf-8?B?VUVpcDBDRnc1dkU4UlNwWHlFRjgzbzJsYlhIbEJsa1R2b1hlYVhPMldnWnlk?=
 =?utf-8?B?V2tZc3pUOFdRUmpFb2IvZDNIUENCTU9xbEpucW53SkxqaUFOaVRwTkFHSG11?=
 =?utf-8?B?ZnQ4MmVmZlRXRU9LTVhOdmVkdmVlRTZ4RU05U0puYi9IN2JXcHZaQ3BDZFFa?=
 =?utf-8?B?eExqZzIyYm1Uc01zZDZrZkZwTCtBbDhFRUhmVkttQk5tbHlpK3RmcmNISlBI?=
 =?utf-8?B?eE82U2J4SmZvTCtZMDZzNU9UeWlxSVQ3Q2dMRzJxdlh5Zk9xT285aUFFL2ha?=
 =?utf-8?B?a1NYaVRUeW53eDVlRVlJSmhiQVRTTkZRa21NbkpZbHFRb3RBbWV3N29KMU1x?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fec8b7b5-1942-42f4-7a8d-08da58a7f8f1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 01:46:09.2735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMhcAuwRdQUGofEOCuhePBUezMR+ulHSx9pZ9mOJg2/yasrTKKNA0FrlTSDxTlamXS8U6wZ8woz5XR6vxHjbAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1562
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/2022 6:34 AM, Rebecca Mckeever wrote:
> Add and use functions and macros for printing verbose testing output.
> 
> If the Memblock simulator was compiled with VERBOSE=1:
> - prefix_push(): appends the given string to a prefix string that will be
>    printed in test_fail() and test_pass*().
> 
> - prefix_pop(): removes the last prefix from the prefix string.
> 
> - prefix_reset(): clears the prefix string.
> 
> - test_fail(): prints a message after a test fails containing the test
>    number of the failing test and the prefix.
> 
> - test_pass(): prints a message after a test passes containing its test
>    number and the prefix.
> 
> - test_print(): prints the given formatted output string.
> 
> - test_pass_pop(): runs test_pass() followed by prefix_pop().
> 
> - PREFIX_PUSH(): runs prefix_push(__func__).
> 
> If the Memblock simulator was not compiled with VERBOSE=1, these
> functions/macros do nothing.
> 
> Add the assert wrapper macros ASSERT_EQ(), ASSERT_NE(), and ASSERT_LT().
> If the assert condition fails, these macros call test_fail() before
> executing assert().
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>

> ---
>   tools/testing/memblock/tests/alloc_api.c      | 225 +++++++----
>   .../memblock/tests/alloc_helpers_api.c        | 129 ++++---
>   tools/testing/memblock/tests/alloc_nid_api.c  | 351 +++++++++++-------
>   tools/testing/memblock/tests/basic_api.c      | 337 +++++++++++------
>   tools/testing/memblock/tests/common.c         |  58 +++
>   tools/testing/memblock/tests/common.h         |  62 ++++
>   6 files changed, 818 insertions(+), 344 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> index d1aa7e15c18d..a14f38eb8a89 100644
> --- a/tools/testing/memblock/tests/alloc_api.c
> +++ b/tools/testing/memblock/tests/alloc_api.c
> @@ -10,6 +10,8 @@ static int alloc_top_down_simple_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_2;
>   	phys_addr_t expected_start;
>   
> @@ -19,12 +21,14 @@ static int alloc_top_down_simple_check(void)
>   
>   	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == size);
> -	assert(rgn->base == expected_start);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, expected_start);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -55,6 +59,8 @@ static int alloc_top_down_disjoint_check(void)
>   	struct region r1;
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r2_size = SZ_16;
>   	/* Use custom alignment */
>   	phys_addr_t alignment = SMP_CACHE_BYTES * 2;
> @@ -73,15 +79,17 @@ static int alloc_top_down_disjoint_check(void)
>   
>   	allocated_ptr = memblock_alloc(r2_size, alignment);
>   
> -	assert(allocated_ptr);
> -	assert(rgn1->size == r1.size);
> -	assert(rgn1->base == r1.base);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn1->size, r1.size);
> +	ASSERT_EQ(rgn1->base, r1.base);
>   
> -	assert(rgn2->size == r2_size);
> -	assert(rgn2->base == expected_start);
> +	ASSERT_EQ(rgn2->size, r2_size);
> +	ASSERT_EQ(rgn2->base, expected_start);
>   
> -	assert(memblock.reserved.cnt == 2);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -101,6 +109,8 @@ static int alloc_top_down_before_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	/*
>   	 * The first region ends at the aligned address to test region merging
>   	 */
> @@ -114,12 +124,14 @@ static int alloc_top_down_before_check(void)
>   
>   	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == total_size);
> -	assert(rgn->base == memblock_end_of_DRAM() - total_size);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, total_size);
> +	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -141,6 +153,8 @@ static int alloc_top_down_after_check(void)
>   	struct region r1;
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r2_size = SZ_512;
>   	phys_addr_t total_size;
>   
> @@ -158,12 +172,14 @@ static int alloc_top_down_after_check(void)
>   
>   	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == total_size);
> -	assert(rgn->base == r1.base - r2_size);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, total_size);
> +	ASSERT_EQ(rgn->base, r1.base - r2_size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -186,6 +202,8 @@ static int alloc_top_down_second_fit_check(void)
>   	struct region r1, r2;
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r3_size = SZ_1K;
>   	phys_addr_t total_size;
>   
> @@ -204,12 +222,14 @@ static int alloc_top_down_second_fit_check(void)
>   
>   	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == r2.size + r3_size);
> -	assert(rgn->base == r2.base - r3_size);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, r2.size + r3_size);
> +	ASSERT_EQ(rgn->base, r2.base - r3_size);
>   
> -	assert(memblock.reserved.cnt == 2);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -231,6 +251,8 @@ static int alloc_in_between_generic_check(void)
>   	struct region r1, r2;
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t gap_size = SMP_CACHE_BYTES;
>   	phys_addr_t r3_size = SZ_64;
>   	/*
> @@ -254,12 +276,14 @@ static int alloc_in_between_generic_check(void)
>   
>   	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == total_size);
> -	assert(rgn->base == r1.base - r2.size - r3_size);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, total_size);
> +	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -281,6 +305,8 @@ static int alloc_small_gaps_generic_check(void)
>   {
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t region_size = SZ_1K;
>   	phys_addr_t gap_size = SZ_256;
>   	phys_addr_t region_end;
> @@ -296,7 +322,9 @@ static int alloc_small_gaps_generic_check(void)
>   
>   	allocated_ptr = memblock_alloc(region_size, SMP_CACHE_BYTES);
>   
> -	assert(!allocated_ptr);
> +	ASSERT_EQ(allocated_ptr, NULL);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -309,6 +337,8 @@ static int alloc_all_reserved_generic_check(void)
>   {
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	setup_memblock();
>   
>   	/* Simulate full memory */
> @@ -316,7 +346,9 @@ static int alloc_all_reserved_generic_check(void)
>   
>   	allocated_ptr = memblock_alloc(SZ_256, SMP_CACHE_BYTES);
>   
> -	assert(!allocated_ptr);
> +	ASSERT_EQ(allocated_ptr, NULL);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -338,6 +370,8 @@ static int alloc_no_space_generic_check(void)
>   {
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	setup_memblock();
>   
>   	phys_addr_t available_size = SZ_256;
> @@ -348,7 +382,9 @@ static int alloc_no_space_generic_check(void)
>   
>   	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
>   
> -	assert(!allocated_ptr);
> +	ASSERT_EQ(allocated_ptr, NULL);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -369,6 +405,8 @@ static int alloc_limited_space_generic_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t available_size = SZ_256;
>   	phys_addr_t reserved_size = MEM_SIZE - available_size;
>   
> @@ -379,12 +417,14 @@ static int alloc_limited_space_generic_check(void)
>   
>   	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == MEM_SIZE);
> -	assert(rgn->base == memblock_start_of_DRAM());
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, MEM_SIZE);
> +	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, MEM_SIZE);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == MEM_SIZE);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -399,14 +439,18 @@ static int alloc_no_memory_generic_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   
>   	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
>   
> -	assert(!allocated_ptr);
> -	assert(rgn->size == 0);
> -	assert(rgn->base == 0);
> -	assert(memblock.reserved.total_size == 0);
> +	ASSERT_EQ(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, 0);
> +	ASSERT_EQ(rgn->base, 0);
> +	ASSERT_EQ(memblock.reserved.total_size, 0);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -421,16 +465,20 @@ static int alloc_bottom_up_simple_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	setup_memblock();
>   
>   	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == SZ_2);
> -	assert(rgn->base == memblock_start_of_DRAM());
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, SZ_2);
> +	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == SZ_2);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, SZ_2);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -459,6 +507,8 @@ static int alloc_bottom_up_disjoint_check(void)
>   	struct region r1;
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r2_size = SZ_16;
>   	/* Use custom alignment */
>   	phys_addr_t alignment = SMP_CACHE_BYTES * 2;
> @@ -477,16 +527,18 @@ static int alloc_bottom_up_disjoint_check(void)
>   
>   	allocated_ptr = memblock_alloc(r2_size, alignment);
>   
> -	assert(allocated_ptr);
> +	ASSERT_NE(allocated_ptr, NULL);
>   
> -	assert(rgn1->size == r1.size);
> -	assert(rgn1->base == r1.base);
> +	ASSERT_EQ(rgn1->size, r1.size);
> +	ASSERT_EQ(rgn1->base, r1.base);
>   
> -	assert(rgn2->size == r2_size);
> -	assert(rgn2->base == expected_start);
> +	ASSERT_EQ(rgn2->size, r2_size);
> +	ASSERT_EQ(rgn2->base, expected_start);
>   
> -	assert(memblock.reserved.cnt == 2);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -506,6 +558,8 @@ static int alloc_bottom_up_before_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r1_size = SZ_512;
>   	phys_addr_t r2_size = SZ_128;
>   	phys_addr_t total_size = r1_size + r2_size;
> @@ -516,12 +570,14 @@ static int alloc_bottom_up_before_check(void)
>   
>   	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == total_size);
> -	assert(rgn->base == memblock_start_of_DRAM());
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, total_size);
> +	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -542,6 +598,8 @@ static int alloc_bottom_up_after_check(void)
>   	struct region r1;
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r2_size = SZ_512;
>   	phys_addr_t total_size;
>   
> @@ -559,12 +617,14 @@ static int alloc_bottom_up_after_check(void)
>   
>   	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == total_size);
> -	assert(rgn->base == r1.base);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, total_size);
> +	ASSERT_EQ(rgn->base, r1.base);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -588,6 +648,8 @@ static int alloc_bottom_up_second_fit_check(void)
>   	struct region r1, r2;
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r3_size = SZ_1K;
>   	phys_addr_t total_size;
>   
> @@ -606,12 +668,14 @@ static int alloc_bottom_up_second_fit_check(void)
>   
>   	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == r2.size + r3_size);
> -	assert(rgn->base == r2.base);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, r2.size + r3_size);
> +	ASSERT_EQ(rgn->base, r2.base);
>   
> -	assert(memblock.reserved.cnt == 2);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -619,6 +683,7 @@ static int alloc_bottom_up_second_fit_check(void)
>   /* Test case wrappers */
>   static int alloc_simple_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_top_down_simple_check();
>   	memblock_set_bottom_up(true);
> @@ -629,6 +694,7 @@ static int alloc_simple_check(void)
>   
>   static int alloc_disjoint_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_top_down_disjoint_check();
>   	memblock_set_bottom_up(true);
> @@ -639,6 +705,7 @@ static int alloc_disjoint_check(void)
>   
>   static int alloc_before_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_top_down_before_check();
>   	memblock_set_bottom_up(true);
> @@ -649,6 +716,7 @@ static int alloc_before_check(void)
>   
>   static int alloc_after_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_top_down_after_check();
>   	memblock_set_bottom_up(true);
> @@ -659,6 +727,7 @@ static int alloc_after_check(void)
>   
>   static int alloc_in_between_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_in_between_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -669,6 +738,7 @@ static int alloc_in_between_check(void)
>   
>   static int alloc_second_fit_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_top_down_second_fit_check();
>   	memblock_set_bottom_up(true);
> @@ -679,6 +749,7 @@ static int alloc_second_fit_check(void)
>   
>   static int alloc_small_gaps_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_small_gaps_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -689,6 +760,7 @@ static int alloc_small_gaps_check(void)
>   
>   static int alloc_all_reserved_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_all_reserved_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -699,6 +771,7 @@ static int alloc_all_reserved_check(void)
>   
>   static int alloc_no_space_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_no_space_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -709,6 +782,7 @@ static int alloc_no_space_check(void)
>   
>   static int alloc_limited_space_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_limited_space_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -719,6 +793,7 @@ static int alloc_limited_space_check(void)
>   
>   static int alloc_no_memory_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_no_memory_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -729,6 +804,12 @@ static int alloc_no_memory_check(void)
>   
>   int memblock_alloc_checks(void)
>   {
> +	const char *func_testing = "memblock_alloc";
> +
> +	prefix_reset();
> +	prefix_push(func_testing);
> +	test_print("Running %s tests...\n", func_testing);
> +
>   	reset_memblock_attributes();
>   	dummy_physical_memory_init();
>   
> @@ -746,5 +827,7 @@ int memblock_alloc_checks(void)
>   
>   	dummy_physical_memory_cleanup();
>   
> +	prefix_pop();
> +
>   	return 0;
>   }
> diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
> index 963a966db461..1069b4bdd5fd 100644
> --- a/tools/testing/memblock/tests/alloc_helpers_api.c
> +++ b/tools/testing/memblock/tests/alloc_helpers_api.c
> @@ -21,6 +21,8 @@ static int alloc_from_simple_generic_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_16;
>   	phys_addr_t min_addr;
>   
> @@ -31,14 +33,16 @@ static int alloc_from_simple_generic_check(void)
>   	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, min_addr);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == min_addr);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -64,6 +68,8 @@ static int alloc_from_misaligned_generic_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_32;
>   	phys_addr_t min_addr;
>   
> @@ -75,14 +81,16 @@ static int alloc_from_misaligned_generic_check(void)
>   	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == memblock_end_of_DRAM() - SMP_CACHE_BYTES);
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - SMP_CACHE_BYTES);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -110,6 +118,8 @@ static int alloc_from_top_down_high_addr_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_32;
>   	phys_addr_t min_addr;
>   
> @@ -120,12 +130,14 @@ static int alloc_from_top_down_high_addr_check(void)
>   
>   	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == size);
> -	assert(rgn->base == memblock_end_of_DRAM() - SMP_CACHE_BYTES);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - SMP_CACHE_BYTES);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -151,6 +163,8 @@ static int alloc_from_top_down_no_space_above_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r1_size = SZ_64;
>   	phys_addr_t r2_size = SZ_2;
>   	phys_addr_t total_size = r1_size + r2_size;
> @@ -165,12 +179,14 @@ static int alloc_from_top_down_no_space_above_check(void)
>   
>   	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->base == min_addr - r1_size);
> -	assert(rgn->size == total_size);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->base, min_addr - r1_size);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -186,6 +202,8 @@ static int alloc_from_top_down_min_addr_cap_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r1_size = SZ_64;
>   	phys_addr_t min_addr;
>   	phys_addr_t start_addr;
> @@ -199,12 +217,14 @@ static int alloc_from_top_down_min_addr_cap_check(void)
>   
>   	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->base == start_addr);
> -	assert(rgn->size == MEM_SIZE);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->base, start_addr);
> +	ASSERT_EQ(rgn->size, MEM_SIZE);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, MEM_SIZE);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == MEM_SIZE);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -230,6 +250,8 @@ static int alloc_from_bottom_up_high_addr_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_32;
>   	phys_addr_t min_addr;
>   
> @@ -240,12 +262,14 @@ static int alloc_from_bottom_up_high_addr_check(void)
>   
>   	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->size == size);
> -	assert(rgn->base == memblock_start_of_DRAM());
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -270,6 +294,8 @@ static int alloc_from_bottom_up_no_space_above_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r1_size = SZ_64;
>   	phys_addr_t min_addr;
>   	phys_addr_t r2_size;
> @@ -284,12 +310,14 @@ static int alloc_from_bottom_up_no_space_above_check(void)
>   
>   	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->base == memblock_start_of_DRAM());
> -	assert(rgn->size == r1_size);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> +	ASSERT_EQ(rgn->size, r1_size);
>   
> -	assert(memblock.reserved.cnt == 2);
> -	assert(memblock.reserved.total_size == r1_size + r2_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, r1_size + r2_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -304,6 +332,8 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r1_size = SZ_64;
>   	phys_addr_t min_addr;
>   	phys_addr_t start_addr;
> @@ -315,12 +345,14 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
>   
>   	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
>   
> -	assert(allocated_ptr);
> -	assert(rgn->base == start_addr);
> -	assert(rgn->size == r1_size);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(rgn->base, start_addr);
> +	ASSERT_EQ(rgn->size, r1_size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == r1_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, r1_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -328,6 +360,7 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
>   /* Test case wrappers */
>   static int alloc_from_simple_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_from_simple_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -338,6 +371,7 @@ static int alloc_from_simple_check(void)
>   
>   static int alloc_from_misaligned_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_from_misaligned_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -348,6 +382,7 @@ static int alloc_from_misaligned_check(void)
>   
>   static int alloc_from_high_addr_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_from_top_down_high_addr_check();
>   	memblock_set_bottom_up(true);
> @@ -358,6 +393,7 @@ static int alloc_from_high_addr_check(void)
>   
>   static int alloc_from_no_space_above_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_from_top_down_no_space_above_check();
>   	memblock_set_bottom_up(true);
> @@ -368,6 +404,7 @@ static int alloc_from_no_space_above_check(void)
>   
>   static int alloc_from_min_addr_cap_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_from_top_down_min_addr_cap_check();
>   	memblock_set_bottom_up(true);
> @@ -378,6 +415,12 @@ static int alloc_from_min_addr_cap_check(void)
>   
>   int memblock_alloc_helpers_checks(void)
>   {
> +	const char *func_testing = "memblock_alloc_from";
> +
> +	prefix_reset();
> +	prefix_push(func_testing);
> +	test_print("Running %s tests...\n", func_testing);
> +
>   	reset_memblock_attributes();
>   	dummy_physical_memory_init();
>   
> @@ -389,5 +432,7 @@ int memblock_alloc_helpers_checks(void)
>   
>   	dummy_physical_memory_cleanup();
>   
> +	prefix_pop();
> +
>   	return 0;
>   }
> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 6390206e50e1..255fd514e9f5 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -21,6 +21,8 @@ static int alloc_try_nid_top_down_simple_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_128;
>   	phys_addr_t min_addr;
>   	phys_addr_t max_addr;
> @@ -36,15 +38,17 @@ static int alloc_try_nid_top_down_simple_check(void)
>   	b = (char *)allocated_ptr;
>   	rgn_end = rgn->base + rgn->size;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, max_addr - size);
> +	ASSERT_EQ(rgn_end, max_addr);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == max_addr - size);
> -	assert(rgn_end == max_addr);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -72,6 +76,8 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_128;
>   	phys_addr_t misalign = SZ_2;
>   	phys_addr_t min_addr;
> @@ -88,15 +94,17 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
>   	b = (char *)allocated_ptr;
>   	rgn_end = rgn->base + rgn->size;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == max_addr - size - misalign);
> -	assert(rgn_end < max_addr);
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, max_addr - size - misalign);
> +	ASSERT_LT(rgn_end, max_addr);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -122,6 +130,8 @@ static int alloc_try_nid_exact_address_generic_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_1K;
>   	phys_addr_t min_addr;
>   	phys_addr_t max_addr;
> @@ -137,15 +147,17 @@ static int alloc_try_nid_exact_address_generic_check(void)
>   	b = (char *)allocated_ptr;
>   	rgn_end = rgn->base + rgn->size;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, min_addr);
> +	ASSERT_EQ(rgn_end, max_addr);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == min_addr);
> -	assert(rgn_end == max_addr);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -173,6 +185,8 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_256;
>   	phys_addr_t min_addr;
>   	phys_addr_t max_addr;
> @@ -186,14 +200,16 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
>   					       min_addr, max_addr, NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, max_addr - size);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == max_addr - size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -222,6 +238,8 @@ static int alloc_try_nid_low_max_generic_check(void)
>   {
>   	void *allocated_ptr = NULL;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_1K;
>   	phys_addr_t min_addr;
>   	phys_addr_t max_addr;
> @@ -234,7 +252,9 @@ static int alloc_try_nid_low_max_generic_check(void)
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
>   
> -	assert(!allocated_ptr);
> +	ASSERT_EQ(allocated_ptr, NULL);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -259,6 +279,8 @@ static int alloc_try_nid_min_reserved_generic_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r1_size = SZ_128;
>   	phys_addr_t r2_size = SZ_64;
>   	phys_addr_t total_size = r1_size + r2_size;
> @@ -278,14 +300,16 @@ static int alloc_try_nid_min_reserved_generic_check(void)
>   					       min_addr, max_addr, NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
>   
> -	assert(rgn->size == total_size);
> -	assert(rgn->base == reserved_base);
> +	ASSERT_EQ(rgn->size, total_size);
> +	ASSERT_EQ(rgn->base, reserved_base);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -310,6 +334,8 @@ static int alloc_try_nid_max_reserved_generic_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r1_size = SZ_64;
>   	phys_addr_t r2_size = SZ_128;
>   	phys_addr_t total_size = r1_size + r2_size;
> @@ -327,14 +353,16 @@ static int alloc_try_nid_max_reserved_generic_check(void)
>   					       min_addr, max_addr, NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn->size, total_size);
> +	ASSERT_EQ(rgn->base, min_addr);
>   
> -	assert(rgn->size == total_size);
> -	assert(rgn->base == min_addr);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -364,6 +392,8 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
>   	char *b;
>   	struct region r1, r2;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r3_size = SZ_64;
>   	phys_addr_t gap_size = SMP_CACHE_BYTES;
>   	phys_addr_t total_size;
> @@ -389,17 +419,19 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
>   					       min_addr, max_addr, NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn1->size, r1.size + r3_size);
> +	ASSERT_EQ(rgn1->base, max_addr - r3_size);
>   
> -	assert(rgn1->size == r1.size + r3_size);
> -	assert(rgn1->base == max_addr - r3_size);
> +	ASSERT_EQ(rgn2->size, r2.size);
> +	ASSERT_EQ(rgn2->base, r2.base);
>   
> -	assert(rgn2->size == r2.size);
> -	assert(rgn2->base == r2.base);
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
>   
> -	assert(memblock.reserved.cnt == 2);
> -	assert(memblock.reserved.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -427,6 +459,8 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
>   	char *b;
>   	struct region r1, r2;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r3_size = SZ_64;
>   	phys_addr_t total_size;
>   	phys_addr_t max_addr;
> @@ -451,14 +485,16 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
>   					       min_addr, max_addr, NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
>   
> -	assert(rgn->size == total_size);
> -	assert(rgn->base == r2.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +	ASSERT_EQ(rgn->base, r2.base);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -489,6 +525,8 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
>   	char *b;
>   	struct region r1, r2;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r3_size = SZ_256;
>   	phys_addr_t gap_size = SMP_CACHE_BYTES;
>   	phys_addr_t total_size;
> @@ -514,17 +552,19 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
>   					       min_addr, max_addr, NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn1->size, r1.size);
> +	ASSERT_EQ(rgn1->base, r1.base);
>   
> -	assert(rgn1->size == r1.size);
> -	assert(rgn1->base == r1.base);
> +	ASSERT_EQ(rgn2->size, r2.size + r3_size);
> +	ASSERT_EQ(rgn2->base, r2.base - r3_size);
>   
> -	assert(rgn2->size == r2.size + r3_size);
> -	assert(rgn2->base == r2.base - r3_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
>   
> -	assert(memblock.reserved.cnt == 2);
> -	assert(memblock.reserved.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -554,6 +594,8 @@ static int alloc_try_nid_reserved_all_generic_check(void)
>   	void *allocated_ptr = NULL;
>   	struct region r1, r2;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r3_size = SZ_256;
>   	phys_addr_t gap_size = SMP_CACHE_BYTES;
>   	phys_addr_t max_addr;
> @@ -576,7 +618,9 @@ static int alloc_try_nid_reserved_all_generic_check(void)
>   	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
>   
> -	assert(!allocated_ptr);
> +	ASSERT_EQ(allocated_ptr, NULL);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -592,6 +636,8 @@ static int alloc_try_nid_top_down_cap_max_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_256;
>   	phys_addr_t min_addr;
>   	phys_addr_t max_addr;
> @@ -605,14 +651,16 @@ static int alloc_try_nid_top_down_cap_max_check(void)
>   					       min_addr, max_addr, NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == memblock_end_of_DRAM() - size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -628,6 +676,8 @@ static int alloc_try_nid_top_down_cap_min_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_1K;
>   	phys_addr_t min_addr;
>   	phys_addr_t max_addr;
> @@ -641,14 +691,16 @@ static int alloc_try_nid_top_down_cap_min_check(void)
>   					       min_addr, max_addr, NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == memblock_end_of_DRAM() - size);
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -673,6 +725,8 @@ static int alloc_try_nid_bottom_up_simple_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_128;
>   	phys_addr_t min_addr;
>   	phys_addr_t max_addr;
> @@ -689,15 +743,17 @@ static int alloc_try_nid_bottom_up_simple_check(void)
>   	b = (char *)allocated_ptr;
>   	rgn_end = rgn->base + rgn->size;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, min_addr);
> +	ASSERT_LT(rgn_end, max_addr);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == min_addr);
> -	assert(rgn_end < max_addr);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -725,6 +781,8 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_128;
>   	phys_addr_t misalign = SZ_2;
>   	phys_addr_t min_addr;
> @@ -742,15 +800,17 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
>   	b = (char *)allocated_ptr;
>   	rgn_end = rgn->base + rgn->size;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
> +	ASSERT_LT(rgn_end, max_addr);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == min_addr + (SMP_CACHE_BYTES - misalign));
> -	assert(rgn_end < max_addr);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -778,6 +838,8 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_256;
>   	phys_addr_t min_addr;
>   	phys_addr_t max_addr;
> @@ -792,14 +854,16 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
>   					       NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == memblock_start_of_DRAM());
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -829,6 +893,8 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
>   	char *b;
>   	struct region r1, r2;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r3_size = SZ_64;
>   	phys_addr_t gap_size = SMP_CACHE_BYTES;
>   	phys_addr_t total_size;
> @@ -855,17 +921,19 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
>   					       NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
>   
> -	assert(rgn1->size == r1.size);
> -	assert(rgn1->base == max_addr);
> +	ASSERT_EQ(rgn1->size, r1.size);
> +	ASSERT_EQ(rgn1->base, max_addr);
>   
> -	assert(rgn2->size == r2.size + r3_size);
> -	assert(rgn2->base == r2.base);
> +	ASSERT_EQ(rgn2->size, r2.size + r3_size);
> +	ASSERT_EQ(rgn2->base, r2.base);
>   
> -	assert(memblock.reserved.cnt == 2);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -899,6 +967,8 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
>   	char *b;
>   	struct region r1, r2;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t r3_size = SZ_256;
>   	phys_addr_t gap_size = SMP_CACHE_BYTES;
>   	phys_addr_t total_size;
> @@ -925,20 +995,22 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
>   					       NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn3->size, r3_size);
> +	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
>   
> -	assert(rgn3->size == r3_size);
> -	assert(rgn3->base == memblock_start_of_DRAM());
> +	ASSERT_EQ(rgn2->size, r2.size);
> +	ASSERT_EQ(rgn2->base, r2.base);
>   
> -	assert(rgn2->size == r2.size);
> -	assert(rgn2->base == r2.base);
> +	ASSERT_EQ(rgn1->size, r1.size);
> +	ASSERT_EQ(rgn1->base, r1.base);
>   
> -	assert(rgn1->size == r1.size);
> -	assert(rgn1->base == r1.base);
> +	ASSERT_EQ(memblock.reserved.cnt, 3);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
>   
> -	assert(memblock.reserved.cnt == 3);
> -	assert(memblock.reserved.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -954,6 +1026,8 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_256;
>   	phys_addr_t min_addr;
>   	phys_addr_t max_addr;
> @@ -968,14 +1042,16 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
>   					       NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, min_addr);
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == min_addr);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -991,6 +1067,8 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
>   	void *allocated_ptr = NULL;
>   	char *b;
>   
> +	PREFIX_PUSH();
> +
>   	phys_addr_t size = SZ_1K;
>   	phys_addr_t min_addr;
>   	phys_addr_t max_addr;
> @@ -1005,14 +1083,16 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
>   					       NUMA_NO_NODE);
>   	b = (char *)allocated_ptr;
>   
> -	assert(allocated_ptr);
> -	assert(*b == 0);
> +	ASSERT_NE(allocated_ptr, NULL);
> +	ASSERT_EQ(*b, 0);
> +
> +	ASSERT_EQ(rgn->size, size);
> +	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
>   
> -	assert(rgn->size == size);
> -	assert(rgn->base == memblock_start_of_DRAM());
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -1020,6 +1100,7 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
>   /* Test case wrappers */
>   static int alloc_try_nid_simple_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_top_down_simple_check();
>   	memblock_set_bottom_up(true);
> @@ -1030,6 +1111,7 @@ static int alloc_try_nid_simple_check(void)
>   
>   static int alloc_try_nid_misaligned_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_top_down_end_misaligned_check();
>   	memblock_set_bottom_up(true);
> @@ -1040,6 +1122,7 @@ static int alloc_try_nid_misaligned_check(void)
>   
>   static int alloc_try_nid_narrow_range_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_top_down_narrow_range_check();
>   	memblock_set_bottom_up(true);
> @@ -1050,6 +1133,7 @@ static int alloc_try_nid_narrow_range_check(void)
>   
>   static int alloc_try_nid_reserved_with_space_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_top_down_reserved_with_space_check();
>   	memblock_set_bottom_up(true);
> @@ -1060,6 +1144,7 @@ static int alloc_try_nid_reserved_with_space_check(void)
>   
>   static int alloc_try_nid_reserved_no_space_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_top_down_reserved_no_space_check();
>   	memblock_set_bottom_up(true);
> @@ -1070,6 +1155,7 @@ static int alloc_try_nid_reserved_no_space_check(void)
>   
>   static int alloc_try_nid_cap_max_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_top_down_cap_max_check();
>   	memblock_set_bottom_up(true);
> @@ -1080,6 +1166,7 @@ static int alloc_try_nid_cap_max_check(void)
>   
>   static int alloc_try_nid_cap_min_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_top_down_cap_min_check();
>   	memblock_set_bottom_up(true);
> @@ -1090,6 +1177,7 @@ static int alloc_try_nid_cap_min_check(void)
>   
>   static int alloc_try_nid_min_reserved_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_min_reserved_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -1100,6 +1188,7 @@ static int alloc_try_nid_min_reserved_check(void)
>   
>   static int alloc_try_nid_max_reserved_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_max_reserved_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -1110,6 +1199,7 @@ static int alloc_try_nid_max_reserved_check(void)
>   
>   static int alloc_try_nid_exact_address_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_exact_address_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -1120,6 +1210,7 @@ static int alloc_try_nid_exact_address_check(void)
>   
>   static int alloc_try_nid_reserved_full_merge_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_reserved_full_merge_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -1130,6 +1221,7 @@ static int alloc_try_nid_reserved_full_merge_check(void)
>   
>   static int alloc_try_nid_reserved_all_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_reserved_all_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -1140,6 +1232,7 @@ static int alloc_try_nid_reserved_all_check(void)
>   
>   static int alloc_try_nid_low_max_check(void)
>   {
> +	test_print("\tRunning %s...\n", __func__);
>   	memblock_set_bottom_up(false);
>   	alloc_try_nid_low_max_generic_check();
>   	memblock_set_bottom_up(true);
> @@ -1150,6 +1243,12 @@ static int alloc_try_nid_low_max_check(void)
>   
>   int memblock_alloc_nid_checks(void)
>   {
> +	const char *func_testing = "memblock_alloc_try_nid";
> +
> +	prefix_reset();
> +	prefix_push(func_testing);
> +	test_print("Running %s tests...\n", func_testing);
> +
>   	reset_memblock_attributes();
>   	dummy_physical_memory_init();
>   
> @@ -1170,5 +1269,7 @@ int memblock_alloc_nid_checks(void)
>   
>   	dummy_physical_memory_cleanup();
>   
> +	prefix_pop();
> +
>   	return 0;
>   }
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index a7bc180316d6..66f46f261e66 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -4,21 +4,29 @@
>   #include "basic_api.h"
>   
>   #define EXPECTED_MEMBLOCK_REGIONS			128
> +#define FUNC_ADD					"memblock_add"
> +#define FUNC_RESERVE					"memblock_reserve"
> +#define FUNC_REMOVE					"memblock_remove"
> +#define FUNC_FREE					"memblock_free"
>   
>   static int memblock_initialization_check(void)
>   {
> -	assert(memblock.memory.regions);
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
> -	assert(strcmp(memblock.memory.name, "memory") == 0);
> +	PREFIX_PUSH();
>   
> -	assert(memblock.reserved.regions);
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
> -	assert(strcmp(memblock.reserved.name, "reserved") == 0);
> +	ASSERT_NE(memblock.memory.regions, NULL);
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
> +	ASSERT_EQ(strcmp(memblock.memory.name, "memory"), 0);
>   
> -	assert(!memblock.bottom_up);
> -	assert(memblock.current_limit == MEMBLOCK_ALLOC_ANYWHERE);
> +	ASSERT_NE(memblock.reserved.regions, NULL);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
> +	ASSERT_EQ(strcmp(memblock.reserved.name, "reserved"), 0);
> +
> +	ASSERT_EQ(memblock.bottom_up, false);
> +	ASSERT_EQ(memblock.current_limit, MEMBLOCK_ALLOC_ANYWHERE);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -40,14 +48,18 @@ static int memblock_add_simple_check(void)
>   		.size = SZ_4M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_add(r.base, r.size);
>   
> -	assert(rgn->base == r.base);
> -	assert(rgn->size == r.size);
> +	ASSERT_EQ(rgn->base, r.base);
> +	ASSERT_EQ(rgn->size, r.size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, r.size);
>   
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == r.size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -69,18 +81,22 @@ static int memblock_add_node_simple_check(void)
>   		.size = SZ_16M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_add_node(r.base, r.size, 1, MEMBLOCK_HOTPLUG);
>   
> -	assert(rgn->base == r.base);
> -	assert(rgn->size == r.size);
> +	ASSERT_EQ(rgn->base, r.base);
> +	ASSERT_EQ(rgn->size, r.size);
>   #ifdef CONFIG_NUMA
> -	assert(rgn->nid == 1);
> +	ASSERT_EQ(rgn->nid, 1);
>   #endif
> -	assert(rgn->flags == MEMBLOCK_HOTPLUG);
> +	ASSERT_EQ(rgn->flags, MEMBLOCK_HOTPLUG);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, r.size);
>   
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == r.size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -113,18 +129,22 @@ static int memblock_add_disjoint_check(void)
>   		.size = SZ_8K
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_add(r1.base, r1.size);
>   	memblock_add(r2.base, r2.size);
>   
> -	assert(rgn1->base == r1.base);
> -	assert(rgn1->size == r1.size);
> +	ASSERT_EQ(rgn1->base, r1.base);
> +	ASSERT_EQ(rgn1->size, r1.size);
> +
> +	ASSERT_EQ(rgn2->base, r2.base);
> +	ASSERT_EQ(rgn2->size, r2.size);
>   
> -	assert(rgn2->base == r2.base);
> -	assert(rgn2->size == r2.size);
> +	ASSERT_EQ(memblock.memory.cnt, 2);
> +	ASSERT_EQ(memblock.memory.total_size, r1.size + r2.size);
>   
> -	assert(memblock.memory.cnt == 2);
> -	assert(memblock.memory.total_size == r1.size + r2.size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -162,17 +182,21 @@ static int memblock_add_overlap_top_check(void)
>   		.size = SZ_512M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	total_size = (r1.base - r2.base) + r1.size;
>   
>   	reset_memblock_regions();
>   	memblock_add(r1.base, r1.size);
>   	memblock_add(r2.base, r2.size);
>   
> -	assert(rgn->base == r2.base);
> -	assert(rgn->size == total_size);
> +	ASSERT_EQ(rgn->base, r2.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, total_size);
>   
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -210,17 +234,21 @@ static int memblock_add_overlap_bottom_check(void)
>   		.size = SZ_1G
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	total_size = (r2.base - r1.base) + r2.size;
>   
>   	reset_memblock_regions();
>   	memblock_add(r1.base, r1.size);
>   	memblock_add(r2.base, r2.size);
>   
> -	assert(rgn->base == r1.base);
> -	assert(rgn->size == total_size);
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, total_size);
>   
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -255,15 +283,19 @@ static int memblock_add_within_check(void)
>   		.size = SZ_1M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_add(r1.base, r1.size);
>   	memblock_add(r2.base, r2.size);
>   
> -	assert(rgn->base == r1.base);
> -	assert(rgn->size == r1.size);
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, r1.size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, r1.size);
>   
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == r1.size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -279,19 +311,27 @@ static int memblock_add_twice_check(void)
>   		.size = SZ_2M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   
>   	memblock_add(r.base, r.size);
>   	memblock_add(r.base, r.size);
>   
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == r.size);
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, r.size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
>   
>   static int memblock_add_checks(void)
>   {
> +	prefix_reset();
> +	prefix_push(FUNC_ADD);
> +	test_print("Running %s tests...\n", FUNC_ADD);
> +
>   	memblock_add_simple_check();
>   	memblock_add_node_simple_check();
>   	memblock_add_disjoint_check();
> @@ -300,6 +340,8 @@ static int memblock_add_checks(void)
>   	memblock_add_within_check();
>   	memblock_add_twice_check();
>   
> +	prefix_pop();
> +
>   	return 0;
>   }
>   
> @@ -320,11 +362,15 @@ static int memblock_reserve_simple_check(void)
>   		.size = SZ_128M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_reserve(r.base, r.size);
>   
> -	assert(rgn->base == r.base);
> -	assert(rgn->size == r.size);
> +	ASSERT_EQ(rgn->base, r.base);
> +	ASSERT_EQ(rgn->size, r.size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -356,18 +402,22 @@ static int memblock_reserve_disjoint_check(void)
>   		.size = SZ_512M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   
> -	assert(rgn1->base == r1.base);
> -	assert(rgn1->size == r1.size);
> +	ASSERT_EQ(rgn1->base, r1.base);
> +	ASSERT_EQ(rgn1->size, r1.size);
> +
> +	ASSERT_EQ(rgn2->base, r2.base);
> +	ASSERT_EQ(rgn2->size, r2.size);
>   
> -	assert(rgn2->base == r2.base);
> -	assert(rgn2->size == r2.size);
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, r1.size + r2.size);
>   
> -	assert(memblock.reserved.cnt == 2);
> -	assert(memblock.reserved.total_size == r1.size + r2.size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -406,17 +456,21 @@ static int memblock_reserve_overlap_top_check(void)
>   		.size = SZ_1G
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	total_size = (r1.base - r2.base) + r1.size;
>   
>   	reset_memblock_regions();
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   
> -	assert(rgn->base == r2.base);
> -	assert(rgn->size == total_size);
> +	ASSERT_EQ(rgn->base, r2.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -455,17 +509,21 @@ static int memblock_reserve_overlap_bottom_check(void)
>   		.size = SZ_128K
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	total_size = (r2.base - r1.base) + r2.size;
>   
>   	reset_memblock_regions();
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   
> -	assert(rgn->base == r1.base);
> -	assert(rgn->size == total_size);
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -502,15 +560,19 @@ static int memblock_reserve_within_check(void)
>   		.size = SZ_64K
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   
> -	assert(rgn->base == r1.base);
> -	assert(rgn->size == r1.size);
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, r1.size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, r1.size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == r1.size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -527,19 +589,27 @@ static int memblock_reserve_twice_check(void)
>   		.size = SZ_2M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   
>   	memblock_reserve(r.base, r.size);
>   	memblock_reserve(r.base, r.size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == r.size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, r.size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
>   
>   static int memblock_reserve_checks(void)
>   {
> +	prefix_reset();
> +	prefix_push(FUNC_RESERVE);
> +	test_print("Running %s tests...\n", FUNC_RESERVE);
> +
>   	memblock_reserve_simple_check();
>   	memblock_reserve_disjoint_check();
>   	memblock_reserve_overlap_top_check();
> @@ -547,6 +617,8 @@ static int memblock_reserve_checks(void)
>   	memblock_reserve_within_check();
>   	memblock_reserve_twice_check();
>   
> +	prefix_pop();
> +
>   	return 0;
>   }
>   
> @@ -581,16 +653,20 @@ static int memblock_remove_simple_check(void)
>   		.size = SZ_4M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_add(r1.base, r1.size);
>   	memblock_add(r2.base, r2.size);
>   	memblock_remove(r1.base, r1.size);
>   
> -	assert(rgn->base == r2.base);
> -	assert(rgn->size == r2.size);
> +	ASSERT_EQ(rgn->base, r2.base);
> +	ASSERT_EQ(rgn->size, r2.size);
>   
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == r2.size);
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, r2.size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -626,15 +702,19 @@ static int memblock_remove_absent_check(void)
>   		.size = SZ_1G
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_add(r1.base, r1.size);
>   	memblock_remove(r2.base, r2.size);
>   
> -	assert(rgn->base == r1.base);
> -	assert(rgn->size == r1.size);
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, r1.size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, r1.size);
>   
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == r1.size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -674,6 +754,8 @@ static int memblock_remove_overlap_top_check(void)
>   		.size = SZ_32M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	r1_end = r1.base + r1.size;
>   	r2_end = r2.base + r2.size;
>   	total_size = r1_end - r2_end;
> @@ -682,11 +764,13 @@ static int memblock_remove_overlap_top_check(void)
>   	memblock_add(r1.base, r1.size);
>   	memblock_remove(r2.base, r2.size);
>   
> -	assert(rgn->base == r1.base + r2.base);
> -	assert(rgn->size == total_size);
> +	ASSERT_EQ(rgn->base, r1.base + r2.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, total_size);
>   
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -724,17 +808,22 @@ static int memblock_remove_overlap_bottom_check(void)
>   		.size = SZ_256M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	total_size = r2.base - r1.base;
>   
>   	reset_memblock_regions();
>   	memblock_add(r1.base, r1.size);
>   	memblock_remove(r2.base, r2.size);
>   
> -	assert(rgn->base == r1.base);
> -	assert(rgn->size == total_size);
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, total_size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, total_size);
> +
> +	test_pass_pop();
>   
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == total_size);
>   	return 0;
>   }
>   
> @@ -774,6 +863,8 @@ static int memblock_remove_within_check(void)
>   		.size = SZ_1M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	r1_size = r2.base - r1.base;
>   	r2_size = (r1.base + r1.size) - (r2.base + r2.size);
>   	total_size = r1_size + r2_size;
> @@ -782,26 +873,34 @@ static int memblock_remove_within_check(void)
>   	memblock_add(r1.base, r1.size);
>   	memblock_remove(r2.base, r2.size);
>   
> -	assert(rgn1->base == r1.base);
> -	assert(rgn1->size == r1_size);
> +	ASSERT_EQ(rgn1->base, r1.base);
> +	ASSERT_EQ(rgn1->size, r1_size);
> +
> +	ASSERT_EQ(rgn2->base, r2.base + r2.size);
> +	ASSERT_EQ(rgn2->size, r2_size);
>   
> -	assert(rgn2->base == r2.base + r2.size);
> -	assert(rgn2->size == r2_size);
> +	ASSERT_EQ(memblock.memory.cnt, 2);
> +	ASSERT_EQ(memblock.memory.total_size, total_size);
>   
> -	assert(memblock.memory.cnt == 2);
> -	assert(memblock.memory.total_size == total_size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
>   
>   static int memblock_remove_checks(void)
>   {
> +	prefix_reset();
> +	prefix_push(FUNC_REMOVE);
> +	test_print("Running %s tests...\n", FUNC_REMOVE);
> +
>   	memblock_remove_simple_check();
>   	memblock_remove_absent_check();
>   	memblock_remove_overlap_top_check();
>   	memblock_remove_overlap_bottom_check();
>   	memblock_remove_within_check();
>   
> +	prefix_pop();
> +
>   	return 0;
>   }
>   
> @@ -835,16 +934,20 @@ static int memblock_free_simple_check(void)
>   		.size = SZ_1M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_reserve(r2.base, r2.size);
>   	memblock_free((void *)r1.base, r1.size);
>   
> -	assert(rgn->base == r2.base);
> -	assert(rgn->size == r2.size);
> +	ASSERT_EQ(rgn->base, r2.base);
> +	ASSERT_EQ(rgn->size, r2.size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, r2.size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == r2.size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -880,15 +983,19 @@ static int memblock_free_absent_check(void)
>   		.size = SZ_128M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	reset_memblock_regions();
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_free((void *)r2.base, r2.size);
>   
> -	assert(rgn->base == r1.base);
> -	assert(rgn->size == r1.size);
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, r1.size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, r1.size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == r1.size);
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -928,17 +1035,21 @@ static int memblock_free_overlap_top_check(void)
>   		.size = SZ_8M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	total_size = (r1.size + r1.base) - (r2.base + r2.size);
>   
>   	reset_memblock_regions();
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_free((void *)r2.base, r2.size);
>   
> -	assert(rgn->base == r2.base + r2.size);
> -	assert(rgn->size == total_size);
> +	ASSERT_EQ(rgn->base, r2.base + r2.size);
> +	ASSERT_EQ(rgn->size, total_size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -973,17 +1084,21 @@ static int memblock_free_overlap_bottom_check(void)
>   		.size = SZ_32M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	total_size = r2.base - r1.base;
>   
>   	reset_memblock_regions();
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_free((void *)r2.base, r2.size);
>   
> -	assert(rgn->base == r1.base);
> -	assert(rgn->size == total_size);
> +	ASSERT_EQ(rgn->base, r1.base);
> +	ASSERT_EQ(rgn->size, total_size);
>   
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
> @@ -1024,6 +1139,8 @@ static int memblock_free_within_check(void)
>   		.size = SZ_1M
>   	};
>   
> +	PREFIX_PUSH();
> +
>   	r1_size = r2.base - r1.base;
>   	r2_size = (r1.base + r1.size) - (r2.base + r2.size);
>   	total_size = r1_size + r2_size;
> @@ -1032,26 +1149,34 @@ static int memblock_free_within_check(void)
>   	memblock_reserve(r1.base, r1.size);
>   	memblock_free((void *)r2.base, r2.size);
>   
> -	assert(rgn1->base == r1.base);
> -	assert(rgn1->size == r1_size);
> +	ASSERT_EQ(rgn1->base, r1.base);
> +	ASSERT_EQ(rgn1->size, r1_size);
>   
> -	assert(rgn2->base == r2.base + r2.size);
> -	assert(rgn2->size == r2_size);
> +	ASSERT_EQ(rgn2->base, r2.base + r2.size);
> +	ASSERT_EQ(rgn2->size, r2_size);
>   
> -	assert(memblock.reserved.cnt == 2);
> -	assert(memblock.reserved.total_size == total_size);
> +	ASSERT_EQ(memblock.reserved.cnt, 2);
> +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> +
> +	test_pass_pop();
>   
>   	return 0;
>   }
>   
>   static int memblock_free_checks(void)
>   {
> +	prefix_reset();
> +	prefix_push(FUNC_FREE);
> +	test_print("Running %s tests...\n", FUNC_FREE);
> +
>   	memblock_free_simple_check();
>   	memblock_free_absent_check();
>   	memblock_free_overlap_top_check();
>   	memblock_free_overlap_bottom_check();
>   	memblock_free_within_check();
>   
> +	prefix_pop();
> +
>   	return 0;
>   }
>   
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index 62d3191f7c9a..e55b2a8bf0ff 100644
> --- a/tools/testing/memblock/tests/common.c
> +++ b/tools/testing/memblock/tests/common.c
> @@ -4,8 +4,12 @@
>   
>   #define INIT_MEMBLOCK_REGIONS			128
>   #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
> +#define PREFIXES_LEN_MAX			256
> +#define DELIM					": "
> +#define DELIM_LEN				strlen(DELIM)
>   
>   static struct test_memory memory_block;
> +static char __maybe_unused prefixes[PREFIXES_LEN_MAX];
>   
>   void reset_memblock_regions(void)
>   {
> @@ -46,3 +50,57 @@ void dummy_physical_memory_cleanup(void)
>   {
>   	free(memory_block.base);
>   }
> +
> +#ifdef VERBOSE
> +void test_fail(void)
> +{
> +	ksft_test_result_fail(": %sfailed\n", prefixes);
> +}
> +
> +void test_pass(void)
> +{
> +	ksft_test_result_pass(": %spassed\n", prefixes);
> +}
> +
> +void test_print(const char *fmt, ...)
> +{
> +	int saved_errno = errno;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	errno = saved_errno;
> +	vprintf(fmt, args);
> +	va_end(args);
> +}
> +
> +void prefix_reset(void)
> +{
> +	memset(prefixes, 0, PREFIXES_LEN_MAX);
> +}
> +
> +void prefix_push(const char *prefix)
> +{
> +	int prefix_max = PREFIXES_LEN_MAX - strlen(prefixes) - DELIM_LEN - 1;
> +
> +	assert(strlen(prefix) <= prefix_max);
> +	strncat(prefixes, prefix, prefix_max);
> +	strncat(prefixes, DELIM, PREFIXES_LEN_MAX - strlen(prefixes) - 1);
> +}
> +
> +void prefix_pop(void)
> +{
> +	char *ptr;
> +
> +	ptr = strrchr(prefixes, DELIM[0]);
> +	if (!ptr)
> +		prefixes[0] = 0;
> +	else
> +		*(ptr) = 0;
> +
> +	ptr = strrchr(prefixes, DELIM[0]);
> +	if (!ptr)
> +		prefixes[0] = 0;
> +	else
> +		*(ptr + DELIM_LEN) = 0;
> +}
> +#endif /* VERBOSE */
> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> index 619054d03219..46de86a755f3 100644
> --- a/tools/testing/memblock/tests/common.h
> +++ b/tools/testing/memblock/tests/common.h
> @@ -7,9 +7,49 @@
>   #include <linux/types.h>
>   #include <linux/memblock.h>
>   #include <linux/sizes.h>
> +#include <linux/printk.h>
> +#include <../selftests/kselftest.h>
>   
>   #define MEM_SIZE SZ_16K
>   
> +/**
> + * ASSERT_EQ():
> + * Check the condition
> + * @_expected == @_seen
> + * If false, print failed test message (if in VERBOSE mode) and then assert
> + */
> +#define ASSERT_EQ(_expected, _seen) do { \
> +	if ((_expected) != (_seen)) \
> +		test_fail(); \
> +	assert((_expected) == (_seen)); \
> +} while (0)
> +
> +/**
> + * ASSERT_NE():
> + * Check the condition
> + * @_expected != @_seen
> + * If false, print failed test message (if in VERBOSE mode) and then assert
> + */
> +#define ASSERT_NE(_expected, _seen) do { \
> +	if ((_expected) == (_seen)) \
> +		test_fail(); \
> +	assert((_expected) != (_seen)); \
> +} while (0)
> +
> +/**
> + * ASSERT_LT():
> + * Check the condition
> + * @_expected < @_seen
> + * If false, print failed test message (if in VERBOSE mode) and then assert
> + */
> +#define ASSERT_LT(_expected, _seen) do { \
> +	if ((_expected) >= (_seen)) \
> +		test_fail(); \
> +	assert((_expected) < (_seen)); \
> +} while (0)
> +
> +#define PREFIX_PUSH() prefix_push(__func__)
> +
>   /*
>    * Available memory registered with memblock needs to be valid for allocs
>    * test to run. This is a convenience wrapper for memory allocated in
> @@ -31,4 +71,26 @@ void setup_memblock(void);
>   void dummy_physical_memory_init(void);
>   void dummy_physical_memory_cleanup(void);
>   
> +#ifdef VERBOSE
> +void test_fail(void);
> +void test_pass(void);
> +void test_print(const char *fmt, ...);
> +void prefix_reset(void);
> +void prefix_push(const char *prefix);
> +void prefix_pop(void);
> +#else
> +static inline void test_fail(void) {}
> +static inline void test_pass(void) {}
> +static inline void test_print(const char *fmt, ...) {}
> +static inline void prefix_reset(void) {}
> +static inline void prefix_push(const char *prefix) {}
> +static inline void prefix_pop(void) {}
> +#endif /* VERBOSE */
> +
> +static inline void test_pass_pop(void)
> +{
> +	test_pass();
> +	prefix_pop();
> +}
> +
>   #endif
