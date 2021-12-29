Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9224B480E40
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhL2AhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:37:11 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45013 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhL2AhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:37:10 -0500
Received: by mail-lf1-f45.google.com with SMTP id g26so44491678lfv.11;
        Tue, 28 Dec 2021 16:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOWM3EEvD7fdWp9qIviuq0c9wOogAKxn4lEqLJfiCyg=;
        b=RIbT7ixQLdZMWcY6L4ZMT9CXM1r3kR/gSniD0ZOGww8hGvrbnKBHGYUPPqOEUAsJrO
         wjD+k2wmj93WFAJODP/RF+CCUbzJuj4sJHqtl+DdVjPCGRHSxYkIcTa0DOq3FySc5H8u
         IqqCgKMHer1Bh4u5yfOPxHV2vnWqfqzoQDdp/wI6sw1yf862ahEaMp2vfF1hdwYYs3u4
         EhOwgxwY8xyAOpF8Yw1xcb1qSXBSFLkdl8bzTEiLxNHoV7kEu8Qj/5lHqs6CkHzMeZkl
         LPllnLuWkAQHL4JIocxLhvXZwYgT3nH1nArkBdCe/GFrxepGQSR2qJYMK6Ovycc9z76n
         Zvqg==
X-Gm-Message-State: AOAM530ql5yv0j/+5AxLRNBbFtbRqUa/o/geXrwxRSv3K0yiHtoL1M0u
        jOD2a78rS7nH6gnnEwqO8zYgLjs3PlZYh2oXRdA=
X-Google-Smtp-Source: ABdhPJzAcDXv+BOHRkP0nTH9e4aXMoaw93moV6RNNJeCGL+el0e0ByHxQhEdqL5gUV/HXfI8FLHIIuIJGlg+h9pcVSY=
X-Received: by 2002:ac2:5e8b:: with SMTP id b11mr22415630lfq.47.1640738228836;
 Tue, 28 Dec 2021 16:37:08 -0800 (PST)
MIME-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com> <20211223074541.3318938-31-irogers@google.com>
In-Reply-To: <20211223074541.3318938-31-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Dec 2021 16:36:57 -0800
Message-ID: <CAM9d7cgdDOhRb9bXar5KgCS52FLfRwyj+CXBtx3J5zSa95vXfA@mail.gmail.com>
Subject: Re: [PATCH v2 30/48] perf stat: Rename aggr_data cpu to imply it's an index
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 11:47 PM Ian Rogers <irogers@google.com> wrote:
>
> Trying to make cpu maps less error prone.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c       |  2 +-
>  tools/perf/util/stat-display.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 563a9ba8954f..4b510a1f27d4 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1057,7 +1057,7 @@ static struct mmap *get_md(struct evlist *evlist, int cpu)
>         for (i = 0; i < evlist->core.nr_mmaps; i++) {
>                 struct mmap *md = &evlist->mmap[i];
>
> -               if (md->core.cpu == cpu)
> +               if (md->core.cpu_map_idx == cpu)

It doesn't seem to belong to this change..

Thanks,
Namhyung


>                         return md;
>         }
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 821511ba22cc..4f93591aaa76 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -626,7 +626,7 @@ struct aggr_data {
>         u64 ena, run, val;
>         struct aggr_cpu_id id;
>         int nr;
> -       int cpu;
> +       int cpu_map_idx;
>  };
>
>  static void aggr_cb(struct perf_stat_config *config,
> @@ -878,9 +878,9 @@ static void counter_cb(struct perf_stat_config *config __maybe_unused,
>  {
>         struct aggr_data *ad = data;
>
> -       ad->val += perf_counts(counter->counts, ad->cpu, 0)->val;
> -       ad->ena += perf_counts(counter->counts, ad->cpu, 0)->ena;
> -       ad->run += perf_counts(counter->counts, ad->cpu, 0)->run;
> +       ad->val += perf_counts(counter->counts, ad->cpu_map_idx, 0)->val;
> +       ad->ena += perf_counts(counter->counts, ad->cpu_map_idx, 0)->ena;
> +       ad->run += perf_counts(counter->counts, ad->cpu_map_idx, 0)->run;
>  }
>
>  /*
> @@ -897,7 +897,7 @@ static void print_counter(struct perf_stat_config *config,
>         struct aggr_cpu_id id;
>
>         for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
> -               struct aggr_data ad = { .cpu = cpu };
> +               struct aggr_data ad = { .cpu_map_idx = cpu };
>
>                 if (!collect_data(config, counter, counter_cb, &ad))
>                         return;
> --
> 2.34.1.307.g9b7440fafd-goog
>
