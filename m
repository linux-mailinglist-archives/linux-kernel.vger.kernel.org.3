Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C78480E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbhL2ASn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:18:43 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:33658 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhL2ASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:18:42 -0500
Received: by mail-lf1-f54.google.com with SMTP id k21so44539890lfu.0;
        Tue, 28 Dec 2021 16:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kSlZtf2qd90AE80B6FU3qu3YV/jUpRRYZZboHWcOZs=;
        b=cAKva1ab6VIo2qYp6epkeGtzRSAhM373iGYKPfx39FOgkS7Ivuq6G88YqIOv23zXQd
         iza9N8jxfpbvkf2TGucSW3oDGR9HNvyf8M9JFvwpldH+By9bTPDusKQZ0OFcy6rCZoEH
         9wcbjR+vvKCLl955YQBxydUF2wT28XKEkpu6vmQn15nCxzDUJoMFes6vUKw0npshzy9E
         Bgl1FkQitJm/iYrskRgXvLJHH8mSegxEu5srFVcFJrNncRx433zDfuRe72Ku6DxELNta
         OPevIDS4rjNrcTwcsRu9kMa2EeYxjFYviebL/ymq+jgyLOKddH6LZPt7hmQS6fPmuklY
         hHHQ==
X-Gm-Message-State: AOAM53145kIUkoCQqMj6o7FqLCVoPjvkB+ZNwI0sBI4hrcKUDLFOQodI
        b0uv8oCJ8aLkLSah5C6Y3cNVK2ur4Lc3ic1WA5Q=
X-Google-Smtp-Source: ABdhPJx47NWChZOlcQSiUkrgjqVLZcbrDzlPxM/8K5gK/e8RWdjfuHWWhzjQmiCUGun8ZYMF61AWqpgDdjwYLMKsq9g=
X-Received: by 2002:ac2:5e8b:: with SMTP id b11mr22363125lfq.47.1640737120394;
 Tue, 28 Dec 2021 16:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com> <20211223074541.3318938-27-irogers@google.com>
In-Reply-To: <20211223074541.3318938-27-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Dec 2021 16:18:29 -0800
Message-ID: <CAM9d7cjTUX+A4OiH2Hd9Gnfk7KNK7rSG4i++X2-9hczkN3SR6g@mail.gmail.com>
Subject: Re: [PATCH v2 26/48] perf evsel: Derive CPUs and threads in alloc_counts
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
> Passing the number of CPUs and threads allows for an evsel's counts to
> be mismatched to its cpu map. To avoid this always derive the counts
> size from the cpu map. Change openaat-syscall-all-cpus to set the cpus

s/openaat/openat/

> to allow for this to work.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/openat-syscall-all-cpus.c | 10 +---------
>  tools/perf/util/counts.c                   |  8 ++++++--
>  tools/perf/util/counts.h                   |  2 +-
>  tools/perf/util/evsel.c                    |  2 +-
>  tools/perf/util/stat.c                     | 13 ++++++-------
>  5 files changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
> index cd3dd463783f..544db0839b3b 100644
> --- a/tools/perf/tests/openat-syscall-all-cpus.c
> +++ b/tools/perf/tests/openat-syscall-all-cpus.c
> @@ -85,15 +85,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
>                 CPU_CLR(cpus->map[cpu], &cpu_set);
>         }
>
> -       /*
> -        * Here we need to explicitly preallocate the counts, as if
> -        * we use the auto allocation it will allocate just for 1 cpu,
> -        * as we start by cpu 0.
> -        */
> -       if (evsel__alloc_counts(evsel, cpus->nr, 1) < 0) {
> -               pr_debug("evsel__alloc_counts(ncpus=%d)\n", cpus->nr);
> -               goto out_close_fd;
> -       }
> +       evsel->core.cpus = perf_cpu_map__get(cpus);

I was about to write that you need to call
evsel__alloc_counts() after this.  But it seems
evsel__read_on_cpu() can do the job later.
So I'm fine with this. :)

