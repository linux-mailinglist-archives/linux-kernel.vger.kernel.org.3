Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CA0465ACE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354389AbhLBAdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354272AbhLBAcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E933C061748;
        Wed,  1 Dec 2021 16:29:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0057CE2139;
        Thu,  2 Dec 2021 00:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBCAC58324;
        Thu,  2 Dec 2021 00:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404954;
        bh=Qd/EpGdyevNA++m6zhqUVS71bNUavrZjH0rRok92euU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dd+GR5BFnboiwEzyVwoTOrt5UoHZXWu/5oiJNR3QPASBoGqo6AZZmeiPpKlUih3gV
         ilV2CgR2/TiSR5kbU8aOqclWRRfUTvFRKuLWakMMP+djIf9cShJ723m8Sf6LTr9Cyw
         IkxYXFSxxpiqqraZLfTJmX0+JCXxZUJtRLoU5s+8aZ1cEvZElduTrwhjLJy6uObQpV
         jZhFg9AanpywX3t6G6GRdXP8I7VoFslXsJz/COJ+XGc2qVRRL+RIX0iDOl6/8JNLEI
         mpTmCpvQZelSQGwYGhtHlFrnZCQUgcscT+LuSgGPcVsUTg+FWPBEdyRR4ZHOe5MlZE
         XP7UwgaYCUr+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 682FE5C1184; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
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
Subject: [PATCH rcu 06/18] rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
Date:   Wed,  1 Dec 2021 16:29:00 -0800
Message-Id: <20211202002912.3127710-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

When callbacks are offloaded, the NOCB kthreads handle the callbacks
progression on behalf of rcu_core().

However during the (de-)offloading process, the kthread may not be
entirely up to the task. As a result some callbacks grace period
sequence number may remain stale for a while because rcu_core() won't
take care of them either.

Fix this with forcing callbacks acceleration from rcu_core() as long
as the offloading process isn't complete.

Reported-and-tested-by: Valentin Schneider <valentin.schneider@arm.com>
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
 kernel/rcu/tree.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5985698f33414..cb9abb80377fe 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2278,6 +2278,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
+	bool needacc = false;
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2305,16 +2306,29 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		 * This GP can't end until cpu checks in, so all of our
 		 * callbacks can be processed during the next GP.
 		 *
-		 * NOCB kthreads have their own way to deal with that.
+		 * NOCB kthreads have their own way to deal with that...
 		 */
-		if (!rcu_rdp_is_offloaded(rdp))
+		if (!rcu_rdp_is_offloaded(rdp)) {
 			needwake = rcu_accelerate_cbs(rnp, rdp);
+		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
+			/*
+			 * ...but NOCB kthreads may miss or delay callbacks acceleration
+			 * if in the middle of a (de-)offloading process.
+			 */
+			needacc = true;
+		}
 
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
 			rcu_gp_kthread_wake();
+
+		if (needacc) {
+			rcu_nocb_lock_irqsave(rdp, flags);
+			rcu_accelerate_cbs_unlocked(rnp, rdp);
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+		}
 	}
 }
 
-- 
2.31.1.189.g2e36527f23

