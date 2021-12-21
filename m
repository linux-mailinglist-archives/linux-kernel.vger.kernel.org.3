Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD84947B9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 06:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhLUFy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 00:54:58 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:40455 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhLUFy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 00:54:57 -0500
Received: by mail-lj1-f182.google.com with SMTP id u22so19620014lju.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 21:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfi9UjB57hbDM6Jzg/GUzBNAysGg3/ki3QoOw4uWt+k=;
        b=JswoVgLg6LxS64st1mV4oSFAM2kxjW9DOWxuNliv72gD7HoEwSNBcvR4gSGA1aynQI
         8Pl71gpMQoUs71wJixj6c/CHOGPaz8Q3XE/sJPgfwx8NvstM+Bk4SIUuL3d2wNcsqrw0
         /L0EozjvGTE1aRfNkYI+7HHfurSPAfnkZmDvswOK8IgeRCGDDfkOS/QRZ8nDGsK8rTP8
         nN1JPvFvfZ5bsoHpMKIcElrbgwE7qiMEYg+lAfSQKm39JNZ/aFsI8X/FlB/EQq2the40
         p61CDAAIKwpjAvFEG8P1COVe3oylVnZwbTpOId8ozSHOAvI9EnP4OewyaG/RPuc2N+u2
         c5tg==
X-Gm-Message-State: AOAM532XuCwS+KzCf8spftc2pG/0S70iikPHRdR2TJVwdwF3OTLQMSiw
        MA1xRUVyEWvI94uhw5agMlqi8jr/0r55M8fYm8o=
X-Google-Smtp-Source: ABdhPJwJI6PnOJCOtuShC1ANT/zhz1cuIqYKeQHMGdN1zkfEeoJd7hANCHEKAtNRZw6Qv17hTAWZxMEn8a7hGV06N78=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr1301700ljp.202.1640066095951;
 Mon, 20 Dec 2021 21:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20211205224843.1503081-1-namhyung@kernel.org> <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
 <20211210103341.GS16608@worktop.programming.kicks-ass.net>
 <Yby8Su+fVA1lqVjT@hirez.programming.kicks-ass.net> <YcB06DasOBtU0b00@hirez.programming.kicks-ass.net>
