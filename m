Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA935265F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381912AbiEMPWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381908AbiEMPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:22:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C473C67D05
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652455325; x=1683991325;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GQE36AppxZlzHNFn1tYD0nv0jnlyG8m+FjVXvMMe1gA=;
  b=brDeZvj3tIrIIsHfx9G9z58W7KvpToBsMz5v4t0WFLgQBdTgO2o4oBhT
   I3WhDlZ9tl31oED1eA218mEP1OI3GFDlmYSu9X0sc3x+z+gcER5Cw7rm3
   cSdQ02z7sFW0c0mJhirTXwIjj7d/VCED1PBIJxLcqp0CvHcqQITh6DOTV
   fiDnXrTkc5bjS3Jak6iy/4qkJGtPeFEsnMwpFi/tNexMOULBmlOTEaIC3
   3VfUgcekHq8giHx3iX0CmwNFQslw4VHVEHRCCZWevNlMlhxgoqRLBitCc
   6A/PvGVFf11cigSeyveI42LHP4tDjzaRrRDiphBeI+zQbyuy6BdvXbVXx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270262275"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270262275"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 08:22:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="595266097"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.36.190])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 08:22:02 -0700
Message-ID: <84737c6c-6fc5-57a1-b964-73a4ae8bf4be@intel.com>
Date:   Fri, 13 May 2022 18:21:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V2 22/23] perf tools: Allow system-wide events to keep
 their own CPUs
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-23-adrian.hunter@intel.com>
 <CAM9d7cg8JRK2oVUvmWit=F5zhLhpqP=gD6iYBAa8_O-+c=EjPQ@mail.gmail.com>
 <52f201d4-4fab-c2f4-9c4d-af887900732f@intel.com>
 <CAM9d7cgDCd2uUJbWcvqmCDGMoPc9kppx--_rcO2OVp_GarLJkg@mail.gmail.com>
 <f92a7681-30ca-eaf5-6f3e-de54bc19adec@intel.com>
 <9ae6d64e-a935-94f0-d2a9-cc49a578ba1c@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <9ae6d64e-a935-94f0-d2a9-cc49a578ba1c@linux.intel.com>
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

