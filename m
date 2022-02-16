Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D194B8CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiBPPms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:42:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiBPPmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:42:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20AAA146A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:42:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E953619A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBA0C004E1;
        Wed, 16 Feb 2022 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026143;
        bh=yJU8hBc2czTJc3bbudjxiT4f52GXeYpKuKeizilsRso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmARornArjckhS9MrmRfkVRvPK5ZXyBzs6of3apNy83fcQZVc+H5MH9kYrbltxjSC
         DRLvRYTOEQKQuxHV259ZfkCWufhG1QjV/y5IqHmdBw6LnONTRJhYvHeYwq5TV0qbWI
         FIn6YqAuSTm8ACObvyeKFj7w3U0uNNHs7zhYRHwPVCxvJbrUv9NBB/ZNjMmGHeLjV1
         OAnX5S6F8PGegOtbG80rzbV1P1Nhf3urKd62O1AOSTZwvCn5SHoY9ViM4tT6yO4fq4
         aRdpUpv4KMB/hXJt1ay9yR0rW1+APu3rRBeKal2ytpIJKsF47/juD9pH1xhi2JyBOI
         pVXIRwojTI2Dw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 5/5] rcu/nocb: Initialize nocb kthreads only for boot CPU prior SMP initialization
Date:   Wed, 16 Feb 2022 16:42:08 +0100
Message-Id: <20220216154208.696069-6-frederic@kernel.org>
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

rcu_spawn_gp_kthread() is called as an early initcall, which means that
SMP initialization hasn't happened yet and the boot CPU is the only one
online. Therefore only the NOCB kthreads related to the boot CPU need
to be created at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c      |  6 +++++-
 kernel/rcu/tree.h      |  1 -
 kernel/rcu/tree_nocb.h | 20 --------------------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4a98417c2e28..3e9a8ec222e4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4526,9 +4526,13 @@ static int __init rcu_spawn_gp_kthread(void)
 	smp_store_release(&rcu_state.gp_kthread, t);  /* ^^^ */
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
-	rcu_spawn_nocb_kthreads();
 	/* This is a pre-SMP initcall, we expect a single CPU */
 	WARN_ON(num_online_cpus() > 1);
+	/*
+	 * Those kthreads couldn't be created on rcu_init() -> rcutree_prepare_cpu()
+	 * due to rcu_scheduler_fully_active.
+	 */
+	rcu_spawn_cpu_nocb_kthread(smp_processor_id());
 	rcu_spawn_one_boost_kthread(rdp->mynode);
 	rcu_spawn_core_kthreads();
 	return 0;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 48c772fc353f..e3296ecde277 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -443,7 +443,6 @@ static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
 static bool do_nocb_deferred_wakeup(struct rcu_data *rdp);
 static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
 static void rcu_spawn_cpu_nocb_kthread(int cpu);
-static void __init rcu_spawn_nocb_kthreads(void);
 static void show_rcu_nocb_state(struct rcu_data *rdp);
 static void rcu_nocb_lock(struct rcu_data *rdp);
 static void rcu_nocb_unlock(struct rcu_data *rdp);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 494e65445773..9d6d4786bc70 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1266,22 +1266,6 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 }
 
-/*
- * Once the scheduler is running, spawn rcuo kthreads for all online
- * no-CBs CPUs.  This assumes that the early_initcall()s happen before
- * non-boot CPUs come online -- if this changes, we will need to add
- * some mutual exclusion.
- */
-static void __init rcu_spawn_nocb_kthreads(void)
-{
-	int cpu;
-
-	if (rcu_state.nocb_is_setup) {
-		for_each_online_cpu(cpu)
-			rcu_spawn_cpu_nocb_kthread(cpu);
-	}
-}
-
 /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
 static int rcu_nocb_gp_stride = -1;
 module_param(rcu_nocb_gp_stride, int, 0444);
@@ -1538,10 +1522,6 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
 }
 
-static void __init rcu_spawn_nocb_kthreads(void)
-{
-}
-
 static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
 }
-- 
2.25.1

