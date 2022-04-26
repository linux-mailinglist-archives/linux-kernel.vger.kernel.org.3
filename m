Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21050FC16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346501AbiDZLoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiDZLoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:44:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C23B2B4;
        Tue, 26 Apr 2022 04:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGhMr0soHMOczjwVI742fJbln/7c+Kf+2X+Kb2se5StG4iAJiiPABz4wynvKgXmgPheYvK/6z0+nPZ+Sgc/n8JaW8SZQWeb4538XAXPLHlalVKkRJZJ41y5a9U++U/FXB3uZwLyOHV3YcyMom/Ex7N7SO2xnsarZENynDojNzrjE9JCykFONS0d00e8hdjfVrh9WcZrPuyUHx6j/CcR8lLtYw7Y8pc53sBy+wBR9IDI/7+bY5gp7bXYPWBVcZ29K3UboGg3pte+ajFFQgnoqLzlmm7ZFu+TqWYtWH5LZmd3O79divgoc7DsFX7bc/hK2bhXa41g+IwY76Kl+s0t4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlYPIQctxHCj4EM6Ww0SjVtOrkFUUu2pV270b5ftNf4=;
 b=T0bd+LMDo9TmkEJ6c0WKkeS6ORNoetG7JU5J75sYRXKae6lI6ixa7BcXVypCFOeTMmZUBljGJiF7wJTplK9TfqUe0S6wGcybGWQG19dtAKYLEYGDRsELEZL6HfoRrhMza7GYOTrUFkVhwqLjeJtW+v7SjKGW7a+a3H+wG9uyhswwUwF1NRmdkM+RhVF6/PIyviKKKyBW6QONUvRmxPoebZVi7cZpxo1SqxI/LAXJJhBGS8UXnRvZcD6/24n+1dT3QS88nVa3jbhZp65t64om0m7LoMTGWDf4hbWfcgWERqZWch0Sa/IqwNznwmcT1fxuLZLT6PHoacOh65uDtjxfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlYPIQctxHCj4EM6Ww0SjVtOrkFUUu2pV270b5ftNf4=;
 b=GdyNE9rg0L+v4tXq8E+M8f0o9t/ehiLjRRwqb1YGcmQ/O4h/XXA6Ea/3o9uY2kESy5BvwLPj8desJYVD8qRXBJmIZWjB4CEvqCUTSV5idFL+nruk0XcSSwwEk4COtjQpzx3RnlFq0kBIwMIOOxIK2nz4qigfvdeMNyg72Nvb7oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 11:41:05 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 11:41:05 +0000
Message-ID: <ccf42c33-c11c-9650-7361-a5776991c1da@amd.com>
Date:   Tue, 26 Apr 2022 17:10:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/6] perf/amd/ibs: Advertise zen4_ibs_extensions as pmu
 capability attribute
Content-Language: en-US
To:     Robert Richter <rrichter@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-3-ravi.bangoria@amd.com>
 <YmfCICT+nbdvohw3@rric.localdomain>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YmfCICT+nbdvohw3@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::10) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 799bc4bb-64b6-4171-2a22-08da2779a599
