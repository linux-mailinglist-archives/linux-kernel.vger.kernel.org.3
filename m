Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301DB592BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbiHOI7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiHOI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:59:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11CC20F55
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660553961; x=1692089961;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tDUIT8sKcCzpDE/lF2HD87yHJ0hfZ3PgpRr0Asp0ey4=;
  b=FczTmfvK7DfZhPaXZY/909DAEzVHfEg4IShcx8E0y+A04dMLYzgZsCaQ
   dGG5zkAgUPKe56fK62e4tzwFxAq9mDyIQZsZxlac2d1A/VSn5XUO7Fjw0
   oKEdpSdiF6G4CnI+Gx10P068NVt59sI0eei5LRii/edjfc5AMQQwyLUh4
   m3/xdf/B9VPyfFSoe+uGRcj+1+s2XigSMQQsmu58S7AMe7HgQeEVVWgO4
   CLsaDp9uptDL9x5xhW3VpWSYRa/r2IgSet28aAMmryRnU9shhXKcFo+Fu
   qPPCZHJUe4KJcFUMB9ODfqE/uhmYMI6LD9QXQeUw4qSuu4jMk4yEEek8G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="290675031"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="290675031"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 01:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="639585586"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2022 01:59:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 01:59:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 01:59:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 01:59:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 01:59:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM+YE6zY6L0PnLEjnTGTUSs/aDCQJes8c4NWnfx/VfA2VyuTxZkivU1iolUXsPYLoQfjl1in7xiCIaVTePLao+UCf72AzO1OijjEM9MtMKsrxUmNyQYA/MrbuMBjk2EF0W4ASeXEhCU+YXd1wbfxpApzlbBI00k87DIOdIOqUfxa9sgJxjyRfTq3UwK2VbJbFU27UTR0bPxtEHu/Zg03iVprPx2QuIMBgYUM0/ONLjbdMu7GfBr+Pzr/MLH7IlO6c8QDrR30BS98OvOWrNq27fKtT0OJvrAFAfsfdY8mPXwbO7XZoopW7o7vcCZPdY/Es8NgnfcdJZjWYSxL0Uon7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yHAhl0bmlGeHOFWowKVPmjrbhtQN7KUXzTPi/ekSlI=;
 b=CDITf34Tm+Pv9Xg1+tH3813M46bUPsOQQc9qonj8Gni/zLmWMxOmQZtjAgtX8XYZTEACOhesBLGIfhw2koREUTrBg97nuI75qqxhxaiajgZkoi/nAxgAHy+/EWh1XHga3cGvheI1oCpQqHDO9c+BGX2zFko5mEfAqx0BY2pp8Acx7+NXVxXsI0M8OIXiuakoZprBzlxeGXeelDft497isR7UEEhdLC4O2MHiqCMQi4+tHmg9yK5+u1J5ufVsWGNJbeqnpmrQidMHIEXmpnCX8dU8Rl+1e78E+Nw0B2SvrCG+wt1wXKIRAtTAC3LkyYluVrLMSDJJjl3FS2LGIX7jqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by SN6PR11MB2686.namprd11.prod.outlook.com (2603:10b6:805:59::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 08:59:17 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e%3]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 08:59:17 +0000
Message-ID: <37ba5dec-e313-635c-3b9e-25ab131833d9@intel.com>
Date:   Mon, 15 Aug 2022 16:59:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 2/8] memblock tests: update zeroed memory check for
 memblock_alloc_* tests
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>
References: <cover.1660454730.git.remckee0@gmail.com>
 <02cad26bef7bc8c7271bba20deac0e5f0bf081c2.1660454730.git.remckee0@gmail.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <02cad26bef7bc8c7271bba20deac0e5f0bf081c2.1660454730.git.remckee0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd736f81-dd48-4dce-2745-08da7e9c6f06
