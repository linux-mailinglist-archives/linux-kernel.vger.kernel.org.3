Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA36C465AA0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354286AbhLBAYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354214AbhLBAYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:24:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0D8C061756;
        Wed,  1 Dec 2021 16:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25737B8219B;
        Thu,  2 Dec 2021 00:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E71C53FCC;
        Thu,  2 Dec 2021 00:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404456;
        bh=m+lQmJUj1qQ/xcdX/Rab01HKQg/sXpjZsaBg8r8Q+WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bn/XZCBfbjQjer4l6Y3rKHZbs2QY3hbBRzJfnJSV1OBFUOahVlgBMIcqMWC802y1t
         nadzyQS2rrlAHzpRioG1wFZdh/XBcN71UuEJma/L9ndHog1Cqmhqamp/t7sKvNgRmN
         ezUcMYWVx0bZVC12ZYIHHQSfuEwbKgTjgvvmkG3saHqmG1ScahgXVxyOW7aEErVhyU
         zZ0kyyUEdQKHnUbk68xyVt3Ym+SiGbQ5d0j6vHlVNxalPZI5Kz3dnGhFmqvVge+8wx
         ru72V+9MiW3AfZiwNry1KnTQ1DXAB9EAyuBrAbLPK/E1JcJTBxmCDfXnu9qncedcca
         1+CgzQcbQPmjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 83F9E5C1109; Wed,  1 Dec 2021 16:20:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/6] rcu: Improve tree_plugin.h comments and add code cleanups
Date:   Wed,  1 Dec 2021 16:20:52 -0800
Message-Id: <20211202002055.3127133-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

This commit cleans up some comments and code in kernel/rcu/tree_plugin.h.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 599084c4c21fd..f44580276fbdc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -16,7 +16,7 @@
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 {
 	/*
-	 * In order to read the offloaded state of an rdp is a safe
+	 * In order to read the offloaded state of an rdp in a safe
 	 * and stable way and prevent from its value to be changed
 	 * under us, we must either hold the barrier mutex, the cpu
 	 * hotplug lock (read or write) or the nocb lock. Local
@@ -56,7 +56,7 @@ static void __init rcu_bootup_announce_oddness(void)
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
 		pr_info("\tRCU lockdep checking is enabled.\n");
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
-		pr_info("\tRCU strict (and thus non-scalable) grace periods enabled.\n");
+		pr_info("\tRCU strict (and thus non-scalable) grace periods are enabled.\n");
 	if (RCU_NUM_LVLS >= 4)
 		pr_info("\tFour(or more)-level hierarchy is enabled.\n");
 	if (RCU_FANOUT_LEAF != 16)
@@ -88,13 +88,13 @@ static void __init rcu_bootup_announce_oddness(void)
 	if (rcu_kick_kthreads)
 		pr_info("\tKick kthreads if too-long grace period.\n");
 	if (IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD))
-		pr_info("\tRCU callback double-/use-after-free debug enabled.\n");
+		pr_info("\tRCU callback double-/use-after-free debug is enabled.\n");
 	if (gp_preinit_delay)
 		pr_info("\tRCU debug GP pre-init slowdown %d jiffies.\n", gp_preinit_delay);
 	if (gp_init_delay)
 		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
 	if (gp_cleanup_delay)
-		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_cleanup_delay);
+		pr_info("\tRCU debug GP cleanup slowdown %d jiffies.\n", gp_cleanup_delay);
 	if (!use_softirq)
 		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
 	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
@@ -1153,7 +1153,6 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
 /*
  * Create an RCU-boost kthread for the specified node if one does not
  * already exist.  We only create this kthread for preemptible RCU.
- * Returns zero if all is well, a negated errno otherwise.
  */
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
@@ -1455,7 +1454,7 @@ static void rcu_cleanup_after_idle(void)
  * CPU unless the grace period has extended for too long.
  *
  * This code relies on the fact that all NO_HZ_FULL CPUs are also
- * CONFIG_RCU_NOCB_CPU CPUs.
+ * RCU_NOCB_CPU CPUs.
  */
 static bool rcu_nohz_full_cpu(void)
 {
-- 
2.31.1.189.g2e36527f23

