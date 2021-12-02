Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02799465ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354446AbhLBAee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354316AbhLBAcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B9C061758;
        Wed,  1 Dec 2021 16:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29255B821A8;
        Thu,  2 Dec 2021 00:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B471C58337;
        Thu,  2 Dec 2021 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404955;
        bh=/P1pyaTsbwzcUSpj473jR21r0PHzGd93q/qNRSTV65k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvWyil6DMdrNlspyD6vz0Zu4+nPmyb1VS+wK/AWywZg6JzNKpRomGFU1R6DVnT+gY
         /QLkApO2ZAveyiavB6kUwoYyvDzC8vyZgmotPHZmu3TxmGPzsGf9xyu2VyEmYj5gf9
         vQoLXBV47MywDHfEom9yS+xb0jL3GxiEnHHcWedRlbPyx0YjmoWIicSYSTRBEHQ9Je
         7AfljYOWk6cxRqJ2AGg4aTTm9sQzSVq4kqmmxdscvQdSzR/KvwOFLANZqpYeQhD3Ih
         3ryunVOGLiy05hbzMvLssG0eFzl1FtuS8SsY8rbHLS15VhTBcAJOa4Ivt3gCQwTg2o
         p7uhdTw6h1Yog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 78AB05C1461; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 14/18] rcu/nocb: Prepare nocb_cb_wait() to start with a non-offloaded rdp
Date:   Wed,  1 Dec 2021 16:29:08 -0800
Message-Id: <20211202002912.3127710-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

In order to be able to toggle the offloaded state from cpusets, a nocb
kthread will need to be created for all possible CPUs whenever either
of the "rcu_nocbs=" or "nohz_full=" parameters are specified.

Therefore, the nocb_cb_wait() kthread must be prepared to start running
on a de-offloaded rdp.  To accomplish this, simply move the sleeping
condition to the beginning of the nocb_cb_wait() function, which prevents
this kthread from attempting to invoke callbacks before the corresponding
CPU is offloaded.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8e94a5344afed..cd596cf4ee79a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -803,6 +803,18 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	bool can_sleep = true;
 	struct rcu_node *rnp = rdp->mynode;
 
+	do {
+		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
+						    nocb_cb_wait_cond(rdp));
+
+		// VVV Ensure CB invocation follows _sleep test.
+		if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
+			WARN_ON(signal_pending(current));
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
+		}
+	} while (!nocb_cb_can_run(rdp));
+
+
 	local_irq_save(flags);
 	rcu_momentary_dyntick_idle();
 	local_irq_restore(flags);
@@ -855,17 +867,6 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 
 	if (needwake_state)
 		swake_up_one(&rdp->nocb_state_wq);
-
-	do {
-		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
-						    nocb_cb_wait_cond(rdp));
-
-		// VVV Ensure CB invocation follows _sleep test.
-		if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
-			WARN_ON(signal_pending(current));
-			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
-		}
-	} while (!nocb_cb_can_run(rdp));
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

