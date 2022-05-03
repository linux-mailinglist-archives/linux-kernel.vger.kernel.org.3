Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A95518B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiECRpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiECRpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:45:15 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086443B3F8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:41:42 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id t12so8309704vkt.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwPSjaMjm9TF6BYonjXsevNc2gdUuFLzVjLeMOe0hfM=;
        b=hEUCG/VyNY1Q6ZkNV6RzriHU9MyI9JPbQAuY2HgDOpAHikk4KxObVs6WTZkemJGhxl
         BIb8BpolQm/UHtLRcg+AHqvaRbAmQsVE4KnAsgPBbKLLTW7zS3DwuoXyIAE5HvLjwHY4
         M3/GyUBhonVjxnq+8V4FpIsmeQC3LxXZzvM5nHnCwE+PBiR8CaXQP3eaD/txrkXyZ1tm
         ITybkS70LaUQuEXbVb2BuLEycAlvGzZ/yZz1iFXWfb8yDYKpPPwU7VGG2gDRSvKcfyAQ
         z3q9HIzqzXsCIACeaAl8oxN0eQY5WnLsyC4rcQd+7qNncbYgn+O1c6qqMsCBJXFmVrel
         Tx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwPSjaMjm9TF6BYonjXsevNc2gdUuFLzVjLeMOe0hfM=;
        b=B0fsgsJ4/w2zQGIHc3XnmaeLJbabweGEVSUMuKK8/D5FbKWluz9gwfcPhaYifIBdzO
         t/GfMjzzUalfAC090H3lMB7lQmWSufHtRUtkQHFS6PZoJUcEdO96rytFNfc4eMD1nMM9
         hknoNokBuyhmvEg3uCBDARV7QIfIr2kaDqBuBlaCz1Hh2DqWTZj6TAWWeIcgLCrFxD9q
         rkW74fXAgEqZvLHR17Cb2P7k9gVUovbiKQ6XuBHT2gtBkoIjwV4vPuwfYpFi2B+E+zC/
         XUQP4xMAz4mIRQiyOmwBAT/tMfUY7O0aT0vnIv/a22buJvF6roVCRpGQ9P7nmK7TpB9O
         2VMw==
X-Gm-Message-State: AOAM533mi7HESOklDKnig6Sjzs97P+2QSqME1W1d2sJjpatcsvcMt5DM
        4iwJF69vvW0Di2rwlW4/9MBNsQwQoFvenabaUSBYaA==
X-Google-Smtp-Source: ABdhPJyND5WdgHwShHBqT8f3MBPiry0GixfF0btyD2ToJ9dze7rM0tw4yt2PPksCb0V1Ap0ank3BjME2TfNhV2JAltE=
X-Received: by 2002:a05:6122:1810:b0:34e:8f1c:749d with SMTP id
 ay16-20020a056122181000b0034e8f1c749dmr4369273vkb.20.1651599700731; Tue, 03
 May 2022 10:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220422162402.147958-1-adrian.hunter@intel.com> <20220422162402.147958-18-adrian.hunter@intel.com>
