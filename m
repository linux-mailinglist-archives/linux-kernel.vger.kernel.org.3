Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF20470E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345016AbhLJXXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:23:46 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:37635 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbhLJXXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:23:43 -0500
Received: by mail-lf1-f49.google.com with SMTP id c32so20761429lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9d3hE4yr4pfg3m6CMn9gJl0jmuaMwv1gKC7I/q9Crgw=;
        b=hIRk910NUOt5OhGPBlB2kB3UXvjg9N34f1/Xkk88lpOFIc6pBeBHsQrkuXFGjlkHgZ
         /1W/wC5bAJBmETu+/mB90CZ/ctv369YvCo910RPUcTfOFO6oED0Nmi6Myx4snX40Jsvf
         /WthkaU3ZGtLZK0J1UhZuO5pz0RdDGdXhbdHhrkSyMAifFJPRyCEiOD1CcsliWFZPqzS
         W1e5RLlD9+WCGUss95E94+lutla6iyVd9bYoKcEVoTmrxmMuZiglDuNq/xpNko1Tafsh
         GPAWPdwIDUcbtpfyCSN5N+bstvbUO9QoliCZgtnIjOmZzNgKfQXb43KRJT8kVuWI4azP
         DJTg==
X-Gm-Message-State: AOAM533glXTOo0543Ai0J11p/DQvQUnpZ0x7AVTZTBOEpBwZjUr3Rqu2
        8PTDtvnHyMd6Jnl9Px2cmyvOWCNmXRDvqaOFCbV8yOG8
X-Google-Smtp-Source: ABdhPJxdiaZW3XY4qh1HbipCCTp9QF8ns20EKKmgDSIxP8htZetSXbBw3fA6ekpwW+mM7IVfTKx5uzyKJGHABGFHAFc=
X-Received: by 2002:a05:6512:b8c:: with SMTP id b12mr14854609lfv.99.1639178405977;
 Fri, 10 Dec 2021 15:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20211205224843.1503081-1-namhyung@kernel.org> <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com> <20211210103341.GS16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211210103341.GS16608@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Dec 2021 15:19:53 -0800
Message-ID: <CAM9d7cg6Dmojccw1kCxHoK9Kt_k3+4ojWaE1qq+NWmkCNjuFhw@mail.gmail.com>
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

On Fri, Dec 10, 2021 at 2:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 09, 2021 at 01:35:11PM -0800, Namhyung Kim wrote:
> > On Thu, Dec 9, 2021 at 3:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:
> > >
> > > > Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
> > > > have a negative enabled time.  In fact, bperf keeps values returned by
> > > > bpf_perf_event_read_value() which calls perf_event_read_local(), and
> > > > accumulates delta between two calls.  When event->shadow_ctx_time is
> > > > not set, it'd return invalid enabled time which is bigger than normal.
> > >
> > > *that*, how does it happen that shadow_time isn't set? It should be last
> > > set when the event switches to INACTIVE, no?
> >
> > As you can see, perf_event_set_state() doesn't set the shadow time.
> > It's called from event_sched_in() which might result in ACTIVE or
> > INACTIVE.  But the problem is that there's a case that event_sched_in
> > was not called at all - when group_can_go_on() returns false.
> >
> > > At which point the logic in
> > > perf_event_read_local() should make @enabled move forward while @running
> > > stays put.
> >
> > It's not about updating event->total_time_enabled, it only
> > afftects the returned value of @enabled.
> >
> > I'd say the time calculation is broken so it'd break @running
> > as well.  But this case can only happen on INACTIVE -
> > otherwise it'd call event_sched_in() and update the shadow
> > time properly, so no issue there.  And then we can see
> > the broken value of enabled time only.
>
> I'm thinking this is a cgroup specific thing. Normally the shadow_time
> thing is simply a relative displacement between event-time and the
> global clock. That displacement never changes, except when you do
> IOC_DISABLE/IOC_ENABLE.

I think it changes when the events are scheduled in and out.
The global clock (ctx->timestamp) is constantly changing
when any event in the context is scheduled while event-
time might not change if the event is not scheduled, no?

Anyway, as I told you this is not a cgroup event.
The point of the BPF work was not to use cgroup events
and my example in the commit message was not about
cgroups at all.

The cgroup event has its own set of problems.. sigh.
I'll post one that I hit recently.

>
> However, for cgroup things are different, since the cgroup events aren't
> unconditionally runnable, that is, the enabled time should only count
> when the cgroup is active, right?

Yeah, that's my understanding.

>
> So perhaps perf_event_read_local() should use a cgroup clock instead of
> perf_clock() for cgroup events.
>
> Let me think about that some more...

Thanks,
Namhyung
