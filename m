Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFA44BA8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244649AbiBQS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:56:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242730AbiBQS4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:56:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81E71139;
        Thu, 17 Feb 2022 10:56:28 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124187;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxMgh3IDNwIzEm2KVoQUUi/pn3xQij1vRbLpdOlGqPQ=;
        b=YrwDHAdB3pB4qq5VzBCqsL0iVNRuAmB3rR6wZpMssviSOzeWdJCHr0imGnig6fV/XXeiOm
        87w7VKZU55o/S7/WqetQP0phlMwHr1qJJ0AEeEAzXnsgRJivf5Iprvf8YP+MCLSbi6p7TV
        5IIWlVQir/12GV4tOpK+NoKLWamzYM0Nq1BqTEt/4FEZ7vxj+4GIvHVpegfzcZgffi9KYw
        Zq69sg1CZrNDCWKKK/bzZR3AU4z/UhtwR95Z/pbSKY025azTEh+4qWt7Py15Ga1qTB295g
        O+hBrHtRTOOHxGevi3xVLtkoM7+sGwDUa4+0nRJdi2sgJ1tOybcnxVMjb8K//w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124187;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxMgh3IDNwIzEm2KVoQUUi/pn3xQij1vRbLpdOlGqPQ=;
        b=NP8AlD7DUeIYg3Iwjzo2RxqCxhNskhSoyLWSo/qEpQvkR6fCvUvSeMd8cbAgM1UjHJgrAI
        7RSmK5gRJfbJ/kAw==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Iterate lock_classes directly
 when reading lockdep files
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220211035526.1329503-2-longman@redhat.com>
References: <20220211035526.1329503-2-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <164512418573.16921.10863107150064972616.tip-bot2@tip-bot2>
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

Commit-ID:     fb7275acd6fb988313dddd8d3d19efa70d9015ad
Gitweb:        https://git.kernel.org/tip/fb7275acd6fb988313dddd8d3d19efa70d9015ad
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 10 Feb 2022 22:55:26 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:58 +01:00

locking/lockdep: Iterate lock_classes directly when reading lockdep files

When dumping lock_classes information via /proc/lockdep, we can't take
the lockdep lock as the lock hold time is indeterminate. Iterating
over all_lock_classes without holding lock can be dangerous as there
is a slight chance that it may branch off to other lists leading to
infinite loop or even access invalid memory if changes are made to
all_lock_classes list in parallel.

To avoid this problem, iteration of lock classes is now done directly
on the lock_classes array itself. The lock_classes_in_use bitmap is
checked to see if the lock class is being used. To avoid iterating
the full array all the times, a new max_lock_class_idx value is added
to track the maximum lock_class index that is currently being used.

We can theoretically take the lockdep lock for iterating all_lock_classes
when other lockdep files (lockdep_stats and lock_stat) are accessed as
the lock hold time will be shorter for them. For consistency, they are
also modified to iterate the lock_classes array directly.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220211035526.1329503-2-longman@redhat.com
---
 kernel/locking/lockdep.c           | 14 +++++---
 kernel/locking/lockdep_internals.h |  6 ++-
 kernel/locking/lockdep_proc.c      | 51 ++++++++++++++++++++++++-----
 3 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2e6892e..50036c1 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -183,11 +183,9 @@ static DECLARE_BITMAP(list_entries_in_use, MAX_LOCKDEP_ENTRIES);
 static struct hlist_head lock_keys_hash[KEYHASH_SIZE];
 unsigned long nr_lock_classes;
 unsigned long nr_zapped_classes;
-#ifndef CONFIG_DEBUG_LOCKDEP
-static
-#endif
+unsigned long max_lock_class_idx;
 struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
