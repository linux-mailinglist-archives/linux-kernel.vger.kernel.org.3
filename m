Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35E9571ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiGLPU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiGLPUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:20:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED2FB93CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E48DCE1BC1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C1FC341C0;
        Tue, 12 Jul 2022 15:16:17 +0000 (UTC)
Date:   Tue, 12 Jul 2022 11:16:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        zhaohui.shi@horizon.ai
Subject: Re: [PATCH v6 1/2] sched/rt: fix bad task migration for rt tasks
Message-ID: <20220712111616.4e25e11c@gandalf.local.home>
In-Reply-To: <20220712150506.632304-1-schspa@gmail.com>
References: <20220712150506.632304-1-schspa@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 23:05:05 +0800
Schspa Shi <schspa@gmail.com> wrote:

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
> To fix it, we need to check migration_disabled flag again to avoid
> bad migration.
> 
> Fixes: 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


