Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E65506007
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiDRW7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiDRW70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:59:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B734928E1D;
        Mon, 18 Apr 2022 15:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC22611DA;
        Mon, 18 Apr 2022 22:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56062C385A1;
        Mon, 18 Apr 2022 22:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322604;
        bh=ZEBq7zR50zNnytDr1DAj4+RNb5TDVS+djhiUTtjXeg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3gmKPNN8cmRwuaGTSsPlS3Ky9iLBO8STYdFi4U5B7+XxGckJyXz8MWOWwza7TGRf
         fzawoVdYo+JyaHk16mjY8ZmAWlR6zHCOLtRxb50egPZN0I+HESzoFARPOw4yH9Aguw
         dmW70HkG8+0zkBbcn8W+3746CaVAsJCuzC1meYOztc+9wKfeqHy0JnICcTwxj0SXPL
         q/4nhJaHKS7gs/bB7/zjbhtUDhxdlt0ay0+hotVMocYpYqPH7zAuaCDnbrmQleuYhy
         4yjfhLpaHmFGXAwzQ8bHOcA7Mn3l4COYpMZg+rI6baXErcDGgMa+MAVdQZL2+Vziu4
         gLlMVzAGl9QfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0F1855C0848; Mon, 18 Apr 2022 15:56:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/5] rcu: Assume rcu_init() is called before smp
Date:   Mon, 18 Apr 2022 15:56:40 -0700
Message-Id: <20220418225642.3945539-3-paulmck@kernel.org>
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

The rcu_init() function is called way before SMP is initialized and
therefore only the boot CPU should be online at this stage.

Simplify the boot per-cpu initialization accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4b8189455d5..e6a9e5744e45 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4782,7 +4782,7 @@ static void __init kfree_rcu_batch_init(void)
 
 void __init rcu_init(void)
 {
-	int cpu;
+	int cpu = smp_processor_id();
 
 	rcu_early_boot_tests();
 
@@ -4802,11 +4802,10 @@ void __init rcu_init(void)
 	 * or the scheduler are operational.
 	 */
 	pm_notifier(rcu_pm_notify, 0);
-	for_each_online_cpu(cpu) {
-		rcutree_prepare_cpu(cpu);
-		rcu_cpu_starting(cpu);
-		rcutree_online_cpu(cpu);
-	}
+	WARN_ON(num_online_cpus() > 1); // Only one CPU this early in boot.
+	rcutree_prepare_cpu(cpu);
+	rcu_cpu_starting(cpu);
+	rcutree_online_cpu(cpu);
 
 	/* Create workqueue for Tree SRCU and for expedited GPs. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
-- 
2.31.1.189.g2e36527f23

