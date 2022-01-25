Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19D149A8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1321490AbiAYDSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:18:40 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:49031 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1318647AbiAYDGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:06:53 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 25 Jan 2022 11:36:46 +0900
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
Subject: [RFC 03/14] dept: Embed Dept data in Lockdep
Date:   Tue, 25 Jan 2022 11:36:33 +0900
Message-Id: <1643078204-12663-4-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
References: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dept should work independently from Lockdep. However, there's no choise
but to rely on Lockdep code and its instances for now.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/lockdep.h       | 71 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/lockdep_types.h |  3 ++
 kernel/locking/lockdep.c      | 12 ++++----
 3 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index f559487..bcd9d7d 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -20,6 +20,33 @@
 extern int prove_locking;
 extern int lock_stat;
 
+#ifdef CONFIG_DEPT
+static inline void dept_after_copy_map(struct dept_map *to,
+				       struct dept_map *from)
+{
+	int i;
+
+	if (from->keys == &from->keys_local)
+		to->keys = &to->keys_local;
+
+	if (!to->keys)
+		return;
+
+	/*
+	 * Since the class cache can be modified concurrently we could observe
+	 * half pointers (64bit arch using 32bit copy insns). Therefore clear
+	 * the caches and take the performance hit.
+	 *
+	 * XXX it doesn't work well with lockdep_set_class_and_subclass(), since
+	 *     that relies on cache abuse.
+	 */
+	for (i = 0; i < DEPT_MAX_SUBCLASSES_CACHE; i++)
+		to->keys->classes[i] = NULL;
+}
+#else
+#define dept_after_copy_map(t, f)	do { } while (0)
+#endif
+
 #ifdef CONFIG_LOCKDEP
 
 #include <linux/linkage.h>
@@ -43,6 +70,8 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 	 */
 	for (i = 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
 		to->class_cache[i] = NULL;
+
+	dept_after_copy_map(&to->dmap, &from->dmap);
 }
 
 /*
@@ -176,8 +205,19 @@ struct held_lock {
 	current->lockdep_recursion -= LOCKDEP_OFF;	\
 } while (0)
 
-extern void lockdep_register_key(struct lock_class_key *key);
-extern void lockdep_unregister_key(struct lock_class_key *key);
+extern void __lockdep_register_key(struct lock_class_key *key);
+extern void __lockdep_unregister_key(struct lock_class_key *key);
+
+#define lockdep_register_key(k)				\
+do {							\
+	__lockdep_register_key(k);			\
+	dept_key_init(&(k)->dkey);			\
+} while (0)
+#define lockdep_unregister_key(k)			\
+do {							\
+	__lockdep_unregister_key(k);			\
+	dept_key_destroy(&(k)->dkey);			\
+} while (0)
 
 /*
  * These methods are used by specific locking variants (spinlocks,
@@ -185,9 +225,18 @@ struct held_lock {
  * to lockdep:
  */
 
-extern void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
+extern void __lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 	struct lock_class_key *key, int subclass, short inner, short outer);
 
+#define lockdep_init_map_waits(l, n, k, s, i, o)		\
+do {								\
+	__lockdep_init_map_waits(l, n, k, s, i, o);		\
+	if ((k) == &__lockdep_no_validate__)			\
+		dept_map_nocheck(&(l)->dmap);			\
+	else							\
+		dept_map_init(&(l)->dmap, &(k)->dkey, s, n);	\
+} while (0)
+
 static inline void
 lockdep_init_map_wait(struct lockdep_map *lock, const char *name,
 		      struct lock_class_key *key, int subclass, short inner)
@@ -398,13 +447,27 @@ enum xhlock_context_t {
 	XHLOCK_CTX_NR,
 };
 
+#ifdef CONFIG_DEPT
+/*
+ * TODO: I found the case to use an address of other than a real key as
+ * _key, for instance, in workqueue. So for now, we cannot use the
+ * assignment like '.dmap.keys = &(_key)->dkey' unless it's fixed.
+ */
+#define STATIC_DEPT_MAP_INIT(_name, _key) .dmap = {		\
+	.name = (_name),					\
+	.keys = NULL },
+#else
+#define STATIC_DEPT_MAP_INIT(_name, _key)
+#endif
+
 #define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
 /*
  * To initialize a lockdep_map statically use this macro.
  * Note that _name must not be NULL.
  */
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
-	{ .name = (_name), .key = (void *)(_key), }
+	{ .name = (_name), .key = (void *)(_key), \
+	STATIC_DEPT_MAP_INIT(_name, _key) }
 
 static inline void lockdep_invariant_state(bool force) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 9a1fd49..822ab1d 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -11,6 +11,7 @@
 #define __LINUX_LOCKDEP_TYPES_H
 
 #include <linux/types.h>
+#include <linux/dept.h>
 
 #define MAX_LOCKDEP_SUBCLASSES		8UL
 
@@ -70,6 +71,7 @@ struct lock_class_key {
 		struct hlist_node		hash_entry;
 		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
 	};
+	struct dept_key				dkey;
 };
 
 extern struct lock_class_key __lockdep_no_validate__;
@@ -175,6 +177,7 @@ struct lockdep_map {
 	int				cpu;
 	unsigned long			ip;
 #endif
+	struct dept_map			dmap;
 };
 
 struct pin_cookie { unsigned int val; };
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c1418b47..b649588 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1168,7 +1168,7 @@ static inline struct hlist_head *keyhashentry(const struct lock_class_key *key)
 }
 
 /* Register a dynamically allocated key. */
-void lockdep_register_key(struct lock_class_key *key)
+void __lockdep_register_key(struct lock_class_key *key)
 {
 	struct hlist_head *hash_head;
 	struct lock_class_key *k;
@@ -1191,7 +1191,7 @@ void lockdep_register_key(struct lock_class_key *key)
 restore_irqs:
 	raw_local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(lockdep_register_key);
+EXPORT_SYMBOL_GPL(__lockdep_register_key);
 
 /* Check whether a key has been registered as a dynamic key. */
 static bool is_dynamic_key(const struct lock_class_key *key)
@@ -4577,7 +4577,7 @@ static inline int check_wait_context(struct task_struct *curr,
 /*
  * Initialize a lock instance's lock-class mapping info:
  */
-void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
+void __lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 			    struct lock_class_key *key, int subclass,
 			    short inner, short outer)
 {
@@ -4636,7 +4636,7 @@ void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 		raw_local_irq_restore(flags);
 	}
 }
-EXPORT_SYMBOL_GPL(lockdep_init_map_waits);
+EXPORT_SYMBOL_GPL(__lockdep_init_map_waits);
 
 struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
@@ -6085,7 +6085,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 }
 
 /* Unregister a dynamically allocated key. */
-void lockdep_unregister_key(struct lock_class_key *key)
+void __lockdep_unregister_key(struct lock_class_key *key)
 {
 	struct hlist_head *hash_head = keyhashentry(key);
 	struct lock_class_key *k;
@@ -6120,7 +6120,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
 	synchronize_rcu();
 }
-EXPORT_SYMBOL_GPL(lockdep_unregister_key);
+EXPORT_SYMBOL_GPL(__lockdep_unregister_key);
 
 void __init lockdep_init(void)
 {
-- 
1.9.1

