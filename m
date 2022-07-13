Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0795572ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiGMHIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiGMHIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:08:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95C2E3C13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bf13so9640294pgb.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1rI3NJLOWsk4vsP7I8W/i/0iO2V6TYGkyq9mbykMWmc=;
        b=JsG4DJjxtIuzRTGePgkVD534zkcZvQCGsVUdko8T5lmNcAPW6UZ7mQdZa+W/ofasOE
         h5F3pi8R+hkkB5uAtv/dql08ZOT7mM58lvtRP/IBEX+ST37A5TKH5bwD4EkrUGO6pEAH
         dvNoRUjBgeP79D0rAESigx29AySMMKB/IsH+z6Aye6NLNHvjH6HEoluYULQfUzp3bFYj
         QHB+rmvpmJEhlSc89WoUiwUTIYcwLy6uh8N+c7PVtZ7IQAkK3HtKoBBnemQv5jEaU+mR
         ArdWpkHEGRn0pdJt7xetbSGN4qYvVL4ozKMaoqb33FCtCm9wtwUpWegMri03ixXOiAWK
         rLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rI3NJLOWsk4vsP7I8W/i/0iO2V6TYGkyq9mbykMWmc=;
        b=d/hMn2QCPeCR9Xbb7qEq7ej7yqXL5S12goihyW7btYaoftpMv356eS3OLAGR8RU3t1
         YK5RgoaAjeGEE8QJe4XE2MAeCFQv36+15Bw7yGdiai5LMumta9HyUxzk+cqMod/arMLZ
         PMgZdIhVUaikk+cAV8jCpvkgL2wAItQvVEWectYIXmqG6w65Llo7+9I/kHVaX63PR/Wu
         08jD65Q0FRFz1eHyRz2viULQP1D1sv4be4sPGCH6F9tkvSpVYyZrO+7M8IIcAhJK5LYf
         jmdp90CBVUFwvjZcW1eBJflFRtJz4D35BKIJQ648n8QqrPlhcNuW+O4QyNZowv36ZW5V
         dPFg==
X-Gm-Message-State: AJIora8xNAmQFEXqUsV9PSm3jN5yYvecuLqhEo+DJa3289KWmAXw5ARn
        ysDeJciorkrK/iogC5nvTsM=
X-Google-Smtp-Source: AGRyM1urJp8NIccTLGHfoWd9dsGyW7nWtFqiBcPbYT+WiGVzK84rVNCszlItvcBCs3a43wT/qk2u7A==
X-Received: by 2002:a05:6a00:23d4:b0:52a:e5c1:caa7 with SMTP id g20-20020a056a0023d400b0052ae5c1caa7mr1775750pfc.62.1657696073495;
        Wed, 13 Jul 2022 00:07:53 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:53 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/12] locking/qspinlock: separate pv_wait_node from the non-paravirt path
Date:   Wed, 13 Jul 2022 17:07:03 +1000
Message-Id: <20220713070704.308394-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713070704.308394-1-npiggin@gmail.com>
References: <20220713070704.308394-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pv_wait_node waits until node->locked is non-zero, no need for the
pv case to wait again by also executing the !pv code path.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2ebb946a6b80..3255e7804842 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -506,15 +506,18 @@ static void pv_init_node(struct qnode *node)
  * pv_kick_node() is used to set _Q_SLOW_VAL and fill in hash table on its
  * behalf.
  */
-static void pv_wait_node(struct qnode *node, struct qnode *prev)
+static void pv_wait_node_acquire(struct qnode *node, struct qnode *prev)
 {
 	int loop;
 	bool wait_early;
 
 	for (;;) {
 		for (wait_early = false, loop = SPIN_THRESHOLD; loop; loop--) {
-			if (READ_ONCE(node->locked))
+			if (READ_ONCE(node->locked)) {
+				/* Provide the acquire ordering. */
+				smp_load_acquire(&node->locked);
 				return;
+			}
 			if (pv_wait_early(prev, loop)) {
 				wait_early = true;
 				break;
@@ -556,29 +559,23 @@ static void pv_wait_node(struct qnode *node, struct qnode *prev)
 		lockevent_cond_inc(pv_spurious_wakeup,
 				  !READ_ONCE(node->locked));
 	}
-
-	/*
-	 * By now our node->locked should be 1 and our caller will not actually
-	 * spin-wait for it. We do however rely on our caller to do a
-	 * load-acquire for us.
-	 */
 }
 
 /*
  * Called after setting next->locked = 1 when we're the lock owner.
  *
- * Instead of waking the waiters stuck in pv_wait_node() advance their state
- * such that they're waiting in pv_wait_head_or_lock(), this avoids a
+ * Instead of waking the waiters stuck in pv_wait_node_acquire() advance their
+ * state such that they're waiting in pv_wait_head_or_lock(), this avoids a
  * wake/sleep cycle.
  */
 static void pv_kick_node(struct qspinlock *lock, struct qnode *node)
 {
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
-	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
-	 * observe its next->locked value and advance itself.
+	 * pv_wait_node_acquire(). If OTOH this fails, the vCPU was running and
+	 * will observe its next->locked value and advance itself.
 	 *
-	 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node()
+	 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node_acquire()
 	 *
 	 * The write to next->locked in arch_mcs_spin_unlock_contended()
 	 * must be ordered before the read of node->state in the cmpxchg()
@@ -765,8 +762,8 @@ EXPORT_SYMBOL(__pv_queued_spin_unlock);
 
 #else /* CONFIG_PARAVIRT_SPINLOCKS */
 static __always_inline void pv_init_node(struct qnode *node) { }
-static __always_inline void pv_wait_node(struct qnode *node,
-					 struct qnode *prev) { }
+static __always_inline void pv_wait_node_acquire(struct qnode *node,
+						 struct qnode *prev) { }
 static __always_inline void pv_kick_node(struct qspinlock *lock,
 					 struct qnode *node) { }
 static __always_inline u32  pv_wait_head_or_lock(struct qspinlock *lock,
@@ -864,10 +861,11 @@ static __always_inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, b
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
 
-		if (paravirt)
-			pv_wait_node(node, prev);
 		/* Wait for mcs node lock to be released */
-		smp_cond_load_acquire(&node->locked, VAL);
+		if (paravirt)
+			pv_wait_node_acquire(node, prev);
+		else
+			smp_cond_load_acquire(&node->locked, VAL);
 
 		/*
 		 * While waiting for the MCS lock, the next pointer may have
-- 
2.35.1

