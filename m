Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5F74B8CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiBPPmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:42:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiBPPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:42:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC26C1CA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:42:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8B3619A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0833FC340EF;
        Wed, 16 Feb 2022 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026135;
        bh=6K9657j7gLRwoEvVjac7cH9GcoId6TrWRZBv5kqat48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NO7roNpp9rWRvyrCpgkrjVUX1YRucdP9kuRIRaRLVi0c1+ph5QQ6P/9nNtSnvaYQf
         2n4eP04EWyNX5SAINJXIzIi7FSzz0UsrhxJkpF7yIVeyrDs8+FTXnIreoKSZqCr/tY
         a0xCXyjVc9e2nLk1PqgeT1m3QRiB+tXGFiHXFQkdZp2cv4K6cf3AaIk2NNezxyYnl8
         h1etmLR8uYv+MnFigV7fFg6ddzuntFxyI3z3VKl/fbkH4wm9rFNynWne4/YOYI8Q7c
         hwUAXmVjF8bTkAEUkf2sH+IuZJKvzcOK9vYknv/Uqec8IX/xQK6d39Ncoh6w4/mF5m
         P5nIeTitQXEzg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 1/5] rcu: Remove rcu_is_nocb_cpu()
Date:   Wed, 16 Feb 2022 16:42:04 +0100
Message-Id: <20220216154208.696069-2-frederic@kernel.org>
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

It's an unused leftover that can now be removed.

Reported-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h       | 2 --
 kernel/rcu/tree_nocb.h | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 819f9d979e61..44efedd921d0 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -549,10 +549,8 @@ void rcu_gp_slow_unregister(atomic_t *rgssp);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_RCU_NOCB_CPU
-bool rcu_is_nocb_cpu(int cpu);
 void rcu_bind_current_to_nocb(void);
 #else
-static inline bool rcu_is_nocb_cpu(int cpu) { return false; }
 static inline void rcu_bind_current_to_nocb(void) { }
 #endif
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 636d0546a4e9..02e1d05a11fc 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -215,14 +215,6 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
 }
 
-/* Is the specified CPU a no-CBs CPU? */
-bool rcu_is_nocb_cpu(int cpu)
-{
-	if (cpumask_available(rcu_nocb_mask))
-		return cpumask_test_cpu(cpu, rcu_nocb_mask);
-	return false;
-}
-
 static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 			   struct rcu_data *rdp,
 			   bool force, unsigned long flags)
-- 
2.25.1

