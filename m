Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95957522CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiEKHEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbiEKHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:03:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3531CE7339
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652252540; x=1683788540;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G3yKzvJNHbyll/+nq4BlFLb6ifyCHdO/l4eKWFl2Fzo=;
  b=hP6LL1bOyK/oFs24ONMI2+9TizoDGbHQE7kMxWmndOh2AtC1LfLNHVHv
   eoFJP/Li6Dc+Cf6LVjnC6IiY8NAJuGH3Eqa5jbV8khRUdlHu350J23zYf
   1zrlg8GTD90P2Vm8SCPqTlPTzX0y4a49Hfu98EMFuWKN0A1y3/ENJ8NmL
   M4HeBm7KMMnvPr+hGRwW41vuePYqYlxGEUJJ+RMTUwiZBuD8W08Fi3kvI
   QTsS8HVldgGm4RMWBnzQ/Tf2kjLW0KjgK5hD9SCyUSfV0Dbv/rZ9EODgm
   Fl1mbFUK8qTbpRMueCMYbIjfIQEW3lnwCLn6hYnBJ2CczwLCPSeGLfcxv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250141065"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="250141065"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:02:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="593967970"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.107])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:02:17 -0700
Message-ID: <2e997d95-11b8-0f33-adaa-8395c9626188@intel.com>
Date:   Wed, 11 May 2022 10:02:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V2 10/23] perf auxtrace: Add mmap_needed to
 auxtrace_mmap_params
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-11-adrian.hunter@intel.com>
 <CAP-5=fXfGjfpK81Gnm4uxZq3gYanKbYpa9wxxVLF9=aD4_3ArA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fXfGjfpK81Gnm4uxZq3gYanKbYpa9wxxVLF9=aD4_3ArA@mail.gmail.com>
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

On 6/05/22 23:16, Ian Rogers wrote:
> On Fri, May 6, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Add mmap_needed to auxtrace_mmap_params.
>>
>> Currently an auxtrace mmap is always attempted even if the event is not an
>> auxtrace event. That works because, when AUX area tracing, there is always
>> an auxtrace event first for every mmap. Prepare for that not being the
>> case, which it won't be when sideband tracking events are allowed on
>> all CPUs even when auxtrace is limited to selected CPUs.
> 
> Should there be a later patch to remove this option and just not do
> the auxtrace mmap when it's not necessary?

The same code path is used for non-auxtrace mmap as auxtrace mmap.
I have amended the comment to explain.

> 
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/util/auxtrace.c | 10 ++++++++--
>>  tools/perf/util/auxtrace.h |  8 ++++++--
>>  tools/perf/util/evlist.c   |  5 +++--
>>  tools/perf/util/mmap.c     |  1 +
>>  4 files changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index b11549ae39df..b446cfa66469 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -125,7 +125,7 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
>>         mm->tid = mp->tid;
>>         mm->cpu = mp->cpu.cpu;
>>
>> -       if (!mp->len) {
>> +       if (!mp->len || !mp->mmap_needed) {
>>                 mm->base = NULL;
>>                 return 0;
>>         }
>> @@ -168,9 +168,15 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>>  }
>>
>>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>> -                                  struct evlist *evlist, int idx,
>> +                                  struct evlist *evlist,
>> +                                  struct evsel *evsel, int idx,
>>                                    bool per_cpu)
>>  {
>> +       mp->mmap_needed = evsel->needs_auxtrace_mmap;
>> +
>> +       if (!mp->mmap_needed)
>> +               return;
>> +
>>         mp->idx = idx;
>>
>>         if (per_cpu) {
>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>> index dc38b6f57232..37feae003904 100644
>> --- a/tools/perf/util/auxtrace.h
>> +++ b/tools/perf/util/auxtrace.h
>> @@ -344,6 +344,7 @@ struct auxtrace_mmap {
>>   * @idx: index of this mmap
>>   * @tid: tid for a per-thread mmap (also set if there is only 1 tid on a per-cpu
>>   *       mmap) otherwise %0
>> + * @mmap_needed: set to %false for non-auxtrace events
> 
> Could you add something like:
> (ie. we don't want the mmap but we do want the side effects of ...
> 
> Thanks,
> Ian
> 
>>   * @cpu: cpu number for a per-cpu mmap otherwise %-1
>>   */
>>  struct auxtrace_mmap_params {
>> @@ -353,6 +354,7 @@ struct auxtrace_mmap_params {
>>         int             prot;
>>         int             idx;
>>         pid_t           tid;
>> +       bool            mmap_needed;
>>         struct perf_cpu cpu;
>>  };
>>
>> @@ -490,7 +492,8 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>>                                 unsigned int auxtrace_pages,
>>                                 bool auxtrace_overwrite);
>>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>> -                                  struct evlist *evlist, int idx,
>> +                                  struct evlist *evlist,
>> +                                  struct evsel *evsel, int idx,
>>                                    bool per_cpu);
>>
>>  typedef int (*process_auxtrace_t)(struct perf_tool *tool,
>> @@ -863,7 +866,8 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>>                                 unsigned int auxtrace_pages,
>>                                 bool auxtrace_overwrite);
>>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>> -                                  struct evlist *evlist, int idx,
>> +                                  struct evlist *evlist,
>> +                                  struct evsel *evsel, int idx,
>>                                    bool per_cpu);
>>
>>  #define ITRACE_HELP ""
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 7ae56b062f44..996bdc203616 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -747,15 +747,16 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
>>
>>  static void
>>  perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
>> -                        struct perf_evsel *_evsel __maybe_unused,
>> +                        struct perf_evsel *_evsel,
>>                          struct perf_mmap_param *_mp,
>>                          int idx)
>>  {
>>         struct evlist *evlist = container_of(_evlist, struct evlist, core);
>>         struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
>>         bool per_cpu = !perf_cpu_map__empty(_evlist->user_requested_cpus);
>> +       struct evsel *evsel = container_of(_evsel, struct evsel, core);
>>
>> -       auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
>> +       auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, evsel, idx, per_cpu);
>>  }
>>
>>  static struct perf_mmap*
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index 50502b4a7ca4..de59c4da852b 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -62,6 +62,7 @@ void __weak auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp __maybe_u
>>
>>  void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __maybe_unused,
>>                                           struct evlist *evlist __maybe_unused,
>> +                                         struct evsel *evsel __maybe_unused,
>>                                           int idx __maybe_unused,
>>                                           bool per_cpu __maybe_unused)
>>  {
>> --
>> 2.25.1
>>

