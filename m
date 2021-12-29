Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ABE480E68
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 02:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbhL2A7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:59:12 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:38611 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbhL2A7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:59:10 -0500
Received: by mail-lf1-f50.google.com with SMTP id x21so44652164lfa.5;
        Tue, 28 Dec 2021 16:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNS82RmN/G6p71wRtkaGNMucODNCY3Fc4PUc32RxirQ=;
        b=n+jHX3mT7869uCkoAG+7H5a0L2H2BW6fGf7WqSY4kCdduDao7ju+AkaOY1MKQSv4M4
         UbUlY0eZP+nMZLqiVHJFJECK6loGwGDycgcIcJUdVPyBlU7s9qLafmvf8vb8vUTagudy
         T7VdU2JXFaoVO03uKICjYINY6rPFEKfIJvFYHjz+47Dq+6Bp7YnDxdztLMkAsLH/x3yg
         HQHuY3ckTiL2VbUMk3yhuECrR9PQhtZNyadYleZai3Qca+BynNXTacYUE8dEiqxHn84u
         T4MptU5lQh7eQsKnmS2yHtZS2J2A+Oib8CKd413LMgNZzJEwbQhgSXgH8WkqX18SDYyD
         rZog==
X-Gm-Message-State: AOAM5301+Xrd/kAL/Jro1AFUL55Okk33nvfLPvMd3RxU8wT0BHhIWwfx
        fhsqPkmW0z9n3HSbxI/8e2qrQDPz4KcaXFIBiEk=
X-Google-Smtp-Source: ABdhPJyVp2KHpj7U95STMtmGWt3VgUgU7DG9BdGcABJEjv4F2fpeztISOuOk+iTUtSrKKg9cV96Dx10cTO3WMfIS/18=
X-Received: by 2002:a05:6512:16a6:: with SMTP id bu38mr1168532lfb.454.1640739549151;
 Tue, 28 Dec 2021 16:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com> <20211223074541.3318938-35-irogers@google.com>
In-Reply-To: <20211223074541.3318938-35-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Dec 2021 16:58:57 -0800
Message-ID: <CAM9d7cjRhxtJ3avtVZOd5b1AJTNEp3Vk9w8z2fX8QJjWL27w-A@mail.gmail.com>
Subject: Re: [PATCH v2 34/48] perf evlist: Refactor evlist__for_each_cpu.
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
> Previously evlist__for_each_cpu needed to iterate over the evlist in an
> inner loop and call "skip" routines. Refactor this so that the iteratr
> is smarter and the next function can update both the current CPU and
> evsel.
>
> By using a cpu map index, fix apparent off-by-1 in __run_perf_stat's
> call to perf_evsel__close_cpu.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 5f92319ce258..39d294f6c321 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -342,36 +342,65 @@ static int evlist__nr_threads(struct evlist *evlist, struct evsel *evsel)
>                 return perf_thread_map__nr(evlist->core.threads);
>  }
>
> -void evlist__cpu_iter_start(struct evlist *evlist)
> -{
> -       struct evsel *pos;
> -
> -       /*
> -        * Reset the per evsel cpu_iter. This is needed because
> -        * each evsel's cpumap may have a different index space,
> -        * and some operations need the index to modify
> -        * the FD xyarray (e.g. open, close)
> -        */
> -       evlist__for_each_entry(evlist, pos)
> -               pos->cpu_iter = 0;
> -}
> +struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity)

I think we can rename it to evlist_cpu_iterator__begin().


> +{
> +       struct evlist_cpu_iterator itr = {
> +               .container = evlist,
> +               .evsel = evlist__first(evlist),
> +               .cpu_map_idx = 0,
> +               .evlist_cpu_map_idx = 0,
> +               .evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
> +               .cpu = -1,
> +               .affinity = affinity,
> +       };
>
> -bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu)
> -{
> -       if (ev->cpu_iter >= ev->core.cpus->nr)
> -               return true;
> -       if (cpu >= 0 && ev->core.cpus->map[ev->cpu_iter] != cpu)
> -               return true;
> -       return false;
> +       if (itr.affinity) {
> +               itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
> +               affinity__set(itr.affinity, itr.cpu);
> +               itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);

This doesn't match to the evlist_cpu_iterator__next() when
affinity is NULL.  It should set the cpu and cpu_map_idx.

Other than that, I like this! :)

Thanks,
Namhyung


