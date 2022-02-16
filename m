Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296294B8CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiBPPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:42:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiBPPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:42:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988679A984
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:42:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35228619F6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12923C340EF;
        Wed, 16 Feb 2022 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026139;
        bh=m+S1Tc4+/RJ6N1RKDacFpzfvDG/4zJND6bubnGil5PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wws0deF3fieUDAQyT0xYnkKV1A9TJ5PP22+IWBpIqfqgeWRIs8+GKzdTWEWtjiw1g
         N67dQ0Exag3UqC2BDWgT6nxBkuww7huonp9UgYqRLDjdZDkg8FF5lBD0BIj/Idjq/A
         MKg8jb6MISundjQGWRi23UzQjYzxfnQqn5xK9c6eMfiL9EtOjmpA67fs5D8Zx8h5xs
         3dGt6CPlyJbfBmwgme6uXUZ8jD0URvlhmeVY+Z6hIULl+UwpwkMBS+Qiguvypo4ogd
         qVgjLCifxkZprZ09QhbUWiszcIyCnYy+O6UzzoE0C57lIkxd3TetFit6iKZWLz51VA
         M2iyl9ejqc1oQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/5] rcu: Assume rcu_init() is called before smp
Date:   Wed, 16 Feb 2022 16:42:06 +0100
Message-Id: <20220216154208.696069-4-frederic@kernel.org>
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

rcu_init() is called way before SMP is initialized and therefore only
the boot CPU should be online at this stage.

Simplify the boot per-cpu initialization according to this constraint.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 86eec6a0f1a1..83dec1db86cf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4813,7 +4813,7 @@ static void __init kfree_rcu_batch_init(void)
 
 void __init rcu_init(void)
 {
-	int cpu;
+	int cpu = smp_processor_id();
 
 	rcu_early_boot_tests();
 
@@ -4833,11 +4833,13 @@ void __init rcu_init(void)
 	 * or the scheduler are operational.
 	 */
 	pm_notifier(rcu_pm_notify, 0);
-	for_each_online_cpu(cpu) {
-		rcutree_prepare_cpu(cpu);
-		rcu_cpu_starting(cpu);
-		rcutree_online_cpu(cpu);
-	}
+
+	/* This is early on boot, we expect a single CPU */
+	WARN_ON(num_online_cpus() > 1);
+
+	rcutree_prepare_cpu(cpu);
+	rcu_cpu_starting(cpu);
+	rcutree_online_cpu(cpu);
 
 	/* Create workqueue for Tree SRCU and for expedited GPs. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
-- 
2.25.1

