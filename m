Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C044B8CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiBPPmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:42:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiBPPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:42:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C559A9A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:42:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FC2661899
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEFCC340F1;
        Wed, 16 Feb 2022 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026137;
        bh=8+SlU7r8WAJmX5jNCV3E4luagGnB16N6dk5c/+4swoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwQZ+eevSUosmgfHtAamiyR/6lH+C3ob1Qu9qWJ7biBuyPRRZPc4qzw5e0chgMIWS
         De3AV1NclV9Chzz7Gs91GF5H0B0jsopNVpYWLXOrzRLGPKG1Q6ZYSqLYxlh3nTH9WO
         13KqxiqwHvmqDOnN4kewIMdkHnD3QyJSYKsn7giHfKR+SD0x4sLFpNniUbszXM4x9x
         xVsE9ShLmjOQ/Jf2kkI0AduomBe430g5P66nPUCRw7r/sZyJ3WRY42Og7ZvMNaB/7b
         tHEUQ5Cson1b7PKlp28DHueYrx3BdCBJd1pik8PORAo9M7xNt+MeA0BNCeXcxR95MM
         dTOWYPZvaw/qw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/5] rcu/nocb: Move rcu_nocb_is_setup to rcu_state
Date:   Wed, 16 Feb 2022 16:42:05 +0100
Message-Id: <20220216154208.696069-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216154208.696069-1-frederic@kernel.org>
References: <20220216154208.696069-1-frederic@kernel.org>
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

In order to avoid scattering the global RCU states, move the RCU nocb
initialization witness within rcu_state.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h | 15 ++++++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 19fc9acce3ce..735fc410d76a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -368,6 +368,7 @@ struct rcu_state {
 	arch_spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
+	int nocb_is_setup;			/* nocb is setup from boot */
 };
 
 /* Values for rcu_state structure's gp_flags field. */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 02e1d05a11fc..494e65445773 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -60,9 +60,6 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
  * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
  * If the list is invalid, a warning is emitted and all CPUs are offloaded.
  */
-
-static bool rcu_nocb_is_setup;
-
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
@@ -72,7 +69,7 @@ static int __init rcu_nocb_setup(char *str)
 			cpumask_setall(rcu_nocb_mask);
 		}
 	}
-	rcu_nocb_is_setup = true;
+	rcu_state.nocb_is_setup = true;
 	return 1;
 }
 __setup("rcu_nocbs", rcu_nocb_setup);
@@ -1165,17 +1162,17 @@ void __init rcu_init_nohz(void)
 		need_rcu_nocb_mask = true;
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
-	if (need_rcu_nocb_mask) {
+	if (rcu_state.nocb_is_setup) {
 		if (!cpumask_available(rcu_nocb_mask)) {
 			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
 				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
 				return;
 			}
 		}
-		rcu_nocb_is_setup = true;
+		rcu_state.nocb_is_setup = true;
 	}
 
-	if (!rcu_nocb_is_setup)
+	if (!rcu_state.nocb_is_setup)
 		return;
 
 #if defined(CONFIG_NO_HZ_FULL)
@@ -1233,7 +1230,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	struct task_struct *t;
 	struct sched_param sp;
 
-	if (!rcu_scheduler_fully_active || !rcu_nocb_is_setup)
+	if (!rcu_scheduler_fully_active || !rcu_state.nocb_is_setup)
 		return;
 
 	/* If there already is an rcuo kthread, then nothing to do. */
@@ -1279,7 +1276,7 @@ static void __init rcu_spawn_nocb_kthreads(void)
 {
 	int cpu;
 
-	if (rcu_nocb_is_setup) {
+	if (rcu_state.nocb_is_setup) {
 		for_each_online_cpu(cpu)
 			rcu_spawn_cpu_nocb_kthread(cpu);
 	}
-- 
2.25.1

