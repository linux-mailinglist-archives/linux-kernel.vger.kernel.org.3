Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38D05A854D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiHaSQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiHaSO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:14:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4B9ED02B;
        Wed, 31 Aug 2022 11:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F6E961C67;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A510C4314A;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=wGST3YDzy3o68YtlnXnYOiYlSDAYr4NnGFg4G17K0hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcCxvanwi7RJ1Tw6jEy70675ckfhTiR9WefHcwRGJs6BfwIXx6pxkvjZq1GG+OyvH
         8KJ7oakE/BkND9ASAGkwA0NKdTNn3Q6hyRPBqPUtxGyWuHSQu5FaCF/eKez+RwUxOM
         MCe9vmu8003kBbPsjp0FSKFqzO6/eYCnPf6auXB4k+KiU7rf53e3R7a8WoE/OrSi4z
         Osm9QpsXS5p0RnYq/N0KhJPhYbbU4fe1POMBC9Bcp10x+vbvNIqONjGwI5j4eVC6tm
         w81/89H9Q31qSFxRteMuzXDsMPkri3LIdSdU2HzA/SP+hKsmaXUjURCUImempVjxi+
         HJE+h8hD2k0LQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6FF295C0B07; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/25] rcu: Disable run-time single-CPU grace-period optimization
Date:   Wed, 31 Aug 2022 11:11:58 -0700
Message-Id: <20220831181210.2695080-13-paulmck@kernel.org>
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

The run-time single-CPU grace-period optimization applies only to
kernels built with CONFIG_SMP=y && CONFIG_PREEMPTION=y that are running
on a single-CPU system.  But a kernel intended for a single-CPU system
should instead be built with CONFIG_SMP=n, and in any case, single-CPU
systems running Linux no longer appear to be the common case.  Plus this
optimization results in the rcu_gp_oldstate structure being half again
larger than it needs to be.

This commit therefore disables the run-time single-CPU grace-period
optimization, so that this optimization applies only during the
pre-scheduler portion of the boot sequence.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5c46c0d34ef0d..5c4ec9dd4ce70 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3423,42 +3423,20 @@ void __init kfree_rcu_scheduler_running(void)
 
 /*
  * During early boot, any blocking grace-period wait automatically
- * implies a grace period.  Later on, this is never the case for PREEMPTION.
+ * implies a grace period.
  *
- * However, because a context switch is a grace period for !PREEMPTION, any
- * blocking grace-period wait automatically implies a grace period if
- * there is only one CPU online at any point time during execution of
- * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
- * occasionally incorrectly indicate that there are multiple CPUs online
- * when there was in fact only one the whole time, as this just adds some
- * overhead: RCU still operates correctly.
+ * Later on, this could in theory be the case for kernels built with
+ * CONFIG_SMP=y && CONFIG_PREEMPTION=y running on a single CPU, but this
+ * is not a common case.  Furthermore, this optimization would cause
+ * the rcu_gp_oldstate structure to expand by 50%, so this potential
+ * grace-period optimization is ignored once the scheduler is running.
  */
 static int rcu_blocking_is_gp(void)
 {
-	int ret;
-
-	// Invoking preempt_model_*() too early gets a splat.
-	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE ||
-	    preempt_model_full() || preempt_model_rt())
-		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
+		return false;
 	might_sleep();  /* Check for RCU read-side critical section. */
-	preempt_disable();
-	/*
-	 * If the rcu_state.n_online_cpus counter is equal to one,
-	 * there is only one CPU, and that CPU sees all prior accesses
-	 * made by any CPU that was online at the time of its access.
-	 * Furthermore, if this counter is equal to one, its value cannot
-	 * change until after the preempt_enable() below.
-	 *
-	 * Furthermore, if rcu_state.n_online_cpus is equal to one here,
-	 * all later CPUs (both this one and any that come online later
-	 * on) are guaranteed to see all accesses prior to this point
-	 * in the code, without the need for additional memory barriers.
-	 * Those memory barriers are provided by CPU-hotplug code.
-	 */
-	ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
-	preempt_enable();
-	return ret;
+	return true;
 }
 
 /**
-- 
2.31.1.189.g2e36527f23

