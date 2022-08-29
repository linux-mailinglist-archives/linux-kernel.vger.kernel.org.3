Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669375A524F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiH2Qys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiH2Qym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:54:42 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D60792DA;
        Mon, 29 Aug 2022 09:54:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661792079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wqRlTTQhXMkzgdQ5i8AvTlYEB1fkqaxcWwTrp0oSCk=;
        b=KYQOz7BO4pscCamhUJeqzpch1wGcuiDLjJMK6NpKcQQD+9EM3o4EzMUcadT4f0kxWVSPK0
        30ySUOgHP+F3dfdS1GOBrvT2CCNmwdyWILV0fPQdCMWdRvZynfHxx+frU1Wzss/wiU7dGR
        QPJV3/juXC4UHRljh5I+R0Xdi7KSWtM=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        colyli@suse.de
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 2/3] bcache: Convert to lib/time_stats
Date:   Mon, 29 Aug 2022 12:53:43 -0400
Message-Id: <20220829165344.2958640-3-kent.overstreet@linux.dev>
In-Reply-To: <20220829165344.2958640-1-kent.overstreet@linux.dev>
References: <20220829165344.2958640-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts bcache to the new generic time_stats code
lib/time_stats.c. The new code is from bcachefs, and has some changes
from the version in bcache:

 - we now use ktime_get_ns(), not local_clock(). When the code was
   originally written multi processor systems that lacked synchronized
   TSCs were still common, and so local_clock() was much cheaper than
   sched_clock() (though not necessarily fully accurate, due to TSC
   drift). ktime_get_ns() should be cheap enough on all common hardware
   now, and more standard/correct.

 - time_stats are now exported in a single file in sysfs, which means we
   can improve the statistics we keep track of without changing all
   users. This also means we don't have to manually specify which units
   (ms, us, ns) a given time_stats should be printed in; that's handled
   dynamically.

 - There's a lazily-allocated percpu buffer, which now needs to be freed
   with time_stats_exit().

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/Kconfig  |  1 +
 drivers/md/bcache/bcache.h |  1 +
 drivers/md/bcache/bset.c   |  8 +++---
 drivers/md/bcache/bset.h   |  1 +
 drivers/md/bcache/btree.c  | 12 ++++----
 drivers/md/bcache/super.c  |  3 ++
 drivers/md/bcache/sysfs.c  | 43 ++++++++++++++++++++--------
 drivers/md/bcache/util.c   | 30 --------------------
 drivers/md/bcache/util.h   | 57 --------------------------------------
 9 files changed, 47 insertions(+), 109 deletions(-)

diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
index 529c9d04e9..8d165052e5 100644
--- a/drivers/md/bcache/Kconfig
+++ b/drivers/md/bcache/Kconfig
@@ -4,6 +4,7 @@ config BCACHE
 	tristate "Block device as cache"
 	select BLOCK_HOLDER_DEPRECATED if SYSFS
 	select CRC64
+	select TIME_STATS
 	help
 	Allows a block device to be used as cache for other devices; uses
 	a btree for indexing and the layout is optimized for SSDs.
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 2acda9cea0..5100010a38 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -185,6 +185,7 @@
 #include <linux/rbtree.h>
 #include <linux/rwsem.h>
 #include <linux/refcount.h>
+#include <linux/time_stats.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index 94d38e8a59..727e9b7aea 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -1251,7 +1251,7 @@ static void __btree_sort(struct btree_keys *b, struct btree_iter *iter,
 		order = state->page_order;
 	}
 
-	start_time = local_clock();
+	start_time = ktime_get_ns();
 
 	btree_mergesort(b, out, iter, fixup, false);
 	b->nsets = start;
