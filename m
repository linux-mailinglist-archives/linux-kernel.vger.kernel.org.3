Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C6D465ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354358AbhLBAcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:32:46 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51878 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbhLBAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 45772CE213A;
        Thu,  2 Dec 2021 00:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB48C53FAD;
        Thu,  2 Dec 2021 00:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404954;
        bh=2v7+FPf9diZj5Aa7QlJClMx/gzTSbjL4TQgGFYiUYIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0qb98MchxgKJIryzrF7a80+eIvdU39ApB+WyLPiI6RhwOVBXtPXnXctYaxil838w
         2k4UlgWBkUpc+S96r1hU0hYXdT9hnU7iHNYMui2AoGIq7B293/2aMlU1pvSAZBX6eu
         PuL09w+XK4zhbbaBvtz9zMvz/9hEJy85uQUnFV+0tdYgSL9Tipmm2/ma3YIfYKLyyO
         dLTfi9aSFSg74V8BU4Ag4Sa4ZVb69fFjPFYVXcaB8fhPJff1Dicpa9fNde8+z5C/VP
         8FJxmXyHVZOt3/QiePTDChCgBpjxdJz7L9iJx2arf1Ot5ohAGSIT7qmzyeNGiKJfTW
         RATmUF2IRKS2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5FD2C5C1108; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
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
Subject: [PATCH rcu 02/18] rcu/nocb: Make local rcu_nocb_lock_irqsave() safe against concurrent deoffloading
Date:   Wed,  1 Dec 2021 16:28:56 -0800
Message-Id: <20211202002912.3127710-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

rcu_nocb_lock_irqsave() can be preempted between the call to
rcu_segcblist_is_offloaded() and the actual locking. This matters now
that rcu_core() is preemptible on PREEMPT_RT and the (de-)offloading
process can interrupt the softirq or the rcuc kthread.

As a result we may locklessly call into code that requires nocb locking.
In practice this is a problem while we accelerate callbacks on rcu_core().

Simply disabling interrupts before (instead of after) checking the NOCB
offload state fixes the issue.

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
 kernel/rcu/tree.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 305cf6aeb4086..4f6c67b3ccd5e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -447,12 +447,16 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
-#define rcu_nocb_lock_irqsave(rdp, flags)				\
-do {									\
-	if (!rcu_segcblist_is_offloaded(&(rdp)->cblist))		\
-		local_irq_save(flags);					\
-	else								\
-		raw_spin_lock_irqsave(&(rdp)->nocb_lock, (flags));	\
+
+/*
+ * Disable IRQs before checking offloaded state so that local
+ * locking is safe against concurrent de-offloading.
+ */
+#define rcu_nocb_lock_irqsave(rdp, flags)			\
+do {								\
+	local_irq_save(flags);					\
+	if (rcu_segcblist_is_offloaded(&(rdp)->cblist))	\
+		raw_spin_lock(&(rdp)->nocb_lock);		\
 } while (0)
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 #define rcu_nocb_lock_irqsave(rdp, flags) local_irq_save(flags)
-- 
2.31.1.189.g2e36527f23