On 13/05/22 17:12, Liang, Kan wrote:
> 
> 
> On 5/13/2022 12:48 AM, Adrian Hunter wrote:
>> On 12/05/22 21:53, Namhyung Kim wrote:
>>> On Thu, May 12, 2022 at 3:35 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 12/05/22 08:27, Namhyung Kim wrote:
>>>>> On Fri, May 6, 2022 at 5:27 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>
>>>>>> Currently, user_requested_cpus supplants system-wide CPUs when the evlist
>>>>>> has_user_cpus. Change that so that system-wide events retain their own
>>>>>> CPUs and they are added to all_cpus.
>>>>>>
>>>>>> Acked-by: Ian Rogers <irogers@google.com>
>>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>>> ---
>>>>>>   tools/lib/perf/evlist.c | 11 +++++------
>>>>>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
>>>>>> index 1c801f8da44f..9a6801b53274 100644
>>>>>> --- a/tools/lib/perf/evlist.c
>>>>>> +++ b/tools/lib/perf/evlist.c
>>>>>> @@ -40,12 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>>>>>>           * We already have cpus for evsel (via PMU sysfs) so
>>>>>>           * keep it, if there's no target cpu list defined.
>>>>>>           */
>>>>>> -       if (!evsel->own_cpus || evlist->has_user_cpus) {
>>>>>> -               perf_cpu_map__put(evsel->cpus);
>>>>>> -               evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>>>>>> -       } else if (!evsel->system_wide &&
>>>>>> -                  !evsel->requires_cpu &&
>>>>>> -                  perf_cpu_map__empty(evlist->user_requested_cpus)) {
>>>>>> +       if (!evsel->own_cpus ||
>>>>>> +           (!evsel->system_wide && evlist->has_user_cpus) ||
>>>>>> +           (!evsel->system_wide &&
>>>>>> +            !evsel->requires_cpu &&
>>>>>> +            perf_cpu_map__empty(evlist->user_requested_cpus))) {
>>>>>
>>>>> This is getting hard to understand.  IIUC this propagation basically
>>>>> sets user requested cpus to evsel unless it has its own cpus, right?
>>>>
>>>> I put the conditional logic altogether because that is kernel style but
>>>> it does make it practically unreadable.
>>>>
>>>> If we start with the original logic:
>>>>
>>>>          if (!evsel->own_cpus || evlist->has_user_cpus) {
>>>>                  perf_cpu_map__put(evsel->cpus);
>>>>                  evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>>>>          } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus)) {
>>>>                  perf_cpu_map__put(evsel->cpus);
>>>>                  evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>>>>          } else if (evsel->cpus != evsel->own_cpus) {
>>>>                  perf_cpu_map__put(evsel->cpus);
>>>>                  evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
>>>>          }
>>>>
>>>> Then make it more readable, i.e. same functionality
>>>>
>>>>          struct perf_cpu_map *cpus;
>>>>
>>>>          if (!evsel->own_cpus || evlist->has_user_cpus)
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus))
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else
>>>>                  cpus = evsel->own_cpus;
>>>>
>>>>          if (evsel->cpus != cpus) {
>>>>                  perf_cpu_map__put(evsel->cpus);
>>>>                  evsel->cpus = perf_cpu_map__get(cpus);
>>>>          }
>>>>
>>>> Then separate out the conditions, i.e. still same functionality
>>>>
>>>>          if (!evsel->own_cpus)
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else if (evlist->has_user_cpus)
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else if (evsel->system_wide)
>>>>                  cpus = evsel->own_cpus;
>>>>          else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else
>>>>                  cpus = evsel->own_cpus;
>>>>
>>>> Then add the new requires_cpu flag:
>>>>
>>>>          if (!evsel->own_cpus)
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else if (evlist->has_user_cpus)
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else if (evsel->system_wide)
>>>>                  cpus = evsel->own_cpus;
>>>> -       else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>>>> +       else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else
>>>>                  cpus = evsel->own_cpus;
>>>>
>>>> Then make system_wide keep own_cpus even if has_user_cpus:
>>>>
>>>>          if (!evsel->own_cpus)
>>>>                  cpus = evlist->user_requested_cpus;
>>>> +       else if (evsel->system_wide)
>>>> +               cpus = evsel->own_cpus;
>>>>          else if (evlist->has_user_cpus)
>>>>                  cpus = evlist->user_requested_cpus;
>>>> -       else if (evsel->system_wide)
>>>> -               cpus = evsel->own_cpus;
>>>>          else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else
>>>>                  cpus = evsel->own_cpus;
>>>>
>>>> Which leaves:
>>>>
>>>>          if (!evsel->own_cpus)
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else if (evsel->system_wide)
>>>>                  cpus = evsel->own_cpus;
>>>>          else if (evlist->has_user_cpus)
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else
>>>>                  cpus = evsel->own_cpus;
>>>>
>>>> And putting it back together:
>>>>
>>>>          if (!evsel->own_cpus ||
>>>>              (!evsel->system_wide && evlist->has_user_cpus) ||
>>>>              (!evsel->system_wide &&
>>>>               !evsel->requires_cpu &&
>>>>               perf_cpu_map__empty(evlist->user_requested_cpus))) {
>>>>                  cpus = evlist->user_requested_cpus;
>>>>          else
>>>>                  cpus = evsel->own_cpus;
>>>>
>>>> Perhaps I shouldn't put it together?
>>>
>>> Cool, thanks a lot for explaining it in detail.
>>> I do not oppose your change but little worried about the
>>> complexity.  And I think we have some issues with uncore
>>> events already.
>>
>> Yes it is a bit complicated because we are handling
>> many different use cases.
>>
>>>
>>> So do you have any idea where evsel->own_cpus
>>> doesn't propagate to evsel->cpus?
>>
>> We let the user's list of CPUs override it i.e. the
>> evlist->has_user_cpus case.  Essentially we are expecting
>> the user to know what they are doing.
>>
>>>
>>> I think evsel->system_wide and evsel->requires_cpu
>>> can be replaced to check evsel->own_cpus instead.
>>
>> Not at the moment because we let the user override
>> own_cpus.
> 
> Do we check whether the user's input is valid (match the PMU's cpumask) before the override?
> 
> I think we know the PMU name. The cpumask of the PMU can be found in the sysfs. So we should have enough information for a sanity check.

