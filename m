Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D1A47C525
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbhLURmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhLURmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:42:39 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5E8C061574;
        Tue, 21 Dec 2021 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=TupUKF0VK4vg65WIuMQBgabCl7SjWqeiUzuXaaiefOE=; b=Dxjv
        ii8l2A9scfMMOd9FBIcBR+gfXLs7mW//0vJRA5kk6lDnWpVDWNdhgJzeguEYF8vNlI7s/ATdwlk31
        aTsyuZN9Xy0P9PCpR5BzPbrd48ITEdT5UKqmnbYSqP+yL1d+U6q7WiqFeJTB00gcU7x+wvnFDO9G9
        JzZdmxN0OfMBzv14Iqxga/bebByPQ3RmFf1YbR512JMzsRz249stHj/AUlvHAB2r24p6VWdOXSEnw
        fmBZLDDpJPNIkG8IBEoV/mpwn0LpehpIJ0RTj+FCeS/QPi7R5a1ihljVNw2D+zz6FlOvaUJoWeotw
        jekNb8LStw9vRIRa23hbPJQWYL6ZtQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mzj9W-0006jB-Jy; Tue, 21 Dec 2021 17:42:18 +0000
Date:   Tue, 21 Dec 2021 17:42:15 +0000
From:   John Keeping <john@metanate.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RT] BUG in sched/cpupri.c
Message-ID: <20211221174215.04b07f31.john@metanate.com>
In-Reply-To: <87wnjx7u05.mognet@arm.com>
References: <Yb3vXx3DcqVOi+EA@donbot>
        <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com>
        <87zgou6iq1.mognet@arm.com>
        <20211221164528.3c84543f.john@metanate.com>
        <87wnjx7u05.mognet@arm.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 17:22:34 +0000
Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 21/12/21 16:45, John Keeping wrote:
> > On Tue, 21 Dec 2021 16:11:34 +0000
> > Valentin Schneider <valentin.schneider@arm.com> wrote:
> >  
> >> On 20/12/21 18:35, Dietmar Eggemann wrote:  
> >> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> >> > index ef8228d19382..798887f1eeff 100644
> >> > --- a/kernel/sched/rt.c
> >> > +++ b/kernel/sched/rt.c
> >> > @@ -1895,9 +1895,17 @@ static int push_rt_task(struct rq *rq, bool pull)
> >> >                 struct task_struct *push_task = NULL;
> >> >                 int cpu;
> >> >
> >> > +               if (WARN_ON_ONCE(!rt_task(rq->curr))) {
> >> > +                       printk("next_task=[%s %d] rq->curr=[%s %d]\n",
> >> > +                              next_task->comm, next_task->pid, rq->curr->comm, rq->curr->pid);
> >> > +               }
> >> > +
> >> >                 if (!pull || rq->push_busy)
> >> >                         return 0;
> >> >
> >> > +               if (!rt_task(rq->curr))
> >> > +                       return 0;
> >> > +    
> >> 
> >> If current is a DL/stopper task, why not; if that's CFS (which IIUC is your
> >> case), that's buggered: we shouldn't be trying to pull RT tasks when we
> >> have queued RT tasks and a less-than-RT current, we should be rescheduling
> >> right now.
> >> 
> >> I'm thinking this can happen via rt_mutex_setprio() when we demote an RT-boosted
> >> CFS task (or straight up sched_setscheduler()):
> >> check_class_changed()->switched_from_rt() doesn't trigger a resched_curr(),
> >> so I suspect we get to the push/pull callback before getting a
> >> resched (I actually don't see where we'd get a resched in that case other
> >> than at the next tick).
> >> 
> >> IOW, feels like we want the below. Unfortunately I can't reproduce the
> >> issue locally (yet), so that's untested.  
> >
> > This patch doesn't make any difference for me - I hit the BUG on the
> > first boot with this applied.
> >  
> 
> Thanks for the swift testing!
> 
> Did you give Dietmar's patch a try? ITSM it lacks a resched_curr(), but if
> we can somehow get to the push IRQ work before rescheduling (which I think
> might happen if we try to resched_curr(this_rq)), then we need his
> bailout.

With Dietmar's patch I hit the added WARN_ON_ONCE with:

	next_task=[rcu_preempt 11] rq->curr=[ksoftirqd/1 21]
	next_task=[rcu_preempt 11] rq->curr=[ksoftirqd/1 21]

	# ps -eTo comm,pid,lwp,pri,rtprio,nice,class
	...
	rcu_preempt        11    11  41      1   - FF
	...
	ksoftirqd/1        21    21  19      -   0 TS

Out of three reproductions, rcu_preempt as next_task is consistent, but
I've seen three different tasks in rq->curr (although all with
SCHED_OTHER).

And as expected, the added early return does stop the BUG.
