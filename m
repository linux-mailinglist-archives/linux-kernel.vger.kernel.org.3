Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D351147D7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbhLVTso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:48:44 -0500
Received: from foss.arm.com ([217.140.110.172]:53342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345312AbhLVTsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:48:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4363C1FB;
        Wed, 22 Dec 2021 11:48:41 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEF423F5A1;
        Wed, 22 Dec 2021 11:48:39 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        John Keeping <john@metanate.com>
Cc:     linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RT] BUG in sched/cpupri.c
In-Reply-To: <31a47e99-6de3-76ec-62ad-9c98d092ead5@arm.com>
References: <Yb3vXx3DcqVOi+EA@donbot> <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com> <87zgou6iq1.mognet@arm.com> <20211221164528.3c84543f.john@metanate.com> <31a47e99-6de3-76ec-62ad-9c98d092ead5@arm.com>
Date:   Wed, 22 Dec 2021 19:48:33 +0000
Message-ID: <87r1a4775a.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/21 18:46, Dietmar Eggemann wrote:
> On 21.12.21 17:45, John Keeping wrote:
>> On Tue, 21 Dec 2021 16:11:34 +0000
>> Valentin Schneider <valentin.schneider@arm.com> wrote:
>>
>>> On 20/12/21 18:35, Dietmar Eggemann wrote:
>
> [...]
>
>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>> index fd7c4f972aaf..7d61ceec1a3b 100644
>>> --- a/kernel/sched/deadline.c
>>> +++ b/kernel/sched/deadline.c
>>> @@ -2467,10 +2467,13 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
>>>      * this is the right place to try to pull some other one
>>>      * from an overloaded CPU, if any.
>>>      */
>>> -	if (!task_on_rq_queued(p) || rq->dl.dl_nr_running)
>>> +	if (!task_on_rq_queued(p))
>>>             return;
>>>
>>> -	deadline_queue_pull_task(rq);
>>> +	if (!rq->dl.dl_nr_running)
>>> +		deadline_queue_pull_task(rq);
>>> +	else if (task_current(rq, p) && (p->sched_class < &dl_sched_class))
>>> +		resched_curr(rq);
>>>  }
>>>
>>>  /*
>>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>>> index ef8228d19382..1ea2567612fb 100644
>>> --- a/kernel/sched/rt.c
>>> +++ b/kernel/sched/rt.c
>>> @@ -2322,10 +2322,13 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
>>>      * we may need to handle the pulling of RT tasks
>>>      * now.
>>>      */
>>> -	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
>>> +	if (!task_on_rq_queued(p))
>>>             return;
>>>
>>> -	rt_queue_pull_task(rq);
>>> +	if (!rq->rt.rt_nr_running)
>>> +		rt_queue_pull_task(rq);
>>> +	else if (task_current(rq, p) && (p->sched_class < &rt_sched_class))
>>> +		resched_curr(rq);
>
> switched_from_rt() -> rt_queue_pull_task(, pull_rt_task)
>   pull_rt_task()->tell_cpu_to_push()->irq_work_queue_on(&rq->rd->rto_push_work,)
>     rto_push_irq_work_func() -> push_rt_task(rq, true)
>
> seems to be the only way with pull=true.
>
> In my tests, rq->rt.rt_nr_running seems to be 0 when it happens.
>
> [   22.288537] CPU3 switched_to_rt: p=[ksoftirqd/3 35]
> [   22.288554] rt_mutex_setprio: CPU3 p=[ksoftirqd/3 35] pi_task=[rcu_preempt 11] queued=1 running=0 prio=98 oldprio=120
> [   22.288636] CPU3 switched_from_rt: p=[ksoftirqd/3 35] rq->rt.rt_nr_running=0
>                                                          ^^^^^^^^^^^^^^^^^^^^^^
> [   22.288649] rt_mutex_setprio: CPU3 p=[ksoftirqd/3 35] queued=1 running=1 prio=120 oldprio=98
> [   22.288681] CPU3 push_rt_task: next_task=[rcu_preempt 11] migr_dis=1 rq->curr=[ksoftirqd/3 35] pull=1
>                                                              ^^^^^^^^^^                           ^^^^^^

mark_wakeup_next_waiter() first deboosts the previous owner and then
wakeups the next top waiter. Seems like you somehow have the wakeup happen
before the push_rt_task IRQ work is run. Also, tell_cpu_to_push() should
only pick a CPU that is in rq->rd->rto_mask, which requires having at least
2 RT tasks there...

Now, that wakeup from the rtmutex unlock would give us a resched_curr() via
check_preempt_curr() if required, which is good, though I think we are
still missing some for sched_setscheduler() (there are no wakeups
there). So if we just have to live with an IRQ work popping in before we
get to preempt_schedule_irq() (or somesuch), then perhaps the below would
be sufficient.

> What about slightly changing the layout in switched_from_rt() (only lightly tested):
>
>
> @@ -2322,7 +2338,15 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
>          * we may need to handle the pulling of RT tasks
>          * now.
>          */
> -       if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
> +       if (!task_on_rq_queued(p))
> +               return;
> +
> +       if (task_current(rq, p) && (p->sched_class < &rt_sched_class)) {
> +               resched_curr(rq);
> +               return;
> +       }
> +
> +       if (rq->rt.rt_nr_running)
>                 return;
>
>         rt_queue_pull_task(rq);

If !rq->rt.rt_nr_running then there's no point in issuing a reschedule (at
least from RT's perspective; p->sched_class->switched_to() takes care of
the rest)

---

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fd7c4f972aaf..7d61ceec1a3b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2467,10 +2467,13 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	 * this is the right place to try to pull some other one
 	 * from an overloaded CPU, if any.
 	 */
-	if (!task_on_rq_queued(p) || rq->dl.dl_nr_running)
+	if (!task_on_rq_queued(p))
 		return;
 
-	deadline_queue_pull_task(rq);
+	if (!rq->dl.dl_nr_running)
+		deadline_queue_pull_task(rq);
+	else if (task_current(rq, p) && (p->sched_class < &dl_sched_class))
+		resched_curr(rq);
 }
 
 /*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ef8228d19382..8f3e3a1367b6 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1890,6 +1890,16 @@ static int push_rt_task(struct rq *rq, bool pull)
 	if (!next_task)
 		return 0;
 
+	/*
+	 * It's possible that the next_task slipped in of higher priority than
+	 * current, or current has *just* changed priority.  If that's the case
+	 * just reschedule current.
+	 */
+	if (unlikely(next_task->prio < rq->curr->prio)) {
+		resched_curr(rq);
+		return 0;
+	}
+
 retry:
 	if (is_migration_disabled(next_task)) {
 		struct task_struct *push_task = NULL;
@@ -1922,16 +1932,6 @@ static int push_rt_task(struct rq *rq, bool pull)
 	if (WARN_ON(next_task == rq->curr))
 		return 0;
 
-	/*
-	 * It's possible that the next_task slipped in of
-	 * higher priority than current. If that's the case
-	 * just reschedule current.
-	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
-		resched_curr(rq);
-		return 0;
-	}
-
 	/* We might release rq lock */
 	get_task_struct(next_task);
 
@@ -2322,10 +2322,13 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	 * we may need to handle the pulling of RT tasks
 	 * now.
 	 */
-	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
+	if (!task_on_rq_queued(p))
 		return;
 
-	rt_queue_pull_task(rq);
+	if (!rq->rt.rt_nr_running)
+		rt_queue_pull_task(rq);
+	else if (task_current(rq, p) && (p->sched_class < &rt_sched_class))
+		resched_curr(rq);
 }
 
 void __init init_sched_rt_class(void)
