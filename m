Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BFD465A94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354237AbhLBAWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:22:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55538 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240671AbhLBAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:22:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69527B82198;
        Thu,  2 Dec 2021 00:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D0AC53FCD;
        Thu,  2 Dec 2021 00:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404347;
        bh=IaDmmqKe4B8y0bdSwq3mak9uJot/QRrYn0p8THs6BIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4zE9K/QrOzaJ7DfixC4yiWaT/CTCyzJPBt/8ZVsaNL+ouMXUjtrhRatT0czAD9wE
         jzy03V6pSvG9GJnGdeEdLbhkjCY+tCfN7wFWzWVhoioEp61hW6RnkD1AGZBvbaqwB9
         qUCuUuN7QRahtZ/HrD1MOufEWKG8+eJjg84fPAmEaWYk3i1UmYDYqtloLHRO1BMRLb
         o1yOMSeD2SeSEqwuiXoWCiKmeGxIweG4RVWgkZgcnYlAfjlLPk9SIm3V8xkmys0oKr
         +J7e+KTLju0Ti/ignFS8x1zexfpOgN838K8RKVOhaSBJ3CRKigenTpU/mPRyAmO+Vr
         MQAVkgcZEk0Dg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C9C965C117F; Wed,  1 Dec 2021 16:19:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/4] rcu: Move rcu_needs_cpu() to tree.c
Date:   Wed,  1 Dec 2021 16:19:04 -0800
Message-Id: <20211202001904.3126929-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001838.GA3126627@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001838.GA3126627@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that RCU_FAST_NO_HZ is no more, there is but one implementation of
the rcu_needs_cpu() function.  This commit therefore moves this function
from kernel/rcu/tree_plugin.c to kernel/rcu/tree.c.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 18 ++++++++++++++++++
 kernel/rcu/tree_plugin.h | 16 ----------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5e98257c2910e..4ac019e9b25ff 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1075,6 +1075,24 @@ void rcu_irq_enter_irqson(void)
 	local_irq_restore(flags);
 }
 
+/*
+ * Check to see if any future non-offloaded RCU-related work will need
+ * to be done by the current CPU, even if none need be done immediately,
+ * returning 1 if so.  This function is part of the RCU implementation;
+ * it is -not- an exported member of the RCU API.  This is used by
+ * the idle-entry code to figure out whether it is safe to disable the
+ * scheduler-clock interrupt.
+ *
+ * Just check whether or not this CPU has non-offloaded RCU callbacks
+ * queued.
+ */
+int rcu_needs_cpu(u64 basemono, u64 *nextevt)
+{
+	*nextevt = KTIME_MAX;
+	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
+		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
+}
+
 /*
  * If any sort of urgency was applied to the current CPU (for example,
  * the scheduler-clock interrupt was enabled on a nohz_full CPU) in order
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 19f7d578cedb3..0575757a0f8fc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1251,22 +1251,6 @@ static void __init rcu_spawn_boost_kthreads(void)
 
 #endif /* #else #ifdef CONFIG_RCU_BOOST */
 
-/*
- * Check to see if any future non-offloaded RCU-related work will need
- * to be done by the current CPU, even if none need be done immediately,
- * returning 1 if so.  This function is part of the RCU implementation;
- * it is -not- an exported member of the RCU API.
- *
- * Just check whether or not this CPU has non-offloaded RCU callbacks
- * queued.
- */
-int rcu_needs_cpu(u64 basemono, u64 *nextevt)
-{
-	*nextevt = KTIME_MAX;
-	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
-		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
-}
-
 /*
  * Is this CPU a NO_HZ_FULL CPU that should ignore RCU so that the
  * grace-period kthread will do force_quiescent_state() processing?
-- 
2.31.1.189.g2e36527f23

