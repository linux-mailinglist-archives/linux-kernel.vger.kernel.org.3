Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037DF4AA44F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378184AbiBDXYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346197AbiBDXYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:24:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB06DFC13FC;
        Fri,  4 Feb 2022 15:24:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BB447CE24C2;
        Fri,  4 Feb 2022 23:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A1CC36AE2;
        Fri,  4 Feb 2022 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017048;
        bh=2W4MLM7m8I6vA/YIMpHFfSjn+OnxWplMJIEA37I40k8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=flUuBFwvI4fLaQDspE1Sab5DOwLJiY5hHXQnfrf7d7Nxfx6oAY5dMvW2eY6p23hZk
         7ed3S1kFjkaU/Qom8jYy0zwgtg7u/anfmWCE3Yy7WdSSN4dak2RjV4CK45U+X2pbDs
         5G2lkbVPr/TXXccd/pFZ1GJC3OyV3MLZEvnlCeY1zixz1oB1GpSRoeJyEQDvxYi3a0
         QScKepFutglBWAvqtbMEYeJdQdaNSoVXfPA8PSxpQWH/TrokdwK0tNknzCaj1MBxaQ
         fKyhy0xEaSLYabrVehm/BfRw5t7DfWJtD6rK5+q6sEFmCxvb071jEkyvDYTYs9OQTF
         zD59ojt8CWZlw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C76395C0992; Fri,  4 Feb 2022 15:24:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Alison Chaiken <achaiken@aurora.tech>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/10] rcu: Move kthread_prio bounds-check to a separate function
Date:   Fri,  4 Feb 2022 15:24:01 -0800
Message-Id: <20220204232406.814-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

Move the bounds-check of the kthread_prio cmdline parameter to a new
function in order to faciliate a different callsite.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4e5e37e5ee3c9..5bf0312f66760 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4440,26 +4440,10 @@ static int rcu_pm_notify(struct notifier_block *self,
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
@@ -4584,6 +4568,28 @@ static void __init rcu_init_one(void)
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
@@ -4744,6 +4750,7 @@ void __init rcu_init(void)
 
 	kfree_rcu_batch_init();
 	rcu_bootup_announce();
+	sanitize_kthread_prio();
 	rcu_init_geometry();
 	rcu_init_one();
 	if (dump_tree)
-- 
2.31.1.189.g2e36527f23

