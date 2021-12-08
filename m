Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A629046CDCF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 07:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbhLHGhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 01:37:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235346AbhLHGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 01:37:16 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B85GFcY022610;
        Wed, 8 Dec 2021 06:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DULwrPD7AZfuc1iKz19PNHX8TzFDSz7Y7ar+WuR+Wlk=;
 b=omwoVqLA+7wjJJDVOU45BG+2V5eFu8CtJtooneoufwdm6REGvSdpyNsMr1F6dnd06ZeM
 z0xrjrrbpWRTIJQtJvkZVH39pQtdYK6x09ngqZb0YyZEXhBaKuJIQrnSZmlqy/3a8svA
 DMsJ/EbGfY0QbJQUy85M5ce44E+WJvDFvB/EUUqYXtwpsS0KR/m1bwG0CR8TLUGs4A6z
 zZAwUmiD2SGboKf7jZcAYiKpf2qcXXzC4/7+MkU5vuYL1y7V5C+AmGhFDHvSE/Ig5XzN
 9Zs5tFGEz2ms25aY0Avx8syHMRUB75Ub5/ByP/8MI6312EYR24sbt7zrv8I4aVQUCIB6 Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ctjfud2kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 06:33:13 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B85n5pU024765;
        Wed, 8 Dec 2021 06:33:12 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ctjfud2jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 06:33:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B86DvRr022610;
        Wed, 8 Dec 2021 06:33:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3cqyya4cr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 06:33:10 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B86X7IK29032812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 06:33:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0EBC4C040;
        Wed,  8 Dec 2021 06:33:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 579CD4C04E;
        Wed,  8 Dec 2021 06:33:03 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.15.149])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 06:33:03 +0000 (GMT)
Subject: Re: [PATCH 2/2] perf tools: Improve IBS error handling
To:     Kim Phillips <kim.phillips@amd.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>
References: <20211004214114.188477-1-kim.phillips@amd.com>
 <20211004214114.188477-2-kim.phillips@amd.com> <YV8uQVnMnnMd1Led@krava>
 <8a8583dc-5a5d-f107-8ef0-6be96e2f9095@amd.com>
 <fdcfec83-01c6-5e25-5b99-dac05287fdae@linux.ibm.com>
 <74e17a71-98ff-e0b1-61d4-d37992b1ae15@amd.com>
 <f095bebf-77d5-94c7-5787-13a6f38867cc@linux.ibm.com>
 <4281dce8-0e2a-cfe8-3b05-1b9a455d09a9@amd.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <e937591b-542d-c3ac-bc64-d5223c27f70d@linux.ibm.com>
