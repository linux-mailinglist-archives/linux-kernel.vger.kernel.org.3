Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8346F634
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhLIVzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:55:31 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:40611 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhLIVza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:55:30 -0500
Received: by mail-lj1-f178.google.com with SMTP id u22so11053998lju.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1TtAFa8taK30XGWEzUdZI7ysiEBQapYQCq5iZUXmFE=;
        b=K/UnRJp4554Akd5P6i+8cvEATjmFLjOIOG9tYWtFutizf2l+rMdIqEOpEciObSYsnv
         4OHhL/P+C57miSkopFnqIXbjKRmt3Rp0/LuqlPX/VjC0u1/s7C6lzpMO+i3vz4xdJIqE
         haUuK2pcdTVLg+MAyw+8B8tkVIx5iDNckNyyYYpRNED5N3N4uTNBn1hiWHzDGOvp5f9T
         OTtKXmknCe4L8RuPnLi9diCqsvdX0TMfbkaECw2YLgeyjOqR6CV5NXAKRugS2bbNp/kW
         dywm3mSehHmreGAqWi+pZXe9+JvGZlgOltQYLBbI6OOSMwjV3vdtlkZmXFSB/6QHPLKd
         y3CA==
X-Gm-Message-State: AOAM5307zMs98v6G1J/lTkcegc602YESKKf7Jl4z4ILD+xD0cq747USd
        yBEKgSwlbknZSeY4e5oKQnUAJc2sHdXP4FP52Aw=
X-Google-Smtp-Source: ABdhPJwHzT8EwcTj/uTqHavwL1y+n8l1T/2tKrf7K/gKsixe4bAUISZlPfDb+rdwX1KyWAJ3MRjcZPvLUiBGaEgtzG4=
X-Received: by 2002:a2e:7305:: with SMTP id o5mr9043889ljc.180.1639086715714;
 Thu, 09 Dec 2021 13:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20211205224843.1503081-1-namhyung@kernel.org> <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <YbHp2MXmP1V5WE4B@hirez.programming.kicks-ass.net>
In-Reply-To: <YbHp2MXmP1V5WE4B@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Dec 2021 13:51:42 -0800
Message-ID: <CAM9d7chMn7Gmc4FYn_ZjMiojUCao90e80Zg5+hNXQ7MTeHrK_A@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 3:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 09, 2021 at 12:26:32PM +0100, Peter Zijlstra wrote:
> > On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:
> >
> > > Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
> > > have a negative enabled time.  In fact, bperf keeps values returned by
> > > bpf_perf_event_read_value() which calls perf_event_read_local(), and
> > > accumulates delta between two calls.  When event->shadow_ctx_time is
> > > not set, it'd return invalid enabled time which is bigger than normal.
> >
> > *that*, how does it happen that shadow_time isn't set? It should be last
> > set when the event switches to INACTIVE, no? At which point the logic in
> > perf_event_read_local() should make @enabled move forward while @running
> > stays put.
> >
> > Let me go rummage around a bit... either I'm missing something obvious
> > or something's smelly.
>
> How's this then?

Still the same :(

Maybe because the event is enabled from the beginning.
Then it might miss set_state/update_time at all.

>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 7b7525e9155f..82baa8bdfc86 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -686,9 +686,7 @@ struct perf_event {
>         /*
>          * timestamp shadows the actual context timing but it can
>          * be safely used in NMI interrupt context. It reflects the
> -        * context time as it was when the event was last scheduled in,
> -        * or when ctx_sched_in failed to schedule the event because we
> -        * run out of PMC.
> +        * context time as it was when the event was last scheduled in.
>          *
>          * ctx_time already accounts for ctx->timestamp. Therefore to
>          * compute ctx_time for a sample, simply add perf_clock().
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 28aaeacdaea1..20637b7f420c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -640,6 +640,9 @@ __perf_update_times(struct perf_event *event, u64 now, u64 *enabled, u64 *runnin
>                 *running += delta;
>  }
>
> +static void perf_set_shadow_time(struct perf_event *event,
> +                                struct perf_event_context *ctx);
> +
>  static void perf_event_update_time(struct perf_event *event)
>  {
>         u64 now = perf_event_time(event);
> @@ -647,6 +650,7 @@ static void perf_event_update_time(struct perf_event *event)
>         __perf_update_times(event, now, &event->total_time_enabled,
>                                         &event->total_time_running);
>         event->tstamp = now;
> +       perf_set_shadow_time(event, event->ctx);

I like this.

>  }
>
>  static void perf_event_update_sibling_time(struct perf_event *leader)
> @@ -2552,8 +2556,6 @@ event_sched_in(struct perf_event *event,
>
>         perf_pmu_disable(event->pmu);
>
> -       perf_set_shadow_time(event, ctx);
> -
>         perf_log_itrace_start(event);
>
>         if (event->pmu->add(event, PERF_EF_START)) {
> @@ -3707,29 +3709,6 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
>         return 0;
>  }
>
> -static inline bool event_update_userpage(struct perf_event *event)
> -{
> -       if (likely(!atomic_read(&event->mmap_count)))
> -               return false;
> -
> -       perf_event_update_time(event);
> -       perf_set_shadow_time(event, event->ctx);
> -       perf_event_update_userpage(event);
> -
> -       return true;
> -}
> -
> -static inline void group_update_userpage(struct perf_event *group_event)
> -{
> -       struct perf_event *event;
> -
> -       if (!event_update_userpage(group_event))
> -               return;
> -
> -       for_each_sibling_event(event, group_event)
> -               event_update_userpage(event);
> -}
> -
>  static int merge_sched_in(struct perf_event *event, void *data)
>  {
>         struct perf_event_context *ctx = event->ctx;
> @@ -3748,15 +3727,14 @@ static int merge_sched_in(struct perf_event *event, void *data)
>         }
>
>         if (event->state == PERF_EVENT_STATE_INACTIVE) {
> -               *can_add_hw = 0;
>                 if (event->attr.pinned) {
>                         perf_cgroup_event_disable(event, ctx);
>                         perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> -               } else {
> -                       ctx->rotate_necessary = 1;
> -                       perf_mux_hrtimer_restart(cpuctx);
> -                       group_update_userpage(event);
>                 }
> +
> +               *can_add_hw = 0;
> +               ctx->rotate_necessary = 1;
> +               perf_mux_hrtimer_restart(cpuctx);

Not sure about this.  We might not want to rotate them
if a pinned event failed...?

Thanks,
Namhyung


>         }
>
>         return 0;
> @@ -6349,7 +6327,6 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>                 ring_buffer_attach(event, rb);
>
>                 perf_event_update_time(event);
> -               perf_set_shadow_time(event, event->ctx);
>                 perf_event_init_userpage(event);
>                 perf_event_update_userpage(event);
>         } else {
