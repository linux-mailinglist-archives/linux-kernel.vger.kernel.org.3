Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56CF48D05C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiAMCPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:15:43 -0500
Received: from ec2-13-52-33-57.us-west-1.compute.amazonaws.com ([13.52.33.57]:11533
        "EHLO aurora.tech" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231528AbiAMCPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:15:42 -0500
Received: by aurora.tech (Postfix, from userid 1001)
        id 16EBF16402F4; Tue, 11 Jan 2022 15:33:17 -0800 (PST)
From:   Alison Chaiken <achaiken@aurora.tech>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, paulmck@kernel.org,
        valentin.schneider@arm.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, glenn@aurora.tech,
        alison@she-devel.com, Alison Chaiken <achaiken@aurora.tech>
Subject: [PATCH 1/4] RCU: move kthread_prio bounds-check to a separate function
Date:   Tue, 11 Jan 2022 15:32:50 -0800
Message-Id: <20220111233253.21692-2-achaiken@aurora.tech>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111233253.21692-1-achaiken@aurora.tech>
References: <20220111233253.21692-1-achaiken@aurora.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the bounds-check of the kthread_prio cmdline parameter to a new
function in order to faciliate a different callsite.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/rcu/tree.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9a04550cc54b..15cabb288a1c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4404,26 +4404,10 @@ static int rcu_pm_notify(struct notifier_block *self,
 static int __init rcu_spawn_gp_kthread(void)
 {
 	unsigned long flags;
-	int kthread_prio_in = kthread_prio;
 	struct rcu_node *rnp;
 	struct sched_param sp;
 	struct task_struct *t;
 
-	/* Force priority into range. */
-	if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 2
-	    && IS_BUILTIN(CONFIG_RCU_TORTURE_TEST))
-		kthread_prio = 2;
-	else if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 1)
-		kthread_prio = 1;
-	else if (kthread_prio < 0)
-		kthread_prio = 0;
-	else if (kthread_prio > 99)
-		kthread_prio = 99;
-
-	if (kthread_prio != kthread_prio_in)
-		pr_alert("rcu_spawn_gp_kthread(): Limited prio to %d from %d\n",
-			 kthread_prio, kthread_prio_in);
-
 	rcu_scheduler_fully_active = 1;
 	t = kthread_create(rcu_gp_kthread, NULL, "%s", rcu_state.name);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start grace-period kthread, OOM is now expected behavior\n", __func__))
@@ -4548,6 +4532,28 @@ static void __init rcu_init_one(void)
 	}
 }
 
+/*
+ * Force priority from the kernel command-line into range.
+ */
+static void __init sanitize_kthread_prio(void)
+{
+	int kthread_prio_in = kthread_prio;
+
+	if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 2
+	    && IS_BUILTIN(CONFIG_RCU_TORTURE_TEST))
+		kthread_prio = 2;
+	else if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 1)
+		kthread_prio = 1;
+	else if (kthread_prio < 0)
+		kthread_prio = 0;
+	else if (kthread_prio > 99)
+		kthread_prio = 99;
+
+	if (kthread_prio != kthread_prio_in)
+		pr_alert("%s: Limited prio to %d from %d\n",
+			 __func__, kthread_prio, kthread_prio_in);
+}
+
 /*
  * Compute the rcu_node tree geometry from kernel parameters.  This cannot
  * replace the definitions in tree.h because those are needed to size
@@ -4708,6 +4714,7 @@ void __init rcu_init(void)
 
 	kfree_rcu_batch_init();
 	rcu_bootup_announce();
+	sanitize_kthread_prio();
 	rcu_init_geometry();
 	rcu_init_one();
 	if (dump_tree)
-- 
2.32.0