X-MS-TrafficTypeDiagnostic: SN6PR11MB2686:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwEbkt1rHBsQUe2gFW9BK4m8YDqfgjvLlJ5+I+mv4xlceRagjx76n4zAwCGO9mD2u0jROHwKTURKTsIHUF1ciMYcLnXKgdKhQysL701+Xk0NZN3Ttn66UX7rFnou4g2S9Za8FBLZM4BqsR/EJmn3ig3Gz4rfUX+xMjHkjxarq2OJSxBKjVr5xfE1xS+vkgzIJv1wkr+Kp3T6RC/aZ4/yD4XoH20dkTOo7x47Y4Lx+RKCjfk9vgC2bVfNIQSJwtwQgQ6mq3ynlTU1kpiRiygHNSyz1ZX9Khp4bTlQfh/f+AplB4Cnai85byrQsgrAoUbalGlu4WLcysT9mOuhE6y/3rUJGIfKWiPcOzvFYPk+s9OsHqXkA5YKL9ccc1PMnYBkvvdcWifJz3CUr0Do9fwPwWFa0iGUkZLtImgia572AIf4YfecUue6oAh7FAiCewiCykBv3EwbNtSlmBjaHquhHIjCol+Aef7aTvzzYS1Ke5n5/wun6JLtNd/f/paV/qTgrnaoJDAaXIjyyl9f8aZzzfAuytB/9kofmtScTf6F7VX1m5xD5rosslTleGOlUk01qYLz+WVl+w/272v1vL/cT5A88KZZAfR6PE/mY+u1nfakzh6r1h2l0qM4Y43lFVR0ftZvsZ/SOI7G3ajgNUhLWhCGX+N7ld+0/nwNfY5uupeyF2lMx4+tV3whrTfwliYb3yWhMd9rQStMWHLP/RdD1XuRrDaQwbsBTB+TJTlwGg+S6Dv4st+VlmWCkqEslOux2uDHjz76kiYObjbLqsx9cdQulMElZaB0InYL+D215Eipc0Y+ZPdqlUbOnZ7uQcbnbFGx3p2VaNF8YTTOVQGTnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(396003)(366004)(31696002)(86362001)(31686004)(66946007)(66556008)(66476007)(8936002)(36756003)(8676002)(6486002)(82960400001)(478600001)(186003)(4326008)(6666004)(5660300002)(41300700001)(30864003)(15650500001)(38100700002)(26005)(2906002)(6506007)(110136005)(316002)(2616005)(6512007)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am93NzRZTXFEUEVOVGVCV1Z0RGxFRWRnUjFGNzFrUWlYdFVsZWk0Wmt5UVpH?=
 =?utf-8?B?V1REb2huZDBUUzVYcUpGdm9ZeTd2VXMxR0dTeTc2WEFkVDZYbWxvUk1Mb3BH?=
 =?utf-8?B?T0RCL1hIaUVRUmJhZTZyWFVhOW05M2sxeXNtb1JsMUlFeGFhbFBUNFRtWDdG?=
 =?utf-8?B?dmtVbWZzQy9KU2VJemdPdjhEOEtSN3NocHlTV3JFR29OcytmMW8yeWM1cFNN?=
 =?utf-8?B?SFEvNThkWlQ3TTEzTTNTZVA4aFd5STBQWk9OL3pJVlJ1K3k2b2Rmcjk4bDcw?=
 =?utf-8?B?QUNBbm4rOVB5cUFNVDFDYnlqalRPdENFK1FhU1JBTkZlQW1jR3M3eGxmWmps?=
 =?utf-8?B?RC90Wk5USEprMlBEamF5bHYxcDBYOTQvOXpKUGR0Y0hQRTBkeCtZVVovVjRx?=
 =?utf-8?B?Wit0TVJEQWYxVlZSbkRiNGdtSTlJZG9pMmhMSFE0WnljU21qcXh1eGY3NVh0?=
 =?utf-8?B?YWtCWVVqNi83a0xHcFFEUFpPK3Nlam93TFFqU01LQXltcHB4TGNKVzFiYmhw?=
 =?utf-8?B?M3BNanRISkQyd3BOeUxzZXhjanF6YXpJT2R0UFBoYnk5QnY4RVRYNVYvWk1E?=
 =?utf-8?B?cHVFcnkzcittOU1Fd1pyS29VdjVYVmR1NUdkMk93TE0rYXI5OTJiS0YvcFI1?=
 =?utf-8?B?YndmdzVobVBQUDl4cWxXRzc5MFNFbjZSditRMGZyd29CZENpSkpWdjBaYVRq?=
 =?utf-8?B?cjE2c0tPTGt5dnNKMFVJNDZ3eFdaQitwa01HWTc0dGIwaHNJakRGK3o3VVVN?=
 =?utf-8?B?dDVUbFRyV3puMHc1S3lkLzRTcHg4Y1JORFJDNmhIZHg0Qmh1aFE2UDBDdWJm?=
 =?utf-8?B?eWtxK2t4b1pqZXZXZ3JoWWlJa2REcmZZWkdpbWx2a2cyTFJpOVQzRXU5bkht?=
 =?utf-8?B?Q1kwSjNoZnJEcmltbzB4bFBmWUVrWHlmcmJmSmpFN2kwdzBFWWhpRmVteUhE?=
 =?utf-8?B?NEZNZUJ1UUtNNStvcjZLYUtzVlNTUGF6MDQzekpGTGRxd21IeEZna2d6T3d6?=
 =?utf-8?B?aW1ncWdoZi9IUXB5bnI2MWRnMjI0cDAxSjI3VThBc3RPOW1VdWJFVko4SWJU?=
 =?utf-8?B?RHE1dkpjbHk4UFpSL3FXSjN3cHhybVZLYkRGWmJIRnU3QUhPekhsM3EvRFM1?=
 =?utf-8?B?TGNIZitrcml4dnFQKzMxaTA4MmpPdy9NREFsVm0vWWFBdVdzVXpWaUpFYUlM?=
 =?utf-8?B?dmFyd29BaWp4SG9sU1gweWdSRnNoMWhZT1orREJvdVZTNDgzVGxKM0NXLzJY?=
 =?utf-8?B?ZTBsdzlTcktFNVdDMmFxeVQxWWxNNGlETVN3aUlnaG5hdXp2dkREYkk3azV1?=
 =?utf-8?B?VDU0ZW1XV25DVDN5blFjOFBkOGJDSDBYV05tRW13T01PN21HVTNqMDR0Nzlo?=
 =?utf-8?B?SnRKM2pEelBSbmljQWRVcDMxNDFKcHlvRkZpeWhlTEM2bHp6UzBDdW9VM3Z2?=
 =?utf-8?B?U3dJTzRqdG5ZUUQvc1NLYjdKVDNEYXVVdUdyYVlsS05IRlhORHNPYUxPSHUw?=
 =?utf-8?B?QVJxbkRFYlQ0SUwxTGFZMzhKWjZ1Z3E1OTB1dHIxQS9VNzhlQmtCZFhvK3Bm?=
 =?utf-8?B?a1c0aTU5SC9GMERWZnRaMGVhNG8weDRRUmhsRTBOT2tGaExFVFlGdnBoeEVN?=
 =?utf-8?B?dFQ2MTNrbHowMktPMWZJVjkxdDFNOXRSYWdURjdPZXJlNnZIMWQxYk12Y3Rw?=
 =?utf-8?B?UVRPMW5FWDQzclhBdkdkMnY5SGFVdWNhcllTSGJ2M3ZhZktCN2t6TTJTaVE4?=
 =?utf-8?B?NnpaMU1BUmZtY3R2Zjhibm5HU2FCVmgrRVdpbVlSYnNXZnhFV2RhRHIzUzhz?=
 =?utf-8?B?Nk9XV01NMnIvdmdMVkY0eE54bzZyb3JqTUF1MGZyeWNWelVISlEwa1FvVUpS?=
 =?utf-8?B?TVNkMWNkaTNUTDVUalRNSWdaQzVhbFpHbUJVU1VnQ2NwSGRERlBkemFYY0oy?=
 =?utf-8?B?d2RoSzRvK1pmSlBud092SlVqamwvS3pYTTNzUDVPeGEyV25IMVdMczFUaHZn?=
 =?utf-8?B?K21BM3Zub1F2SndoS2hyTkl4cC91WHJDeGpCMEtNcXBIdEZRRVFMK3I0bzlr?=
 =?utf-8?B?VWMxMnFHcDE5K0tXbGpLYjl3aUFoWkpVNTJWWExEYXRCNmo5S0FKajNwcmVB?=
 =?utf-8?B?WEFsMUhwc2Y4bXBySkE4elpvNHcyUkpSR1J2TTA1M240UmNEQ1pFdlN2UGNZ?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd736f81-dd48-4dce-2745-08da7e9c6f06
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 08:59:17.2612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wE9YUORfmmiKQi0f+irlIcSi2Q3HJVccFQoNxCDB181In/LDgm9zX0zihnmjjmqMgFA53hssLnr2qx2LGcXP4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2686
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

