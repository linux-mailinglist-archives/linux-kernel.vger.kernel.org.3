Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEED582382
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiG0Jyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiG0Jyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:54:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009801B797
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658915683; x=1690451683;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tj9Yo0HEpieZSyZn4HGLpV4IfmM9FBcG3JV0j2ruLs0=;
  b=OjJ5z1y4TamUTU7dNTriQJdBsns4UP2poDM57rE1yCyTynnLxYXDLPLY
   w25PWukk8H2wNIuVPpGBCkQSQHVZaBcRUHPawm1K3k4oc8majLkW1UTVR
   RDG9c8qPiJcRCFmSYdFywk7+KGqN4249LifD7kg+cpnDzBb3Rc9+xlueo
   mtKCjYlQZ7IUH2o/TP+57cQqqT64OcXPAcPO5YMc9jMOKnfl9SkZ4VWQH
   8rpxY34UTI0dg884UBBjBRn1sskDqKxjASKvDhHIwGyhESd0rOpfvmQbm
   yp5IFyYjnCwxlmFU0pEAW8mJ0Jf8qLdqrBTXz8YuVF2OzXzfA/JDK9A1h
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="288203661"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="288203661"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 02:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="659126074"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jul 2022 02:54:43 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 02:54:43 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 02:54:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 02:54:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 02:54:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQFecFWyxoDNmVc0vzTcJUTWKXb/HV+G3TIXqALwTRkrT58oj2WfTz9DPRvrLxwx5ewZIhioizHP6qQ6YnvkExDa1v6/vlu4imgJe78yhnWwrjfwI4jU31v6oqAeRhtUwsNVyvaIqGEpG8kPMX9ihBwVUzEsvaS/zjLM21Gp3Oe6DMrqTGudWVVzcg4Ua21tQTd13woq3SOzRFkQfc7FIhZXASI41vgqWq9z8XQiSo3ed2aL3D900pdU+QcAdwVJQQkCY7oc+AKCNK790risEkkVhYEyOXeUxoOJtvl7+aXQPrz/mfntDBxXK1vPzaWDrMGUmnGMl48SXeRFIgElnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YeIO/1dQ4JeFLYV9vqgKaOiulYyi0queqxmeA/nRuQ=;
 b=e5/OLK+kEyPf1nRAX1x0SfiBwde3+cqO2oR8HVenmY/HR7aSGjsp+gguqxy5YlwYZUuytlt1lEHnrDFIkCgMuIZrN7C1YlkfP3u3z+Ircig4c0Dsupm0wA0ou/iaqMw2uE2msLsN0zWiVeyfKCf2cgd+u3fxFpBotAZnSy2SRpHea71yA9VMKsx1T2m5xOEF6KSVZWS1s3C1w68p5eI4omp+BssgDjzo44eNgfiGjoapRnrioQ1L5O3//O+dUygBAL+sWfD4UAuIecc4ATAI0B24SSPx67HMRWxBaeZHthh3+X73mjL+ZLFa8UJaRC8WhK/bDNzsEcIwYy3ZnmcIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 09:54:35 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::dd55:c9f5:fbc7:8a74]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::dd55:c9f5:fbc7:8a74%3]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 09:54:35 +0000
Message-ID: <24026aa6-24fd-22e9-75d9-b095499e4ce5@intel.com>
Date:   Wed, 27 Jul 2022 17:54:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] memblock test: Modify the obsolete description in README
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>
References: <20220728001615.19099-1-shaoqin.huang@intel.com>
 <YuEIKdxSJcuLia15@kernel.org>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <YuEIKdxSJcuLia15@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5d9fc7c-07f2-4bc7-c613-08da6fb602c4
