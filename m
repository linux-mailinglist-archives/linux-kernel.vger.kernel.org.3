Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4222547B237
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhLTRf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:35:27 -0500
Received: from foss.arm.com ([217.140.110.172]:60250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232781AbhLTRfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:35:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42D00D6E;
        Mon, 20 Dec 2021 09:35:25 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80EDC3F774;
        Mon, 20 Dec 2021 09:35:23 -0800 (PST)
Subject: Re: [RT] BUG in sched/cpupri.c
To:     John Keeping <john@metanate.com>, linux-rt-users@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <Yb3vXx3DcqVOi+EA@donbot>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com>
Date:   Mon, 20 Dec 2021 18:35:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yb3vXx3DcqVOi+EA@donbot>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.12.21 15:25, John Keeping wrote:
> Hi,
> 
> On v5.15.10-rt24 (and earlier v5.15 series RT kernels) I'm seeing an
> occasional BUG at cpupri.c:151 (full trace below).
> 
> Having added extra logging, it seems that p->prio == 120 which isn't
> handled by convert_prio() following commit 934fc3314b39 ("sched/cpupri:
> Remap CPUPRI_NORMAL to MAX_RT_PRIO-1").
> 
> This happens maybe half the time as userspace is starting up, but if the
> system boots to a login prompt I haven't seen any issues after that.
> The process isn't always the same, I've seen systemd-udevd as well as
> pr/ttyS2.
> 
> I can easily "fix" this by handling normal priority tasks in
> convert_prio() but I guess there's some wider reason why that's not an
> expected value there, so perhaps the real problem lies elsewhere.

find_lowest_rq() -> [ cpupri_find() ] -> cpupri_find_fitness() ->
convert_prio(p->prio) can only be called for an RT task (p->prio=[0..98])

I can recreate this on my Juno-r0 Arm64 machine with v5.15.10-rt24,
CONFIG_PREEMPT_RT=y .

------------[ cut here ]------------
[   15.256482] WARNING: CPU: 3 PID: 35 at kernel/sched/rt.c:1898 push_rt_task.part.0+0x190/0x364
[   15.256521] Modules linked in:
[   15.256532] CPU: 3 PID: 35 Comm: ksoftirqd/3 Not tainted 5.15.10-rt24-dirty #14
[   15.256546] Hardware name: ARM Juno development board (r0) (DT)
[   15.256552] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   15.256567] pc : push_rt_task.part.0+0x190/0x364
[   15.256582] lr : push_rt_task.part.0+0x20/0x364
[   15.256597] sp : ffff800011ff3e20
[   15.256602] x29: ffff800011ff3e20 x28: ffff0008001ca940 x27: 0000000000000000
[   15.256622] x26: 0000000000000000 x25: ffff800011f61da0 x24: 0000000000000001
[   15.256639] x23: 0000000000000000 x22: ffff00097ef923c0 x21: ffff0008000e0dc0
[   15.256657] x20: ffff0008000e0dc0 x19: ffff00097ef923c0 x18: 0000000000000002
[   15.256674] x17: ffff80096d7e7000 x16: ffff800011ff4000 x15: 0000000000004000
[   15.256692] x14: 00000000000000c1 x13: 0000000000000001 x12: 0000000000000000
[   15.256709] x11: 0000000000000001 x10: 0000000000000001 x9 : 0000000000000400
[   15.256725] x8 : ffff00097ef924c0 x7 : ffff00097ef92440 x6 : 00000000356c5f2b
[   15.256743] x5 : ffff80096d7e7000 x4 : 0000000000000000 x3 : 0000000000000003
[   15.256760] x2 : ffff00097ef923c0 x1 : 0000000000000062 x0 : 0000000000000078
[   15.256777] Call trace:
[   15.256783]  push_rt_task.part.0+0x190/0x364
[   15.256799]  rto_push_irq_work_func+0x180/0x190
[   15.256815]  irq_work_single+0x34/0xa0
[   15.256829]  flush_smp_call_function_queue+0x138/0x244
[   15.256845]  generic_smp_call_function_single_interrupt+0x18/0x24
[   15.256860]  ipi_handler+0xb0/0x15c
[   15.256875]  handle_percpu_devid_irq+0x88/0x140
[   15.256890]  handle_domain_irq+0x64/0x94
[   15.256907]  gic_handle_irq+0x50/0xf0
[   15.256924]  call_on_irq_stack+0x2c/0x60
[   15.256937]  do_interrupt_handler+0x54/0x60
[   15.256951]  el1_interrupt+0x30/0x80
[   15.256965]  el1h_64_irq_handler+0x1c/0x30
[   15.256978]  el1h_64_irq+0x78/0x7c
[   15.256989]  preempt_schedule_irq+0x40/0x150
[   15.257004]  el1_interrupt+0x60/0x80
[   15.257016]  el1h_64_irq_handler+0x1c/0x30
[   15.257029]  el1h_64_irq+0x78/0x7c
[   15.257039]  run_ksoftirqd+0x94/0xc0
[   15.257053]  smpboot_thread_fn+0x2d8/0x320
[   15.257066]  kthread+0x18c/0x1a0
[   15.257081]  ret_from_fork+0x10/0x20
[   15.257094] ---[ end trace 0000000000000002 ]---
[   16.257349] next_task=[rcu_preempt 11] rq->curr=[ksoftirqd/3 35]

root@juno:~# ps -eTo comm,pid,lwp,pri,rtprio,nice,class | more
COMMAND           PID   LWP PRI RTPRIO  NI CLS
..
rcu_preempt        11    11  41      1   - FF
...
ksoftirqd/3        35    35  19      -   0 TS
...

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ef8228d19382..798887f1eeff 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1895,9 +1895,17 @@ static int push_rt_task(struct rq *rq, bool pull)
                struct task_struct *push_task = NULL;
                int cpu;
 
+               if (WARN_ON_ONCE(!rt_task(rq->curr))) {
+                       printk("next_task=[%s %d] rq->curr=[%s %d]\n",
+                              next_task->comm, next_task->pid, rq->curr->comm, rq->curr->pid);
+               }
+
                if (!pull || rq->push_busy)
                        return 0;
 
+               if (!rt_task(rq->curr))
+                       return 0;
+
                cpu = find_lowest_rq(rq->curr);
                if (cpu == -1 || cpu == rq->cpu)
                        return 0;

The 2. condition prevents the BUG_ON() in cpupri_find_fitness().

[...]
