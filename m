Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835125158BE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381662AbiD2XBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiD2XBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:01:23 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D43CE4B5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:58:03 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id n14so16402553lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziMACgLom846eNy1FVlDF6Zdf3bclvVhrrDsjq01XVQ=;
        b=GD9//itZ405d3WoT0gyQyZCF8Di1tIPT75UAnPWGUUiIW/F79dEy99hQBfPEjotpQg
         C1xjc3MH44poLjHULsi9e79i5Qstf8JcPGgqYvaPvQ1/L3qMO+h0UbYt3EX89+3h5nzZ
         mRomNNpsdKDGz2doawQtxS65SgeVDkxVkKF38A3XUZHiHfxBv2eIJhPWJoXqA+pKlKJa
         WVSrGScZBepeQeNY5ABOSekYj4i5FjLpwUhYzkibgiCqnMeLZRJVLvHKc+MSmLgawvuX
         ZDC0kVVlOGMbKFB2joeU+aSEvkUzWRU0BvcowGOxgi2onP8WpASjdSQiqPM9WtASfmMG
         9ZMw==
X-Gm-Message-State: AOAM533OKdrXPxsM+h1Z5jITYFQQ52+Oddjm9g+bMUE/ozpuFBoklb1G
        qLmWvyMNsFmKwAUvyjplPgtGX1E0OUqSkpEKnm1wh3o/
X-Google-Smtp-Source: ABdhPJzXwXLcAqV02XguwoswO04EyM24jEqdyIpWTltYWYwm2cuchZRZB+DcCBf48iFf2zg+GYfNyFD5AdQKHEjTrEQ=
X-Received: by 2002:a19:6744:0:b0:46d:185f:5322 with SMTP id
 e4-20020a196744000000b0046d185f5322mr1011953lfj.586.1651273081933; Fri, 29
 Apr 2022 15:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220422162402.147958-1-adrian.hunter@intel.com> <20220422162402.147958-20-adrian.hunter@intel.com>
In-Reply-To: <20220422162402.147958-20-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 29 Apr 2022 15:57:50 -0700
Message-ID: <CAM9d7cir40QisAK7AxsO6Rm3ARpPNLy8L6SFHXpHJ=Eu8obA5w@mail.gmail.com>
Subject: Re: [PATCH RFC 19/21] perf stat: Add requires_cpu flag for uncore
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:25 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Uncore events require a CPU i.e. it cannot be -1.
>
> The evsel system_wide flag is intended for events that should be on every
> CPU, which does not make sense for uncore events because uncore events do
> not map one-to-one with CPUs.
>
> These 2 requirements are not exactly the same, so introduce a new flag
> 'requires_cpu' the uncore case.

Yeah, I like this change!  I was often confused by the two different things.

Thanks,
Namhyung

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evlist.c                 | 4 +++-
>  tools/lib/perf/include/internal/evsel.h | 1 +
>  tools/perf/builtin-stat.c               | 5 +----
>  tools/perf/util/evsel.c                 | 1 +
>  tools/perf/util/parse-events.c          | 2 +-
>  5 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 37dfa9d936a7..9fbcca3fc836 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -42,7 +42,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>         if (!evsel->own_cpus || evlist->has_user_cpus) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> -       } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus)) {
> +       } else if (!evsel->system_wide &&
> +                  !evsel->requires_cpu &&
> +                  perf_cpu_map__empty(evlist->user_requested_cpus)) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>         } else if (evsel->cpus != evsel->own_cpus) {
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> index cfc9ebd7968e..77fbb8b97e5c 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -50,6 +50,7 @@ struct perf_evsel {
>         /* parse modifier helper */
>         int                      nr_members;
>         bool                     system_wide;
> +       bool                     requires_cpu;
>         int                      idx;
>  };
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a96f106dc93a..8972ae546cfe 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -364,9 +364,6 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_
>         if (!counter->supported)
>                 return -ENOENT;
>
> -       if (counter->core.system_wide)
> -               nthreads = 1;
> -
>         for (thread = 0; thread < nthreads; thread++) {
>                 struct perf_counts_values *count;
>
> @@ -2224,7 +2221,7 @@ static void setup_system_wide(int forks)
>                 struct evsel *counter;
>
>                 evlist__for_each_entry(evsel_list, counter) {
> -                       if (!counter->core.system_wide &&
> +                       if (!counter->core.requires_cpu &&
>                             strcmp(counter->name, "duration_time")) {
>                                 return;
>                         }
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2a1729e7aee4..81bbddb6fbc0 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -382,6 +382,7 @@ struct evsel *evsel__clone(struct evsel *orig)
>         evsel->core.threads = perf_thread_map__get(orig->core.threads);
>         evsel->core.nr_members = orig->core.nr_members;
>         evsel->core.system_wide = orig->core.system_wide;
> +       evsel->core.requires_cpu = orig->core.requires_cpu;
>
>         if (orig->name) {
>                 evsel->name = strdup(orig->name);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index dd84fed698a3..783359017548 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -350,7 +350,7 @@ __add_event(struct list_head *list, int *idx,
>         (*idx)++;
>         evsel->core.cpus = cpus;
>         evsel->core.own_cpus = perf_cpu_map__get(cpus);
> -       evsel->core.system_wide = pmu ? pmu->is_uncore : false;
> +       evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
>         evsel->auto_merge_stats = auto_merge_stats;
>
>         if (name)
> --
> 2.25.1
>
