Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C075F470F61
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 01:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbhLKAYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 19:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240714AbhLKAYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:24:40 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E71C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:21:04 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i6so9990116ila.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQVK/fW2IHx2/eKTcMFa0xhiXhA/tPMPik28eRkL13o=;
        b=QaJzGZHASS1oX67CObMN87QSxGDyHUc5LDDXay3wq8QbJDc6kWWggxB03qbRamgMNz
         Qu+v+EEiG3B9eC6hoarkqGUIXYLbwwJRv47i6wzWZmabNpsrRvw6erGDm8mF3vBMvRLO
         1vZYkncNG5g3tF/xKw0RIV9AaMTbODDhqHz6rnKyCWSGdpf0WPrPXD/QDg9Y0OYlijHS
         3tm0fnr1FwoQDcTzUfq34M2vbbdr9msvvVxKz4y6+8NxkZrFDAV+1lDzRORVY2YsovDe
         uTWw8C1nzWFcJk9epDv5+2bHNQYKLmZgsEzN6z7Jrr6yyCqFCWNuG/vtW8hEUY7eml8H
         N11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQVK/fW2IHx2/eKTcMFa0xhiXhA/tPMPik28eRkL13o=;
        b=A2zBDm/LYKweMSSj0FFqiawUBGtn4Ikbg2s2KnhiKAjkffx87aoDM5iTZXSwsfW5ip
         w7aV0FQUGHRL/S+WAK9tvFwFaUtOixzh6tee6PYoXsfTTw9bdYQT0DNg1cK5kTdHlsZU
         D9Dq1I2MbGHS1AOF7fqNuY/bxpD3RMabC+roscVG39KfavxaauC26c+0rK/3ehY2zWpH
         UK+weOg6LimVy50TN+Q3t05GgoC7UMan0KccxfKyrJGwS8dPKIEXxoB4UgFkMhUcdf9v
         6svKTTqK9ZaaQi5CusSYgDRtwfh2g8CvGpskaP2k6nwsV0qY0piYt7dFoAIkH3tYtwFR
         AZWA==
X-Gm-Message-State: AOAM533fKAlIOTt9Isi/VgaVWtwI4qn98eTPCt4CS1P1KxzGr0j3bVOn
        qcMXt0dkUhCzKHOApqulp5pnSXkEwYiqScm3UZ4XIw==
X-Google-Smtp-Source: ABdhPJyj9vh7tqRpnD47wWgXa/m77w147OhnzNh/Dmm7irKvVlej9YpLK9/wFIRcKbQ/uMBTzF5A1OTWDEbEZ1TwL4Q=
X-Received: by 2002:a05:6e02:931:: with SMTP id o17mr21339890ilt.174.1639182063829;
 Fri, 10 Dec 2021 16:21:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1629490974.git.rickyman7@gmail.com> <5bfe13dd0985611285bb697987816ddc36e93e76.1629490974.git.rickyman7@gmail.com>
