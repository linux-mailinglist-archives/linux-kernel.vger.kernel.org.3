Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8603C51AC95
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbiEDSWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376787AbiEDSWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:22:12 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAD19419A;
        Wed,  4 May 2022 10:44:55 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 16so2566280lju.13;
        Wed, 04 May 2022 10:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Q6SqrbYZWFx128//isZIV7PZCyMyA/oWJ4+i+1SqpQ=;
        b=SJR3L8zR+8d5bvgbzKtIzYLsLn8vbBLACQi5XNP5Oe0LL5pb8Jj0iVXOS9WzKkLLo8
         R7L46ho6bcD4h8A0eHDiReXAhwQl2V90VUA4hLlt50WpaPGXDZPcB+qt8aYRHhoD9N6Z
         SB3AcjlfJVv9FZzLnfKsdN7ayNQAqNybVCMS/KoytSs9kFHomRhOFm14NSEuEhckHf2Y
         84VYHeBADSymMa9q6bLzp7Dxs3QuAIO68LjuMNjtrStwpl/RfT4VFqTyK9eLmr8mwMnj
         7qzDFp02DCO7Z2OpeZ8nZosRR51fVboyJq2Dbl8Igk91/P6l45f6BfBRrSVVjp28WMBN
         fU4g==
X-Gm-Message-State: AOAM530PR/s5mLu4x5BloR8zWeH/1la9AOAntgCwKKjdT32ezH+VKpoq
        LBmlZVJHWNsPOz7GBNm3Cxnt4WvKNbywVeWX/gI=
X-Google-Smtp-Source: ABdhPJw5AG2YrsW1npAHOjDJcRGDqpWprXLTivDEJBhDfskMirP6cXddjRw+ysx5IcErE5BpV0J65ztG3PNK5JqfwJs=
X-Received: by 2002:a2e:7e05:0:b0:24f:12e3:6602 with SMTP id
 z5-20020a2e7e05000000b0024f12e36602mr12689874ljc.202.1651686293418; Wed, 04
 May 2022 10:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com> <20220503041757.2365696-2-irogers@google.com>
