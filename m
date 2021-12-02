Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A603465B20
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354855AbhLBApA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354671AbhLBAms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C00C06175D;
        Wed,  1 Dec 2021 16:39:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 791BDCE2140;
        Thu,  2 Dec 2021 00:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02018C58333;
        Thu,  2 Dec 2021 00:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405541;
        bh=9xOSk3gYZu1N5WP5WvuyaDDXPeakndsyQwP0MNyBGBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mb9q/RQlbQjcGup18+46zzYDzFatq3LpvCB10rkPu+3BKYxueVMyIMfpqtEgq+3n+
         4OS5TWB6YXN9jam3GgjHCxfZbV/IfpEsRF6f2GH9R11cB87rISDEWYEVruHEhu/RNQ
         vhOX0QdgWJHJyB2gD22Uef6emUfsFkAQJrhj1BiHpgK81Udyj+J1toD0E1tBH/Y+qw
         MCXmNOQlkm79xtgX+us5r36+3QyOU/vhYgnKG/GUPWElFowu5O9W1nFRTWuEoSP7N+
         1o8e69I4eXm7e1VtD2J2tqZuZII29Kc75yGcIbr2t1mYr5bsFQWaJmpwszVVJYtVPR
         IvBdWW6YKgYHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5F42F5C1349; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 15/18] rcu-tasks: Avoid raw-spinlocked wakeups from call_rcu_tasks_generic()
Date:   Wed,  1 Dec 2021 16:38:55 -0800
Message-Id: <20211202003858.3129628-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the caller of of call_rcu_tasks(), call_rcu_tasks_rude(),
or call_rcu_tasks_trace() holds a raw spinlock, and then if
call_rcu_tasks_generic() determines that the grace-period kthread must
be awakened, then the wakeup might acquire a normal spinlock while a
raw spinlock is held.  This results in lockdep splats when the
kernel is built with CONFIG_PROVE_RAW_LOCK_NESTING=y.

This commit therefore defers the wakeup using irq_work_queue().

It would be nice to directly invoke wakeup when a raw spinlock is not
held, but there is currently no way to check for this in all kernels.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3f25022a0db9a..652f51eec5f34 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -27,6 +27,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtp_jiffies: Jiffies counter value for statistics.
  * @rtp_n_lock_retries: Rough lock-contention statistic.
  * @rtp_work: Work queue for invoking callbacks.
+ * @rtp_irq_work: IRQ work queue for deferred wakeups.
  * @barrier_q_head: RCU callback for barrier operation.
  * @cpu: CPU number corresponding to this entry.
  * @rtpp: Pointer to the rcu_tasks structure.
@@ -37,6 +38,7 @@ struct rcu_tasks_percpu {
 	unsigned long rtp_jiffies;
 	unsigned long rtp_n_lock_retries;
 	struct work_struct rtp_work;
+	struct irq_work rtp_irq_work;
 	struct rcu_head barrier_q_head;
 	int cpu;
 	struct rcu_tasks *rtpp;
@@ -102,9 +104,12 @@ struct rcu_tasks {
 	char *kname;
 };
 
+static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
+
 #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
 static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
+	.rtp_irq_work = IRQ_WORK_INIT(call_rcu_tasks_iw_wakeup),			\
 };											\
 static struct rcu_tasks rt_name =							\
 {											\
@@ -230,6 +235,16 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
 }
 
+// IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
+static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
+{
+	struct rcu_tasks *rtp;
+	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct rcu_tasks_percpu, rtp_irq_work);
+
+	rtp = rtpcp->rtpp;
+	wake_up(&rtp->cbs_wq);
+}
+
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
@@ -262,8 +277,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	/* We can't create the thread unless interrupts are enabled. */
-	if (needwake && READ_ONCE(rtp->kthread_ptr))
-		wake_up(&rtp->cbs_wq);
+	if (needwake && READ_ONCE(rtp->kthread_ptr)) {
+		irq_work_queue(&rtpcp->rtp_irq_work);
+	}
 }
 
 // Wait for a grace period for the specified flavor of Tasks RCU.
-- 
2.31.1.189.g2e36527f23

