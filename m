Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73667465B23
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355052AbhLBAp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354664AbhLBAmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB8FC061758;
        Wed,  1 Dec 2021 16:39:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AAF1B8219A;
        Thu,  2 Dec 2021 00:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD8BC5674A;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=1u6E8u+Bz8q5xa9pvKSIwzql70OpTkl+wXJfuBVm9e8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFQogbFcscvyY3Ji0FUUmPeWIhlU1Z8bLF0R8Im7abGbaTygxK+3YY6R8tVv8buuu
         dNTbtG/11tv7XXiUx4abwGJ4U4n3f12uUKmuxj/pkWLb37R3iVwgGd5zUTGk2kmBly
         W5SwL411z7bXaIqqsRG+xtfKZ+2BtY4JOUWhARtapNvYgXJ0lKjmRW15/7mBkCYo2s
         87lBVkpLoC/rBxrhBumNT8ArNobYV3F4+AxKVT+R9LI8++kx7BDW5dz/xIS/IQP7rG
         pMc/vxC+CLvv7zTZoc4/asuUCby/wNkJ2WPILZV8FHpSqNBxP7tBEuGQdF7rlHasJR
         k/9HaB9zViKnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 50A635C1183; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/18] rcu-tasks: Inspect stalled task's trc state in locked state
Date:   Wed,  1 Dec 2021 16:38:47 -0800
Message-Id: <20211202003858.3129628-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <quic_neeraju@quicinc.com>

On RCU tasks trace stall, inspect the RCU-tasks-trace specific
states of stalled task in locked down state, using try_invoke_
on_locked_down_task(), to get reliable trc state of a non-running
stalled task.

This was tested using the following command:

tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --configs TRACE01 \
--bootargs "rcutorture.torture_type=tasks-tracing rcutorture.stall_cpu=10 \
rcutorture.stall_cpu_block=1 rcupdate.rcu_task_stall_timeout=100" --trust-make

As expected, this produced the following console output for running and
sleeping tasks.

[   21.520291] INFO: rcu_tasks_trace detected stalls on tasks:
[   21.521292] P85: ... nesting: 1N cpu: 2
[   21.521966] task:rcu_torture_sta state:D stack:15080 pid:   85 ppid:     2
flags:0x00004000
[   21.523384] Call Trace:
[   21.523808]  __schedule+0x273/0x6e0
[   21.524428]  schedule+0x35/0xa0
[   21.524971]  schedule_timeout+0x1ed/0x270
[   21.525690]  ? del_timer_sync+0x30/0x30
[   21.526371]  ? rcu_torture_writer+0x720/0x720
[   21.527106]  rcu_torture_stall+0x24a/0x270
[   21.527816]  kthread+0x115/0x140
[   21.528401]  ? set_kthread_struct+0x40/0x40
[   21.529136]  ret_from_fork+0x22/0x30
[   21.529766]  1 holdouts
[   21.632300] INFO: rcu_tasks_trace detected stalls on tasks:
[   21.632345] rcu_torture_stall end.
[   21.633293] P85: .
[   21.633294] task:rcu_torture_sta state:R  running task stack:15080 pid:
85 ppid:     2 flags:0x00004000
[   21.633299] Call Trace:
[   21.633301]  ? vprintk_emit+0xab/0x180
[   21.633306]  ? vprintk_emit+0x11a/0x180
[   21.633308]  ? _printk+0x4d/0x69
[   21.633311]  ? __default_send_IPI_shortcut+0x1f/0x40

[ paulmck: Update to new v5.16 task_call_func() name. ]

Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e9f59a88637cf..b3d15600f4fe9 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1134,25 +1134,50 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 	// Any tasks that exit after this point will set ->trc_reader_checked.
 }
 
+/* Communicate task state back to the RCU tasks trace stall warning request. */
+struct trc_stall_chk_rdr {
+	int nesting;
+	int ipi_to_cpu;
+	u8 needqs;
+};
+
+static int trc_check_slow_task(struct task_struct *t, void *arg)
+{
+	struct trc_stall_chk_rdr *trc_rdrp = arg;
+
+	if (task_curr(t))
+		return false; // It is running, so decline to inspect it.
+	trc_rdrp->nesting = READ_ONCE(t->trc_reader_nesting);
+	trc_rdrp->ipi_to_cpu = READ_ONCE(t->trc_ipi_to_cpu);
+	trc_rdrp->needqs = READ_ONCE(t->trc_reader_special.b.need_qs);
+	return true;
+}
+
 /* Show the state of a task stalling the current RCU tasks trace GP. */
 static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 {
 	int cpu;
+	struct trc_stall_chk_rdr trc_rdr;
+	bool is_idle_tsk = is_idle_task(t);
 
 	if (*firstreport) {
 		pr_err("INFO: rcu_tasks_trace detected stalls on tasks:\n");
 		*firstreport = false;
 	}
-	// FIXME: This should attempt to use try_invoke_on_nonrunning_task().
 	cpu = task_cpu(t);
-	pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
-		 t->pid,
-		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) >= 0],
-		 ".i"[is_idle_task(t)],
-		 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
-		 READ_ONCE(t->trc_reader_nesting),
-		 " N"[!!READ_ONCE(t->trc_reader_special.b.need_qs)],
-		 cpu);
+	if (!task_call_func(t, trc_check_slow_task, &trc_rdr))
+		pr_alert("P%d: %c\n",
+			 t->pid,
+			 ".i"[is_idle_tsk]);
+	else
+		pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
+			 t->pid,
+			 ".I"[trc_rdr.ipi_to_cpu >= 0],
+			 ".i"[is_idle_tsk],
+			 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
+			 trc_rdr.nesting,
+			 " N"[!!trc_rdr.needqs],
+			 cpu);
 	sched_show_task(t);
 }
 
-- 
2.31.1.189.g2e36527f23

