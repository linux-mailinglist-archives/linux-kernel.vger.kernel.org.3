Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A30465B35
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354811AbhLBArk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344340AbhLBArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE20C061574;
        Wed,  1 Dec 2021 16:43:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 45E88CE2073;
        Thu,  2 Dec 2021 00:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76193C00446;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=FkkjdHi4jMjNVhOZRiQE9voSnpNCSKi5WpXqUkMfxTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+EUqfSjgFtKmkmlfkbwibrDmN53izS2zVH689cu4zYG5vLXYIQmkQGOA0LWrUPAt
         9x9796Pj2hqOrcbKIbbXs0eA4rip8cX47jJ/Tu1mToJwOCcI+b1IBvGdH6K+EDBS3+
         YiUvtjbJAxi6se7ujvZ1xJiao6uUlL6AGHSCoyIom10sKjEHDRQ+BWrp2YMFIcpyfx
         fxsVf5pNuxXIg0w72HXp+zWmTvKwOAmTdmoM5R2EuBh/CR8HJpQ9B45UPzRitvmoFR
         H7nxxUpKsv5UL7Sb/ebeWen8KCbYZ/GHaOe9dliMUyGJKr6Mk404RrDqgsfd2yNUn3
         MVRzEvdjXMyow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4723E5C0FCD; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/17] rcutorture: Sanitize RCUTORTURE_RDR_MASK
Date:   Wed,  1 Dec 2021 16:43:20 -0800
Message-Id: <20211202004337.3130175-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCUTORTURE_RDR_MASK is currently not the bit indicated by
RCUTORTURE_RDR_SHIFT, but is instead all the bits less significant than
that one.  This is an accident waiting to happen, so this commit makes
RCUTORTURE_RDR_MASK be that one bit and adjusts uses accordingly.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8b410d982990c..1e03fe681f025 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -54,7 +54,7 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@
 
 /* Bits for ->extendables field, extendables param, and related definitions. */
 #define RCUTORTURE_RDR_SHIFT	 8	/* Put SRCU index in upper bits. */
-#define RCUTORTURE_RDR_MASK	 ((1 << RCUTORTURE_RDR_SHIFT) - 1)
+#define RCUTORTURE_RDR_MASK	 (1 << RCUTORTURE_RDR_SHIFT)
 #define RCUTORTURE_RDR_BH	 0x01	/* Extend readers by disabling bh. */
 #define RCUTORTURE_RDR_IRQ	 0x02	/*  ... disabling interrupts. */
 #define RCUTORTURE_RDR_PREEMPT	 0x04	/*  ... disabling preemption. */
@@ -1466,6 +1466,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		if (lockit)
 			raw_spin_lock_irqsave(&current->pi_lock, flags);
 		cur_ops->readunlock(idxold >> RCUTORTURE_RDR_SHIFT);
+		idxold = 0;
 		if (lockit)
 			raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 	}
@@ -1476,7 +1477,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 
 	/* Update the reader state. */
 	if (idxnew == -1)
-		idxnew = idxold & ~RCUTORTURE_RDR_MASK;
+		idxnew = idxold & RCUTORTURE_RDR_MASK;
 	WARN_ON_ONCE(idxnew < 0);
 	WARN_ON_ONCE((idxnew >> RCUTORTURE_RDR_SHIFT) > 1);
 	*readstate = idxnew | newstate;
@@ -1626,7 +1627,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 			  rcu_torture_writer_state,
 			  cookie, cur_ops->get_gp_state());
 	rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
-	WARN_ON_ONCE(readstate & RCUTORTURE_RDR_MASK);
+	WARN_ON_ONCE(readstate);
 	// This next splat is expected behavior if leakpointer, especially
 	// for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.
 	WARN_ON_ONCE(leakpointer && READ_ONCE(p->rtort_pipe_count) > 1);
-- 
2.31.1.189.g2e36527f23

