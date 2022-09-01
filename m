Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585945A9251
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiIAIoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiIAIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:44:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DEC131DFD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662021841; x=1693557841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I6zLMG0suRclxX/McFHt3+JOSMEuKhP/9lY+hvedBoE=;
  b=iur06doSVESKGkIq9ANBoAXTcWksNh1ON9qGGL/eOdDU+n43lXR1zIFi
   QeVlaiEzqmaOYyPcx+VwptfeQv+C5PPCHKXQJbvavv6h4vCB0ssqwuyfM
   45aM3Tbi+aEUDOXTtPypiW8dPtcNMcBgW//QrI3WaO/1aeHnKBXn833Ok
   mL3ZglN82FEPcQNzUqslHILAET61aUuRPCGg6c2IjCNtRDQ/7A+qxvCr1
   00UR2L6p+aONmBhyUeobPXpI8P6yEIxFM3i0V2W39Z6gkpEeBRF+EDo++
   NSPMbrtB63+ck+9ghMIkAilQDoCDxWmRKbvEG3xfWZnjbMWfNngFv1Ipw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275405971"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="275405971"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 01:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="857762858"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2022 01:44:01 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 01:44:01 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 01:44:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 01:44:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 01:44:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG4n43H8f+EAtVdd+ZFZi39bogcTaTOE5Oj5XJShc6aat3k9ysVa8SKDI/vwYc2HtPqjHz6vslHHR5nPF2Y7OQ2xDDWSFkFmZUFwoCWGUTFi9dNAwPMTHquVH7M8s6oBcF7N1jyjQNAc27h3IqQKBaytmbUxE4oypY01b87pnav4chqL4jsM9z8g/xj1llwRpBbO6Do82gX1JWm3OsTkmbMf2DYjoVkaJZnb4dMty2o6yc8CSKwE7JCkyG38fnVvQKrpppJuDCJfaoeawspyvDuWEuFzh2BNzZThfgF4glANifH/SWD/aLB0FannYwvBZ04+w6pZBEAHhQW4xtJ/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xelWTdntFo/Joe0UQfj+ZmruS2uMZYn/zF3faws9fI=;
 b=QL61j4dmnObuUnH3ZTmobSeVFTyHmr3J2C6TN+P3fiB5RVaQ5rjDUzC9f6iUpTKU1JE49Kgl4hvx73n5AI7DNd3fYU8m1DBI3QGupHlwYnwGT6+vkqu8nZkx9+JZ/2LM4fVATVGFEZ8E6ocsEK899+BGf3Uff/L/1ijRTIq/28Pu3XpjZDYK0+v8Ye+3anH6JJV/9m4/hDss3TZcUfXhuQhUQV89NnBOry94muduAw+CjEgDV39Abx5Fy30nhwzkv76i/+C44h4+69xvoerjpmM6UE+ICfHqEBrgm98TW9brCmLuxT8LIecMSAi8V3puOnDvkHUkssaSKy5t5WClgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by MWHPR11MB1918.namprd11.prod.outlook.com (2603:10b6:300:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 08:43:53 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::d9cb:9341:df01:f8a6]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::d9cb:9341:df01:f8a6%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 08:43:52 +0000
Message-ID: <647ac6e1-34e5-07d9-2078-da0dc3c36149@intel.com>
Date:   Thu, 1 Sep 2022 16:43:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [PATCH 2/3] memblock test: Add test to memblock_reserve() 129th
 region
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
CC:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220830014925.162718-1-shaoqin.huang@intel.com>
 <20220830014925.162718-3-shaoqin.huang@intel.com>
 <YxBogSb3qDMoXcrc@kernel.org>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <YxBogSb3qDMoXcrc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf739b4-2ae2-409a-7800-08da8bf618bf
