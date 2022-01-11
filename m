Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E608F48B7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbiAKUBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbiAKUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:01:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E177C06173F;
        Tue, 11 Jan 2022 12:01:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7593617B4;
        Tue, 11 Jan 2022 20:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1623C36AE9;
        Tue, 11 Jan 2022 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641931272;
        bh=2P23q78eVRoAnd0OeBbRtez+v8BysbgdmnEBKMu+veM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=io7KDUmHXlAgKsNLCS8k6zh1ReGjCkyGEvmlzZ+KUDeELv6chcJfxtUsWBX0IbptG
         U4ZJ47kph2uWyn/TbxS2C8bcRatW342AHZXCQBhEkHF9pfc+oEy7uW86PP9eaZK+U2
         SEB949kkafvP0xewd+PrccIcQyXVucfYhFBFjDpdNBrA2Ln7jgEZLj3KXYhofJDVJf
         14NZlJ2zA0yrMABoSWjC3R6Z6vOanhL6kqtBmH8N0VDWCm1ajpI/a9d8bvYX2ozHY/
         0LHKWDgULl02CYG37Y4qI7AvtMobXxXdVPDV1MVT/1psUyRxp2xo02axeSG9V7bQVs
         LHwVA85ZjFDvA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7190040714; Tue, 11 Jan 2022 17:01:10 -0300 (-03)
Date:   Tue, 11 Jan 2022 17:01:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Subject: Re: [PATCH v4 48/48] perf cpumap: Give CPUs their own type.
Message-ID: <Yd3iBvVim1vB81pM@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-49-irogers@google.com>
 <YdyOFd8JJHbm1W+m@kernel.org>
 <CAP-5=fWZWMweYhWvv1vr6quZe=ZJrhF_WEXqbELVitzofBcQrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWZWMweYhWvv1vr6quZe=ZJrhF_WEXqbELVitzofBcQrA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 11, 2022 at 11:16:16AM -0800, Ian Rogers escreveu:
> On Mon, Jan 10, 2022 at 11:50 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Jan 04, 2022 at 10:13:51PM -0800, Ian Rogers escreveu:
> > > A common problem is confusing CPU map indices with the CPU, by wrapping
> > > the CPU with a struct then this is avoided. This approach is similar to
> > > atomic_t.
> >
> > This one needed this to build with BUILD_BPF_SKEL=1, please check, I'll
> > soon push this to tmp.perf/perf_cpu so that you can take a look and test
> > it.
> 
> 
> Thanks Arnaldo, I did eye-ball one issue where cpu_map__default_new's
> behavior would be impacted (nr would be 1 rather than nr_cpus). The
> fix is:
> 
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -18,7 +18,7 @@ static struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
>         if (!cpus)
>                 return NULL;
> 
> -       cpus->nr = 1;
> +       cpus->nr = nr_cpus;
>         refcount_set(&cpus->refcnt, 1);
>         return cpus;
>  }

> Could you add that into this patch as well?

Sure.

I´m now running perf-test after each of those csets, so far so good.
 