LGTM.

Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>

On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> Update the assert in memblock_alloc_try_nid() and memblock_alloc_from()
> tests that checks whether the memory is cleared so that it checks the
> entire chunk of allocated memory instead of just the first byte.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   .../memblock/tests/alloc_helpers_api.c        |  8 +--
>   tools/testing/memblock/tests/alloc_nid_api.c  | 72 +++++--------------
>   2 files changed, 20 insertions(+), 60 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
> index 1069b4bdd5fd..796527cf3bd2 100644
> --- a/tools/testing/memblock/tests/alloc_helpers_api.c
> +++ b/tools/testing/memblock/tests/alloc_helpers_api.c
> @@ -19,7 +19,6 @@ static int alloc_from_simple_generic_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -31,10 +30,9 @@ static int alloc_from_simple_generic_check(void)
>   	min_addr = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
>   
>   	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, min_addr);
> @@ -66,7 +64,6 @@ static int alloc_from_misaligned_generic_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -79,10 +76,9 @@ static int alloc_from_misaligned_generic_check(void)
>   	min_addr = memblock_end_of_DRAM() - (SMP_CACHE_BYTES * 2 - 1);
>   
>   	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - SMP_CACHE_BYTES);
> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 255fd514e9f5..71b7beb35526 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -19,7 +19,6 @@ static int alloc_try_nid_top_down_simple_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -35,11 +34,10 @@ static int alloc_try_nid_top_down_simple_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   	rgn_end = rgn->base + rgn->size;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, max_addr - size);
> @@ -74,7 +72,6 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -91,11 +88,10 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   	rgn_end = rgn->base + rgn->size;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, max_addr - size - misalign);
> @@ -128,7 +124,6 @@ static int alloc_try_nid_exact_address_generic_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -144,11 +139,10 @@ static int alloc_try_nid_exact_address_generic_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   	rgn_end = rgn->base + rgn->size;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, min_addr);
> @@ -183,7 +177,6 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -198,10 +191,9 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, max_addr - size);
> @@ -277,7 +269,6 @@ static int alloc_try_nid_min_reserved_generic_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -298,10 +289,9 @@ static int alloc_try_nid_min_reserved_generic_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
>   
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, reserved_base);
> @@ -332,7 +322,6 @@ static int alloc_try_nid_max_reserved_generic_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -351,10 +340,9 @@ static int alloc_try_nid_max_reserved_generic_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
>   
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, min_addr);
> @@ -389,7 +377,6 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
>   	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
>   	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   	struct region r1, r2;
>   
>   	PREFIX_PUSH();
> @@ -417,10 +404,9 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
>   
>   	ASSERT_EQ(rgn1->size, r1.size + r3_size);
>   	ASSERT_EQ(rgn1->base, max_addr - r3_size);
> @@ -456,7 +442,6 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   	struct region r1, r2;
>   
>   	PREFIX_PUSH();
> @@ -483,10 +468,9 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
>   
>   	ASSERT_EQ(rgn->size, total_size);
>   	ASSERT_EQ(rgn->base, r2.base);
> @@ -522,7 +506,6 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
>   	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
>   	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   	struct region r1, r2;
>   
>   	PREFIX_PUSH();
> @@ -550,10 +533,9 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
>   
>   	ASSERT_EQ(rgn1->size, r1.size);
>   	ASSERT_EQ(rgn1->base, r1.base);
> @@ -634,7 +616,6 @@ static int alloc_try_nid_top_down_cap_max_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -649,10 +630,9 @@ static int alloc_try_nid_top_down_cap_max_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
> @@ -674,7 +654,6 @@ static int alloc_try_nid_top_down_cap_min_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -689,10 +668,9 @@ static int alloc_try_nid_top_down_cap_min_check(void)
>   
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr, NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
> @@ -723,7 +701,6 @@ static int alloc_try_nid_bottom_up_simple_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -740,11 +717,10 @@ static int alloc_try_nid_bottom_up_simple_check(void)
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr,
>   					       NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   	rgn_end = rgn->base + rgn->size;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, min_addr);
> @@ -779,7 +755,6 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -797,11 +772,10 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr,
>   					       NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   	rgn_end = rgn->base + rgn->size;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
> @@ -836,7 +810,6 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -852,10 +825,9 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr,
>   					       NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> @@ -890,7 +862,6 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
>   	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
>   	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   	struct region r1, r2;
>   
>   	PREFIX_PUSH();
> @@ -919,10 +890,9 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
>   	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr,
>   					       NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
>   
>   	ASSERT_EQ(rgn1->size, r1.size);
>   	ASSERT_EQ(rgn1->base, max_addr);
> @@ -964,7 +934,6 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
>   	struct memblock_region *rgn2 = &memblock.reserved.regions[1];
>   	struct memblock_region *rgn3 = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   	struct region r1, r2;
>   
>   	PREFIX_PUSH();
> @@ -993,10 +962,9 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
>   	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr,
>   					       NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
>   
>   	ASSERT_EQ(rgn3->size, r3_size);
>   	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
> @@ -1024,7 +992,6 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -1040,10 +1007,9 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr,
>   					       NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, min_addr);
> @@ -1065,7 +1031,6 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
>   {
>   	struct memblock_region *rgn = &memblock.reserved.regions[0];
>   	void *allocated_ptr = NULL;
> -	char *b;
>   
>   	PREFIX_PUSH();
>   
> @@ -1081,10 +1046,9 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
>   	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
>   					       min_addr, max_addr,
>   					       NUMA_NO_NODE);
> -	b = (char *)allocated_ptr;
>   
>   	ASSERT_NE(allocated_ptr, NULL);
> -	ASSERT_EQ(*b, 0);
> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>   
>   	ASSERT_EQ(rgn->size, size);
>   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