In-Reply-To: <20220503041757.2365696-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 4 May 2022 10:44:42 -0700
Message-ID: <CAM9d7cia6OT5Mk13R36CwZW8iwVWtsyQVBE7s1+NKhh+dT93Vg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] perf cpumap: Switch to using perf_cpu_map API
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Mon, May 2, 2022 at 9:18 PM Ian Rogers <irogers@google.com> wrote:
>
> Switch some raw accesses to the cpu map to using the library API. This
> can help with reference count checking. Some BPF cases switch from index
> to CPU for consistency, this shouldn't matter as the CPU map is full.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-record.c          | 13 +++++----
>  tools/perf/util/bpf_counter_cgroup.c | 42 +++++++++++++---------------
>  2 files changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 069825c48d40..a5cf6a99d67f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1011,7 +1011,7 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
>
>         for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
>                 if (cpu_map__is_dummy(cpus) ||
> -                   test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
> +                   test_bit(perf_cpu_map__cpu(cpus, m).cpu, thread_data->mask->maps.bits)) {
>                         if (thread_data->maps) {
>                                 thread_data->maps[tm] = &mmap[m];
>                                 pr_debug2("thread_data[%p]: cpu%d: maps[%d] -> mmap[%d]\n",
> @@ -3331,13 +3331,14 @@ struct option *record_options = __record_options;
>
>  static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
>  {
> -       int c;
> +       struct perf_cpu cpu;
> +       int idx;
>
>         if (cpu_map__is_dummy(cpus))
>                 return;
>
> -       for (c = 0; c < cpus->nr; c++)
> -               set_bit(cpus->map[c].cpu, mask->bits);
> +       perf_cpu_map__for_each_cpu(cpu, idx, cpus)
> +               set_bit(cpu.cpu, mask->bits);
>  }
>
>  static int record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const char *mask_spec)
> @@ -3404,8 +3405,8 @@ static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map
>         pr_debug("nr_threads: %d\n", rec->nr_threads);
>
>         for (t = 0; t < rec->nr_threads; t++) {
> -               set_bit(cpus->map[t].cpu, rec->thread_masks[t].maps.bits);
> -               set_bit(cpus->map[t].cpu, rec->thread_masks[t].affinity.bits);
> +               set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].maps.bits);
> +               set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].affinity.bits);
>                 if (verbose) {
>                         pr_debug("thread_masks[%d]: ", t);
>                         mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index ac60c08e8e2a..63b9db657442 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -46,8 +46,8 @@ static int bperf_load_program(struct evlist *evlist)
>         struct bpf_link *link;
>         struct evsel *evsel;
>         struct cgroup *cgrp, *leader_cgrp;
> -       __u32 i, cpu;
> -       __u32 nr_cpus = evlist->core.all_cpus->nr;
> +       int i, j;
> +       struct perf_cpu cpu;
>         int total_cpus = cpu__max_cpu().cpu;
>         int map_size, map_fd;
>         int prog_fd, err;
> @@ -93,9 +93,9 @@ static int bperf_load_program(struct evlist *evlist)
>                 goto out;
>         }
>
> -       for (i = 0; i < nr_cpus; i++) {
> +       perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
>                 link = bpf_program__attach_perf_event(skel->progs.on_cgrp_switch,
> -                                                     FD(cgrp_switch, i));
> +                                                     FD(cgrp_switch, cpu.cpu));
>                 if (IS_ERR(link)) {
>                         pr_err("Failed to attach cgroup program\n");
>                         err = PTR_ERR(link);
> @@ -122,10 +122,9 @@ static int bperf_load_program(struct evlist *evlist)
>                         }
>
>                         map_fd = bpf_map__fd(skel->maps.events);
> -                       for (cpu = 0; cpu < nr_cpus; cpu++) {
> -                               int fd = FD(evsel, cpu);
> -                               __u32 idx = evsel->core.idx * total_cpus +
> -                                       evlist->core.all_cpus->map[cpu].cpu;
> +                       perf_cpu_map__for_each_cpu(cpu, j, evlist->core.all_cpus) {
> +                               int fd = FD(evsel, cpu.cpu);
> +                               __u32 idx = evsel->core.idx * total_cpus + cpu.cpu;
>
>                                 err = bpf_map_update_elem(map_fd, &idx, &fd,
>                                                           BPF_ANY);
> @@ -207,14 +206,12 @@ static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
>   */
>  static int bperf_cgrp__sync_counters(struct evlist *evlist)
>  {
> -       int i, cpu;
> -       int nr_cpus = evlist->core.all_cpus->nr;
> +       struct perf_cpu cpu;
> +       int idx;
>         int prog_fd = bpf_program__fd(skel->progs.trigger_read);
>
> -       for (i = 0; i < nr_cpus; i++) {
> -               cpu = evlist->core.all_cpus->map[i].cpu;
> -               bperf_trigger_reading(prog_fd, cpu);
> -       }
> +       perf_cpu_map__for_each_cpu(cpu, idx, evlist->core.all_cpus)
> +               bperf_trigger_reading(prog_fd, cpu.cpu);
>
>         return 0;
>  }
> @@ -244,12 +241,10 @@ static int bperf_cgrp__disable(struct evsel *evsel)
>  static int bperf_cgrp__read(struct evsel *evsel)
>  {
>         struct evlist *evlist = evsel->evlist;
> -       int i, cpu, nr_cpus = evlist->core.all_cpus->nr;
>         int total_cpus = cpu__max_cpu().cpu;
>         struct perf_counts_values *counts;
>         struct bpf_perf_event_value *values;
>         int reading_map_fd, err = 0;
> -       __u32 idx;
>
>         if (evsel->core.idx)
>                 return 0;
> @@ -263,7 +258,10 @@ static int bperf_cgrp__read(struct evsel *evsel)
>         reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
>
>         evlist__for_each_entry(evlist, evsel) {
> -               idx = evsel->core.idx;
> +               __u32 idx = evsel->core.idx;
> +               int i;
> +               struct perf_cpu cpu;
> +
>                 err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
>                 if (err) {
>                         pr_err("bpf map lookup failed: idx=%u, event=%s, cgrp=%s\n",
> @@ -271,13 +269,11 @@ static int bperf_cgrp__read(struct evsel *evsel)
>                         goto out;
>                 }
>
> -               for (i = 0; i < nr_cpus; i++) {
> -                       cpu = evlist->core.all_cpus->map[i].cpu;
> -
> +               perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
>                         counts = perf_counts(evsel->counts, i, 0);
> -                       counts->val = values[cpu].counter;
> -                       counts->ena = values[cpu].enabled;
> -                       counts->run = values[cpu].running;
> +                       counts->val = values[cpu.cpu].counter;
> +                       counts->ena = values[cpu.cpu].enabled;
> +                       counts->run = values[cpu.cpu].running;
>                 }
>         }
>
> --
> 2.36.0.464.gb9c8b46e94-goog
>