In-Reply-To: <20220422162402.147958-18-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 May 2022 10:41:29 -0700
Message-ID: <CAP-5=fXBhfmknChWJLR4u9RhTmLyaOrhdpyjpFS4RzfHs1WuPw@mail.gmail.com>
Subject: Re: [PATCH RFC 17/21] perf tools: Allow all_cpus to be a superset of user_requested_cpus
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> To support collection of system-wide events with user requested CPUs,
> all_cpus must be a superset of user_requested_cpus.
>
> In order to support all_cpus to be a superset of user_requested_cpus,
> all_cpus must be used instead of user_requested_cpus when dealing with CPUs
> of all events instead of CPUs of requested events.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/lib/perf/evlist.c     | 12 ++++++------
>  tools/perf/builtin-record.c | 18 ++++++++++++------
>  tools/perf/util/auxtrace.c  |  2 +-
>  3 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index ad04da81c367..048b546f9444 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -294,7 +294,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>
>  int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
>  {
> -       int nr_cpus = perf_cpu_map__nr(evlist->user_requested_cpus);
> +       int nr_cpus = perf_cpu_map__nr(evlist->all_cpus);
>         int nr_threads = perf_thread_map__nr(evlist->threads);
>         int nfds = 0;
>         struct perf_evsel *evsel;
> @@ -426,7 +426,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                int idx, struct perf_mmap_param *mp, int cpu_idx,
>                int thread, int *_output, int *_output_overwrite)
>  {
> -       struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->user_requested_cpus, cpu_idx);
> +       struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->all_cpus, cpu_idx);
>         struct perf_evsel *evsel;
>         int revent;
>
> @@ -536,7 +536,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>              struct perf_mmap_param *mp)
>  {
>         int nr_threads = perf_thread_map__nr(evlist->threads);
> -       int nr_cpus    = perf_cpu_map__nr(evlist->user_requested_cpus);
> +       int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
>         int cpu, thread;
>
>         for (cpu = 0; cpu < nr_cpus; cpu++) {
> @@ -561,8 +561,8 @@ static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
>  {
>         int nr_mmaps;
>
> -       nr_mmaps = perf_cpu_map__nr(evlist->user_requested_cpus);
> -       if (perf_cpu_map__empty(evlist->user_requested_cpus))
> +       nr_mmaps = perf_cpu_map__nr(evlist->all_cpus);
> +       if (perf_cpu_map__empty(evlist->all_cpus))
>                 nr_mmaps = perf_thread_map__nr(evlist->threads);
>
>         return nr_mmaps;
> @@ -573,7 +573,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>                           struct perf_mmap_param *mp)
>  {
>         struct perf_evsel *evsel;
> -       const struct perf_cpu_map *cpus = evlist->user_requested_cpus;
> +       const struct perf_cpu_map *cpus = evlist->all_cpus;
>
>         if (!ops || !ops->get || !ops->mmap)
>                 return -EINVAL;
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 83d2f2b5dcda..42127cfd9cc1 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -967,14 +967,20 @@ static void record__thread_data_close_pipes(struct record_thread *thread_data)
>         }
>  }
>
> +static bool evlst__per_thread(struct evlist *evlist)
> +{
> +       return cpu_map__is_dummy(evlist->core.user_requested_cpus);
> +}
> +

This is much clearer than the previous code. Could we add a comment as
to why dummy implies per-thread? What would empty imply?

Just to note the cpu_map__is_dummy adds to the confusion on whether
dummy can appear merged into a map:
 "Events associated with a pid, rather than a CPU, use a single dummy
map with an entry of -1"
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/cpumap.h?h=perf/core#n55
If the dummy can appear in any cpu map then we should rephrase this
and possibly turn this into a has_dummy_cpu function.

Thanks,
Ian

>  static int record__thread_data_init_maps(struct record_thread *thread_data, struct evlist *evlist)
>  {
>         int m, tm, nr_mmaps = evlist->core.nr_mmaps;
>         struct mmap *mmap = evlist->mmap;
>         struct mmap *overwrite_mmap = evlist->overwrite_mmap;
> -       struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
> +       struct perf_cpu_map *cpus = evlist->core.all_cpus;
> +       bool per_thread = evlst__per_thread(evlist);
>
> -       if (cpu_map__is_dummy(cpus))
> +       if (per_thread)
>                 thread_data->nr_mmaps = nr_mmaps;
>         else
>                 thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
> @@ -995,7 +1001,7 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
>                  thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
>
>         for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
> -               if (cpu_map__is_dummy(cpus) ||
> +               if (per_thread ||
>                     test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
>                         if (thread_data->maps) {
>                                 thread_data->maps[tm] = &mmap[m];
> @@ -1870,7 +1876,7 @@ static int record__synthesize(struct record *rec, bool tail)
>                 return err;
>         }
>
> -       err = perf_event__synthesize_cpu_map(&rec->tool, rec->evlist->core.user_requested_cpus,
> +       err = perf_event__synthesize_cpu_map(&rec->tool, rec->evlist->core.all_cpus,
>                                              process_synthesized_event, NULL);
>         if (err < 0) {
>                 pr_err("Couldn't synthesize cpu map.\n");
> @@ -3667,12 +3673,12 @@ static int record__init_thread_default_masks(struct record *rec, struct perf_cpu
>  static int record__init_thread_masks(struct record *rec)
>  {
>         int ret = 0;
> -       struct perf_cpu_map *cpus = rec->evlist->core.user_requested_cpus;
> +       struct perf_cpu_map *cpus = rec->evlist->core.all_cpus;
>
>         if (!record__threads_enabled(rec))
>                 return record__init_thread_default_masks(rec, cpus);
>
> -       if (cpu_map__is_dummy(cpus)) {
> +       if (evlst__per_thread(rec->evlist)) {
>                 pr_err("--per-thread option is mutually exclusive to parallel streaming mode.\n");
>                 return -EINVAL;
>         }
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 246afe99a7fb..bac1f1eb95a7 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -181,7 +181,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>         mp->idx = idx;
>
>         if (per_cpu) {
> -               mp->cpu = perf_cpu_map__cpu(evlist->core.user_requested_cpus, idx);
> +               mp->cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
>                 if (evlist->core.threads)
>                         mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
>                 else
> --
> 2.25.1
>
