Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E9047D5FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbhLVRrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:47:15 -0500
Received: from foss.arm.com ([217.140.110.172]:51080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234475AbhLVRrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:47:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAD1F1FB;
        Wed, 22 Dec 2021 09:47:12 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 156063F5A1;
        Wed, 22 Dec 2021 09:47:10 -0800 (PST)
Subject: Re: [RT] BUG in sched/cpupri.c
To:     John Keeping <john@metanate.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <Yb3vXx3DcqVOi+EA@donbot>
 <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com> <87zgou6iq1.mognet@arm.com>
 <20211221164528.3c84543f.john@metanate.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <31a47e99-6de3-76ec-62ad-9c98d092ead5@arm.com>
Date:   Wed, 22 Dec 2021 18:46:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221164528.3c84543f.john@metanate.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.21 17:45, John Keeping wrote:
> On Tue, 21 Dec 2021 16:11:34 +0000
> Valentin Schneider <valentin.schneider@arm.com> wrote:
> 
>> On 20/12/21 18:35, Dietmar Eggemann wrote:

[...]

>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index fd7c4f972aaf..7d61ceec1a3b 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2467,10 +2467,13 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
>>  	 * this is the right place to try to pull some other one
>>  	 * from an overloaded CPU, if any.
>>  	 */
>> -	if (!task_on_rq_queued(p) || rq->dl.dl_nr_running)
>> +	if (!task_on_rq_queued(p))
>>  		return;
>>  
>> -	deadline_queue_pull_task(rq);
>> +	if (!rq->dl.dl_nr_running)
>> +		deadline_queue_pull_task(rq);
>> +	else if (task_current(rq, p) && (p->sched_class < &dl_sched_class))
>> +		resched_curr(rq);
>>  }
>>  
>>  /*
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index ef8228d19382..1ea2567612fb 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -2322,10 +2322,13 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
>>  	 * we may need to handle the pulling of RT tasks
>>  	 * now.
>>  	 */
>> -	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
>> +	if (!task_on_rq_queued(p))
>>  		return;
>>  
>> -	rt_queue_pull_task(rq);
>> +	if (!rq->rt.rt_nr_running)
>> +		rt_queue_pull_task(rq);
>> +	else if (task_current(rq, p) && (p->sched_class < &rt_sched_class))
>> +		resched_curr(rq);

switched_from_rt() -> rt_queue_pull_task(, pull_rt_task)
  pull_rt_task()->tell_cpu_to_push()->irq_work_queue_on(&rq->rd->rto_push_work,)
    rto_push_irq_work_func() -> push_rt_task(rq, true)

seems to be the only way with pull=true.

In my tests, rq->rt.rt_nr_running seems to be 0 when it happens.

[   22.288537] CPU3 switched_to_rt: p=[ksoftirqd/3 35]
[   22.288554] rt_mutex_setprio: CPU3 p=[ksoftirqd/3 35] pi_task=[rcu_preempt 11] queued=1 running=0 prio=98 oldprio=120
[   22.288636] CPU3 switched_from_rt: p=[ksoftirqd/3 35] rq->rt.rt_nr_running=0
                                                         ^^^^^^^^^^^^^^^^^^^^^^ 
[   22.288649] rt_mutex_setprio: CPU3 p=[ksoftirqd/3 35] queued=1 running=1 prio=120 oldprio=98
[   22.288681] CPU3 push_rt_task: next_task=[rcu_preempt 11] migr_dis=1 rq->curr=[ksoftirqd/3 35] pull=1
                                                             ^^^^^^^^^^                           ^^^^^^ 
[   22.288698] CPU: 3 PID: 35 Comm: ksoftirqd/3 Not tainted 5.15.10-rt24-dirty #36
[   22.288711] Hardware name: ARM Juno development board (r0) (DT)
[   22.288718] Call trace:
[   22.288722]  dump_backtrace+0x0/0x1ac
[   22.288747]  show_stack+0x1c/0x70
[   22.288763]  dump_stack_lvl+0x68/0x84
[   22.288777]  dump_stack+0x1c/0x38
[   22.288788]  push_rt_task.part.0+0x364/0x370
[   22.288805]  rto_push_irq_work_func+0x180/0x190
[   22.288821]  irq_work_single+0x34/0xa0
[   22.288836]  flush_smp_call_function_queue+0x138/0x244
[   22.288852]  generic_smp_call_function_single_interrupt+0x18/0x24
[   22.288867]  ipi_handler+0xb0/0x15c
...

What about slightly changing the layout in switched_from_rt() (only lightly tested):


@@ -2322,7 +2338,15 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
         * we may need to handle the pulling of RT tasks
         * now.
         */
-       if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
+       if (!task_on_rq_queued(p))
+               return;
+
+       if (task_current(rq, p) && (p->sched_class < &rt_sched_class)) {
+               resched_curr(rq);
+               return;
+       }
+
+       if (rq->rt.rt_nr_running)
                return;
 
        rt_queue_pull_task(rq);
