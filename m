Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B005A9225
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiIAIff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiIAIfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:35:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FFB2ED73
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662021318; x=1693557318;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KARca7HROnREZwvhUXnXlar/18Q4XMohGELdmezKwHU=;
  b=FsdvSFyS5xEcYbz0ZFoPlJrCZhhqCTDBqRnnsmx4AuEK6+YdlGa0rw4i
   K5pAK6jPX9DihZIPxtUnqWNwG4PFTDUm/OUZ2fHHfttda3axxZm+5m66i
   2ukuC0b4F7lQxHDKM7Z+GVQNdCtBYAGkFZmqHpIPMCMECV90NUeRDPAOx
   3Gy9VlAupOZXHq+gvtaMyQj6hv2o9feNFIbt4OGfhoYCXBXYQgqUXCeRq
   ETJCw25mG2O+o89LCA/KWb86sqMcwD9mgsYJB0hZs/reV4ODAH0afM3Y6
   PhU+x+UOqugagsJnvkIAfUqoU1wejMPLLqk4px80KwcS2rd36q/UByYbs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275403560"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="275403560"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 01:35:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="738412009"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 01 Sep 2022 01:35:17 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 01:35:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 01:35:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 01:35:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 01:35:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtJSZJC1VgzEnKPb9KjFb1UfA6bSJiXNDDcLffve2GJLxJgnmtqs2uU6U8cu9qwjZ41ssU9rUf1q42l3nbeR3MXtoTA0i/u/Wjf+n1rDvuy1c0osJV0qIvba0qKg0jhUoQMKqHqBxdv69lNo/B3iwQ0K48lDfsadMyDxzzZ2MYx8eICLDEIxREPfllMgFTyZ2WuY4Sx7NpbiTwWOBTeJdI5JF0YDdH8XZoa1m1WH/VaVZl8acB4p2mqppINfmWbXlR670/SIUwSvyz5y3+wbli6HTfjrVok5avPu4T319N04U+8/WmM/cRU9hWqeqA7MZ395w8+Ranjl7hXr4i6yMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILaG0D55jjS+BiAPddZ2vM3YZKS+N9DdoJqQnYyCOX0=;
 b=cPZeYKspi2NG/6kVyQ1XBb4FD6+/mD/rtzH9WYC4/F8YWtr842x4YkzySq7BZ60MeuN6chgY5vSXtsW5LbT7ntu1taDsl5Fz1CfEgWQodoMyuZsECWmIYsiKKzfmrPs1PsGOqbi0c/vMWCU3GY3d0uoDVFPHnrXJysCcdKnVtj3Uc/ZCg6ztLeaTzENLhkEnR2Fvnzu3gOL50Dsh45C1TTaQXUAFNZMHtChGbbvmpb5Fet+wdmcxPCfa4V2veLWP3azIgx9PIlbJb+S0wY6P83gt5ibWs5Scp4/NmCubekbE7AVNu0se033TcFKdjxgWNq38gy8qd1XpyJ84sfLvoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 1 Sep
 2022 08:35:14 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::d9cb:9341:df01:f8a6]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::d9cb:9341:df01:f8a6%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 08:35:14 +0000
Message-ID: <2d75b9c4-e126-0cc2-dca5-64c6ae9666de@intel.com>
Date:   Thu, 1 Sep 2022 16:35:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [PATCH 1/3] memblock test: Add test to memblock_add() 129th
 region
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
CC:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220830014925.162718-1-shaoqin.huang@intel.com>
 <20220830014925.162718-2-shaoqin.huang@intel.com>
 <YxBnG4xYh/eIJ/ZT@kernel.org>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <YxBnG4xYh/eIJ/ZT@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 028a5061-9ad1-4b5f-8ef9-08da8bf4e405
