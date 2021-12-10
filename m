Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B27470998
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbhLJTDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:03:37 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:42866 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbhLJTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:03:37 -0500
Received: by mail-lf1-f42.google.com with SMTP id t26so19722978lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXqflbyxp07n+LvBpYF3boLC2Cb8iRBI32Vthg/usLU=;
        b=mv+Yhs3vLopclb8ZIbdT0sFFUTxyHdvr4dnoYnTx+jtzBMmMj5xed1KgLqMOmkfqfH
         z1MTz6jC3x6TSKgZ7C0BUC6Pg+j+qGODRF/C28V0MbSRvsFdsBSlO7AjtWY1QsHRKRSr
         rYbHRogALnPSz3xs4PczZ5GuqRmst4SwbwLWIo0Pefs/pDeElm6kUpbn0aQMUL1H9dw9
         HqOfK9L18MSjIfMpXGFOonQsmOqkouuiQGt+XJqzNj70zCWHek09RJ4Rmk/vrENTXc2j
         PguDzY7F4vVEYs5HoQMDA344mlHFNWH36tOab2XBaff7UR8bHQ31H8Zmtmi52f1GVBWs
         x8UQ==
X-Gm-Message-State: AOAM531ugA097zhfrNBZMTpaaBOM7EdpMx/XP26nJU+7SVMgS61WnWXQ
        JvDFMK6EV0Hjz0vOgwgbZSvVeaQMYrQVtzib3JA=
X-Google-Smtp-Source: ABdhPJxQKHVG3TAI61WrDyj5XjtbczdaRq8+VoiLm87XqlncJrypNvcb8ocLAtKxngvEEqktv4Yev78gGBq4EPnPoO0=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr14534407lfv.481.1639162800591;
 Fri, 10 Dec 2021 11:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20211205224843.1503081-1-namhyung@kernel.org> <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <YbHp2MXmP1V5WE4B@hirez.programming.kicks-ass.net> <CAM9d7chMn7Gmc4FYn_ZjMiojUCao90e80Zg5+hNXQ7MTeHrK_A@mail.gmail.com>
 <20211210101950.GR16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211210101950.GR16608@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Dec 2021 10:59:49 -0800
Message-ID: <CAM9d7cgugnvrv5CJPe_EP_M8pp8h+GsCCW3-RDmyrd+JDGYJrQ@mail.gmail.com>
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

On Fri, Dec 10, 2021 at 2:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 09, 2021 at 01:51:42PM -0800, Namhyung Kim wrote:
> > On Thu, Dec 9, 2021 at 3:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Dec 09, 2021 at 12:26:32PM +0100, Peter Zijlstra wrote:
> > > > On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:
> > > >
> > > > > Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
> > > > > have a negative enabled time.  In fact, bperf keeps values returned by
> > > > > bpf_perf_event_read_value() which calls perf_event_read_local(), and
> > > > > accumulates delta between two calls.  When event->shadow_ctx_time is
> > > > > not set, it'd return invalid enabled time which is bigger than normal.
> > > >
> > > > *that*, how does it happen that shadow_time isn't set? It should be last
> > > > set when the event switches to INACTIVE, no? At which point the logic in
> > > > perf_event_read_local() should make @enabled move forward while @running
> > > > stays put.
> > > >
> > > > Let me go rummage around a bit... either I'm missing something obvious
> > > > or something's smelly.
> > >
> > > How's this then?
> >
> > Still the same :(
>
> You're doing that bpf-cgroup crud, right? Where exactly do you hook into
> to do the counter reads?

That's true but it doesn't use cgroup events actually.  They are plain cpu
events and BPF is called from a separate 'cgroup-switches' event to
read out the counters.

>
> > Maybe because the event is enabled from the beginning.
> > Then it might miss set_state/update_time at all.
>
> Even then, it's set to INACTIVE and any state change thereafter needs to
> go through perf_event_set_state() and update the relevant timestamps.

Right, but the problem happens when you read the event *before*
any state change.

Thanks,
Namhyung
