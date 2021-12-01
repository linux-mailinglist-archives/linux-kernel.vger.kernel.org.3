Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B1F465158
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350677AbhLAPXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:23:20 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57658 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbhLAPXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:23:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7FF44CE1F4E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164E5C53FCC;
        Wed,  1 Dec 2021 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371995;
        bh=RMGoCFST+KwezpUE7DaCOjBzuh5WAvgw48JOjBy/r6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebUIhRipj3wStSmSz20a3ul3LtnHoBIwo/K6EJotGiUV+7oUV08uNW4xTPsMIJM9x
         QD9vaurKTVey+N7TLotDgYaArmnCQBlfsnKpf4ptsHRMSqmVds4GAeb0TtcAjKd+D4
         dQd3b8ywZygrBmaWJk2sxu0i9zYy/nE0KaTTLk6c5uHmF4Qe/kmFBrZQxgj7pcOYSv
         wxpBLcAcd3/5dkFcHwlfnYsGVWDDHaQyk86EBJahMAfrKXVMHqPSW5p0IIGUn+7E1N
         b172VWpP5D4qIGRKIev5abGZrvsy/7/D+VNs5mcQDwstvQxyuH+jGs7jKDxKDhklC9
         jy6KSWet1ak4g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 1/2] workqueue: Fix unbind_workers() VS wq_worker_running() race
Date:   Wed,  1 Dec 2021 16:19:44 +0100
Message-Id: <20211201151945.632214-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201151945.632214-1-frederic@kernel.org>
References: <20211201151945.632214-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At CPU-hotplug time, unbind_worker() may preempt a worker while it is
waking up. In that case the following scenario can happen:

        unbind_workers()                     wq_worker_running()
        --------------                      -------------------
        	                      if (!(worker->flags & WORKER_NOT_RUNNING))
        	                          //PREEMPTED by unbind_workers
        worker->flags |= WORKER_UNBOUND;
        [...]
        atomic_set(&pool->nr_running, 0);
        //resume to worker
		                              atomic_inc(&worker->pool->nr_running);

After unbind_worker() resets pool->nr_running, the value is expected to
remain 0 until the pool ever gets rebound in case cpu_up() is called on
the target CPU in the future. But here the race leaves pool->nr_running
with a value of 1, triggering the following warning when the worker goes
idle:

	WARNING: CPU: 3 PID: 34 at kernel/workqueue.c:1823 worker_enter_idle+0x95/0xc0
	Modules linked in:
	CPU: 3 PID: 34 Comm: kworker/3:0 Not tainted 5.16.0-rc1+ #34
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
	Workqueue:  0x0 (rcu_par_gp)
	RIP: 0010:worker_enter_idle+0x95/0xc0
	Code: 04 85 f8 ff ff ff 39 c1 7f 09 48 8b 43 50 48 85 c0 74 1b 83 e2 04 75 99 8b 43 34 39 43 30 75 91 8b 83 00 03 00 00 85 c0 74 87 <0f> 0b 5b c3 48 8b 35 70 f1 37 01 48 8d 7b 48 48 81 c6 e0 93  0
	RSP: 0000:ffff9b7680277ed0 EFLAGS: 00010086
	RAX: 00000000ffffffff RBX: ffff93465eae9c00 RCX: 0000000000000000
	RDX: 0000000000000000 RSI: ffff9346418a0000 RDI: ffff934641057140
	RBP: ffff934641057170 R08: 0000000000000001 R09: ffff9346418a0080
	R10: ffff9b768027fdf0 R11: 0000000000002400 R12: ffff93465eae9c20
	R13: ffff93465eae9c20 R14: ffff93465eae9c70 R15: ffff934641057140
	FS:  0000000000000000(0000) GS:ffff93465eac0000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 0000000000000000 CR3: 000000001cc0c000 CR4: 00000000000006e0
	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	Call Trace:
	  <TASK>
	  worker_thread+0x89/0x3d0
	  ? process_one_work+0x400/0x400
	  kthread+0x162/0x190
	  ? set_kthread_struct+0x40/0x40
	  ret_from_fork+0x22/0x30
	  </TASK>

Also due to this incorrect "nr_running == 1", further queued work may
end up not being served, because no worker is awaken at work insert time.
This raises rcutorture writer stalls for example.

Fix this with disabling preemption in the right place in
wq_worker_running().

It's worth noting that if the worker migrates and runs concurrently with
unbind_workers(), it is guaranteed to see the WORKER_UNBOUND flag update
due to set_cpus_allowed_ptr() acquiring/releasing rq->lock.

Fixes: 6d25be5782e4 ("sched/core, workqueues: Distangle worker accounting from rq lock")
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/workqueue.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 332361cf215f..5094573e8b45 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -868,8 +868,17 @@ void wq_worker_running(struct task_struct *task)
 
 	if (!worker->sleeping)
 		return;
+
+	/*
+	 * If preempted by unbind_workers() between the WORKER_NOT_RUNNING check
+	 * and the nr_running increment below, we may ruin the nr_running reset
+	 * and leave with an unexpected pool->nr_running == 1 on the newly unbound
+	 * pool. Protect against such race.
+	 */
+	preempt_disable();
 	if (!(worker->flags & WORKER_NOT_RUNNING))
 		atomic_inc(&worker->pool->nr_running);
+	preempt_enable();
 	worker->sleeping = 0;
 }
 
-- 
2.25.1