X-MS-TrafficTypeDiagnostic: CY8PR11MB7058:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7t3V80rHJSuoPs19Y9BAaEQZ8NwWO/Er9HMD1iamJkIJFp6IdQ0IKuOnK2YkGotdGqjAvcrIbCqW0dOsawwZtzbDU9UgRqCJGpASgX+3olBQkQZpRXV9ntwM2zfKP1SXQawGuPyQyBnGiCy2bglxSyHeCLW4kIqcKEMEoZyZID4yqD/R2C5qGFKHk3HJG1TkPcRNWNSu30CUIxCnmxzEzW4fkS5wP3zlcaXPjL3CodTLNl0seHHJLYNZfUDB488BcO5wjevOaXDzfMSK0XpKXufi0dXME3YM1Lyj7gOtoBy5FFsU8XZ5sYnrIguQU3ouUbQn28ZsadZL1RjKz1qBMIq1tEd2P4b7iazhJriXTBvZSHN0P7t6KSLGksvORmlkKMMjHgJLpBQqOHqvUso6i2Am2NqNT4eDpkRZkj7ibZNbK4b6xoiJEKmzPZ0siCE+V6ddu4OLLnNNv2fI2H07z9CbbJ2vC4rlEDz4XhFMVg8IJbm4y6hMSTgw65ub+sq2P7B0EKUxXAr9IKn6dSLzvWB56IcV8HkZ3rOz08T2uDKzvDLxwxeZi6ighhrPSpuOotGuKAV96a2xxWQfJ/yOnI3/Fzo9yoLs8z8hS/IlY714Bx13QvukRYjPePSHyB3grcgvYjdBGompQUjAAVjs9lNHpLeMNDvf8hlpKbrA0wkJCXGUgyJbo/gTAz6ulH7U/RRmJRgUOFGTxJ6YdnS5EQqDVQ5KRxzsO4oY/SRv28WIPf/6PZKBr/eccFe6YJwIysnoahxTi+X+fpN8Bp5JdgFOvteu6oi5K2qyT2N2xM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(346002)(366004)(376002)(478600001)(2906002)(66476007)(4326008)(82960400001)(38100700002)(41300700001)(53546011)(8676002)(8936002)(66946007)(31696002)(66556008)(6666004)(6506007)(86362001)(6512007)(316002)(83380400001)(5660300002)(36756003)(186003)(2616005)(26005)(6916009)(54906003)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZCeXptZXlHRlNDQ25kclZLektuVXIyVG5QMHkyQy82WS9XVnZhV1JJRHVp?=
 =?utf-8?B?c0dBWEZobTNHM2gxL2xzVjJuU1lCRi93U0d0NXZqSzJRODhId0xJbFBQMHp6?=
 =?utf-8?B?ZXJZbWVJdTdhWmtka1JoMkJDSFp5YldjQnV2UzBrNUdQZjc3eGlIakMzN2ZL?=
 =?utf-8?B?SmVkZEtCckYrQWxuQ0R3UUkyTFBxbXJiMzlaYWQzc2N5aXhjdEdBZElxUU1Q?=
 =?utf-8?B?K0NxSmRFMnRtQUh1WlR4SHJYdFpDVStFNEtEaUJkbGhxRUZaWENwMHVmWXFU?=
 =?utf-8?B?UE5PUzBkQzlKVmthYlFzVjZjTjhhbzV2bGFuVEVNemtWUTdJNHNrd0xkR0J0?=
 =?utf-8?B?S1d6dklibFhVOHJHSFNPQ0s4ZVQ3YTBOQmpkaVEzQzJNUmowM2M4RkJjS1pJ?=
 =?utf-8?B?N004QnBsSjVDZkJ1ejRORktSMU12K0cyRXE4SEdjbEwzWEUxZFhIaHk5SDRR?=
 =?utf-8?B?ditpQlFsVHV5ajlYTlFnUzQxYmpoRmN4UWlkZkRDMk9XTm1BdDIvZ1hvMG9U?=
 =?utf-8?B?QzllUFVNR1pCdjNrL2x0OWUzWm5jcFQ1MndJckljNVpoaUpGM3ZzbHJOazls?=
 =?utf-8?B?ME1RT0Z5a0ttZmJzNlJ5VWMzNzdmSzlaaWpHZEdtUC9tM1dqMGNjQ1ZQcUZ0?=
 =?utf-8?B?TDM1ZDY3dVFzTzFhZEozdU9SMlcxODAwZnJ0S0I2eUc5dE8vVHp0Qk1CVHE4?=
 =?utf-8?B?bytsV0JGZjBLTWZkZi9Bb1VSakhBSGdHNVppazlCMGp2Zmo0MUg5VncraUhC?=
 =?utf-8?B?UmlJUERqaU9ySFc0bmQyTTFScXJCT0dTaHdEaXpzZDdkVVkwWVV6cVhWdGU0?=
 =?utf-8?B?VkpCazZKZXZrZnFITXc0ckxRWWJLTEdqcmxid3lUQkhjdUdtUFlZNE5ueU5F?=
 =?utf-8?B?MXRPeW1RNlBKVnNmbUpURTlqSVpOSjdMbEREM2JZUE9zMXdyUE5GdVZoYWFr?=
 =?utf-8?B?cHd5VUdBc25aRER4THIxaXdYVkFVbDZYOEFjTTFvWS9oNE9aOVVUMmc5aENs?=
 =?utf-8?B?ZCtyN1dzYlZablBwQ1FWaDJ5Z2x6bitDdHl1Z0ZuMWViU2hJbFhreWxkcjla?=
 =?utf-8?B?VGRVOHNDMk1aNm9HYnJKZlVPanE5MEVNNHhwejRTYk9zVmlML2F1S3RLT2Vu?=
 =?utf-8?B?TEpGcDVtMndSWUdmemFkd3FEaWtjOG9LaUpUelhVbzU2R0tVWmR5RDdkbTdK?=
 =?utf-8?B?YytZeGRhdzhxZlArTVljcDlzdkdjYnRQVFN3YkxYOWM5eWRLS29LSy9mbEV6?=
 =?utf-8?B?Nk5odEdTSG9NdDl4dnYybW9hbFRQQVFQak9hZk1ITDlrYnB1VjhlTUxCRDZT?=
 =?utf-8?B?SEpXMDJOTkpodXlTcHdiNzZaYWZ6b202aVBkUlN3bzVTTHRWa1hVa1hZMWI2?=
 =?utf-8?B?eTJjdFlrWW1IZkJvSmtqY3JWa2ZNd0Z3YjBJeVhvblRQM29YZzFKY1FBWDdZ?=
 =?utf-8?B?eXJvM0NuaDJJUTdPczYrelNNODl5Q0JnQzlsTGhrVDhRVlN3azduUVQyanBN?=
 =?utf-8?B?eDEray9EK0s4V0VsOURRWkJveVZNOW9lVzYyUkxBVFlKbEovVGVpa05iVElL?=
 =?utf-8?B?MDRJa1BvcWFmYWxkemROem1ldXpvYkVYTTBYRWdkdngzajdmMVY2UXFER3Ju?=
 =?utf-8?B?RVNxOTd1cVJmcTNhVGxIcXlDOWtRTWNZMEpTYWlLeHdJNC9Fa3BxWE82ZmV5?=
 =?utf-8?B?NkFiK3ozUFV4Z0xyeUZ0VGo4cVY1bzF6Vnh2bmJvcjFGQVM5M0EyWnpoblpt?=
 =?utf-8?B?RVkzbXpRLzhxaXpCeXJyYW52SGN0aDZhU2hXVGlybWd1ZkFyMDR3dENvd3pS?=
 =?utf-8?B?VlJibVRjZUJRKy9GSGxTT2NyQnRxUklBU3hhY0oyb1Q0TDYwV0lTdSs4MWQy?=
 =?utf-8?B?LzZ5SnVZa3ZoVmZJamU5ajBZZWxZTVo0eXhNT3F2dHJJakdKVlVXTnZ6ZE9V?=
 =?utf-8?B?Y3lMODMvc24xSWI2SHlHdUxyS3EzVy80bkNoMnd4aW5iTzJxbWo3T1RmaHcv?=
 =?utf-8?B?M0tUc0VHd0F0VU0yc3RQdGxTYk05bml1NmZqVjhKcDkvMXJXbmQ3K0haRE5N?=
 =?utf-8?B?NlFyVDcwVVU1Zk5lSVdQQ0xFRXRXYm9iN0VxR01BKzJVYnRZa0FKUlpjYlk4?=
 =?utf-8?B?TEN3MThpRytWVS9vTEtnb1B4cTZaWWY4VEZ0Q3NHcHE3QUJ2V1FsRm04OFYv?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 028a5061-9ad1-4b5f-8ef9-08da8bf4e405
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 08:35:14.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTB6KZi/w2ZLF114nd2Rff/TOW+dYSLywRqh2f+oUnqEj8ZDaa4XIfrB2sTG0yJm7iPvDFyhLHpzW3xfiu1r7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
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



