Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34DC517B07
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiEBXz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiEBXzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:55:14 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7596B3AE;
        Mon,  2 May 2022 16:51:43 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w1so27845181lfa.4;
        Mon, 02 May 2022 16:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J29Au43aNgTC2idscwYSuOnypyhEFy3S2IpBzMhtJu8=;
        b=hFXmcdNO9Dljl6vTrXrDBYgDNBc2n3evdWTar9hfyDx8TcpBuZm2zbaT4ylH70IDV3
         zULYrifwyk+EIQZtWamBeZDdGmFyBlA4qa+aGqguoFJoMWE7T5gFAVkeij8QnNs8gO9C
         J+ApentCN59ebdptNvRrXwrGy93z0K+T+2zIltfshNB9/xsT/rxiz3cBvdT56e+UZcoV
         +fz/gyrIkBgZ+4W2zfNjLYk6xiroZtM4++jv6jb3Il7WDcHlKJhgk+7d2fIIPutO3bEq
         dpQwh/cuW8L1xggAIEfHpwawswXH9gVNWXxaIqY/FGsLE/6MYDrhFoGKZGFPq9gy+2e/
         9GsA==
X-Gm-Message-State: AOAM5300diEbL1xkMN95W08mBY7+U8+kT5lFKA+O5zkO2IoTbiw4wz1J
        ykTFXaQonszev8KVt9HMvWYirMomBlYxgu0hnk0=
X-Google-Smtp-Source: ABdhPJx5aX46r2P23k0oblcmvYiBeg+7gTYoL+kgEnKuNqbORvogt3vqtN/xaIWH+8ccELy5XxyZixyEYt7Se/ytq8Y=
X-Received: by 2002:a05:6512:39d3:b0:472:4920:96d7 with SMTP id
 k19-20020a05651239d300b00472492096d7mr10369364lfu.47.1651535501462; Mon, 02
 May 2022 16:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220430062324.1565215-1-irogers@google.com> <20220430062324.1565215-2-irogers@google.com>
In-Reply-To: <20220430062324.1565215-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 2 May 2022 16:51:30 -0700
Message-ID: <CAM9d7cir7=okKG0gNDkCKQQYNWRNA2aUz9+o3vtJFK+xKNjYew@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] perf cpumap: Switch to using perf_cpu_map API
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

On Fri, Apr 29, 2022 at 11:23 PM Ian Rogers <irogers@google.com> wrote:
>
> Switch some raw accesses to the cpu map to using the library API. This
> can help with reference count checking.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[...]
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index ac60c08e8e2a..a4b676920da0 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -47,7 +47,7 @@ static int bperf_load_program(struct evlist *evlist)
>         struct evsel *evsel;
>         struct cgroup *cgrp, *leader_cgrp;
>         __u32 i, cpu;
> -       __u32 nr_cpus = evlist->core.all_cpus->nr;
> +       __u32 nr_cpus = perf_cpu_map__nr(evlist->core.all_cpus);
>         int total_cpus = cpu__max_cpu().cpu;
>         int map_size, map_fd;
>         int prog_fd, err;
> @@ -125,7 +125,7 @@ static int bperf_load_program(struct evlist *evlist)
>                         for (cpu = 0; cpu < nr_cpus; cpu++) {
>                                 int fd = FD(evsel, cpu);
>                                 __u32 idx = evsel->core.idx * total_cpus +
> -                                       evlist->core.all_cpus->map[cpu].cpu;
> +                                       perf_cpu_map__cpu(evlist->core.all_cpus, cpu).cpu;
>
>                                 err = bpf_map_update_elem(map_fd, &idx, &fd,
>                                                           BPF_ANY);
> @@ -207,13 +207,13 @@ static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
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
> +       perf_cpu_map__for_each_cpu(cpu, idx, cpus) {

s/cpus/evlist->core.all_cpus/?

> +               cpu = perf_cpu_map__cpu(evlist->core.all_cpus, i);

I don't think we need this line anymore.

> +               bperf_trigger_reading(prog_fd, cpu.cpu);
>         }
>
>         return 0;
> @@ -244,12 +244,10 @@ static int bperf_cgrp__disable(struct evsel *evsel)
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
> @@ -263,7 +261,10 @@ static int bperf_cgrp__read(struct evsel *evsel)
>         reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
>
>         evlist__for_each_entry(evlist, evsel) {
> -               idx = evsel->core.idx;
> +               __u32 idx = evsel->core.idx;
> +               int i;
> +               struct perf_cpu_map cpu;
> +
>                 err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
>                 if (err) {
>                         pr_err("bpf map lookup failed: idx=%u, event=%s, cgrp=%s\n",
> @@ -271,13 +272,11 @@ static int bperf_cgrp__read(struct evsel *evsel)
>                         goto out;
>                 }
>
> -               for (i = 0; i < nr_cpus; i++) {
> -                       cpu = evlist->core.all_cpus->map[i].cpu;
> -
> +               perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpu) {

evlist->core.all_cpus ?

Thanks,
Namhyung


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
