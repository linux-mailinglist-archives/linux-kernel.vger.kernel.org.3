Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A54465B31
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344506AbhLBArG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:47:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39200 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbhLBArC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4848B82197;
        Thu,  2 Dec 2021 00:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835CEC53FCD;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=BwmW4ZgS1oIucAqxGoAL1piw7majEuKwklXzQUxISsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8VMRg7h476Tcj7Fm5/25Xg37ryY2R0gaS5NwJUUSO4aiCQcA4ireTSqoMIg7ArIT
         8ZtW0wPVU/dTtN5A+BF9zsYfmd2AYoBY95Hd4TfffR/idDaa2341FFt8abOsT9nTUE
         EiF1TzXyBS2ppumchM4AAdETBJYs+wsSAYFEwv6m+uuRYwQ/le9s9bCbHeFnpKFYAx
         GOV2Hrz5P3TP5bXm0Y62V2P8oBo78JYWi+lHVgvdL6QprRR1Y5mpMaczhd3J1h78E/
         Iegc5iNrtXKLUNkH9RcOh/B7Dm/76CnVHl358/kVXNFHPjy2PvYWySwxQA4chAlOlk
         elZb3ZZmFqpNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4A5425C100F; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/17] rcutorture: More thoroughly test nested readers
Date:   Wed,  1 Dec 2021 16:43:21 -0800
Message-Id: <20211202004337.3130175-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, nested readers occur only when a timer handler interrupts a
reader.  This is rare, and is thus insufficient testing of the transition
between nesting levels.  This commit therefore causes rcutorture nested
readers to be the rule rather than the exception.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 73 ++++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1e03fe681f025..d295da380fb4f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -53,15 +53,18 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
 
 /* Bits for ->extendables field, extendables param, and related definitions. */
-#define RCUTORTURE_RDR_SHIFT	 8	/* Put SRCU index in upper bits. */
-#define RCUTORTURE_RDR_MASK	 (1 << RCUTORTURE_RDR_SHIFT)
+#define RCUTORTURE_RDR_SHIFT_1	 8	/* Put SRCU index in upper bits. */
+#define RCUTORTURE_RDR_MASK_1	 (1 << RCUTORTURE_RDR_SHIFT_1)
+#define RCUTORTURE_RDR_SHIFT_2	 9	/* Put SRCU index in upper bits. */
+#define RCUTORTURE_RDR_MASK_2	 (1 << RCUTORTURE_RDR_SHIFT_2)
 #define RCUTORTURE_RDR_BH	 0x01	/* Extend readers by disabling bh. */
 #define RCUTORTURE_RDR_IRQ	 0x02	/*  ... disabling interrupts. */
 #define RCUTORTURE_RDR_PREEMPT	 0x04	/*  ... disabling preemption. */
 #define RCUTORTURE_RDR_RBH	 0x08	/*  ... rcu_read_lock_bh(). */
 #define RCUTORTURE_RDR_SCHED	 0x10	/*  ... rcu_read_lock_sched(). */
-#define RCUTORTURE_RDR_RCU	 0x20	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_NBITS	 6	/* Number of bits defined above. */
+#define RCUTORTURE_RDR_RCU_1	 0x20	/*  ... entering another RCU reader. */
+#define RCUTORTURE_RDR_RCU_2	 0x40	/*  ... entering another RCU reader. */
+#define RCUTORTURE_RDR_NBITS	 7	/* Number of bits defined above. */
 #define RCUTORTURE_MAX_EXTEND	 \
 	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
 	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
