Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B693251C641
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356402AbiEERnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244971AbiEERnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:43:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CF1580F2;
        Thu,  5 May 2022 10:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8289161EFC;
        Thu,  5 May 2022 17:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D7FC385A8;
        Thu,  5 May 2022 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651772369;
        bh=iXDWyiE9q5pfXJlpa8Nq+4eTeksvSC818uecQcHGyuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aw60ITQpsgqh62Tn4jXbdvCwPk9QH3Jk8Tp8BLOguS/RvmNLfQGutySNm6gplSUm3
         UQ2SUKVvdEAD93LjqQ3jYLQt0UF3Vp6oUDWgnjHXWu7RKSZ33evZM97yaF1KIHJuVw
         5lrFXePXQrBq2PH5bcSAQf/jmW+9w+4YFiIvysjgWxR/H67NXdP0PSvkPUoqFROJGz
         EDezhQRYB/p7XzcpKwhfhdWNo/vsMHtUvSSwj3MIW34lFmdQG64m4dUoXFRc9GwQbs
         RXKQlnl9aT+12PCvSUWNWUlqyVrzXJXCz7ptLr8kvlP8m0pU9Jf386fsZgS6sb5qv4
         7E24nyEwfV8xQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 48CEF400B1; Thu,  5 May 2022 14:39:26 -0300 (-03)
Date:   Thu, 5 May 2022 14:39:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v5 1/6] perf cpumap: Switch to using perf_cpu_map API
Message-ID: <YnQLzvmuI2tG3bvj@kernel.org>
References: <20220503041757.2365696-1-irogers@google.com>
 <20220503041757.2365696-2-irogers@google.com>
 <CAM9d7cia6OT5Mk13R36CwZW8iwVWtsyQVBE7s1+NKhh+dT93Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cia6OT5Mk13R36CwZW8iwVWtsyQVBE7s1+NKhh+dT93Vg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 04, 2022 at 10:44:42AM -0700, Namhyung Kim escreveu:
> Hi Ian,
> 
> On Mon, May 2, 2022 at 9:18 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Switch some raw accesses to the cpu map to using the library API. This
> > can help with reference count checking. Some BPF cases switch from index
> > to CPU for consistency, this shouldn't matter as the CPU map is full.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/builtin-record.c          | 13 +++++----
> >  tools/perf/util/bpf_counter_cgroup.c | 42 +++++++++++++---------------
> >  2 files changed, 26 insertions(+), 29 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 069825c48d40..a5cf6a99d67f 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1011,7 +1011,7 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
> >
> >         for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
> >                 if (cpu_map__is_dummy(cpus) ||
> > -                   test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
> > +                   test_bit(perf_cpu_map__cpu(cpus, m).cpu, thread_data->mask->maps.bits)) {
> >                         if (thread_data->maps) {
> >                                 thread_data->maps[tm] = &mmap[m];
> >                                 pr_debug2("thread_data[%p]: cpu%d: maps[%d] -> mmap[%d]\n",
> > @@ -3331,13 +3331,14 @@ struct option *record_options = __record_options;
> >
> >  static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
> >  {
> > -       int c;
> > +       struct perf_cpu cpu;
> > +       int idx;
> >
> >         if (cpu_map__is_dummy(cpus))
> >                 return;
> >
> > -       for (c = 0; c < cpus->nr; c++)
> > -               set_bit(cpus->map[c].cpu, mask->bits);
> > +       perf_cpu_map__for_each_cpu(cpu, idx, cpus)
> > +               set_bit(cpu.cpu, mask->bits);
> >  }
> >
> >  static int record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const char *mask_spec)
> > @@ -3404,8 +3405,8 @@ static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map
> >         pr_debug("nr_threads: %d\n", rec->nr_threads);
> >
> >         for (t = 0; t < rec->nr_threads; t++) {
> > -               set_bit(cpus->map[t].cpu, rec->thread_masks[t].maps.bits);
> > -               set_bit(cpus->map[t].cpu, rec->thread_masks[t].affinity.bits);
> > +               set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].maps.bits);
> > +               set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].affinity.bits);
> >                 if (verbose) {
> >                         pr_debug("thread_masks[%d]: ", t);
> >                         mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
> > diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> > index ac60c08e8e2a..63b9db657442 100644
> > --- a/tools/perf/util/bpf_counter_cgroup.c
> > +++ b/tools/perf/util/bpf_counter_cgroup.c
> > @@ -46,8 +46,8 @@ static int bperf_load_program(struct evlist *evlist)
> >         struct bpf_link *link;
> >         struct evsel *evsel;
> >         struct cgroup *cgrp, *leader_cgrp;
> > -       __u32 i, cpu;
> > -       __u32 nr_cpus = evlist->core.all_cpus->nr;
> > +       int i, j;
> > +       struct perf_cpu cpu;
> >         int total_cpus = cpu__max_cpu().cpu;
> >         int map_size, map_fd;
> >         int prog_fd, err;
> > @@ -93,9 +93,9 @@ static int bperf_load_program(struct evlist *evlist)
> >                 goto out;
> >         }
> >
> > -       for (i = 0; i < nr_cpus; i++) {
> > +       perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
> >                 link = bpf_program__attach_perf_event(skel->progs.on_cgrp_switch,
> > -                                                     FD(cgrp_switch, i));
> > +                                                     FD(cgrp_switch, cpu.cpu));
> >                 if (IS_ERR(link)) {
> >                         pr_err("Failed to attach cgroup program\n");
> >                         err = PTR_ERR(link);
> > @@ -122,10 +122,9 @@ static int bperf_load_program(struct evlist *evlist)
> >                         }
> >
> >                         map_fd = bpf_map__fd(skel->maps.events);
> > -                       for (cpu = 0; cpu < nr_cpus; cpu++) {
> > -                               int fd = FD(evsel, cpu);
> > -                               __u32 idx = evsel->core.idx * total_cpus +
> > -                                       evlist->core.all_cpus->map[cpu].cpu;
> > +                       perf_cpu_map__for_each_cpu(cpu, j, evlist->core.all_cpus) {
> > +                               int fd = FD(evsel, cpu.cpu);
> > +                               __u32 idx = evsel->core.idx * total_cpus + cpu.cpu;
> >
> >                                 err = bpf_map_update_elem(map_fd, &idx, &fd,
> >                                                           BPF_ANY);
> > @@ -207,14 +206,12 @@ static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
> >   */
> >  static int bperf_cgrp__sync_counters(struct evlist *evlist)
> >  {
> > -       int i, cpu;
> > -       int nr_cpus = evlist->core.all_cpus->nr;
> > +       struct perf_cpu cpu;
> > +       int idx;
> >         int prog_fd = bpf_program__fd(skel->progs.trigger_read);
> >
> > -       for (i = 0; i < nr_cpus; i++) {
> > -               cpu = evlist->core.all_cpus->map[i].cpu;
> > -               bperf_trigger_reading(prog_fd, cpu);
> > -       }
> > +       perf_cpu_map__for_each_cpu(cpu, idx, evlist->core.all_cpus)
> > +               bperf_trigger_reading(prog_fd, cpu.cpu);
> >
> >         return 0;
> >  }
> > @@ -244,12 +241,10 @@ static int bperf_cgrp__disable(struct evsel *evsel)
> >  static int bperf_cgrp__read(struct evsel *evsel)
> >  {
> >         struct evlist *evlist = evsel->evlist;
> > -       int i, cpu, nr_cpus = evlist->core.all_cpus->nr;
> >         int total_cpus = cpu__max_cpu().cpu;
> >         struct perf_counts_values *counts;
> >         struct bpf_perf_event_value *values;
> >         int reading_map_fd, err = 0;
> > -       __u32 idx;
> >
> >         if (evsel->core.idx)
> >                 return 0;
> > @@ -263,7 +258,10 @@ static int bperf_cgrp__read(struct evsel *evsel)
> >         reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
> >
> >         evlist__for_each_entry(evlist, evsel) {
> > -               idx = evsel->core.idx;
> > +               __u32 idx = evsel->core.idx;
> > +               int i;
> > +               struct perf_cpu cpu;
> > +
> >                 err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
> >                 if (err) {
> >                         pr_err("bpf map lookup failed: idx=%u, event=%s, cgrp=%s\n",
> > @@ -271,13 +269,11 @@ static int bperf_cgrp__read(struct evsel *evsel)
> >                         goto out;
> >                 }
> >
> > -               for (i = 0; i < nr_cpus; i++) {
> > -                       cpu = evlist->core.all_cpus->map[i].cpu;
> > -
> > +               perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
> >                         counts = perf_counts(evsel->counts, i, 0);
> > -                       counts->val = values[cpu].counter;
> > -                       counts->ena = values[cpu].enabled;
> > -                       counts->run = values[cpu].running;
> > +                       counts->val = values[cpu.cpu].counter;
> > +                       counts->ena = values[cpu.cpu].enabled;
> > +                       counts->run = values[cpu.cpu].running;
> >                 }
> >         }
> >
> > --
> > 2.36.0.464.gb9c8b46e94-goog
> >

-- 

- Arnaldo
