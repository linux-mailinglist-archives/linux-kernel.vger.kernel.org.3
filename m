Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924835A854A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiHaSPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiHaSOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:14:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB65F1B6D;
        Wed, 31 Aug 2022 11:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5405B61CA0;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E26BC4315E;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=+3o3kcW+nFj8F0D42txGmbjiiaheUJvzJk/MtcXEmg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDPPrXlzXdJf72qGoy/xlZDI8SRO0RGaIJmpZKHzXLt2RW5TDZv1mdhWFE0cfl6JZ
         qb59rPZihhDo0fBnUJ39MpdadS/1rBxmfxAZYXLZx/KnXY41J/vStfCE5lmM/36BEL
         Kh6m9/QSUgmRbohwIZKIGtnocsQc7PPABYUKa086LQTVlgdw3n2UiLUyOy3JkwZ+uV
         eIeksiQ7ugEe1lHTrG2FQYC+pxJLR9CJmbBwh5iwrZDPh6vXEEAwCo8oble0BlqQHA
         OHKNNlNsOIoqJcwne3JPOMioCiZG5Z8q0hBAkTUKEXrSqZTSuJwlJaRXUNfcJ7h/bc
         Gu6s7L9H8/9ng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7D7D85C0EBC; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 21/25] rcu: Make synchronize_rcu() fastpath update only boot-CPU counters
Date:   Wed, 31 Aug 2022 11:12:06 -0700
Message-Id: <20220831181210.2695080-21-paulmck@kernel.org>
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

Large systems can have hundreds of rcu_node structures, and updating
counters in each of them might slow down booting.  This commit therefore
updates only the counters in those rcu_node structures corresponding
to the boot CPU, up to and including the root rcu_node structure.

The counters for the remaining rcu_node structures are updated by the
rcu_scheduler_starting() function, which executes just before the first
non-boot kthread is spawned.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b9e8ed00536d4..ef15bae3c7c77 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3504,11 +3504,14 @@ void synchronize_rcu(void)
 	rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_snap);
 	rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_snap);
 
-	// Update normal grace-period counters to record grace period.
+	// Update the normal grace-period counters to record
+	// this grace period, but only those used by the boot CPU.
+	// The rcu_scheduler_starting() will take care of the rest of
+	// these counters.
 	local_irq_save(flags);
 	WARN_ON_ONCE(num_online_cpus() > 1);
 	rcu_state.gp_seq += (1 << RCU_SEQ_CTR_SHIFT);
-	rcu_for_each_node_breadth_first(rnp)
+	for (rnp = this_cpu_ptr(&rcu_data)->mynode; rnp; rnp = rnp->parent)
 		rnp->gp_seq_needed = rnp->gp_seq = rcu_state.gp_seq;
 	local_irq_restore(flags);
 }
@@ -4456,9 +4459,20 @@ early_initcall(rcu_spawn_gp_kthread);
  */
 void rcu_scheduler_starting(void)
 {
+	unsigned long flags;
+	struct rcu_node *rnp;
+
 	WARN_ON(num_online_cpus() != 1);
 	WARN_ON(nr_context_switches() > 0);
 	rcu_test_sync_prims();
+
+	// Fix up the ->gp_seq counters.
+	local_irq_save(flags);
+	rcu_for_each_node_breadth_first(rnp)
+		rnp->gp_seq_needed = rnp->gp_seq = rcu_state.gp_seq;
+	local_irq_restore(flags);
+
+	// Switch out of early boot mode.
 	rcu_scheduler_active = RCU_SCHEDULER_INIT;
 	rcu_test_sync_prims();
 }
-- 
2.31.1.189.g2e36527f23