> Thanks,
> Ian
> 
> 
> > - Arnaldo
> >
> > diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> > index 80d1a3a31052fe55..328479df5e16a638 100644
> > --- a/tools/perf/util/bpf_counter.c
> > +++ b/tools/perf/util/bpf_counter.c
> > @@ -540,7 +540,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
> >                     filter_type == BPERF_FILTER_TGID)
> >                         key = evsel->core.threads->map[i].pid;
> >                 else if (filter_type == BPERF_FILTER_CPU)
> > -                       key = evsel->core.cpus->map[i];
> > +                       key = evsel->core.cpus->map[i].cpu;
> >                 else
> >                         break;
> >
> > @@ -584,7 +584,7 @@ static int bperf_sync_counters(struct evsel *evsel)
> >
> >         num_cpu = all_cpu_map->nr;
> >         for (i = 0; i < num_cpu; i++) {
> > -               cpu = all_cpu_map->map[i];
> > +               cpu = all_cpu_map->map[i].cpu;
> >                 bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
> >         }
> >         return 0;
> > @@ -605,7 +605,7 @@ static int bperf__disable(struct evsel *evsel)
> >  static int bperf__read(struct evsel *evsel)
> >  {
> >         struct bperf_follower_bpf *skel = evsel->follower_skel;
> > -       __u32 num_cpu_bpf = cpu__max_cpu();
> > +       __u32 num_cpu_bpf = cpu__max_cpu().cpu;
> >         struct bpf_perf_event_value values[num_cpu_bpf];
> >         int reading_map_fd, err = 0;
> >         __u32 i;
> > @@ -615,6 +615,7 @@ static int bperf__read(struct evsel *evsel)
> >         reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> >
> >         for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
> > +               struct perf_cpu entry;
> >                 __u32 cpu;
> >
> >                 err = bpf_map_lookup_elem(reading_map_fd, &i, values);
> > @@ -624,14 +625,15 @@ static int bperf__read(struct evsel *evsel)
> >                 case BPERF_FILTER_GLOBAL:
> >                         assert(i == 0);
> >
> > -                       perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
> > +                       perf_cpu_map__for_each_cpu(entry, j, all_cpu_map) {
> > +                               cpu = entry.cpu;
> >                                 perf_counts(evsel->counts, cpu, 0)->val = values[cpu].counter;
> >                                 perf_counts(evsel->counts, cpu, 0)->ena = values[cpu].enabled;
> >                                 perf_counts(evsel->counts, cpu, 0)->run = values[cpu].running;
> >                         }
> >                         break;
> >                 case BPERF_FILTER_CPU:
> > -                       cpu = evsel->core.cpus->map[i];
> > +                       cpu = evsel->core.cpus->map[i].cpu;
> >                         perf_counts(evsel->counts, i, 0)->val = values[cpu].counter;
> >                         perf_counts(evsel->counts, i, 0)->ena = values[cpu].enabled;
> >                         perf_counts(evsel->counts, i, 0)->run = values[cpu].running;
> > diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> > index cbc6c2bca488f6bf..631e34a0b66ff084 100644
> > --- a/tools/perf/util/bpf_counter_cgroup.c
> > +++ b/tools/perf/util/bpf_counter_cgroup.c
> > @@ -48,7 +48,7 @@ static int bperf_load_program(struct evlist *evlist)
> >         struct cgroup *cgrp, *leader_cgrp;
> >         __u32 i, cpu;
> >         __u32 nr_cpus = evlist->core.all_cpus->nr;
> > -       int total_cpus = cpu__max_cpu();
> > +       int total_cpus = cpu__max_cpu().cpu;
> >         int map_size, map_fd;
> >         int prog_fd, err;
> >
> > @@ -125,7 +125,7 @@ static int bperf_load_program(struct evlist *evlist)
> >                         for (cpu = 0; cpu < nr_cpus; cpu++) {
> >                                 int fd = FD(evsel, cpu);
> >                                 __u32 idx = evsel->core.idx * total_cpus +
> > -                                       evlist->core.all_cpus->map[cpu];
> > +                                       evlist->core.all_cpus->map[cpu].cpu;
> >
> >                                 err = bpf_map_update_elem(map_fd, &idx, &fd,
> >                                                           BPF_ANY);
> > @@ -212,7 +212,7 @@ static int bperf_cgrp__sync_counters(struct evlist *evlist)
> >         int prog_fd = bpf_program__fd(skel->progs.trigger_read);
> >
> >         for (i = 0; i < nr_cpus; i++) {
> > -               cpu = evlist->core.all_cpus->map[i];
> > +               cpu = evlist->core.all_cpus->map[i].cpu;
> >                 bperf_trigger_reading(prog_fd, cpu);
> >         }
> >
> > @@ -245,7 +245,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
> >  {
> >         struct evlist *evlist = evsel->evlist;
> >         int i, cpu, nr_cpus = evlist->core.all_cpus->nr;
> > -       int total_cpus = cpu__max_cpu();
> > +       int total_cpus = cpu__max_cpu().cpu;
> >         struct perf_counts_values *counts;
> >         struct bpf_perf_event_value *values;
> >         int reading_map_fd, err = 0;
> > @@ -272,7 +272,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
> >                 }
> >
> >                 for (i = 0; i < nr_cpus; i++) {
> > -                       cpu = evlist->core.all_cpus->map[i];
> > +                       cpu = evlist->core.all_cpus->map[i].cpu;
> >
> >                         counts = perf_counts(evsel->counts, i, 0);
> >                         counts->val = values[cpu].counter;
> > diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
> > index 28dc4c60c7884818..d756cc66eef32ae8 100644
> > --- a/tools/perf/util/bpf_ftrace.c
> > +++ b/tools/perf/util/bpf_ftrace.c
> > @@ -63,7 +63,7 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
> >                 fd = bpf_map__fd(skel->maps.cpu_filter);
> >
> >                 for (i = 0; i < ncpus; i++) {
> > -                       cpu = perf_cpu_map__cpu(ftrace->evlist->core.cpus, i);
> > +                       cpu = perf_cpu_map__cpu(ftrace->evlist->core.cpus, i).cpu;
> >                         bpf_map_update_elem(fd, &cpu, &val, BPF_ANY);
> >                 }
> >         }
> > @@ -122,7 +122,7 @@ int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
> >         int i, fd, err;
> >         u32 idx;
> >         u64 *hist;
> > -       int ncpus = cpu__max_cpu();
> > +       int ncpus = cpu__max_cpu().cpu;
> >
> >         fd = bpf_map__fd(skel->maps.latency);
> >

-- 

- Arnaldo
