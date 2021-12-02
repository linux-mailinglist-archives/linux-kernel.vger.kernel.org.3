Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05D0465B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354806AbhLBAoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354684AbhLBAms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E2C06175E;
        Wed,  1 Dec 2021 16:39:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20065B821AA;
        Thu,  2 Dec 2021 00:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2670DC58336;
        Thu,  2 Dec 2021 00:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405541;
        bh=rfme3z2tPZe5A5xdacykD7wfiYb3HjKaoqKcbyxcwPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fg8wnFXwavy/Yu0HhJK2JuIoiV8liqexB3nfThCdWwmMyTKqr9R3AD0EkkmqNWW3P
         nF4UnMZcNuymaUPUQ1khceguYs+hOSG0YxqgteVdgi4/ucHaxGVNUKEiFNbCbZJlXN
         cQiis9EcnAGXqBHclF66hkaUXYU1zrIBpU9cUG3s4D+oBVJYz2FqWuTIhck4qg1Fvj
         x2g9Bpwf9Wv6SmQnlZDN3LpGCAKOw/nqY82l+CAMswzfdeTjk0F7FBpkEi3rF/c2E/
         EcpvErxt6G3Aw8GGifAsCnumeBa+YzalatJkLIemQ2N2Cafx91yiTwrEthYOhKBkw0
         4OC1RnWCRespg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6120E5C134A; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>, Martin Lau <kafai@fb.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 16/18] rcu-tasks: Use more callback queues if contention encountered
Date:   Wed,  1 Dec 2021 16:38:56 -0800
Message-Id: <20211202003858.3129628-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcupdate.rcu_task_enqueue_lim module parameter allows system
administrators to tune the number of callback queues used by the RCU
Tasks flavors.  However if callback storms are infrequent, it would
be better to operate with a single queue on a given system unless and
until that system actually needed more queues.  Systems not needing
more queues can then avoid the overhead of checking the extra queues
and especially avoid the overhead of fanning workqueue handlers out to
all CPUs to invoke callbacks.

This commit therefore switches to using all the CPUs' callback queues if
call_rcu_tasks_generic() encounters too much lock contention.  The amount
of lock contention to tolerate defaults to 100 contended lock acquisitions
per jiffy, and can be adjusted using the new rcupdate.rcu_task_contend_lim
module parameter.

Such switching is undertaken only if the rcupdate.rcu_task_enqueue_lim
module parameter is negative, which is its default value (-1).
This allows savvy systems administrators to set the number of queues
to some known good value and to not have to worry about the kernel doing
any second guessing.

[ paulmck: Apply feedback from Guillaume Tucker and kernelci. ]

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++++
 kernel/rcu/tasks.h                            | 27 ++++++++++++++++---
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9b09fc5dfe665..089f4c5f8225b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4805,6 +4805,14 @@
 			period to instead use normal non-expedited
 			grace-period processing.
 
+	rcupdate.rcu_task_contend_lim= [KNL]
+			Set the minimum number of callback-queuing-time
+			lock-contention events per jiffy required to
+			cause the RCU Tasks flavors to switch to per-CPU
+			callback queuing.  This switching only occurs
+			when rcupdate.rcu_task_enqueue_lim is set to
+			the default value of -1.
+
 	rcupdate.rcu_task_enqueue_lim= [KNL]
 			Set the number of callback queues to use for the
 			RCU Tasks family of RCU flavors.  The default
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 652f51eec5f34..1695da0f6985e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -142,6 +142,10 @@ module_param(rcu_task_stall_timeout, int, 0644);
 static int rcu_task_enqueue_lim __read_mostly = -1;
 module_param(rcu_task_enqueue_lim, int, 0444);
 
+static bool rcu_task_cb_adjust;
+static int rcu_task_contend_lim __read_mostly = 100;
+module_param(rcu_task_contend_lim, int, 0444);
+
 /* RCU tasks grace-period state for debugging. */
 #define RTGS_INIT		 0
 #define RTGS_WAIT_WAIT_CBS	 1
@@ -207,10 +211,13 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	int lim;
 
 	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
-	if (rcu_task_enqueue_lim < 0)
-		rcu_task_enqueue_lim = nr_cpu_ids;
-	else if (rcu_task_enqueue_lim == 0)
+	if (rcu_task_enqueue_lim < 0) {
+		rcu_task_enqueue_lim = 1;
+		rcu_task_cb_adjust = true;
+		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
+	} else if (rcu_task_enqueue_lim == 0) {
 		rcu_task_enqueue_lim = 1;
+	}
 	lim = rcu_task_enqueue_lim;
 
 	if (lim > nr_cpu_ids)
@@ -251,6 +258,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 {
 	unsigned long flags;
 	unsigned long j;
+	bool needadjust = false;
 	bool needwake;
 	struct rcu_tasks_percpu *rtpcp;
 
@@ -266,7 +274,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 			rtpcp->rtp_jiffies = j;
 			rtpcp->rtp_n_lock_retries = 0;
 		}
-		rtpcp->rtp_n_lock_retries++;
+		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
+		    READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
+			needadjust = true;  // Defer adjustment to avoid deadlock.
 	}
 	if (!rcu_segcblist_is_enabled(&rtpcp->cblist)) {
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
@@ -276,6 +286,15 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	needwake = rcu_segcblist_empty(&rtpcp->cblist);
 	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	if (unlikely(needadjust)) {
+		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
+		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
+			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids));
+			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
+			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
+		}
+		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+	}
 	/* We can't create the thread unless interrupts are enabled. */
 	if (needwake && READ_ONCE(rtp->kthread_ptr)) {
 		irq_work_queue(&rtpcp->rtp_irq_work);
-- 
2.31.1.189.g2e36527f23

