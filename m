Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7334A84E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiBCNNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347799AbiBCNNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:13:21 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6D2C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 05:13:21 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so1442016ooo.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 05:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l1NG9qud1LpaSOVSQkpnHko+6K/HJr+ErHRZPqMtGVU=;
        b=hLT6n8MMx784Gy81FKXkW2EMnPjpoNPQgm4PQUZCiFZvAvVdslEENx8Py9Zy3IP8BI
         W9cd9oiTC1l7imttsMxLJTKjlIbqDTVLHdWL9hP5zKwUp9GWe5xRerqT2zBlXtg4DX4x
         P6Mgx/tf8ZZBiSB3reeUeKJ5XoDIUZKWo1W9D3+THh56NXywdvmhh8/CSWvtgGq2jq6C
         Xx36DEhpfOXvkpTwujxxwXj+eYQCSnqdoEQx1/zFUo3BMRUgLFZZLwFOMFi9eog15IIZ
         gJl+9z8Zzb2tAfw22dFhkwwwP5dCW78uYSY5ZiOBu7MATYZ64W6aCT113y+BW5QrH8QT
         1U+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l1NG9qud1LpaSOVSQkpnHko+6K/HJr+ErHRZPqMtGVU=;
        b=6W7mJvo1HiY3WjEiETK/6wVIPANLVkvRcNMI8FWRzl7ZIHipdi1YSHVCxBHGhujlsc
         bnPJ7fWzRYZfhq4hR0deXvMAzAQD2eNiBVFquOjJNKXFMOecczeJrVUGYN5UmBmFC7xt
         1wLlsupFmWN7OEuDeoAjwhfJofJKmwFX2HpBYo/2otJDnT2LwgjYdiQ9nzx+iPIXimci
         8IKRHE10eh98NxVaAZPEesKJPrB1obU99O8aS5tr0tx7G96wRBBGXsgc9j1SMJRxi39e
         oZcSFLFRu3M+OsvTHvTPU8sGwEPO132Sehu43XJCfDpJnGQ72VK8rbpWANjtbYGBLlES
         d60w==
X-Gm-Message-State: AOAM533ErRE8nABtAqfM0OLeeDUismEPLzSRoJnXVBIYirqEr93zIwfk
        NRqr/KF24yVNteAeAfts+JA=
X-Google-Smtp-Source: ABdhPJw606awtxkHoaAQoMDNkwgrOoN9kSTAdyPIExCnKxwSn/7RBLxmhGiiS+4Vyxas89WUbwE3MA==
X-Received: by 2002:a05:6870:d8ae:: with SMTP id dv46mr198000oab.228.1643894000683;
        Thu, 03 Feb 2022 05:13:20 -0800 (PST)
Received: from localhost.localdomain ([179.223.196.228])
        by smtp.gmail.com with ESMTPSA id n12sm16665537oop.5.2022.02.03.05.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 05:13:20 -0800 (PST)
From:   Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc:     Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        SeongJae Park <sj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: Add option to monitor only writes
Date:   Thu,  3 Feb 2022 10:12:36 -0300
Message-Id: <20220203131237.298090-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "writes" is written to /sys/kernel/debug/damon/counter_type damon will monitor only writes.
This patch also adds the actions mergeable and unmergeable to damos schemes. These actions are used by KSM as explained in [1].

