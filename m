Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952184628D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhK3AJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhK3AJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:09:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556BDC061714
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:06:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7462ACE13DE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 00:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A9FC53FAD;
        Tue, 30 Nov 2021 00:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638230781;
        bh=mFV7t5eNBthj0/Acs1XWZNXlo5r/Sm9J9tNYiSy90yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toQfkKj9RIQjkYp291G7B7VLO0V475ILb6WGZZDH0Brjn8vwXhQE6xU1oqYtHYeb9
         YlouNnBUhL4xVhHp2wL0lBxQCVQ4R/baTTH4Kt4JITpBGnt+7ZmnUowNST/YClyBIQ
         9hyPFum8tfISyfo/Mnrnywx/ts7yVrLnhxZ1to38L/lImqf2XJKfu9xHvy+2J+H9DU
         MndfIN/J+49JuHZM7mFwD8MQm8kvs3VPXS3sBj6zI4ocUkOj86KNgLIeBt15pBNfnP
         r5Ove6v4otoIF2Oz0BqxRlajxtE+Yp/EamKHXLd5EKJdoXqw96SH7PMj0LGk4jxWiL
         NQfWJYTg4R1ag==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [RFC PATCH 1/2] workqueue: Fix unbind_workers() VS wq_worker_running() race
Date:   Tue, 30 Nov 2021 01:06:11 +0100
Message-Id: <20211130000612.591368-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130000612.591368-1-frederic@kernel.org>
References: <20211130000612.591368-1-frederic@kernel.org>
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

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
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

