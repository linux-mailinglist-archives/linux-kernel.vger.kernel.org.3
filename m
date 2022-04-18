Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C2506008
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiDRW7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiDRW70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:59:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E12CE2E;
        Mon, 18 Apr 2022 15:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A43D60FC5;
        Mon, 18 Apr 2022 22:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2D3C385A8;
        Mon, 18 Apr 2022 22:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322604;
        bh=aoxHRcD5CE1ksNMOtptxB5UStULjmR/2Os4/NqSTB9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzeP9fMoz/970D1bk1F5wcGZQvAuQEvERKqPa7U2pjTUKchZ2ZbHs1JP2izKTEH5q
         wvyQPZY9HaBEApBK9aUYNFN5wd8LgQLUzYo/I2gStVexBxfAYLVkHH9K2/XyPbgb7h
         Ju/szWCGQuTqtm8zmSPIsUxKzX/R2A01qZIfKZ1N0p+jqTPFdMBKq0hNSdar7EfpQI
         it+vjLBj/nxajlYVhpeobRMV5CcLzo83ipiQZpojrxMQcPG5xxQRsTWrqei7qJqkcY
         ez3AftZ8qFXlofV1cIlwRSDL6tfgmc/wRRNv8HnVeZHg1AyP81fhCjDqAS9JeExpZ/
         Tb061OLev6Gng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 132DD5C0A23; Mon, 18 Apr 2022 15:56:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/5] rcu/nocb: Initialize nocb kthreads only for boot CPU prior SMP initialization
Date:   Mon, 18 Apr 2022 15:56:42 -0700
Message-Id: <20220418225642.3945539-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225633.GA3945428@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225633.GA3945428@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The rcu_spawn_gp_kthread() function is called as an early initcall, which
means that SMP initialization hasn't happened yet and only the boot CPU is
online. Therefore, create only the NOCB kthreads related to the boot CPU.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c      |  6 +++++-
 kernel/rcu/tree.h      |  1 -
 kernel/rcu/tree_nocb.h | 20 --------------------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 70b33c55d39a..9f7441a78f90 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4498,9 +4498,13 @@ static int __init rcu_spawn_gp_kthread(void)
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
index b2a0f2613ab9..25dc4166f218 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -439,7 +439,6 @@ static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
 static bool do_nocb_deferred_wakeup(struct rcu_data *rdp);
 static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
 static void rcu_spawn_cpu_nocb_kthread(int cpu);
-static void __init rcu_spawn_nocb_kthreads(void);
 static void show_rcu_nocb_state(struct rcu_data *rdp);
 static void rcu_nocb_lock(struct rcu_data *rdp);
 static void rcu_nocb_unlock(struct rcu_data *rdp);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 3c00240833d6..46694e13398a 100644
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
2.31.1.189.g2e36527f23