> +               /*
> +                * If this CPU isn't in the evsel's cpu map then advance through
> +                * the list.
> +                */
> +               if (itr.cpu_map_idx == -1)
> +                       evlist_cpu_iterator__next(&itr);
> +       }
> +       return itr;
> +}
> +
> +void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr)
> +{
> +       while (evlist_cpu_itr->evsel != evlist__last(evlist_cpu_itr->container)) {
> +               evlist_cpu_itr->evsel = evsel__next(evlist_cpu_itr->evsel);
> +               evlist_cpu_itr->cpu_map_idx =
> +                       perf_cpu_map__idx(evlist_cpu_itr->evsel->core.cpus,
> +                                         evlist_cpu_itr->cpu);
> +               if (evlist_cpu_itr->cpu_map_idx != -1)
> +                       return;
> +       }
> +       evlist_cpu_itr->evlist_cpu_map_idx++;
> +       if (evlist_cpu_itr->evlist_cpu_map_idx < evlist_cpu_itr->evlist_cpu_map_nr) {
> +               evlist_cpu_itr->evsel = evlist__first(evlist_cpu_itr->container);
> +               evlist_cpu_itr->cpu =
> +                       perf_cpu_map__cpu(evlist_cpu_itr->container->core.all_cpus,
> +                                         evlist_cpu_itr->evlist_cpu_map_idx);
> +               if (evlist_cpu_itr->affinity)
> +                       affinity__set(evlist_cpu_itr->affinity, evlist_cpu_itr->cpu);
> +               evlist_cpu_itr->cpu_map_idx =
> +                       perf_cpu_map__idx(evlist_cpu_itr->evsel->core.cpus,
> +                                         evlist_cpu_itr->cpu);
> +               /*
> +                * If this CPU isn't in the evsel's cpu map then advance through
> +                * the list.
> +                */
> +               if (evlist_cpu_itr->cpu_map_idx == -1)
> +                       evlist_cpu_iterator__next(evlist_cpu_itr);
> +       }
>  }
>
> -bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
> +bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr)
>  {
> -       if (!evsel__cpu_iter_skip_no_inc(ev, cpu)) {
> -               ev->cpu_iter++;
> -               return false;
> -       }
> -       return true;
> +       return evlist_cpu_itr->evlist_cpu_map_idx >= evlist_cpu_itr->evlist_cpu_map_nr;
>  }
>
>  static int evsel__strcmp(struct evsel *pos, char *evsel_name)
> @@ -400,31 +429,26 @@ static int evlist__is_enabled(struct evlist *evlist)
>  static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>  {
>         struct evsel *pos;
> +       struct evlist_cpu_iterator evlist_cpu_itr;
>         struct affinity affinity;
> -       int cpu, i, imm = 0;
>         bool has_imm = false;
>
>         if (affinity__setup(&affinity) < 0)
>                 return;
>
>         /* Disable 'immediate' events last */
> -       for (imm = 0; imm <= 1; imm++) {
> -               evlist__for_each_cpu(evlist, i, cpu) {
> -                       affinity__set(&affinity, cpu);
> -
> -                       evlist__for_each_entry(evlist, pos) {
> -                               if (evsel__strcmp(pos, evsel_name))
> -                                       continue;
> -                               if (evsel__cpu_iter_skip(pos, cpu))
> -                                       continue;
> -                               if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
> -                                       continue;
> -                               if (pos->immediate)
> -                                       has_imm = true;
> -                               if (pos->immediate != imm)
> -                                       continue;
> -                               evsel__disable_cpu(pos, pos->cpu_iter - 1);
> -                       }
> +       for (int imm = 0; imm <= 1; imm++) {
> +               evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
> +                       pos = evlist_cpu_itr.evsel;
> +                       if (evsel__strcmp(pos, evsel_name))
> +                               continue;
> +                       if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
> +                               continue;
> +                       if (pos->immediate)
> +                               has_imm = true;
> +                       if (pos->immediate != imm)
> +                               continue;
> +                       evsel__disable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
>                 }
>                 if (!has_imm)
>                         break;
> @@ -462,24 +486,19 @@ void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
>  static void __evlist__enable(struct evlist *evlist, char *evsel_name)
>  {
>         struct evsel *pos;
> +       struct evlist_cpu_iterator evlist_cpu_itr;
>         struct affinity affinity;
> -       int cpu, i;
>
>         if (affinity__setup(&affinity) < 0)
>                 return;
>
> -       evlist__for_each_cpu(evlist, i, cpu) {
> -               affinity__set(&affinity, cpu);
> -
> -               evlist__for_each_entry(evlist, pos) {
> -                       if (evsel__strcmp(pos, evsel_name))
> -                               continue;
> -                       if (evsel__cpu_iter_skip(pos, cpu))
> -                               continue;
> -                       if (!evsel__is_group_leader(pos) || !pos->core.fd)
> -                               continue;
> -                       evsel__enable_cpu(pos, pos->cpu_iter - 1);
> -               }
> +       evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
> +               pos = evlist_cpu_itr.evsel;
> +               if (evsel__strcmp(pos, evsel_name))
> +                       continue;
> +               if (!evsel__is_group_leader(pos) || !pos->core.fd)
> +                       continue;
> +               evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
>         }
>         affinity__cleanup(&affinity);
>         evlist__for_each_entry(evlist, pos) {
> @@ -1264,8 +1283,8 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel)
>  void evlist__close(struct evlist *evlist)
>  {
>         struct evsel *evsel;
> +       struct evlist_cpu_iterator evlist_cpu_itr;
>         struct affinity affinity;
> -       int cpu, i;
>
>         /*
>          * With perf record core.cpus is usually NULL.
> @@ -1279,15 +1298,12 @@ void evlist__close(struct evlist *evlist)
>
>         if (affinity__setup(&affinity) < 0)
>                 return;
> -       evlist__for_each_cpu(evlist, i, cpu) {
> -               affinity__set(&affinity, cpu);
>
> -               evlist__for_each_entry_reverse(evlist, evsel) {
> -                       if (evsel__cpu_iter_skip(evsel, cpu))
> -                           continue;
> -                       perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
> -               }
> +       evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
> +               perf_evsel__close_cpu(&evlist_cpu_itr.evsel->core,
> +                                     evlist_cpu_itr.cpu_map_idx);
>         }
> +
>         affinity__cleanup(&affinity);
>         evlist__for_each_entry_reverse(evlist, evsel) {
>                 perf_evsel__free_fd(&evsel->core);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 27594900a052..57828ebfcb61 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -327,17 +327,53 @@ void evlist__to_front(struct evlist *evlist, struct evsel *move_evsel);
>  #define evlist__for_each_entry_safe(evlist, tmp, evsel) \
>         __evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
>
> -#define evlist__for_each_cpu(evlist, index, cpu)       \
> -       evlist__cpu_iter_start(evlist);                 \
> -       perf_cpu_map__for_each_cpu (cpu, index, (evlist)->core.all_cpus)
> +/** Iterator state for evlist__for_each_cpu */
> +struct evlist_cpu_iterator {
> +       /** The list being iterated through. */
> +       struct evlist *container;
> +       /** The current evsel of the iterator. */
> +       struct evsel *evsel;
> +       /** The CPU map index corresponding to the evsel->core.cpus for the current CPU. */
> +       int cpu_map_idx;
> +       /**
> +        * The CPU map index corresponding to evlist->core.all_cpus for the
> +        * current CPU.  Distinct from cpu_map_idx as the evsel's cpu map may
> +        * contain fewer entries.
> +        */
> +       int evlist_cpu_map_idx;
> +       /** The number of CPU map entries in evlist->core.all_cpus. */
> +       int evlist_cpu_map_nr;
> +       /** The current CPU of the iterator. */
> +       int cpu;
> +       /** If present, used to set the affinity when switching between CPUs. */
> +       struct affinity *affinity;
> +};
> +
> +/**
> + * evlist__for_each_cpu - without affinity, iterate over the evlist. With
> + *                        affinity, iterate over all CPUs and then the evlist
> + *                        for each evsel on that CPU. When switching between
> + *                        CPUs the affinity is set to the CPU to avoid IPIs
> + *                        during syscalls.
> + * @evlist_cpu_itr: the iterator instance.
> + * @evlist: evlist instance to iterate.
> + * @affinity: NULL or used to set the affinity to the current CPU.
> + */
> +#define evlist__for_each_cpu(evlist_cpu_itr, evlist, affinity)         \
> +       for ((evlist_cpu_itr) = evlist__cpu_begin(evlist, affinity);    \
> +            !evlist_cpu_iterator__end(&evlist_cpu_itr);                \
> +            evlist_cpu_iterator__next(&evlist_cpu_itr))
> +
> +/** Returns an iterator set to the first CPU/evsel of evlist. */
> +struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity);
> +/** Move to next element in iterator, updating CPU, evsel and the affinity. */
> +void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr);
> +/** Returns true when iterator is at the end of the CPUs and evlist. */
> +bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr);
>
>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
>
> -void evlist__cpu_iter_start(struct evlist *evlist);
> -bool evsel__cpu_iter_skip(struct evsel *ev, int cpu);
> -bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu);
> -
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
>
>  struct evsel *evlist__event2evsel(struct evlist *evlist, union perf_event *event);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 99aa3363def7..7cb7c9c77ab0 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -121,7 +121,6 @@ struct evsel {
>         bool                    errored;
>         struct hashmap          *per_pkg_mask;
>         int                     err;
> -       int                     cpu_iter;
>         struct {
>                 evsel__sb_cb_t  *cb;
>                 void            *data;
> --
> 2.34.1.307.g9b7440fafd-goog
>
