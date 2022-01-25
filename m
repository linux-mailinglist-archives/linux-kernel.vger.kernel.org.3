Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942F049A8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1321146AbiAYDPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:15:53 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:54174 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1318646AbiAYDGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:06:51 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 25 Jan 2022 11:36:46 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.126 with ESMTP; 25 Jan 2022 11:36:46 +0900
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
Subject: [RFC 05/14] dept: Apply Dept to mutex families
Date:   Tue, 25 Jan 2022 11:36:35 +0900
Message-Id: <1643078204-12663-6-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
References: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes Dept able to track dependencies by mutex families.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/lockdep.h | 18 +++++++++++++++---
 include/linux/mutex.h   | 31 +++++++++++++++++++++++++++++++
 include/linux/rtmutex.h | 11 ++++++++++-
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c08e3ae..f558091 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -597,9 +597,21 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 #define seqcount_acquire_read(l, s, t, i)	lock_acquire_shared_recursive(l, s, t, NULL, i)
 #define seqcount_release(l, i)			lock_release(l, i)
 
-#define mutex_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define mutex_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define mutex_release(l, i)			lock_release(l, i)
+#define mutex_acquire(l, s, t, i)					\
+do {									\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+	dept_mutex_lock(&(l)->dmap, s, t, NULL, "mutex_unlock", i);	\
+} while (0)
+#define mutex_acquire_nest(l, s, t, n, i)				\
+do {									\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+	dept_mutex_lock(&(l)->dmap, s, t, (n) ? &(n)->dmap : NULL, "mutex_unlock", i);\
+} while (0)
+#define mutex_release(l, i)						\
+do {									\
+	lock_release(l, i);						\
+	dept_mutex_unlock(&(l)->dmap, i);				\
+} while (0)
 
 #define rwsem_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
 #define rwsem_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index dcd185c..a3477e7 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -76,6 +76,30 @@ struct ww_mutex {
 #endif
 };
 
+#ifdef CONFIG_DEPT
+#define dept_mutex_lock(m, ne, t, n, e_fn, ip)				\
+do {									\
+	if (t) {							\
+		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
+		dept_asked_event(m);					\
+	} else if (n) {							\
+		dept_warn_on(dept_top_map() != (n));			\
+	} else {							\
+		dept_wait(m, 1UL, ip, __func__, ne);			\
+		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
+		dept_asked_event(m);					\
+	}								\
+} while (0)
+#define dept_mutex_unlock(m, ip)					\
+do {									\
+	dept_event(m, 1UL, ip, __func__);				\
+	dept_ecxt_exit(m, ip);						\
+} while (0)
+#else
+#define dept_mutex_lock(m, ne, t, n, e_fn, ip)	do { } while (0)
+#define dept_mutex_unlock(m, ip)		do { } while (0)
+#endif
+
 /*
  * This is the control structure for tasks blocked on mutex,
  * which resides on the blocked task's kernel stack:
@@ -119,11 +143,18 @@ static inline void mutex_destroy(struct mutex *lock) {}
 	__mutex_init((mutex), #mutex, &__key);				\
 } while (0)
 
+#ifdef CONFIG_DEPT
+# define DMAP_MUTEX_INIT(lockname)	.dmap = { .name = #lockname },
+#else
+# define DMAP_MUTEX_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
 		, .dep_map = {					\
 			.name = #lockname,			\
 			.wait_type_inner = LD_WAIT_SLEEP,	\
+			DMAP_MUTEX_INIT(lockname)		\
 		}
 #else
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 6fd615a..52d4444 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -75,9 +75,18 @@ struct rt_mutex {
 # define rt_mutex_debug_task_free(t)			do { } while (0)
 #endif
 
+#ifdef CONFIG_DEPT
+#define DMAP_RT_MUTEX_INIT(mutexname)	.dmap = { .name = #mutexname },
+#else
+#define DMAP_RT_MUTEX_INIT(mutexname)
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname) \
-	, .dep_map = { .name = #mutexname }
+	, .dep_map = {					\
+		.name = #mutexname,			\
+		DMAP_RT_MUTEX_INIT(mutexname)		\
+	}
 #else
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
 #endif
-- 
1.9.1