On 9/1/2022 4:02 PM, Mike Rapoport wrote:
> On Tue, Aug 30, 2022 at 09:49:17AM +0800, shaoqin.huang@intel.com wrote:
>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>
>> Add 129th region into the memblock, and this will trigger the
>> memblock_double_array() function, this needs valid memory regions. So
>> using dummy_physical_memory_init() to allocate a valid memory region, and
>> fake the other memory region, so it make sure the memblock_double_array()
>> will always choose the valid memory region that is allocated by the
>> dummy_physical_memory_init(). So memblock_double_array() must success.
>>
>> Another thing should be done is to restore the memory.regions after
>> memblock_double_array(), due to now the memory.regions is pointing to a
>> memory region allocated by dummy_physical_memory_init(). And it will
>> affect the subsequent tests if we don't restore the memory region. So
>> simply record the origin region, and restore it after the test.
>>
>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>> ---
>>   tools/testing/memblock/tests/basic_api.c | 82 ++++++++++++++++++++++++
>>   tools/testing/memblock/tests/common.c    |  7 +-
>>   tools/testing/memblock/tests/common.h    |  3 +
>>   3 files changed, 90 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
>> index 66f46f261e66..c8e201156cdc 100644
>> --- a/tools/testing/memblock/tests/basic_api.c
>> +++ b/tools/testing/memblock/tests/basic_api.c
>> @@ -326,6 +326,87 @@ static int memblock_add_twice_check(void)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * A test that tries to add the 129th memory block.
>> + * Expect to trigger memblock_double_array() to double the
>> + * memblock.memory.max, find a new valid memory as
>> + * memory.regions.
>> + */
>> +static int memblock_add_many_check(void)
>> +{
>> +	int i;
>> +	void *orig_region;
>> +	struct region r = {
>> +		.base = SZ_16K,
>> +		.size = MEM_SIZE,
>> +	};
>> +	phys_addr_t memory_base = SZ_128K;
>> +
>> +	PREFIX_PUSH();
>> +
>> +	reset_memblock_regions();
>> +	memblock_allow_resize();
>> +
>> +	/*
>> +	 * Add one valid memory region, this will be choosed to be the memory
>> +	 * that new memory.regions occupied.
>> +	 */
>> +	dummy_physical_memory_init();
>> +	memblock_add((phys_addr_t)get_memory_block_base(), MEM_SIZE);
>> +
>> +	ASSERT_EQ(memblock.memory.cnt, 1);
>> +	ASSERT_EQ(memblock.memory.total_size, MEM_SIZE);
>> +
>> +	for (i = 1; i < INIT_MEMBLOCK_REGIONS; i++) {
>> +		/* Add some fakes memory region to fulfill the memblock. */
>> +		memblock_add(memory_base, MEM_SIZE);
> 
> I would rather prefer to memblock_add() ranges from the simulated memory
> created in dummy_physical_memory_init(). 16K will be probably too small,
> but I don't see problem with increasing MEM_SIZE.
> 

Yes. If we memblock_add() the memory both allocated from 
dummy_physical_memory_init(), It's no need to fake these memory regions. 
And with all valid memory region, it will always choose a valid memory 
region and double the array.

And now with calculation, 16K is enough. The doubled array will only use 
8KB, so it will success.

>> +
>> +		ASSERT_EQ(memblock.memory.cnt, i + 1);
>> +		ASSERT_EQ(memblock.memory.total_size, (i + 1) * MEM_SIZE);
>> +
>> +		/* Keep the gap so these memory region will not be merged. */
>> +		memory_base += MEM_SIZE * 2;
>> +	}
>> +
>> +	orig_region = memblock.memory.regions;
>> +
>> +	/* This adds the 129 memory_region, and makes it double array. */
>> +	memblock_add((phys_addr_t)memory_base, MEM_SIZE);
> 
> memory_base is already phys_addr_t, isn't it?
> 

Thanks for notice. Will delete it.

>> +
>> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 1);
>> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE);
>> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	ASSERT_EQ(memblock.reserved.cnt, 1);
>> +	/* This is the size used by new memory.regions. Check it. */
>> +	ASSERT_EQ(memblock.reserved.total_size, PAGE_ALIGN(INIT_MEMBLOCK_REGIONS * 2 *
>> +						sizeof(struct memblock_region)));
>> +
> 
> Can you please elaborate what does the following sequence test?
> 

