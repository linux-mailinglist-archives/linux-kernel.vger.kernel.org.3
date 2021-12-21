Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE4C47C4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbhLURWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:22:45 -0500
Received: from foss.arm.com ([217.140.110.172]:56714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhLURWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:22:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65535D6E;
        Tue, 21 Dec 2021 09:22:38 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE3A83F718;
        Tue, 21 Dec 2021 09:22:36 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Keeping <john@metanate.com>
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
In-Reply-To: <20211221164528.3c84543f.john@metanate.com>
References: <Yb3vXx3DcqVOi+EA@donbot> <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com> <87zgou6iq1.mognet@arm.com> <20211221164528.3c84543f.john@metanate.com>
Date:   Tue, 21 Dec 2021 17:22:34 +0000
Message-ID: <87wnjx7u05.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/21 16:45, John Keeping wrote:
> On Tue, 21 Dec 2021 16:11:34 +0000
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>
>> On 20/12/21 18:35, Dietmar Eggemann wrote:
>> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> > index ef8228d19382..798887f1eeff 100644
>> > --- a/kernel/sched/rt.c
>> > +++ b/kernel/sched/rt.c
>> > @@ -1895,9 +1895,17 @@ static int push_rt_task(struct rq *rq, bool pull)
>> >                 struct task_struct *push_task = NULL;
>> >                 int cpu;
>> >
>> > +               if (WARN_ON_ONCE(!rt_task(rq->curr))) {
>> > +                       printk("next_task=[%s %d] rq->curr=[%s %d]\n",
>> > +                              next_task->comm, next_task->pid, rq->curr->comm, rq->curr->pid);
>> > +               }
>> > +
>> >                 if (!pull || rq->push_busy)
>> >                         return 0;
>> >
>> > +               if (!rt_task(rq->curr))
>> > +                       return 0;
>> > +  
>> 
>> If current is a DL/stopper task, why not; if that's CFS (which IIUC is your
>> case), that's buggered: we shouldn't be trying to pull RT tasks when we
>> have queued RT tasks and a less-than-RT current, we should be rescheduling
>> right now.
>> 
>> I'm thinking this can happen via rt_mutex_setprio() when we demote an RT-boosted
>> CFS task (or straight up sched_setscheduler()):
>> check_class_changed()->switched_from_rt() doesn't trigger a resched_curr(),
>> so I suspect we get to the push/pull callback before getting a
>> resched (I actually don't see where we'd get a resched in that case other
>> than at the next tick).
>> 
>> IOW, feels like we want the below. Unfortunately I can't reproduce the
>> issue locally (yet), so that's untested.
>
> This patch doesn't make any difference for me - I hit the BUG on the
> first boot with this applied.
>

Thanks for the swift testing!

Did you give Dietmar's patch a try? ITSM it lacks a resched_curr(), but if
we can somehow get to the push IRQ work before rescheduling (which I think
might happen if we try to resched_curr(this_rq)), then we need his
bailout.
