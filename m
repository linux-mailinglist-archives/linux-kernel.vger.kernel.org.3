Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0775050FBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349562AbiDZLeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbiDZLdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:33:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A006A431;
        Tue, 26 Apr 2022 04:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjUQCklp6Ng1LAFSCoIBU66vtvFvY9f5GTdmICvx+o4Cwo63P424WYRmMYep++PLulPyFvruOB05DEHsURG2yhiNHWQZmEzMeW0HZzCFIYSCFxQdUg0pO2dQR/rEyd8ZMzGlRWpNcldrv8sS1mskFXMMPRPToOTE901/U5ttMTGwixUu2sQhE4a6Hqe+oN95bmrDlFX4aZIMAuVkvpuUcn1hYeF76hwr/S3Up+KFD+NRCgOZOIZZL9uDvLhKiXFKmBUJSE41Dfpar5UNjVCiAHJb3lTylethg07ze2N01YNaq04DsEwlu5vkxHmp5hHVrBYYqWtO7a3sz5ZSn6k/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBIV1PB/W1uJDVZcqPUhWZBMGdTw2XppdfNZC6YCHtE=;
 b=BkxDEk6K0ZWXp4t7IZKzQZYhcaqOCkXrjF5ztDYZ2x6ENPollXT1ka/LSkbcq77Bx0K+gmn3/iKNtOGRmUPdQJ4cD4QV5F0NsSeO8iZXOkKUiSkIy4BTp1zq14KNGYz5JSZHeBeyqdKi0+Zo8095C7ECKP2FiFlaijLCWY1YcoAErw70Z93a98DwgjeIbMagyF9bl2F9HogDEmq/RGjOs8PIdZrAStRkyjsP/+betNExEcQDMs1LN9rbOcdl/7sum1S/s7M1PC0iOvRQT3S7srG8zo751SZWRMh8YvK873wlgwOJ/lO95r+AZXMckAelIcAfZH4cFRCvniOy47x12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBIV1PB/W1uJDVZcqPUhWZBMGdTw2XppdfNZC6YCHtE=;
 b=b95BRunry46CKVzPwCX+QU9N2H7v2ZEfEt9kiVEpAe/iGxbjMIL9AXOqcg7cIIw+Qwb6UTjEf6x/6phDiEdVn101jqjXg0k4SdL/0DE81TLXaq00zPTTJ4vLDIm8nBB7lRmGL+4HroMsK2IrhOI6OAuv2FWI7slbee63VVk5xg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 11:30:45 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 11:30:45 +0000