-static DECLARE_BITMAP(lock_classes_in_use, MAX_LOCKDEP_KEYS);
+DECLARE_BITMAP(lock_classes_in_use, MAX_LOCKDEP_KEYS);
 
 static inline struct lock_class *hlock_class(struct held_lock *hlock)
 {
@@ -338,7 +336,7 @@ static inline void lock_release_holdtime(struct held_lock *hlock)
  * elements. These elements are linked together by the lock_entry member in
  * struct lock_class.
  */
-LIST_HEAD(all_lock_classes);
+static LIST_HEAD(all_lock_classes);
 static LIST_HEAD(free_lock_classes);
 
 /**
@@ -1252,6 +1250,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	struct lockdep_subclass_key *key;
 	struct hlist_head *hash_head;
 	struct lock_class *class;
+	int idx;
 
 	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1317,6 +1316,9 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	 * of classes.
 	 */
 	list_move_tail(&class->lock_entry, &all_lock_classes);
+	idx = class - lock_classes;
+	if (idx > max_lock_class_idx)
+		max_lock_class_idx = idx;
 
 	if (verbose(class)) {
 		graph_unlock();
@@ -6000,6 +6002,8 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		WRITE_ONCE(class->name, NULL);
 		nr_lock_classes--;
 		__clear_bit(class - lock_classes, lock_classes_in_use);
+		if (class - lock_classes == max_lock_class_idx)
+			max_lock_class_idx--;
 	} else {
 		WARN_ONCE(true, "%s() failed for class %s\n", __func__,
 			  class->name);
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index ecb8662..bbe9000 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -121,7 +121,6 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 
 #define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
 
-extern struct list_head all_lock_classes;
 extern struct lock_chain lock_chains[];
 
 #define LOCK_USAGE_CHARS (2*XXX_LOCK_USAGE_STATES + 1)
@@ -151,6 +150,10 @@ extern unsigned int nr_large_chain_blocks;
 
 extern unsigned int max_lockdep_depth;
 extern unsigned int max_bfs_queue_depth;
+extern unsigned long max_lock_class_idx;
+
+extern struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
+extern unsigned long lock_classes_in_use[];
 
 #ifdef CONFIG_PROVE_LOCKING
 extern unsigned long lockdep_count_forward_deps(struct lock_class *);
@@ -205,7 +208,6 @@ struct lockdep_stats {
 };
 
 DECLARE_PER_CPU(struct lockdep_stats, lockdep_stats);
-extern struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
 
 #define __debug_atomic_inc(ptr)					\
 	this_cpu_inc(lockdep_stats.ptr);
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index b8d9a05..15fdc7f 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -24,14 +24,33 @@
 
 #include "lockdep_internals.h"
 
+/*
+ * Since iteration of lock_classes is done without holding the lockdep lock,
+ * it is not safe to iterate all_lock_classes list directly as the iteration
+ * may branch off to free_lock_classes or the zapped list. Iteration is done
+ * directly on the lock_classes array by checking the lock_classes_in_use
+ * bitmap and max_lock_class_idx.
+ */
+#define iterate_lock_classes(idx, class)				\
+	for (idx = 0, class = lock_classes; idx <= max_lock_class_idx;	\
+	     idx++, class++)
+
 static void *l_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	return seq_list_next(v, &all_lock_classes, pos);
+	struct lock_class *class = v;
+
+	++class;
+	*pos = class - lock_classes;
+	return (*pos > max_lock_class_idx) ? NULL : class;
 }
 
 static void *l_start(struct seq_file *m, loff_t *pos)
 {
-	return seq_list_start_head(&all_lock_classes, *pos);
+	unsigned long idx = *pos;
+
+	if (idx > max_lock_class_idx)
+		return NULL;
+	return lock_classes + idx;
 }
 
 static void l_stop(struct seq_file *m, void *v)
@@ -57,14 +76,16 @@ static void print_name(struct seq_file *m, struct lock_class *class)
 
 static int l_show(struct seq_file *m, void *v)
 {
-	struct lock_class *class = list_entry(v, struct lock_class, lock_entry);
+	struct lock_class *class = v;
 	struct lock_list *entry;
 	char usage[LOCK_USAGE_CHARS];
+	int idx = class - lock_classes;
 
-	if (v == &all_lock_classes) {
+	if (v == lock_classes)
 		seq_printf(m, "all lock classes:\n");
+
+	if (!test_bit(idx, lock_classes_in_use))
 		return 0;
-	}
 
 	seq_printf(m, "%p", class->key);
 #ifdef CONFIG_DEBUG_LOCKDEP
@@ -220,8 +241,11 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_PROVE_LOCKING
 	struct lock_class *class;
+	unsigned long idx;
 
-	list_for_each_entry(class, &all_lock_classes, lock_entry) {
+	iterate_lock_classes(idx, class) {
+		if (!test_bit(idx, lock_classes_in_use))
+			continue;
 
 		if (class->usage_mask == 0)
 			nr_unused++;
@@ -254,6 +278,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 
 		sum_forward_deps += lockdep_count_forward_deps(class);
 	}
+
 #ifdef CONFIG_DEBUG_LOCKDEP
 	DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused);
 #endif
@@ -345,6 +370,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, " max bfs queue depth:           %11u\n",
 			max_bfs_queue_depth);
 #endif
+	seq_printf(m, " max lock class index:          %11lu\n",
+			max_lock_class_idx);
 	lockdep_stats_debug_show(m);
 	seq_printf(m, " debug_locks:                   %11u\n",
 			debug_locks);
@@ -622,12 +649,16 @@ static int lock_stat_open(struct inode *inode, struct file *file)
 	if (!res) {
 		struct lock_stat_data *iter = data->stats;
 		struct seq_file *m = file->private_data;
+		unsigned long idx;
 
-		list_for_each_entry(class, &all_lock_classes, lock_entry) {
+		iterate_lock_classes(idx, class) {
+			if (!test_bit(idx, lock_classes_in_use))
+				continue;
 			iter->class = class;
 			iter->stats = lock_stats(class);
 			iter++;
 		}
+
 		data->iter_end = iter;
 
 		sort(data->stats, data->iter_end - data->stats,
@@ -645,6 +676,7 @@ static ssize_t lock_stat_write(struct file *file, const char __user *buf,
 			       size_t count, loff_t *ppos)
 {
 	struct lock_class *class;
+	unsigned long idx;
 	char c;
 
 	if (count) {
@@ -654,8 +686,11 @@ static ssize_t lock_stat_write(struct file *file, const char __user *buf,
 		if (c != '0')
 			return count;
 
-		list_for_each_entry(class, &all_lock_classes, lock_entry)
+		iterate_lock_classes(idx, class) {
+			if (!test_bit(idx, lock_classes_in_use))
+				continue;
 			clear_lock_stats(class);
+		}
 	}
 	return count;
 }