In-Reply-To: <5bfe13dd0985611285bb697987816ddc36e93e76.1629490974.git.rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 10 Dec 2021 16:20:52 -0800
Message-ID: <CAP-5=fV4aFHf1K+wuqJ19W1GPsj4fnO-EznLf=wL1z7nKf_tqg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 03/37] perf evlist: replace evsel__cpu_iter*
 functions with evsel__find_cpu
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 2:19 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> Commit a8cbe40fe9f4ba49 ("perf evsel: Add iterator to iterate over events
> ordered by CPU") introduced an iterator for evsel.core.cpus inside evsel
> which is used to iterate over evlist one CPU at a time.
>
> However, this solution is hacky since it involves a mutable state in the
> evsel which is supposed to be unmodified during iteration.
> Sice checking that a CPU is within the evsel can be done quickly in
> O(logn) time, this patch replaces the aforementioned iterator with a
> simple check.

I like this change. It ties in with the CPU vs index refactoring I'm
doing and expanding upon in:
https://lore.kernel.org/lkml/20211208024607.1784932-1-irogers@google.com/
The O(log(n)) look up of the CPU from the CPU map I think can be
improved, but it is good enough for now. We can improve upon it by
recognizing that the CPU we're looking for in the CPU map is 'cpu /
num_cpus' into the map - ie. don't binary search from the middle, but
start from somewhere near where the CPU will be. Something like
interpolation search [1] would do this in O(log(log(n)) time, but
because CPU maps are so regular in layout I'd expect it would be O(1)
for us.

That said, I think the right thing to do here is to introduce a new
struct which would behave like an STL style iterator. STL style
iterators are returned by begin and end functions. They implement a
next() routine as operator ++. Termination of the loop happens when
the iterator equals the end value. The current evlist affinity
iteration needs two loops. The outer loop is iterating over CPUs and
the caller needs to set affinity to the CPU. An inner loop iterates
over the evlist again, skipping until an appropriate evsel is
encountered for the outer loop's CPU. I think it would be better if we
had a single loop, and this loop is going to maintain two pieces of
state in the iterator, the current CPU and evsel. The loop start, next
and end will change the CPU affinity. The next routine will iterate
over every evsel for a CPU and then advance to the next CPU and so on
until all CPUs and the evsels are done. For something like:
$ perf stat -a -e cycles,power/energy-pkg/ -I 1000
The cpumasks are going to be all CPUs for cycles, and on my machine 0
and 18 for energy-pkg. So the iterator will be on CPU 0 with an evsel
for cycles, then for energy-pkg, next for CPU 1 it will have an evsel
for cycles, and so on until CPU 18. For CPU 18 it will be like CPU.0
and have the evsel for cycles and energy-pkg. For CPU 19 it is just
cycles again until you get to CPU 35.

In the API it'd be something like:

struct evlist_cpu_iterator {
  int cpu;
  struct evsel *evsel;
  struct evlist *container;
  struct affinity saved_affinity;
};

struct evlist_cpu_iterator evlist__cpu_iter_start(struct evlist *evlist);
void evlist_cpu_iterator__next(struct evlist_cpu_iterator *itr);
bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *itr);

The advantage of this API is that we know the CPU and evsel without a
lookup (as with the current code), the affinity is hidden in the
abstraction and we get rid of the global iterator state from evsel (as
with this patch) that makes parallelization impossible.

I'm working to add something like this into the cpumap refactoring
effort. That isn't looking to do parallelization but merely to get
correctness, as at the moment CPUs and CPU map indices are often
confused leading to crashes or incorrect behavior. I'm aware that this
will mean rebasing this patch series, but I think that will be easier
as the confusion over CPU and index will be ironed out in my changes.

Thanks,
Ian

[1] https://en.wikipedia.org/wiki/Interpolation_search


> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-stat.c | 24 +++++++++--------
>  tools/perf/util/evlist.c  | 54 +++++++++++----------------------------
>  tools/perf/util/evlist.h  |  5 +---
>  tools/perf/util/evsel.h   |  1 -
>  4 files changed, 30 insertions(+), 54 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 84de61795e67bbb9..62dcc001c8f0a78b 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -407,7 +407,7 @@ static int read_affinity_counters(struct timespec *rs)
>  {
>         struct evsel *counter;
>         struct affinity affinity;
> -       int i, ncpus, cpu;
> +       int i, ncpus, cpu, cpu_idx;
>
>         if (all_counters_use_bpf)
>                 return 0;
> @@ -424,13 +424,14 @@ static int read_affinity_counters(struct timespec *rs)
>                 affinity__set(&affinity, cpu);
>
>                 evlist__for_each_entry(evsel_list, counter) {
> -                       if (evsel__cpu_iter_skip(counter, cpu))
> +                       cpu_idx = evsel__find_cpu(counter, cpu);
> +                       if (cpu_idx < 0)
>                                 continue;
>                         if (evsel__is_bpf(counter))
>                                 continue;
>                         if (!counter->err) {
>                                 counter->err = read_counter_cpu(counter, rs,
> -                                                               counter->cpu_iter - 1);
> +                                                               cpu_idx);
>                         }
>                 }
>         }
> @@ -789,7 +790,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>         const bool forks = (argc > 0);
>         bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
>         struct affinity affinity;
> -       int i, cpu, err;
> +       int i, cpu, cpu_idx, err;
>         bool second_pass = false;
>
>         if (forks) {
> @@ -823,7 +824,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>                 affinity__set(&affinity, cpu);
>
>                 evlist__for_each_entry(evsel_list, counter) {
> -                       if (evsel__cpu_iter_skip(counter, cpu))
> +                       cpu_idx = evsel__find_cpu(counter, cpu);
> +                       if (cpu_idx < 0)
>                                 continue;
>                         if (counter->reset_group || counter->errored)
>                                 continue;
> @@ -831,7 +833,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>                                 continue;
>  try_again:
>                         if (create_perf_stat_counter(counter, &stat_config, &target,
> -                                                    counter->cpu_iter - 1) < 0) {
> +                                                    cpu_idx) < 0) {
>
>                                 /*
>                                  * Weak group failed. We cannot just undo this here
> @@ -877,22 +879,24 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>                         evlist__for_each_entry(evsel_list, counter) {
>                                 if (!counter->reset_group && !counter->errored)
>                                         continue;
> -                               if (evsel__cpu_iter_skip_no_inc(counter, cpu))
> +                               cpu_idx = evsel__find_cpu(counter, cpu);
> +                               if (cpu_idx < 0)
>                                         continue;
> -                               perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
> +                               perf_evsel__close_cpu(&counter->core, cpu_idx);
>                         }
>                         /* Now reopen weak */
>                         evlist__for_each_entry(evsel_list, counter) {
>                                 if (!counter->reset_group && !counter->errored)
>                                         continue;
> -                               if (evsel__cpu_iter_skip(counter, cpu))
> +                               cpu_idx = evsel__find_cpu(counter, cpu);
> +                               if (cpu_idx < 0)
>                                         continue;
>                                 if (!counter->reset_group)
>                                         continue;
>  try_again_reset:
>                                 pr_debug2("reopening weak %s\n", evsel__name(counter));
>                                 if (create_perf_stat_counter(counter, &stat_config, &target,
> -                                                            counter->cpu_iter - 1) < 0) {
> +                                                            cpu_idx) < 0) {
>
>                                         switch (stat_handle_error(counter)) {
>                                         case COUNTER_FATAL:
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 47581a237c7a7848..3d55d9a53b9f4875 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -341,36 +341,9 @@ static int evlist__nr_threads(struct evlist *evlist, struct evsel *evsel)
>                 return perf_thread_map__nr(evlist->core.threads);
>  }
>
> -void evlist__cpu_iter_start(struct evlist *evlist)
> +int evsel__find_cpu(struct evsel *ev, int cpu)
>  {
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
> -
> -bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu)
> -{
> -       if (ev->cpu_iter >= ev->core.cpus->nr)
> -               return true;
> -       if (cpu >= 0 && ev->core.cpus->map[ev->cpu_iter] != cpu)
> -               return true;
> -       return false;
> -}
> -
> -bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
> -{
> -       if (!evsel__cpu_iter_skip_no_inc(ev, cpu)) {
> -               ev->cpu_iter++;
> -               return false;
> -       }
> -       return true;
> +       return perf_cpu_map__idx(ev->core.cpus, cpu);
>  }
>
>  static int evsel__strcmp(struct evsel *pos, char *evsel_name)
> @@ -400,7 +373,7 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>  {
>         struct evsel *pos;
>         struct affinity affinity;
> -       int cpu, i, imm = 0;
> +       int cpu, i, imm = 0, cpu_idx;
>         bool has_imm = false;
>
>         if (affinity__setup(&affinity) < 0)
> @@ -414,7 +387,8 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>                         evlist__for_each_entry(evlist, pos) {
>                                 if (evsel__strcmp(pos, evsel_name))
>                                         continue;
> -                               if (evsel__cpu_iter_skip(pos, cpu))
> +                               cpu_idx = evsel__find_cpu(pos, cpu);
> +                               if (cpu_idx < 0)
>                                         continue;
>                                 if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
>                                         continue;
> @@ -422,7 +396,7 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>                                         has_imm = true;
>                                 if (pos->immediate != imm)
>                                         continue;
> -                               evsel__disable_cpu(pos, pos->cpu_iter - 1);
> +                               evsel__disable_cpu(pos, cpu_idx);
>                         }
>                 }
>                 if (!has_imm)
> @@ -462,7 +436,7 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
>  {
>         struct evsel *pos;
>         struct affinity affinity;
> -       int cpu, i;
> +       int cpu, i, cpu_idx;
>
>         if (affinity__setup(&affinity) < 0)
>                 return;
> @@ -473,11 +447,12 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
>                 evlist__for_each_entry(evlist, pos) {
>                         if (evsel__strcmp(pos, evsel_name))
>                                 continue;
> -                       if (evsel__cpu_iter_skip(pos, cpu))
> +                       cpu_idx = evsel__find_cpu(pos, cpu);
> +                       if (cpu_idx < 0)
>                                 continue;
>                         if (!evsel__is_group_leader(pos) || !pos->core.fd)
>                                 continue;
> -                       evsel__enable_cpu(pos, pos->cpu_iter - 1);
> +                       evsel__enable_cpu(pos, cpu_idx);
>                 }
>         }
>         affinity__cleanup(&affinity);
> @@ -1264,7 +1239,7 @@ void evlist__close(struct evlist *evlist)
>  {
>         struct evsel *evsel;
>         struct affinity affinity;
> -       int cpu, i;
> +       int cpu, i, cpu_idx;
>
>         /*
>          * With perf record core.cpus is usually NULL.
> @@ -1282,9 +1257,10 @@ void evlist__close(struct evlist *evlist)
>                 affinity__set(&affinity, cpu);
>
>                 evlist__for_each_entry_reverse(evlist, evsel) {
> -                       if (evsel__cpu_iter_skip(evsel, cpu))
> -                           continue;
> -                       perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
> +                       cpu_idx = evsel__find_cpu(evsel, cpu);
> +                       if (cpu_idx < 0)
> +                               continue;
> +                       perf_evsel__close_cpu(&evsel->core, cpu_idx);
>                 }
>         }
>         affinity__cleanup(&affinity);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 5c22383489ae4905..fde893170c7ba6d2 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -310,15 +310,12 @@ void evlist__to_front(struct evlist *evlist, struct evsel *move_evsel);
>         __evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
>
>  #define evlist__for_each_cpu(evlist, index, cpu)       \
> -       evlist__cpu_iter_start(evlist);                 \
>         perf_cpu_map__for_each_cpu (cpu, index, (evlist)->core.all_cpus)
>
>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
>
> -void evlist__cpu_iter_start(struct evlist *evlist);
> -bool evsel__cpu_iter_skip(struct evsel *ev, int cpu);
> -bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu);
> +int evsel__find_cpu(struct evsel *ev, int cpu);
>
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
>
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 80383096d51c5f00..eabccce406886320 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -119,7 +119,6 @@ struct evsel {
>         bool                    errored;
>         struct hashmap          *per_pkg_mask;
>         int                     err;
> -       int                     cpu_iter;
>         struct {
>                 evsel__sb_cb_t  *cb;
>                 void            *data;
> --
> 2.31.1
>