[1] https://www.kernel.org/doc/html/latest/admin-guide/mm/ksm.html#controlling-ksm-with-madvise

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 include/linux/damon.h        | 13 ++++++
 include/trace/events/damon.h | 10 ++--
 mm/damon/core.c              | 91 +++++++++++++++++++++++++-----------
 mm/damon/dbgfs.c             | 72 +++++++++++++++++++++++++++-
 mm/damon/prmtv-common.c      | 88 ++++++++++++++++++++++++++++++++++
 mm/damon/prmtv-common.h      |  5 ++
 mm/damon/vaddr.c             | 80 ++++++++++++++++++++++++++++---
 7 files changed, 318 insertions(+), 41 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b4d4be3cc987..9efe89bbcec8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -44,11 +44,13 @@ struct damon_region {
 	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
+	unsigned int nr_writes;
 	struct list_head list;
 
 	unsigned int age;
 /* private: Internal value for age calculation. */
 	unsigned int last_nr_accesses;
+	unsigned int last_nr_writes;
 };
 
 /**
@@ -88,6 +90,8 @@ enum damos_action {
 	DAMOS_PAGEOUT,
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
+	DAMOS_MERGEABLE,
+	DAMOS_UNMERGEABLE,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 };
 
@@ -185,6 +189,11 @@ struct damos_watermarks {
 	bool activated;
 };
 
+enum damos_counter_type {
+	DAMOS_NUMBER_ACCESSES,
+	DAMOS_NUMBER_WRITES,
+};
+
 /**
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @min_sz_region:	Minimum size of target regions.
@@ -223,6 +232,9 @@ struct damos {
 	unsigned long max_sz_region;
 	unsigned int min_nr_accesses;
 	unsigned int max_nr_accesses;
+	unsigned int min_nr_writes;
+	unsigned int max_nr_writes;
+	enum damos_counter_type counter_type;
 	unsigned int min_age_region;
 	unsigned int max_age_region;
 	enum damos_action action;
@@ -386,6 +398,7 @@ struct damon_ctx {
 	struct damon_primitive primitive;
 	struct damon_callback callback;
 
+	enum damos_counter_type counter_type;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
 	struct list_head adaptive_targets;
diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 2f422f4f1fb9..45573f421707 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -11,17 +11,17 @@
 
 TRACE_EVENT(damon_aggregated,
 
-	TP_PROTO(struct damon_target *t, struct damon_region *r,
+	TP_PROTO(struct damon_ctx *c, struct damon_target *t, struct damon_region *r,
 		unsigned int nr_regions),
 
-	TP_ARGS(t, r, nr_regions),
+	TP_ARGS(c, t, r, nr_regions),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, target_id)
 		__field(unsigned int, nr_regions)
 		__field(unsigned long, start)
 		__field(unsigned long, end)
-		__field(unsigned int, nr_accesses)
+		__field(unsigned int, nr)
 	),
 
 	TP_fast_assign(
@@ -29,12 +29,12 @@ TRACE_EVENT(damon_aggregated,
 		__entry->nr_regions = nr_regions;
 		__entry->start = r->ar.start;
 		__entry->end = r->ar.end;
-		__entry->nr_accesses = r->nr_accesses;
+		__entry->nr = c->counter_type == DAMOS_NUMBER_WRITES ? r->nr_writes : r->nr_accesses;
 	),
 
 	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u",
 			__entry->target_id, __entry->nr_regions,
-			__entry->start, __entry->end, __entry->nr_accesses)
+			__entry->start, __entry->end, __entry->nr)
 );
 
 #endif /* _TRACE_DAMON_H */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index e92497895202..e827231366db 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -45,10 +45,12 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.start = start;
 	region->ar.end = end;
 	region->nr_accesses = 0;
+	region->nr_writes = 0;
 	INIT_LIST_HEAD(&region->list);
 
 	region->age = 0;
 	region->last_nr_accesses = 0;
+	region->last_nr_writes = 0;
 
 	return region;
 }
@@ -89,7 +91,7 @@ void damon_destroy_region(struct damon_region *r, struct damon_target *t)
 
 struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
-		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
+		unsigned int min_nr, unsigned int max_nr,
 		unsigned int min_age_region, unsigned int max_age_region,
 		enum damos_action action, struct damos_quota *quota,
 		struct damos_watermarks *wmarks)
@@ -101,8 +103,10 @@ struct damos *damon_new_scheme(
 		return NULL;
 	scheme->min_sz_region = min_sz_region;
 	scheme->max_sz_region = max_sz_region;
-	scheme->min_nr_accesses = min_nr_accesses;
-	scheme->max_nr_accesses = max_nr_accesses;
+	scheme->max_nr_writes = max_nr;
+	scheme->min_nr_writes = min_nr;
+	scheme->min_nr_accesses = min_nr;
+	scheme->max_nr_accesses = max_nr;
 	scheme->min_age_region = min_age_region;
 	scheme->max_age_region = max_age_region;
 	scheme->action = action;
@@ -221,6 +225,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->sample_interval = 5 * 1000;
 	ctx->aggr_interval = 100 * 1000;
 	ctx->primitive_update_interval = 60 * 1000 * 1000;
+	ctx->counter_type = DAMOS_NUMBER_ACCESSES;
 
 	ktime_get_coarse_ts64(&ctx->last_aggregation);
 	ctx->last_primitive_update = ctx->last_aggregation;
@@ -535,9 +540,11 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		struct damon_region *r;
 
 		damon_for_each_region(r, t) {
-			trace_damon_aggregated(t, r, damon_nr_regions(t));
+			trace_damon_aggregated(c, t, r, damon_nr_regions(t));
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
+			r->last_nr_writes = r->nr_writes;
+			r->nr_writes = 0;
 		}
 	}
 }
