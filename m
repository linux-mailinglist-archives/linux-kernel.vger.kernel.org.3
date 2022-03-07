Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC54D0555
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiCGRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiCGRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:37:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAE08F993;
        Mon,  7 Mar 2022 09:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646674609; x=1678210609;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FAeiF86aFFsw5lbkVbv1I3WMogYOfLpO4F3QAEADdMQ=;
  b=PBWi8/cGFF2iCjZvwc92G9ew3TjA67fx71DJo5v7GaH+Qsx+n7xl+Yxp
   1S19+mm/TtJwAH8KhQRW7Nz9/Hjvw5wosv9YoarspKbFFOuNKW25f3sZ0
   B02UvUL0dbR+HrX7NVamH6myepXJ3UJzf2ik/oofR1kqAzhNLk3iJdyXB
   L6cmc3S7VUGofonK+6DAf/1yso2ccC31yiX/+BEsUt4+YqNsvcFMyshXP
   R+vTDRDkVhTQSMsnhFjXChyFjgYTlEecKni1iLZnKnFlEgq+9X8lLo7DL
   /u/5W9Xl9UsSM2VhmbhFsMbvDp9YWlcKlHaxzcdbuWPEBZO9bM6qYLxuu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254183053"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254183053"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 09:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="512766543"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2022 09:36:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 09:36:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 09:36:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 09:36:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 09:36:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6pklb/BwueSkK4ZSUJOkwnn9XkAJoPMYdtY5sg/NYXWjhEBouy4D4Zxh13QuaMzwnCuPvvvSgHhHGnad81vkA0r235eurJPPzLdiK7U9PlEI1PdFXjliFibRarBxBhyxL2jxlzxE1XnpFPYP7EPSzSrQbi9AGwwZB9YE9wxNlNh4eLPdGUj0pM52wKqK5j4gO1OIJe0EgJQchLQqGQCYfWgKgKz/94H9hAVZOTqkcSGtVDNTWDkA1DF2adlt+DsONyPMlaThlPXfkvG1ak6xO/TMIpyr2SwVUDoGY9sAH/SL/HFloJ/ukwrrDV7o/p11BHYg/VHv/Ws5YV7tikAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJYewIX2ZkBKCGDU78w51leyy1GzjwRUOw3DDzkom4M=;
 b=h1K0CBgvPjDdMv9S63Lwta329KI/NxbsXMSDbyQQaFVk8R0mu5N3gTwm13a3MnjD1PvQipaS5jI63FXMyaqtPSq+rGSTjDBev3r85vmOwhlT6s9UzbQbALkRM97O5lBfvRpACVWd+RxQ8JI+ZhOcE+n+kJAoqoQZCoAchIHQE9X8qbP/pRRzZ7Um4qEfHjM9HpJH3aSOR15Zb8cSpzxpipUBRGYDTxWbfLDpWrterQ/gCJQP8+4WYLXXnvZDi0KxVHLkyrDJuFazSjH5MtHN4ASfTlzoOZQmmTRDI/iSZh/BSLHk8FkoROCKdUTd7mLGMd5RjOyjMFoE4zmr+jVb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 17:36:44 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 17:36:44 +0000
Message-ID: <774e906c-53fc-279c-1fb7-0922557a9da5@intel.com>
Date:   Mon, 7 Mar 2022 09:36:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 06/32] x86/sgx: Support VMA permissions more relaxed
 than enclave permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <0555a4b4a5e8879eb8f879ab3d9908302000f11c.1644274683.git.reinette.chatre@intel.com>
 <YiY8bD/QcmcHH8dz@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YiY8bD/QcmcHH8dz@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:300:6c::32) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00342739-7440-4158-79d7-08da00610bf9