X-MS-TrafficTypeDiagnostic: MWHPR11MB1696:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpcQH/VThl1sIdEC5efzq+Tnh+LybIoB5aprGqzRiuApIhRfQwOQKLt0M9Ia99E72NacWwZKKDUvB/quTb8ltOugwZW+gpwMxbbjngHNA31e+R6rOsecVPSowAEG15m/OYMce6AX+j5xrB5XAv9ZaEM1RuNQZ0/ItHQ9uQsnewiDn6jPfZ7bJAgKHO7oRhjrNb/pDQoABOcPB4n5ZeXwjn5oef108/QtCZzfYXzApsYFgeAqPMOlTSkDXZKsd4C5cgSGJWcIB2BkgyL4nmc3N5A+1Vrvb9wdJsn7KkS2qWVPIYe93pXBoxmyW1v6NiZnGTplBSn7Ns8wg86/3FHYAsgDNprAbiNpuWm1Iaomebyr3zM6yWXNw/9T1+Z6MWgqvGlaFaTVlP5b77fyn7cjcLBqNAnHpZZcyZiDoHLfG3ucJsc9tlTJXnmyXrrm4qZG+dWW1QjRkCgQQ6JbPLSc7NmGhy188MmpFbeuXuKZnFiOhnH5HSQDSHAtdrWUNZCVW0z1nncekVwhnR9pw9qLJZJseO5Y7LWrv1tLX3kBp7vPIacHbsUu46/UFhZb/IhQl3BfAaXq4baa5iS575BdONvIsk/VSRjhO9rBGBSFd6+A68+vqcD3mA5/fB+8NLMbMz2krByTKSStnO1GD0E4vxfsjkhwyXUzfNlBiJeq9NkXpm4866mgBPWs1skHi1UCYeZCiMF+sfRlqTnPC5lFctkRAnc03IVNCaQFyjy/evGKBKXZ/MHkfNxc/CWq4GbI60od7CPd3UMmm23OGyxz5g9NGmRanRvLJzvwiO+LNNOzsmXhfR+q4I/N41WxdMal7KWLsfR9Y1xrUbtOiF9RUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(396003)(366004)(136003)(6512007)(26005)(478600001)(83380400001)(31686004)(6486002)(186003)(5660300002)(82960400001)(36756003)(8936002)(6916009)(86362001)(6506007)(53546011)(2616005)(54906003)(2906002)(31696002)(66946007)(38100700002)(66476007)(66556008)(316002)(41300700001)(6666004)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUN3T084V1AxeXlsQ1pnNFBxZDJ1RENLOVN2YnRtc3J6a3hkd2l4eHVsa3ZW?=
 =?utf-8?B?cHZqRHdyakg1ekVjTU1IY21DWFlTb0hhZm41MjFZSWh5aVNVQUtvRHp3eHB1?=
 =?utf-8?B?bGpjbU83WXlVbFRSdnNIbDE0ZTIydXhGN0lLVnIvYUdCTFQ2aVY3T08vajJC?=
 =?utf-8?B?MnFMaFhjbTJRQ2M4dzNFaVAyUmgzQitGWlBjVk9PMTVhOGxUcVR0aFMrTENu?=
 =?utf-8?B?SXg3VjRSYjNZbjdyam9CN2QwOXpodEQyYW9IYkFVOFkweXU0VUVORnkva2FF?=
 =?utf-8?B?YzRIRktCNVVwOEJuMVVKRXlDMDBLQVFIMTZsMTZWWmhSNlVQbXNFbnFjbDVU?=
 =?utf-8?B?dkEyU2pMaFYzZzBpSjdnSitpLzZhZE8vT051dEJ4ZDI5YVQreEFNNHJ0V3NP?=
 =?utf-8?B?T2h2d2NsZWNXcDcwRzlBYStCN0tuczNzdm5nL1p4cXNyRFIzNHdEcFZJUmJH?=
 =?utf-8?B?cmUvVGl4M05SRHBoOGFXMCs5a3NrWGNBS05ZSkYzWVZLZC9TMytaWHpCbVoy?=
 =?utf-8?B?dkF2a1ZlQVNMM0ZzMHlSUnNReXlKMjNjL292OVdqYlN3RTRUUkdpMjlmZHdn?=
 =?utf-8?B?NG9ZLzZBNVFVZjZER0l5VjhWMmhFUUdRRVBjdDBOa2FBL2xqN0t6bnZkZG5J?=
 =?utf-8?B?Ni9jMDhQUTVCTW5aNVFSRFphWnRlTkk1bG5odHRVajhRcFplaS9NMUh2WXgz?=
 =?utf-8?B?ejYyV1htclFIWFhudVd4bk56R0I4Ti9wVG5GeksxWG1qM05Tc2V6dGhnNldO?=
 =?utf-8?B?cHJYcWNTLzk3eXpWYjY4NDV4UDZiOUJLN2M1MWwrdWFFYWdyTUh0RGt6L082?=
 =?utf-8?B?aXY2UEMwSGdFbmttczAxU2dzYzBHamNTT0VTY1RiT2FtcnQyZkE2TVk5SVRX?=
 =?utf-8?B?T1gvQVpXVTg1OWNsdkE3ZWxOSHVyUTJZQW1NZlBZZ0JTWkkyc1BIK0V3dTY1?=
 =?utf-8?B?ZjRoTkVhZFFaWDFpeVpxUm4rVExMYko0NWZlSkt3T215bFFHVFNaL1VldVRX?=
 =?utf-8?B?dXF1d0FPT25hOHcxNnZYcjJsQWlvdXg4MUxlVGhiUlVxN3FEMDlEdHArcS80?=
 =?utf-8?B?N1ZVdm1USi8rSGxTbFI2S1Rhb2grc24yR1d6SngwRWRGOUVqNGNXeVpoNS9m?=
 =?utf-8?B?RWRlOGpWU1VIMWdZNEo4dk03b3N5VzlIWDRUM00yM3RSWEl0d2xNbkM3TEdu?=
 =?utf-8?B?MVFETDV0MDVQdDBieVBPZVhOSEEzSW9zL0FNQm5yMUc3RWVQbWRGYW9HcFBs?=
 =?utf-8?B?aGFwN2pTdTVmL1BrTzVJK2M4VnR3MkRVWWxLWnNpcGRud00xWjE0K3Zna2t5?=
 =?utf-8?B?U2taRUZlT0wzdmdEMkRyZjdVTlZsa1hIbW94QzdGa2FDb0lQcFllZS9Ebzhk?=
 =?utf-8?B?UUtRVElnUHErZjFpS0dhUTdSc0RWODZ4SU52dE9DSDZqQ3Z3Z2JkSWlvSDdw?=
 =?utf-8?B?c0s4MHBUQTNPMjU3T21SbnBmM3BLSE8yR0pUOVBrckN4NFkrYVZiay9jYjRw?=
 =?utf-8?B?RVVFV3FSZ2xsWTZKLzcxN2U1cXVDanFDQlJlMWp6eWJPbHZZQ0tGWUIwUjkw?=
 =?utf-8?B?S0xESkRtZnhmS1JUSS9zU21FLzlYUTBHR1pkZXVzZlpzdEZ0RWx2aHcyZGdR?=
 =?utf-8?B?b3A4ak5oUFFKeXg0NE9mUTVNTGMwWlM2ekVYc0ErUjRFblN5V1VqRktmWUUv?=
 =?utf-8?B?WHZCaFZsaWZMRXYzYlkyelhndXovZXhIemJYc0FrbTBuMmpvWFVXSEYxOG5F?=
 =?utf-8?B?SnBDdS9PR1FnbmdCeGx0Q2M5RFZoOXVSaWpvdGJ4T3BhL3dBcm85TWVWbVlB?=
 =?utf-8?B?VlNuZ3FDTVZJTXdrSWlBVUdKQ2NITGtsZU5QSExvZzZhVUlpbi9GbmpQUzRm?=
 =?utf-8?B?QXlOd0htQnBqMVpLMFFOQUR6Zy9zd1YyRXIxdW9yRkpVN2JhTnVTWkpvaUd6?=
 =?utf-8?B?VW52ZjRHZG5HNCs0VHRMdnRmTHQycW81UXAyeUNZSU5VQmlVZUxZMnRLNzVV?=
 =?utf-8?B?Z2hBdnA1QlNsVDVwVVFxVmF1WWpleWxXVWYvM2tYRWFyRDhJSy9lRnZla1Jh?=
 =?utf-8?B?V0JWMUE1alpOeGYyWEE1cFRLdGJhQk1iS0s4ekRvMlFiajNoZmJwaGdoZlVa?=
 =?utf-8?B?OWFINjVWM1JxMGx3L1pFQTcvK0hkYTRCQk80VXlCUHNwdk5vVHVrdjVxa2Nl?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d9fc7c-07f2-4bc7-c613-08da6fb602c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 09:54:35.1433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9eYrxgQbdt5N5mvoMqu9zU9EXMmLdsWd9+29BWHvUdOYii2Xtuz59XVNceLGmMqW/fZ9wjgQzyrJE7crYhp5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1696
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2022 5:40 PM, Mike Rapoport wrote:
> On Wed, Jul 27, 2022 at 06:16:15PM -0600, shaoqin.huang@intel.com wrote:
>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>
>> The VERBOSE option in Makefile has been moved, but there still have the
>> description left in README. For now, we use `-v` options when running
>> memblock test to print information, so also add some description about
>> it.
>>
>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>> ---
>>   tools/testing/memblock/README | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
>> index 058146b528a5..f39cc0aa6b76 100644
>> --- a/tools/testing/memblock/README
>> +++ b/tools/testing/memblock/README
>> @@ -33,20 +33,21 @@ To run the tests, build the main target and run it:
>>   
>>   $ make && ./main
>>   
>> -A successful run produces no output. It is also possible to override different
>> -configuration parameters. For example, to include verbose output, specify the
>> -VERBOSE flag when building the main target:
> 
> The description of VERBOSE build option was a logical continuation of the
> previous sentence.
> 
> Instead of doing mechanical changes, please rearrange the text so it'll
> make sense.
> 

I agree. I will try to give a clear and continuation description.

>> +A successful run produces no output. It it also possible to override different
>> +configuration parameters. For example, to simulate enabled NUMA, use:
>>   
>> -$ make VERBOSE=1
>> +$ make NUMA=1
>>   
>> -This will print information about which functions are being tested and the
>> -number of test cases that passed.
>> +For the full list of options, see `make help`.
>>   
>> -To simulate enabled NUMA, use:
>> +It is also possible to pass options at run time. For example:
>>   
>> -$ make NUMA=1
>> +$ ./main -v
>>   
>> -For the full list of options, see `make help`.
>> +This will print information about which functions are being tested and the
>> +number of test cases that passed.
>> +
>> +For the full list of options, see `./main --help`.
>>   
>>   Project structure
>>   =================
>> -- 
>> 2.30.2
>>
>>
> 
