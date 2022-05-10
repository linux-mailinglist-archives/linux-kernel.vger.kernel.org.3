Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A23B521DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345103AbiEJPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345121AbiEJPSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:18:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22CF1F617
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652194542; x=1683730542;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ETtsOjDWqOVH6W0WZ13Jpu4HR4pk+sMHooCemDirA3s=;
  b=kwvpNNloNt7aXGeaIxB0vIZAO++DTda4J1O2K9vcEOSlhPbCTpT2/uu9
   myiF5JzsbQ+Oppo7qHzYHzgB3wzxoO6RbgaB2RIMHbOO09OwdG7CEFFFM
   9EbUIMj4YqXuzEuQbnU8JNLcRCn77Umj7H3xdhfdMhP8ZwzbmRmc1X7lO
   hmtVoITOGJmUFlq1gSfVBXXBG7YMVLgvF9AX71ZEct+3YLpkH9nBJrq8h
   gwQqmP/pwPccbDlzpdv+oPaTxla50dAEAD11E6BAeznSruk7bh3vbjv4r
   hXcJRuGcBWwqTkbLvkLlSpr0e3XcTY+XYNBDLtUDJ/jDiID+L6rIQP9bo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="329994033"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="329994033"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:55:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="593550195"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.3])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:55:39 -0700
Message-ID: <0cde1030-e9e5-8688-d98d-6f5f8b2cde27@intel.com>
Date:   Tue, 10 May 2022 17:55:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V2 13/23] perf evlist: Add evlist__add_dummy_on_all_cpus()
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-14-adrian.hunter@intel.com>
 <CAP-5=fV3SWDb8uTsUmdkweRrO9t9OZXzP=9GWqKxTYn0bdfriw@mail.gmail.com>
 <078c3b3a-9976-9ee4-0cd2-11ff6599dbd2@intel.com>
 <CAP-5=fWWHeFN1UeyFU=HS39kQNXHcu74JTdOmw0Nar_ztFG-uw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWWHeFN1UeyFU=HS39kQNXHcu74JTdOmw0Nar_ztFG-uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/05/22 18:35, Ian Rogers wrote:
> On Fri, May 6, 2022 at 8:08 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 6/05/22 16:47, Ian Rogers wrote:
>>> On Fri, May 6, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> Add evlist__add_dummy_on_all_cpus() to enable creating a system-wide dummy
>>>> event that sets up the system-wide maps before map propagation.
>>>>
>>>> For convenience, add evlist__add_aux_dummy() so that the logic can be used
>>>> whether or not the event needs to be system-wide.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  tools/perf/util/evlist.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>>  tools/perf/util/evlist.h |  5 +++++
>>>>  2 files changed, 45 insertions(+)
>>>>
>>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>>> index 78c47cbafbc2..c16bd4836314 100644
>>>> --- a/tools/perf/util/evlist.c
>>>> +++ b/tools/perf/util/evlist.c
>>>> @@ -264,6 +264,46 @@ int evlist__add_dummy(struct evlist *evlist)
>>>>         return 0;
>>>>  }
>>>>
>>>> +static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
>>>> +{
>>>> +       evsel->core.system_wide = true;
>>>> +
>>>> +       /* All CPUs */
>>>> +       perf_cpu_map__put(evsel->core.own_cpus);
>>>> +       evsel->core.own_cpus = perf_cpu_map__new(NULL);
>>>> +       perf_cpu_map__put(evsel->core.cpus);
>>>> +       evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
>>>> +
>>>> +       /* No threads */
>>>> +       perf_thread_map__put(evsel->core.threads);
>>>> +       evsel->core.threads = perf_thread_map__new_dummy();
>>>> +
>>>> +       evlist__add(evlist, evsel);
>>>> +}
>>>> +
>>>> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
>>>> +{
>>>> +       struct evsel *evsel = evlist__dummy_event(evlist);
>>>> +
>>>> +       if (!evsel)
>>>> +               return NULL;
>>>> +
>>>> +       evsel->core.attr.exclude_kernel = 1;
>>>> +       evsel->core.attr.exclude_guest = 1;
>>>> +       evsel->core.attr.exclude_hv = 1;
>>>> +       evsel->core.attr.freq = 0;
>>>> +       evsel->core.attr.sample_period = 1;
>>>> +       evsel->no_aux_samples = true;
>>>> +       evsel->name = strdup("dummy:u");
>>>> +
>>>> +       if (system_wide)
>>>> +               evlist__add_on_all_cpus(evlist, evsel);
>>>> +       else
>>>> +               evlist__add(evlist, evsel);
>>>> +
>>>> +       return evsel;
>>>> +}
>>>> +
>>>>  static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
>>>>  {
>>>>         struct evsel *evsel, *n;
>>>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>>>> index 4062f5aebfc1..1bde9ccf4e7d 100644
>>>> --- a/tools/perf/util/evlist.h
>>>> +++ b/tools/perf/util/evlist.h
>>>> @@ -114,6 +114,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist);
>>>>  struct evsel *arch_evlist__leader(struct list_head *list);
>>>>
>>>>  int evlist__add_dummy(struct evlist *evlist);
>>>> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
>>>> +static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
>>>
>>> Sorry to be a language lawyer. What I hope to clean up with CPU maps is that:
>>>
>>> empty == dummy == any CPU
>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n279
>>>
>>> Given every CPU map should be empty or contain any CPU then it seems
>>> they all meet the definition of empty - so something is wrong.
>>
>> Nothing is wrong.  I am not against clarifying things, but stop assuming
>> natural language has to mean anything exactly.  That is what computer
>> languages are for.
>>
>> Sometimes more abstract language is used, precisely to stop people
>> making assumptions about the details.
>>
>>>
>>> The cpu map here is explicitly opened so that it gets all online CPUs:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n174
>>>
>>> From:
>>> https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/cputopology.rst
>>> there are example topologies like:
>>> kernel_max: 31
>>>    offline: 2,4-31,32-63
>>>     online: 0-1,3
>>>   possible: 0-31
>>>    present: 0-31
>>>
>>> all_cpus could mean the union of offline and online CPUs, possible
>>> CPUs or present CPUs. You are saying that in the perf code all_cpus
>>> should be the same as all online cpus as only those CPUs are valid
>>> with perf_event_open. That's true but offline CPUs can be made online.
>>> If that happens here then the dummy events will have a CPU map that
>>> rather than being for all CPUs will be for all online CPUs at the
>>> point it was opened. Having online in the function name I think
>>> captures the time dependent nature of this - but if you think that's
>>> too much could we add a comment?
>>
>> If you ask me it does the exact opposite.  The function of the code
>> is to put the event on all CPUS without having to know the details
>> of: well actually perf doesn't automagically retain or restore events
>> across enabling or disabling CPUs so in fact we deal only in online
>> CPUs.
> 
> But 'any CPU' (-1) could map to an offline CPU brought online. Calling
> this function twice could also result in this behavior. Via the
> topology documentation we have language to describe exactly the
> scenario that's happening and I'd prefer not to muddy that by making
> all and online synonyms.

In this case the caller wants all CPUs, not online CPUs.  The detail
that we can't trace offline CPUs that become online is not relevant
to the caller.  Why would the caller call a function limited to online
CPUs when that is not what the caller wants.

> 
>>> too much could we add a comment? I'm trying to avoid a situation, like
>>> with the CPU map code, where all and online are interchangeable
>>> leading to the code being unnecessarily confusing unless you read
>>> every line.
>>
>> It is normal to have to read the details of code, and, in my
>> experience at least, normal for the code not to work exactly the
>> way I'd imagined.
> 
> :-) The problem is that we all need to work with abstractions at some
> point, abstraction is pretty much the whole point of computer science.
> We need to fix CPU maps empty function, it is just a fundamental level
> of contradiction. As with the CPU map index being often mistaken for
> the CPU leading to bugs and crashes, I suspect remedying empty will
> fix existing and future bugs. With function naming the point is to be
> short and succinct, but also to be intention revealing for the sake of
> abstraction. Yes you need to read the code, but as with CPU map empty
> even that isn't enough and trying to infer behavior from usage can be
> a long and painful process.

You seem to be insisting that the function be named for its
implementation (i.e. offline CPUs are not supported) not its
purpose (trace system wide).

I can only suggest we go back to the original name, because the
function has *nothing* to do with whether or not perf supports
tracing per-cpu contexts on offline CPUs that become online.

> 
> Thanks,
> Ian
> 
>>>
>>> Thanks,
>>> Ian
>>>
>>>> +{
>>>> +       return evlist__add_aux_dummy(evlist, true);
>>>> +}
>>>>
>>>>  int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
>>>>                          evsel__sb_cb_t cb, void *data);
>>>> --
>>>> 2.25.1
>>>>
>>