X-MS-TrafficTypeDiagnostic: BL1PR11MB5224:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL1PR11MB522420BDEE1F0A9CC163E2FAF8089@BL1PR11MB5224.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pel0MM3ysc3339bll7UEhONXr+3HKpT77uRpasnfAklpUEXANkQqq5nRA6+WANWbODl629meH6WdsSuvM9TIvT0TDb/hk9r/8i88Dx5qy7AaUcqyw2Hv1CWLW8ddK+c/RX7P7WQsC2RZUCy1QuR847M919VmvZndn1ww8OOfRJpSWj9r2x8b+rmiTOt8bt25BcRDAYfcMDUNy1qnvwdzfDbH/Gers7O0deCKdIhgxp/ZpeQaf3F4spEPZebVBG18K5IRlWdNPDy5/ovKY9xTbbNTBAVDEHrRU+KgbETxCgXckopN5QfCPqZ5d0LRJ/CMWriNenfdsNnEVzLo6fqd3jfNHlS7tIuq6qlN1WOy6tuJGFhQIvDhXf7eYGiqJHFLhh5qfRYmkdcAmt5dbFH3jzmby0D17bkJ0A2ngkMuSTqhnnyI9S+ZXbfRvLGqzxo1YuBnzqEvtz5/z3JBpZ/75HJriwLjvLtjGMjvjp2EAgf2Zk4PcR5V3Ux5E49/Aql6nH0sHcNLw4sZ3YLysGg3PIgrPqrg1zTfCXuEz5IrumgdPz4MtHNSNfV/ulUoTaU2Eu6475JQA+zaqJ1GaJiBejcTBLoUeHjVbA4k4a2RwEp4b5X+tzrkpThlZZzjIJpsZh/YAS2hD78hWDgN+3lMiBinCwSuosXg1AIDtl55jvJI7lomukVd3by2/cJqvOMOb+395+AGl7bUVRvyhQfHafMc0CHPpwW8M+G7qAad0Vkgu7K6YalO3kE5OPkeEIYbeagXAFpA/Jn26i4eCf0hGiynkNr7efWYD7eFGtW613afxD+KH00MwGcVvHipbc5A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(7416002)(508600001)(6506007)(53546011)(8936002)(66556008)(66946007)(30864003)(5660300002)(86362001)(6666004)(6486002)(2906002)(6512007)(186003)(26005)(8676002)(4326008)(66476007)(31696002)(2616005)(38100700002)(82960400001)(966005)(31686004)(316002)(36756003)(6916009)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3RuU0FPR2FXOXdyOWl1RmJDWXYrbkJwYkI0U2QzcHVLcmZVMWxRSTBBTnpB?=
 =?utf-8?B?ckhMK0tjMlNtSUk0YW5NTWpkNUs3TjJpRU95UzNjc1p5OWRxWG4rZzBmUCtP?=
 =?utf-8?B?UlpaYnZjODhwWXE5bTR6Qzk4N3VWQ2JYak9JWDRHTVh0ZFB4bVRIV0VhR2x3?=
 =?utf-8?B?UVZKV255d25tanRadTJIaW5XV0dkeHRGb29pV0U2TThqTVNXTE9EV3dvZHA3?=
 =?utf-8?B?WEVrMVd0cjR5R3Q2NHlIenp0UWNrRkJybWZ4bHVpL25UL0g0VWpNYitYMFQ2?=
 =?utf-8?B?Tzd6eUxmeG1RcjUxSCtOVmxIak1qSnNPVGJYeXF2clp4ZXBRUGtweDNrMDZB?=
 =?utf-8?B?Y1FhZ1FXQUMxdEVUano3NzE0YzUyb1owMkhTdTRnVVo1NDZSSGJQdStwRkdJ?=
 =?utf-8?B?ZXp2QVlQTU5zOXkvaEo3M3FWdWtpTTNSU1pJYTF4MlljNmFsZ3ZMM0FUcU9M?=
 =?utf-8?B?alRXTjZHWFh2K1FQY2dKcCt6SlNSUnM3RklEa0F2b004YXRJZHJaTk1la3FU?=
 =?utf-8?B?YnJubVJ6amE2SENmR293TmZCYmVRTldyNEloOEo0Y1pNeU1zb1pPMXpzSVRK?=
 =?utf-8?B?T1lveklINFVlSU9KSzVESmdkenE0akk2UGJydnlyekdRVnptOWRhQ255dlBJ?=
 =?utf-8?B?TmVtQnpGMlk2Wk5HVXovQVVkQlNtYUNCc3MzSE5jam1Va3Z5cVFuUXdvOEN3?=
 =?utf-8?B?aVg0Si9renZ3dkJLaWlhNUZucjlpMGFuZ2h1eHJjQ2Ura0ZnekJwR3RJN0J0?=
 =?utf-8?B?NnBFUmJ2WXpUTU5CREtpblRseDNOTElqQW1LcUQyazRhV0ZHbzY1dmlCeWMz?=
 =?utf-8?B?eU5wMnBpT1BiV0E3aG5wVTBXM3lxOWw1a3BIOC9aR2l4Qm0zTXJvMWVOWEll?=
 =?utf-8?B?WUlveGNtSzhhSi9lR05XS3cyWGJtTVNucWY2dE43V2FDNENwaVV1OG4wQ3VY?=
 =?utf-8?B?Qy82ZDJ0TzIyUERNN1ZvcjFLbXAyNUFocDBPc2MvSndPS0E1VjY3ZUk4TThI?=
 =?utf-8?B?VDUyQ3UwYmZIZXpsUERwNHN1MHNteFkrWlljMlJLUkJaZnZqcGlHMWpuOVg3?=
 =?utf-8?B?STdGOG9lbHdBVk9mc2FVUE8xYTFIN2Z6Y3JwSTZqMUg5dkhGb2t2RmE0WXBy?=
 =?utf-8?B?ekVrenpJZU5ncGpFWWV0ZGtJRk81bmNxK055cTlhMmlnNUFjU3NIUzcxNDNm?=
 =?utf-8?B?N0xxRWx1MjgzZzVDTmdqcnBRMzVHS3F4cDdnR3JiRFRSU3FSYmV4bmRPUU8r?=
 =?utf-8?B?L0dGQnZaRzhtUC9lMmcwV1pEYk56c082cm96bEtMUGFHVTl5SGN1V05CWXU0?=
 =?utf-8?B?a2d4VGg0czA0UkIyZUt6ZzNQbUdvRlB2akFLQTJhTEdudVhrRkJuMXRCUnJt?=
 =?utf-8?B?MlV6Y1lVMmtqSFF3SGZsWER1MjFHNHhDSHN1MHpTUENXcUE2ZWNnT3ExVmtR?=
 =?utf-8?B?N0F3UDdtdzRiRkh6RXNTOWppUjAyYTJ2c1BUb1dzZ0xSdldHVWxvcUJwRUZY?=
 =?utf-8?B?SXZCenRrZUhib0dpODRWc1RHSWNGdThyNUVjVXlmbEU3U0RzYnJiM3ZLVThB?=
 =?utf-8?B?OHZKS1RCL3ZrVWQ0SXlteXJ5aGdFOWxjMVlmUUdJUlA2c2IvMU9FTXJjT25G?=
 =?utf-8?B?WGphNXJ2MWlVbm5IOCttNDRxZHNZa21nTEVFdWhwVU9ZOXoxQjBFTkJtblVj?=
 =?utf-8?B?bmNPS3ppeXdGdDRoQThia3VXMHladnIrTDdLVjhYRGcxY3lyMkFWOEdoZHVI?=
 =?utf-8?B?MFNYeGtFVDh2NXo4bURlTnBaaU4zVFVwaURDMUJiVUFrUUZuQm4xZmVtM2xm?=
 =?utf-8?B?Q0dMdGxjTzdTZWoreENTbkQvV05kOHJNOWovL0lob0VneVczV0dYU3pJdGZs?=
 =?utf-8?B?TngwVkl6enRoTkU5MHQxK2JuVHhnd1A0UStBZHFkSVAwaG1EcXJHMENUN1Js?=
 =?utf-8?B?aGFDQVFXMERkMkNFbGt6MEY0MXRDYSs5TElDNHZUc3I5TlpGVnd3NXBqUm9n?=
 =?utf-8?B?VFcxTlUyeW80VTF6bGNoelVrODh2T2ZjZ1QrZzNlVTM4RmRQRlZJYTByVE54?=
 =?utf-8?B?bXRubGlseWozSzgrL2RYL0hoV293VGkwUXgvbGpqdmd4NDh5M2xTRWM3S25H?=
 =?utf-8?B?ZHVSeFVqZHBNcXNJMHo2SVhzWmpPR3VKZEphM3oxUlhUc05sQ0JxNVY1dXo5?=
 =?utf-8?B?RGlEL2JzbGNzMFJkOXdRaUx5MUlNVHNsbUJSNW5aNjZjZG9KOGpLTGJzTXFn?=
 =?utf-8?Q?xF9ciODb9bvJvB6iReojOzDOIBzKzdaka0geAyeBAo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00342739-7440-4158-79d7-08da00610bf9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 17:36:44.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rI8Qrk6bjJbnLInDf4hZ5pxclmeBwN3RYTm8pSnB51Zj3BeD20qMhAN3c/M4+hI70M4i6ry9j6ay/CnVEERs7Tar76h4/cTIg77a5R50JH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/7/2022 9:10 AM, Jarkko Sakkinen wrote:
> On Mon, Feb 07, 2022 at 04:45:28PM -0800, Reinette Chatre wrote:
>> === Summary ===
>>
>> An SGX VMA can only be created if its permissions are the same or
>> weaker than the Enclave Page Cache Map (EPCM) permissions. After VMA
>> creation this same rule is again enforced by the page fault handler:
>> faulted enclave pages are required to have equal or more relaxed
>> EPCM permissions than the VMA permissions.
>>
>> On SGX1 systems the additional enforcement in the page fault handler
>> is redundant and on SGX2 systems it incorrectly prevents access.
>> On SGX1 systems it is unnecessary to repeat the enforcement of the
>> permission rule. The rule used during original VMA creation will
>> ensure that any access attempt will use correct permissions.
>> With SGX2 the EPCM permissions of a page can change after VMA
>> creation resulting in the VMA permissions potentially being more
>> relaxed than the EPCM permissions and the page fault handler
>> incorrectly blocking valid access attempts.
>>
>> Enable the VMA's pages to remain accessible while ensuring that
>> the PTEs are installed to match the EPCM permissions but not be
>> more relaxed than the VMA permissions.
>>
>> === Full Changelog ===
>>
>> An SGX enclave is an area of memory where parts of an application
>> can reside. First an enclave is created and loaded (from
>> non-enclave memory) with the code and data of an application,
>> then user space can map (mmap()) the enclave memory to
>> be able to enter the enclave at its defined entry points for
>> execution within it.
>>
>> The hardware maintains a secure structure, the Enclave Page Cache Map
>> (EPCM), that tracks the contents of the enclave. Of interest here is
>> its tracking of the enclave page permissions. When a page is loaded
>> into the enclave its permissions are specified and recorded in the
>> EPCM. In parallel the kernel maintains permissions within the
>> page table entries (PTEs) and the rule is that PTE permissions
>> are not allowed to be more relaxed than the EPCM permissions.
>>
>> A new mapping (mmap()) of enclave memory can only succeed if the
>> mapping has the same or weaker permissions than the permissions that
>> were vetted during enclave creation. This is enforced by
>> sgx_encl_may_map() that is called on the mmap() as well as mprotect()
>> paths. This rule remains.
>>
>> One feature of SGX2 is to support the modification of EPCM permissions
>> after enclave initialization. Enclave pages may thus already be part
>> of a VMA at the time their EPCM permissions are changed resulting
>> in the VMA's permissions potentially being more relaxed than the EPCM
>> permissions.
>>
>> Allow permissions of existing VMAs to be more relaxed than EPCM
>> permissions in preparation for dynamic EPCM permission changes
>> made possible in SGX2.  New VMAs that attempt to have more relaxed
>> permissions than EPCM permissions continue to be unsupported.
>>
>> Reasons why permissions of existing VMAs are allowed to be more relaxed
>> than EPCM permissions instead of dynamically changing VMA permissions
>> when EPCM permissions change are:
>> 1) Changing VMA permissions involve splitting VMAs which is an
>>    operation that can fail. Additionally changing EPCM permissions of
>>    a range of pages could also fail on any of the pages involved.
>>    Handling these error cases causes problems. For example, if an
>>    EPCM permission change fails and the VMA has already been split
>>    then it is not possible to undo the VMA split nor possible to
>>    undo the EPCM permission changes that did succeed before the
>>    failure.
>> 2) The kernel has little insight into the user space where EPCM
>>    permissions are controlled from. For example, a RW page may
>>    be made RO just before it is made RX and splitting the VMAs
>>    while the VMAs may change soon is unnecessary.
>>
>> Remove the extra permission check called on a page fault
>> (vm_operations_struct->fault) or during debugging
>> (vm_operations_struct->access) when loading the enclave page from swap
>> that ensures that the VMA permissions are not more relaxed than the
>> EPCM permissions. Since a VMA could only exist if it passed the
>> original permission checks during mmap() and a VMA may indeed
>> have more relaxed permissions than the EPCM permissions this extra
>> permission check is no longer appropriate.
>>
>> With the permission check removed, ensure that PTEs do
>> not blindly inherit the VMA permissions but instead the permissions
>> that the VMA and EPCM agree on. PTEs for writable pages (from VMA
>> and enclave perspective) are installed with the writable bit set,
>> reducing the need for this additional flow to the permission mismatch
>> cases handled next.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> Changes since V1:
>> - Reword commit message (Jarkko).
>> - Use "relax" instead of "exceed" when referring to permissions (Dave).
>> - Add snippet to Documentation/x86/sgx.rst that highlights the
>>   relationship between VMA, EPCM, and PTE permissions on SGX
>>   systems (Andy).
>>
>>  Documentation/x86/sgx.rst      | 10 +++++++++
>>  arch/x86/kernel/cpu/sgx/encl.c | 38 ++++++++++++++++++----------------
>>  2 files changed, 30 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
>> index 89ff924b1480..5659932728a5 100644
>> --- a/Documentation/x86/sgx.rst
>> +++ b/Documentation/x86/sgx.rst
>> @@ -99,6 +99,16 @@ The relationships between the different permission masks are:
>>  * PTEs are installed to match the EPCM permissions, but not be more
>>    relaxed than the VMA permissions.
>>  
>> +On systems supporting SGX2 EPCM permissions may change while the
>> +enclave page belongs to a VMA without impacting the VMA permissions.
>> +This means that a running VMA may appear to allow access to an enclave
>> +page that is not allowed by its EPCM permissions. For example, when an
>> +enclave page with RW EPCM permissions is mapped by a RW VMA but is
>> +subsequently changed to have read-only EPCM permissions. The kernel
>> +continues to maintain correct access to the enclave page through the
>> +PTE that will ensure that only access allowed by both the VMA
>> +and EPCM permissions are permitted.
>> +
>>  Application interface
>>  =====================
>>  
>> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
>> index 48afe96ae0f0..b6105d9e7c46 100644
>> --- a/arch/x86/kernel/cpu/sgx/encl.c
>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
>> @@ -91,10 +91,8 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
>>  }
>>  
>>  static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>> -						unsigned long addr,
>> -						unsigned long vm_flags)
>> +						unsigned long addr)
>>  {
>> -	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
>>  	struct sgx_epc_page *epc_page;
>>  	struct sgx_encl_page *entry;
>>  
>> @@ -102,14 +100,6 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>>  	if (!entry)
>>  		return ERR_PTR(-EFAULT);
>>  
>> -	/*
>> -	 * Verify that the faulted page has equal or higher build time
>> -	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
>> -	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
>> -	 */
>> -	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
>> -		return ERR_PTR(-EFAULT);
>> -
>>  	/* Entry successfully located. */
>>  	if (entry->epc_page) {
>>  		if (entry->desc & SGX_ENCL_PAGE_BEING_RECLAIMED)
>> @@ -138,7 +128,9 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>>  {
>>  	unsigned long addr = (unsigned long)vmf->address;
>>  	struct vm_area_struct *vma = vmf->vma;
>> +	unsigned long page_prot_bits;
>>  	struct sgx_encl_page *entry;
>> +	unsigned long vm_prot_bits;
>>  	unsigned long phys_addr;
>>  	struct sgx_encl *encl;
>>  	vm_fault_t ret;
>> @@ -155,7 +147,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>>  
>>  	mutex_lock(&encl->lock);
>>  
>> -	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
>> +	entry = sgx_encl_load_page(encl, addr);
>>  	if (IS_ERR(entry)) {
>>  		mutex_unlock(&encl->lock);
>   
>> @@ -167,7 +159,19 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>>  
>>  	phys_addr = sgx_get_epc_phys_addr(entry->epc_page);
>>  
>> -	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
>> +	/*
>> +	 * Insert PTE to match the EPCM page permissions ensured to not
>> +	 * exceed the VMA permissions.
>> +	 */
>> +	vm_prot_bits = vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
>> +	page_prot_bits = entry->vm_max_prot_bits & vm_prot_bits;
>> +	/*
>> +	 * Add VM_SHARED so that PTE is made writable right away if VMA
>> +	 * and EPCM are writable (no COW in SGX).
>> +	 */
>> +	page_prot_bits |= (vma->vm_flags & VM_SHARED);
>> +	ret = vmf_insert_pfn_prot(vma, addr, PFN_DOWN(phys_addr),
>> +				  vm_get_page_prot(page_prot_bits));
>>  	if (ret != VM_FAULT_NOPAGE) {
>>  		mutex_unlock(&encl->lock);
>>  
>> @@ -295,15 +299,14 @@ static int sgx_encl_debug_write(struct sgx_encl *encl, struct sgx_encl_page *pag
>>   * Load an enclave page to EPC if required, and take encl->lock.
>>   */
>>  static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
>> -						   unsigned long addr,
>> -						   unsigned long vm_flags)
>> +						   unsigned long addr)
>>  {
>>  	struct sgx_encl_page *entry;
>>  
>>  	for ( ; ; ) {
>>  		mutex_lock(&encl->lock);
>>  
>> -		entry = sgx_encl_load_page(encl, addr, vm_flags);
>> +		entry = sgx_encl_load_page(encl, addr);
>>  		if (PTR_ERR(entry) != -EBUSY)
>>  			break;
>>  
>> @@ -339,8 +342,7 @@ static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
>>  		return -EFAULT;
>>  
>>  	for (i = 0; i < len; i += cnt) {
>> -		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK,
>> -					      vma->vm_flags);
>> +		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK);
>>  		if (IS_ERR(entry)) {
>>  			ret = PTR_ERR(entry);
>>  			break;
>> -- 
>> 2.25.1
>>
> 
> If you unconditionally set vm_max_prot_bits to RWX for dynamically created
> pags, you would not need to do this.
> 
> These patches could be then safely dropped then:
> 
> - [PATCH V2 06/32] x86/sgx: Support VMA permissions more relaxed than enclave permissions 
> - [PATCH V2 08/32] x86/sgx: x86/sgx: Add sgx_encl_page->vm_run_prot_bits for dynamic permission changes
> - [PATCH V2 15/32] x86/sgx: Support relaxing of enclave page permissions
> 
> And that would also keep full ABI compatibility without exceptions to the
> existing mainline code.
> 

Dropping these changes do not just impact dynamically created pages. Dropping
these patches would result in EPCM page permission restriction being supported
for all pages, those added before enclave initialization as well as dynamically
added pages, but their PTEs will not be impacted.

For example, if a RW enclave page is added via SGX_IOC_ENCLAVE_ADD_PAGES and
then later made read-only via SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS then Linux
would keep allowing and installing RW PTEs to this page.

Allowing this goes against something explicitly disallowed from the beginning
of SGX as per:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/x86/sgx.rst#n74

"EPCM permissions are separate from the normal page tables.  This prevents the
kernel from, for instance, allowing writes to data which an enclave wishes to
remain read-only."

Reinette