@@ -546,21 +553,27 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		unsigned long sz_r);
 
-static bool __damos_valid_target(struct damon_region *r, struct damos *s)
+static bool __damos_valid_target(struct damon_ctx *ctx, struct damon_region *r, struct damos *s)
 {
 	unsigned long sz;
-
 	sz = r->ar.end - r->ar.start;
-	return s->min_sz_region <= sz && sz <= s->max_sz_region &&
-		s->min_nr_accesses <= r->nr_accesses &&
-		r->nr_accesses <= s->max_nr_accesses &&
-		s->min_age_region <= r->age && r->age <= s->max_age_region;
+
+	if (ctx->counter_type == DAMOS_NUMBER_WRITES)
+		return s->min_sz_region <= sz && sz <= s->max_sz_region &&
+			s->min_nr_writes <= r->nr_writes &&
+			r->nr_writes <= s->max_nr_writes &&
+			s->min_age_region <= r->age && r->age <= s->max_age_region;
+	else
+		return s->min_sz_region <= sz && sz <= s->max_sz_region &&
+			s->min_nr_accesses <= r->nr_accesses &&
+			r->nr_accesses <= s->max_nr_accesses &&
+			s->min_age_region <= r->age && r->age <= s->max_age_region;
 }
 
 static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
-	bool ret = __damos_valid_target(r, s);
+	bool ret = __damos_valid_target(c, r, s);
 
 	if (!ret || !s->quota.esz || !c->primitive.get_scheme_score)
 		return ret;
