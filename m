Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E524955DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377793AbiATVMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:12:14 -0500
Received: from foss.arm.com ([217.140.110.172]:53728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377781AbiATVMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:12:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93F2C101E;
        Thu, 20 Jan 2022 13:12:10 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1FD83F774;
        Thu, 20 Jan 2022 13:12:08 -0800 (PST)
Date:   Thu, 20 Jan 2022 21:12:02 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com, Morten.Rasmussen@arm.com,
        Chris.Redpath@arm.com, qperret@google.com, Lukasz.Luba@arm.com
Subject: Re: [PATCH v2 2/7] sched/fair: Decay task PELT values during
 migration
Message-ID: <YenQIsHJhaEuJFQl@FVFF7649Q05P>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
 <20220112161230.836326-3-vincent.donnefort@arm.com>
 <CAKfTPtC2wCw4U9w=saW0dGYHfOKo42nBKU7oHcEM7KeDj7MzWA@mail.gmail.com>
 <Yeac5Y5Fzu/jaUf0@FVFF7649Q05P>
 <CAKfTPtAdTTP+qGruYy8gi6rfhS0W1gAdjgeLCtrLZHxyCEHo9g@mail.gmail.com>
 <Yef8kTnlP5h4I7/1@FVFF7649Q05P>
 <CAKfTPtB=CJNFDrpXY9o8g5XfjBfnVTUgb2rWke1SyWMUxz0M+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtB=CJNFDrpXY9o8g5XfjBfnVTUgb2rWke1SyWMUxz0M+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > And if cpu is not idle, you can't apply the diff between clk_pelt and clock_task
> > >
> > > >
> > > > > - (B) doesn't seem to be accurate as you skip irq and steal time
> > > > > accounting and you don't apply any scale invariance if the cpu is not
> > > > > idle
> > > >
> > > > The missing irq and paravirt time is the reason why it is called "estimator".
> > > > But maybe there's a chance of improving this part with a lockless version of
> > > > rq->prev_irq_time and rq->prev_steal_time_rq?
> > > >
> > > > > - IIUC your explanation in the commit message above, the (A) period
> > > > > seems to be a problem only when idle but you apply it unconditionally.
> > > >
> > > > If the CPU is idle (and clock_pelt == clock_task), only the B part would be
> > > > worth something:
> > > >
> > > >   A + B = [clock_task - clock_pelt] + [sched_clock_cpu() - clock]
> > > >                       A                            B
> > > >
> > > > > If cpu is idle you can assume that clock_pelt should be equal to
> > > > > clock_task but you can't if cpu is not idle otherwise your sync will
> > > > > be inaccurate and defeat the primary goal of this patch. If your
> > > > > problem with clock_pelt is that the pending idle time is not accounted
> > > > > for when entering idle but only at the next update (update blocked
> > > > > load or wakeup of a thread). This patch below should fix this and
> > > > > remove your A.
> > > >
> > > > That would help slightly the current situation, but this part is already
> > > > covered by the estimator.
> > >
> > > But the estimator, as you name it, is wrong beaus ethe A part can't be
> > > applied unconditionally
> >
> > Hum, it is used only in the !active migration. So we know the task was sleeping
> > before that migration. As a consequence, the time we need to account is "sleeping"
> > time from the task point of view, which is clock_pelt == clock_task (for
> > __update_load_avg_blocked_se()). Otherwise, we would only decay with the
> > "wallclock" idle time instead of the "scaled" one wouldn't we?
> 
> clock_pelt == clock_task only when cpu is idle and after updating
> lost_idle_time but you have no idea of the state of the cpu when
> migrating the task

I was just applying the time scaling at the task level. Why shall it depends on
the CPU state?

The situation would be as follows:

                    <--X--> <--Y-->
           +-------+-------+-------+
CPUX    ___|   B   |   A   |   B   |___
                                  ^
                               migrate A
                    
In a such scenario, CPUX's PELT clock is indeed scaled. The Task A running
time (X) has already been accounted, so what's left is to get an idle time (Y)
contribution accurate. We would usually rely on the CPU being idle for the
catch-up and that time would be Y + (X - scaled(X)). Without the catch-up, we
would account at the migration, for the sleeping time Y, only (scaled(Y)). Applied
to the same graph as for update_rq_clock_pelt()'s:

 clock_task    | 1| 2| 3| 4| 5| 6| 7| 8|
 clock_pelt    | 1   | 2   | 3   | 4   |  (CPU's running, clock_pelt is scaled)
 expected      | 1   | 2   | 5| 6| 7| 8|
               <---- X ---><--- Y ---->
 Task A -------************----------
                                   ^ 
                               migrate A

Contribution for Task A idle time at the migration (as we know we won't have
another chance to catch-up clock_task later) should be 6, not 2, regardless of
the CPU state.

_But_ indeed, there would be a risk of hitting the lost_idle_time threshold and
decay too much... (which is absolutely not handled in the current version). So
now, if we don't want to bother too much, we could simplify the problem and
say (which is true with NOHZ_IDLE) that if the CPU is running, the clock must
not be that old anyway. So we should only care of the idle case, which is
mitigated with your proposed snippet and I allow to get rid of the [A]
part (clock_task - clock_pelt).

As per sched_clock_cpu() usage, I haven't measured anything yet but notice it's
already used in the wakeup path in ttwu_queue_wakelist().

