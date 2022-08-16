Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FDD59533A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiHPHBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiHPHAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:00:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FA278582
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660616702; x=1692152702;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L9xL/MAcUupPbyAwYLC5GrhfS3YA1nFVJeuhafkwQ9o=;
  b=FMR9/+5cngmuw1RsQt0NkY3z0cBdDAA5qQKHpK22gFGbg/vWGbyo6y9m
   xmHq3xYZZWUdXhwWymM4hKhYWAVIBICWCkc+6JcSQSzgcJ1WhWrEN2NKL
   TvgzPRq4MYGHdLuVb2YQ25RVKzn0rUJ8eig/5RxFHMffvbtAgqhI6cRFO
   TiDxLJWRZHPTj9TIOwHVzZwlBXdtgAjg3Xzb+Pwtg2RjVrv/Pa8vW3w8b
   oxQYeL+rh1uqUqHSqXQLJiOq42BM8qqNBxqFm9RFoXwA432D/JvttKxA2
   5G0xNvKAiW7Eoxox66raCZE5NGTga902H3n2CUZ6ssyte9GQ8k56Rhloj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="271876577"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="271876577"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 19:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="934707573"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2022 19:25:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 19:25:01 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 19:25:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 19:25:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 19:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeGzAreTEr3z8PVRZ/BYEqfYmQk/dvP7vT8cwDJAbnObPN74mjvD9xgzUNjUdmGGHqL9Y+e8/dcdjD6GcpTsavPsnCa1PtJ7TgyFo7hXZi2GUYNkVZPBTB5U6jO3YWFDEhZccMtIN6y+Paadgk5nGw/xX1K9ptQr3cwUZmlA2VerG2h6fnLl5o1UFNu38BpYxyr43UaViRoU4DtJehvIwv9hhSVpkGKHgZcPbRVntj9YznVbj8eM0LOyrUdQRQBwmMoYPQxKaSNk3kegELZTAZky57q4Uic7cfOxFmNjaUD9UMyR9H4g3JXzRe8HjWwr5Y7X82/3YE6y3CdraE+5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zndexq7VtTyxUs3JvuhY8u/QATw+QDjGQeVIqeaEeZw=;
 b=M1pVXv0vvY120Ut6cUIlV1/8qn8M8E8plkeX7QfBUilqtIDAF8/R8aPEqWOMnAsYL1wZ/XT+ss7E4+3kzJOZ6+NOTFGsdrNjPdWxLHQe1Mllw9Wtucu/x8K1LNRuqMi8MHLF5dvlkDGX2jvipMmmeYSs3sdg6DxsaPuq9sco+2mkpnyd+XuW6hgjGefoKeDEEvQWzU3GMxsSfCLfbtchXmlyutV6lra2Aa6X2wPkSCNMHNx5/SY3M0L6WBiQKsGbKgoaNNtha+uQSYDAOP8WYX648At/oBz6zwlVA/iVjo8cFhEel3DDtegXId1PAlvmDe7/mGHCk+dpUHqo1g4pFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by SJ1PR11MB6156.namprd11.prod.outlook.com (2603:10b6:a03:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 02:24:58 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e%3]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 02:24:52 +0000
