Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB804DD5FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiCRIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiCRIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:20:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A78222A6;
        Fri, 18 Mar 2022 01:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+KYv7SbbfJMQf8YGauhstYUwiuY+0adUoCZmksNeyad1YZ1pMcvz6BOKAgfrQw1Tsu/N9ESAeJNm/hIXhLAg16Dz/eLdkYDKqC9IhUTj/N4FvXa3oNqc1XHJ0JAsdJOFaTxPyOe2rjP4o6H7gzTBU+8NTVuL0qq0DjPwiKIKV41Q8F7oq0faRkBdmXnWlDYpjKnld6Zhb+ugQjRDmItUv9u815tGW/RVbikvfudoiqdiEchsM89bqPF3EIpoWDOHv8cNlVICGI7wuPT3sAtvNxufpsN6gFM0/yCMiQU8/gBv+d9uCA/YrrTgcMsCuNWlpvg6cZDwBBqX1wTeB+w+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA8HFQcA0NfKOVxdL7DEUW4GazqF+U1l66ujgH//YVo=;
 b=C0sVrOp40fFenwmYD0Tqjmfe8dKDH4Lw8TKzVs+2q1MydRYQA+pqDhy29g/rE19CV/DhEJpOw8pLUyQkJRpqa1/S0eCPooXpybdQUo9QG/4pbB8pp4SEaq3xp9Xi498hSw3Sfhk5Ol/7PAQxQLtkx3iAM33tH4JtiMae0eUkLWgI/rlhMwo9Wi1lkbI9nF4CXI0E9HKGc0HQaw/tvPMfvaJNSdfXywGS4QaZvbulKgETFn6JWoEpin1kR8znLLMmhwTDAFAeW0DFGn6i8xd733h2vgM3N51d64wwWU/yCP/lZP1cLjNbWvyPBd56MLHKjCdKMt2vYs2G3Y9a1DnZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA8HFQcA0NfKOVxdL7DEUW4GazqF+U1l66ujgH//YVo=;
 b=rcWcfGJD6LV0bDHSDNSO2akHjmMd0RAwmJHLf/IsMxZ8AsPHTRvCIXM74wiUxzVrrAyQNq/u3ljmIUUMMgtcJMmFqAC5eGQOgXYAcjhPiby9+HdA+Hg2mM2uaDpcxp+/jsgf0zchdPbOCdddqbaMGlPZF1F64OPpgCtqQdOWpiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 (2603:10b6:405:55::20) by DM4PR12MB5961.namprd12.prod.outlook.com
 (2603:10b6:8:68::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 08:19:22 +0000
Received: from BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::944e:aab8:facf:fd8]) by BN6PR1201MB0178.namprd12.prod.outlook.com
 ([fe80::944e:aab8:facf:fd8%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:19:21 +0000
Message-ID: <8b8c0949-7677-94dc-4a8f-9fcf1b4d2f2d@amd.com>
Date:   Fri, 18 Mar 2022 13:48:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
Content-Language: en-US
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
 <7d43b4ba8a7c3c0833495f3fabfcfc6df8db3732.1647498015.git.sandipan.das@amd.com>
 <YjMjNvrGa7ZK/x3H@hirez.programming.kicks-ass.net>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <YjMjNvrGa7ZK/x3H@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::12)
 To BN6PR1201MB0178.namprd12.prod.outlook.com (2603:10b6:405:55::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d396611f-0649-4d16-c02b-08da08b800e5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5961:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB59619B3BD892DD11609198998B139@DM4PR12MB5961.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxszL/xIvxkkY6KQq0EtUqYTvFsw1y1CHu5/hTUeL7xPsRYHmxHICYuOfjJU1vBPcknBnVS5RW00sndmaH94NWiAEAwyBoERgdj4cWak2065j1weql3Onl4lhEiEi2cHfi3o10hWYInEjiKcIL99pQQEbg0s3iQELoFv7zNoCWKndaOI6ALCifImuI5eCctyhhNYhGOlQGNjjQMvfg5WGvX3hszJ0m4mj6ZFmHS05DrcyLjEmoD3takKWdPIrzqwdzTrGI7sFwBYUp1BkC8QEaO2G0TvUYYckiP7zED/7i4e3gvBiJ2h7VXncnuTdJGacmgh2z6r3l4MlGC90xT9zHb+mR6doJXPsMqQKAjDulbaqeii1z8iPoZf1p8WENU8myHOwRv0baWR8lgPWx69A+HIUNWwxCYYCxAzP4K+Lm8pxA937IVqXNaEOe6U7BHQJCXhOrD7oh7qPwP6a3763MgtNOol1rHBXNg5e+O2EvXjzgx7FFQOpGGDM/9eBpqjeBCPrghOgxiEqy9lkFDjvofNqxWAStXqtFsjc/D8doTxwlPCmzO+sH/zbOM3l7JrZsbxhp7/vShhqbBk5aOub1Bd/etof9INd/Tp3R/a0hAZHM3YtHXFAOOZaYkK1O9H4Y+IJfqyUcOKmRya0ywNadF7nLCbM6MVI2lY0/g81F1LX254kmJ98lYPQBfgBioiO0id1X09V6XVl0/YNL2wcsq0ZcaNX+ow0PvbsgSpE9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB0178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(66556008)(4326008)(66476007)(8676002)(83380400001)(2906002)(5660300002)(2616005)(186003)(26005)(6486002)(44832011)(36756003)(6916009)(7416002)(38100700002)(31686004)(8936002)(6506007)(508600001)(6512007)(53546011)(316002)(31696002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVBYTkFKa2Y0cmpoaXJOMWQ1T01aQ2JUK1VtS043NEpQU0V6VXlDQ3hsaU94?=
 =?utf-8?B?RUxtT0lZRUpuVmZvNmdHdXd6V2hNbEpQdnhHcm92M0ZLeWNlWjZMRDAyczZT?=
 =?utf-8?B?dmZLcU5WUkViR1ljdWsvZmxiT2JsbXIxemx3M2NrRDlrejFYY0VEblZTVllU?=
 =?utf-8?B?M3dLYzNvUU9GSnc4UWRKWW9McWI2N0dVQUFHQnRSVGVJbDljRi9PTHJkcXlm?=
 =?utf-8?B?NWlTZ1Z4M21rNmJEWmVsMmhoREREaVVWUnB2Rm01dkFVYmZrT3JGOHkwL2pZ?=
 =?utf-8?B?ZFNuWWd3cDVVYXd0WlVxVC9HQUlXbjdZMnd3V3pyQnV0UTBYWVYwWlVSdUda?=
 =?utf-8?B?djd1K1RHRG5nVDQrTGtsODhMeTFPWWp6V3RjSWE5aUkwVkErNzNSVTVUci95?=
 =?utf-8?B?Tmh4dGRNZUl0VG1OVWovcWlsUnl2dDhsSWhXdEJYRVBTTUtDdEppV095ZEVh?=
 =?utf-8?B?blV6RHJYQ1BHNXNFZXF0UThPSDdYZ1BhS05GMGZIOUR4SkVuMDMzaTlMRWdI?=
 =?utf-8?B?dDROTGlzOGc3NFBwakNFYWVadDcrRHBqSXB0bXVnNFE2SWZvWTJWbCtSSlJ3?=
 =?utf-8?B?bEU3MjNmV1NaYzhaMlR6azdvOUZQUmczN3EwQk9sbnNzRlRvVUdzWWdUM0Ry?=
 =?utf-8?B?VStZNmRuMzdwVTl2T0swcHBhMkF0b0M2bVdoS3YwTnpXZ0phd1Q5QWNYREF6?=
 =?utf-8?B?aTJZS2tlTlM5cUNDK1ZpVjZNOG5CNGtEa0tRaSt1eTFVekhOcGppU1dIZ0Jn?=
 =?utf-8?B?dmJuKzVaRFltQmpRaTdESnovSjd0RzZKbzVPR053dDBMOHZmWFlOa0hOU0g1?=
 =?utf-8?B?SzZ6c3B2NjNOaC8yYnR5aDloREVsd2dhYzVNTVhrZ2xjVTlXZThlT3dNaVd3?=
 =?utf-8?B?K08raTRvb2R6c2VaR0tBemZIQk4wZTVNN0Rmb2JVb2V0cy9lYmEvTDIvRjBU?=
 =?utf-8?B?M0pyclJmQ1VtbXN5ZXpZdHJuenRsOW01enh1MXhnbG83Q2NTYlYrVC9YNXZy?=
 =?utf-8?B?MG1QTXh1SWJYZ0tXMHFiVmI3bDlpRXJSVWEzTHlwbDdyeG9idnEvZHBJa2JY?=
 =?utf-8?B?c2hrbHRTUkUrSThxY203OVBqZzdaQUdvU05UdlJNZ3BPZ1k4T1N1MU4yMzJL?=
 =?utf-8?B?Zi9RcHpPMDRnMWw5SzRtTTlwR1RteVpGcDd3SHYra3lhaGRpNFd2bUVRdlVU?=
 =?utf-8?B?b0VrcFFLSkl1eHVIV28zdng1b3ZaVWViRTA2czc1L1R4V25ONWV2Rk5Qdk1Z?=
 =?utf-8?B?N2ljRldkMU5odEFNRXRjcWJwN2tXVGc5YUNjMkExZUl4UzJGdlQ2OHA0TXg5?=
 =?utf-8?B?aGo2VmdVU3ZldmlMbG9TNjUvK3BUZjc2b2oxWko0emt2M2YxUnFnOGo1c21t?=
 =?utf-8?B?RVdtdzNMT2ZOdG9lSjhRQXI3Ni9kMW4yb2hWQ1l2QW1VSUFaeGpLZyszeTh0?=
 =?utf-8?B?NmlndXdDcFYyNzY2Y0hnWG9vVUJxVVdkMHNkdjlXTUJOZk12WHhmTHkvQmZD?=
 =?utf-8?B?b2o3OVRWSEZncU5YWXY3Y0krSU1YcUp1SzJCbjlicExiaTVDd3E5L2V1NjlZ?=
 =?utf-8?B?UjJlSVIyYi9jV21xdm1heFlxM1hUc1dJVE5HQ2NoU3UvRkFkSW5TWnhOc3Jp?=
 =?utf-8?B?MGpZbW5MQ0swWFUwY2VOam0wamFuQ2ZzT28rUXlkenRZcUVSa1grcEluRGo0?=
 =?utf-8?B?WFExUXh6a1JpVmptUDlEZFhQa2FzWWdaUzNHQU1iUUJYdjRiSllYZ2NwbzBM?=
 =?utf-8?B?eWVsQlA3MENQa1lBVlRBUkdTU09qanMra2trUlJKVjdIcUp1MGRWQnMzL1ZW?=
 =?utf-8?B?N0g4MXpDTmRDUUlvQXFKaHg5RkprZWFvL052NHFaRlR1V3kzSG85RkttTExz?=
 =?utf-8?B?aW40NmJJSktVYjc4dldlWXppV2NwdkVheWVCSTYrT2hPNHNmVTA4bFFLRGQv?=
 =?utf-8?Q?rki+GLzj7LkNkseLF7s/cUPqqk0tnVr7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d396611f-0649-4d16-c02b-08da08b800e5
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:19:21.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XV6PrcitWEojDeoY92NV4N38cJPRllnimYEjml5z1F+aTP+r9RfGk2adxZC7A/ZI0vVASDSiM4as7DvF/lOy0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/2022 5:31 PM, Peter Zijlstra wrote:
> On Thu, Mar 17, 2022 at 11:58:35AM +0530, Sandipan Das wrote:
> 
>> +static inline u64 amd_pmu_get_global_overflow(void)
>> +{
>> +	u64 status;
>> +
>> +	/* PerfCntrGlobalStatus is read-only */
>> +	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
>> +
>> +	return status & amd_pmu_global_cntr_mask;
>> +}
>> +
>> +static inline void amd_pmu_ack_global_overflow(u64 status)
>> +{
>> +	/*
>> +	 * PerfCntrGlobalStatus is read-only but an overflow acknowledgment
>> +	 * mechanism exists; writing 1 to a bit in PerfCntrGlobalStatusClr
>> +	 * clears the same bit in PerfCntrGlobalStatus
>> +	 */
>> +
>> +	/* Only allow modifications to PerfCntrGlobalStatus.PerfCntrOvfl */
>> +	status &= amd_pmu_global_cntr_mask;
>> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
>> +}
>> +
>> +static bool amd_pmu_legacy_has_overflow(int idx)
>> +{
>> +	u64 counter;
>> +
>> +	rdmsrl(x86_pmu_event_addr(idx), counter);
>> +
>> +	return !(counter & BIT_ULL(x86_pmu.cntval_bits - 1));
>> +}
>> +
>> +static bool amd_pmu_global_has_overflow(int idx)
>> +{
>> +	return amd_pmu_get_global_overflow() & BIT_ULL(idx);
>> +}
>> +
>> +DEFINE_STATIC_CALL(amd_pmu_has_overflow, amd_pmu_legacy_has_overflow);
>> +
>>  /*
>>   * When a PMC counter overflows, an NMI is used to process the event and
>>   * reset the counter. NMI latency can result in the counter being updated
>> @@ -613,7 +653,6 @@ static inline void amd_pmu_set_global_ctl(u64 ctl)
>>  static void amd_pmu_wait_on_overflow(int idx)
>>  {
>>  	unsigned int i;
>> -	u64 counter;
>>  
>>  	/*
>>  	 * Wait for the counter to be reset if it has overflowed. This loop
>> @@ -621,8 +660,7 @@ static void amd_pmu_wait_on_overflow(int idx)
>>  	 * forever...
>>  	 */
>>  	for (i = 0; i < OVERFLOW_WAIT_COUNT; i++) {
>> -		rdmsrl(x86_pmu_event_addr(idx), counter);
>> -		if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
>> +		if (!static_call(amd_pmu_has_overflow)(idx))
>>  			break;
>>  
>>  		/* Might be in IRQ context, so can't sleep */
> 
> This scares me... please tell me you fixed that mess.
> 
>> @@ -718,6 +756,83 @@ static void amd_pmu_enable_event(struct perf_event *event)
>>  	static_call(amd_pmu_enable_event)(event);
>>  }
>>  
>> +static int amd_pmu_global_handle_irq(struct pt_regs *regs)
>> +{
>> +	struct perf_sample_data data;
>> +	struct cpu_hw_events *cpuc;
>> +	struct hw_perf_event *hwc;
>> +	struct perf_event *event;
>> +	u64 val, status, mask;
>> +	int handled = 0, idx;
>> +
>> +	status = amd_pmu_get_global_overflow();
>> +
>> +	/* Check if any overflows are pending */
>> +	if (!status)
>> +		return 0;
>> +
>> +	/* Stop counting */
>> +	amd_pmu_global_disable_all();
> 
> 
> This seems weird to me, I'd first disable it, then read status. MSR
> access is expensive, you want to shut down the PMU asap.
> 
> Also, this is written like PMI would not be the primary NMI source,
> which seems somewhat unlikely.
> 

Yes, PMI is the primary NMI source. Will fix this.

>> +
>> +	cpuc = this_cpu_ptr(&cpu_hw_events);
>> +
>> +	/*
>> +	 * Some chipsets need to unmask the LVTPC in a particular spot
>> +	 * inside the nmi handler.  As a result, the unmasking was
>> +	 * pushed into all the nmi handlers.
>> +	 *
>> +	 * This generic handler doesn't seem to have any issues where
>> +	 * the unmasking occurs so it was left at the top.
>> +	 *
>> +	 * N.B. Taken from x86_pmu_handle_irq()
>> +	 */
> 
> Please write an AMD specific comment here. Note how 'recent' Intel chips
> ended up pushing this to the end of the handler. Verify with your
> hardware team where they want this and write as much of the rationale as
> you're allowed to share in the comment.
> 

Sure. I'll follow-up on this.

>> +	apic_write(APIC_LVTPC, APIC_DM_NMI);
>> +
>> +	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
>> +		if (!test_bit(idx, cpuc->active_mask))
>> +			continue;
>> +
>> +		event = cpuc->events[idx];
>> +		hwc = &event->hw;
>> +		val = x86_perf_event_update(event);
>> +		mask = BIT_ULL(idx);
>> +
>> +		if (!(status & mask))
>> +			continue;
>> +
>> +		/* Event overflow */
>> +		handled++;
>> +		perf_sample_data_init(&data, 0, hwc->last_period);
>> +
>> +		if (!x86_perf_event_set_period(event))
>> +			continue;
>> +
>> +		if (perf_event_overflow(event, &data, regs))
>> +			x86_pmu_stop(event, 0);
>> +
>> +		status &= ~mask;
>> +	}
>> +
>> +	/*
>> +	 * It should never be the case that some overflows are not handled as
>> +	 * the corresponding PMCs are expected to be inactive according to the
>> +	 * active_mask
>> +	 */
>> +	WARN_ON(status > 0);
>> +
>> +	/* Clear overflow bits */
>> +	amd_pmu_ack_global_overflow(~status);
>> +
>> +	inc_irq_stat(apic_perf_irqs);
>> +
>> +	/* Resume counting */
>> +	amd_pmu_global_enable_all(0);
> 
> I think this is broken vs perf_pmu_{dis,en}able(), note how
> intel_pmu_handle_irq() saves/restores the enable state.
> 

Yes, it is. Will fix it.

>> +
>> +	return handled;
>> +}
>> +
>> +DEFINE_STATIC_CALL(amd_pmu_handle_irq, x86_pmu_handle_irq);
>> +
>>  /*
>>   * Because of NMI latency, if multiple PMC counters are active or other sources
>>   * of NMIs are received, the perf NMI handler can handle one or more overflowed
>> @@ -741,7 +856,7 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
>>  	int handled;
>>  
>>  	/* Process any counter overflows */
>> -	handled = x86_pmu_handle_irq(regs);
>> +	handled = static_call(amd_pmu_handle_irq)(regs);
>>  
>>  	/*
>>  	 * If a counter was handled, record a timestamp such that un-handled
>> @@ -1041,6 +1156,8 @@ static int __init amd_core_pmu_init(void)
>>  		static_call_update(amd_pmu_enable_all, amd_pmu_global_enable_all);
>>  		static_call_update(amd_pmu_disable_all, amd_pmu_global_disable_all);
>>  		static_call_update(amd_pmu_enable_event, amd_pmu_global_enable_event);
>> +		static_call_update(amd_pmu_has_overflow, amd_pmu_global_has_overflow);
>> +		static_call_update(amd_pmu_handle_irq, amd_pmu_global_handle_irq);
>>  	}
> 
> Same, all this static_call() stuff is misguided.
> 
> Also, if you feel like it, you can create amd_pmu_v2.

Sure.

- Sandipan