In-Reply-To: <YcB06DasOBtU0b00@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 20 Dec 2021 21:54:44 -0800
Message-ID: <CAM9d7cjndf2BKMZPziwy-tCuzE-TSwpto8Ng0Jy-5C=aS8dePA@mail.gmail.com>
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events too
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 4:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> How's this then?
>
> ---
> Subject: perf: Fix perf_event_read_local() time
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Dec 20 09:59:47 CET 2021
>
> Time readers that cannot take locks (due to NMI etc..) currently make
> use of perf_event::shadow_ctx_time, which, for that event gives:
>
>         time' = now + (time - timestamp)
>
> or, alternatively arranged:
>
>         time' = time + (now - timestamp)
>
> IOW, the progression of time since the last time the shadow_ctx_time
> was updated.
>
> There's problems with this:
>
>  A) the shadow_ctx_time is per-event, even though the ctx_time it
>     reflects is obviously per context. The direct concequence of this
>     is that the context needs to iterate all events all the time to
>     keep the shadow_ctx_time in sync.
>
>  B) even with the prior point, the context itself might not be active
>     meaning its time should not advance to begin with.
>
>  C) shadow_ctx_time isn't consistently updated when ctx_time is
>
> There are 3 users of this stuff, that suffer differently from this:
>
>  - calc_timer_values()
>    - perf_output_read()
>    - perf_event_update_userpage()       /* A */
>
>  - perf_event_read_local()              /* A,B */
>
> In particular, perf_output_read() doesn't suffer at all, because it's
> sample driven and hence only relevant when the event is actually
> running.
>
> This same was supposed to be true for perf_event_update_userpage(),
> after all self-monitoring implies the context is active *HOWEVER*, as
> per commit f79256532682 ("perf/core: fix userpage->time_enabled of
> inactive events") this goes wrong when combined with counter
> overcommit, in that case those events that do not get scheduled when
> the context becomes active (task events typically) miss out on the
> EVENT_TIME update and ENABLED time is inflated (for a little while)
> with the time the context was inactive. Once the event gets rotated
> in, this gets corrected, leading to a non-monotonic timeflow.
>
> perf_event_read_local() made things even worse, it can request time at
> any point, suffering all the problems perf_event_update_userpage()
> does and more. Because while perf_event_update_userpage() is limited
> by the context being active, perf_event_read_local() users have no
> such constraint.
>
> Therefore, completely overhaul things and do away with
> perf_event::shadow_ctx_time. Instead have regular context time updates
> keep track of this offset directly and provide perf_event_time_now()
> to complement perf_event_time().
>
> perf_event_time_now() will, in adition to being context wide, also
> take into account if the context is active. For inactive context, it
> will not advance time.
>
> This latter property means the cgroup perf_cgroup_info context needs
> to grow addition state to track this.
>
> Additionally, since all this is strictly per-cpu, we can use barrier()
> to order context activity vs context time.
>
> Fixes: 7d9285e82db5 ("perf/bpf: Extend the perf_event_read_local() interface, a.k.a. "bpf: perf event change needed for subsequent bpf helpers"")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

It worked well for my test.

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  include/linux/perf_event.h |   15 ---
>  kernel/events/core.c       |  224 +++++++++++++++++++++++++++------------------
>  2 files changed, 138 insertions(+), 101 deletions(-)
>
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -683,18 +683,6 @@ struct perf_event {
>         u64                             total_time_running;
>         u64                             tstamp;
>
> -       /*
> -        * timestamp shadows the actual context timing but it can
> -        * be safely used in NMI interrupt context. It reflects the
> -        * context time as it was when the event was last scheduled in,
> -        * or when ctx_sched_in failed to schedule the event because we
> -        * run out of PMC.
> -        *
> -        * ctx_time already accounts for ctx->timestamp. Therefore to
> -        * compute ctx_time for a sample, simply add perf_clock().
> -        */
> -       u64                             shadow_ctx_time;
> -
>         struct perf_event_attr          attr;
>         u16                             header_size;
>         u16                             id_header_size;
> @@ -841,6 +829,7 @@ struct perf_event_context {
>          */
>         u64                             time;
>         u64                             timestamp;
> +       u64                             timeoffset;
>
>         /*
>          * These fields let us detect when two contexts have both
> @@ -923,6 +912,8 @@ struct bpf_perf_event_data_kern {
>  struct perf_cgroup_info {
>         u64                             time;
>         u64                             timestamp;
> +       u64                             timeoffset;
> +       int                             active;
>  };
>
>  struct perf_cgroup {
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -674,6 +674,23 @@ perf_event_set_state(struct perf_event *
>         WRITE_ONCE(event->state, state);
>  }
>
> +/*
> + * UP store-release, load-acquire
> + */
> +
> +#define __store_release(ptr, val)                                      \
> +do {                                                                   \
> +       barrier();                                                      \
> +       WRITE_ONCE(*(ptr), (val));                                      \
> +} while (0)
> +
> +#define __load_acquire(ptr)                                            \
> +({                                                                     \
> +       __unqual_scalar_typeof(*(ptr)) ___p = READ_ONCE(*(ptr));        \
> +       barrier();                                                      \
> +       ___p;                                                           \
> +})
> +
>  #ifdef CONFIG_CGROUP_PERF
>
>  static inline bool
> @@ -719,34 +736,51 @@ static inline u64 perf_cgroup_event_time
>         return t->time;
>  }
>
> -static inline void __update_cgrp_time(struct perf_cgroup *cgrp)
> +static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
>  {
> -       struct perf_cgroup_info *info;
> -       u64 now;
> -
> -       now = perf_clock();
> +       struct perf_cgroup_info *t;
>
> -       info = this_cpu_ptr(cgrp->info);
> +       t = per_cpu_ptr(event->cgrp->info, event->cpu);
> +       if (!__load_acquire(&t->active))
> +               return t->time;
> +       now += READ_ONCE(t->timeoffset);
> +       return now;
> +}
>
> -       info->time += now - info->timestamp;
> +static inline void __update_cgrp_time(struct perf_cgroup_info *info, u64 now, bool adv)
> +{
> +       if (adv)
> +               info->time += now - info->timestamp;
>         info->timestamp = now;
> +       /*
> +        * see update_context_time()
> +        */
> +       WRITE_ONCE(info->timeoffset, info->time - info->timestamp);
>  }
>
> -static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
> +static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx, bool final)
>  {
>         struct perf_cgroup *cgrp = cpuctx->cgrp;
>         struct cgroup_subsys_state *css;
> +       struct perf_cgroup_info *info;
>
>         if (cgrp) {
> +               u64 now = perf_clock();
> +
>                 for (css = &cgrp->css; css; css = css->parent) {
>                         cgrp = container_of(css, struct perf_cgroup, css);
> -                       __update_cgrp_time(cgrp);
> +                       info = this_cpu_ptr(cgrp->info);
> +
> +                       __update_cgrp_time(info, now, true);
> +                       if (final)
> +                               __store_release(&info->active, 0);
>                 }
>         }
>  }
>
>  static inline void update_cgrp_time_from_event(struct perf_event *event)
>  {
> +       struct perf_cgroup_info *info;
>         struct perf_cgroup *cgrp;
>
>         /*
> @@ -760,8 +794,10 @@ static inline void update_cgrp_time_from
>         /*
>          * Do not update time when cgroup is not active
>          */
> -       if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
> -               __update_cgrp_time(event->cgrp);
> +       if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
> +               info = this_cpu_ptr(event->cgrp->info);
> +               __update_cgrp_time(info, perf_clock(), true);
> +       }
>  }
>
>  static inline void
> @@ -785,7 +821,8 @@ perf_cgroup_set_timestamp(struct task_st
>         for (css = &cgrp->css; css; css = css->parent) {
>                 cgrp = container_of(css, struct perf_cgroup, css);
>                 info = this_cpu_ptr(cgrp->info);
> -               info->timestamp = ctx->timestamp;
> +               __update_cgrp_time(info, ctx->timestamp, false);
> +               __store_release(&info->active, 1);
>         }
>  }
>
> @@ -982,14 +1019,6 @@ static inline int perf_cgroup_connect(in
>  }
>
>  static inline void
> -perf_cgroup_set_shadow_time(struct perf_event *event, u64 now)
> -{
> -       struct perf_cgroup_info *t;
> -       t = per_cpu_ptr(event->cgrp->info, event->cpu);
> -       event->shadow_ctx_time = now - t->timestamp;
> -}
> -
> -static inline void
>  perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ctx)
>  {
>         struct perf_cpu_context *cpuctx;
> @@ -1066,7 +1095,8 @@ static inline void update_cgrp_time_from
>  {
>  }
>
> -static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
> +static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
> +                                               bool final)
>  {
>  }
>
> @@ -1098,12 +1128,12 @@ perf_cgroup_switch(struct task_struct *t
>  {
>  }
>
> -static inline void
> -perf_cgroup_set_shadow_time(struct perf_event *event, u64 now)
> +static inline u64 perf_cgroup_event_time(struct perf_event *event)
>  {
> +       return 0;
>  }
>
> -static inline u64 perf_cgroup_event_time(struct perf_event *event)
> +static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
>  {
>         return 0;
>  }
> @@ -1525,22 +1555,59 @@ static void perf_unpin_context(struct pe
>  /*
>   * Update the record of the current time in a context.
>   */
> -static void update_context_time(struct perf_event_context *ctx)
> +static void __update_context_time(struct perf_event_context *ctx, bool adv)
>  {
>         u64 now = perf_clock();
>
> -       ctx->time += now - ctx->timestamp;
> +       if (adv)
> +               ctx->time += now - ctx->timestamp;
>         ctx->timestamp = now;
> +
> +       /*
> +        * The above: time' = time + (now - timestamp), can be re-arranged
> +        * into: time` = now + (time - timestamp), which gives a single value
> +        * offset to compute future time without locks on.
> +        *
> +        * See perf_event_time_now(), which can be used from NMI context where
> +        * it's (obviously) not possible to acquire ctx->lock in order to read
> +        * both the above values in a consistent manner.
> +        */
> +       WRITE_ONCE(ctx->timeoffset, ctx->time - ctx->timestamp);
> +}
> +
> +static void update_context_time(struct perf_event_context *ctx)
> +{
> +       __update_context_time(ctx, true);
>  }
>
>  static u64 perf_event_time(struct perf_event *event)
>  {
>         struct perf_event_context *ctx = event->ctx;
>
> +       if (unlikely(!ctx))
> +               return 0;
> +
>         if (is_cgroup_event(event))
>                 return perf_cgroup_event_time(event);
>
> -       return ctx ? ctx->time : 0;
> +       return ctx->time;
> +}
> +
> +static u64 perf_event_time_now(struct perf_event *event, u64 now)
> +{
> +       struct perf_event_context *ctx = event->ctx;
> +
> +       if (unlikely(!ctx))
> +               return 0;
> +
> +       if (is_cgroup_event(event))
> +               return perf_cgroup_event_time_now(event, now);
> +
> +       if (!(__load_acquire(&ctx->is_active) & EVENT_TIME))
> +               return ctx->time;
> +
> +       now += READ_ONCE(ctx->timeoffset);
> +       return now;
>  }
>
>  static enum event_type_t get_event_type(struct perf_event *event)
> @@ -2346,7 +2413,7 @@ __perf_remove_from_context(struct perf_e
>
>         if (ctx->is_active & EVENT_TIME) {
>                 update_context_time(ctx);
> -               update_cgrp_time_from_cpuctx(cpuctx);
> +               update_cgrp_time_from_cpuctx(cpuctx, false);
>         }
>
>         event_sched_out(event, cpuctx, ctx);
> @@ -2357,6 +2424,9 @@ __perf_remove_from_context(struct perf_e
>         list_del_event(event, ctx);
>
>         if (!ctx->nr_events && ctx->is_active) {
> +               if (ctx == &cpuctx->ctx)
> +                       update_cgrp_time_from_cpuctx(cpuctx, true);
> +
>                 ctx->is_active = 0;
>                 ctx->rotate_necessary = 0;
>                 if (ctx->task) {
> @@ -2478,40 +2548,6 @@ void perf_event_disable_inatomic(struct
>         irq_work_queue(&event->pending);
>  }
>
> -static void perf_set_shadow_time(struct perf_event *event,
> -                                struct perf_event_context *ctx)
> -{
> -       /*
> -        * use the correct time source for the time snapshot
> -        *
> -        * We could get by without this by leveraging the
> -        * fact that to get to this function, the caller
> -        * has most likely already called update_context_time()
> -        * and update_cgrp_time_xx() and thus both timestamp
> -        * are identical (or very close). Given that tstamp is,
> -        * already adjusted for cgroup, we could say that:
> -        *    tstamp - ctx->timestamp
> -        * is equivalent to
> -        *    tstamp - cgrp->timestamp.
> -        *
> -        * Then, in perf_output_read(), the calculation would
> -        * work with no changes because:
> -        * - event is guaranteed scheduled in
> -        * - no scheduled out in between
> -        * - thus the timestamp would be the same
> -        *
> -        * But this is a bit hairy.
> -        *
> -        * So instead, we have an explicit cgroup call to remain
> -        * within the time source all along. We believe it
> -        * is cleaner and simpler to understand.
> -        */
> -       if (is_cgroup_event(event))
> -               perf_cgroup_set_shadow_time(event, event->tstamp);
> -       else
> -               event->shadow_ctx_time = event->tstamp - ctx->timestamp;
> -}
> -
>  #define MAX_INTERRUPTS (~0ULL)
>
>  static void perf_log_throttle(struct perf_event *event, int enable);
> @@ -2552,8 +2588,6 @@ event_sched_in(struct perf_event *event,
>
>         perf_pmu_disable(event->pmu);
>
> -       perf_set_shadow_time(event, ctx);
> -
>         perf_log_itrace_start(event);
>
>         if (event->pmu->add(event, PERF_EF_START)) {
> @@ -3247,16 +3281,6 @@ static void ctx_sched_out(struct perf_ev
>                 return;
>         }
>
> -       ctx->is_active &= ~event_type;
> -       if (!(ctx->is_active & EVENT_ALL))
> -               ctx->is_active = 0;
> -
> -       if (ctx->task) {
> -               WARN_ON_ONCE(cpuctx->task_ctx != ctx);
> -               if (!ctx->is_active)
> -                       cpuctx->task_ctx = NULL;
> -       }
> -
>         /*
>          * Always update time if it was set; not only when it changes.
>          * Otherwise we can 'forget' to update time for any but the last
> @@ -3270,7 +3294,22 @@ static void ctx_sched_out(struct perf_ev
>         if (is_active & EVENT_TIME) {
>                 /* update (and stop) ctx time */
>                 update_context_time(ctx);
> -               update_cgrp_time_from_cpuctx(cpuctx);
> +               update_cgrp_time_from_cpuctx(cpuctx, ctx == &cpuctx->ctx);
> +               /*
> +                * CPU-release for the below ->is_active store,
> +                * see __load_acquire() in perf_event_time_now()
> +                */
> +               barrier();
> +       }
> +
> +       ctx->is_active &= ~event_type;
> +       if (!(ctx->is_active & EVENT_ALL))
> +               ctx->is_active = 0;
> +
> +       if (ctx->task) {
> +               WARN_ON_ONCE(cpuctx->task_ctx != ctx);
> +               if (!ctx->is_active)
> +                       cpuctx->task_ctx = NULL;
>         }
>
>         is_active ^= ctx->is_active; /* changed bits */
> @@ -3707,13 +3746,19 @@ static noinline int visit_groups_merge(s
>         return 0;
>  }
>
> +/*
> + * Because the userpage is strictly per-event (there is no concept of context,
> + * so there cannot be a context indirection), every userpage must be updated
> + * when context time starts :-(
> + *
> + * IOW, we must not miss EVENT_TIME edges.
> + */
>  static inline bool event_update_userpage(struct perf_event *event)
>  {
>         if (likely(!atomic_read(&event->mmap_count)))
>                 return false;
>
>         perf_event_update_time(event);
> -       perf_set_shadow_time(event, event->ctx);
>         perf_event_update_userpage(event);
>
>         return true;
> @@ -3797,13 +3842,23 @@ ctx_sched_in(struct perf_event_context *
>              struct task_struct *task)
>  {
>         int is_active = ctx->is_active;
> -       u64 now;
>
>         lockdep_assert_held(&ctx->lock);
>
>         if (likely(!ctx->nr_events))
>                 return;
>
> +       if (is_active ^ EVENT_TIME) {
> +               /* start ctx time */
> +               __update_context_time(ctx, false);
> +               perf_cgroup_set_timestamp(task, ctx);
> +               /*
> +                * CPU-release for the below ->is_active store,
> +                * see __load_acquire() in perf_event_time_now()
> +                */
> +               barrier();
> +       }
> +
>         ctx->is_active |= (event_type | EVENT_TIME);
>         if (ctx->task) {
>                 if (!is_active)
> @@ -3814,13 +3869,6 @@ ctx_sched_in(struct perf_event_context *
>
>         is_active ^= ctx->is_active; /* changed bits */
>
> -       if (is_active & EVENT_TIME) {
> -               /* start ctx time */
> -               now = perf_clock();
> -               ctx->timestamp = now;
> -               perf_cgroup_set_timestamp(task, ctx);
> -       }
> -
>         /*
>          * First go through the list and put on any pinned groups
>          * in order to give them the best chance of going on.
> @@ -4473,10 +4521,9 @@ int perf_event_read_local(struct perf_ev
>
>         *value = local64_read(&event->count);
>         if (enabled || running) {
> -               u64 now = event->shadow_ctx_time + perf_clock();
> -               u64 __enabled, __running;
> +               u64 __enabled, __running, __now;;
>
> -               __perf_update_times(event, now, &__enabled, &__running);
> +               calc_timer_values(event, &__now, &__enabled, &__running);
>                 if (enabled)
>                         *enabled = __enabled;
>                 if (running)
> @@ -5806,7 +5853,7 @@ static void calc_timer_values(struct per
>         u64 ctx_time;
>
>         *now = perf_clock();
> -       ctx_time = event->shadow_ctx_time + *now;
> +       ctx_time = perf_event_time_now(event, *now);
>         __perf_update_times(event, ctx_time, enabled, running);
>  }
>
> @@ -6349,7 +6396,6 @@ static int perf_mmap(struct file *file,
>                 ring_buffer_attach(event, rb);
>
>                 perf_event_update_time(event);
> -               perf_set_shadow_time(event, event->ctx);
>                 perf_event_init_userpage(event);
>                 perf_event_update_userpage(event);
>         } else {
