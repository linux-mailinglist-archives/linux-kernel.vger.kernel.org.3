Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928965266E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382328AbiEMQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350972AbiEMQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:18:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD35510FCF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652458718; x=1683994718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gbF5LfIL6sZKxxNy3tAKZN1ztiZDXWL4woGO7URxf38=;
  b=ZsyskEUvrK9ovNFKbbUvuD/6gAmmayNar8f9E47EMeHq3QGsHHKjA6m6
   4lPhuEU6XmGmqpg30E/IcxZYd54u9wkg0Jww3GXX26V+2r7ju5tv4kPSk
   dsFvjfEEUJ9Ap3cXPv+Sq+rthwUnIIBjz4E2kOtFVZzWNc9xJoT94n6dp
   Fh3eBrE4rA9lAUHLJeN9WWhls8m1VWFZxYM0IwX9brOZtlu+h0AX1tgis
   lpdN1E346WKdvjCRVNt9SvlRnu8RrWbdm5Dx0OmTas77AXywvmC55lM5t
   Pw5S22aMZdbSzqeSnJ53v7NP9+OfscSj6v8sce5bBNfpWiK9+ot7EItN3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="269177532"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="269177532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 09:11:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="595291553"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.36.190])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 09:11:29 -0700
Message-ID: <24814c81-fdff-17f1-e686-2dc968381e20@intel.com>
Date:   Fri, 13 May 2022 19:11:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V2 22/23] perf tools: Allow system-wide events to keep
 their own CPUs
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-23-adrian.hunter@intel.com>
 <CAM9d7cg8JRK2oVUvmWit=F5zhLhpqP=gD6iYBAa8_O-+c=EjPQ@mail.gmail.com>
 <52f201d4-4fab-c2f4-9c4d-af887900732f@intel.com>
 <CAM9d7cgDCd2uUJbWcvqmCDGMoPc9kppx--_rcO2OVp_GarLJkg@mail.gmail.com>
 <f92a7681-30ca-eaf5-6f3e-de54bc19adec@intel.com>
 <9ae6d64e-a935-94f0-d2a9-cc49a578ba1c@linux.intel.com>
 <84737c6c-6fc5-57a1-b964-73a4ae8bf4be@intel.com>
 <584b0753-5e69-16b7-014f-7115d6b88683@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <584b0753-5e69-16b7-014f-7115d6b88683@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/22 18:46, Liang, Kan wrote:
> 
> 
> On 5/13/2022 11:21 AM, Adrian Hunter wrote:
>> On 13/05/22 17:12, Liang, Kan wrote:
>>>
>>>
>>> On 5/13/2022 12:48 AM, Adrian Hunter wrote:
>>>> On 12/05/22 21:53, Namhyung Kim wrote:
>>>>> On Thu, May 12, 2022 at 3:35 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>
>>>>>> On 12/05/22 08:27, Namhyung Kim wrote:
>>>>>>> On Fri, May 6, 2022 at 5:27 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>>>
>>>>>>>> Currently, user_requested_cpus supplants system-wide CPUs when the evlist
>>>>>>>> has_user_cpus. Change that so that system-wide events retain their own
>>>>>>>> CPUs and they are added to all_cpus.
>>>>>>>>
>>>>>>>> Acked-by: Ian Rogers <irogers@google.com>
>>>>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>>>>> ---
>>>>>>>>    tools/lib/perf/evlist.c | 11 +++++------
>>>>>>>>    1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
>>>>>>>> index 1c801f8da44f..9a6801b53274 100644
>>>>>>>> --- a/tools/lib/perf/evlist.c
>>>>>>>> +++ b/tools/lib/perf/evlist.c
>>>>>>>> @@ -40,12 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>>>>>>>>            * We already have cpus for evsel (via PMU sysfs) so
>>>>>>>>            * keep it, if there's no target cpu list defined.
>>>>>>>>            */
>>>>>>>> -       if (!evsel->own_cpus || evlist->has_user_cpus) {
>>>>>>>> -               perf_cpu_map__put(evsel->cpus);
>>>>>>>> -               evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>>>>>>>> -       } else if (!evsel->system_wide &&
>>>>>>>> -                  !evsel->requires_cpu &&
>>>>>>>> -                  perf_cpu_map__empty(evlist->user_requested_cpus)) {
>>>>>>>> +       if (!evsel->own_cpus ||
>>>>>>>> +           (!evsel->system_wide && evlist->has_user_cpus) ||
>>>>>>>> +           (!evsel->system_wide &&
>>>>>>>> +            !evsel->requires_cpu &&
>>>>>>>> +            perf_cpu_map__empty(evlist->user_requested_cpus))) {
>>>>>>>
>>>>>>> This is getting hard to understand.  IIUC this propagation basically
>>>>>>> sets user requested cpus to evsel unless it has its own cpus, right?
>>>>>>
>>>>>> I put the conditional logic altogether because that is kernel style but
>>>>>> it does make it practically unreadable.
>>>>>>
>>>>>> If we start with the original logic:
>>>>>>
>>>>>>           if (!evsel->own_cpus || evlist->has_user_cpus) {
>>>>>>                   perf_cpu_map__put(evsel->cpus);
>>>>>>                   evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>>>>>>           } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus)) {
>>>>>>                   perf_cpu_map__put(evsel->cpus);
>>>>>>                   evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>>>>>>           } else if (evsel->cpus != evsel->own_cpus) {
>>>>>>                   perf_cpu_map__put(evsel->cpus);
>>>>>>                   evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
>>>>>>           }
>>>>>>
>>>>>> Then make it more readable, i.e. same functionality
>>>>>>
>>>>>>           struct perf_cpu_map *cpus;
>>>>>>
>>>>>>           if (!evsel->own_cpus || evlist->has_user_cpus)
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus))
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else
>>>>>>                   cpus = evsel->own_cpus;
>>>>>>
>>>>>>           if (evsel->cpus != cpus) {
>>>>>>                   perf_cpu_map__put(evsel->cpus);
>>>>>>                   evsel->cpus = perf_cpu_map__get(cpus);
>>>>>>           }
>>>>>>
>>>>>> Then separate out the conditions, i.e. still same functionality
>>>>>>
>>>>>>           if (!evsel->own_cpus)
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else if (evlist->has_user_cpus)
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else if (evsel->system_wide)
>>>>>>                   cpus = evsel->own_cpus;
>>>>>>           else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else
>>>>>>                   cpus = evsel->own_cpus;
>>>>>>
>>>>>> Then add the new requires_cpu flag:
>>>>>>
>>>>>>           if (!evsel->own_cpus)
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else if (evlist->has_user_cpus)
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else if (evsel->system_wide)
>>>>>>                   cpus = evsel->own_cpus;
>>>>>> -       else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>>>>>> +       else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else
>>>>>>                   cpus = evsel->own_cpus;
>>>>>>
>>>>>> Then make system_wide keep own_cpus even if has_user_cpus:
>>>>>>
>>>>>>           if (!evsel->own_cpus)
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>> +       else if (evsel->system_wide)
>>>>>> +               cpus = evsel->own_cpus;
>>>>>>           else if (evlist->has_user_cpus)
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>> -       else if (evsel->system_wide)
>>>>>> -               cpus = evsel->own_cpus;
>>>>>>           else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else
>>>>>>                   cpus = evsel->own_cpus;
>>>>>>
>>>>>> Which leaves:
>>>>>>
>>>>>>           if (!evsel->own_cpus)
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else if (evsel->system_wide)
>>>>>>                   cpus = evsel->own_cpus;
>>>>>>           else if (evlist->has_user_cpus)
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else
>>>>>>                   cpus = evsel->own_cpus;
>>>>>>
>>>>>> And putting it back together:
>>>>>>
>>>>>>           if (!evsel->own_cpus ||
>>>>>>               (!evsel->system_wide && evlist->has_user_cpus) ||
>>>>>>               (!evsel->system_wide &&
>>>>>>                !evsel->requires_cpu &&
>>>>>>                perf_cpu_map__empty(evlist->user_requested_cpus))) {
>>>>>>                   cpus = evlist->user_requested_cpus;
>>>>>>           else
>>>>>>                   cpus = evsel->own_cpus;
>>>>>>
>>>>>> Perhaps I shouldn't put it together?
>>>>>
>>>>> Cool, thanks a lot for explaining it in detail.
>>>>> I do not oppose your change but little worried about the
>>>>> complexity.  And I think we have some issues with uncore
>>>>> events already.
>>>>
>>>> Yes it is a bit complicated because we are handling
>>>> many different use cases.
>>>>
>>>>>
>>>>> So do you have any idea where evsel->own_cpus
>>>>> doesn't propagate to evsel->cpus?
>>>>
>>>> We let the user's list of CPUs override it i.e. the
>>>> evlist->has_user_cpus case.  Essentially we are expecting
>>>> the user to know what they are doing.
>>>>
>>>>>
>>>>> I think evsel->system_wide and evsel->requires_cpu
>>>>> can be replaced to check evsel->own_cpus instead.
>>>>
>>>> Not at the moment because we let the user override
>>>> own_cpus.
>>>
>>> Do we check whether the user's input is valid (match the PMU's cpumask) before the override?
>>>
>>> I think we know the PMU name. The cpumask of the PMU can be found in the sysfs. So we should have enough information for a sanity check.
>>
>> For the uncore PMU case, I am not sure what sanity is :-)
>>
> 
> For a non-core PMU, e.g., uncore, cstate, power and etc. The cpumask is under the /sys/devices/<PMU>/cpumask. It shows the cpumask which kernel supports. If a end user request a different CPU other that the cpumask, I think it's better throw a waning. It should mitigate the confusion which Namhyung mentioned (uncore -C1,2).

So you couldn't get uncore events unless you are also coincidentally wanting to trace CPU 0.