Message-ID: <a5cbc369-ada7-03aa-599b-f90c6306a124@amd.com>
Date:   Tue, 26 Apr 2022 17:00:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/6] perf/amd/ibs: Add support for L3 miss filtering
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, irogers@google.com, yao.jin@linux.intel.com,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com, rrichter@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-2-ravi.bangoria@amd.com>
 <20220426100707.GP2731@worktop.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220426100707.GP2731@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::23) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f11c67ba-4f6d-4dc4-ee6e-08da2778340f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02177888BFE92E825913EA09E0FB9@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9sL/juNTdwq+UVH8jFDwSQdYceukx6gnT0xoNW/jtS2QaIo2ICXzg6eyjEsu1OeXbaYBpvHWFEsUiCHKlT8MWDwlSUfJci27g+mihgBmMOoGlMo0X9nXmpIduZ7jy/ehaVdIqzSnk5jLTelLYkyRFdmdUBaB1Bds0qZgEJK3XO94DM3yFFUr3F4Q42rkRbqcMQQZEGMa7fe01bXu8/GHFqwBhYiFYWfDm4FewXwOR/DdMOT26Hr27iyD4POBOyXvcTrPuPuqRQWq/LbOw+cVSGjMS2pvZzRuZFXr0nrUtvEHWTD3TtkT0XKQ707YPLlAaHDCRhuJ33sBj1rQG9uf5nDxSOMG6mlMNrULLmUVgG/IYXBk99kddKQDOSfapebFcww4VJqOsWIA6kvssvSM66OT9uSL4x1XJwk2I7B4BuBdJsoCwn5Z+MiyJ3M0LOjs9i89xZjauju2buAnj99YzGUwYksCYSW7tLYGSeCTnuh/mdOoCDeeat3v9MbFvsBkkC4sMULm3TqTG2HsLzsNcYAp/G1+apuFAX03bjCZU6q0H1usYUUaJ+24lZwbCt23AVsHVKMjHj8mRfOg+p4epJaX9mrjwk8QsbUlPC+s0j4qVIn1GEW4Xx8CNdOq6xo7RGqfYCMcU4Ul1AXpXI1FwytoJf30YCH754LWBOFdxzszNwjRbrkfewQM3EHrIASdU9ifjYARohkeapkuJM8zE8p1rnVA31o48WDOLus3Vk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2906002)(6506007)(2616005)(53546011)(6916009)(66946007)(8676002)(7416002)(316002)(4326008)(5660300002)(44832011)(8936002)(31686004)(36756003)(66476007)(66556008)(6486002)(6666004)(6512007)(26005)(38100700002)(83380400001)(31696002)(508600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJEd3I3RW1Ob080azlNQkVnZEhIcHlIOERSajdoN0dIK3BGbWVYaE9oUU0y?=
 =?utf-8?B?dEhwL2gwNjhFMnVFWldENzNDZUN3eTI1S0s1WFFabXk2cHM0RDVNOHBuQWFC?=
 =?utf-8?B?Tk9TSWJ6UjQ4K2JuRzVYM3d1WU5HNVRoRURuRWQzTi81bmYwbWN1RXZUSTkz?=
 =?utf-8?B?M0Nmc0kyNEIyUElpdkMrblNRU2luTkQ2ZHZMZEdYQTY0ZW12YlMzMXA0SzZr?=
 =?utf-8?B?TWREby9RdVNMKytTTWZleGExT2IxS2tXUFFuZFY1K0trRDd2ckFtdkR3a2RI?=
 =?utf-8?B?eDdTTFQ1SzBHbVRMajZReXdHK0MvZjQyc2xCMm14N0FibjF4eFJVSWk2V1R3?=
 =?utf-8?B?MnZWUEJnMTkvY212dGE2T1lteUJnU09hR0J0Wk9xcmZrNjlOTDB5b2RUV2hO?=
 =?utf-8?B?MkJsV1lLdW4zOExodVA2bFd2bUx0YXhNVHk2d3VtRWIrQkxHY0lqb3hndjN2?=
 =?utf-8?B?S3Y2bXFYT0tLY1l2b0h6NXlSZWZkdmhZSG9RR3VTV05uYWxuTDlGVmJZWUJ2?=
 =?utf-8?B?U0pUck1pM3RiTEFZb2EwOG9VeFdMbVhrVzFROCt6dFRFTGpGN0RseGFrditq?=
 =?utf-8?B?K2hQekg0UDkxemVBcmZJZGZXOUlrY1VZYTVvVkloNkpnQWt3bnZNMldhanh1?=
 =?utf-8?B?YWdWaDdtOHcrQVdjSHdGb2MvUzNqanBBc084aHp0Q2ZuQzFpZUNGa3kyRkVv?=
 =?utf-8?B?Mml0aXRsYitYT3Y3TjJydmJpMFY4MmVkSjFGMHBVblF6TWUxaTVhclQ5aEdJ?=
 =?utf-8?B?TUpqY1ZlMTVFWVYxTVVvZHZBWFM3bGl0V24yUlBwaC8xcjFIL1NBK1lBS3J0?=
 =?utf-8?B?ekJqTDIzeVBNWFM2UGdDd0ZERmNhTC9HSTlTUTNFMGNEM0RBTENIZWdTU3RC?=
 =?utf-8?B?dTFTRFVSeWt2ZE9qd3dNMGozZkpKeVBnWk9FWWYxTXJaTnNzUi9YaFJDTlJO?=
 =?utf-8?B?VlBMamRnQXBjZ21XcHZrdGJKRmtwTTFob1kvRDNRWm5ydnM4b1BCb3NDY0dx?=
 =?utf-8?B?YkNyNGQwZ3ozS0RocWJVSlNuUGJTWUNXNmwzcGo2QkNCdWVHZ01nS1UwZ1N1?=
 =?utf-8?B?TmFqSGY2V244RURUVmNvbzBDVjdZTlJsbjN2U1cyeW92RWNpSk04dWVxREZL?=
 =?utf-8?B?dXpDR21MZHI0TXQ5NlFBSnRpL3hZWTJzb2paRjY1OVkvWHlrSVF3ME5OY2tD?=
 =?utf-8?B?MHdXN3JIZE9lb3Q1d3NFZzk0bHVCSlJ6dVZkNlhGWlU4aWVCK3dpWVczSEFO?=
 =?utf-8?B?VUlrWGVhSVhZdk14b0N0UmNqcEJHQnZjam9BeWMzM2dFM1IzWDdoeU1GTnRT?=
 =?utf-8?B?MjNlKzkrQ3k5RWxEY2xPbFhneHQ2YkJCMEdNdlJmNzZtbVNoQlB0eS9VNTBW?=
 =?utf-8?B?VjBOVzhqT2JTSWJOSmp5LzRrR3RWdzVOTkx2Z3phWWZjRVpkN2dSVm55c05o?=
 =?utf-8?B?d00xSm94ZSt1aU9tbWNJZGQ3OVhlbkVBY2FRemxwbWU5U2VtSHgvTkpQWS90?=
 =?utf-8?B?RSs4SGVHT2poMExNUDd6VEI1VWk4Vzlwd0RYYVlNN3Q0NWcrZHNpUzhaUDFP?=
 =?utf-8?B?ek5Ea1FRd0E0L3pwNStWM2M1RFNmM3JyTW5TTDJUSUY4MlZKVkZMQUdDN3Jk?=
 =?utf-8?B?OThjVTZzK0ZaeXRhZWwxR0Fwck5yOVlQYzRQOWowUkdoRUNqcVBFeWdGMHJv?=
 =?utf-8?B?TTZtR256ZVUzR0dTRFJwZFlreFFYaFV2eVpZVVRLZkFOYUEvNnZTNDJZRmI4?=
 =?utf-8?B?T2NKakdvWUo1RGo4QXdsb3ZxcUtHU3JBKzdzVWVxVkRyRFlWYlFCOWV2Z3lx?=
 =?utf-8?B?S3Njcm0vV21qdkVlQ1BLaEhVVkRzdWsvTTBQL3FhV0svWFJEV1FvcWRlekFM?=
 =?utf-8?B?dGVtZXovTzRONjhtbC9WQnpseEQ4STI3bm12bHFXdEhZb1F4T3BhQUlKTjZY?=
 =?utf-8?B?dlRaY09KK0EvQkk3b0NjelVyMk9wMENlT1k0RzB2SkdHNWNwcGh4cFl5aGZz?=
 =?utf-8?B?alQ1K0dKR1JDcFRTVzZueXpHU0VpZlZQQjlQdjBsN0NGTlJiL2h1NjRmZkQ4?=
 =?utf-8?B?U3FpanZwcnRKRjZ5N3dDcEpSWUR5dU9JaCtmbWkyNW9BLy9WRDlSN0VvV2pO?=
 =?utf-8?B?MXBSYm9rYis4WmlLSFl5akNQYU5aUTg3WVdEd2dyN0p5UFlEcUtvTTlvTVdF?=
 =?utf-8?B?Qzl5WVlRZC9Gb3oyeEdXaHFMT1YyQnZuRndwaHlvb1E0RzB4bkJBUVFxc25U?=
 =?utf-8?B?c3E1WWdrYW5hY1k3eCtDaldFQjB3cXFkNUFMd3JRQ3E4REt5MVVNb3dqamRW?=
 =?utf-8?B?Kzk0MVNvNlRRVzhRWVhOMGVsNytWTTY2VkU4QlZTQ2o1c0RNNWYxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11c67ba-4f6d-4dc4-ee6e-08da2778340f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 11:30:45.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwPAGRaBQDf4swEHs0z7LIPZglWDNcpIYecUHMoUdqfesfheqoJffRmu5qKDwjxvS4eQ1Qw73A7rLY+eG4yjJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Apr-22 3:37 PM, Peter Zijlstra wrote:
> On Mon, Apr 25, 2022 at 10:13:18AM +0530, Ravi Bangoria wrote:
>> IBS L3 miss filtering works by tagging an instruction on IBS counter
>> overflow and generating an NMI if the tagged instruction causes an L3
>> miss. Samples without an L3 miss are discarded and counter is reset
>> with random value (between 1-15 for fetch pmu and 1-127 for op pmu).
>> This helps in reducing sampling overhead when user is interested only
>> in such samples. One of the use case of such filtered samples is to
>> feed data to page-migration daemon in tiered memory systems.
>>
>> Add support for L3 miss filtering in IBS driver via new pmu attribute
>> "l3missonly". Example usage:
>>
>>   # perf record -a -e ibs_op/l3missonly=1/ --raw-samples sleep 5
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  arch/x86/events/amd/ibs.c         | 42 ++++++++++++++++++++++---------
>>  arch/x86/include/asm/perf_event.h |  3 +++
>>  2 files changed, 33 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index 9739019d4b67..a5303d62060c 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -520,16 +520,12 @@ static void perf_ibs_read(struct perf_event *event) { }
>>  
>>  PMU_FORMAT_ATTR(rand_en,	"config:57");
>>  PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
>> +PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
>> +PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
>>  
>> -static struct attribute *ibs_fetch_format_attrs[] = {
>> -	&format_attr_rand_en.attr,
>> -	NULL,
>> -};
>> -
>> -static struct attribute *ibs_op_format_attrs[] = {
>> -	NULL,	/* &format_attr_cnt_ctl.attr if IBS_CAPS_OPCNT */
>> -	NULL,
>> -};
>> +/* size = nr attrs plus NULL at the end */
>> +static struct attribute *ibs_fetch_format_attrs[3];
>> +static struct attribute *ibs_op_format_attrs[3];
>>  
>>  static struct perf_ibs perf_ibs_fetch = {
>>  	.pmu = {
>> @@ -759,9 +755,9 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
>>  	return ret;
>>  }
>>  
>> -static __init void perf_event_ibs_init(void)
>> +static __init void perf_ibs_fetch_prepare(void)
>>  {
>> -	struct attribute **attr = ibs_op_format_attrs;
>> +	struct attribute **format_attrs = perf_ibs_fetch.format_attrs;
>>  
>>  	/*
>>  	 * Some chips fail to reset the fetch count when it is written; instead
>> @@ -773,11 +769,22 @@ static __init void perf_event_ibs_init(void)
>>  	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
>>  		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
>>  
>> +	*format_attrs++ = &format_attr_rand_en.attr;
>> +	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
>> +		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
>> +		*format_attrs++ = &fetch_l3missonly.attr.attr;
>> +	}
>> +
>>  	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
>> +}
>> +
>> +static __init void perf_ibs_op_prepare(void)
>> +{
>> +	struct attribute **format_attrs = perf_ibs_op.format_attrs;
>>  
>>  	if (ibs_caps & IBS_CAPS_OPCNT) {
>>  		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
>> -		*attr++ = &format_attr_cnt_ctl.attr;
>> +		*format_attrs++ = &format_attr_cnt_ctl.attr;
>>  	}
>>  
>>  	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
>> @@ -786,7 +793,18 @@ static __init void perf_event_ibs_init(void)
>>  		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
>>  	}
>>  
>> +	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
>> +		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
>> +		*format_attrs++ = &op_l3missonly.attr.attr;
>> +	}
>> +
>>  	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
>> +}
> 
> Right, so Greg told us to stop doing silly things like this and use
> .is_visible, also see commits like:
> 
>   b7c9b3927337 ("perf/x86/intel: Use ->is_visible callback for default group")
> 
> There's quite a bit of that in the intel driver and some in the x86
> core code too. Please have a look.

Sure.

Thanks for the review,
Ravi
