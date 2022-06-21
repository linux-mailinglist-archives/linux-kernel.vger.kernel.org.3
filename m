Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404AD552A68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 07:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344835AbiFUFOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 01:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFUFN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 01:13:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28515808;
        Mon, 20 Jun 2022 22:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655788436; x=1687324436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fwfyoCox5P6th5mDDYrcf0Yc19KUp3D83/gnY/MeHeg=;
  b=l/iJgw97+wYSU9enBADHMVR2JfE8E5jnB6feoqKzHt28MCaxMp36+yuO
   k0xbHwr38QzenVIqTCQ0LOuSZMnZK1/Yu7IL2NZEHdO1h6+nSbR4S8/z/
   m7hxsfGfgCvNlRahegK3uKVfPGKLxjKXPfTWopn/OLqYv69vZgxaV+39M
   TZFeQCMBU4SCFw9/eqXM7YN1yO1PtWsHDfUtY77p4No7DyYKQBbT11nHz
   0pu5GVvnKzuOxsa0eWBtjziYpAYLI5tUqH7LcftimUZkf3nknk7h1Yo7u
   Tivs1l+pqZ+UfeuqjDbbsGFJVqulPFVH7bbBd3fRMQS3o98tpRWkw5fZ+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="281084073"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="281084073"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 22:13:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="643446710"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.30.13]) ([10.255.30.13])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 22:13:52 -0700
Message-ID: <8870b06f-dd42-c3a6-1909-9550d77cf187@linux.intel.com>
Date:   Tue, 21 Jun 2022 13:13:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] perf record: Support "--cputype" option for hybrid events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20220615150823.2230349-1-zhengjun.xing@linux.intel.com>
 <CAP-5=fVnD=jiSav=UAV9E_mc8XtcHad107ww8JSeiJ2y4ucxDw@mail.gmail.com>
 <bc4d4c51-27ee-d8ef-a190-e5c7e587447b@linux.intel.com>
 <2560dc81-7ff9-f907-9041-b309a8ef5509@linux.intel.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <2560dc81-7ff9-f907-9041-b309a8ef5509@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 6/16/2022 10:31 PM, Liang, Kan wrote:
> 
> 
> On 6/16/2022 4:31 AM, Xing Zhengjun wrote:
>> Hi Ian,
>>
>> On 6/15/2022 11:16 PM, Ian Rogers wrote:
>>> On Wed, Jun 15, 2022 at 8:07 AM <zhengjun.xing@linux.intel.com> wrote:
>>>>
>>>> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>>>
>>>> perf stat already has the "--cputype" option to enable events only 
>>>> on the
>>>> specified PMU for the hybrid platform, this commit extends the 
>>>> "--cputype"
>>>> support to perf record.
>>>>
>>>> Without "--cputype", it reports events for both cpu_core and cpu_atom.
>>>>
>>>>   # ./perf record  -e cycles -a sleep 1 | ./perf report
>>>>
>>>>   # To display the perf.data header info, please use 
>>>> --header/--header-only options.
>>>>   #
>>>>   [ perf record: Woken up 1 times to write data ]
>>>>   [ perf record: Captured and wrote 0.000 MB (null) ]
>>>>   #
>>>>   # Total Lost Samples: 0
>>>>   #
>>>>   # Samples: 335  of event 'cpu_core/cycles/'
>>>>   # Event count (approx.): 35855267
>>>>   #
>>>>   # Overhead  Command          Shared Object      Symbol
>>>>   # ........  ...............  ................. 
>>>> .........................................
>>>>   #
>>>>       10.31%  swapper          [kernel.kallsyms]  [k] poll_idle
>>>>        9.42%  swapper          [kernel.kallsyms]  [k] menu_select
>>>>        ...    ...               ...               ... ...
>>>>
>>>>   # Samples: 61  of event 'cpu_atom/cycles/'
>>>>   # Event count (approx.): 16453825
>>>>   #
>>>>   # Overhead  Command        Shared Object      Symbol
>>>>   # ........  .............  ................. 
>>>> ......................................
>>>>   #
>>>>       26.36%  snapd          [unknown]          [.] 0x0000563cc6d03841
>>>>        7.43%  migration/13   [kernel.kallsyms]  [k] 
>>>> update_sd_lb_stats.constprop.0
>>>>        ...    ...            ...                ... ...
>>>>
>>>> With "--cputype", it reports events only for the specified PMU.
>>>>
>>>>   # ./perf record --cputype core  -e cycles -a sleep 1 | ./perf report
>>>>
>>>>   # To display the perf.data header info, please use 
>>>> --header/--header-only options.
>>>>   #
>>>>   [ perf record: Woken up 1 times to write data ]
>>>>   [ perf record: Captured and wrote 0.000 MB (null) ]
>>>>   #
>>>>   # Total Lost Samples: 0
>>>>   #
>>>>   # Samples: 221  of event 'cpu_core/cycles/'
>>>>   # Event count (approx.): 27121818
>>>>   #
>>>>   # Overhead  Command          Shared Object      Symbol
>>>>   # ........  ...............  ................. 
>>>> .........................................
>>>>   #
>>>>       11.24%  swapper          [kernel.kallsyms]  [k] e1000_irq_enable
>>>>        7.77%  swapper          [kernel.kallsyms]  [k] 
>>>> mwait_idle_with_hints.constprop.0
>>>>        ...    ...              ...                ... ...
>>>
>>> This is already possible by having the PMU name as part of the event,
>>> cpu_atom/cycles/ or cpu_core/cycles/. I don't know why we're adding
>>> "hybrid" all over the code base, I wish it would stop. You are asking
>>> for an option here for an implied PMU for events that don't specify a
>>> PMU. The option should be called --pmutype and consider all PMUs. 
> 
> The --pmutype should be redundant because other PMUs have to specify the 
> PMU name with the event. Only the CPU type of PMUs have events which 
> doesn't have a PMU name prefix, e.g., cycles, instructions.
> So the "--cputype" was introduced for perf stat to avoid the annoying 
> pmu prefix for the CPU type of PMU.
> 
> This patch just extends the "--cputype" to perf record to address the 
> request from the community. It reuses the existing function.
> 

