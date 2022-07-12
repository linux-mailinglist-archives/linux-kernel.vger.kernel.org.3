Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F975571F17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiGLP1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiGLP1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:27:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D441026101
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:26:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F331B1596;
        Tue, 12 Jul 2022 08:26:59 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D190D3F73D;
        Tue, 12 Jul 2022 08:26:57 -0700 (PDT)
Message-ID: <c1db7f31-82e1-eac4-bd49-212859727cb2@arm.com>
Date:   Tue, 12 Jul 2022 17:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 1/2] sched/rt: fix bad task migration for rt tasks
Content-Language: en-US
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai
References: <20220712150506.632304-1-schspa@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220712150506.632304-1-schspa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 17:05, Schspa Shi wrote:
> Commit 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
> allow find_lock_lowest_rq to pick a task with migration disabled.
> This commit is intended to push the current running task on this CPU
> away.
> 
> There is a race scenarios, which allows a migration disabled task to
> be migrated to another CPU.
> 
> When there is a RT task with higher priority, rt sched class was
> intended to migrate higher priority task to lowest rq via push_rt_tasks,
> this BUG will happen here.
> 
> With the system running on PREEMPT_RT, rt_spin_lock will disable
> migration, this will make the problem easier to reproduce.
> 
> I have seen this crash on PREEMPT_RT, from the logs, there is a race
> when trying to migrate higher priority tasks to the lowest rq.
> 
> Please refer to the following scenarios.
> 
>            CPU0                                  CPU1
> ------------------------------------------------------------------
> push_rt_task
>   check is_migration_disabled(next_task)
>                                         task not running and
>                                         migration_disabled == 0
>   find_lock_lowest_rq(next_task, rq);
>     _double_lock_balance(this_rq, busiest);
>       raw_spin_rq_unlock(this_rq);
>       double_rq_lock(this_rq, busiest);
>         <<wait for busiest rq>>
>                                             <wakeup>
>                                         task become running
>                                         migrate_disable();
>                                           <context out>
>   deactivate_task(rq, next_task, 0);
>   set_task_cpu(next_task, lowest_rq->cpu);
>     WARN_ON_ONCE(is_migration_disabled(p));
>       ---------OOPS-------------
> 
> Crash logs as fellowing:
> [123671.996430] WARNING: CPU: 2 PID: 13470 at kernel/sched/core.c:2485

What code-base is this?

IMHO, currently this `WARN_ON_ONCE(is_migration_disabled(p))` in
set_task_cpu() is at > line 3000.

> set_task_cpu+0x8c/0x108
> [123671.996800] pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
> [123671.996811] pc : set_task_cpu+0x8c/0x108
> [123671.996820] lr : set_task_cpu+0x7c/0x108
> [123671.996828] sp : ffff80001268bd30
> [123671.996832] pmr_save: 00000060
> [123671.996835] x29: ffff80001268bd30 x28: ffff0001a3d68e80
> [123671.996844] x27: ffff80001225f4a8 x26: ffff800010ab62cb
> [123671.996854] x25: ffff80026d95e000 x24: 0000000000000005
> [123671.996864] x23: ffff00019746c1b0 x22: 0000000000000000
> [123671.996873] x21: ffff00027ee33a80 x20: 0000000000000000
> [123671.996882] x19: ffff00019746ba00 x18: 0000000000000000
> [123671.996890] x17: 0000000000000000 x16: 0000000000000000
> [123671.996899] x15: 000000000000000a x14: 000000000000349e
> [123671.996908] x13: ffff800012f4503d x12: 0000000000000001
> [123671.996916] x11: 0000000000000000 x10: 0000000000000000
> [123671.996925] x9 : 00000000000c0000 x8 : ffff00027ee58700
> [123671.996933] x7 : ffff00027ee8da80 x6 : ffff00027ee8e580
> [123671.996942] x5 : ffff00027ee8dcc0 x4 : 0000000000000005
> [123671.996951] x3 : ffff00027ee8e338 x2 : 0000000000000000
> [123671.996959] x1 : 00000000000000ff x0 : 0000000000000002
> [123671.996969] Call trace:
> [123671.996975]  set_task_cpu+0x8c/0x108
> [123671.996984]  push_rt_task.part.0+0x144/0x184
> [123671.996995]  push_rt_tasks+0x28/0x3c
> [123671.997002]  task_woken_rt+0x58/0x68
> [123671.997009]  ttwu_do_wakeup+0x5c/0xd0
> [123671.997019]  ttwu_do_activate+0xc0/0xd4
> [123671.997028]  try_to_wake_up+0x244/0x288
> [123671.997036]  wake_up_process+0x18/0x24
> [123671.997045]  __irq_wake_thread+0x64/0x80
> [123671.997056]  __handle_irq_event_percpu+0x110/0x124
> [123671.997064]  handle_irq_event_percpu+0x50/0xac
> [123671.997072]  handle_irq_event+0x84/0xfc
> 

[...]

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 8c9ed96648409..7bd3e6ecbe45e 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1998,11 +1998,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  			 * the mean time, task could have
>  			 * migrated already or had its affinity changed.
>  			 * Also make sure that it wasn't scheduled on its rq.
> +			 * It is possible the task was scheduled, set
> +			 * "migrate_disabled" and then got preempted, so we must
> +			 * check the task migration disable flag here too.
>  			 */
>  			if (unlikely(task_rq(task) != rq ||
>  				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
>  				     task_running(rq, task) ||
>  				     !rt_task(task) ||
> +				     is_migration_disabled(task) ||

I wonder why this isn't covered by `task_rq(task) != rq` in this condition?

[...]
