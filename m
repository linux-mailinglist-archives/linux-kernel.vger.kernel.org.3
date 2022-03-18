Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3274DD5C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiCRIDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiCRIDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:03:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7462C80BA;
        Fri, 18 Mar 2022 01:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBn4vIkMBBeovHySbTmi3Vj1cH8KDFLuIqlDpdNJgZzDH4hnHU1YQfOH9msyCO0mVynjQqfS9lk0vKKxXpE32BWbahvZl3uWk6Vl/Bcm49WKonmsSPKCa96Vxj0/2k1vcnTbzw3rQIMbxprjQosYTmncDaFgx8QB5OGwqgMVHlDDfvfYJQ4Q6LR+C94VsJTKOQ9N0c0bdchEFOYiUjul056raQkSIA9AWujl/IBy0cRZZflvyJ7c3vnT1zWRWCfsUPVrH0DU/gB4KKnQ90pUnX9m3xQgB5Jq+/GFeZ41ZGJJlbm8Wb45oZuHm0urhrtkvkzt838XPNSeR8cirnIHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyU0RVad/RzcLDgtxMUx0YjA25CRR4+KvUtESFnm0nY=;
 b=GZEKO0MOmUBDn8hjZa8QUXevu3Iw04q0lwutusQPGinWmjggdeA+BXz9M0p8nEmUPlAyM2WgBqT0C59+XVK9y+OGyCn9/a2F7h934E2fSIkAS5yKtwHu0JanXBw3Qj1EYC2+mhEBSsu8pY55LjPVUDliNz5kYPeM6z/6s1CPbfsFKlzBZBVa5j033RNsBGcbzGS8wj9eVmrM/wnOxoRyY/cWTBTuzeKDdeY6GejOPjZLjO1B6KBlrTn5PHYbQfV7Nm2Uy0euoO3UBJQ50gvp5DXBLRf8cyZizXNFsnB7+FdXuHxa8U2QkiwBvGGE1mjI7t/4JfTJ3fq63I06XkTqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyU0RVad/RzcLDgtxMUx0YjA25CRR4+KvUtESFnm0nY=;
 b=VURi/7F197yFSVZs8/A+5ozDtVjy+D3s8WXvXl0zQjT3WYPuqZQUc5RPohQ5x4BEOjRU6edhT/lSnCuAwya98O3w7YGdK4hEo2Vp3z9PMPMC1sR6iej3RUp0tTuhWtLquuX9Mvk3vEFJ2Zt9GGMSo99KttqIKL739syMsFlexKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20) by DM6PR12MB2634.namprd12.prod.outlook.com
 (2603:10b6:5:49::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Fri, 18 Mar
 2022 08:02:27 +0000
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::944e:aab8:facf:fd8]) by BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::944e:aab8:facf:fd8%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:02:26 +0000
Message-ID: <ea39ef1d-44a3-478d-f6fb-2120be67e745@amd.com>
Date:   Fri, 18 Mar 2022 13:32:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH 5/7] perf/x86/amd/core: Add PerfMonV2 counter control
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1647498015.git.sandipan.das@amd.com>
 <7958e729c6be0f682379bec81f115b8cd7cca1ad.1647498015.git.sandipan.das@amd.com>
 <YjMfe7KyKp+a3Jkp@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <YjMfe7KyKp+a3Jkp@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::22)
 To BN6PR1201MB0178.namprd12.prod.outlook.com (2603:10b6:405:55::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f957b08a-4f71-4e1e-2454-08da08b5a3d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2634:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2634EF9A78CCEC5324FDB6EB8B139@DM6PR12MB2634.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSP4neF0Rl/cMVtRnRLU0AEm4acuKiToD81GNecB4bskLh/oBA0GocGywtUPa5SrOW4sTm1ROESJluTScTmYiNXiIFBm5j9KUE+DLtAWuuUs+910NsfTHGleMjxOVWAkAegU9U96X0kzB3w9UNLirVe7O106oyRnyvZkQukoQmT5zeWdyh1SPRBLj+pAV2kGIXCfdeGmqH3SmpVhVK11Ma5QyDe4I/TwhkoC7pskJvLQj0TUMXi7EPgW2db+lruJ+r5coRCyqZjxWOaCTKSFHuZBav1kEUF3IKfU8NwcztljXhRDoI1T7EjacwSguSpdmFnSyt6oRic9rUdvfZn9wkn/u31JMqKmnayn+thuEmXxkMSAH+cPtzDzrqku9pRkAsqfMpNDHeU+dql67Flg3auSL83MlQeFQc4gIEpoQMJ1XHqGlRZLekwDuzx2wBuoygQL0aRJDA45MpDwEh6hKJ+WsQhS5ycyd5rE7XkpjWDyEwOXBpjsZy/JYpL0/hlwYtmEEg63Ox+1rQ5F0YHh3eA/y/m588A98pNIiUb1rhiGO3rQEzVMnO4nwJA7LSn3yr8YAFb4gVz5FnszClcluAXCkHPjx8Kdf1eWkDjAiFCO56mroQ0l4mMY6CiBS/AyOf2v+L/2ecTik92lmoxNrJpEHeFrZwMOgKoJIwyF5izkcqgC4DGfRKzAv/y1aqYds8A+WzPmRXqoBHD4rvuwxPYqISTwxlmOVy1Vve7GRk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB0178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(508600001)(6486002)(2906002)(36756003)(44832011)(5660300002)(186003)(26005)(2616005)(38100700002)(8676002)(316002)(66556008)(66946007)(66476007)(6506007)(6916009)(86362001)(31696002)(53546011)(7416002)(8936002)(6666004)(6512007)(83380400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhmS2JjTi9CTVArTVBZNzNrSndIdFZRUUlNaVQ2bFNkRjBKMTB1NWlaZjc2?=
 =?utf-8?B?aEovN29wMFVkU1dnT1h2RTVnZTdKSjhUSXMrdDB2Q0cva2UvdHByOHRaV1Uv?=
 =?utf-8?B?ZkExdHJlbUZaZEVVaUR3ZUw3bUFVY0Z3a3JNZ282ZENIamdUN1B6Ynd2ODZH?=
 =?utf-8?B?WVdhUFNoREt5MnFxL2xzblcyM0R1YktDdlljeFhqTjhWSGdOR00wYUloUU43?=
 =?utf-8?B?NTNPZUJrQ3JaWlNLbWtjamZPMHFzRklFdEFUREtTalhrNmRrRy8wYUJFMDRz?=
 =?utf-8?B?YWl0N21WSURCVjBWWVdPdVBob2pDS1k3clRCQjd4UmgwVkExcXRkNUoxaE5j?=
 =?utf-8?B?YkhTWjAvdjhkQUJvSXBPQlIyNWJ6d2hFajQxMWZORHp5bWxObzRET2lTMlRV?=
 =?utf-8?B?UmlqdDk3Z1Erc3RnY2c4K3E3VmJkeDd1eWJYWFNpMmErWlEwOGdMUzdQRXl1?=
 =?utf-8?B?MHZWMEVPWlBJMVdhVTRBdmc5c1NRYk5Kay9QUmJCZjg5SXdTYktick83aXAz?=
 =?utf-8?B?SzNINnlCTGZIMWpPdFVTZFZlSlZkM0F0Zy9QTnllQmJnRVJTVVJOaXprODll?=
 =?utf-8?B?MFU2Szg0QkJYVlUwTG1RcWxlZExkTmtUb0F5b0tZWjdaVzRyUzk2ZW4xNlFF?=
 =?utf-8?B?U0J2NlhOWlVBci94RWJqeFNUSENBcEl4d0VQODV4NTQxd085c2hDRWVrN1Vn?=
 =?utf-8?B?dnQ4L2ZrUzVmSG03d2U5VkVUcGgrVFpiVlVCKzBmVVdld0tlZEMrZDJERnp6?=
 =?utf-8?B?RmRHQzFVVTJxL3poa0FOKzhNTVVUaFlLOWhjMUJuK3MvUUdvNG45S2dlUDk4?=
 =?utf-8?B?WlY0SWU3emU4MVh0V0d4RXRtclEvNHB3WEdjSkZkSTFIWVRqWkNjWnBxeU95?=
 =?utf-8?B?Q1d5ZWF6dmltUVFlK0lxU3ZHYktiK0xMN1NzR3RDY3lUczZCWGx0MTNrb1Zi?=
 =?utf-8?B?YjcrbHVmM05yWkcyMkg1SEhrNUZHZ2JzQlF0dkN2SkhJeFJYYUpHWE5Ed0VO?=
 =?utf-8?B?SEF5UHVHZE56UHBxNXVBMEFmaDlWSndxVEhxb25DZmp1L243SkxwRmp6VDRi?=
 =?utf-8?B?djNjbzhpU2VLUGZ5TytyeFFtSklsODlVOU9CaS9IYWNHT1IvZnNpb3RPaWxi?=
 =?utf-8?B?a00wR2Q4S0lYQ2VLWmhnUkFYT2tKZ1NOYURhelA4czJabmNidHJYR0JqNFBq?=
 =?utf-8?B?R05FYlJoTUhCTG9QM3BVVlN3OElNNXh4YkhEOFpZYUowdE9ISUxzNU9vL3RV?=
 =?utf-8?B?bjdNUUtlL25sZzBQV3ArWFVMZzlPT2cwcnRRY3ErS2NMakx1ZXR2VlQrNHBh?=
 =?utf-8?B?MXJCanF0TEZ1RmZpcGpJMVQrK24vb3Z3WlBGUFFoamViRzBGNG9zbWxBanZy?=
 =?utf-8?B?Qk53MC91OWxhREN4M3dlb1Y1dVBHUEdHU3RQdkJLaG4weWNFWkp3aDIxZlFQ?=
 =?utf-8?B?OFJRc09CZkJsQkVlNWkrREIyK2NPb0kxOXdVaXA2anFnVVlrU3lxNkRBcDRr?=
 =?utf-8?B?Y2ZVVlFLc2RHV0pJMCtnei9NUnpYQlhnaUkvMTVQMWtIb0V5RHdGU0lLeExn?=
 =?utf-8?B?K3Bkc2tyeHdpNkc1ZXRYcWR4VzEwaURVMllSandjckw3MFNtbVpDK29xdlFw?=
 =?utf-8?B?NWFnTGRQbTNyVXNhL3F5Mmo1Rm9aZjI5c1l5UVVpbEV4WGZtcWRBeVF4eVUr?=
 =?utf-8?B?STIrUExwb0gzdGI0ZGJlek5YZHVMcmFlSTk0K2ZxbjV0UGVZOFhLelRjbVFV?=
 =?utf-8?B?UkxZL3V1b01UYllIMlpPSXl5aDMvNzlnTHAvaGZENzhwQ0xzQjBUT2dKS1VQ?=
 =?utf-8?B?Y3puaUtWa3ZiU0Q2dXRnR2ZXV05uY3owNllJc3ZNWXo0aTBGS3NHQnlJOXdZ?=
 =?utf-8?B?dW5Wc1RORWtQSngrVGZ2UlV1b1NXNlV0V3cxRzZCR21DQXRQeWJKa0VsRlB4?=
 =?utf-8?Q?M3n8qGtVmZjCm9W3TwzKFucPK4EQyild?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f957b08a-4f71-4e1e-2454-08da08b5a3d6
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:02:26.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zZ4ZWkkLU642SrQjMU2zFhNdvg7YQJYzzrAjq/5DoxPMNlPZmg4B1tjo4YIWsQUkpbd6zdSw3I0eROmLywn6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/2022 5:16 PM, Peter Zijlstra wrote:
> On Thu, Mar 17, 2022 at 11:58:34AM +0530, Sandipan Das wrote:
>> @@ -625,12 +630,32 @@ static void amd_pmu_wait_on_overflow(int idx)
>>  	}
>>  }
>>  
>> +static void amd_pmu_global_enable_all(int added)
>> +{
>> +	amd_pmu_set_global_ctl(amd_pmu_global_cntr_mask);
>> +}
>> +
>> +DEFINE_STATIC_CALL(amd_pmu_enable_all, x86_pmu_enable_all);
>> +
>> +static void amd_pmu_enable_all(int added)
>> +{
>> +	static_call(amd_pmu_enable_all)(added);
>> +}
>> +
>> +static void amd_pmu_global_disable_all(void)
>> +{
>> +	/* Disable all PMCs */
>> +	amd_pmu_set_global_ctl(0);
>> +}
>> +
>> +DEFINE_STATIC_CALL(amd_pmu_disable_all, x86_pmu_disable_all);
>> +
>>  static void amd_pmu_disable_all(void)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  	int idx;
>>  
>> -	x86_pmu_disable_all();
>> +	static_call(amd_pmu_disable_all)();
>>  
>>  	/*
>>  	 * This shouldn't be called from NMI context, but add a safeguard here
>> @@ -671,6 +696,28 @@ static void amd_pmu_disable_event(struct perf_event *event)
>>  	amd_pmu_wait_on_overflow(event->hw.idx);
>>  }
>>  
>> +static void amd_pmu_global_enable_event(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	/*
>> +	 * Testing cpu_hw_events.enabled should be skipped in this case unlike
>> +	 * in x86_pmu_enable_event().
>> +	 *
>> +	 * Since cpu_hw_events.enabled is set only after returning from
>> +	 * x86_pmu_start(), the PMCs must be programmed and kept ready.
>> +	 * Counting starts only after x86_pmu_enable_all() is called.
>> +	 */
>> +	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
>> +}
>> +
>> +DEFINE_STATIC_CALL(amd_pmu_enable_event, x86_pmu_enable_event);
>> +
>> +static void amd_pmu_enable_event(struct perf_event *event)
>> +{
>> +	static_call(amd_pmu_enable_event)(event);
>> +}
>> +
>>  /*
>>   * Because of NMI latency, if multiple PMC counters are active or other sources
>>   * of NMIs are received, the perf NMI handler can handle one or more overflowed
>> @@ -929,8 +976,8 @@ static __initconst const struct x86_pmu amd_pmu = {
>>  	.name			= "AMD",
>>  	.handle_irq		= amd_pmu_handle_irq,
>>  	.disable_all		= amd_pmu_disable_all,
>> -	.enable_all		= x86_pmu_enable_all,
>> -	.enable			= x86_pmu_enable_event,
>> +	.enable_all		= amd_pmu_enable_all,
>> +	.enable			= amd_pmu_enable_event,
>>  	.disable		= amd_pmu_disable_event,
>>  	.hw_config		= amd_pmu_hw_config,
>>  	.schedule_events	= x86_schedule_events,
>> @@ -989,6 +1036,11 @@ static int __init amd_core_pmu_init(void)
>>  		x86_pmu.num_counters = EXT_PERFMON_DEBUG_NUM_CORE_PMC(ebx);
>>  
>>  		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
>> +
>> +		/* Update PMC handling functions */
>> +		static_call_update(amd_pmu_enable_all, amd_pmu_global_enable_all);
>> +		static_call_update(amd_pmu_disable_all, amd_pmu_global_disable_all);
>> +		static_call_update(amd_pmu_enable_event, amd_pmu_global_enable_event);
>>  	}
> 
> 
> This makes no sense to me...
> 
> First and foremost, *please* tell me your shiny new hardware fixed the
> terrible behaviour that requires the wait_on_overflow hacks in
> amd_pmu_disable_all().

Unfortunately, that workaround is still required.

> 
> Second, all these x86_pmu methods are already static_calls per
> arch/x86/events/core.c. So what you want to do is something like:
> 
> 	x86_pmu = amd_pmu;
> 	if (amd_v2) {
> 		x86_pmu.disable_all = amd_v2_disable_all;
> 		x86_pmu.enable_all  = amd_v2_enable_all;
> 	}
> 
> And leave it at that.
> 

Sure. I'll clean this up.

- Sandipan
