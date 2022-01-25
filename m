Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117B049A8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351507AbiAYDQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:16:39 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:49049 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1318652AbiAYDGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:06:51 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 25 Jan 2022 11:36:47 +0900
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
Subject: [RFC 09/14] dept: Apply Dept to rwsem
Date:   Tue, 25 Jan 2022 11:36:39 +0900
Message-Id: <1643078204-12663-10-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
References: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes Dept able to track dependencies by rwsem.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/lockdep.h      | 24 ++++++++++++++++++++----
 include/linux/percpu-rwsem.h | 10 +++++++++-
 include/linux/rwsem.h        | 31 +++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 4653df7..80e665e 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -628,10 +628,26 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 	dept_mutex_unlock(&(l)->dmap, i);				\
 } while (0)
 
-#define rwsem_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define rwsem_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define rwsem_acquire_read(l, s, t, i)		lock_acquire_shared(l, s, t, NULL, i)
-#define rwsem_release(l, i)			lock_release(l, i)
+#define rwsem_acquire(l, s, t, i)					\
+do {									\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+	dept_rwsem_lock(&(l)->dmap, s, t, NULL, "up_write", i);		\
+} while (0)
+#define rwsem_acquire_nest(l, s, t, n, i)				\
+do {									\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+	dept_rwsem_lock(&(l)->dmap, s, t, (n) ? &(n)->dmap : NULL, "up_write", i);\
+} while (0)
+#define rwsem_acquire_read(l, s, t, i)					\
+do {									\
+	lock_acquire_shared(l, s, t, NULL, i);				\
+	dept_rwsem_lock(&(l)->dmap, s, t, NULL, "up_read", i);		\
+} while (0)
+#define rwsem_release(l, i)						\
+do {									\
+	lock_release(l, i);						\
+	dept_rwsem_unlock(&(l)->dmap, i);				\
+} while (0)
 
 #define lock_map_acquire(l)			lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
 #define lock_map_acquire_read(l)		lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 5fda40f..7ec5625 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -20,8 +20,16 @@ struct percpu_rw_semaphore {
 #endif
 };
 
+#ifdef CONFIG_DEPT
+#define __PERCPU_RWSEM_DMAP_INIT(lockname) .dmap = { .name = #lockname }
+#else
+#define __PERCPU_RWSEM_DMAP_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = {	\
+	.name = #lockname,					\
+	__PERCPU_RWSEM_DMAP_INIT(lockname) },
 #else
 #define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)
 #endif
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 25e3fde8..b4a266f 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -20,6 +20,30 @@
 #include <linux/osq_lock.h>
 #endif
 
+#ifdef CONFIG_DEPT
+#define dept_rwsem_lock(m, ne, t, n, e_fn, ip)				\
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
+#define dept_rwsem_unlock(m, ip)					\
+do {									\
+	dept_event(m, 1UL, ip, __func__);				\
+	dept_ecxt_exit(m, ip);						\
+} while (0)
+#else
+#define dept_rwsem_lock(m, ne, t, n, e_fn, ip)	do { } while (0)
+#define dept_rwsem_unlock(m, ip)		do { } while (0)
+#endif
+
 /*
  * For an uncontended rwsem, count and owner are the only fields a task
  * needs to touch when acquiring the rwsem. So they are put next to each
@@ -64,11 +88,18 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 
 /* Common initializer macros and functions */
 
+#ifdef CONFIG_DEPT
+# define RWSEM_DMAP_INIT(lockname)	.dmap = { .name = #lockname },
+#else
+# define RWSEM_DMAP_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __RWSEM_DEP_MAP_INIT(lockname)			\
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
+		RWSEM_DMAP_INIT(lockname)		\
 	},
 #else
 # define __RWSEM_DEP_MAP_INIT(lockname)
-- 
1.9.1