X-MS-TrafficTypeDiagnostic: MWHPR11MB1918:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ch0nWnPEFLiHgTEYB8mUmLDMqTQysK2zAk3WmlUramRftCAyJIymIiuZQgOGVws4Lag91EoP3lg5BZ9GkR+1+DsRKKX/vJGTrtYeV52aROn7H9aykCeHV58Db80Lzf0F8HHnx02HmJbgJSBEnp+uJRJBoKRlLtwQSRRuWVxfAP233pOxWKvGu+xAkSv1pd8SepciLtBFonZBezBOJ24tph0kqoRoFivVypKPNm9V0NcvAagsk8AUbmIgBiOMp75FZNgi1SUTIr7VM59k//zYONtvls52oU63n0u+E5y8LeeQN+WStBfc9nkgbRUbEXTHg6fy2/6lCfuipKkL09+yS3l4yvPH11DoukL1xrAdGpS16i5kAFsHv/8S4yydQGE5bq17zRiLJN44efa2lIsMywl/oZCJXv1sfpJDfVRCLeptbL9Ybp0bK5eU9JpmAlkb89+BGtXnZvneoi6FYYrB8Di6luIrdzhzTSDY8ZURMBm76ljXaFWLhx7IWJGA4XPqII+dCx6wXQSZ+dGoiSL8xoNYeOOMlobFhECKeD+Yckt9pded/32Rvott+6+4LaNuobxAabgKgVsxfxFWS2O3ZfvZ+mmZKrniTvaFP2fJ10uZ7lDJZDib6GC3BlLxdDNtM6htfz26eYYo7BmXcaEniR0nz72uYtuI7GZlExGTOZCC+L6/AKgAdNc42EDjfG0Bk7KMe5k/UvU55HjVe2A8EoQv5TqkrXMV878+tsRLIeoVK39RZwGbVf853EVX4utvWtxc2b7LqEeOwoRvnRi0sPdFrSl2zGddg4KxjaOKgE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(39860400002)(376002)(366004)(2616005)(186003)(83380400001)(6916009)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(54906003)(36756003)(6512007)(26005)(53546011)(31686004)(6506007)(41300700001)(6666004)(2906002)(82960400001)(86362001)(31696002)(478600001)(38100700002)(6486002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVdJTHJvbC9uTThSbk5VZnFNVWVhdEhMRDJ6UW1QaEJJSzdqTWlQbHduMVo4?=
 =?utf-8?B?N2ZybzliVnNDTmowejJKOURzSW96NEhJelMrNXR0Z0MxdGkyenp5ZThLZ0Zq?=
 =?utf-8?B?VkQzU1IrdnVUSnQwK1NYZFhXMlh0VWpqVjlPSFl2bUtiVy9yd1NvakRndEw1?=
 =?utf-8?B?bWRHZmU3NEpwYWE4MjE4WmtPRGFLcEVlcWxyUlJkNnRzanRtcW16aDEvSUkw?=
 =?utf-8?B?R3FqN3h3cnNvUUdWVGJWbjhEUlY2N0VLWkdZUy9XWnQ2MEZVbkF5ZGhjQ3BN?=
 =?utf-8?B?amFRSUZYbWFQdnFpZ2k1SUZBNksvR3Z2ZmVOYjladFdoYmw1KytIUy9zR3Rm?=
 =?utf-8?B?OWZ2N0cvWC8zMFZuQjN1bVZ4YWhnb2xjTzMrWEFOTjk4MkpSYjl3WFhUN0R5?=
 =?utf-8?B?M0FleCtZd1F2ZGFFejdtaXYvMGZHSTMveW1rdmxEQWlGeXllMHcxZW9JODdr?=
 =?utf-8?B?bG8rWCtkcXd4bkUxelI5STFGR0dJMVV4Tml6Z0N0TXZaOE5OMTJ3S3pscEpn?=
 =?utf-8?B?ZnBxWDNwa203MVRheXMxQ0N3WTFYenBXcWk3SUZFc3ZTd0p1aldhMzlIVWx4?=
 =?utf-8?B?VC9oTm1BOWJTQTVtSk8yK0pvd2h3VUlnbUk0VWtsV1VUbUdNbnRzTlVKc2NI?=
 =?utf-8?B?RUJ6U3lUT0tYV3dtcHdYbFgwM2hCZjgzT2p1aml2MFpxZXdIYUZuaHNwK1F6?=
 =?utf-8?B?bWtpbWppNGl1eU5XS3lvMWoxTHN0TzFjL09KTHAra2U5dUdXN3h5a0hzR1pL?=
 =?utf-8?B?K0gyaXpkQVRYMElpbUdlRDN4QVNKUzhVbkduZUFPOGlMOWZya1JqSWQ0U0x0?=
 =?utf-8?B?Q2NRK2xhbEhXQk14aVJvQ204VkRkT0U1RDRiOFRIOTkrMy90T3lKNHFhZEVy?=
 =?utf-8?B?cTROWnlrY0ZZaURxL0RReW93RU1EZFFIblUreXlOb0xYbFh6MkFVRE5MMDlI?=
 =?utf-8?B?SFpEMTJrRklnS1N5Yno1R3BTdS9oSDZGVVduWFFHdk5pc0puQXlpQ3VvRVY5?=
 =?utf-8?B?MW1CUlllQUxnSU53dDhEc2ZWYUV2NWZnS0JXUTR4UUtocUtSMW1mVU9UY2ZH?=
 =?utf-8?B?Q3UyRlZBVXlFZUZoR2RWbWk5ZXlVaSsrejNpU1Q3N3VLLzN6d3VSZExNRGNz?=
 =?utf-8?B?anhid3dpS3NWSk1rdmFqMk5RSmJlYjNnZThuelpJQkhpVEhYQlVZZmNYRTIv?=
 =?utf-8?B?ZGo3ZlM5SEVZeXZScVRBMGtVZGRLSEwzRkpzMXJibUplMHNlWm44bytyZWo1?=
 =?utf-8?B?ZEhjVlErTVNzQllIMVNPd3RrQ1prYWcxb3lXeGpLd2JTaXkySkVZMEFPNDI1?=
 =?utf-8?B?bVBINEJNNlJ5c1BscWxHUEJ3ZlBxK0JOMGF1cDh4ZmR0aldJZElZZEo3ZE5w?=
 =?utf-8?B?b3dFSVRiVFBLWXZtZ2ZKTUJPNkFIVE5pemNHSElnVERPZGdON0Z3dGtKZTlN?=
 =?utf-8?B?Nksza09kRzBCQmM0M0pya2o4NEJoaWdWaFI3dDJaK2VWSDZEdGljWE9iODlQ?=
 =?utf-8?B?b2JHWCtwRHY5Z1pmU3lweHljclFPYUtpT0NRTDJOY1RIRURGRFlQb2ZZSzkw?=
 =?utf-8?B?MkVKVkhmWEh2RC9tMmlZa0RiTnovQlNqaThzRUpMazRIWm1RQi8xR3V4WSsw?=
 =?utf-8?B?WDdxT00rZUIvWnlya0d4bTZmNHlXY2ljSUlLcytMT1AxZEpjRFFBU0NBTTBX?=
 =?utf-8?B?Q3l2azJpcWhPM2M2aU80bWRVWXhZM3hZNHlhMGRxVGV5aUIwbFVpbDZ4dFdF?=
 =?utf-8?B?cXpFWFpENStoVnFudVlIWlNiL05aSkJzZkxSYkM2WllVV3BRemk0eGczK0c0?=
 =?utf-8?B?VTRBSnBXOGs0S29WNnJRQ3R4RFExbFdnaEw4WGJoQWxiUUNsQWpUU3NyRVdH?=
 =?utf-8?B?azg4S1F2OXkxemRJaFozemtoN3JUODdHZnBFbno1eS96V1JTLy95SjhKN01z?=
 =?utf-8?B?ZFVLQzZoMjB4aDQzNHo1eFFCbE9rd2wxeVR3UUtCZWk0YkJtUk8weTBxL1lp?=
 =?utf-8?B?c3N1YVcvcXNlaHhGd2ZWV25xL0YxbnJPdnBnZm52cUpTK0VTU2RrWHlNRENJ?=
 =?utf-8?B?N2JSU0NCTi9IVURXQThKQ0RzRW5tK21RcjNaWEkwWGNQMmpoZU9BVlJWQXQ1?=
 =?utf-8?B?djBqWTlLekdpZnBzUDUrVVhQOEhnMHdvZURmZERiOGxJeUlHRlhFdXJ4M1Jh?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf739b4-2ae2-409a-7800-08da8bf618bf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 08:43:52.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18/PoItwvWR/XnFLTLfKHKvCzr4Ufo5ugtVMjnxYXGpmhR6EkQkUAKanPLk6gYr2uIDIzzQQ5XNAmq3ZozNDOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1918
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



