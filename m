Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE945A8550
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiHaSQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiHaSPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2BE7253;
        Wed, 31 Aug 2022 11:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E3761CAF;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57682C43159;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=07ujm17gMsps1cdH2vluoTIiYIZi7L2itN8CAFloXZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhzskBwu8BVukyWgCBe63YyYzo06ZIImFpph2t6GpUjgxxkLGJcHuLAgvQntDM/3Z
         w5ERahQtM6wjpcPhLF4VDen1frxImEJMWXl80JkLQ3Mipxe9htYQPb+QsAgZRQMdES
         sfwdBlmw/wTDExszu7BhqrVp6XfT+C91hUWmvcOiZNrjwGbjLhLb8OTPaml8j8ncjZ
         KwhFO36TFo5Nw5HScoBY/jVXovQc84/zBgKT5XpzBvxpDmdDBFze9JaRx1wo5nlGbR
         8dd39jzNnJbjkKfUVvvvItCSCNBE+/eleGaA0j1HlyEF5GuoJuCWW4uFa+8wv/xti/
         BjVZg49QBTswQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 750175C0DE5; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 16/25] rcu: Make synchronize_rcu() fast path update ->gp_seq counters
Date:   Wed, 31 Aug 2022 11:12:01 -0700
Message-Id: <20220831181210.2695080-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit causes the early boot single-CPU synchronize_rcu() fastpath to
update the rcu_state and rcu_node structures' ->gp_seq and ->gp_seq_needed
counters.  This will allow the full-state polled grace-period APIs to
detect all normal grace periods without the need to track the special
combined polling-only counter, which is a step towards removing the
->rgos_polled field from the rcu_gp_oldstate, thereby reducing its size
by one third.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ff7d5eaa3761..8fa5ec0f3d111 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3480,24 +3480,37 @@ static int rcu_blocking_is_gp(void)
  */
 void synchronize_rcu(void)
 {
+	unsigned long flags;
+	struct rcu_node *rnp;
+
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
-	if (rcu_blocking_is_gp()) {
-		// Note well that this code runs with !PREEMPT && !SMP.
-		// In addition, all code that advances grace periods runs at
-		// process level.  Therefore, this normal GP overlaps with
-		// other normal GPs only by being fully nested within them,
-		// which allows reuse of ->gp_seq_polled_snap.
-		rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_snap);
-		rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_snap);
-		return;  // Context allows vacuous grace periods.
+	if (!rcu_blocking_is_gp()) {
+		if (rcu_gp_is_expedited())
+			synchronize_rcu_expedited();
+		else
+			wait_rcu_gp(call_rcu);
+		return;
 	}
-	if (rcu_gp_is_expedited())
-		synchronize_rcu_expedited();
-	else
-		wait_rcu_gp(call_rcu);
+
+	// Context allows vacuous grace periods.
+	// Note well that this code runs with !PREEMPT && !SMP.
+	// In addition, all code that advances grace periods runs at
+	// process level.  Therefore, this normal GP overlaps with other
+	// normal GPs only by being fully nested within them, which allows
+	// reuse of ->gp_seq_polled_snap.
+	rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_snap);
+	rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_snap);
+
+	// Update normal grace-period counters to record grace period.
+	local_irq_save(flags);
+	WARN_ON_ONCE(num_online_cpus() > 1);
+	rcu_state.gp_seq += (1 << RCU_SEQ_CTR_SHIFT);
+	rcu_for_each_node_breadth_first(rnp)
+		rnp->gp_seq_needed = rnp->gp_seq = rcu_state.gp_seq;
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
-- 
2.31.1.189.g2e36527f23