Yes, "--cputype" is better. Ian, what do you think? Thanks.

>>> We
>>> should remove the "hybrid" PMU list and make all of the "hybrid" code
>>> generic.
> 
> We already start to rework on the "hybrid" code.
> 
> We recently rework the perf stat default
> https://lore.kernel.org/lkml/20220610025449.2089232-1-zhengjun.xing@linux.intel.com/ 
> 
> 
> With the help of Ravi, we clean up the hybrid CPU in the perf header.
> https://lore.kernel.org/all/20220604044519.594-6-ravi.bangoria@amd.com/
> 
> I think Zhengjun will work on the perf record default cleanup shortly.
> 
> Then I guess we can further clean up the "--cputype", e.g., removing 
> hybrid_pmu_name from evlist... as next step.
> 
> Thanks,
> Kan
>>>
>>
>> I can change the option name from "cputype" to "pmutype". We have 
>> planned to clean up the hybrid code, and try to reduce the code with 
>> "if perf_pmu__has_hybrid()", this will be done step by step, from this 
>> patch, we have begun to do some clean-up, move the hybrid API from the 
>> common file to the hybrid-specific files. For the clean-up, Do you 
>> have any ideas? Thanks.
>>
>>> Thanks,
>>> Ian
>>>
>>>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>>> ---
>>>>   tools/perf/Documentation/perf-record.txt |  4 ++++
>>>>   tools/perf/builtin-record.c              |  3 +++
>>>>   tools/perf/builtin-stat.c                | 20 --------------------
>>>>   tools/perf/util/pmu-hybrid.c             | 19 +++++++++++++++++++
>>>>   tools/perf/util/pmu-hybrid.h             |  2 ++
>>>>   5 files changed, 28 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/tools/perf/Documentation/perf-record.txt 
>>>> b/tools/perf/Documentation/perf-record.txt
>>>> index cf8ad50f3de1..ba8d680da1ac 100644
>>>> --- a/tools/perf/Documentation/perf-record.txt
>>>> +++ b/tools/perf/Documentation/perf-record.txt
>>>> @@ -402,6 +402,10 @@ Enable weightened sampling. An additional 
>>>> weight is recorded per sample and can
>>>>   displayed with the weight and local_weight sort keys.  This 
>>>> currently works for TSX
>>>>   abort events and some memory events in precise mode on modern 
>>>> Intel CPUs.
>>>>
>>>> +--cputype::
>>>> +Only enable events on applying cpu with this type for hybrid 
>>>> platform(e.g. core or atom).
>>>> +For non-hybrid events, it should be no effect.
>>>> +
>>>>   --namespaces::
>>>>   Record events of type PERF_RECORD_NAMESPACES.  This enables 
>>>> 'cgroup_id' sort key.
>>>>
>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>> index 9a71f0330137..e1edd4e98358 100644
>>>> --- a/tools/perf/builtin-record.c
>>>> +++ b/tools/perf/builtin-record.c
>>>> @@ -3183,6 +3183,9 @@ static struct option __record_options[] = {
>>>>          OPT_INCR('v', "verbose", &verbose,
>>>>                      "be more verbose (show counter open errors, 
>>>> etc)"),
>>>>          OPT_BOOLEAN('q', "quiet", &quiet, "don't print any message"),
>>>> +       OPT_CALLBACK(0, "cputype", &record.evlist, "hybrid cpu type",
>>>> +                    "Only enable events on applying cpu with this 
>>>> type for hybrid platform (e.g. core or atom)",
>>>> +                    parse_hybrid_type),
>>>>          OPT_BOOLEAN('s', "stat", &record.opts.inherit_stat,
>>>>                      "per thread counts"),
>>>>          OPT_BOOLEAN('d', "data", &record.opts.sample_address, 
>>>> "Record the sample addresses"),
>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>>> index 4ce87a8eb7d7..0d95b29273f4 100644
>>>> --- a/tools/perf/builtin-stat.c
>>>> +++ b/tools/perf/builtin-stat.c
>>>> @@ -1184,26 +1184,6 @@ static int parse_stat_cgroups(const struct 
>>>> option *opt,
>>>>          return parse_cgroups(opt, str, unset);
>>>>   }
>>>>
>>>> -static int parse_hybrid_type(const struct option *opt,
>>>> -                            const char *str,
>>>> -                            int unset __maybe_unused)
>>>> -{
>>>> -       struct evlist *evlist = *(struct evlist **)opt->value;
>>>> -
>>>> -       if (!list_empty(&evlist->core.entries)) {
>>>> -               fprintf(stderr, "Must define cputype before 
>>>> events/metrics\n");
>>>> -               return -1;
>>>> -       }
>>>> -
>>>> -       evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu(str);
>>>> -       if (!evlist->hybrid_pmu_name) {
>>>> -               fprintf(stderr, "--cputype %s is not supported!\n", 
>>>> str);
>>>> -               return -1;
>>>> -       }
>>>> -
>>>> -       return 0;
>>>> -}
>>>> -
>>>>   static struct option stat_options[] = {
>>>>          OPT_BOOLEAN('T', "transaction", &transaction_run,
>>>>                      "hardware transaction statistics"),
>>>> diff --git a/tools/perf/util/pmu-hybrid.c 
>>>> b/tools/perf/util/pmu-hybrid.c
>>>> index f51ccaac60ee..5c490b5201b7 100644
>>>> --- a/tools/perf/util/pmu-hybrid.c
>>>> +++ b/tools/perf/util/pmu-hybrid.c
>>>> @@ -13,6 +13,7 @@
>>>>   #include <stdarg.h>
>>>>   #include <locale.h>
>>>>   #include <api/fs/fs.h>
>>>> +#include "util/evlist.h"
>>>>   #include "fncache.h"
>>>>   #include "pmu-hybrid.h"
>>>>
>>>> @@ -87,3 +88,21 @@ char *perf_pmu__hybrid_type_to_pmu(const char *type)
>>>>          free(pmu_name);
>>>>          return NULL;
>>>>   }
>>>> +
>>>> +int parse_hybrid_type(const struct option *opt, const char *str, 
>>>> int unset __maybe_unused)
>>>> +{
>>>> +       struct evlist *evlist = *(struct evlist **)opt->value;
>>>> +
>>>> +       if (!list_empty(&evlist->core.entries)) {
>>>> +               fprintf(stderr, "Must define cputype before 
>>>> events/metrics\n");
>>>> +               return -1;
>>>> +       }
>>>> +
>>>> +       evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu(str);
>>>> +       if (!evlist->hybrid_pmu_name) {
>>>> +               fprintf(stderr, "--cputype %s is not supported!\n", 
>>>> str);
>>>> +               return -1;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> diff --git a/tools/perf/util/pmu-hybrid.h 
>>>> b/tools/perf/util/pmu-hybrid.h
>>>> index 2b186c26a43e..26101f134a3a 100644
>>>> --- a/tools/perf/util/pmu-hybrid.h
>>>> +++ b/tools/perf/util/pmu-hybrid.h
>>>> @@ -5,6 +5,7 @@
>>>>   #include <linux/perf_event.h>
>>>>   #include <linux/compiler.h>
>>>>   #include <linux/list.h>
>>>> +#include <subcmd/parse-options.h>
>>>>   #include <stdbool.h>
>>>>   #include "pmu.h"
>>>>
>>>> @@ -18,6 +19,7 @@ bool perf_pmu__hybrid_mounted(const char *name);
>>>>   struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
>>>>   bool perf_pmu__is_hybrid(const char *name);
>>>>   char *perf_pmu__hybrid_type_to_pmu(const char *type);
>>>> +int parse_hybrid_type(const struct option *opt, const char *str, 
>>>> int unset __maybe_unused);
>>>>
>>>>   static inline int perf_pmu__hybrid_pmu_num(void)
>>>>   {
>>>> -- 
>>>> 2.25.1
>>>>
>>

-- 
Zhengjun Xing
