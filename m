Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEBE48EFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244089AbiANSZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:25:49 -0500
Received: from foss.arm.com ([217.140.110.172]:36686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236376AbiANSZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:25:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF795ED1;
        Fri, 14 Jan 2022 10:25:47 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 657E23F766;
        Fri, 14 Jan 2022 10:25:46 -0800 (PST)
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
In-Reply-To: <f2d50e78-dc7b-6851-f12e-d702fbfea826@arm.com>
References: <Yb3vXx3DcqVOi+EA@donbot> <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com> <87zgou6iq1.mognet@arm.com> <20211221164528.3c84543f.john@metanate.com> <31a47e99-6de3-76ec-62ad-9c98d092ead5@arm.com> <87r1a4775a.mognet@arm.com> <f2d50e78-dc7b-6851-f12e-d702fbfea826@arm.com>
Date:   Fri, 14 Jan 2022 18:25:35 +0000
Message-ID: <87h7a66uow.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to page this back in...

On 07/01/22 11:46, Dietmar Eggemann wrote:
> On 22/12/2021 20:48, Valentin Schneider wrote:
>> On 22/12/21 18:46, Dietmar Eggemann wrote:
>>> On 21.12.21 17:45, John Keeping wrote:
>>>> On Tue, 21 Dec 2021 16:11:34 +0000
>>>> Valentin Schneider <valentin.schneider@arm.com> wrote:
>>>>
>>>>> On 20/12/21 18:35, Dietmar Eggemann wrote:
>
> [...]
>
>>> switched_from_rt() -> rt_queue_pull_task(, pull_rt_task)
>>>   pull_rt_task()->tell_cpu_to_push()->irq_work_queue_on(&rq->rd->rto_push_work,)
>>>     rto_push_irq_work_func() -> push_rt_task(rq, true)
>>>
>>> seems to be the only way with pull=true.
>>>
>>> In my tests, rq->rt.rt_nr_running seems to be 0 when it happens.
>>>
>>> [   22.288537] CPU3 switched_to_rt: p=[ksoftirqd/3 35]
>>> [   22.288554] rt_mutex_setprio: CPU3 p=[ksoftirqd/3 35] pi_task=[rcu_preempt 11] queued=1 running=0 prio=98 oldprio=120
>>> [   22.288636] CPU3 switched_from_rt: p=[ksoftirqd/3 35] rq->rt.rt_nr_running=0
>>>                                                          ^^^^^^^^^^^^^^^^^^^^^^
>>> [   22.288649] rt_mutex_setprio: CPU3 p=[ksoftirqd/3 35] queued=1 running=1 prio=120 oldprio=98
>>> [   22.288681] CPU3 push_rt_task: next_task=[rcu_preempt 11] migr_dis=1 rq->curr=[ksoftirqd/3 35] pull=1
>>>                                                              ^^^^^^^^^^                           ^^^^^^
>> 
>> mark_wakeup_next_waiter() first deboosts the previous owner and then
>> wakeups the next top waiter. Seems like you somehow have the wakeup happen
>> before the push_rt_task IRQ work is run. Also, tell_cpu_to_push() should
>> only pick a CPU that is in rq->rd->rto_mask, which requires having at least
>> 2 RT tasks there...
>
> True, this_cpu has rt_nr_running = 0 and *cpu* has rt_nr_running >= 2:
>
>   mark_wakeup_next_waiter()
>
>     (1) /* deboost */
>     rt_mutex_adjust_prio()
>
>       rt_mutex_setprio(current, ...)
>
>         rq = __task_rq_lock(current, );
>         check_class_changed(rq, p, prev_class, oldprio)
>
>           switched_from_rt()
>
>             if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
>               return;
>
>             rt_queue_pull_task(rq)
>
>               queue_balance_callback(rq, ..., pull_rt_task);
>
>                 pull_rt_task()
>
>                   tell_cpu_to_push()
>
>                     *cpu* = rto_next_cpu(rq->rd)
>                     irq_work_queue_on(&rq->rd->rto_push_work, *cpu*)
>
>                       rto_push_irq_work_func()
>                         push_rt_task(rq, true) <-- !!!
>
>     (2) /* waking the top waiter */
>     rt_mutex_wake_q_add(wqh, waiter);
>
>> Now, that wakeup from the rtmutex unlock would give us a resched_curr() via
>> check_preempt_curr() if required, which is good, though I think we are
>> still missing some for sched_setscheduler() (there are no wakeups
>> there). So if we just have to live with an IRQ work popping in before we
>> get to preempt_schedule_irq() (or somesuch), then perhaps the below would
>> be sufficient.
>
> I think that's the case here but we are on the RT overloaded CPU (*cpu*).
>

So one thing I wasn't entirely clear on (and holidays didn't fix that) is
the rt_queue_pull_task() from switched_from_rt() only happens if that rq
has no other runnable RT tasks, so I don't quite see how the
irq_work_queue_on() can end up as a self-IPI...

>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index ef8228d19382..8f3e3a1367b6 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -1890,6 +1890,16 @@ static int push_rt_task(struct rq *rq, bool pull)
>>  	if (!next_task)
>>  		return 0;
>>  
>> +	/*
>> +	 * It's possible that the next_task slipped in of higher priority than
>> +	 * current, or current has *just* changed priority.  If that's the case
>> +	 * just reschedule current.
>> +	 */
>> +	if (unlikely(next_task->prio < rq->curr->prio)) {
>> +		resched_curr(rq);
>> +		return 0;
>> +	}
>
> IMHO, that's the bit which prevents the BUG.
>
> But this would also prevent the case in which rq->curr is an RT task
> with lower prio than next_task.
>

I think that's what we want - if current isn't the (logical) highest
priority task on the runqueue, we should forgo push/pull and reschedule
ASAP.

> Also `rq->curr = migration/X` goes still though which is somehow fine
> since find_lowest_rq() bails out for if (task->nr_cpus_allowed == 1).
>
> And DL tasks (like sugov:X go through and they can have
> task->nr_cpus_allowed > 1 (arm64 slow-switching boards with shared
> freuency domains with schedutil). cpupri_find_fitness()->convert_prio()
> can handle  task_pri, p->prio = -1 (CPUPRI_INVALID) although its somehow
> by coincidence.
>

Right. This reminds me of:
https://lore.kernel.org/lkml/jhjblbx7glh.mognet@arm.com/


> So maybe something like this:
>

Ah, so you explicitely prevent rt.c::find_lowest_rq() invocations with a
non-RT task... But what if current is an RT task that just got deboosted,
so that next_task->prio < rq->curr->prio? IMO we should reschedule ASAP (as
I already blabbered about above). If next_task is migration_disabled but
higher (logical) prio than current, we don't need to do any of the
migration_disabled specific crud, we just reschedule.

> @ -1898,6 +1898,11 @@ static int push_rt_task(struct rq *rq, bool pull)
>                 if (!pull || rq->push_busy)
>                         return 0;
>
> +               if (rq->curr->sched_class != &rt_sched_class) {
> +                       resched_curr(rq);
> +                       return 0;
> +               }
> +
>                 cpu = find_lowest_rq(rq->curr);
>
> [...]
