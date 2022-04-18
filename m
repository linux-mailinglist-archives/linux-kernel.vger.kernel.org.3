Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A65B506006
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiDRW7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiDRW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:59:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA422D1E2;
        Mon, 18 Apr 2022 15:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9893CB81136;
        Mon, 18 Apr 2022 22:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592B4C385A9;
        Mon, 18 Apr 2022 22:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322604;
        bh=FCA6zs4LWWKubnderCQQGmx4BdH6abaJqQaksaPioy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTTwxDV9hl9qnwWDZ7BJ2gIf1/LYaZWgs9VAJDqHUpx00SoyPmv3wOb1WAcdcfZHV
         gm+ZClsV/EQgeVJj7Wfbd0NV7aNXMN+fCaJf9mlBGvUfPEMzvDUNZKDXNaOzyxN7wU
         DJB9kkcWcXv0khMVTxLiFGBtZKRc+LypPknW6M22TS4aEl5D2dm5nc3ArJ90soRwa5
         Wt7BNMrfmSTRa7Yt6BN94Ozp1fFsyY5ddArwGgdSovoAO2xEVdcjyfmqxeOlod01it
         LPYf63sqEcXalVKXtD6CDoWXftD96dFJSmHokzhPmmTrY0TPZdQWuxjgqhy6ZVvPAr
         iVhIhGTT1+iZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0D0725C04C6; Mon, 18 Apr 2022 15:56:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH rcu 2/5] rcu/nocb: Move rcu_nocb_is_setup to rcu_state
Date:   Mon, 18 Apr 2022 15:56:39 -0700
Message-Id: <20220418225642.3945539-2-paulmck@kernel.org>
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

This commit moves the RCU nocb initialization witness within rcu_state
to consolidate RCU's global state.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h | 13 +++++--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 926673ebe355..f6a3d54585c9 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -364,6 +364,7 @@ struct rcu_state {
 	arch_spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
+	int nocb_is_setup;			/* nocb is setup from boot */
 };
 
 /* Values for rcu_state structure's gp_flags field. */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 02e1d05a11fc..3c00240833d6 100644
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
@@ -1172,10 +1169,10 @@ void __init rcu_init_nohz(void)
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
2.31.1.189.g2e36527f23

