Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4E465B1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbhLBAoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354685AbhLBAms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D81C06175F;
        Wed,  1 Dec 2021 16:39:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA0F7B821A9;
        Thu,  2 Dec 2021 00:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF56C5832C;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405541;
        bh=h8iaD/wlGz/273V4BxOmkQQ3yT5O6Zer8M++4yK6NEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcJk+MfaefPuC6EAnuGYLbFLsx01vtc4HNApDNMixcCVUXMHAosL1MeSyqY0jpuGN
         iC+Fv7GWlGiUYiNCQPCUuBu4jtbanVZiWUoIFvQTeXrey6BFU4URDWloMN4cKBiapY
         hSeDwCsM7exP9mm2Zuek/j/cVc0hRL3LV3C/EoDj7qXPxxqaZTAJYOLfKKGt98em48
         BPB/Swo8sJP0wsfGxccdAh3+8tOoGkplFS0nr4fo0u88Ic1TG7J1Er/14dbFNTHKcP
         d7eea/HomZuaRlu8uTJOl67Ql+1hg7SrsFmdxwfVbJo2EUh+ax+SEEdqFi4ySTtshC
         uZZplwUEhu36g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B9EC5C12FE; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 13/18] rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set initial queueing
Date:   Wed,  1 Dec 2021 16:38:53 -0800
Message-Id: <20211202003858.3129628-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a rcupdate.rcu_task_enqueue_lim module parameter that
sets the initial number of callback queues to use for the RCU Tasks
family of RCU implementations.  This paramter allows testing of various
fanout values.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++++
 kernel/rcu/tasks.h                            | 24 ++++++++++++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c546a0d46..9b09fc5dfe665 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4805,6 +4805,13 @@
 			period to instead use normal non-expedited
 			grace-period processing.
 
+	rcupdate.rcu_task_enqueue_lim= [KNL]
+			Set the number of callback queues to use for the
+			RCU Tasks family of RCU flavors.  The default
+			of -1 allows this to be automatically (and
+			dynamically) adjusted.	This parameter is intended
+			for use in testing.
+
 	rcupdate.rcu_task_ipi_delay= [KNL]
 			Set time in jiffies during which RCU tasks will
 			avoid sending IPIs, starting with the beginning
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 61a606569868b..2b148f6743150 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -130,6 +130,9 @@ module_param(rcu_task_ipi_delay, int, 0644);
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
 module_param(rcu_task_stall_timeout, int, 0644);
 
+static int rcu_task_enqueue_lim __read_mostly = -1;
+module_param(rcu_task_enqueue_lim, int, 0444);
+
 /* RCU tasks grace-period state for debugging. */
 #define RTGS_INIT		 0
 #define RTGS_WAIT_WAIT_CBS	 1
@@ -192,10 +195,19 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 {
 	int cpu;
 	unsigned long flags;
+	int lim;
 
 	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
-	rtp->percpu_enqueue_shift = ilog2(nr_cpu_ids);
-	rtp->percpu_enqueue_lim = 1;
+	if (rcu_task_enqueue_lim < 0)
+		rcu_task_enqueue_lim = nr_cpu_ids;
+	else if (rcu_task_enqueue_lim == 0)
+		rcu_task_enqueue_lim = 1;
+	lim = rcu_task_enqueue_lim;
+
+	if (lim > nr_cpu_ids)
+		lim = nr_cpu_ids;
+	WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids / lim));
+	smp_store_release(&rtp->percpu_enqueue_lim, lim);
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
@@ -211,7 +223,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
-
+	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
 }
 
 // Enqueue a callback for the specified flavor of Tasks RCU.
@@ -307,7 +319,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	unsigned long flags;
 	int needgpcb = 0;
 
-	for (cpu = 0; cpu < rtp->percpu_enqueue_lim; cpu++) {
+	for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_enqueue_lim); cpu++) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 		/* Advance and accelerate any new callbacks. */
@@ -339,11 +351,11 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 
 	cpu = rtpcp->cpu;
 	cpunext = cpu * 2 + 1;
-	if (cpunext < rtp->percpu_enqueue_lim) {
+	if (cpunext < smp_load_acquire(&rtp->percpu_enqueue_lim)) {
 		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
 		queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
 		cpunext++;
-		if (cpunext < rtp->percpu_enqueue_lim) {
+		if (cpunext < smp_load_acquire(&rtp->percpu_enqueue_lim)) {
 			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
 			queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
 		}
-- 
2.31.1.189.g2e36527f23

