Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C344EEBE4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbiDAK7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiDAK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:59:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D4C26B3A7;
        Fri,  1 Apr 2022 03:57:44 -0700 (PDT)
Date:   Fri, 1 Apr 2022 12:57:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648810663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/7N1HR5Tgltj8+MZZuxlysA6sc9VMTIUsAdh5kS4RTA=;
        b=aPFjJHvFF5LbvY9qCytGgM2ii27lyxB/bE0iWZ0KRvMl6AnaGYrfs2dYMnKIKWA6OG3dRS
        mxbZUx3XtunOQUtT8ITf8ehkoo16jJPkJwdWBigMA+AgH0c71tGgNio5+p/qwk8DmAT2+J
        /lcEFhXmOIYtWiV/vyeCcR0St2vM/shQfsKT8Oks3oeej0Ieh6sYGyRT7kfnnNTvh9vqCb
        C8GKuvboeyQWWLA/2R40zKzbh9DXFWX/fpAUz6+WS4sd4eMT8JUsexxNMUoBQd73B/P+Yf
        De+wn8OAfSbCOCNGGL0dapj/mVaucP6uqAxznAaHDSnhGL8TLLsAkgCAoza/uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648810663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/7N1HR5Tgltj8+MZZuxlysA6sc9VMTIUsAdh5kS4RTA=;
        b=zGgraDMZP9Sn9SkD+x4uknNUCKwrGAydhEuge7rTZKQexHtIdQ0iFhfnzwPYti6RMweVM0
        83Gy2kBvLVLxZzDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.17.1-rt17
Message-ID: <Ykbapdep6CxfSIOf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.17.1-rt17 patch set. 

Changes since v5.17.1-rt16:

  - Update the "ptrace: fix ptrace vs tasklist_lock race" patch:

    - The rework in v5.17-rc6-rt11 caused a bug which may update the
      wrong state during a ptrace operation.

    - wait_task_inactive() waits for the expected task state and ensures
      that the task is not blocked on a lock.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.17.1-rt16 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/incr/patch-5.17.1-rt16-rt17.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.17.1-rt17

The RT patch against v5.17.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patch-5.17.1-rt17.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patches-5.17.1-rt17.tar.xz

Sebastian

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3df4ab414f1ad..94ead66808a50 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2058,21 +2058,22 @@ static inline bool task_state_match_and(struct task_struct *tsk, long state)
 	return match;
 }
 
-static inline bool __task_state_match_eq(struct task_struct *tsk, long state)
+static inline int __task_state_match_eq(struct task_struct *tsk, long state)
 {
-	bool match = false;
+	int match = 0;
 
 	if (READ_ONCE(tsk->__state) == state)
-		match = true;
+		match = 1;
 	else if (tsk->saved_state == state)
-		match = true;
+		match = -1;
+
 	return match;
 }
 
-static inline bool task_state_match_eq(struct task_struct *tsk, long state)
+static inline int task_state_match_eq(struct task_struct *tsk, long state)
 {
 	unsigned long flags;
-	bool match;
+	int match;
 
 	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
 	match = __task_state_match_eq(tsk, state);
@@ -2091,7 +2092,7 @@ static inline bool task_state_match_and_set(struct task_struct *tsk, long state,
 		WRITE_ONCE(tsk->__state, new_state);
 		match = true;
 	} else if (tsk->saved_state & state) {
-		tsk->__state = new_state;
+		tsk->saved_state = new_state;
 		match = true;
 	}
 	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
@@ -2123,12 +2124,12 @@ static inline bool task_state_match_and(struct task_struct *tsk, long state)
 	return READ_ONCE(tsk->__state) & state;
 }
 
-static inline bool __task_state_match_eq(struct task_struct *tsk, long state)
+static inline int __task_state_match_eq(struct task_struct *tsk, long state)
 {
 	return READ_ONCE(tsk->__state) == state;
 }
 
-static inline bool task_state_match_eq(struct task_struct *tsk, long state)
+static inline int task_state_match_eq(struct task_struct *tsk, long state)
 {
 	return __task_state_match_eq(tsk, state);
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 33ce5cd113d82..7cda920dc6939 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3261,6 +3261,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 	struct rq *rq;
 
 	for (;;) {
+		int match_type = 0;
+
 		/*
 		 * We do the initial early heuristics without holding
 		 * any task-queue locks at all. We'll only try to get
@@ -3297,7 +3299,9 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_running(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || __task_state_match_eq(p, match_state))
+		if (match_state)
+			match_type = __task_state_match_eq(p, match_state);
+		if (!match_state || match_type)
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
@@ -3327,7 +3331,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * running right now), it's preempted, and we should
 		 * yield - it could be a while.
 		 */
-		if (unlikely(queued)) {
+		if (unlikely(queued || match_type < 0)) {
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
diff --git a/localversion-rt b/localversion-rt
index 1199ebade17b4..1e584b47c987e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt16
+-rt17