I guess really the requrement is not to perf_event_open() an uncore PMU more than once? 
To figure that out we'd need to be able map CPUs to uncore PMUs?

> 
>> I don't know about the hybrid case.  I suspect it doesn't
>> work because it would need to intersect own_cpus with
>> user_requested_cpus if has_user_cpus, wouldn't it?
> 
> For the hybrid, the cpumask is named as "cpus" under the sysfs. The name is the same for both X86 and Arm.
> The current kernel will filter out the CPU which is not in the cpumask.
> For the tool, I think we can throw a warning as well if the user requests the unsupported CPU.

Ok, I was assuming we were using atom and core PMUs at the same time, so if the user
asks for some of each that should be fine.

> 
> Actually, there is already a patch to check and print a warning for the hybrid group. See commit 660e533e87ff ("perf stat: Warn group events from different hybrid PMU"), but it's X86 specific.
> 
> Maybe we can introduce a generic way by checking the "cpus" of the core PMU for both X86 and Arm. Then the above patch may be dropped.
> 
> Thanks,
> Kan
> 
>>
>>>
>>>
>>>>
>>>>>
>>>>> Actually evlist->has_user_cpus is checked first so
>>>>> uncore events' own_cpus might not be used.
>>>>
>>>> Yes
>>>>
>>>>>
>>>>> In my laptop, perf stat -a -A -e imc/data_reads/
>>>>> will use cpu 0 as it's listed in the pmu cpumask.
>>>>> But when I use -C1,2 it'll use the both cpus and
>>>>> returns the similar values each (so the sum is 2x).
>>>>
>>>> We expect the user to understand the uncore PMU they
>>>> are using.  AFAICT an uncore PMU cpu mask with only
>>>> CPU 0 typically means a single PMU that counts events
>>>> that could be indrectly caused by any CPU.  When the
>>>> cpu mask has more than one CPU, it means a PMU for
>>>> each of a group of CPU's (e.g. a core or socket)
>>>>
>>>> So in the example you gave above, there is only 1 PMU
>>>> and reading from any CPU will give it's value.
>>>>
>>>> A user providing a list of CPUs for uncore events
>>>> is useful only in certain cases.  For example when
>>>> each core has an uncore PMU and you only want to get
>>>> values from one core.
>>>>
>>>>>
>>>>> I'm not sure if it's intended.  I expect it runs on
>>>>> cpu 0 or one of the given cpus.  Or it runs on both
>>>>> cpus and returns value in half so that the sum is
>>>>> the same as the original value (from a cpu).
>>>
>>> It runs on CPU0. The kernel will correct the CPU when initializing the event. The uncore is per-die (For the most current platforms, die is the same as socket.). Usually, it runs on the first CPU of a die.
>>> For the -C 1,2 uncore/event/ case, the current tool creates two events. One for each CPU. The kernel will find the die ID of the input CPU first, then correct it to the first CPU of the die, which is 0.
>>> So from the kernel's perspective, the perf command turns to -C0 uncore/event/ -C0 uncore/event/. That's why you see similar values each. (They should not be exactly the same. That's because they are not in a group.)
>>>
>>>
>>>>
>>>> I don't know if there is anything wrong with the way
>>>> we are handling uncore PMUs, except that I don't know
>>>> if it is documented anywhere.
>>>
>>> Right, we are lacking of the document for the cpumask. I guess I can update it in the Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore. But it's only for the developer.
>>>
>>> At the meantime, I think it may be better to show an error/warning if the user inputs are not matched with the cpumask of the requested PMU. That's for the end users.
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> But the hybrid pmus make this complex.  Maybe we can move the
>>>>>>> logic in evlist__fix_hybrid_cpus() here and simplify it like below
>>>>>>>
>>>>>>> if (evsel->own_cpus) {
>>>>>>>      if (evsel->pmu->is_hybrid)
>>>>>>>         evsel->cpus = fixup_hybrid_cpus(evsel>own_cpus,
>>>>>>>                                         evlist->user_requested_cpus);  //?
>>>>>>>      else
>>>>>>>         evsel->cpus = evlist->own_cpus;  // put + get
>>>>>>> } else {
>>>>>>>      evsel->cpus = evlist->user_requested_cpus;  // put + get
>>>>>>> }
>>>>>>>
>>>>>>> Then we need to make sure evsel->pmu is set properly.
>>>>>>>
>>>>>>> What do you think?
>>>>>>
>>>>>> Hybrid handling looks complicated.  I would have to spend time
>>>>>> better understanding it.
>>>>>>
>>>>>> So, in the context of this patch set, I don't want to look at
>>>>>> issues with hybrid CPUs, except that there should be no change
>>>>>> to how they are handled.
>>>>>
>>>
>>> I think we should at least run perf test on a hybrid machine. We already have some backlog to handle. It's better not to bring more regression issue.
>>>
>>> Thanks,Kan
>>>
>>>
>>>
>>

