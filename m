Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910B451D459
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390486AbiEFJbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390520AbiEFJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:31:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DE564BC4
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651829243; x=1683365243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J7XOmTu7TYPbzhxPJ7h4k1YCkR5C8gg9HSeJvj2JEgA=;
  b=AT+S2S6ZAx1qyr+QQMSVi29LeRWQ3joRHQjHyuJVhx1sQkCsYthtSr2p
   T81rlPAuSrjkoOm2Od1nLQObL5kP/cyaHjQAOdSHKnBJ5ZuEli67/v9/r
   NRepPzKksrDIKZu8iaWgqpM0eHDVbI4qAIzuQPcnuEHqSfBNm6Oa4tXQY
   VTDze2GA/KN8DbZYJMf5zlussiWoKcCGVUxeev2+S5ZzvjGNkQNqP6TLI
   0j8LTXg+rUf4P3Do7iMauLts+Laz5vEhZ0fug9OoO+BDkU/oI3olTIOGI
   tOiGWJ+LkphIfLdEqJ8UqcgUo0nvuF5VcJlWqWNAgwTDhgPTXCp/X++z8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="328956169"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="328956169"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 02:27:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585883719"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.62.152])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 02:27:20 -0700
Message-ID: <077c06ad-e1f9-a86c-208e-5dc0d0f33bce@intel.com>
Date:   Fri, 6 May 2022 12:27:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V1 13/23] perf evlist: Add evlist__add_system_wide_dummy()
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
References: <20220505165639.361733-1-adrian.hunter@intel.com>
 <20220505165639.361733-14-adrian.hunter@intel.com>
 <CAP-5=fWKOYiOSs=TppGCD+k283rUUsexzVuJP17Pm76EMOs+xA@mail.gmail.com>
 <fed8d256-b214-e25f-9a5f-492442c4b849@intel.com>
 <CAP-5=fWF=c1Hu5JaJfz4oZLg15ZQy=gqVkNc34Xphtroenfm8g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWF=c1Hu5JaJfz4oZLg15ZQy=gqVkNc34Xphtroenfm8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/05/22 11:34, Ian Rogers wrote:
> On Fri, May 6, 2022 at 1:14 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 6/05/22 02:56, Ian Rogers wrote:
>>> On Thu, May 5, 2022 at 9:57 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> Add evlist__add_system_wide_dummy() to enable creating a system-wide dummy
>>>> event that sets up the system-wide maps before map propagation.
>>>
>>> Perhaps this should be:
>>> evlist__add_dummy_on_all_online_cpus()
>>
>> Ok, but offline isn't an option, so I'll drop 'online' from the name.
> 
> I'm not sure I follow. There can be CPUs that are offline (echo 0 >
> /sys/devices/system/cpu/cpu2/online) and then brought online while
> perf is running. The output obviously won't be right as we're missing
> dummy events. Losing online from the name here seems to remove a
> useful clue.

perf_event_open() will not accept events on offline CPUs.

> 
> Thanks,
> Ian
> 
>>> my thoughts being that a system wide dummy sounds like the dummy CPU
>>> map, ie {-1} whilst what happens here is opening on all online CPUs
>>> {0-35} on a 36 hyperthread system. Note also that the libperf
>>> cpu_map__read_all_cpu_map code doesn't discover sysfs' mount properly,
>>> as done in:
>>> tools/lib/api/fs/fs.h
>>> Some tech debt.
>>>
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
>>>> index 78c47cbafbc2..58ea562ddbd2 100644
>>>> --- a/tools/perf/util/evlist.c
>>>> +++ b/tools/perf/util/evlist.c
>>>> @@ -264,6 +264,46 @@ int evlist__add_dummy(struct evlist *evlist)
>>>>         return 0;
>>>>  }
>>>>
>>>> +static void evlist__add_system_wide(struct evlist *evlist, struct evsel *evsel)
>>>
>>> This would be:
>>> evlist__add_on_all_online_cpus(..)
>>>
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
>>>> +               evlist__add_system_wide(evlist, evsel);
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
>>>> index 4062f5aebfc1..dd1af114e033 100644
>>>> --- a/tools/perf/util/evlist.h
>>>> +++ b/tools/perf/util/evlist.h
>>>> @@ -114,6 +114,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist);
>>>>  struct evsel *arch_evlist__leader(struct list_head *list);
>>>>
>>>>  int evlist__add_dummy(struct evlist *evlist);
>>>> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
>>>> +static inline struct evsel *evlist__add_system_wide_dummy(struct evlist *evlist)
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

