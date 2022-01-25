Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EDE49A8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1321097AbiAYDPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:15:45 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:54180 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1318648AbiAYDGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:06:51 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jan 2022 22:06:50 EST
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 25 Jan 2022 11:36:47 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.126 with ESMTP; 25 Jan 2022 11:36:47 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com
Subject: [RFC 06/14] dept: Apply Dept to rwlock
Date:   Tue, 25 Jan 2022 11:36:36 +0900
Message-Id: <1643078204-12663-7-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
References: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes Dept able to track dependencies by rwlock.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/lockdep.h        | 25 +++++++++++++++++-----
 include/linux/rwlock.h         | 48 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/rwlock_api_smp.h |  8 +++----
 include/linux/rwlock_types.h   |  7 ++++++
 4 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index f558091..4653df7 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -582,16 +582,31 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 	dept_spin_unlock(&(l)->dmap, i);				\
 } while (0)
 
-#define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
+#define rwlock_acquire(l, s, t, i)					\
+do {									\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+	dept_rwlock_wlock(&(l)->dmap, s, t, NULL, "write_unlock", i);	\
+} while (0)
 #define rwlock_acquire_read(l, s, t, i)					\
 do {									\
-	if (read_lock_is_recursive())					\
+	if (read_lock_is_recursive()) {				\
 		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
-	else								\
+		dept_rwlock_rlock(&(l)->dmap, s, t, NULL, "read_unlock", i, 0);\
+	} else {							\
 		lock_acquire_shared(l, s, t, NULL, i);			\
+		dept_rwlock_rlock(&(l)->dmap, s, t, NULL, "read_unlock", i, 1);\
+	}								\
+} while (0)
+#define rwlock_release(l, i)						\
+do {									\
+	lock_release(l, i);						\
+	dept_rwlock_wunlock(&(l)->dmap, i);				\
+} while (0)
+#define rwlock_release_read(l, i)					\
+do {									\
+	lock_release(l, i);						\
+	dept_rwlock_runlock(&(l)->dmap, i);				\
 } while (0)
-
-#define rwlock_release(l, i)			lock_release(l, i)
 
 #define seqcount_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
 #define seqcount_acquire_read(l, s, t, i)	lock_acquire_shared_recursive(l, s, t, NULL, i)
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 3dcd617..6792521 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -28,6 +28,54 @@
 	do { *(lock) = __RW_LOCK_UNLOCKED(lock); } while (0)
 #endif
 
+#ifdef CONFIG_DEPT
+#define DEPT_EVT_RWLOCK_R		1UL
+#define DEPT_EVT_RWLOCK_W		(1UL << 1)
+#define DEPT_EVT_RWLOCK_RW		(DEPT_EVT_RWLOCK_R | DEPT_EVT_RWLOCK_W)
+
+#define dept_rwlock_wlock(m, ne, t, n, e_fn, ip)			\
+do {									\
+	if (t) {							\
+		dept_ecxt_enter(m, DEPT_EVT_RWLOCK_W, ip, __func__, e_fn, ne);\
+		dept_asked_event(m);					\
+	} else if (n) {							\
+		dept_warn_on(dept_top_map() != (n));			\
+	} else {							\
+		dept_wait(m, DEPT_EVT_RWLOCK_RW, ip, __func__, ne);	\
+		dept_ecxt_enter(m, DEPT_EVT_RWLOCK_W, ip, __func__, e_fn, ne);\
+		dept_asked_event(m);					\
+	}								\
+}while (0)
+#define dept_rwlock_rlock(m, ne, t, n, e_fn, ip, q)			\
+do {									\
+	if (t) {							\
+		dept_ecxt_enter(m, DEPT_EVT_RWLOCK_R, ip, __func__, e_fn, ne);\
+		dept_asked_event(m);					\
+	} else if (n) {							\
+		dept_warn_on(dept_top_map() != (n));			\
+	} else {							\
+		dept_wait(m, (q) ? DEPT_EVT_RWLOCK_RW : DEPT_EVT_RWLOCK_W, ip, __func__, ne);\
+		dept_ecxt_enter(m, DEPT_EVT_RWLOCK_R, ip, __func__, e_fn, ne);\
+		dept_asked_event(m);					\
+	}								\
+} while (0)
+#define dept_rwlock_wunlock(m, ip)					\
+do {									\
+	dept_event(m, DEPT_EVT_RWLOCK_W, ip, __func__);			\
+	dept_ecxt_exit(m, ip);						\
+} while (0)
+#define dept_rwlock_runlock(m, ip)					\
+do {									\
+	dept_event(m, DEPT_EVT_RWLOCK_R, ip, __func__);			\
+	dept_ecxt_exit(m, ip);						\
+} while (0)
+#else
+#define dept_rwlock_wlock(m, ne, t, n, e_fn, ip)	do { } while (0)
+#define dept_rwlock_rlock(m, ne, t, n, e_fn, ip, q)	do { } while (0)
+#define dept_rwlock_wunlock(m, ip)			do { } while (0)
+#define dept_rwlock_runlock(m, ip)			do { } while (0)
+#endif
+
 #ifdef CONFIG_DEBUG_SPINLOCK
  extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
 #define do_raw_read_lock_flags(lock, flags) do_raw_read_lock(lock)
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index abfb53a..9f47df9 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -222,7 +222,7 @@ static inline void __raw_write_unlock(rwlock_t *lock)
 
 static inline void __raw_read_unlock(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, _RET_IP_);
+	rwlock_release_read(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
 	preempt_enable();
 }
@@ -230,7 +230,7 @@ static inline void __raw_read_unlock(rwlock_t *lock)
 static inline void
 __raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
-	rwlock_release(&lock->dep_map, _RET_IP_);
+	rwlock_release_read(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
 	local_irq_restore(flags);
 	preempt_enable();
@@ -238,7 +238,7 @@ static inline void __raw_read_unlock(rwlock_t *lock)
 
 static inline void __raw_read_unlock_irq(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, _RET_IP_);
+	rwlock_release_read(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
 	local_irq_enable();
 	preempt_enable();
@@ -246,7 +246,7 @@ static inline void __raw_read_unlock_irq(rwlock_t *lock)
 
 static inline void __raw_read_unlock_bh(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, _RET_IP_);
+	rwlock_release_read(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
 	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 }
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 3bd03e1..a366f39 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -21,11 +21,18 @@
 
 #define RWLOCK_MAGIC		0xdeaf1eed
 
+#ifdef CONFIG_DEPT
+# define RW_DMAP_INIT(lockname) .dmap = { .name = #lockname },
+#else
+# define RW_DMAP_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define RW_DEP_MAP_INIT(lockname)					\
 	.dep_map = {							\
 		.name = #lockname,					\
 		.wait_type_inner = LD_WAIT_CONFIG,			\
+		RW_DMAP_INIT(lockname)					\
 	}
 #else
 # define RW_DEP_MAP_INIT(lockname)
-- 
1.9.1

