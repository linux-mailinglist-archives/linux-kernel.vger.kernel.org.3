Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEC50607E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiDSAGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbiDSAGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33B25EB9;
        Mon, 18 Apr 2022 17:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DDD9612D2;
        Tue, 19 Apr 2022 00:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B1BC385C6;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=nNJzJ7ht+CbKYymIkOO+SwWfnhHVpzPdSX+sR/dQxpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGOX6Wc1yC7t7X1I1bHokg/oMTHfD1+ZF8aL7evt0quDKJ3mMegJ+f5+92g4fin12
         ziRIE8uB49OCyf997rjFW1pwQNTu7BNYv0XqaeltJF0SGSeEjy0wAE0CwpQ7D5Z6PC
         AIZ1A4ITiS0VA/uzMN2C9xKneCI308C99ci1ykxGU2owmOm5hzP5XKHdDBEwskEhmN
         t+v2E2mX4Mn/CrI6RKkbpNVppMomRd0vc5w6KQ2tTpgKSQNKgdvwuDC2FvAjQ4CIW+
         /g1Swb/v92kQ3FUpYjwiqs3cTIASCcgPgO/ZLMzCLUFnKNHQLPcZSh0EbY8o2SMtIQ
         0D1YvYaTgyj1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 697FC5C2DF5; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 16/21] srcu: Create concurrency-safe helper for initiating size transition
Date:   Mon, 18 Apr 2022 17:03:17 -0700
Message-Id: <20220419000322.3948903-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
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

Once there are contention-initiated size transitions, it will be
possible for rcutorture to initiate a transition at the same time
as a contention-initiated transition.  This commit therefore creates
a concurrency-safe helper function named srcu_transition_to_big() to
safely initiate size transitions.

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 64993a172cff..c9460374d437 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -272,6 +272,25 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
 
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
+/*
+ * Initiate an idempotent transition to SRCU_SIZE_BIG.
+ */
+static void srcu_transition_to_big(struct srcu_struct *ssp)
+{
+	unsigned long flags;
+
+	/* Double-checked locking on ->srcu_size-state. */
+	if (smp_load_acquire(&ssp->srcu_size_state) != SRCU_SIZE_SMALL)
+		return;
+	spin_lock_irqsave_rcu_node(ssp, flags);
+	if (smp_load_acquire(&ssp->srcu_size_state) != SRCU_SIZE_SMALL) {
+		spin_unlock_irqrestore_rcu_node(ssp, flags);
+		return;
+	}
+	smp_store_release(&ssp->srcu_size_state, SRCU_SIZE_ALLOC);
+	spin_unlock_irqrestore_rcu_node(ssp, flags);
+}
+
 /*
  * First-use initialization of statically allocated srcu_struct
  * structure.  Wiring up the combining tree is more than can be
@@ -1523,8 +1542,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		}
 		pr_cont(" T(%ld,%ld)\n", s0, s1);
 	}
-	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && convert_to_big == 2)
-		WRITE_ONCE(ssp->srcu_size_state, SRCU_SIZE_ALLOC);
+	if (convert_to_big == 2)
+		srcu_transition_to_big(ssp);
 }
 EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
 
-- 
2.31.1.189.g2e36527f23

