Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7E48B6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350841AbiAKTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350678AbiAKTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:56 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443BEC029822
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:16:29 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d14so88933ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2KFfPbPRBt8YGYlaB2/t+lZ75sWpufY8ClCo8t5CDk=;
        b=WmJYV/WX+ELYGJn8X4yZ09RWnDx3L0/A+mRB9WOVuSRDB0uWdu2CI+t3tVrEtRayub
         aJBEpOgJao68JwUMzGBE7SOXd4nYG129LdkjkkPNfprxdN361RHLQVs8s+w+uZlUvB03
         nHQDdI/ziiIXmK1FcqstDiBskRJdvNEAE1rAJRMaWdazoWkhaYaoJB12SrMRXeAsBOZG
         fkLSD86BSL0VEyk9H7CVuCIz6gj76PUc2PAgOQF6uJDPkemF7E8aORa5cJ3YFve9Zlue
         zLReT6vszv2cjrhW0v6Eu43k2poOHMICMSDKvfIKTPKJ2UdHC1+5OTvYugRzU3gFdfTi
         HbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2KFfPbPRBt8YGYlaB2/t+lZ75sWpufY8ClCo8t5CDk=;
        b=bKOV1phYJ8f/SNS3FQmslhIYVREG5aMp+hqaGwbV9qYLHQWIVf5nIzxtp1Gebg3yax
         MGVh+CuUVKTxBDfPF+Y0WS2etSN+28OKXcH+V7ZUyqGxq4gTvTLniEj15ChHG73K+hWP
         5ZlpNPQORCkX+3fn82mAlBQvSIXs3EOVh7ZECzTHo5wVoREV+IUCzIZrcYUHlLABupGm
         Zcs/0C8JJ4e0zEDIAgcK8an5G2ajhAHer9TcuJjkkVhD88V876Gh8b2s0kl9gCnLx1jj
         E+2GidO+8lHUSOq2fSn2u6ccOKckcwZRFZZ/FcxAtSVs6bM0nzs+OJCtivVOi11lmxvW
         KKvw==
X-Gm-Message-State: AOAM530zFKfOx157glhp4GCUQ/BzHXPCmUSHsxQ9OPgrL9CUAn2tqjpB
        0J4CWsmq0kngw0TY6AzcgN5ClfeOL9DcdIj0322xZQ==
X-Google-Smtp-Source: ABdhPJz9kJk8A7Pxek51nVV4rDgfhl7f0EWvWG5QHBoFEMoMa81pmsNniD6ODk33n+xr/uv1TB4xr/BoNsATiJzSFR8=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr3173172ils.53.1641928588347;
 Tue, 11 Jan 2022 11:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-49-irogers@google.com>
 <YdyOFd8JJHbm1W+m@kernel.org>
In-Reply-To: <YdyOFd8JJHbm1W+m@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jan 2022 11:16:16 -0800
Message-ID: <CAP-5=fWZWMweYhWvv1vr6quZe=ZJrhF_WEXqbELVitzofBcQrA@mail.gmail.com>
Subject: Re: [PATCH v4 48/48] perf cpumap: Give CPUs their own type.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:50 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jan 04, 2022 at 10:13:51PM -0800, Ian Rogers escreveu:
> > A common problem is confusing CPU map indices with the CPU, by wrapping
> > the CPU with a struct then this is avoided. This approach is similar to
> > atomic_t.
>
> This one needed this to build with BUILD_BPF_SKEL=1, please check, I'll
> soon push this to tmp.perf/perf_cpu so that you can take a look and test
> it.


Thanks Arnaldo, I did eye-ball one issue where cpu_map__default_new's
behavior would be impacted (nr would be 1 rather than nr_cpus). The
fix is:

--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -18,7 +18,7 @@ static struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
        if (!cpus)
                return NULL;

-       cpus->nr = 1;
+       cpus->nr = nr_cpus;
        refcount_set(&cpus->refcnt, 1);
        return cpus;
 }

Could you add that into this patch as well?

Thanks,
Ian