@@ -707,7 +720,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		memset(quota->histogram, 0, sizeof(quota->histogram));
 		damon_for_each_target(t, c) {
 			damon_for_each_region(r, t) {
-				if (!__damos_valid_target(r, s))
+				if (!__damos_valid_target(c, r, s))
 					continue;
 				score = c->primitive.get_scheme_score(
 						c, t, r, s);
@@ -738,13 +751,18 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 /*
  * Merge two adjacent regions into one region
  */
-static void damon_merge_two_regions(struct damon_target *t,
+static void damon_merge_two_regions(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *l, struct damon_region *r)
 {
 	unsigned long sz_l = sz_damon_region(l), sz_r = sz_damon_region(r);
 
-	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
+	if (c->counter_type == DAMOS_NUMBER_WRITES)
+		l->nr_writes = (l->nr_writes * sz_l + r->nr_writes * sz_r) /
 			(sz_l + sz_r);
+	else
+		l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
+				(sz_l + sz_r);
+
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
 	damon_destroy_region(r, t);
@@ -759,23 +777,39 @@ static void damon_merge_two_regions(struct damon_target *t,
  * thres	'->nr_accesses' diff threshold for the merge
  * sz_limit	size upper limit of each region
  */
-static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
+static void damon_merge_regions_of(struct damon_ctx *c, struct damon_target *t, unsigned int thres,
 				   unsigned long sz_limit)
 {
 	struct damon_region *r, *prev = NULL, *next;
 
-	damon_for_each_region_safe(r, next, t) {
-		if (diff_of(r->nr_accesses, r->last_nr_accesses) > thres)
-			r->age = 0;
-		else
-			r->age++;
-
-		if (prev && prev->ar.end == r->ar.start &&
-		    diff_of(prev->nr_accesses, r->nr_accesses) <= thres &&
-		    sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
-			damon_merge_two_regions(t, prev, r);
-		else
-			prev = r;
+	if (c->counter_type == DAMOS_NUMBER_WRITES) {
+		damon_for_each_region_safe(r, next, t) {
+			if (diff_of(r->nr_writes, r->last_nr_writes) > thres)
+				r->age = 0;
+			else
+				r->age++;
+
+			if (prev && prev->ar.end == r->ar.start &&
+				diff_of(prev->nr_writes, r->nr_writes) <= thres &&
+				sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
+				damon_merge_two_regions(c, t, prev, r);
+			else
+				prev = r;
+		}
+	} else {
+		damon_for_each_region_safe(r, next, t) {
+			if (diff_of(r->nr_accesses, r->last_nr_accesses) > thres)
+				r->age = 0;
+			else
+				r->age++;
+
+			if (prev && prev->ar.end == r->ar.start &&
+				diff_of(prev->nr_accesses, r->nr_accesses) <= thres &&
+				sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
+				damon_merge_two_regions(c, t, prev, r);
+			else
+				prev = r;
+		}
 	}
 }
 
@@ -796,7 +830,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	struct damon_target *t;
 
 	damon_for_each_target(t, c)
-		damon_merge_regions_of(t, threshold, sz_limit);
+		damon_merge_regions_of(c, t, threshold, sz_limit);
 }
 
 /*
@@ -819,6 +853,7 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
+	new->last_nr_writes = r->last_nr_writes;
 
 	damon_insert_region(new, r, damon_next_region(r), t);
 }
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index ad65436756af..6cf2501148f5 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -166,6 +166,8 @@ static bool damos_action_valid(int action)
 	case DAMOS_PAGEOUT:
 	case DAMOS_HUGEPAGE:
 	case DAMOS_NOHUGEPAGE:
+	case DAMOS_MERGEABLE:
+	case DAMOS_UNMERGEABLE:
 	case DAMOS_STAT:
 		return true;
 	default:
@@ -477,6 +479,66 @@ static ssize_t dbgfs_init_regions_read(struct file *file, char __user *buf,
 	return len;
 }
 
+static ssize_t dbgfs_counter_type_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = file->private_data;
+	char *kbuf;
+	ssize_t ret;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		mutex_unlock(&ctx->kdamond_lock);
+		ret = -EBUSY;
+		goto out;
+	}
+	ret = count;
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	if (!strncmp(kbuf, "writes\n", count))
+		ctx->counter_type = DAMOS_NUMBER_WRITES;
+	else
+		ctx->counter_type = DAMOS_NUMBER_ACCESSES;
+
+	mutex_unlock(&ctx->kdamond_lock);
+out:
+	kfree(kbuf);
+	return ret;
+}
+
+static ssize_t dbgfs_counter_type_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = file->private_data;
+	char *kbuf;
+	ssize_t len;
+
+	kbuf = kmalloc(count, GFP_KERNEL | __GFP_NOWARN);
+	if (!kbuf)
+		return -ENOMEM;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		mutex_unlock(&ctx->kdamond_lock);
+		len = -EBUSY;
+		goto out;
+	}
+
+	if (ctx->counter_type == DAMOS_NUMBER_WRITES)
+		len = scnprintf(kbuf, count, "writes");
+	else
+		len = scnprintf(kbuf, count, "accesses");
+	mutex_unlock(&ctx->kdamond_lock);
+	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
+
+out:
+	kfree(kbuf);
+	return len;
+}
+
+
 static int add_init_region(struct damon_ctx *c,
 			 unsigned long target_id, struct damon_addr_range *ar)
 {
@@ -636,12 +698,18 @@ static const struct file_operations kdamond_pid_fops = {
 	.read = dbgfs_kdamond_pid_read,
 };
 
+static const struct file_operations counter_type_fops = {
+	.open = damon_dbgfs_open,
+	.read = dbgfs_counter_type_read,
+	.write = dbgfs_counter_type_write,
+};
+
 static void dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 {
 	const char * const file_names[] = {"attrs", "schemes", "target_ids",
-		"init_regions", "kdamond_pid"};
+		"init_regions", "kdamond_pid", "counter_type"};
 	const struct file_operations *fops[] = {&attrs_fops, &schemes_fops,
-		&target_ids_fops, &init_regions_fops, &kdamond_pid_fops};
+		&target_ids_fops, &init_regions_fops, &kdamond_pid_fops, &counter_type_fops};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(file_names); i++)
diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
index 92a04f5831d6..09ba2b5b895e 100644
--- a/mm/damon/prmtv-common.c
+++ b/mm/damon/prmtv-common.c
@@ -9,6 +9,8 @@
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 #include "prmtv-common.h"
 
@@ -58,6 +60,92 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
 	put_page(page);
 }
 
+static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
+{
+	struct page *page;
+
+	if (!pte_write(pte))
+		return false;
+	if (!is_cow_mapping(vma->vm_flags))
+		return false;
+	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
+		return false;
+	page = vm_normal_page(vma, addr, pte);
+	if (!page)
+		return false;
+	return page_maybe_dma_pinned(page);
+}
+
+static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
+		unsigned long addr, pmd_t *pmdp)
+{
+	pmd_t old, pmd = *pmdp;
+
+	if (pmd_present(pmd)) {
+		/* See comment in change_huge_pmd() */
+		old = pmdp_invalidate(vma, addr, pmdp);
+		if (pmd_dirty(old))
+			pmd = pmd_mkdirty(pmd);
+		if (pmd_young(old))
+			pmd = pmd_mkyoung(pmd);
+
+		pmd = pmd_wrprotect(pmd);
+		pmd = pmd_clear_soft_dirty(pmd);
+
+		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
+		pmd = pmd_swp_clear_soft_dirty(pmd);
+		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+	}
+}
+
+static inline void clear_soft_dirty(struct vm_area_struct *vma,
+		unsigned long addr, pte_t *pte)
+{
+	/*
+	 * The soft-dirty tracker uses #PF-s to catch writes
+	 * to pages, so write-protect the pte as well. See the
+	 * Documentation/admin-guide/mm/soft-dirty.rst for full description
+	 * of how soft-dirty works.
+	 */
+	pte_t ptent = *pte;
+
+	if (pte_present(ptent)) {
+		pte_t old_pte;
+
+		if (pte_is_pinned(vma, addr, ptent))
+			return;
+		old_pte = ptep_modify_prot_start(vma, addr, pte);
+		ptent = pte_wrprotect(old_pte);
+		ptent = pte_clear_soft_dirty(ptent);
+		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
+	} else if (is_swap_pte(ptent)) {
+		ptent = pte_swp_clear_soft_dirty(ptent);
+		set_pte_at(vma->vm_mm, addr, pte, ptent);
+	}
+}
+
+void damon_pmd_clean_soft_dirty(struct vm_area_struct *vma, unsigned long addr,
+		pmd_t *pmd)
+{
+	vma->vm_flags &= ~VM_SOFTDIRTY;
+	vma_set_page_prot(vma);
+
+	if (pmd_soft_dirty(*pmd))
+		clear_soft_dirty_pmd(vma, addr, pmd);
+
+}
+
+void damon_ptep_clean_soft_dirty(struct vm_area_struct *vma, unsigned long addr,
+		pte_t *pte)
+{
+	vma->vm_flags &= ~VM_SOFTDIRTY;
+	vma_set_page_prot(vma);
+
+	if (pte_soft_dirty(*pte))
+		clear_soft_dirty(vma, addr, pte);
+}
+
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
index 61f27037603e..03847d149f0e 100644
--- a/mm/damon/prmtv-common.h
+++ b/mm/damon/prmtv-common.h
@@ -13,6 +13,11 @@
 
 struct page *damon_get_page(unsigned long pfn);
 
+void damon_ptep_clean_soft_dirty(struct vm_area_struct *vma, unsigned long addr,
+		pte_t *pte);
+void damon_pmd_clean_soft_dirty(struct vm_area_struct *vma, unsigned long addr,
+		pmd_t *pmd);
+
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 20a9a9d69eb1..a7d9c9563d1d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -368,6 +368,44 @@ void damon_va_update(struct damon_ctx *ctx)
 	}
 }
 
+static int damon_clean_soft_dirty_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	pte_t *pte;
+	spinlock_t *ptl;
+
+	if (pmd_huge(*pmd)) {
+		ptl = pmd_lock(walk->mm, pmd);
+		if (pmd_huge(*pmd)) {
+			damon_pmd_clean_soft_dirty(walk->vma, addr, pmd);
+			spin_unlock(ptl);
+			return 0;
+		}
+		spin_unlock(ptl);
+	}
+
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		return 0;
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte_present(*pte))
+		goto out;
+	damon_ptep_clean_soft_dirty(walk->vma, addr, pte);
+out:
+	pte_unmap_unlock(pte, ptl);
+	return 0;
+}
+
+static const struct mm_walk_ops damon_clean_soft_dirty_ops = {
+	.pmd_entry = damon_clean_soft_dirty_pmd_entry,
+};
+
+static void damon_va_clean_soft_dirty(struct mm_struct *mm, unsigned long addr)
+{
+	mmap_read_lock(mm);
+	walk_page_range(mm, addr, addr + 1, &damon_clean_soft_dirty_ops, NULL);
+	mmap_read_unlock(mm);
+}
+
 static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
@@ -415,7 +453,10 @@ static void damon_va_prepare_access_check(struct damon_ctx *ctx,
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
-	damon_va_mkold(mm, r->sampling_addr);
+	if (ctx->counter_type == DAMOS_NUMBER_WRITES)
+		damon_va_clean_soft_dirty(mm, r->sampling_addr);
+	else
+		damon_va_mkold(mm, r->sampling_addr);
 }
 
 void damon_va_prepare_access_checks(struct damon_ctx *ctx)
@@ -437,6 +478,7 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 struct damon_young_walk_private {
 	unsigned long *page_sz;
 	bool young;
+	bool dirty;
 };
 
 static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -463,6 +505,10 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 			*priv->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
 			priv->young = true;
 		}
+		if (pmd_soft_dirty(*pmd)) {
+			*priv->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
+			priv->dirty = true;
+		}
 		put_page(page);
 huge_out:
 		spin_unlock(ptl);
@@ -485,6 +531,10 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		*priv->page_sz = PAGE_SIZE;
 		priv->young = true;
 	}