On 9/1/2022 4:08 PM, Mike Rapoport wrote:
> On Tue, Aug 30, 2022 at 09:49:18AM +0800, shaoqin.huang@intel.com wrote:
>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>
>> Reserve 129th region in the memblock, and this will trigger the
>> memblock_double_array() function, this needs valid memory regions. So
>> using dummy_physical_memory_init() to allocate a valid memory region.
>> At the same time, reserve 128 faked memory region, and make sure these
>> reserved region not intersect with the valid memory region. So
>> memblock_double_array() will choose the valid memory region, and it will
>> success.
>>
>> Also need to restore the reserved.regions after memblock_double_array(),
>> to make sure the subsequent tests can run as normal.
>>
>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>> ---
>>   tools/testing/memblock/tests/basic_api.c | 87 ++++++++++++++++++++++++
>>   1 file changed, 87 insertions(+)
>>
>> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
>> index c8e201156cdc..d8defc9866cb 100644
>> --- a/tools/testing/memblock/tests/basic_api.c
>> +++ b/tools/testing/memblock/tests/basic_api.c
>> @@ -686,6 +686,92 @@ static int memblock_reserve_twice_check(void)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * A test that tries to reserve the 129th memory block.
>> + * Expect to trigger memblock_double_array() to double the
>> + * memblock.memory.max, find a new valid memory as
>> + * reserved.regions.
>> + */
>> +static int memblock_reserve_many_check(void)
>> +{
>> +	int i;
>> +	void *orig_region;
>> +	struct region r = {
>> +		.base = SZ_16K,
>> +		.size = MEM_SIZE,
>> +	};
>> +	phys_addr_t memory_base = SZ_128K;
>> +	phys_addr_t new_reserved_regions_size;
>> +
>> +	PREFIX_PUSH();
>> +
>> +	reset_memblock_regions();
>> +	memblock_allow_resize();
>> +
>> +	/* Add a valid memory region used by double_array(). */
>> +	dummy_physical_memory_init();
>> +	memblock_add((phys_addr_t)get_memory_block_base(), MEM_SIZE);
>> +
>> +	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
>> +		/* Reserve some fakes memory region to fulfill the memblock. */
>> +		memblock_reserve(memory_base, MEM_SIZE);
>> +
>> +		ASSERT_EQ(memblock.reserved.cnt, i + 1);
>> +		ASSERT_EQ(memblock.reserved.total_size, (i + 1) * MEM_SIZE);
>> +
>> +		/* Keep the gap so these memory region will not be merged. */
>> +		memory_base += MEM_SIZE * 2;
>> +	}
>> +
>> +	orig_region = memblock.reserved.regions;
>> +
>> +	/* This reserve the 129 memory_region, and makes it double array. */
>> +	memblock_reserve(memory_base, MEM_SIZE);
>> +
>> +	/*
>> +	 * This is the memory region size used by the doubled reserved.regions,
>> +	 * and it has been reserved due to it has been used. The size is used to
>> +	 * calculate the total_size that the memblock.reserved have now.
>> +	 */
>> +	new_reserved_regions_size = PAGE_ALIGN((INIT_MEMBLOCK_REGIONS * 2) *
>> +					sizeof(struct memblock_region));
>> +	/*
>> +	 * The double_array() will find a free memory region as the new
>> +	 * reserved.regions, and the used memory region will be reserved, so
>> +	 * there will be one more region exist in the reserved memblock. And the
>> +	 * one more reserved region's size is new_reserved_regions_size.
>> +	 */
>> +	ASSERT_EQ(memblock.reserved.cnt, INIT_MEMBLOCK_REGIONS + 1 + 1);
> 
>                                                     +2 would be fine ^
> 