Thanks,
Namhyung

>
>         err = 0;
>
> diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
> index 582f3aeaf5e4..2b81707b9dba 100644
> --- a/tools/perf/util/counts.c
> +++ b/tools/perf/util/counts.c
> @@ -4,6 +4,7 @@
>  #include <string.h>
>  #include "evsel.h"
>  #include "counts.h"
> +#include <perf/threadmap.h>
>  #include <linux/zalloc.h>
>
>  struct perf_counts *perf_counts__new(int ncpus, int nthreads)
> @@ -55,9 +56,12 @@ void evsel__reset_counts(struct evsel *evsel)
>         perf_counts__reset(evsel->counts);
>  }
>
> -int evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads)
> +int evsel__alloc_counts(struct evsel *evsel)
>  {
> -       evsel->counts = perf_counts__new(ncpus, nthreads);
> +       struct perf_cpu_map *cpus = evsel__cpus(evsel);
> +       int nthreads = perf_thread_map__nr(evsel->core.threads);
> +
> +       evsel->counts = perf_counts__new(cpus ? cpus->nr : 1, nthreads);
>         return evsel->counts != NULL ? 0 : -ENOMEM;
>  }
>
> diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
> index 7ff36bf6d644..3e275e9c60d1 100644
> --- a/tools/perf/util/counts.h
> +++ b/tools/perf/util/counts.h
> @@ -40,7 +40,7 @@ void perf_counts__delete(struct perf_counts *counts);
>  void perf_counts__reset(struct perf_counts *counts);
>
>  void evsel__reset_counts(struct evsel *evsel);
> -int evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads);
> +int evsel__alloc_counts(struct evsel *evsel);
>  void evsel__free_counts(struct evsel *evsel);
>
>  #endif /* __PERF_COUNTS_H */
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 656c30b988ce..6c9af21776e6 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1578,7 +1578,7 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
>         if (FD(evsel, cpu, thread) < 0)
>                 return -EINVAL;
>
> -       if (evsel->counts == NULL && evsel__alloc_counts(evsel, cpu + 1, thread + 1) < 0)
> +       if (evsel->counts == NULL && evsel__alloc_counts(evsel) < 0)
>                 return -ENOMEM;
>
>         if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) <= 0)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index c69b221f5e3e..995cb5003133 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -152,11 +152,13 @@ static void evsel__free_stat_priv(struct evsel *evsel)
>         zfree(&evsel->stats);
>  }
>
> -static int evsel__alloc_prev_raw_counts(struct evsel *evsel, int ncpus, int nthreads)
> +static int evsel__alloc_prev_raw_counts(struct evsel *evsel)
>  {
> +       int cpu_map_nr = evsel__nr_cpus(evsel);
> +       int nthreads = perf_thread_map__nr(evsel->core.threads);
>         struct perf_counts *counts;
>
> -       counts = perf_counts__new(ncpus, nthreads);
> +       counts = perf_counts__new(cpu_map_nr, nthreads);
>         if (counts)
>                 evsel->prev_raw_counts = counts;
>
> @@ -177,12 +179,9 @@ static void evsel__reset_prev_raw_counts(struct evsel *evsel)
>
>  static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
>  {
> -       int ncpus = evsel__nr_cpus(evsel);
> -       int nthreads = perf_thread_map__nr(evsel->core.threads);
> -
>         if (evsel__alloc_stat_priv(evsel) < 0 ||
> -           evsel__alloc_counts(evsel, ncpus, nthreads) < 0 ||
> -           (alloc_raw && evsel__alloc_prev_raw_counts(evsel, ncpus, nthreads) < 0))
> +           evsel__alloc_counts(evsel) < 0 ||
> +           (alloc_raw && evsel__alloc_prev_raw_counts(evsel) < 0))
>                 return -ENOMEM;
>
>         return 0;
> --
> 2.34.1.307.g9b7440fafd-goog
>
