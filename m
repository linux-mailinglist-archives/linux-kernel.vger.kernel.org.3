Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C115224B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiEJTYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiEJTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:24:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B442268676;
        Tue, 10 May 2022 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652210683; x=1683746683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=23iCMiXe5e7MlRGiOzIxGkq98V+Wt6seKcCwq1pWTDE=;
  b=HaqX10x6VrgHojdLHywpg6wvJX03bCGIeWEZkr5J+NHpiEmC2IBIYl4f
   qXKUPBBdM9LQ8r13cVYwuOefi+lyG7b91AUXYTGoSCyWZEDVpo2u/aFNs
   mSll826TVAoF9RRfcuEOZs4uaoOR+s9N0NxNy/jxqfrcgFW7YMl1FHk8x
   3bkGctM0HPrn3R/9P76OPnYx9VWyOFlKfaIOtlo7L4pzPTMi7AbIg5PA6
   1YMknWIba4wICEGglnSALh8na/YyvYc5wLSRIh6Vh5Y/QBM1DOXW40t8f
   FvygL/Xwi57VeWRQwcrAIB0xbq7YJ82YMoZxxCX2q7SAsFmDN9EGp/1Xz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="355908932"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="355908932"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 12:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="711172537"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2022 12:24:42 -0700
Received: from [10.252.212.108] (kliang2-MOBL.ccr.corp.intel.com [10.252.212.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 67144580BE2;
        Tue, 10 May 2022 12:24:39 -0700 (PDT)
Message-ID: <86b7143f-b757-a2d3-b837-686b420cf3c8@linux.intel.com>
Date:   Tue, 10 May 2022 15:24:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] perf evlist: Keep topdown counters in weak group
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
References: <20220505043846.3165303-1-irogers@google.com>
 <87b89e2c-da5c-52c3-40dc-448e874cb5d8@linux.intel.com>
 <CAP-5=fVHhWu1uJHnTfFYWvM02_F-bFBZaaOYo8zPRiA=ODRxGQ@mail.gmail.com>
 <12c03e85-cb48-d264-5f04-e9bf9faaf739@linux.intel.com>
 <CAP-5=fW9Cp3ShO=tTQddDWXz+nrSip99HrNW7Wv5_Qsy1UT7bw@mail.gmail.com>
 <83417b72-4872-072a-2328-a88d2bb90858@linux.intel.com>
 <CAP-5=fXnYUnbT89q9W0Ax3d-26jbL5Mcd7O5X=JcXq9FnOUm7Q@mail.gmail.com>
 <0c8da8b4-4f77-4329-9e63-721d05fd258d@linux.intel.com>
 <CAP-5=fUwSkikUiLpXURYKM4FEf=0zMW9a3Q5h8=Wg08ht5KXHw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUwSkikUiLpXURYKM4FEf=0zMW9a3Q5h8=Wg08ht5KXHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2022 12:58 PM, Ian Rogers wrote:
> On Mon, May 9, 2022 at 2:01 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> On 5/9/2022 1:28 PM, Ian Rogers wrote:
>>> On Thu, May 5, 2022 at 12:44 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 5/5/2022 2:31 PM, Ian Rogers wrote:
>>>>>>> So I think fixing all of these should be a follow up. I am working to
>>>>>>> get access to an Alderlake system, could we land this first?
>>>>>>>
>>>>>> I think we can use pmu_name to replace the "cpu" to fix the issue for
>>>>>> the hybrid platform. For a hybrid platform, the pmu_name is either
>>>>>> cpu_atom or cpu_core.
>>>>>>
>>>>>> Besides, the topdown events may have a PMU prefix, e.g.,
>>>>>> cpu_core/topdown-be-bound/. The strcasecmp may not work well for this case.
>>>>>>
>>>>>> How about the below patch?
>>>>>> If it's OK for you, could you please merge it into your V2 patch set?
>>>>>> I can do the test on a ADL system.
>>>>>>
>>>>>> diff --git a/tools/perf/arch/x86/util/evsel.c
>>>>>> b/tools/perf/arch/x86/util/evsel.c
>>>>>> index 40b171de2086..551ae2bab70e 100644
>>>>>> --- a/tools/perf/arch/x86/util/evsel.c
>>>>>> +++ b/tools/perf/arch/x86/util/evsel.c
>>>>>> @@ -33,11 +33,12 @@ void arch_evsel__fixup_new_cycles(struct
>>>>>> perf_event_attr *attr)
>>>>>>
>>>>>>      bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>>>>>>      {
>>>>>> -       if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
>>>>>> -           !pmu_have_event("cpu", "slots"))
>>>>>> +       const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
>>>>>> +
>>>>>> +       if (!pmu_have_event(pmu_name, "slots"))
>>>>>>                    return false;
>>>>> Hmm. The idea with this test is to see if the architecture supports
>>>>> topdown events before going further. There's a similar test in all the
>>>>> arch_evlist functions. I think with cpu_core this needs to become:
>>>>>
>>>>
>>>> The case is a little bit different here. For the arch_evlist functions,
>>>> the input is the evlist, not the specific evsel. So we have to check all
>>>> the possible PMU names which are "cpu" and "cpu_core". Then we decide
>>>> whether going further.
>>>>
>>>> The input of the evsel__must_be_in_group() is the evsel. The PMU name is
>>>> stored in the evsel->pmu_name. I don't think we need to check all the
>>>> possible PMU names. Using evsel->pmu_name should be good enough.
>>>>
>>>>> if (!pmu_have_event("cpu", "slots") && !pmu_have_event("cpu_core", "slots") )
>>>>>
>>>>> But we should add a helper function for this. It is odd to have this
>>>>> change supporting Alderlake but the existing evlist work not. Perhaps
>>>>> we should just wait until Zhengjun's patches land.
>>>>
>>>> Yes, a helper function is good for the arch_evlist functions. But I
>>>> don't think this patch needs the helper function. Zhengjun's patches are
>>>> to fix the other topdown issues on ADL. There is no dependency between
>>>> this patch and zhengjun's patches.
>>>>
>>>> Thanks,
>>>> Kan
>>>
>>> TL;DR I think we can move forward with landing these patches to fix Icelake.
>>
>> This patch doesn't work with the hybrid platform for sure. I can send
>> you a fix for the hybrid part if you prefer this way? Then I guess you
>> may append it as the patch 3 for V2.
>>
>> Besides the hybrid thing, the patch set also has other two issues I
>> mentioned in the previous reply.
>> - I don't think the strcasecmp() can handle the case like
>> cpu/topdown-bad-spec/ or cpu/slots/. It should be an issue for both
>> hybrid and non-hybrid platforms.
>> - It's better not to use non-architecture events, e.g., baclears.any,
>> ARITH.DIVIDER_ACTIVE, even in the test case. The non-architecture events
>> may be disappear in the future platforms. If so, you have to update the
>> test case again for the future platforms.
>> IMHO, I don't think the patch set is ready.
> 
> So all the stated objections are that I'm checking cpu/slots/ for an
> indication of topdown support and this doesn't work for hybrid?

No, besides the hybrid issue, I also pointed out two non-hybrid issues 
for the patch set.

Have you tried this with the patch set on ICX?

./perf stat -e 
'{cpu/slots/,cpu/topdown-bad-spec/,cpu/topdown-be-bound/,cpu/topdown-fe-bound/,cpu/topdown-retiring/,branch-instructions,branch-misses,bus-cycles,cache-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,cache-misses,cache-references}:W' 
-a sleep 1

I don't think it works.


The ARITH.DIVIDER_ACTIVE is already a deprecated event in SPR.
I don't think we want to update the test case for the platform after SPR.


> This
> is identical to the arch evlist code:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/arch/x86/util/evlist.c?h=perf/core#n10
> both in the functions arch_evlist__add_default_attrs and
> arch_evlist__leader (one I wrote and one I didn't). So the patch set
> isn't ready because I haven't fixed alderlake, but alderlake already
> isn't working? And there is no example of how to make this work for
> alderlake. So basically your ask is that I bring up alderlake. I think
> this is stretching things for a patch fixing icelake. The value here
> is in fixing icelake and alderlake will have to be the next problem.
> 
>>>
>>> For Alderlake/hybrid we have a problem. To determine what happens with
>>> grouping we need to know does the CPU have topdown events? This is a
>>> runtime question for doing perf_event_open and so an arch test and
>>> weak symbol are appropriate. For Icelake we are determining the
>>> presence of topdown events by looking at the special PMU cpu. For
>>> Alderlake the same information can be found by looking at the PMUs
>>> cpu_core and cpu_atom, but how to discover those PMU names?
>>
>> The PMU name can be retrieved either from the event list or perf command.
>> For the non-hybrid, the PMU name is hard code to "cpu" for the core
>> events. So users/event files don't need to specify the PMU name.
>> For the hybrid platform, a PMU name is required and stored in the
>> evsel->pmu_name. If the evsel->pmu_name is NULL, we can assume that it's
>> a non-hybrid PMU, CPU.
> 
> This doesn't make sense. Hybrid implies more than 1 CPU type, how can
> more than one be the same as 1 type to be used for the PMU? 

One event can only belongs to one PMU. It's saved in the evsel->pmu_name.
But it may be NULL on a non-hybrid machine, because there is only one 
CPU type for a non-hybrid machine. The old code may not set the variable.

> Again, you
> are asking I make all the alderlake logic work and I think that should
> be follow up.

I didn't ask you to make all the alderlake logic work.

What I asked is not to introduce more such kind problem, because we 
already have enough to fix.

I even offered you a fixed patch for the problem.

https://lore.kernel.org/all/f1c212e3-c1fd-4a2d-0dfe-bc913d4f4f36@linux.intel.com/T/#m22465c6d35be59fc853a7d86f5bd6025ce7e539b


> As shown above the arch evlist code also needs fixing as
> follow up.

Zhengjun is working on them. There is no dependency between this patch 
and that fix. Don't worry about it.


Thanks,
Kan
