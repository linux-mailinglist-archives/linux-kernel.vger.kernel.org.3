Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417EE465AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354502AbhLBAeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354293AbhLBAcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6D5C061756;
        Wed,  1 Dec 2021 16:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EDFFB8219F;
        Thu,  2 Dec 2021 00:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06078C58329;
        Thu,  2 Dec 2021 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404955;
        bh=cvMmzh8x8FsGsRIFTe3ax6oCakAAl4UmFBxDrqEqpgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDXLWn/TYEKKFJV0PG0LWHPnbTXTREeho7jaONbiDA9+1gkAkESU7JaTHQ57UAhur
         nnCK6QpQbfMfF3ZvQ9OuonDOUi7MvQOqFa9GARqcZZgm45NYUFuqFKehpmcm3XiaiH
         k3y0+/vIkhMQN/kGZMeS7SLm8/8tHvyV5rqMTqCkcZmca4SXabL5G2sr6o5NOhEBLG
         KRpr9549oluU3B1Eomf023ww+vZWjD74pHvsJl7wX0nftp1WfbejBwl8Ho9lKyyScr
         HTEbodLDu5z1Pz3pXcK8FT/s9UWA1Ia8lJRcmvVU8p/TgJAIbksWonlYPQ7K8JChzk
         MzM24LulWEtOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 727A95C13F8; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/18] rcu: Apply callbacks processing time limit only on softirq
Date:   Wed,  1 Dec 2021 16:29:05 -0800
Message-Id: <20211202002912.3127710-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Time limit only makes sense when callbacks are serviced in softirq mode
because:

_ In case we need to get back to the scheduler,
  cond_resched_tasks_rcu_qs() is called after each callback.

_ In case some other softirq vector needs the CPU, the call to
  local_bh_enable() before cond_resched_tasks_rcu_qs() takes care about
  them via a call to do_softirq().

Therefore, make sure the time limit only applies to softirq mode.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 74e210ccfd382..1b31fad9f1a0a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2488,7 +2488,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
-	if (unlikely(bl > 100)) {
+	if (in_serving_softirq() && unlikely(bl > 100)) {
 		long rrn = READ_ONCE(rcu_resched_ns);
 
 		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
@@ -2528,6 +2528,17 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		if (in_serving_softirq()) {
 			if (count >= bl && (need_resched() || !is_idle_task(current)))
 				break;
+			/*
+			 * Make sure we don't spend too much time here and deprive other
+			 * softirq vectors of CPU cycles.
+			 */
+			if (unlikely(tlimit)) {
+				/* only call local_clock() every 32 callbacks */
+				if (likely((count & 31) || local_clock() < tlimit))
+					continue;
+				/* Exceeded the time limit, so leave. */
+				break;
+			}
 		} else {
 			local_bh_enable();
 			lockdep_assert_irqs_enabled();
@@ -2535,18 +2546,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			lockdep_assert_irqs_enabled();
 			local_bh_disable();
 		}
-
-		/*
-		 * Make sure we don't spend too much time here and deprive other
-		 * softirq vectors of CPU cycles.
-		 */
-		if (unlikely(tlimit)) {
-			/* only call local_clock() every 32 callbacks */
-			if (likely((count & 31) || local_clock() < tlimit))
-				continue;
-			/* Exceeded the time limit, so leave. */
-			break;
-		}
 	}
 
 	rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.31.1.189.g2e36527f23

