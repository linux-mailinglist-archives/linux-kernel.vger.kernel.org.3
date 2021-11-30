Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C80463592
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhK3NjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:39:18 -0500
Received: from foss.arm.com ([217.140.110.172]:38366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240824AbhK3NjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:39:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CE8ED1;
        Tue, 30 Nov 2021 05:35:56 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CE6F3F5A1;
        Tue, 30 Nov 2021 05:35:55 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a
 task
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <Valentin.Schneider@arm.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net
References: <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com>
 <8735nkcwov.mognet@arm.com>
 <CAKfTPtDPskVdEd-KQ_cwe-R_zVFPQOgdbk9x+3eD12pKs8fGFw@mail.gmail.com>
 <87zgpsb6de.mognet@arm.com>
 <CAKfTPtCnusWJXJLDEudQ_q8MWaZYbPJK-QjAbBYWFW8Nw-J+Ww@mail.gmail.com>
 <87sfvjavqk.mognet@arm.com>
 <CAKfTPtC4iXXaptm9+2bHvX2E3xAWU4M3xN0ZuwpFQ1RyXAyxyA@mail.gmail.com>
 <87pmqmc16f.mognet@arm.com> <20211126171817.GA3798214@ubiquitous>
 <CAKfTPtCGyp8JZq1EOgEhTeD+PBV2rMnTQ=uV-ZgsaN1RVmPk0w@mail.gmail.com>
 <20211129164545.GA3981328@ubiquitous>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <59df959f-c0bc-2635-eb7c-bad2e9964357@arm.com>
Date:   Tue, 30 Nov 2021 14:35:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129164545.GA3981328@ubiquitous>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.21 17:54, Vincent Donnefort wrote:
> [...]
> 
>>>>>
>>>>> still i don't see the need of !is_idle_task(current)
>>>>>
>>>>
>>>> Admittedly, belts and braces. The existing condition checks rq->nr_running <= 1
>>>> which can lead to coscheduling when the wakeup is issued by the idle task
>>>> (or even if rq->nr_running == 0, you can have rq->ttwu_pending without
>>>> having sent an IPI due to polling). Essentially this overrides the first
>>>> check in sis() that uses idle_cpu(target) (prev == smp_processor_id() ==
>>>> target).
>>>>
>>>> I couldn't prove such wakeups can happen right now, but if/when they do
>>>> (AIUI it would just take someone to add a wake_up_process() down some
>>>> smp_call_function() callback) then we'll need the above. If you're still
>>>> not convinced by now, I won't push it further.
>>>
>>> From a quick experiment, even with the asym_fits_capacity(), I can trigger
>>> the following:
>>>
>>> [    0.118855] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
>>> [    0.128214] select_idle_sibling: wakee=rcu_gp:3 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
>>> [    0.137327] select_idle_sibling: wakee=rcu_par_gp:4 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
>>> [    0.147221] select_idle_sibling: wakee=kworker/u16:0:7 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
>>> [    0.156994] select_idle_sibling: wakee=mm_percpu_wq:8 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
>>
>> Timestamp shows its booting phase and thread name above shows per cpu
>> thread. Could it happen just while creating per cpu thread at boot and
>> as a result not relevant ?
> 
> I have more of those logs a bit later in the boot:
> 
> [    0.484791] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.516495] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.525758] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.535078] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.547486] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.579192] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> 
> The nr_cpus_allowed=8 suggest that none of the threads from the logs I
> shared are per-CPU. Sorry if the format is confusing, I used:
> 
>   wakee=<comm>:<pid> current=<comm>:<pid>.
> 
>>
>> Can you see similar things later after booting ?
> 
> I tried few scenarios other than the boot time but none of them produced
> "current=swapper/X:1 in_task=1"

I don't see them on hikey620 (SMP), not even during boot. I use a
BUG_ON(is_idle_task(current) && in_task()) in sis()'
`is_per_cpu_kthread` condition.

I can only spot `is_idle_task(current)=1` (1) or `in_task()=1` (2):

<idle>-0 [006] dNh3.   274.137473: select_task_rq_fair: (1):
is_idle_task(current)=1 in_task()=0 this=6 prev=6 target=6
rq->nr_running=1 p=[task_n10-1 1158] p->cpus_ptr=0-7 current=[swapper/6 0]

[  104.463685] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
5.16.0-rc1-00008-g8c92606ab810-dirty #78
[  104.472385] Hardware name: HiKey Development Board (DT)
[  104.477627] Call trace:

[  104.490808]  dump_stack+0x1c/0x38
[  104.494146]  select_task_rq_fair+0x1200/0x120c
[  104.498620]  try_to_wake_up+0x168/0x670
[  104.502486]  wake_up_process+0x1c/0x30
[  104.506260]  hrtimer_wakeup+0x24/0x3c
[  104.509948]  __hrtimer_run_queues+0x184/0x36c
[  104.514330]  hrtimer_interrupt+0xec/0x250
[  104.518365]  tick_receive_broadcast+0x30/0x50
[  104.522751]  ipi_handler+0x1dc/0x350


  kworker/3:2-87 [003] d..3.   270.954929: select_task_rq_fair: (2):
is_idle_task(current)=0 in_task()=1  this=3 prev=3 target=3
rq->nr_running=1 p=[kworker/u16:1 74] p->cpus_ptr=0-7
current=[kworker/3:2 87]

> 
>>
>> I have tried to trigger the situation but failed to get wrong
>> sequence. All are coming from interrupt while idle.
>> After adding in_task() condition, I haven't been able to trigger the
>> warn() that I added to catch the wrong situations on SMP, Heterogenous
>> or NUMA system. Could you share more details on your setup ?
>>
> 
> This is just my Hikey960 with the asym_fits_capacity() fix [1] to make sure I
> don't simply hit the other issue with asym platforms.
> 
> Then I just added my log in the per-CPU kthread wakee stacking exit path
> 
>     printk("%s: wakee=%s:%d nr_cpus_allowed=%d current=%s:%d in_task=%d\n",
>             __func__, p->comm, p->pid, p->nr_cpus_allowed, current->comm, current->pid, in_task());
> 
> 
> [1] https://lore.kernel.org/all/20211125101239.3248857-1-vincent.donnefort@arm.com/
> 
> 
> From the same logs I also see:
> 
>   wakee=xfsaild/mmcblk0:4855 nr_cpus_allowed=8 current=kworker/1:1:1070 in_task=0
> 
> Doesn't that look like a genuine wakeup that would escape the per-CPU kthread
> stacking exit path because of the in_task test?

I get a couple of `is_idle_task(current)=0 && in_task()=0` mostly with
`current=ksoftirqd/X` and occasionally with `current=[kworker/X:1H` or
`current=kworker/X:1`.

ksoftirqd/7-46 [007] d.s4.   330.275122: select_task_rq_fair: (3):
is_idle_task(current)=0 in_task()=0  this=7 prev=7 target=7
rq->nr_running=1 p=[kworker/u16:2 75] p->cpus_ptr=0-7
current=[ksoftirqd/7 46]

kworker/7:1H-144 [007] d.h3.   335.284388: select_task_rq_fair: (3):
is_idle_task(current)=0 in_task()=0  this=7 prev=7 target=7
rq->nr_running=1 p=[task_n10-1 2397] p->cpus_ptr=0-7
current=[kworker/7:1H 144]
