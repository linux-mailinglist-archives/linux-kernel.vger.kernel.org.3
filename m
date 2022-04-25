Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B650E48E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbiDYPki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242916AbiDYPkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:40:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAF2744A17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:37:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7094A1FB;
        Mon, 25 Apr 2022 08:37:25 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFD233F774;
        Mon, 25 Apr 2022 08:37:23 -0700 (PDT)
Message-ID: <c7b19b42-d7b1-74bb-46ea-e5674837e491@arm.com>
Date:   Mon, 25 Apr 2022 17:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] sched/core: Avoid obvious double update_rq_clock
 warning
Content-Language: en-US
To:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220422090944.52618-1-jiahao.os@bytedance.com>
 <20220422090944.52618-2-jiahao.os@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220422090944.52618-2-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 11:09, Hao Jia wrote:
> When we use raw_spin_rq_lock to acquire the rq lock and have to
> update the rq clock while holding the lock, the kernel may issue
> a WARN_DOUBLE_CLOCK warning.
> 
> Since we directly use raw_spin_rq_lock to acquire rq lock instead of
> rq_lock, there is no corresponding change to rq->clock_update_flags.
> In particular, we have obtained the rq lock of other cores,
> the core rq->clock_update_flags may be RQCF_UPDATED at this time, and
> then calling update_rq_clock will trigger the WARN_DOUBLE_CLOCK warning.
> 
> So we need to clear RQCF_UPDATED of rq->clock_update_flags synchronously
> to avoid the WARN_DOUBLE_CLOCK warning.
> 
> Some call trace reports:
> Call Trace 1:
>  <IRQ>
>  sched_rt_period_timer+0x10f/0x3a0
>  ? enqueue_top_rt_rq+0x110/0x110
>  __hrtimer_run_queues+0x1a9/0x490
>  hrtimer_interrupt+0x10b/0x240

[...]

For the  sched_rt_period_timer() case you simply replace
raw_spin_rq_lock()/raw_spin_rq_unlock() with rq_lock()/rq_unlock().
I.e. you're not using the new double_rq_clock_clear_update() which
is depicted in the text above.

> Call Trace 2:
>  <TASK>
>  activate_task+0x8b/0x110
>  push_rt_task.part.108+0x241/0x2c0
>  push_rt_tasks+0x15/0x30
>  finish_task_switch+0xaa/0x2e0
>  ? __switch_to+0x134/0x420
>  __schedule+0x343/0x8e0

[...]

> Call Trace 3:
>  <TASK>
>  deactivate_task+0x93/0xe0
>  pull_rt_task+0x33e/0x400
>  balance_rt+0x7e/0x90
>  __schedule+0x62f/0x8e0
>  do_task_dead+0x3f/0x50

[...]

> Steps to reproduce:
> 1. Enable CONFIG_SCHED_DEBUG when compiling the kernel
> 2. echo 1 > /sys/kernel/debug/clear_warn_once
>    echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched_features

s/sched_features/sched/features

>    echo "NO_RT_PUSH_IPI" > /sys/kernel/debug/sched_features

s/sched_features/sched/features

> 3. Run some rt tasks that periodically change the priority and sleep

Not sure about the `change the priority` part? I'm using rt-app with 2*n
rt or dl (90% running) tasks (on a system with n CPUs) and can trigger
all of these cases.
 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

You can remove this Signed-off-by. I can provide a Reviewed-By for the
next version.

[...]

When running PREEMPT_RT kernel there is another similar case in DL.

[  215.158100] ------------[ cut here ]------------
[  215.158105] rq->clock_update_flags & RQCF_UPDATED
[  215.158113] WARNING: CPU: 2 PID: 1942 at kernel/sched/core.c:690 update_rq_clock+0x128/0x1a0
...
[  215.158245]  update_rq_clock+0x128/0x1a0
[  215.158253]  migrate_task_rq_dl+0xec/0x310    <--- !!!
[  215.158259]  set_task_cpu+0x84/0x1e4
[  215.158264]  try_to_wake_up+0x1d8/0x5c0
[  215.158268]  wake_up_process+0x1c/0x30
[  215.158272]  hrtimer_wakeup+0x24/0x3c
[  215.158279]  __hrtimer_run_queues+0x114/0x270
[  215.158285]  hrtimer_interrupt+0xe8/0x244
[  215.158291]  arch_timer_handler_phys+0x30/0x50
[  215.158301]  handle_percpu_devid_irq+0x88/0x140
[  215.158306]  generic_handle_domain_irq+0x40/0x60
[  215.158313]  gic_handle_irq+0x48/0xe0
[  215.158320]  call_on_irq_stack+0x2c/0x60
[  215.158327]  do_interrupt_handler+0x80/0x84

For a non_contending task, this is the same issue as in sched_rt_period_timer().

-->8--

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index cfe7b40bc4ff..668a9910cd6d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1804,6 +1804,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 
 static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
 {
+	struct rq_flags rf;
 	struct rq *rq;
 
 	if (READ_ONCE(p->__state) != TASK_WAKING)
@@ -1815,7 +1816,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 	 * from try_to_wake_up(). Hence, p->pi_lock is locked, but
 	 * rq->lock is not... So, lock it
 	 */
-	raw_spin_rq_lock(rq);
+	rq_lock(rq, &rf);
 	if (p->dl.dl_non_contending) {
 		update_rq_clock(rq);
 		sub_running_bw(&p->dl, &rq->dl);
@@ -1831,7 +1832,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 			put_task_struct(p);
 	}
 	sub_rq_bw(&p->dl, &rq->dl);
-	raw_spin_rq_unlock(rq);
+	rq_unlock(rq, &rf);
 }
 
 static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
-- 
2.25.1