Message-ID: <cfdf337a-96dd-e0f8-89f9-1339c5a2579b@intel.com>
Date:   Tue, 16 Aug 2022 10:24:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 1/8] memblock tests: update tests to check if
 memblock_alloc zeroed memory
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>
CC:     Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
References: <cover.1660454730.git.remckee0@gmail.com>
 <02d514d86f212c79e52792b8ecd919156d7a9c20.1660454730.git.remckee0@gmail.com>
 <5dde66a7-2236-a890-aaeb-a45876057bec@intel.com>
 <20220816021522.GA3590@sophie>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <20220816021522.GA3590@sophie>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b70fb11-bc3b-4f5c-3857-08da7f2e7fd9
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6156:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GVJRLMoZ3nr+aLqcSNSNN0zMNN9UEFAEYLmYonqKOxrgAI+rqaN4FKY/EYyxliWWjmFUEyvqAP9gjMsMkms1xYABgTyVwaslKK/EeeIO7+6wr0klXjxJgRCg5Wymm9AyZ3ht10WDRXXbXESCRzasszNztavs87Rn0BBYZm4jnpeb8DgrHFSCDYpCuKG6xNcp1xRz44XiLUHo3dOLpu04AmC0IM3FoQNDlnvf07COegjMrOeYa15Wf+blKJppCs1iHr27TcOvpjEHxFAckwIB4jDePRFvniyWCGxSM7zxTKQJLg2OGuDUUa7Ac58NebollGcc9/AqFyRy+NqoAMKQGyGXoZZTgQ1E6FogRcd4vI3uP5NDylTvUAnso8/SNoZxDhuEdNAnccVxVbi5Wt7A9MR3SRlD7pgwP102AyFA62f2qaxffXWqVrL1a8KZ54xVm+G8ok1lvMZr+g4y6wNB30/lNWgdHGFS3VFXeJX9x/kxgAP3goUxJ5UWS2CDliavznpH7IwfinIHqlXbVSUNCubcHbiQaWYgFCgqK0+w6mDwYOPOwklvWcf+lUVqiCbLOG8+JIhqMGWnPvA0BCoGPADJENC2bZvJJYPMGO1NUzpJAAXeemAhiKKFtbUqj6Nv0retXDYD2E/swRQItt6fWBo+8XvdAGNhMteZe5v/Q0NSPs4rFFTcsZZS9PzK5xytAf/7MaHMyTZSFCtvpFeH50oP2ZnICQPHNzN32T5zHlqXtg3qgHaJUEyrMXDGItPBTB3D2aPNno0OFVT5C4gWWGlNkTILHV04fxrkHCKEMJwmcZLATyPFicbQ3R31cH6D3clBq42m88/ZGcT0+kreA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(396003)(39860400002)(6512007)(82960400001)(186003)(36756003)(31696002)(478600001)(41300700001)(26005)(86362001)(2616005)(53546011)(6506007)(31686004)(83380400001)(6666004)(6486002)(8676002)(66556008)(66476007)(4326008)(15650500001)(316002)(54906003)(5660300002)(6916009)(2906002)(66946007)(38100700002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFoc2Q5N0QrSXVTUTRFZmVyRGk0encvSTFHZm9RcVlOc2xVWXJFa3hJYkxT?=
 =?utf-8?B?UkZqaGFyT0M2a0NXYlVSSmovR2RNUzVnUUJYdTl2eVBudmdHYkxORTMrdmVv?=
 =?utf-8?B?MWtlenJkRmtXZHI4bEpmaTZwN2RpZVFRTWh5aDdEVWJGYlg5b0wwUlYzNGFx?=
 =?utf-8?B?dzRNU2xlRnRWT2Q1KzVxbnZCTUpPbk5kVU80VXV2V2lldnNmeTB0M2FUdEFW?=
 =?utf-8?B?VHFIUHFDVkwzNm1UQ1NTbnFoQ3BzMkFvOVkyUzRjSjNWZDVSWVMrckFYc25o?=
 =?utf-8?B?Q3MrYWpvNXRsQjJ6cDdxNmNSRGpyU213QmRiQklocDZmVHNacjMxVFFLUUxm?=
 =?utf-8?B?a1dhNkZPSjlQVjNHV0FmL0hTMWxycUVLVG5ZZXp0b2FFY1F1MVVyalRzd1Zo?=
 =?utf-8?B?bXBJa3JzUHhmeXh2aFBrdTNGY0xkYnExRTQxTm9sc2h2VXBhR09YNktYY1Rk?=
 =?utf-8?B?M21rSTZ6QVhDYzV3M1kzUVMySCs2TkJyVFltSDk0a3BHZ3UweDFwdFM3RDZD?=
 =?utf-8?B?N21iVXAxTHJxTlk3OW44RjhnVDF5RkdqcmdieDV5Q2pjT2owMmtOQnpOSFZG?=
 =?utf-8?B?RDhBNllkbDNkUjQ5UTd1WjZDOEVoN1I0WnY2a09YK0ZqZFVDSENFUUZrZWg5?=
 =?utf-8?B?RnpnM0xwRENMS01nQkh5MVhnL1NzNncrS0NRN1V1Qk1XTkFsSTk0UzYrTHZJ?=
 =?utf-8?B?cDI1c1lsR1YrS2pYZEZ0N3F2T05NRGNtTU80WE81NW1IL1NleEZjeHovQmp4?=
 =?utf-8?B?bjBWUWlTK3J4dUtBZmlXVFhiQzBFQzNGQ0Fqa1pJZmJhemgxSkZaanNrblRK?=
 =?utf-8?B?OU0zRzFMY3FyMng5TVM5OU5uenJEckZsdU0wTHhqd2NoZ0JwbHpLemk3YTBz?=
 =?utf-8?B?NkF3MXN6UFU3WGNtbU54T3BiTGRVSzFDbjJEOGhzNE15QWQ0dzN2M0I2UjZ5?=
 =?utf-8?B?QS9TWjgrckRUVk8wU25aVzRha0huODdBS2wvbXZEai9jZGphenE4WUtHR1BL?=
 =?utf-8?B?dmRMbHcrRXRScmEwMm5qbWl5UVNyVWxWKy9xb3I4bzhlWWs0amxMdFBVMVoz?=
 =?utf-8?B?cXFHWTFaMThlV24wc1ZaQjR6M2FNT2d2WlVOUXR6MXh1OVVBRUdlVXoxb0VT?=
 =?utf-8?B?QlRKUTRVWWZoWThVTml2L1ZnakJYV05STGo1K3VPUXJ3MGIrQ0hqbUpyU2hF?=
 =?utf-8?B?MzdMcFJLVE0wZlgySzJWMFN0S1RkT2cvem9aOXRYVzlMemMvLzVDUHNKN2gr?=
 =?utf-8?B?SGhZR0NBTGU1N1pTYTF2T3BKM01lTG1vTTJEMTJxamxVcE1RUHB1VGdjZ09i?=
 =?utf-8?B?UHg0d2RLL01wZVI0SXN3am81akJYS0hsYU5ORFp0TlFZd2VlVEZYUFM2bFB6?=
 =?utf-8?B?WUJIQW0vT0ZCUG52NnJwS3pla3lXOThXSWwvWDBNWmtVNGRJM1UydWt5K3Vo?=
 =?utf-8?B?bEREQmZUOHc4OEVRVm1DTjlURnlZVEEybkYySloyZjdMdkN1eHlrQi9EcUVX?=
 =?utf-8?B?Z1kxKytnU3dNb0RyTTJTMWF4NWlpT01XWG1kMGtxeVVlbzB1c1hkWkpibFZv?=
 =?utf-8?B?cWc2VGNkdFZSd0NzMFJaL3FSZGIzRHB3UWhCRkpIcnp1ZkNCbzVIanF2M2V4?=
 =?utf-8?B?djVISTVhRWE4NEYvRGZXUndUa1lwL2Q2WVNJajUxL1B1bU80c1hxSVBuQTBR?=
 =?utf-8?B?cEVSbmZ4YWxmeEF0OThYU2Q2V0ZTT1VVNGxhRU8yYkE1UUUxOEVIOEFYcmJB?=
 =?utf-8?B?bTVCaDRNWno5dXNBY0NYd3N6dUdQcW9xNEZBRnBpdndpMm5DUjBWN1lmZDhI?=
 =?utf-8?B?VGh2dkV0aGJZbHN0a3pwcm1YamVTRms2bmh3WnJ0SG5wY1ZxRDl1dnlTaXZE?=
 =?utf-8?B?c3JGTDBkeXhXSmlSbmFTZ3ZRcFhrRXpENCtGOVB6eXRzWlhHbXhrTVdSM1Ez?=
 =?utf-8?B?WHp1NWtPbFhNeUhNRHk3OEVDbU1NUDNSRXVodDRSazFsdGpwYlQ0OE1wWmht?=
 =?utf-8?B?anQvdzVFVjZ4Wlh3ZWs4aFdSQmxocko5VEc3Y2NEQ2kxRlN4dE9KOGZsQUFO?=
 =?utf-8?B?RDRVQmNRV3pWRVRuNVlrM0wxMjNmbEljVkllbGFhUVJhMXVqdEpHbGRLSlU3?=
 =?utf-8?B?ZW0zajNsYmxpQmZMWS9hQ1ptNk5laGtzNnBSZm1jZGMwWmpwTzFHQmFBNkVH?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b70fb11-bc3b-4f5c-3857-08da7f2e7fd9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 02:24:51.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deawjs2TM1tDOUb5aLUyQ1uPo1vrvsHXGnxD62skNaZosBpGwRIFzPBxEGkyZR32WjumFYpXs4bfb6RdLNFF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6156
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2022 10:15 AM, Rebecca Mckeever wrote:
> On Mon, Aug 15, 2022 at 04:50:51PM +0800, Huang, Shaoqin wrote:
>> Hi, Rebecca.
>>
>> On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
>>> Add an assert in memblock_alloc() tests where allocation is expected to
>>> occur. The assert checks whether the entire chunk of allocated memory is
>>> cleared.
>>>
>>> The current memblock_alloc() tests do not check whether the allocated
>>> memory was zeroed. memblock_alloc() should zero the allocated memory since
>>> it is a wrapper for memblock_alloc_try_nid().
>>>
>>> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
>>> ---
>>>    tools/testing/memblock/tests/alloc_api.c | 24 ++++++++++++++++++++++++
>>>    tools/testing/memblock/tests/common.c    |  7 +++++++
>>>    tools/testing/memblock/tests/common.h    | 13 +++++++++++++
>>>    3 files changed, 44 insertions(+)
>>>
>>> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
>>> index a14f38eb8a89..71c89cb9b2a8 100644
>>> --- a/tools/testing/memblock/tests/alloc_api.c
>>> +++ b/tools/testing/memblock/tests/alloc_api.c
>>> @@ -22,6 +22,8 @@ static int alloc_top_down_simple_check(void)
>>>    	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
>>> +
>>>    	ASSERT_EQ(rgn->size, size);
>>>    	ASSERT_EQ(rgn->base, expected_start);
>>> @@ -80,6 +82,8 @@ static int alloc_top_down_disjoint_check(void)
>>>    	allocated_ptr = memblock_alloc(r2_size, alignment);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
>>> +
>>>    	ASSERT_EQ(rgn1->size, r1.size);
>>>    	ASSERT_EQ(rgn1->base, r1.base);
>>> @@ -125,6 +129,8 @@ static int alloc_top_down_before_check(void)
>>>    	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
>>> +
>>>    	ASSERT_EQ(rgn->size, total_size);
>>>    	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
>>> @@ -173,6 +179,8 @@ static int alloc_top_down_after_check(void)
>>>    	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
>>> +
>>>    	ASSERT_EQ(rgn->size, total_size);
>>>    	ASSERT_EQ(rgn->base, r1.base - r2_size);
>>> @@ -223,6 +231,8 @@ static int alloc_top_down_second_fit_check(void)
>>>    	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
>>> +
>>>    	ASSERT_EQ(rgn->size, r2.size + r3_size);
>>>    	ASSERT_EQ(rgn->base, r2.base - r3_size);
>>> @@ -277,6 +287,8 @@ static int alloc_in_between_generic_check(void)
>>>    	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
>>> +
>>>    	ASSERT_EQ(rgn->size, total_size);
>>>    	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
>>> @@ -418,6 +430,8 @@ static int alloc_limited_space_generic_check(void)
>>>    	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, available_size);
>>> +
>>>    	ASSERT_EQ(rgn->size, MEM_SIZE);
>>>    	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
>>> @@ -442,6 +456,7 @@ static int alloc_no_memory_generic_check(void)
>>>    	PREFIX_PUSH();
>>>    	reset_memblock_regions();
>>> +	fill_memblock();
>>
>> Maybe we don't need this line, it has no effect at here. Anyway, Others
>> Looks Good to me.
>>
> Do you mean that it's not necessary since the test doesn't run
> verify_mem_content()?
> 

