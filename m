Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1757BB62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiGTQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiGTQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:26:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C291AD93;
        Wed, 20 Jul 2022 09:26:18 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:26:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658334377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FmzFd4vLylbmJlciVmTg+XgbOpWzFd/O3iwyuawf0N8=;
        b=kmMmfNPHddxwhREZau1sVKYB9C4Bc/yb7iuXkI1H0ypBNrvSUQmgDqrOfXfI5S2Ks+e9oY
        25bNkJOpLGe00K3EVTogpzYhK+QOdwJBmI1RKz5XxCuuYodNUCStf3GfldGSngcy0TRsLA
        5rMF5Bjdn2ZPAO1gZBWl4OxMlAZGp+6kRTJakcGjYU584yGK4LlN6XxLjN3MRVbyDhsUyJ
        4J6rUaosyzzmfNwvtFTmb6Jiyf+avglgCvz0Ib9eTDoBOJSr6l3IPcz50vq6moX2Mg7VUJ
        xX6/8LYeLOtZwvYM+W3kBCrQ9Kl+U0kRl4/P7pR3ycdnwzijzQVKqjaX1fC+2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658334377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FmzFd4vLylbmJlciVmTg+XgbOpWzFd/O3iwyuawf0N8=;
        b=qRZlY4smc589nRlBaRfBm45fGHCmG4O/jbC0L5cO4vjZrK2+SJDMpPS2dzS4QLwxw21A2I
        A/9xeeRqiyHpN9BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.19-rc7-rt7
Message-ID: <Ytgsp00o2dfGRn9v@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.19-rc7-rt7 patch set. 

Changes since v5.19-rc7-rt6:

  - Slightly update the ptrace patch (for wait_task_inactive(). There is
    no change in functionality, just the code has been reordered.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.19-rc7-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/incr/patch-5.19-rc7-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.19-rc7-rt7

The RT patch against v5.19-rc7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patch-5.19-rc7-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patches-5.19-rc7-rt7.tar.xz

Sebastian

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1d4660a1915b3..377e7d4139d87 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3299,6 +3299,40 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_PREEMPT_RT
+static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
+{
+	unsigned long flags;
+	bool mismatch;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	mismatch = READ_ONCE(p->__state) != match_state &&
+		READ_ONCE(p->saved_state) != match_state;
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	return mismatch;
+}
+static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
+					bool *wait)
+{
+	if (READ_ONCE(p->__state) == match_state)
+		return true;
+	if (READ_ONCE(p->saved_state) != match_state)
+		return false;
+	*wait = true;
+	return true;
+}
+#else
+static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
+{
+	return READ_ONCE(p->__state) != match_state;
+}
+static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
+					bool *wait)
+{
+	return READ_ONCE(p->__state) == match_state;
+}
+#endif
+
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
@@ -3317,12 +3351,10 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
  */
 unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
 {
-	int running, queued;
+	bool running, wait;
 	struct rq_flags rf;
 	unsigned long ncsw;
 	struct rq *rq;
-	bool saved_state_match;
-	bool update_ncsw;
 
 	for (;;) {
 		/*
@@ -3345,24 +3377,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-
-			if (match_state) {
-				bool mismatch = false;
-#ifndef CONFIG_PREEMPT_RT
-				if (READ_ONCE(p->__state != match_state)
-					mismatch = true;
-#else
-				unsigned long flags;
-
-				raw_spin_lock_irqsave(&p->pi_lock, flags);
-				if (READ_ONCE(p->__state) != match_state &&
-				    READ_ONCE(p->saved_state) != match_state)
-					mismatch = true;
-				raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-#endif
-				if (mismatch)
-					return 0;
-			}
+			if (match_state && state_mismatch(p, match_state))
+				return 0;
 			cpu_relax();
 		}
 
@@ -3374,24 +3390,12 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		rq = task_rq_lock(p, &rf);
 		trace_sched_wait_task(p);
 		running = task_running(rq, p);
-		queued = task_on_rq_queued(p);
+		wait = task_on_rq_queued(p);
 		ncsw = 0;
-		update_ncsw = false;
-		saved_state_match = false;
 
-		if (!match_state) {
-			update_ncsw = true;
-		} else if (READ_ONCE(p->__state) == match_state) {
-			update_ncsw = true;
-#ifdef CONFIG_PREEMPT_RT
-		} else if (READ_ONCE(p->saved_state) == match_state) {
-			update_ncsw = true;
-			saved_state_match = true;
-#endif
-		}
-
-		if (update_ncsw)
+		if (!match_state || state_match(p, match_state, &wait))
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
+
 		task_rq_unlock(rq, p, &rf);
 
 		/*
@@ -3420,7 +3424,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * running right now), it's preempted, and we should
 		 * yield - it could be a while.
 		 */
-		if (unlikely(queued) || saved_state_match) {
+		if (unlikely(wait)) {
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