@@ -1420,13 +1423,15 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 				  struct rt_read_seg *rtrsp)
 {
 	unsigned long flags;
-	int idxnew = -1;
-	int idxold = *readstate;
+	int idxnew1 = -1;
+	int idxnew2 = -1;
+	int idxold1 = *readstate;
+	int idxold2 = idxold1;
 	int statesnew = ~*readstate & newstate;
 	int statesold = *readstate & ~newstate;
 
-	WARN_ON_ONCE(idxold < 0);
-	WARN_ON_ONCE((idxold >> RCUTORTURE_RDR_SHIFT) > 1);
+	WARN_ON_ONCE(idxold2 < 0);
+	WARN_ON_ONCE((idxold2 >> RCUTORTURE_RDR_SHIFT_2) > 1);
 	rtrsp->rt_readstate = newstate;
 
 	/* First, put new protection in place to avoid critical-section gap. */
@@ -1440,8 +1445,10 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		preempt_disable();
 	if (statesnew & RCUTORTURE_RDR_SCHED)
 		rcu_read_lock_sched();
-	if (statesnew & RCUTORTURE_RDR_RCU)
-		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
+	if (statesnew & RCUTORTURE_RDR_RCU_1)
+		idxnew1 = (cur_ops->readlock() & 0x1) << RCUTORTURE_RDR_SHIFT_1;
+	if (statesnew & RCUTORTURE_RDR_RCU_2)
+		idxnew2 = (cur_ops->readlock() & 0x1) << RCUTORTURE_RDR_SHIFT_2;
 
 	/*
 	 * Next, remove old protection, in decreasing order of strength
@@ -1460,13 +1467,19 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		local_bh_enable();
 	if (statesold & RCUTORTURE_RDR_RBH)
 		rcu_read_unlock_bh();
-	if (statesold & RCUTORTURE_RDR_RCU) {
+	if (statesold & RCUTORTURE_RDR_RCU_2) {
+		cur_ops->readunlock((idxold2 >> RCUTORTURE_RDR_SHIFT_2) & 0x1);
+		WARN_ON_ONCE(idxnew2 != -1);
+		idxold2 = 0;
+	}
+	if (statesold & RCUTORTURE_RDR_RCU_1) {
 		bool lockit = !statesnew && !(torture_random(trsp) & 0xffff);
 
 		if (lockit)
 			raw_spin_lock_irqsave(&current->pi_lock, flags);
-		cur_ops->readunlock(idxold >> RCUTORTURE_RDR_SHIFT);
-		idxold = 0;
+		cur_ops->readunlock((idxold1 >> RCUTORTURE_RDR_SHIFT_1) & 0x1);
+		WARN_ON_ONCE(idxnew1 != -1);
+		idxold1 = 0;
 		if (lockit)
 			raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 	}
@@ -1476,13 +1489,19 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		cur_ops->read_delay(trsp, rtrsp);
 
 	/* Update the reader state. */
-	if (idxnew == -1)
-		idxnew = idxold & RCUTORTURE_RDR_MASK;
-	WARN_ON_ONCE(idxnew < 0);
-	WARN_ON_ONCE((idxnew >> RCUTORTURE_RDR_SHIFT) > 1);
-	*readstate = idxnew | newstate;
-	WARN_ON_ONCE((*readstate >> RCUTORTURE_RDR_SHIFT) < 0);
-	WARN_ON_ONCE((*readstate >> RCUTORTURE_RDR_SHIFT) > 1);
+	if (idxnew1 == -1)
+		idxnew1 = idxold1 & RCUTORTURE_RDR_MASK_1;
+	WARN_ON_ONCE(idxnew1 < 0);
+	if (WARN_ON_ONCE((idxnew1 >> RCUTORTURE_RDR_SHIFT_1) > 1))
+		pr_info("Unexpected idxnew1 value of %#x\n", idxnew1);
+	if (idxnew2 == -1)
+		idxnew2 = idxold2 & RCUTORTURE_RDR_MASK_2;
+	WARN_ON_ONCE(idxnew2 < 0);
+	WARN_ON_ONCE((idxnew2 >> RCUTORTURE_RDR_SHIFT_2) > 1);
+	*readstate = idxnew1 | idxnew2 | newstate;
+	WARN_ON_ONCE(*readstate < 0);
+	if (WARN_ON_ONCE((*readstate >> RCUTORTURE_RDR_SHIFT_2) > 1))
+		pr_info("Unexpected idxnew2 value of %#x\n", idxnew2);
 }
 
 /* Return the biggest extendables mask given current RCU and boot parameters. */
@@ -1492,7 +1511,7 @@ static int rcutorture_extend_mask_max(void)
 
 	WARN_ON_ONCE(extendables & ~RCUTORTURE_MAX_EXTEND);
 	mask = extendables & RCUTORTURE_MAX_EXTEND & cur_ops->extendables;
-	mask = mask | RCUTORTURE_RDR_RCU;
+	mask = mask | RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
 	return mask;
 }
 
@@ -1507,13 +1526,21 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
 	unsigned long bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
 
-	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
+	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT_1);
 	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
 	if (!(randmask1 & 0x7))
 		mask = mask & randmask2;
 	else
 		mask = mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
 
+	// Can't have nested RCU reader without outer RCU reader.
+	if (!(mask & RCUTORTURE_RDR_RCU_1) && (mask & RCUTORTURE_RDR_RCU_2)) {
+		if (oldmask & RCUTORTURE_RDR_RCU_1)
+			mask &= ~RCUTORTURE_RDR_RCU_2;
+		else
+			mask |= RCUTORTURE_RDR_RCU_1;
+	}
+
 	/*
 	 * Can't enable bh w/irq disabled.
 	 */
@@ -1533,7 +1560,7 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 			mask |= oldmask & bhs;
 	}
 
-	return mask ?: RCUTORTURE_RDR_RCU;
+	return mask ?: RCUTORTURE_RDR_RCU_1;
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

