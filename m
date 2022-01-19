Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A044939FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354364AbiASL7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:59:52 -0500
Received: from foss.arm.com ([217.140.110.172]:54886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240846AbiASL7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:59:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60EB5ED1;
        Wed, 19 Jan 2022 03:59:51 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C741F3F73D;
        Wed, 19 Jan 2022 03:59:49 -0800 (PST)
Date:   Wed, 19 Jan 2022 11:59:44 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com, Morten.Rasmussen@arm.com,
        Chris.Redpath@arm.com, qperret@google.com, Lukasz.Luba@arm.com
Subject: Re: [PATCH v2 2/7] sched/fair: Decay task PELT values during
 migration
Message-ID: <Yef8kTnlP5h4I7/1@FVFF7649Q05P>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
 <20220112161230.836326-3-vincent.donnefort@arm.com>
 <CAKfTPtC2wCw4U9w=saW0dGYHfOKo42nBKU7oHcEM7KeDj7MzWA@mail.gmail.com>
 <Yeac5Y5Fzu/jaUf0@FVFF7649Q05P>
 <CAKfTPtAdTTP+qGruYy8gi6rfhS0W1gAdjgeLCtrLZHxyCEHo9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAdTTP+qGruYy8gi6rfhS0W1gAdjgeLCtrLZHxyCEHo9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > >
> > > This has several shortfalls:
> > > - have a look at cfs_rq_clock_pelt() and rq_clock_pelt(). What you
> > > name clock_pelt in your commit message and is used to update PELT and
> > > saved in se->avg.last_update_time is : rq->clock_pelt -
> > > rq->lost_idle_time - cfs_rq->throttled_clock_task_time
> >
> > That's why, the PELT "lag" is added onto se->avg.last_update_time. (see the last
> > paragraph of the commit message) The estimator is just a time delta, that is
> > added on top of the entity's last_update_time. I don't see any problem with the
> > lost_idle_time here.
> 
> lost_idle_time is updated before entering idle and after your
> clock_pelt_lag has been updated. This means that the delta that you
> are computing can be wrong
> 
> I haven't look in details but similar problem probably happens for
> throttled_clock_task_time
> 
> >
> > > - you are doing this whatever the state of the cpu : idle or not. But
> > > the clock cycles are not accounted for in the same way in both cases.
> >
> > If the CPU is idle and clock_pelt == clock_task, the component A of the
> > estimator would be 0 and we only would account for how outdated is the rq's
> > clock, i.e. component B.
> 
> And if cpu is not idle, you can't apply the diff between clk_pelt and clock_task
> 
> >
> > > - (B) doesn't seem to be accurate as you skip irq and steal time
> > > accounting and you don't apply any scale invariance if the cpu is not
> > > idle
> >
> > The missing irq and paravirt time is the reason why it is called "estimator".
> > But maybe there's a chance of improving this part with a lockless version of
> > rq->prev_irq_time and rq->prev_steal_time_rq?
> >
> > > - IIUC your explanation in the commit message above, the (A) period
> > > seems to be a problem only when idle but you apply it unconditionally.
> >
> > If the CPU is idle (and clock_pelt == clock_task), only the B part would be
> > worth something:
> >
> >   A + B = [clock_task - clock_pelt] + [sched_clock_cpu() - clock]
> >                       A                            B
> >
> > > If cpu is idle you can assume that clock_pelt should be equal to
> > > clock_task but you can't if cpu is not idle otherwise your sync will
> > > be inaccurate and defeat the primary goal of this patch. If your
> > > problem with clock_pelt is that the pending idle time is not accounted
> > > for when entering idle but only at the next update (update blocked
> > > load or wakeup of a thread). This patch below should fix this and
> > > remove your A.
> >
> > That would help slightly the current situation, but this part is already
> > covered by the estimator.
> 
> But the estimator, as you name it, is wrong beaus ethe A part can't be
> applied unconditionally

Hum, it is used only in the !active migration. So we know the task was sleeping
before that migration. As a consequence, the time we need to account is "sleeping"
time from the task point of view, which is clock_pelt == clock_task (for
__update_load_avg_blocked_se()). Otherwise, we would only decay with the
"wallclock" idle time instead of the "scaled" one wouldn't we?


     +-------------+-------------- 
     |   Task A    |    Task B    .....
              ^    ^             ^
              |    |          migrate A
	      |    |             |
              |    |             |
              |    |             |
	      |    |<----------->| 
              |  Wallclock Task A idle time
              |<---------------->|
	    "Scaled" Task A idle time


[...]
