Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99F04F43B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384026AbiDEM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 08:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbiDEIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6172611E;
        Tue,  5 Apr 2022 01:36:28 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EG76px1djD7LhuP2FsvVqSe9KJ1HtJ99tnTsa5NZMzM=;
        b=pRMPOdbf0QVkChK0gP4+YCQuxX3+9WmS97X8OjgfTavV3P4RpeQKlW3Z6mH5xEeo66YKwf
        NXSw0EuWvnuYD1k3h290JJGp/yjqEL+jxTzQdRORdc8gvzlxryOB8FCktkr03q1AIDTQLJ
        K5io8KYm7foZk/U1/8zDQO8/FdfW08SKnSD40eW+8t0+v9/BbeX1qFYrlkB0X7oMKgjXV9
        wektTMWaGEzJ6l++k/BvaAE7gr9gBy4Wmqk16l8Vfo21TEmEGkyINMQFasjnH9Bn6O7NpB
        rfPkQQ9oj/blbyCRg+RstNgQIMD3d6VLW9xu/wLsIimaVQxMknHCu2l9aibGPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EG76px1djD7LhuP2FsvVqSe9KJ1HtJ99tnTsa5NZMzM=;
        b=9dBD20I1CvVQmxYG2prEh5xPyuA5vlSWB/pWNwzTu1xMrpbUKf54pX53d0cY7aYDdg0kby
        KoWo538drSLmjQDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Make contention tracepoints more
 consistent wrt adaptive spinning
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164914777661.389.2436402911593584852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     dc1f7893a70fe403983bd8492f177bf993940e2c
Gitweb:        https://git.kernel.org/tip/dc1f7893a70fe403983bd8492f177bf993940e2c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Mar 2022 13:06:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:36 +02:00

locking/mutex: Make contention tracepoints more consistent wrt adaptive spinning

Have the trace_contention_*() tracepoints consistently include
adaptive spinning. In order to differentiate between the spinning and
non-spinning states add LCB_F_MUTEX and combine with LCB_F_SPIN.

The consequence is that a mutex contention can now triggler multiple
_begin() tracepoints before triggering an _end().

Additionally, this fixes one path where mutex would trigger _end()
without ever seeing a _begin().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/trace/events/lock.h |  4 +++-
 kernel/locking/mutex.c      | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index b9b6e3e..9ebd081 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -14,6 +14,7 @@
 #define LCB_F_WRITE	(1U << 2)
 #define LCB_F_RT	(1U << 3)
 #define LCB_F_PERCPU	(1U << 4)
+#define LCB_F_MUTEX	(1U << 5)
 
 
 #ifdef CONFIG_LOCKDEP
@@ -113,7 +114,8 @@ TRACE_EVENT(contention_begin,
 				{ LCB_F_READ,		"READ" },
 				{ LCB_F_WRITE,		"WRITE" },
 				{ LCB_F_RT,		"RT" },
-				{ LCB_F_PERCPU,		"PERCPU" }
+				{ LCB_F_PERCPU,		"PERCPU" },
+				{ LCB_F_MUTEX,		"MUTEX" }
 			  ))
 );
 
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index c88deda..d973fe6 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -602,12 +602,14 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	preempt_disable();
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
 
+	trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
 	if (__mutex_trylock(lock) ||
 	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
 		/* got the lock, yay! */
 		lock_acquired(&lock->dep_map, ip);
 		if (ww_ctx)
 			ww_mutex_set_context_fastpath(ww, ww_ctx);
+		trace_contention_end(lock, 0);
 		preempt_enable();
 		return 0;
 	}
@@ -644,7 +646,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	set_current_state(state);
-	trace_contention_begin(lock, 0);
+	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
 		bool first;
 
@@ -684,10 +686,16 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		 * state back to RUNNING and fall through the next schedule(),
 		 * or we must see its unlock and acquire.
 		 */
-		if (__mutex_trylock_or_handoff(lock, first) ||
-		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
+		if (__mutex_trylock_or_handoff(lock, first))
 			break;
 
+		if (first) {
+			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
+			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
+				break;
+			trace_contention_begin(lock, LCB_F_MUTEX);
+		}
+
 		raw_spin_lock(&lock->wait_lock);
 	}
 	raw_spin_lock(&lock->wait_lock);
@@ -723,8 +731,8 @@ skip_wait:
 err:
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
-	trace_contention_end(lock, ret);
 err_early_kill:
+	trace_contention_end(lock, ret);
 	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
