Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4770646FE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhLJKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbhLJKXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:23:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFD0C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 02:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XBBd0xtptZTc5dgMn1nwM2bSO1CKXboRmpk2Uha3hkU=; b=mBSopujjD5rT9+5vfrtf97EXWp
        cZtElgsL7IC7b08vPHD4q6QodE21a66HLv+Z5E996EpwDmrpFOD17r/B4rb71Ty/X+5XCJ3MRMOZU
        brGXZgALSeM07kmd+oXZP8fnJpM2qDlIIYOkMgpkdG+FrKQRYtwHpVyPaPjCOL7tqEM/sqqhPuUWJ
        qJVWVmSjsI60rAKTt1aSdFNrqWr/gePdPbnTIqCBk2N7TZEsOSzaU1d3izPiDGsOFKgHIN2t5hM7L
        7J8vF/WEqZ4zZB+P3rzndCRTRqS4e9pEVvzo97RVZ0pS1CADZAybQZGiOka+LEhDTrGeAUVJl8Uex
        2wfInA4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvd0K-000XuN-KJ; Fri, 10 Dec 2021 10:19:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F26E9984E0B; Fri, 10 Dec 2021 11:19:50 +0100 (CET)
Date:   Fri, 10 Dec 2021 11:19:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Message-ID: <20211210101950.GR16608@worktop.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <YbHp2MXmP1V5WE4B@hirez.programming.kicks-ass.net>
 <CAM9d7chMn7Gmc4FYn_ZjMiojUCao90e80Zg5+hNXQ7MTeHrK_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chMn7Gmc4FYn_ZjMiojUCao90e80Zg5+hNXQ7MTeHrK_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 01:51:42PM -0800, Namhyung Kim wrote:
> On Thu, Dec 9, 2021 at 3:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Dec 09, 2021 at 12:26:32PM +0100, Peter Zijlstra wrote:
> > > On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:
> > >
> > > > Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
> > > > have a negative enabled time.  In fact, bperf keeps values returned by
> > > > bpf_perf_event_read_value() which calls perf_event_read_local(), and
> > > > accumulates delta between two calls.  When event->shadow_ctx_time is
> > > > not set, it'd return invalid enabled time which is bigger than normal.
> > >
> > > *that*, how does it happen that shadow_time isn't set? It should be last
> > > set when the event switches to INACTIVE, no? At which point the logic in
> > > perf_event_read_local() should make @enabled move forward while @running
> > > stays put.
> > >
> > > Let me go rummage around a bit... either I'm missing something obvious
> > > or something's smelly.
> >
> > How's this then?
> 
> Still the same :(

You're doing that bpf-cgroup crud, right? Where exactly do you hook into
to do the counter reads?

> Maybe because the event is enabled from the beginning.
> Then it might miss set_state/update_time at all.

Even then, it's set to INACTIVE and any state change thereafter needs to
go through perf_event_set_state() and update the relevant timestamps.

> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 28aaeacdaea1..20637b7f420c 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -640,6 +640,9 @@ __perf_update_times(struct perf_event *event, u64 now, u64 *enabled, u64 *runnin
> >                 *running += delta;
> >  }
> >
> > +static void perf_set_shadow_time(struct perf_event *event,
> > +                                struct perf_event_context *ctx);
> > +
> >  static void perf_event_update_time(struct perf_event *event)
> >  {
> >         u64 now = perf_event_time(event);
> > @@ -647,6 +650,7 @@ static void perf_event_update_time(struct perf_event *event)
> >         __perf_update_times(event, now, &event->total_time_enabled,
> >                                         &event->total_time_running);
> >         event->tstamp = now;
> > +       perf_set_shadow_time(event, event->ctx);
> 
> I like this.

Right, it keeps the shadow timestamp thingy in sync. Specifically it was
missing an update on event sched_out. Although thinking about it more,
that shouldn't make a difference since the relative displacement of the
clocks doesn't change at that point. All that changes there is that
RUNNING should stop advancing.

So in that regards, this not actually changing anything makes sense.

> > @@ -3748,15 +3727,14 @@ static int merge_sched_in(struct perf_event *event, void *data)
> >         }
> >
> >         if (event->state == PERF_EVENT_STATE_INACTIVE) {
> > -               *can_add_hw = 0;
> >                 if (event->attr.pinned) {
> >                         perf_cgroup_event_disable(event, ctx);
> >                         perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> > -               } else {
> > -                       ctx->rotate_necessary = 1;
> > -                       perf_mux_hrtimer_restart(cpuctx);
> > -                       group_update_userpage(event);
> >                 }
> > +
> > +               *can_add_hw = 0;
> > +               ctx->rotate_necessary = 1;
> > +               perf_mux_hrtimer_restart(cpuctx);
> 
> Not sure about this.  We might not want to rotate them
> if a pinned event failed...?

It's just a straight revert, but you're right, this stuff needs
some improvement.
