Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AFF470362
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbhLJPEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:04:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60246 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhLJPEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:04:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B0DCB82877
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5FBC341C6;
        Fri, 10 Dec 2021 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639148433;
        bh=0DBfCKxzXHXT13GYpJ/VzJt0LR3r7vy6DNUS7LwYu1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G6DG/skQ7bdfCphAh9baNqLBid0tqgRbatRsHPCtdREM7GhXqgLz99V4JcfNB/J8q
         HE+V17nTS1sFjdWRNpVEFWIFT9te8nyDFbxC/fYlTcQe3S82Ie5trtmbp1XY9j53Wb
         LxTfFYvMhO4vXVSuA8HsnsOzNYuK4UDSKFbreP2JidwzDqRcsZxKncf43supyMplLl
         W/yJwk20AEQSav9EJSwa4YnKAsIdx3PgqxgoA0RlysSMa0OQtvRkoI895nW8okWXUG
         zOjMTaJlIKXt+LPoBDlyQFzLSi00Tlyca/EKQYB3SCzDZzQe1dHRx3l739GsgmPDFh
         VS6VGLCoK2P3A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/6] mm/damon/schemes: Account scheme actions that successfully applied
Date:   Fri, 10 Dec 2021 15:00:11 +0000
Message-Id: <20211210150016.35349-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211210150016.35349-1-sj@kernel.org>
References: <20211210150016.35349-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON-based operation schemes (DAMOS) stats provide only the number and
the amount of regions that the action of the scheme has tried to be
applied.  Because the action could be failed for some reasons, the
currently provided information is sometimes not useful or convenient
enough for schemes profiling and tuning.  To improve this situation,
this commit extends the DAMOS stats to provide the number and the amount
of regions that the action has successfully applied.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 28 +++++++++++++++++++++-------
 mm/damon/core.c       | 13 ++++++++-----
 mm/damon/dbgfs.c      |  2 +-
 mm/damon/paddr.c      | 13 +++++++------
 mm/damon/vaddr.c      | 30 ++++++++++++++++--------------
 5 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 97f4a224e950..e0ad3d9aaeed 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -192,6 +192,20 @@ struct damos_watermarks {
 	bool activated;
 };
 