Date:   Wed, 8 Dec 2021 12:03:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4281dce8-0e2a-cfe8-3b05-1b9a455d09a9@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hBXggjY0dUVmSLOk5BGJueYSgzrKkYoH
X-Proofpoint-GUID: 3p-vra87S7emHTGL1HLqO050UtxL9qWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_02,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/21 3:39 AM, Kim Phillips wrote:
> On 11/24/21 2:00 AM, kajoljain wrote:
>> On 11/23/21 8:55 PM, Kim Phillips wrote:
>>> On 11/23/21 2:40 AM, kajoljain wrote:
>>>> On 10/8/21 12:47 AM, Kim Phillips wrote:
>>>>> On 10/7/21 12:28 PM, Jiri Olsa wrote:
>>>>>> On Mon, Oct 04, 2021 at 04:41:14PM -0500, Kim Phillips wrote:
>>>>>>> ---
>>>>>>>     tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>>>>>>>     1 file changed, 24 insertions(+)
>>>>>>>
>>>>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>>>>> index b915840690d4..f8a9cbd99314 100644
>>>>>>> --- a/tools/perf/util/evsel.c
>>>>>>> +++ b/tools/perf/util/evsel.c
>>>>>>> @@ -2743,9 +2743,22 @@ static bool find_process(const char *name)
>>>>>>>         return ret ? false : true;
>>>>>>>     }
>>>>>>>     +static bool is_amd(const char *arch, const char *cpuid)
>>>>>>> +{
>>>>>>> +    return arch && !strcmp("x86", arch) && cpuid &&
>>>>>>> strstarts(cpuid,
>>>>>>> "AuthenticAMD");
>>>>>>> +}
>>>>>>> +
>>>>>>> +static bool is_amd_ibs(struct evsel *evsel)
>>>>>>> +{
>>>>>>> +    return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
>>>>>>> "ibs", 3);
>>>>>>> +}
>>>>>>> +
>>>>>>>     int evsel__open_strerror(struct evsel *evsel, struct target
>>>>>>> *target,
>>>>>>>                  int err, char *msg, size_t size)
>>>>>>>     {
>>>>>>> +    struct perf_env *env = evsel__env(evsel);
>>>>>>> +    const char *arch = perf_env__arch(env);
>>>>>>> +    const char *cpuid = perf_env__cpuid(env);
>>>>>>>         char sbuf[STRERR_BUFSIZE];
>>>>>>>         int printed = 0, enforced = 0;
>>>>>>>     @@ -2841,6 +2854,17 @@ int evsel__open_strerror(struct evsel
>>>>>>> *evsel, struct target *target,
>>>>>>>                 return scnprintf(msg, size, "wrong clockid (%d).",
>>>>>>> clockid);
>>>>>>>             if (perf_missing_features.aux_output)
>>>>>>>                 return scnprintf(msg, size, "The 'aux_output'
>>>>>>> feature
>>>>>>> is not supported, update the kernel.");
>>>>>>> +        if (is_amd(arch, cpuid)) {
>>>>>>> +            if (is_amd_ibs(evsel)) {
>>>>>>
>>>>>> would single 'is_amd_ibs' call be better? checking on both amd and
>>>>>> ibs
>>>>>
>>>>> Good suggestion. If you look at the later patch in the
>>>>> BRS series, I have rewritten it to add the new
>>>>> AMD PMU like so:
>>>>>
>>>>>    if (is_amd()) {
>>>>>        if (is_amd_ibs()) {
>>>>>            if (evsel->this)
>>>>>                return
>>>>>            if (evsel->that)
>>>>>                return
>>>>>        }
>>>>> +    if (is_amd_brs()) {
>>>>> +        if (evsel->this)
>>>>> +            return
>>>>> +        if (evsel->that)
>>>>> +            return
>>>>> +    }
>>>>>    }
>>>>
>>>> Hi Kim,
>>>>        From my point of view, it won't be a good idea of adding so many
>>>> checks in common function definition itself.
>>>> Can you just create a check to see if its amd machine and then add a
>>>> function call which will handle all four conditions together?
>>>>
>>>> which is basically for:
>>>>
>>>> +        if (is_amd(arch, cpuid)) {
>>>> +            if (is_amd_ibs(evsel)) {
>>>> +                if (evsel->core.attr.exclude_kernel)
>>>> +                    return scnprintf(msg, size,
>>>> +    "AMD IBS can't exclude kernel events.  Try running at a higher
>>>> privilege level.");
>>>> +                if (!evsel->core.system_wide)
>>>> +                    return scnprintf(msg, size,
>>>> +    "AMD IBS may only be available in system-wide/per-cpu mode.  Try
>>>> using
>>>> -a, or -C and workload affinity");
>>>> +            }
>>>>
>>>> and this:
>>>>
>>>> +            if (is_amd_brs(evsel)) {
>>>> +                if (evsel->core.attr.freq)
>>>> +                    return scnprintf(msg, size,
>>>> +    "AMD Branch Sampling does not support frequency mode sampling,
>>>> must
>>>> pass a fixed sampling period via -c option or
>>>> cpu/branch-brs,period=xxxx/.");
>>>> +                /* another reason is that the period is too small */
>>>> +                return scnprintf(msg, size,
>>>> +    "AMD Branch Sampling does not support sampling period smaller than
>>>> what is reported in /sys/devices/cpu/caps/branches.");
>>>> +            }
>>>
>>> IIRC, I tried something like that but carrying the
>>>
>>>
>>> struct target *target, int err, char *msg, size_t size
>>>
>>> parameters made things worse.
>>>
>>>> So, incase we are in amd machine,  common function evsel__open_strerror
>>>> will call function may be something like amd_evesel_open_strerror_check
>>>> which will look for both ibs and brs conditions and return
>>>> corresponding
>>>> error statement.
>>>
>>> The vast majority of decisions made by evsel__open_strerror are
>>> going to be common across most arch/uarches.  AMD has only these
>>> two pesky exceptions to the rule and therefore IMO it's ok
>>> to have them inline with the common function, since the decisions
>>> are so deeply intertwined.  A new amd_evsel_open_strerror_check
>>> sounds like it'd duplicate too much of the common function code
>>> in order to handle the common error cases.
>>
>> Hi Kim,
>>     Sorry for the confusion, what I meant by adding new function is just
>> to handle these corner error cases and not duplicating whole
>> evsel__open_strerror code.
>>
>> Maybe something like below code, Its just prototype of code to show you
>> the flow, you can refine it and check for any build or indentation
>> issues using checkpatch.pl script.
>>
>> So basically, in common function we can just have 2 calls, first to
>> check if we are in amd system and second to return corresponding error
>> message, rather then adding whole chunk of if's which are specific to
>> amd.
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index ac0127be0459..adefb162ae08 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2852,9 +2852,40 @@ static bool find_process(const char *name)
>>          return ret ? false : true;
>>   }
>>
>> +static bool is_amd(const char *arch, const char *cpuid)
>> +{
>> +       return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid,
>> "AuthenticAMD");
>> +}
>> +
>> +static int error_amd_ibs_brs(struct evsel *evsel, char *msg, size_t
>> size)
>> +{
>> +       if (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
>> "ibs", 3)) {
>> +               if (evsel->core.attr.exclude_kernel)
>> +                       return scnprintf(msg, size,
>> +       "AMD IBS can't exclude kernel events.  Try running at a higher
>> privilege level.");
>> +               if (!evsel->core.system_wide)
>> +                       return scnprintf(msg, size,
>> +       "AMD IBS may only be available in system-wide/per-cpu mode.  Try
>> using -a, or -C and workload affinity");
>> +       }
>> +
>> +       if (((evsel->core.attr.config & 0xff) == 0xc4) &&
>> (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK)) {
>> +               if (evsel->core.attr.freq) {
>> +                       return scnprintf(msg, size,
>> +       "AMD Branch Sampling does not support frequency mode sampling,
>> must pass a fixed sampling
>> +          period via -c option or cpu/branch-brs,period=xxxx/.");
>> +                /* another reason is that the period is too small */
>> +               return scnprintf(msg, size,
>> +       "AMD Branch Sampling does not support sampling period smaller
>> than what is reported in /sys/devices/cpu/caps/branches.");
>> +               }
>> +       }
>> +}
>> +
>>   int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>                           int err, char *msg, size_t size)
>>   {
>> +       struct perf_env *env = evsel__env(evsel);
>> +       const char *arch = perf_env__arch(env);
>> +       const char *cpuid = perf_env__cpuid(env);
>>          char sbuf[STRERR_BUFSIZE];
>>          int printed = 0, enforced = 0;
>>
>> @@ -2950,6 +2981,8 @@ int evsel__open_strerror(struct evsel *evsel,
>> struct target *target,
>>                          return scnprintf(msg, size, "wrong clockid
>> (%d).", clockid);
>>                  if (perf_missing_features.aux_output)
>>                          return scnprintf(msg, size, "The 'aux_output'
>> feature is not supported, update the kernel.");
>> +               if (is_amd(arch, cpuid))
>> +                       return error_amd_ibs_brs(evsel, msg, size);
>>                  break;
>>          case ENODATA:
>>                  return scnprintf(msg, size, "Cannot collect data source
>> with the load latency event alone. "
> 
> That change will makes AMD machines fail to fall back to the default
> "The sys_perf_event_open() syscall returned with..." error string
> in case it's not those AMD IBS and BRS sub-conditions.

Yes right, as I mentioned before, the code I pointed was just a
prototype to show you the flow, these corner cases can be handled on top
of it.

> 
> Is having the AMD error code checking in the main evsel__open_strerror()
> so bad?  Other arches and their PMU implementations may find error
> conditions that they have in common with AMD's, therefore
> opening up the code for opposite types of refactoring and
> reuse than what is being requested here.  E.g., I've seen
> other hardware configurations - not specific to one architecture -
> that could also use this message:
> 

From my understanding, adding too many checks in common function
for a specific arch is not a good practice. Since you already adding
multiple functions to get information like ,if current system is
amd/ibs/brs. Can't we rather just add a single function and handled all
these checks there?
That's just my thoughts, if maintainers are ok with it, then its fine
for me too.

Thanks,
Kajol Jain

> {"AMD IBS"->"%s",pmu_name} may only be available in system-wide/per-cpu
> mode.  Try using -a, or -C and workload affinity");
> 
> Thanks,
> 
> Kim