For the uncore PMU case, I am not sure what sanity is :-)

I don't know about the hybrid case.  I suspect it doesn't
work because it would need to intersect own_cpus with
user_requested_cpus if has_user_cpus, wouldn't it?

> 
> 
>>
>>>
>>> Actually evlist->has_user_cpus is checked first so
>>> uncore events' own_cpus might not be used.
>>
>> Yes
>>
>>>
>>> In my laptop, perf stat -a -A -e imc/data_reads/
>>> will use cpu 0 as it's listed in the pmu cpumask.
>>> But when I use -C1,2 it'll use the both cpus and
>>> returns the similar values each (so the sum is 2x).
>>
>> We expect the user to understand the uncore PMU they
>> are using.  AFAICT an uncore PMU cpu mask with only
>> CPU 0 typically means a single PMU that counts events
>> that could be indrectly caused by any CPU.  When the
>> cpu mask has more than one CPU, it means a PMU for
>> each of a group of CPU's (e.g. a core or socket)
>>
>> So in the example you gave above, there is only 1 PMU
>> and reading from any CPU will give it's value.
>>
>> A user providing a list of CPUs for uncore events
>> is useful only in certain cases.  For example when
>> each core has an uncore PMU and you only want to get
>> values from one core.
>>
>>>
>>> I'm not sure if it's intended.  I expect it runs on
>>> cpu 0 or one of the given cpus.  Or it runs on both
>>> cpus and returns value in half so that the sum is
>>> the same as the original value (from a cpu).
> 
> It runs on CPU0. The kernel will correct the CPU when initializing the event. The uncore is per-die (For the most current platforms, die is the same as socket.). Usually, it runs on the first CPU of a die.
> For the -C 1,2 uncore/event/ case, the current tool creates two events. One for each CPU. The kernel will find the die ID of the input CPU first, then correct it to the first CPU of the die, which is 0.
> So from the kernel's perspective, the perf command turns to -C0 uncore/event/ -C0 uncore/event/. That's why you see similar values each. (They should not be exactly the same. That's because they are not in a group.)
> 
> 
>>
>> I don't know if there is anything wrong with the way
>> we are handling uncore PMUs, except that I don't know
>> if it is documented anywhere.
> 
> Right, we are lacking of the document for the cpumask. I guess I can update it in the Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore. But it's only for the developer.
> 
> At the meantime, I think it may be better to show an error/warning if the user inputs are not matched with the cpumask of the requested PMU. That's for the end users.
> 
>>
>>>
>>>>
>>>>>
>>>>> But the hybrid pmus make this complex.  Maybe we can move the
>>>>> logic in evlist__fix_hybrid_cpus() here and simplify it like below
>>>>>
>>>>> if (evsel->own_cpus) {
>>>>>     if (evsel->pmu->is_hybrid)
>>>>>        evsel->cpus = fixup_hybrid_cpus(evsel>own_cpus,
>>>>>                                        evlist->user_requested_cpus);  //?
>>>>>     else
>>>>>        evsel->cpus = evlist->own_cpus;  // put + get
>>>>> } else {
>>>>>     evsel->cpus = evlist->user_requested_cpus;  // put + get
>>>>> }
>>>>>
>>>>> Then we need to make sure evsel->pmu is set properly.
>>>>>
>>>>> What do you think?
>>>>
>>>> Hybrid handling looks complicated.  I would have to spend time
>>>> better understanding it.
>>>>
>>>> So, in the context of this patch set, I don't want to look at
>>>> issues with hybrid CPUs, except that there should be no change
>>>> to how they are handled.
>>>
> 
> I think we should at least run perf test on a hybrid machine. We already have some backlog to handle. It's better not to bring more regression issue.
> 
> Thanks,Kan
> 
> 
> 

