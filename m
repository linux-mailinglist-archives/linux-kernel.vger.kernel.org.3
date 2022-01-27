Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E149E052
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiA0LLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:11:35 -0500
Received: from foss.arm.com ([217.140.110.172]:54800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbiA0LLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:11:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48EDA1FB;
        Thu, 27 Jan 2022 03:11:34 -0800 (PST)
Received: from [10.57.39.22] (unknown [10.57.39.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9526B3F7D8;
        Thu, 27 Jan 2022 03:11:31 -0800 (PST)
Message-ID: <1ec258b8-c6dd-aa0f-8583-2d7667314be9@arm.com>
Date:   Thu, 27 Jan 2022 11:11:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Andrew Kilroy <andrew.kilroy@arm.com>
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
To:     Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
 <20211214184240.24215-2-andrew.kilroy@arm.com>
 <CAP-5=fXJeH0ZvcHPa20N5KfLwnYSw29rpK3OrnvE0o3u-vGTLA@mail.gmail.com>
 <b1640897-10d7-c11e-4a7a-d17633916c8e@huawei.com>
 <5a2e29c1-2c7e-1b55-9192-62060309aeca@arm.com>
 <12e0deef-08db-445f-4958-bcd5c3e10367@linux.intel.com>
Content-Language: en-US
In-Reply-To: <12e0deef-08db-445f-4958-bcd5c3e10367@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,


On 21/12/2021 14:03, Andi Kleen wrote:
> 
> On 12/20/2021 9:21 AM, Andrew Kilroy wrote:
>>
>> On 15/12/2021 10:52, John Garry wrote:
>>> Hi Andrew,
>>>
>>>>>   const struct pmu_event *metricgroup__find_metric(const char *metric,
>>>>>                                                   const struct 
>>>>> pmu_events_map *map);
>>>>>   int metricgroup__parse_groups_test(struct evlist *evlist,
>>>>> diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
>>>>> index 1081b20f9891..57c0c5f2c6bd 100644
>>>>> --- a/tools/perf/util/topdown.c
>>>>> +++ b/tools/perf/util/topdown.c
>>>>> @@ -56,3 +56,9 @@ __weak bool arch_topdown_sample_read(struct evsel 
>>>>> *leader __maybe_unused)
>>>>>   {
>>>>>          return false;
>>>>>   }
>>>>> +
>>>>> +__weak bool arch_topdown_use_json_metrics(void)
>>>>> +{
>>>
>>> AFAICS, only x86 supports topdown today and that is because they have 
>>> special kernel topdown events exposed for the kernel CPU PMU driver. 
>>> So other architectures - not only arm - would need rely on 
>>> metricgroups for topdown support. So let's make this generic for all 
>>> archs.
>>>
>>>> I like this extension! I've ranted in the past about weak symbols
>>>> breaking with archives due to lazy loading [1]. In this case
>>>> tools/perf/arch/arm64/util/topdown.c has no other symbols within it
>>>> and so the weak symbol has an extra chance of being linked
>>>> incorrectly. We could add a new command line of --topdown-json to
>>>> avoid this, but there seems little difference in doing this over just
>>>> doing '-M TopDownL1'.
>>>
>>>
>>>> Is it possible to use the json metric approach
>>>> for when the CPU version fails?
>>>
>>> I think that's a good idea.
>>>
>>
>>
>> While looking into using the json metrics approach as a fallback to 
>> the original, I noticed  there are two json metricgroups 'TopdownL1' 
>> and 'TopDownL1' (note the case difference) on x86. Not sure if the 
>> case difference is intentional.
>>
>> On skylake, 'TopdownL1' contains the four json metrics Retiring, 
>> Bad_Speculation, Frontend_Bound, and Backend_Bound.  'TopDownL1' has 
>> 'SLOTS', 'CoreIPC', 'CoreIPC_SMT', 'Instructions'.  I think its a 
>> similar situation on other x86 chips.
> 
> 
> There's also SMT metrics.
> 
> 
> We don't want to include CoreIPC etc. by default because it would cause 
> multiplexing in common situations.
> 
>>
>> The search for those metrics by metricgroup name is case insensitive, 
>> so it's picking up all 8 metrics when using the lookup string 
>> 'TopDownL1'.  So the extra 'SLOTS', 'CoreIPC', 'CoreIPC_SMT', 
>> 'Instructions' metrics would be printed as well.
>>
>> Not sure what the significance of the case difference might be.
>>
>> Should we use a different string than 'TopDownL1' as the metric group 
>> name to search for?
> 
> 
> We should probably fix the case (or just make the match case insensitive)
> 
> Can we just keep x86 at using the kernel metrics? On Skylake and earlier 
> it needs different formulas and other options depending whether SMT is 
> on or off, so it's not straight forward to express it as json directly.
> 

I posted a v2 of these patches which keeps x86 only using the kernel 
metrics.

 
https://lore.kernel.org/linux-perf-users/20220111150749.13365-1-andrew.kilroy@arm.com/

Would be good to get your feedback,

Thanks
Andrew

