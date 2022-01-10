Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6775D489D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiAJQ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:29:31 -0500
Received: from foss.arm.com ([217.140.110.172]:36256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237466AbiAJQ3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:29:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27B052B;
        Mon, 10 Jan 2022 08:29:30 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C90D63F5A1;
        Mon, 10 Jan 2022 08:29:28 -0800 (PST)
Date:   Mon, 10 Jan 2022 16:29:19 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com, Morten.Rasmussen@arm.com,
        qperret@google.com
Subject: Re: [PATCH 2/3] sched/fair: Fix newidle_balance() for overutilized
 systems
Message-ID: <YdxeoRUeZhl2D+dK@FVFF7649Q05P>
References: <20211220114323.22811-1-vincent.donnefort@arm.com>
 <20211220114323.22811-3-vincent.donnefort@arm.com>
 <CAKfTPtCJPHfoiuspYMGPARHdOuLJ6g0oUx2EQjdEPz729NrDPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCJPHfoiuspYMGPARHdOuLJ6g0oUx2EQjdEPz729NrDPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> 
> > can spuriously maintain overutilized for a long period of time.
> >
> > We then need newidle_balance() to proceed with balancing if the system is
> > overutilized.
> 
> Always triggering a costly newidle_balance when you are already
> overutilized for the sole purpose of clearing overutilized seems to be
> a bit overkill.

But the only cases where newidle_balance() would now run while it used not to,
are when overutilized is set but overload is not. Which is either a transient
state for which we do not anticipate more than one stat update or it is the
situation where one of the biggest CPU is overutilized while having nr_running <
2.

It can indeed add some additional costly calls to newidle_balance, but they
will not be plentiful, especially with the other patch from this series: 

  "sched/fair: Do not raise overutilized for idle CPUs"

> 
> Furthermore, nothing prevents us to abort newidle_balance before
> reaching the root domain

should_we_balance() always return true in the case of newidle. So I suppose you
refer to max_newidle_lb_cost?

> 
> So this doesn't seem like the good way to proceed

What are our other options?

Resolving it in the nohz balancer would need to change should_we_balance().

I also tried solely to not raise overutilized when the CPU is idle but this is
not a solution either as when a task migration is pending, you can end-up with
a !idle CPU but with nr_running < 2, so once again overutilized set, overload
not.

> 
> >
> > Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e2f6fa14e5e7..51f6f55abb37 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10849,7 +10849,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >         rcu_read_lock();
> >         sd = rcu_dereference_check_sched_domain(this_rq->sd);
> >
> > -       if (!READ_ONCE(this_rq->rd->overload) ||
> > +       if ((!READ_ONCE(this_rq->rd->overload) &&
> > +           !READ_ONCE(this_rq->rd->overutilized)) ||
> >             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> >
> >                 if (sd)
> > --
> > 2.25.1
> >
