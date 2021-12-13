Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89358473666
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbhLMVLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:11:11 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37738 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbhLMVLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:11:11 -0500
Received: by mail-lj1-f179.google.com with SMTP id k2so25545760lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJ/I2vfWddJxomgPfKFNj6rOBQ358qx/LkQRVtQF+yg=;
        b=jIpxyDL/mOThbkT8d5BjxG9W2hFjYmEhZ6PxFqqRyD0be2mALgDXbpEWOIzh2TpVk8
         feFjAD3CFmB0e3ubg1yOVUWgfDuhOf3HIJjIuZK3Nce9elNoN4cOtLOYQvz/Muq5qnbx
         tID849CT2RsDXX6VghfiWFYxk6LWpCek/78IoWDPwtDBIQZnJf91GOY/c67gEnxHE4aU
         0R6Bk/hvIhIH0lzKaCX7LjHlSw8slxJRHXZMp3ICeCGv4ZkHm0Sj47arCUrJEYrGZpNE
         RyjBLp0tR/4lJAv29zWwBL2wU0SRsxou31WCfHylYd9RaUd3/BfaU0lI4ylesCAPnYDZ
         qEPA==
X-Gm-Message-State: AOAM533aOlr6Ksze8zdQgp7sfrZ+KTS81uxMu6TBvtaMTFBRM5nkZJ8V
        AMqpUsyeh1S9DlRd+KCwJhi8k778yqqMiBTrxuk=
X-Google-Smtp-Source: ABdhPJzAQPQTM4j5pMzjBDOa1c3d4grgW7zarJ5JZDZPm0Sw7Mq0iDr0MV7sAE4rpKjZWXN7GGkOQdhdhir/Oz6p0Vg=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr926287ljp.202.1639429869797;
 Mon, 13 Dec 2021 13:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20211213065936.1965081-1-namhyung@kernel.org> <20211213203016.GB16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211213203016.GB16608@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Dec 2021 13:10:58 -0800
Message-ID: <CAM9d7cinG=iSYMS0eHMxVT7=qU0dmM29L9E759FEqZx9_cLx3Q@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Fix cgroup event list management
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
        kernel test robot <lkp@intel.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Dec 13, 2021 at 12:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Dec 12, 2021 at 10:59:36PM -0800, Namhyung Kim wrote:
> > The active cgroup events are managed in the per-cpu cgrp_cpuctx_list.
> > This list is accessed from current cpu and not protected by any locks.
> > But from the commit ef54c1a476ae ("perf: Rework
> > perf_event_exit_event()"), this assumption does not hold true anymore.
> >
> > In the perf_remove_from_context(), it can remove an event from the
> > context without an IPI when the context is not active.  I think it
>
> "I tihnk" just doesn't cut it. That means I have to completely reverse
> engineer your patch and it's assumptions. Which is more work for me :-(

If you are talking about my wording, ok I will use more assertive words
with the facts in the future.  I should say that it doesn't work with
cgroup events which can change the active states during context
switches.

>
> > assumes task event context, but it's possible for cpu event context
> > only with cgroup events can be inactive at the moment - and it might
> > become active soon.
> >
> > If the event is enabled when it's about to be closed, it might call
> > perf_cgroup_event_disable() and list_del() with the cgrp_cpuctx_list
> > on a different cpu.
> >
> > This resulted in a crash due to an invalid list pointer access during
> > the cgroup list traversal on the cpu which the event belongs to.
> >
> > The following program can crash my box easily..
>
> Unless that's already public, you've just given the script kiddos ammo,
> surely we don't need that.

Understood, will take more care in the future.

But this requires root access to create cgroups or the sysctl
perf_event_paranoid of 0 to open cpu/cgroup events which
is restricted in the most distro.  Anyway, I should be careful,
sorry about that.

>
> > Let's use IPI to prevent such crashes.
>
> Let's just not do random things and hope stuff 'works'. Either it is
> correct or it is not.

Right, but in this case, it's back to use IPI by removing the
optimization for cgroup events.  I'll update the description.

>
> > Similarly, I think perf_install_in_context() should use IPI for the
> > cgroup events too.
>
> Let's be sure, ok?

I see.

>
> > Reported-by: kernel test robot <lkp@intel.com>  # for build error
>
> That's complete garbage, please don't do that.

Got it.

>
> > Cc: Marco Elver <elver@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > v2) simply use IPI for cgroup events
> >
> >  kernel/events/core.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 30d94f68c5bd..9460c083acd9 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2388,7 +2388,7 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
> >        * event_function_call() user.
> >        */
> >       raw_spin_lock_irq(&ctx->lock);
> > -     if (!ctx->is_active) {
> > +     if (!ctx->is_active && !is_cgroup_event(event)) {
> >               __perf_remove_from_context(event, __get_cpu_context(ctx),
> >                                          ctx, (void *)flags);
> >               raw_spin_unlock_irq(&ctx->lock);
> > @@ -2857,11 +2857,14 @@ perf_install_in_context(struct perf_event_context *ctx,
> >        * perf_event_attr::disabled events will not run and can be initialized
> >        * without IPI. Except when this is the first event for the context, in
> >        * that case we need the magic of the IPI to set ctx->is_active.
> > +      * Similarly, cgroup events for the context also needs the IPI to
> > +      * manipulate the cgrp_cpuctx_list.
> >        *
> >        * The IOC_ENABLE that is sure to follow the creation of a disabled
> >        * event will issue the IPI and reprogram the hardware.
> >        */
> > -     if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF && ctx->nr_events) {
> > +     if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF &&
> > +         ctx->nr_events && !is_cgroup_event(event)) {
> >               raw_spin_lock_irq(&ctx->lock);
> >               if (ctx->task == TASK_TOMBSTONE) {
> >                       raw_spin_unlock_irq(&ctx->lock);
> >
> > base-commit: 73743c3b092277febbf69b250ce8ebbca0525aa2
>
> What's junk like that doing ?

It was recommended by the kernel test robot.  I think it uses
the info to find where this patch applies to.

Thanks,
Namhyung