Yes. And the test function name is alloc_no_memory_...(). So I just 
think no memory operation in it may be same with the function name.

>> Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>
>>
>>>    	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
>>> @@ -472,6 +487,8 @@ static int alloc_bottom_up_simple_check(void)
>>>    	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, SZ_2);
>>> +
>>>    	ASSERT_EQ(rgn->size, SZ_2);
>>>    	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
>>> @@ -528,6 +545,7 @@ static int alloc_bottom_up_disjoint_check(void)
>>>    	allocated_ptr = memblock_alloc(r2_size, alignment);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
>>>    	ASSERT_EQ(rgn1->size, r1.size);
>>>    	ASSERT_EQ(rgn1->base, r1.base);
>>> @@ -571,6 +589,8 @@ static int alloc_bottom_up_before_check(void)
>>>    	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r1_size);
>>> +
>>>    	ASSERT_EQ(rgn->size, total_size);
>>>    	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
>>> @@ -618,6 +638,8 @@ static int alloc_bottom_up_after_check(void)
>>>    	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
>>> +
>>>    	ASSERT_EQ(rgn->size, total_size);
>>>    	ASSERT_EQ(rgn->base, r1.base);
>>> @@ -669,6 +691,8 @@ static int alloc_bottom_up_second_fit_check(void)
>>>    	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
>>>    	ASSERT_NE(allocated_ptr, NULL);
>>> +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
>>> +
>>>    	ASSERT_EQ(rgn->size, r2.size + r3_size);
>>>    	ASSERT_EQ(rgn->base, r2.base);
>>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
>>> index 76a8ad818f3a..0ca26fe12c38 100644
>>> --- a/tools/testing/memblock/tests/common.c
>>> +++ b/tools/testing/memblock/tests/common.c
>>> @@ -60,16 +60,23 @@ void reset_memblock_attributes(void)
>>>    	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
>>>    }
>>> +void fill_memblock(void)
>>> +{
>>> +	memset(memory_block.base, 1, MEM_SIZE);
>>> +}
>>> +
>>>    void setup_memblock(void)
>>>    {
>>>    	reset_memblock_regions();
>>>    	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
>>> +	fill_memblock();
>>>    }
>>>    void dummy_physical_memory_init(void)
>>>    {
>>>    	memory_block.base = malloc(MEM_SIZE);
>>>    	assert(memory_block.base);
>>> +	fill_memblock();
>>>    }
>>>    void dummy_physical_memory_cleanup(void)
>>> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
>>> index d396e5423a8e..7a16a7dc8f2c 100644
>>> --- a/tools/testing/memblock/tests/common.h
>>> +++ b/tools/testing/memblock/tests/common.h
>>> @@ -51,6 +51,18 @@
>>>    	assert((_expected) < (_seen)); \
>>>    } while (0)
>>> +/**
>>> + * ASSERT_MEM_EQ():
>>> + * Check that the first @_size bytes of @_seen are all equal to @_expected.
>>> + * If false, print failed test message (if running with --verbose) and then
>>> + * assert.
>>> + */
>>> +#define ASSERT_MEM_EQ(_seen, _expected, _size) do { \
>>> +	for (int _i = 0; _i < (_size); _i++) { \
>>> +		ASSERT_EQ((_seen)[_i], (_expected)); \
>>> +	} \
>>> +} while (0)
>>> +
>>>    #define PREFIX_PUSH() prefix_push(__func__)
>>>    /*
>>> @@ -70,6 +82,7 @@ struct region {
>>>    void reset_memblock_regions(void);
>>>    void reset_memblock_attributes(void);
>>> +void fill_memblock(void);
>>>    void setup_memblock(void);
>>>    void dummy_physical_memory_init(void);
>>>    void dummy_physical_memory_cleanup(void);
