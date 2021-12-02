Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBBC465ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354476AbhLBAe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354320AbhLBAcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442A2C061759;
        Wed,  1 Dec 2021 16:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83DF8CE2146;
        Thu,  2 Dec 2021 00:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9F6C58339;
        Thu,  2 Dec 2021 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404955;
        bh=ZjKmJJlETmOFDExkKIrDiHC63737vzU73zR5NOaeV7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXiZ/dVOhBhQvRsIaA8Wn9eSjAiXeknMcB24IoDS8GyPzTJYPHzJgzm53hPZ7kRlZ
         PQDSstHkMxfk6WaScb7XzHnnztXV2ICcXQ50l3Fr4vLhiNG6r/tvHmHpnVrk4SY4Jo
         XmMQwoesR7CXYuMx5K2L2eTIB6C/MfeofmyJrR8vPSjkIx/Kf12FXnjLnJMafE81W3
         2jcMvPVstyQs1mXqC+q8vtgtRxspyq8TZByL5sGyepKTXd91dXQ0KErRkjNEW6rHUB
         g0igQbDgFL0A8Sx+9oO8mkz+fHt0ff4j9+tli736feE+A+SUKVcqJNvHKufwfFQkrx
         GWyv4f/0r/qeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7A97D5C1495; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 15/18] rcu/nocb: Optimize kthreads and rdp initialization
Date:   Wed,  1 Dec 2021 16:29:09 -0800
Message-Id: <20211202002912.3127710-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Currently cpumask_available() is used to prevent from unwanted NOCB
initialization.  However if neither "rcu_nocbs=" nor "nohz_full="
parameters are passed to a kernel built with CONFIG_CPUMASK_OFFSTACK=n,
the initialization path is still taken, running through all sorts of
needless operations and iterations on an empty cpumask.

Fix this by relying on a real initialization state instead.  This also
optimizes kthread creation, preventing needless iteration over all online
CPUs when the kernel is booted without any offloaded CPUs.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index cd596cf4ee79a..42092de677054 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -60,6 +60,9 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
  * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
  * If the list is invalid, a warning is emitted and all CPUs are offloaded.
  */
+
+static bool rcu_nocb_is_setup;
+
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
@@ -67,6 +70,7 @@ static int __init rcu_nocb_setup(char *str)
 		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
 		cpumask_setall(rcu_nocb_mask);
 	}
+	rcu_nocb_is_setup = true;
 	return 1;
 }
 __setup("rcu_nocbs=", rcu_nocb_setup);
@@ -1167,13 +1171,17 @@ void __init rcu_init_nohz(void)
 		need_rcu_nocb_mask = true;
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
-	if (!cpumask_available(rcu_nocb_mask) && need_rcu_nocb_mask) {
-		if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
-			pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
-			return;
+	if (need_rcu_nocb_mask) {
+		if (!cpumask_available(rcu_nocb_mask)) {
+			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
+				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
+				return;
+			}
 		}
+		rcu_nocb_is_setup = true;
 	}
-	if (!cpumask_available(rcu_nocb_mask))
+
+	if (!rcu_nocb_is_setup)
 		return;
 
 #if defined(CONFIG_NO_HZ_FULL)
@@ -1275,8 +1283,10 @@ static void __init rcu_spawn_nocb_kthreads(void)
 {
 	int cpu;
 
-	for_each_online_cpu(cpu)
-		rcu_spawn_cpu_nocb_kthread(cpu);
+	if (rcu_nocb_is_setup) {
+		for_each_online_cpu(cpu)
+			rcu_spawn_cpu_nocb_kthread(cpu);
+	}
 }
 
 /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
-- 
2.31.1.189.g2e36527f23

