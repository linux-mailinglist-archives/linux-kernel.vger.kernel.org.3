Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0673469D9F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387522AbhLFPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:31:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357905AbhLFPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:19:20 -0500
Date:   Mon, 06 Dec 2021 15:15:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nffRp43qW/3HIS11dRlZc3H/uUEMjbw6d/VF30+ov4=;
        b=E6FrqWZ5IiFd/dRmJ+U++/9JiTk6VVF7pSf5zto6mjqPUXay3EQpZDcGdEev2wb2jG+Xvy
        oaBWUWMIjLRslLqjSF5g6qCwjsvw54szwny20TpYhwTvlsv9yHy7asfpz/jubCiIOBEp7V
        trVvbDteslJxt1VHRcxsE+W+mo/5ujCCbw5Nx8KYxfE0LudHe7ZkEqzBx5endFSA27R2ca
        Yj4ZJLiID+LGJaOzYqLzt7oovbCmj0eKYRdLfTUgBYyhfFDInTKHv2KJf2Qnf1fCnrdNhm
        l7/cRcaLE6TuAmc4xKkJa4S3a8Id8wzsIxlT1VNGoOX05dkJyauyW4kx7dk5rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nffRp43qW/3HIS11dRlZc3H/uUEMjbw6d/VF30+ov4=;
        b=ctFfReNmFhT+xlJkDpsvoOUSAtjG7KjzaK7OobnXkZZ/Fmc1w9WQae8cTweBxc0oJYWC2G
        5G6bMwK/Lj7BS3DA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Add rt_mutex_lock_nest_lock()
 and rt_mutex_lock_killable().
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-5-bigeasy@linutronix.de>
References: <20211129174654.668506-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163880374782.11128.1123821944123050508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a3642021923b26d86bb27d88c826494827612c06
Gitweb:        https://git.kernel.org/tip/a3642021923b26d86bb27d88c826494827612c06
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 29 Nov 2021 18:46:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:23 +01:00

locking/rtmutex: Add rt_mutex_lock_nest_lock() and rt_mutex_lock_killable().

The locking selftest for ww-mutex expects to operate directly on the
base-mutex which becomes a rtmutex on PREEMPT_RT.

Add a rtmutex based implementation of mutex_lock_nest_lock() and
mutex_lock_killable() named rt_mutex_lock_nest_lock() abd
rt_mutex_lock_killable().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211129174654.668506-5-bigeasy@linutronix.de
---
 include/linux/rtmutex.h      |  9 +++++++++
 kernel/locking/rtmutex_api.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 9deedfe..7d04988 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -99,13 +99,22 @@ extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
+extern void _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockdep_map *nest_lock);
 #define rt_mutex_lock(lock) rt_mutex_lock_nested(lock, 0)
+#define rt_mutex_lock_nest_lock(lock, nest_lock)			\
+	do {								\
+		typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
+		_rt_mutex_lock_nest_lock(lock, &(nest_lock)->dep_map);	\
+	} while (0)
+
 #else
 extern void rt_mutex_lock(struct rt_mutex *lock);
 #define rt_mutex_lock_nested(lock, subclass) rt_mutex_lock(lock)
+#define rt_mutex_lock_nest_lock(lock, nest_lock) rt_mutex_lock(lock)
 #endif
 
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
+extern int rt_mutex_lock_killable(struct rt_mutex *lock);
 extern int rt_mutex_trylock(struct rt_mutex *lock);
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 5c9299a..9002209 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -21,12 +21,13 @@ int max_lock_depth = 1024;
  */
 static __always_inline int __rt_mutex_lock_common(struct rt_mutex *lock,
 						  unsigned int state,
+						  struct lockdep_map *nest_lock,
 						  unsigned int subclass)
 {
 	int ret;
 
 	might_sleep();
-	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, _RET_IP_);
 	ret = __rt_mutex_lock(&lock->rtmutex, state);
 	if (ret)
 		mutex_release(&lock->dep_map, _RET_IP_);
@@ -48,10 +49,16 @@ EXPORT_SYMBOL(rt_mutex_base_init);
  */
 void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
 {
-	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass);
+	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, NULL, subclass);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
 
+void __sched _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockdep_map *nest_lock)
+{
+	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, nest_lock, 0);
+}
+EXPORT_SYMBOL_GPL(_rt_mutex_lock_nest_lock);
+
 #else /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
@@ -61,7 +68,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
  */
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
-	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0);
+	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 #endif
@@ -77,11 +84,26 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
  */
 int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 {
-	return __rt_mutex_lock_common(lock, TASK_INTERRUPTIBLE, 0);
+	return __rt_mutex_lock_common(lock, TASK_INTERRUPTIBLE, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
 /**
+ * rt_mutex_lock_killable - lock a rt_mutex killable
+ *
+ * @lock:		the rt_mutex to be locked
+ *
+ * Returns:
+ *  0		on success
+ * -EINTR	when interrupted by a signal
+ */
+int __sched rt_mutex_lock_killable(struct rt_mutex *lock)
+{
+	return __rt_mutex_lock_common(lock, TASK_KILLABLE, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock_killable);
+
+/**
  * rt_mutex_trylock - try to lock a rt_mutex
  *
  * @lock:	the rt_mutex to be locked