X-MS-TrafficTypeDiagnostic: DM6PR12MB4012:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40124FB168B313C510BE9001E0FB9@DM6PR12MB4012.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E63Zgm/GNkgwf7Nak+p0DDdYWAdd7NdjbwyA+c5sUmnGEVeeWiCMmUrVwioOoNcCGE/3eTZoEp+lHSc4HFyiLxWt5J62ysP+ulpjH6cqbsmyxbA7R0gFoQ3ebDyTEuY72Gru9PdhTLEgzssgBvClAoYGzzh3+AuUZ06eCOVdAa5AgnZsIGIWTUn6ZsXBxU/FIlQTWcyMfAFXgKSvkxazU/wOj9ONB5Sh9AFXmdwwTH2VhshFmAjELaeZzF69O+RgxtLoRH7Z4/B6RiLgcpUXb3nHjy+6yEh7nUyCSERsElOFny4UtiRuV1NgeUMkDJHELFhAaVAihtqeNouV3ujjRWAsDLVvXv0VPG9yFHMRJV7S3oguF0PUIsB2eZO+0Agir88bfkldbiXvvwIR5OJgSvnWXHlJZvyL+5hDfg6oin/Tn0kSSuYlk5hibvVVKIol9TYfAVhn4zg/lek9QO901S8jJQKO1cPtDkG8I4MQ/6Jq+hjs/iWSq3U/hMpVjncI+yat/YwMBd57TmAiK4IdAecbcNWpDWstH9LgUOzkv5OErLM28hQgDw6REgogh3rck8vFLbIe2YN60rm2eiZsjJHcu84vqJMH6kJtEnwwZbLcZD9ArMb0UnltHDFJu/tg1x0SWQgL7GXEKyqkGfsqfO+fhRQORBPMbvVf4dZ9TdwFO6PW+ADSO9p4wOQ28tWmoBYIXXw61LkzY9KSWgJ3p7Xi/Aab5NtLL7TKJ4a4UNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(31696002)(508600001)(6506007)(6512007)(6666004)(86362001)(6636002)(186003)(53546011)(36756003)(31686004)(7416002)(44832011)(8936002)(4326008)(6862004)(38100700002)(5660300002)(2906002)(8676002)(66556008)(66476007)(66946007)(26005)(316002)(37006003)(6486002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTFkSTU5SHdUSzBUR003RU4wei94QWRGdXRadVlOYU5qa2FBTVBZL1dKSVVG?=
 =?utf-8?B?d2UrVlN1VTh0SmVHaWtaQmx3WGllcUtESnR5dkNxblVZQkNGdjFCSlZ2Q1d1?=
 =?utf-8?B?MXozenVnUWxXQ3lxTTlYeXc0eVpRKzlYOUtjNHdCRDY2WTRob1lZODNKd0ty?=
 =?utf-8?B?SW9uM0JoeXh1YklnWnEwOEtYYVJEMlRURUlMdUpVUXgwbjIrNlQycWRKeWRB?=
 =?utf-8?B?SlM3SHBSZE01TURZRWR4VzN6OUdTbm5pblF1VUcvVlc4V1VrRWlIcWtaRVZa?=
 =?utf-8?B?cnFteHJxZUd0UHJvQU1oMWxDSWZENnJXUU8yMjNqNWdiMU9kRXhvZ1FXK3NL?=
 =?utf-8?B?cWFMOWNLWllYR044eHlaUzRZMjFnbTQyQXBmVXh6enFqbmNKc0M3N0hHaTZj?=
 =?utf-8?B?WDgwOEJIWUhuK2JERTFZZnNVNW1wYjU5cFNYWWllbUZWUndWLzJvQkdiM0VB?=
 =?utf-8?B?cm50R05tUjZRd3ZPR1FIZXVibTl0QWZBbGNUOWp6V3hXUGJpditodlYyWmRz?=
 =?utf-8?B?N2FFSk0wa2xvQ0c3OFFUR0t6eVh2c0F0TVhEMVNFVnJyVzRQWjFIY0xHcmV2?=
 =?utf-8?B?ZlF6b05JZVhnUWRJemxtTjlvVmY0TTNoYTl0ck1HbG1TZnFMa1I3WW9aNWpV?=
 =?utf-8?B?VjJ3R1VyQWRXUzhNY0ZzT2hTY09SV24yalBSV1A4VGFrWTU1NHMyL09scGdw?=
 =?utf-8?B?RFpPaUNjZnllUDZseGZrUEZNY0ZFRE9MbTJ3NDZGdWdGZmZ2MmtBSGtIc0dJ?=
 =?utf-8?B?RXZDMzcyNVFlM3p4czRiQjVMQ2pEN0JteE9SN1BuYU9UR1ZiQWR2VXNiOHB3?=
 =?utf-8?B?TXJpeEYwTitNdHA5ZDRNQzVUcG81dUE1ckFyaDRhTmRIb3VIZHJlQktQelVi?=
 =?utf-8?B?YVNvM2ppYURMUFdpZEsyR1pGc0xvYml5QWRlME1qOUhlRmV5dUxtdGZDckE2?=
 =?utf-8?B?NGtkVHMyMGxQTG9RL2NldnhsMnF2UTcvK0FONHJ0UHFQNEhNQ1NoNzJkekVx?=
 =?utf-8?B?MytST0dCaHg0c3JHWk1LZ1dDdW92WUJjRWt5Um1xWGhWbGdVR3FVRFlLa2gx?=
 =?utf-8?B?NTYvTGdIaTRsSGJjY3hFQjhzK212Y3lyclllZ1plMDFYQ1lnbG5TNFJMVEVm?=
 =?utf-8?B?SEgwTUhLdVRuU0llTXpzYlRhOW1SZVVtSVZZVTc3dDJJSzdRUzYrUGtITXpq?=
 =?utf-8?B?UXI0MHZDVzh4Y1YzTUtwN0VRWUhGUzdLWjZkZDZzZ3pPSXNWTWdCKzBxMGps?=
 =?utf-8?B?L2oxQjIyTTN1a3FrUitpT2NZTHZNdS9jenJvQUg5WTdNS2xLTjBzRkdkbmF3?=
 =?utf-8?B?NUpQVGxiQmZwQ3FBRWpveHZ2Wjc4YXNzVktiZkVIV0d6VHRWMGY1WkZ1NGZC?=
 =?utf-8?B?cUQvWTlrQm1vL3pqcmVXbDlKT3pVbGhrSU41RVEzK3gvRzE5cEpLZFVaZzd5?=
 =?utf-8?B?ODVLY1o5TjczTUtoQWNQT3RQL2p6dWx6eXVGejRvSWxOTDlQcGZJeFE1dFB0?=
 =?utf-8?B?TUNDYmlER0xXZVorQjUvcGVVeDdiQ3UzanJNWllHbFRxV1l0NUVWTFlmREFp?=
 =?utf-8?B?V3JiaSttYWk1SEFIc3hFRGxTZ1JCNExxL0dnWkI2NCswZkJjOFhZSkhqQ21r?=
 =?utf-8?B?aVYzOE9DU2sxNjVkRWlvZnpENGZTb29Vdzc4ajhrUUNscWIyLzNBK2hnQ0R1?=
 =?utf-8?B?OEVxRXd5emxEdzhuc2lUTE0zaWwyTWpWQ2p2RTcvcWNuSm1pUHBTNFNZWmQ3?=
 =?utf-8?B?R1JEdjZwM0dLODFEY0RvMDJHR01Dd25SVHo0b0xpTm5naGEwWkNuT2hiSEov?=
 =?utf-8?B?bVp2SGcvRnhGaUFQdTJudmpYbWFCMGs4U0RvelBDR2R2ME0yK2Z3YjJoZ1Jo?=
 =?utf-8?B?NFZ1aTc5NElNVkFSR2oyNUhnL1VDSGFKME5zRjdyM1hUVnRobWI2R2hXanY2?=
 =?utf-8?B?ODNhM3h4bmVEOGhSc3BkUUM0dDF1cngzZHR1VXBvSVJVVzhkUnhPRjlETEJY?=
 =?utf-8?B?SnB2VjJ0WHBaUytQODBkNGFlZUhveUtES05MRmRUUDF1L3BoWW5FdC9nOXYv?=
 =?utf-8?B?a2JocERYN1hMVjY1NHdDR1ZPcUpiaE5jbmh6a1VoREJhNzBuU1Myc1c2blFN?=
 =?utf-8?B?Y0tTdHFlVjRvbWpKT1drckt3TFo4azN2TkZ2bXcvRSswalU4ZmNBQUdwdGww?=
 =?utf-8?B?UlQrUW5VWEd4VWRqS1ZITkV4ZkFMODNVaFBCOVRVdDZDUFZyRnBNTGRrYWVp?=
 =?utf-8?B?M0lxcGY0VHlXaHNyYkpNK1BISGFzVklsRG9CMGJDRU5tVVBrb29kcVlRTkcx?=
 =?utf-8?B?MU1sa3B2a1VDcksyMGVUOEhNb0F0dzRhZnd5elYrcG5tRW5Ya2JxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799bc4bb-64b6-4171-2a22-08da2779a599
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 11:41:05.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmXM5nx1IXRSbPQCJsy407IuU0M6v152bqeVoietkLRAYmC8DjMyLFCdZH4LJ9to0PV16vq1U5jEwqB7f339BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Apr-22 3:27 PM, Robert Richter wrote:
> On 25.04.22 10:13:19, Ravi Bangoria wrote:
>> PMU driver can advertise certain feature via capability attribute('caps'
>> sysfs directory) which can be consumed by userspace tools like perf. Add
>> zen4_ibs_extensions capability attribute for IBS pmus. This attribute
>> will be enabled when CPUID_Fn8000001B_EAX[11] is set.
>>
>> Without patch:
>>
>>   $ ls /sys/bus/event_source/devices/ibs_op/caps
>>   ls: cannot access '/sys/.../ibs_op/caps': No such file or directory
>>
>> With patch:
>>
>>   $ ls /sys/bus/event_source/devices/ibs_op/caps
>>   zen4_ibs_extensions
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  arch/x86/events/amd/ibs.c | 34 ++++++++++++++++++++++++++++------
>>  1 file changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index a5303d62060c..54e12bd7843e 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -95,8 +95,10 @@ struct perf_ibs {
>>  	struct cpu_perf_ibs __percpu	*pcpu;
>>  
>>  	struct attribute		**format_attrs;
>> +	struct attribute		**caps_attrs;
>>  	struct attribute_group		format_group;
>> -	const struct attribute_group	*attr_groups[2];
>> +	struct attribute_group		caps_group;
>> +	const struct attribute_group	*attr_groups[3];
> 
> Also add a macro for max groups.

Same as previous patch, except defining size of the array, it won't
be used anywhere else.

> 
>>  
>>  	u64				(*get_count)(u64 config);
>>  };
>> @@ -522,10 +524,13 @@ PMU_FORMAT_ATTR(rand_en,	"config:57");
>>  PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
>>  PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
>>  PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
>> +PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
>>  
>>  /* size = nr attrs plus NULL at the end */
>>  static struct attribute *ibs_fetch_format_attrs[3];
>>  static struct attribute *ibs_op_format_attrs[3];
>> +static struct attribute *ibs_fetch_caps_attrs[2];
>> +static struct attribute *ibs_op_caps_attrs[2];
>>  
>>  static struct perf_ibs perf_ibs_fetch = {
>>  	.pmu = {
>> @@ -548,6 +553,7 @@ static struct perf_ibs perf_ibs_fetch = {
>>  	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
>>  	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
>>  	.format_attrs		= ibs_fetch_format_attrs,
>> +	.caps_attrs		= ibs_fetch_caps_attrs,
>>  
>>  	.get_count		= get_ibs_fetch_count,
>>  };
>> @@ -574,6 +580,7 @@ static struct perf_ibs perf_ibs_op = {
>>  	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
>>  	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,
>>  	.format_attrs		= ibs_op_format_attrs,
>> +	.caps_attrs		= ibs_op_caps_attrs,
>>  
>>  	.get_count		= get_ibs_op_count,
>>  };
>> @@ -728,6 +735,7 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
>>  {
>>  	struct cpu_perf_ibs __percpu *pcpu;
>>  	int ret;
>> +	int i = 0;
> 
> 'group'? Use a pointer to iterate over groups here same as for attrs?
> 
> 	struct attribute_group **group = &perf_ibs->attr_groups;

Sure.

> 
>>  
>>  	pcpu = alloc_percpu(struct cpu_perf_ibs);
>>  	if (!pcpu)
>> @@ -736,16 +744,26 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
>>  	perf_ibs->pcpu = pcpu;
>>  
>>  	/* register attributes */
>> +	memset(&perf_ibs->attr_groups, 0, sizeof(perf_ibs->attr_groups));
> 
> With a termination below this could be dropped.

I think we can just remove this line. perf_ibs points to either perf_ibs_fetch
or perf_ibs_op, both of which are global variables and would be preinitialized
with 0s.

> 
>>  	if (perf_ibs->format_attrs[0]) {
>>  		memset(&perf_ibs->format_group, 0, sizeof(perf_ibs->format_group));
>> -		perf_ibs->format_group.name	= "format";
>> -		perf_ibs->format_group.attrs	= perf_ibs->format_attrs;
>> +		perf_ibs->format_group.name = "format";
>> +		perf_ibs->format_group.attrs = perf_ibs->format_attrs;
>>  
>> -		memset(&perf_ibs->attr_groups, 0, sizeof(perf_ibs->attr_groups));
>> -		perf_ibs->attr_groups[0]	= &perf_ibs->format_group;
>> -		perf_ibs->pmu.attr_groups	= perf_ibs->attr_groups;
>> +		perf_ibs->attr_groups[i++] = &perf_ibs->format_group;
> 
> So this could be:
> 
> 		*groups++ = &perf_ibs->format_group
> 
>>  	}
>>  
>> +	if (perf_ibs->caps_attrs[0]) {
>> +		memset(&perf_ibs->caps_group, 0, sizeof(perf_ibs->caps_group));
>> +		perf_ibs->caps_group.name = "caps";
>> +		perf_ibs->caps_group.attrs = perf_ibs->caps_attrs;
>> +
>> +		perf_ibs->attr_groups[i++] = &perf_ibs->caps_group;
> 
> Similar here.
> 
>> +	}
> 
> Add a terminating NULL pointer for groups here.
> 
>> +
>> +	if (i)
> 
> 	if (perf_ibs->attr_groups[0])
> 		...
> 
>> +		perf_ibs->pmu.attr_groups = perf_ibs->attr_groups;
>> +
>>  	ret = perf_pmu_register(&perf_ibs->pmu, name, -1);
>>  	if (ret) {
>>  		perf_ibs->pcpu = NULL;
>> @@ -758,6 +776,7 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
>>  static __init void perf_ibs_fetch_prepare(void)
>>  {
>>  	struct attribute **format_attrs = perf_ibs_fetch.format_attrs;
>> +	struct attribute **caps_attr = perf_ibs_fetch.caps_attrs;
> 
> Now I see why it was renamed, ok.

Yup.

Thanks for the review,
Ravi