@@ -1286,7 +1286,7 @@ static void __btree_sort(struct btree_keys *b, struct btree_iter *iter,
 	bch_bset_build_written_tree(b);
 
 	if (!start)
-		bch_time_stats_update(&state->time, start_time);
+		time_stats_update(&state->time, start_time);
 }
 
 void bch_btree_sort_partial(struct btree_keys *b, unsigned int start,
@@ -1322,14 +1322,14 @@ void bch_btree_sort_and_fix_extents(struct btree_keys *b,
 void bch_btree_sort_into(struct btree_keys *b, struct btree_keys *new,
 			 struct bset_sort_state *state)
 {
-	uint64_t start_time = local_clock();
+	uint64_t start_time = ktime_get_ns();
 	struct btree_iter iter;
 
 	bch_btree_iter_init(b, &iter, NULL);
 
 	btree_mergesort(b, new->set->data, &iter, false, true);
 
-	bch_time_stats_update(&state->time, start_time);
+	time_stats_update(&state->time, start_time);
 
 	new->set->size = 0; // XXX: why?
 }
diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index d795c84246..13e524ad77 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -3,6 +3,7 @@
 #define _BCACHE_BSET_H
 
 #include <linux/kernel.h>
+#include <linux/time_stats.h>
 #include <linux/types.h>
 
 #include "bcache_ondisk.h"
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 147c493a98..abf543bc75 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -242,7 +242,7 @@ static void btree_node_read_endio(struct bio *bio)
 
 static void bch_btree_node_read(struct btree *b)
 {
-	uint64_t start_time = local_clock();
+	uint64_t start_time = ktime_get_ns();
 	struct closure cl;
 	struct bio *bio;
 
@@ -270,7 +270,7 @@ static void bch_btree_node_read(struct btree *b)
 		goto err;
 
 	bch_btree_node_read_done(b);
-	bch_time_stats_update(&b->c->btree_read_time, start_time);
+	time_stats_update(&b->c->btree_read_time, start_time);
 
 	return;
 err:
@@ -1789,7 +1789,7 @@ static void bch_btree_gc(struct cache_set *c)
 	struct gc_stat stats;
 	struct closure writes;
 	struct btree_op op;
-	uint64_t start_time = local_clock();
+	uint64_t start_time = ktime_get_ns();
 
 	trace_bcache_gc_start(c);
 
@@ -1815,7 +1815,7 @@ static void bch_btree_gc(struct cache_set *c)
 	bch_btree_gc_finish(c);
 	wake_up_allocators(c);
 
-	bch_time_stats_update(&c->btree_gc_time, start_time);
+	time_stats_update(&c->btree_gc_time, start_time);
 
 	stats.key_bytes *= sizeof(uint64_t);
 	stats.data	<<= 9;
@@ -2191,7 +2191,7 @@ static int btree_split(struct btree *b, struct btree_op *op,
 {
 	bool split;
 	struct btree *n1, *n2 = NULL, *n3 = NULL;
-	uint64_t start_time = local_clock();
+	uint64_t start_time = ktime_get_ns();
 	struct closure cl;
 	struct keylist parent_keys;
 
@@ -2297,7 +2297,7 @@ static int btree_split(struct btree *b, struct btree_op *op,
 	btree_node_free(b);
 	rw_unlock(true, n1);
 
-	bch_time_stats_update(&b->c->btree_split_time, start_time);
+	time_stats_update(&b->c->btree_split_time, start_time);
 
 	return 0;
 err_free2:
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index ba3909bb6b..26c8fa93b5 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1691,6 +1691,9 @@ static void cache_set_free(struct closure *cl)
 		kobject_put(&ca->kobj);
 	}
 
+	time_stats_exit(&c->btree_gc_time);
+	time_stats_exit(&c->btree_split_time);
+	time_stats_exit(&c->sort.time);
 
 	if (c->moving_gc_wq)
 		destroy_workqueue(c->moving_gc_wq);
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index c6f6770592..01eec5877c 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -16,6 +16,7 @@
 #include <linux/blkdev.h>
 #include <linux/sort.h>
 #include <linux/sched/clock.h>
+#include <linux/seq_buf.h>
 
 extern bool bcache_is_reboot;
 
@@ -79,10 +80,10 @@ read_attribute(active_journal_entries);
 read_attribute(backing_dev_name);
 read_attribute(backing_dev_uuid);
 
-sysfs_time_stats_attribute(btree_gc,	sec, ms);
-sysfs_time_stats_attribute(btree_split, sec, us);
-sysfs_time_stats_attribute(btree_sort,	ms,  us);
-sysfs_time_stats_attribute(btree_read,	ms,  us);
+read_attribute(btree_gc_time);
+read_attribute(btree_split_time);
+read_attribute(btree_sort_time);
+read_attribute(btree_read_time);
 
 read_attribute(btree_nodes);
 read_attribute(btree_used_percent);
@@ -731,6 +732,9 @@ static unsigned int bch_average_key_size(struct cache_set *c)
 SHOW(__bch_cache_set)
 {
 	struct cache_set *c = container_of(kobj, struct cache_set, kobj);
+	struct seq_buf s;
+
+	seq_buf_init(&s, buf, PAGE_SIZE);
 
 	sysfs_print(synchronous,		CACHE_SYNC(&c->cache->sb));
 	sysfs_print(journal_delay_ms,		c->journal_delay_ms);
@@ -743,10 +747,25 @@ SHOW(__bch_cache_set)
 	sysfs_print(btree_cache_max_chain,	bch_cache_max_chain(c));
 	sysfs_print(cache_available_percent,	100 - c->gc_stats.in_use);
 
-	sysfs_print_time_stats(&c->btree_gc_time,	btree_gc, sec, ms);
-	sysfs_print_time_stats(&c->btree_split_time,	btree_split, sec, us);
-	sysfs_print_time_stats(&c->sort.time,		btree_sort, ms, us);
-	sysfs_print_time_stats(&c->btree_read_time,	btree_read, ms, us);
+	if (attr == &sysfs_btree_gc_time) {
+		time_stats_to_text(&s, &c->btree_gc_time);
+		return s.len;
+	}
+
+	if (attr == &sysfs_btree_split_time) {
+		time_stats_to_text(&s, &c->btree_split_time);
+		return s.len;
+	}
+
+	if (attr == &sysfs_btree_sort_time) {
+		time_stats_to_text(&s, &c->sort.time);
+		return s.len;
+	}
+
+	if (attr == &sysfs_btree_read_time) {
+		time_stats_to_text(&s, &c->btree_read_time);
+		return s.len;
+	}
 
 	sysfs_print(btree_used_percent,	bch_btree_used(c));
 	sysfs_print(btree_nodes,	c->gc_stats.nodes);
@@ -988,10 +1007,10 @@ KTYPE(bch_cache_set);
 static struct attribute *bch_cache_set_internal_attrs[] = {
 	&sysfs_active_journal_entries,
 
-	sysfs_time_stats_attribute_list(btree_gc, sec, ms)
-	sysfs_time_stats_attribute_list(btree_split, sec, us)
-	sysfs_time_stats_attribute_list(btree_sort, ms, us)
-	sysfs_time_stats_attribute_list(btree_read, ms, us)
+	&sysfs_btree_gc_time,
+	&sysfs_btree_split_time,
+	&sysfs_btree_sort_time,
+	&sysfs_btree_read_time,
 
 	&sysfs_btree_nodes,
 	&sysfs_btree_used_percent,
diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index ae380bc399..95282bf0f9 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -160,36 +160,6 @@ int bch_parse_uuid(const char *s, char *uuid)
 	return i;
 }
 
-void bch_time_stats_update(struct time_stats *stats, uint64_t start_time)
-{
-	uint64_t now, duration, last;
-
-	spin_lock(&stats->lock);
-
-	now		= local_clock();
-	duration	= time_after64(now, start_time)
-		? now - start_time : 0;
-	last		= time_after64(now, stats->last)
-		? now - stats->last : 0;
-
-	stats->max_duration = max(stats->max_duration, duration);
-
-	if (stats->last) {
-		ewma_add(stats->average_duration, duration, 8, 8);
-
-		if (stats->average_frequency)
-			ewma_add(stats->average_frequency, last, 8, 8);
-		else
-			stats->average_frequency  = last << 8;
-	} else {
-		stats->average_duration  = duration << 8;
-	}
-
-	stats->last = now ?: 1;
-
-	spin_unlock(&stats->lock);
-}
-
 /**
  * bch_next_delay() - update ratelimiting statistics and calculate next delay
  * @d: the struct bch_ratelimit to update
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index 6f3cb7c921..1e1bdbae95 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -345,68 +345,11 @@ ssize_t bch_hprint(char *buf, int64_t v);
 bool bch_is_zero(const char *p, size_t n);
 int bch_parse_uuid(const char *s, char *uuid);
 
-struct time_stats {
-	spinlock_t	lock;
-	/*
-	 * all fields are in nanoseconds, averages are ewmas stored left shifted
-	 * by 8
-	 */
-	uint64_t	max_duration;
-	uint64_t	average_duration;
-	uint64_t	average_frequency;
-	uint64_t	last;
-};
-
-void bch_time_stats_update(struct time_stats *stats, uint64_t time);
-
 static inline unsigned int local_clock_us(void)
 {
 	return local_clock() >> 10;
 }
 
-#define NSEC_PER_ns			1L
-#define NSEC_PER_us			NSEC_PER_USEC
-#define NSEC_PER_ms			NSEC_PER_MSEC
-#define NSEC_PER_sec			NSEC_PER_SEC
-
-#define __print_time_stat(stats, name, stat, units)			\
-	sysfs_print(name ## _ ## stat ## _ ## units,			\
-		    div_u64((stats)->stat >> 8, NSEC_PER_ ## units))
-
-#define sysfs_print_time_stats(stats, name,				\
-			       frequency_units,				\
-			       duration_units)				\
-do {									\
-	__print_time_stat(stats, name,					\
-			  average_frequency,	frequency_units);	\
-	__print_time_stat(stats, name,					\
-			  average_duration,	duration_units);	\
-	sysfs_print(name ## _ ##max_duration ## _ ## duration_units,	\
-			div_u64((stats)->max_duration,			\
-				NSEC_PER_ ## duration_units));		\
-									\
-	sysfs_print(name ## _last_ ## frequency_units, (stats)->last	\
-		    ? div_s64(local_clock() - (stats)->last,		\
-			      NSEC_PER_ ## frequency_units)		\
-		    : -1LL);						\
-} while (0)
-
-#define sysfs_time_stats_attribute(name,				\
-				   frequency_units,			\
-				   duration_units)			\
-read_attribute(name ## _average_frequency_ ## frequency_units);		\
-read_attribute(name ## _average_duration_ ## duration_units);		\
-read_attribute(name ## _max_duration_ ## duration_units);		\
-read_attribute(name ## _last_ ## frequency_units)
-
-#define sysfs_time_stats_attribute_list(name,				\
-					frequency_units,		\
-					duration_units)			\
-&sysfs_ ## name ## _average_frequency_ ## frequency_units,		\
-&sysfs_ ## name ## _average_duration_ ## duration_units,		\
-&sysfs_ ## name ## _max_duration_ ## duration_units,			\
-&sysfs_ ## name ## _last_ ## frequency_units,
-
 #define ewma_add(ewma, val, weight, factor)				\
 ({									\
 	(ewma) *= (weight) - 1;						\
-- 
2.36.1