Before this line, all checks is to make sure the double_array have 
successfully make the size doubled and reserved a new region as the new 
memory.regions.

Below I try to add a memory region which has a small base, so it will be 
added to the first region, if it succeed. We can prove the doubled 
memory.regions has a valid memory.

I will add the commends in the next version.

>> +	/* The base is very small, so it should be insert to the first region. */
>> +	memblock_add(r.base, r.size);
>> +	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
>> +	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
>> +
>> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
>> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
>> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	dummy_physical_memory_cleanup();
>> +
>> +	/*
>> +	 * The current memory.regions is occupying a range of memory that
>> +	 * allocated from dummy_physical_memory_init(). After free the memory,
>> +	 * we must not use it. So restore the origin memory region to make sure
>> +	 * the tests can run as normal and not affected by the double array.
>> +	 */
>> +	memblock.memory.regions = orig_region;
>> +	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
>> +
>> +	test_pass_pop();
>> +
>> +	return 0;
>> +}
>> +
>>   static int memblock_add_checks(void)
>>   {
>>   	prefix_reset();
>> @@ -339,6 +420,7 @@ static int memblock_add_checks(void)
>>   	memblock_add_overlap_bottom_check();
>>   	memblock_add_within_check();
>>   	memblock_add_twice_check();
>> +	memblock_add_many_check();
>>   
>>   	prefix_pop();
>>   
>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
>> index 76a8ad818f3a..96fabd96ff31 100644
>> --- a/tools/testing/memblock/tests/common.c
>> +++ b/tools/testing/memblock/tests/common.c
>> @@ -5,8 +5,6 @@
>>   #include <linux/memory_hotplug.h>
>>   #include <linux/build_bug.h>
>>   
>> -#define INIT_MEMBLOCK_REGIONS			128
>> -#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>   #define PREFIXES_MAX				15
>>   #define DELIM					": "
>>   
>> @@ -77,6 +75,11 @@ void dummy_physical_memory_cleanup(void)
>>   	free(memory_block.base);
>>   }
>>   
>> +void *get_memory_block_base(void)
>> +{
>> +	return memory_block.base;
>> +}
>> +
>>   static void usage(const char *prog)
>>   {
>>   	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
>> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
>> index d396e5423a8e..d56af621c543 100644
>> --- a/tools/testing/memblock/tests/common.h
>> +++ b/tools/testing/memblock/tests/common.h
>> @@ -11,6 +11,8 @@
>>   #include <../selftests/kselftest.h>
>>   
>>   #define MEM_SIZE SZ_16K
>> +#define INIT_MEMBLOCK_REGIONS			128
>> +#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>   
>>   /**
>>    * ASSERT_EQ():
>> @@ -73,6 +75,7 @@ void reset_memblock_attributes(void);
>>   void setup_memblock(void);
>>   void dummy_physical_memory_init(void);
>>   void dummy_physical_memory_cleanup(void);
>> +void *get_memory_block_base(void);
> 
> Let's make it
> 
> phys_addr_t dummy_physical_memory_base(void);
> 

Got it.

>>   void parse_args(int argc, char **argv);
>>   
>>   void test_fail(void);
>> -- 
>> 2.34.1
>>
>>
> 