+/**
+ * struct damos_stat - Statistics on a given scheme.
+ * @nr_tried:	Total number of regions that the scheme is tried to be applied.
+ * @sz_tried:	Total size of regions that the scheme is tried to be applied.
+ * @nr_applied:	Total number of regions that the scheme is applied.
+ * @sz_applied:	Total size of regions that the scheme is applied.
+ */
+struct damos_stat {
+	unsigned long nr_tried;
+	unsigned long sz_tried;
+	unsigned long nr_applied;
+	unsigned long sz_applied;
+};
+
 /**
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @min_sz_region:	Minimum size of target regions.
@@ -203,8 +217,7 @@ struct damos_watermarks {
  * @action:		&damo_action to be applied to the target regions.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
- * @stat_count:		Total number of regions that this scheme is applied.
- * @stat_sz:		Total size of regions that this scheme is applied.
+ * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
  *
  * For each aggregation interval, DAMON finds regions which fit in the
@@ -235,8 +248,7 @@ struct damos {
 	enum damos_action action;
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
-	unsigned long stat_count;
-	unsigned long stat_sz;
+	struct damos_stat stat;
 	struct list_head list;
 };
 
@@ -281,7 +293,8 @@ struct damon_ctx;
  * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
  * DAMON-based operation scheme is found.  It should apply the scheme's action
- * to the region.
+ * to the region and return bytes of the region that the action is successfully
+ * applied.
  * @target_valid should check whether the target is still valid for the
  * monitoring.
  * @cleanup is called from @kdamond just before its termination.
@@ -295,8 +308,9 @@ struct damon_primitive {
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_target *t, struct damon_region *r,
 			struct damos *scheme);
-	int (*apply_scheme)(struct damon_ctx *context, struct damon_target *t,
-			struct damon_region *r, struct damos *scheme);
+	unsigned long (*apply_scheme)(struct damon_ctx *context,
+			struct damon_target *t, struct damon_region *r,
+			struct damos *scheme);
 	bool (*target_valid)(void *target);
 	void (*cleanup)(struct damon_ctx *context);
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 70771cf7da89..6d59047b8923 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -112,8 +112,7 @@ struct damos *damon_new_scheme(
 	scheme->min_age_region = min_age_region;
 	scheme->max_age_region = max_age_region;
 	scheme->action = action;
-	scheme->stat_count = 0;
-	scheme->stat_sz = 0;
+	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
 
 	scheme->quota.ms = quota->ms;
@@ -603,6 +602,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		struct damos_quota *quota = &s->quota;
 		unsigned long sz = r->ar.end - r->ar.start;
 		struct timespec64 begin, end;
+		unsigned long sz_applied = 0;
 
 		if (!s->wmarks.activated)
 			continue;
@@ -665,7 +665,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 				damon_split_region_at(c, t, r, sz);
 			}
 			ktime_get_coarse_ts64(&begin);
-			c->primitive.apply_scheme(c, t, r, s);
+			sz_applied = c->primitive.apply_scheme(c, t, r, s);
 			ktime_get_coarse_ts64(&end);
 			quota->total_charged_ns += timespec64_to_ns(&end) -
 				timespec64_to_ns(&begin);
@@ -679,8 +679,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			r->age = 0;
 
 update_stat:
-		s->stat_count++;
-		s->stat_sz += sz;
+		s->stat.nr_tried++;
+		s->stat.sz_tried += sz;
+		if (sz_applied)
+			s->stat.nr_applied++;
+		s->stat.sz_applied += sz_applied;
 	}
 }
 
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 5b628990ae6e..ef79b7b7716d 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -117,7 +117,7 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 				s->quota.weight_age,
 				s->wmarks.metric, s->wmarks.interval,
 				s->wmarks.high, s->wmarks.mid, s->wmarks.low,
-				s->stat_count, s->stat_sz);
+				s->stat.nr_tried, s->stat.sz_tried);
 		if (!rc)
 			return -ENOMEM;
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4318134cbc4c..5e8244f65a1a 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -213,14 +213,15 @@ bool damon_pa_target_valid(void *t)
 	return true;
 }
 
-static int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
-		struct damon_region *r, struct damos *scheme)
+static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *scheme)
 {
-	unsigned long addr;
+	unsigned long addr, applied;
 	LIST_HEAD(page_list);
 
 	if (scheme->action != DAMOS_PAGEOUT)
-		return -EINVAL;
+		return 0;
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
 		struct page *page = damon_get_page(PHYS_PFN(addr));
@@ -241,9 +242,9 @@ static int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
 			put_page(page);
 		}
 	}
-	reclaim_pages(&page_list);
+	applied = reclaim_pages(&page_list);
 	cond_resched();
-	return 0;
+	return applied * PAGE_SIZE;
 }
 
 static int damon_pa_scheme_score(struct damon_ctx *context,
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 68d9e4134816..a10df3fd3d02 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -572,32 +572,34 @@ bool damon_va_target_valid(void *target)
 }
 
 #ifndef CONFIG_ADVISE_SYSCALLS
-static int damos_madvise(struct damon_target *target, struct damon_region *r,
-			int behavior)
+static unsigned long damos_madvise(struct damon_target *target,
+		struct damon_region *r, int behavior)
 {
-	return -EINVAL;
+	return 0;
 }
 #else
-static int damos_madvise(struct damon_target *target, struct damon_region *r,
-			int behavior)
+static unsigned long damos_madvise(struct damon_target *target,
+		struct damon_region *r, int behavior)
 {
 	struct mm_struct *mm;
-	int ret = -ENOMEM;
+	unsigned long start = PAGE_ALIGN(r->ar.start);
+	unsigned long len = PAGE_ALIGN(r->ar.end - r->ar.start);
+	unsigned long applied;
 
 	mm = damon_get_mm(target);
 	if (!mm)
-		goto out;
+		return 0;
 
-	ret = do_madvise(mm, PAGE_ALIGN(r->ar.start),
-			PAGE_ALIGN(r->ar.end - r->ar.start), behavior);
+	applied = do_madvise(mm, start, len, behavior) ? 0 : len;
 	mmput(mm);
-out:
-	return ret;
+
+	return applied;
 }
 #endif	/* CONFIG_ADVISE_SYSCALLS */
 
-static int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
-		struct damon_region *r, struct damos *scheme)
+static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *scheme)
 {
 	int madv_action;
 
@@ -620,7 +622,7 @@ static int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
 	case DAMOS_STAT:
 		return 0;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	return damos_madvise(t, r, madv_action);
-- 
2.17.1

