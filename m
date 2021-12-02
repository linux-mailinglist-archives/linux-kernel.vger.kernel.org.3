Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0214E465ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354537AbhLBAes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:34:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51962 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345031AbhLBAcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 00639CE213B;
        Thu,  2 Dec 2021 00:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C3CC58332;
        Thu,  2 Dec 2021 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404955;
        bh=GHgGsDCq17POu9DvYzdzZrkC23Mrj2IPIVzBqt/uUnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p27+L0n0+0Su0ARbygCsvpjseu9Gr8Ko+ylfJEr5ZAZDc+A11iUq+j6Im2HV9Gzep
         KecqD6595+/NvwNC4ribBr75BobF+GttIU2ih57gc+GOzHYUdwBHD/x1djDojb/zUq
         a41TeW/A1G1ZTqMP1v3M9SI7pplZQVNiI4pHAsO+IuxtSlkyAUFziIOqkmGpj59RW/
         PcpgihlpDVlC2WUJEe8ekmv0FdgQ2aygKtNobBdXVKjtNAqVtInQg5nElaaMagOhDW
         VlUxOj6z9QKszpnSPnfN3v/LwfX8fx6FR6whiLfLPiZbDy6UqM6cuJNwWFDgfwh1CR
         oG9Bn1aEaScPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7468A5C1411; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
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
Subject: [PATCH rcu 12/18] rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread
Date:   Wed,  1 Dec 2021 16:29:06 -0800
Message-Id: <20211202002912.3127710-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

rcu_core() tries to ensure that its self-invocation in case of callbacks
overload only happen in softirq/rcuc mode. Indeed it doesn't make sense
to trigger local RCU core from nocb_cb kthread since it can execute
on a CPU different from the target rdp. Also in case of overload, the
nocb_cb kthread simply iterates a new loop of callbacks processing.

However the "offloaded" check that aims at preventing misplaced
rcu_core() invocations is wrong. First of all that state is volatile
and second: softirq/rcuc can execute while the target rdp is offloaded.
As a result rcu_core() can be invoked on the wrong CPU while in the
process of (de-)offloading.

Fix that with moving the rcu_core() self-invocation to rcu_core() itself,
irrespective of the rdp offloaded state.

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
 kernel/rcu/tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1b31fad9f1a0a..03c038f324a09 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2460,7 +2460,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	int div;
 	bool __maybe_unused empty;
 	unsigned long flags;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
@@ -2582,9 +2581,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-	/* Re-invoke RCU core processing if there are callbacks remaining. */
-	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
-		invoke_rcu_core();
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
 }
 
@@ -2771,8 +2767,12 @@ static __latent_entropy void rcu_core(void)
 
 	/* If there are callbacks ready, invoke them. */
 	if (do_batch && rcu_segcblist_ready_cbs(&rdp->cblist) &&
-	    likely(READ_ONCE(rcu_scheduler_fully_active)))
+	    likely(READ_ONCE(rcu_scheduler_fully_active))) {
 		rcu_do_batch(rdp);
+		/* Re-invoke RCU core processing if there are callbacks remaining. */
+		if (rcu_segcblist_ready_cbs(&rdp->cblist))
+			invoke_rcu_core();
+	}
 
 	/* Do any needed deferred wakeups of rcuo kthreads. */
 	do_nocb_deferred_wakeup(rdp);
-- 
2.31.1.189.g2e36527f23