Yes. It actually is +2. first +1 is the 129th region, second +1 is the 
reserved region used by double_array().

>> +	ASSERT_EQ(memblock.reserved.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE +
>> +						new_reserved_regions_size);
>> +	ASSERT_EQ(memblock.reserved.max, INIT_MEMBLOCK_REGIONS * 2);
>> +
> 
> Can you please elaborate what does the below sequence check?
> 

After the double_array(), we can reserve more memory region. The below 
is aimed to check it can reserve more. So this reserve a memory region 
with small base which will be put at the first reserved.regions, and I 
checked if it will be reserved ok.

>> +	/* The base is very small, so it should be insert to the first region. */
>> +	memblock_reserve(r.base, r.size);
>> +	ASSERT_EQ(memblock.reserved.regions[0].base, r.base);
>> +	ASSERT_EQ(memblock.reserved.regions[0].size, r.size);
>> +
>> +	ASSERT_EQ(memblock.reserved.cnt, INIT_MEMBLOCK_REGIONS + 2 + 1);
>> +	ASSERT_EQ(memblock.reserved.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE +
>> +						new_reserved_regions_size);
>> +	ASSERT_EQ(memblock.reserved.max, INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	dummy_physical_memory_cleanup();
>> +
>> +	/*
>> +	 * The current reserved.regions is occupying a range of memory that
>> +	 * allocated from dummy_physical_memory_init(). After free the memory,
>> +	 * we must not use it. So restore the origin memory region to make sure
>> +	 * the tests can run as normal and not affected by the double array.
>> +	 */
>> +	memblock.reserved.regions = orig_region;
>> +	memblock.reserved.cnt = INIT_MEMBLOCK_REGIONS;
>> +
>> +	test_pass_pop();
>> +
>> +	return 0;
>> +}
>> +
>>   static int memblock_reserve_checks(void)
>>   {
>>   	prefix_reset();
>> @@ -698,6 +784,7 @@ static int memblock_reserve_checks(void)
>>   	memblock_reserve_overlap_bottom_check();
>>   	memblock_reserve_within_check();
>>   	memblock_reserve_twice_check();
>> +	memblock_reserve_many_check();
>>   
>>   	prefix_pop();
>>   
>> -- 
>> 2.34.1
>>
> 
