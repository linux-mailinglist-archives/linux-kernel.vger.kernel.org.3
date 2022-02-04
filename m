Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742EB4AA39F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355728AbiBDWz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:55:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46782 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355287AbiBDWzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:55:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76F34B83960;
        Fri,  4 Feb 2022 22:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44340C340F0;
        Fri,  4 Feb 2022 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644015309;
        bh=a6SxQDd5Q2UNK1R/nHemOtR3mPTlyCL9AXpjqkoI1uA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQ5ZMo6pt9WmIQAmgSW1KTmUxCdabjoxv3BD4OMbNJYW5zRQlL+EHLkTqXcxT8IFq
         CRRp3I+A45lPcj0gIJGR8tmujr6Vrg/RlNHL6XtCe65ftue2B5+JFXNnGmEqRsHdAP
         Iaumqvp0Pf86A5OtpwvZUpRO2GDbaJygPuJU/F8a3uJ7BmU6kPRfJ9VjB3flLmi7U+
         fyscc4gpXx5rwed7JLauQafTqhSn/3n4xrgorYOTrnQlcrEXymHX8IabiqzjifJUQY
         adF2EFZ7NvbcpefyCW+2z4ye3MUPva4Mc0Ao+SDZohG5ddf0zU1VVSnWdT/wOhhJAu
         ARFiYXukyIhiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1110A5C08B7; Fri,  4 Feb 2022 14:55:09 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH rcu 3/3] rcu: Allow expedited RCU grace periods on incoming CPUs
Date:   Fri,  4 Feb 2022 14:55:07 -0800
Message-Id: <20220204225507.4193113-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
References: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although it is usually safe to invoke synchronize_rcu_expedited() from a
preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
invoke a workqueue handler will hang due to RCU waiting on a CPU that
the scheduler is not paying attention to.  This commit therefore expands
use of the existing workqueue-independent synchronize_rcu_expedited()
from early boot to also include CPUs that are being hotplugged.

Link: https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 60197ea24ceb9..1a45667402260 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -816,7 +816,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  */
 void synchronize_rcu_expedited(void)
 {
-	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
+	bool no_wq;
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
 	unsigned long s;
@@ -841,9 +841,15 @@ void synchronize_rcu_expedited(void)
 	if (exp_funnel_lock(s))
 		return;  /* Someone else did our work for us. */
 
+	/* Don't use workqueue during boot or from an incoming CPU. */
+	preempt_disable();
+	no_wq = rcu_scheduler_active == RCU_SCHEDULER_INIT ||
+		!cpumask_test_cpu(smp_processor_id(), cpu_active_mask);
+	preempt_enable();
+
 	/* Ensure that load happens before action based on it. */
-	if (unlikely(boottime)) {
-		/* Direct call during scheduler init and early_initcalls(). */
+	if (unlikely(no_wq)) {
+		/* Direct call for scheduler init, early_initcall()s, and incoming CPUs. */
 		rcu_exp_sel_wait_wake(s);
 	} else {
 		/* Marshall arguments & schedule the expedited grace period. */
@@ -861,7 +867,7 @@ void synchronize_rcu_expedited(void)
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
 
-	if (likely(!boottime))
+	if (likely(!no_wq))
 		destroy_work_on_stack(&rew.rew_work);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-- 
2.31.1.189.g2e36527f23