> - Arnaldo
>
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 80d1a3a31052fe55..328479df5e16a638 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -540,7 +540,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>                     filter_type == BPERF_FILTER_TGID)
>                         key = evsel->core.threads->map[i].pid;
>                 else if (filter_type == BPERF_FILTER_CPU)
> -                       key = evsel->core.cpus->map[i];
> +                       key = evsel->core.cpus->map[i].cpu;
>                 else
>                         break;
>
> @@ -584,7 +584,7 @@ static int bperf_sync_counters(struct evsel *evsel)
>
>         num_cpu = all_cpu_map->nr;
>         for (i = 0; i < num_cpu; i++) {
> -               cpu = all_cpu_map->map[i];
> +               cpu = all_cpu_map->map[i].cpu;
>                 bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
>         }
>         return 0;
> @@ -605,7 +605,7 @@ static int bperf__disable(struct evsel *evsel)
>  static int bperf__read(struct evsel *evsel)
>  {
>         struct bperf_follower_bpf *skel = evsel->follower_skel;
> -       __u32 num_cpu_bpf = cpu__max_cpu();
> +       __u32 num_cpu_bpf = cpu__max_cpu().cpu;
>         struct bpf_perf_event_value values[num_cpu_bpf];
>         int reading_map_fd, err = 0;
>         __u32 i;
> @@ -615,6 +615,7 @@ static int bperf__read(struct evsel *evsel)
>         reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
>
>         for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
> +               struct perf_cpu entry;
>                 __u32 cpu;
>
>                 err = bpf_map_lookup_elem(reading_map_fd, &i, values);
> @@ -624,14 +625,15 @@ static int bperf__read(struct evsel *evsel)
>                 case BPERF_FILTER_GLOBAL:
>                         assert(i == 0);
>
> -                       perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
> +                       perf_cpu_map__for_each_cpu(entry, j, all_cpu_map) {
> +                               cpu = entry.cpu;
>                                 perf_counts(evsel->counts, cpu, 0)->val = values[cpu].counter;
>                                 perf_counts(evsel->counts, cpu, 0)->ena = values[cpu].enabled;
>                                 perf_counts(evsel->counts, cpu, 0)->run = values[cpu].running;
>                         }
>                         break;
>                 case BPERF_FILTER_CPU:
> -                       cpu = evsel->core.cpus->map[i];
> +                       cpu = evsel->core.cpus->map[i].cpu;
>                         perf_counts(evsel->counts, i, 0)->val = values[cpu].counter;
>                         perf_counts(evsel->counts, i, 0)->ena = values[cpu].enabled;
>                         perf_counts(evsel->counts, i, 0)->run = values[cpu].running;
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index cbc6c2bca488f6bf..631e34a0b66ff084 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -48,7 +48,7 @@ static int bperf_load_program(struct evlist *evlist)
>         struct cgroup *cgrp, *leader_cgrp;
>         __u32 i, cpu;
>         __u32 nr_cpus = evlist->core.all_cpus->nr;
> -       int total_cpus = cpu__max_cpu();
> +       int total_cpus = cpu__max_cpu().cpu;
>         int map_size, map_fd;
>         int prog_fd, err;
>
> @@ -125,7 +125,7 @@ static int bperf_load_program(struct evlist *evlist)
>                         for (cpu = 0; cpu < nr_cpus; cpu++) {
>                                 int fd = FD(evsel, cpu);
>                                 __u32 idx = evsel->core.idx * total_cpus +
> -                                       evlist->core.all_cpus->map[cpu];
> +                                       evlist->core.all_cpus->map[cpu].cpu;
>
>                                 err = bpf_map_update_elem(map_fd, &idx, &fd,
>                                                           BPF_ANY);
> @@ -212,7 +212,7 @@ static int bperf_cgrp__sync_counters(struct evlist *evlist)
>         int prog_fd = bpf_program__fd(skel->progs.trigger_read);
>
>         for (i = 0; i < nr_cpus; i++) {
> -               cpu = evlist->core.all_cpus->map[i];
> +               cpu = evlist->core.all_cpus->map[i].cpu;
>                 bperf_trigger_reading(prog_fd, cpu);
>         }
>
> @@ -245,7 +245,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
>  {
>         struct evlist *evlist = evsel->evlist;
>         int i, cpu, nr_cpus = evlist->core.all_cpus->nr;
> -       int total_cpus = cpu__max_cpu();
> +       int total_cpus = cpu__max_cpu().cpu;
>         struct perf_counts_values *counts;
>         struct bpf_perf_event_value *values;
>         int reading_map_fd, err = 0;
> @@ -272,7 +272,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
>                 }
>
>                 for (i = 0; i < nr_cpus; i++) {
> -                       cpu = evlist->core.all_cpus->map[i];
> +                       cpu = evlist->core.all_cpus->map[i].cpu;
>
>                         counts = perf_counts(evsel->counts, i, 0);
>                         counts->val = values[cpu].counter;
> diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
> index 28dc4c60c7884818..d756cc66eef32ae8 100644
> --- a/tools/perf/util/bpf_ftrace.c
> +++ b/tools/perf/util/bpf_ftrace.c
> @@ -63,7 +63,7 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
>                 fd = bpf_map__fd(skel->maps.cpu_filter);
>
>                 for (i = 0; i < ncpus; i++) {
> -                       cpu = perf_cpu_map__cpu(ftrace->evlist->core.cpus, i);
> +                       cpu = perf_cpu_map__cpu(ftrace->evlist->core.cpus, i).cpu;
>                         bpf_map_update_elem(fd, &cpu, &val, BPF_ANY);
>                 }
>         }
> @@ -122,7 +122,7 @@ int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
>         int i, fd, err;
>         u32 idx;
>         u64 *hist;
> -       int ncpus = cpu__max_cpu();
> +       int ncpus = cpu__max_cpu().cpu;
>
>         fd = bpf_map__fd(skel->maps.latency);
>