+	if (pte_soft_dirty(*pte)) {
+		*priv->page_sz = PAGE_SIZE;
+		priv->dirty = true;
+	}
 	put_page(page);
 out:
 	pte_unmap_unlock(pte, ptl);
@@ -496,16 +546,19 @@ static const struct mm_walk_ops damon_young_ops = {
 };
 
 static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
-		unsigned long *page_sz)
+		unsigned long *page_sz, bool *dirty)
 {
 	struct damon_young_walk_private arg = {
 		.page_sz = page_sz,
 		.young = false,
+		.dirty = false,
 	};
 
 	mmap_read_lock(mm);
 	walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
 	mmap_read_unlock(mm);
+
+	*dirty = arg.dirty;
 	return arg.young;
 }
 
@@ -522,18 +575,23 @@ static void damon_va_check_access(struct damon_ctx *ctx,
 	static unsigned long last_addr;
 	static unsigned long last_page_sz = PAGE_SIZE;
 	static bool last_accessed;
+	static bool last_written;
 
 	/* If the region is in the last checked page, reuse the result */
 	if (mm == last_mm && (ALIGN_DOWN(last_addr, last_page_sz) ==
 				ALIGN_DOWN(r->sampling_addr, last_page_sz))) {
 		if (last_accessed)
 			r->nr_accesses++;
+		if (last_written)
+			r->nr_writes++;
 		return;
 	}
 
-	last_accessed = damon_va_young(mm, r->sampling_addr, &last_page_sz);
+	last_accessed = damon_va_young(mm, r->sampling_addr, &last_page_sz, &last_written);
 	if (last_accessed)
 		r->nr_accesses++;
+	if (last_written)
+		r->nr_writes++;
 
 	last_mm = mm;
 	last_addr = r->sampling_addr;
@@ -544,7 +602,7 @@ unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	struct damon_target *t;
 	struct mm_struct *mm;
 	struct damon_region *r;
-	unsigned int max_nr_accesses = 0;
+	unsigned int max_nr = 0;
 
 	damon_for_each_target(t, ctx) {
 		mm = damon_get_mm(t);
@@ -552,12 +610,15 @@ unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 			continue;
 		damon_for_each_region(r, t) {
 			damon_va_check_access(ctx, mm, r);
-			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+			if (ctx->counter_type == DAMOS_NUMBER_WRITES)
+				max_nr = max(r->nr_writes, max_nr);
+			else
+				max_nr = max(r->nr_accesses, max_nr);
 		}
 		mmput(mm);
 	}
 
-	return max_nr_accesses;
+	return max_nr;
 }
 
 /*
@@ -597,6 +658,7 @@ static int damos_madvise(struct damon_target *target, struct damon_region *r,
 
 	ret = do_madvise(mm, PAGE_ALIGN(r->ar.start),
 			PAGE_ALIGN(r->ar.end - r->ar.start), behavior);
+
 	mmput(mm);
 out:
 	return ret;
@@ -624,6 +686,12 @@ int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
+	case DAMOS_MERGEABLE:
+		madv_action = MADV_MERGEABLE;
+		break;
+	case DAMOS_UNMERGEABLE:
+		madv_action = MADV_UNMERGEABLE;
+		break;
 	case DAMOS_STAT:
 		return 0;
 	default:
-- 
2.25.1

