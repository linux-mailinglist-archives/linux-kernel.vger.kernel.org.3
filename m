Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23098462580
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhK2WkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbhK2Wjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:39:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28548C0C2366
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:48:29 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2FXE74J5d5ASp/h1fUXdPLOR3QpjPl8hyX22DLa4eE=;
        b=R/Xx7x6/Ah45gSK1Wd0BS3mo5TihurIuQy2uo22PLFqCHvlx7eo1EPW2JCHa5UHzPO2yjK
        FSmMALwgDWIXeBxnCIRxTDwUwAVL5ISThxcSAMG7ZcFvXgKa8xuzMF+alKLRzW6BA8S8cJ
        9BfFnDNy9EEtxOnJ2QyCrjTSHK1pjGd5YQN4+fasYibZW5IfJbynBhSV0gQHvS9ZB7oRGI
        HdSXIMOX8+aCkrZT9G/0nDsB1nkZ0/jTyxwSwDvVsoaENR7aCljC08YgXKb2hAbMIMDMlJ
        hGYPe/qY4hO4iSeKVEULfXs+AEFxCgQG5nkFJrCCmojB4w4AGsE2roMWkvO2og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2FXE74J5d5ASp/h1fUXdPLOR3QpjPl8hyX22DLa4eE=;
        b=3LT4ukaWPqiDqm6dRVLoKRtLHbtN5HNI2+8nggxosgYSwpww5WVQok/XWLHo/9l6U7JRrb
        /i+KNQfFZJQyesDA==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 04/11] locking/rtmutex: Add rt_mutex_lock_nest_lock() and rt_mutex_lock_killable().
Date:   Mon, 29 Nov 2021 18:46:47 +0100
Message-Id: <20211129174654.668506-5-bigeasy@linutronix.de>
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The locking selftest for ww-mutex expects to operate directly on the
base-mutex which becomes a rtmutex on PREEMPT_RT.

Add a rtmutex based implementation of mutex_lock_nest_lock() and
mutex_lock_killable() named rt_mutex_lock_nest_lock() abd
rt_mutex_lock_killable().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rtmutex.h      |  9 +++++++++
 kernel/locking/rtmutex_api.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 9deedfeec2b17..7d049883a08ac 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -99,13 +99,22 @@ extern void __rt_mutex_init(struct rt_mutex *lock, cons=
t char *name, struct lock
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subcl=
ass);
+extern void _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockdep=
_map *nest_lock);
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
=20
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
+extern int rt_mutex_lock_killable(struct rt_mutex *lock);
 extern int rt_mutex_trylock(struct rt_mutex *lock);
=20
 extern void rt_mutex_unlock(struct rt_mutex *lock);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 5c9299aaabae1..900220941caac 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -21,12 +21,13 @@ int max_lock_depth =3D 1024;
  */
 static __always_inline int __rt_mutex_lock_common(struct rt_mutex *lock,
 						  unsigned int state,
+						  struct lockdep_map *nest_lock,
 						  unsigned int subclass)
 {
 	int ret;
=20
 	might_sleep();
-	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, _RET_IP_);
 	ret =3D __rt_mutex_lock(&lock->rtmutex, state);
 	if (ret)
 		mutex_release(&lock->dep_map, _RET_IP_);
@@ -48,10 +49,16 @@ EXPORT_SYMBOL(rt_mutex_base_init);
  */
 void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subc=
lass)
 {
-	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass);
+	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, NULL, subclass);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
=20
+void __sched _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockde=
p_map *nest_lock)
+{
+	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, nest_lock, 0);
+}
+EXPORT_SYMBOL_GPL(_rt_mutex_lock_nest_lock);
+
 #else /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
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
@@ -77,10 +84,25 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
  */
 int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 {
-	return __rt_mutex_lock_common(lock, TASK_INTERRUPTIBLE, 0);
+	return __rt_mutex_lock_common(lock, TASK_INTERRUPTIBLE, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
=20
+/**
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
 /**
  * rt_mutex_trylock - try to lock a rt_mutex
  *
--=20
2.34.0

