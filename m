Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E935465B36
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354927AbhLBArm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:47:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39230 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344454AbhLBArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCB4EB8219F;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175FCC5833E;
        Thu,  2 Dec 2021 00:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405819;
        bh=nSMcJ7P6z5FVnG87SuhC7T5E4DdHulUKBzzezc0fpE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjpQT98D/1hY0jNjK98guEEYZl9KMYGF2piRqI8ttLcaSsYGCQYT55XPhOymP5pCc
         6zqDYVAPsxK3wyD0SUN8RSxybRsUF5e/Exm3MFylTfyAT1sGmSRtiCu4YvQWOvqJgg
         lQRqAOL1oRwD/vofRmhfZg9Qw9kIGCnZ+uz76gs2vt2ml1gUgK/Ep6jqDXPDs684Ku
         /ghMZdFLSvBYGoGQ0aP7L7DH9kpJ/wXQ6C3lttCVgEUK6iJ8v1hs49/aQU2PMbxhA7
         mCRO39ksDej0zSbWUmb9RBby2vfUei9hZotRjX3+wujYr5RMdUvTVwUeOHUPtUeVep
         fNdsIQyeeUubA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 642935C134A; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 16/17] rcutorture: Add ability to limit callback-flood intensity
Date:   Wed,  1 Dec 2021 16:43:35 -0800
Message-Id: <20211202004337.3130175-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU tasks flavors of RCU now need concurrent callback flooding to
test their ability to switch between single-queue mode and per-CPU queue
mode, but their lack of heavy-duty forward-progress features rules out
the use of rcutorture's current callback-flooding code.  This commit
therefore provides the ability to limit the intensity of the callback
floods using a new ->cbflood_max field in the rcu_operations structure.
When this field is zero, there is no limit, otherwise, each callback-flood
kthread allocates at most ->cbflood_max callbacks.

Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9390f867ba6cc..1e8360d159200 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -348,6 +348,7 @@ struct rcu_torture_ops {
 	void (*gp_kthread_dbg)(void);
 	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
 	int (*stall_dur)(void);
+	long cbflood_max;
 	int irq_capable;
 	int can_boost;
 	int extendables;
@@ -841,6 +842,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.call		= call_rcu_tasks_rude,
 	.cb_barrier	= rcu_barrier_tasks_rude,
 	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
+	.cbflood_max	= 50000,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -881,6 +883,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
 	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
+	.cbflood_max	= 50000,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -2387,7 +2390,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 			rfp->rcu_fwd_cb_head = rfcpn;
 			n_launders++;
 			n_launders_sa++;
-		} else {
+		} else if (!cur_ops->cbflood_max || cur_ops->cbflood_max > n_max_cbs) {
 			rfcp = kmalloc(sizeof(*rfcp), GFP_KERNEL);
 			if (WARN_ON_ONCE(!rfcp)) {
 				schedule_timeout_interruptible(1);
@@ -2397,8 +2400,11 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 			n_launders_sa = 0;
 			rfcp->rfc_gps = 0;
 			rfcp->rfc_rfp = rfp;
+		} else {
+			rfcp = NULL;
 		}
-		cur_ops->call(&rfcp->rh, rcu_torture_fwd_cb_cr);
+		if (rfcp)
+			cur_ops->call(&rfcp->rh, rcu_torture_fwd_cb_cr);
 		rcu_torture_fwd_prog_cond_resched(n_launders + n_max_cbs);
 		if (tick_nohz_full_enabled()) {
 			local_irq_save(flags);
@@ -2506,8 +2512,10 @@ static int rcu_torture_fwd_prog(void *args)
 		pr_alert("%s: Starting forward-progress test %d\n", __func__, rfp->rcu_fwd_id);
 		if (rcu_inkernel_boot_has_ended() && torture_num_online_cpus() > rfp->rcu_fwd_id)
 			rcu_torture_fwd_prog_cr(rfp);
-		if (!IS_ENABLED(CONFIG_TINY_RCU) ||
-		    (rcu_inkernel_boot_has_ended() && torture_num_online_cpus() > rfp->rcu_fwd_id))
+		if ((cur_ops->stall_dur && cur_ops->stall_dur() > 0) &&
+		    (!IS_ENABLED(CONFIG_TINY_RCU) ||
+		     (rcu_inkernel_boot_has_ended() &&
+		      torture_num_online_cpus() > rfp->rcu_fwd_id)))
 			rcu_torture_fwd_prog_nr(rfp, &tested, &tested_tries);
 
 		/* Avoid slow periods, better to test when busy. */
@@ -2539,7 +2547,8 @@ static int __init rcu_torture_fwd_prog_init(void)
 		fwd_progress = nr_cpu_ids;
 	}
 	if ((!cur_ops->sync && !cur_ops->call) ||
-	    !cur_ops->stall_dur || cur_ops->stall_dur() <= 0 || cur_ops == &rcu_busted_ops) {
+	    (!cur_ops->cbflood_max && (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0)) ||
+	    cur_ops == &rcu_busted_ops) {
 		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
 		fwd_progress = 0;
 		return 0;
-- 
2.31.1.189.g2e36527f23

