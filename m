Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3454B782E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbiBOSqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:46:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiBOSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:46:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21F12B19C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:46:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EE6E61704
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E15C340F2;
        Tue, 15 Feb 2022 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950798;
        bh=v1c4LFF1KOqf3tnp6aX1bQQ8kiIyhn4wqzhhTvpNep4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpldtVkuFRpF46RmvNmgxwQ7C+ixBVa6eGgiXqWGO/rcTm+xru3BPBUFMUOVGU1wY
         M10j10RfH+yvTFcxGHSFMQyyj9yjBUm0nuRm5e/liSC/dilYxp3AjwJUFlmKI74Yww
         oalPS1ElJlLEsixuzemCliQ2db2SP0vs3yWVuKccR8SrxJwgD2n2Q3QWEiRpNNYhJK
         g83VcDT8wDCtpqlW13jRUyoeW+3tDU0By4MT/Lrxr5Y1vFaw3Tppe92FGqFCqnPrMJ
         8GJrJfqXsT/QBS/tvWjBDrrCfEahdxrgA3yLU+wyMzIwHsJhblvpNK6vwdhe/hy55X
         81TGm2uzNMo2A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     xhao@linux.alibaba.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/8] mm/damon: Rename damon_primitives to damon_operations
Date:   Tue, 15 Feb 2022 18:45:56 +0000
Message-Id: <20220215184603.1479-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215184603.1479-1-sj@kernel.org>
References: <20220215184603.1479-1-sj@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON has a set of callback functions called monitoring primitives and
let it can be configured with various implementations for easy extension
for different address spaces and usages.  However, the word 'primitive'
is not so explicit.  Meanwhile, many other structs resembles similar
purpose calls themselves 'operations'.  To make the code easier to be
understood, this commit renames 'damon_primitives' to 'damon_operations'
before it is too late to rename.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h                     | 48 ++++++++---------
 mm/damon/Kconfig                          | 12 ++---
 mm/damon/Makefile                         |  4 +-
 mm/damon/core.c                           | 65 ++++++++++++-----------
 mm/damon/dbgfs-test.h                     |  2 +-
 mm/damon/dbgfs.c                          | 10 ++--
 mm/damon/{prmtv-common.c => ops-common.c} |  2 +-
 mm/damon/{prmtv-common.h => ops-common.h} |  0
 mm/damon/paddr.c                          | 22 ++++----
 mm/damon/reclaim.c                        |  2 +-
 mm/damon/vaddr-test.h                     |  2 +-
 mm/damon/vaddr.c                          | 22 ++++----
 12 files changed, 96 insertions(+), 95 deletions(-)
 rename mm/damon/{prmtv-common.c => ops-common.c} (99%)
 rename mm/damon/{prmtv-common.h => ops-common.h} (100%)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7c1d915b3587..00baeb42c18e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -67,8 +67,8 @@ struct damon_region {
  *
  * Each monitoring context could have multiple targets.  For example, a context
  * for virtual memory address spaces could have multiple target processes.  The
- * @pid should be set for appropriate address space monitoring primitives
- * including the virtual address spaces monitoring primitives.
+ * @pid should be set for appropriate &struct damon_operations including the
+ * virtual address spaces monitoring operations.
  */
 struct damon_target {
 	struct pid *pid;
@@ -120,9 +120,9 @@ enum damos_action {
  * uses smaller one as the effective quota.
  *
  * For selecting regions within the quota, DAMON prioritizes current scheme's
- * target memory regions using the &struct damon_primitive->get_scheme_score.
+ * target memory regions using the &struct damon_operations->get_scheme_score.
  * You could customize the prioritization logic by setting &weight_sz,
- * &weight_nr_accesses, and &weight_age, because monitoring primitives are
+ * &weight_nr_accesses, and &weight_age, because monitoring operations are
  * encouraged to respect those.
  */
 struct damos_quota {
@@ -256,10 +256,10 @@ struct damos {
 struct damon_ctx;
 
 /**
- * struct damon_primitive - Monitoring primitives for given use cases.
+ * struct damon_operations - Monitoring operations for given use cases.
  *
- * @init:			Initialize primitive-internal data structures.
- * @update:			Update primitive-internal data structures.
+ * @init:			Initialize operations-related data structures.
+ * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
  * @reset_aggregated:		Reset aggregated accesses monitoring results.
@@ -269,18 +269,18 @@ struct damon_ctx;
  * @cleanup:			Clean up the context.
  *
  * DAMON can be extended for various address spaces and usages.  For this,
- * users should register the low level primitives for their target address
- * space and usecase via the &damon_ctx.primitive.  Then, the monitoring thread
+ * users should register the low level operations for their target address
+ * space and usecase via the &damon_ctx.ops.  Then, the monitoring thread
  * (&damon_ctx.kdamond) calls @init and @prepare_access_checks before starting
- * the monitoring, @update after each &damon_ctx.primitive_update_interval, and
+ * the monitoring, @update after each &damon_ctx.ops_update_interval, and
  * @check_accesses, @target_valid and @prepare_access_checks after each
  * &damon_ctx.sample_interval.  Finally, @reset_aggregated is called after each
  * &damon_ctx.aggr_interval.
  *
- * @init should initialize primitive-internal data structures.  For example,
+ * @init should initialize operations-related data structures.  For example,
  * this could be used to construct proper monitoring target regions and link
  * those to @damon_ctx.adaptive_targets.
- * @update should update the primitive-internal data structures.  For example,
+ * @update should update the operations-related data structures.  For example,
  * this could be used to update monitoring target regions for current status.
  * @prepare_access_checks should manipulate the monitoring regions to be
  * prepared for the next access check.
@@ -300,7 +300,7 @@ struct damon_ctx;
  * monitoring.
  * @cleanup is called from @kdamond just before its termination.
  */
-struct damon_primitive {
+struct damon_operations {
 	void (*init)(struct damon_ctx *context);
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
@@ -354,15 +354,15 @@ struct damon_callback {
  *
  * @sample_interval:		The time between access samplings.
  * @aggr_interval:		The time between monitor results aggregations.
- * @primitive_update_interval:	The time between monitoring primitive updates.
+ * @ops_update_interval:	The time between monitoring operations updates.
  *
  * For each @sample_interval, DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
  * each region) for @aggr_interval time.  DAMON also checks whether the target
  * memory regions need update (e.g., by ``mmap()`` calls from the application,
  * in case of virtual memory monitoring) and applies the changes for each
- * @primitive_update_interval.  All time intervals are in micro-seconds.
- * Please refer to &struct damon_primitive and &struct damon_callback for more
+ * @ops_update_interval.  All time intervals are in micro-seconds.
+ * Please refer to &struct damon_operations and &struct damon_callback for more
  * detail.
  *
  * @kdamond:		Kernel thread who does the monitoring.
@@ -374,7 +374,7 @@ struct damon_callback {
  *
  * Once started, the monitoring thread runs until explicitly required to be
  * terminated or every monitoring target is invalid.  The validity of the
- * targets is checked via the &damon_primitive.target_valid of @primitive.  The
+ * targets is checked via the &damon_operations.target_valid of @ops.  The
  * termination can also be explicitly requested by writing non-zero to
  * @kdamond_stop.  The thread sets @kdamond to NULL when it terminates.
  * Therefore, users can know whether the monitoring is ongoing or terminated by
@@ -384,7 +384,7 @@ struct damon_callback {
  * Note that the monitoring thread protects only @kdamond and @kdamond_stop via
  * @kdamond_lock.  Accesses to other fields must be protected by themselves.
  *
- * @primitive:	Set of monitoring primitives for given use cases.
+ * @ops:	Set of monitoring operations for given use cases.
  * @callback:	Set of callbacks for monitoring events notifications.
  *
  * @min_nr_regions:	The minimum number of adaptive monitoring regions.
@@ -395,17 +395,17 @@ struct damon_callback {
 struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
-	unsigned long primitive_update_interval;
+	unsigned long ops_update_interval;
 
 /* private: internal use only */
 	struct timespec64 last_aggregation;
-	struct timespec64 last_primitive_update;
+	struct timespec64 last_ops_update;
 
 /* public: */
 	struct task_struct *kdamond;
 	struct mutex kdamond_lock;
 
-	struct damon_primitive primitive;
+	struct damon_operations ops;
 	struct damon_callback callback;
 
 	unsigned long min_nr_regions;
@@ -484,7 +484,7 @@ unsigned int damon_nr_regions(struct damon_target *t);
 struct damon_ctx *damon_new_ctx(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		unsigned long aggr_int, unsigned long primitive_upd_int,
+		unsigned long aggr_int, unsigned long ops_upd_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
 int damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
@@ -497,12 +497,12 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
 #ifdef CONFIG_DAMON_VADDR
 bool damon_va_target_valid(void *t);
-void damon_va_set_primitives(struct damon_ctx *ctx);
+void damon_va_set_operations(struct damon_ctx *ctx);
 #endif	/* CONFIG_DAMON_VADDR */
 
 #ifdef CONFIG_DAMON_PADDR
 bool damon_pa_target_valid(void *t);
-void damon_pa_set_primitives(struct damon_ctx *ctx);
+void damon_pa_set_operations(struct damon_ctx *ctx);
 #endif	/* CONFIG_DAMON_PADDR */
 
 #endif	/* _DAMON_H */
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 5bcf05851ad0..01bad77ad7ae 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -25,27 +25,27 @@ config DAMON_KUNIT_TEST
 	  If unsure, say N.
 
 config DAMON_VADDR
-	bool "Data access monitoring primitives for virtual address spaces"
+	bool "Data access monitoring operations for virtual address spaces"
 	depends on DAMON && MMU
 	select PAGE_IDLE_FLAG
 	help
-	  This builds the default data access monitoring primitives for DAMON
+	  This builds the default data access monitoring operations for DAMON
 	  that work for virtual address spaces.
 
 config DAMON_PADDR
-	bool "Data access monitoring primitives for the physical address space"
+	bool "Data access monitoring operations for the physical address space"
 	depends on DAMON && MMU
 	select PAGE_IDLE_FLAG
 	help
-	  This builds the default data access monitoring primitives for DAMON
+	  This builds the default data access monitoring operations for DAMON
 	  that works for the physical address space.
 
 config DAMON_VADDR_KUNIT_TEST
-	bool "Test for DAMON primitives" if !KUNIT_ALL_TESTS
+	bool "Test for DAMON operations" if !KUNIT_ALL_TESTS
 	depends on DAMON_VADDR && KUNIT=y
 	default KUNIT_ALL_TESTS
 	help
-	  This builds the DAMON virtual addresses primitives Kunit test suite.
+	  This builds the DAMON virtual addresses operations Kunit test suite.
 
 	  For more information on KUnit and unit tests in general, please refer
 	  to the KUnit documentation.
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index f7d5ac377a2b..03931472991a 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DAMON)		:= core.o
-obj-$(CONFIG_DAMON_VADDR)	+= prmtv-common.o vaddr.o
-obj-$(CONFIG_DAMON_PADDR)	+= prmtv-common.o paddr.o
+obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
+obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
diff --git a/mm/damon/core.c b/mm/damon/core.c
index bf495236d741..be93fb1c3473 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -204,10 +204,10 @@ struct damon_ctx *damon_new_ctx(void)
 
 	ctx->sample_interval = 5 * 1000;
 	ctx->aggr_interval = 100 * 1000;
-	ctx->primitive_update_interval = 60 * 1000 * 1000;
+	ctx->ops_update_interval = 60 * 1000 * 1000;
 
 	ktime_get_coarse_ts64(&ctx->last_aggregation);
-	ctx->last_primitive_update = ctx->last_aggregation;
+	ctx->last_ops_update = ctx->last_aggregation;
 
 	mutex_init(&ctx->kdamond_lock);
 
@@ -224,8 +224,8 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next_t;
 
-	if (ctx->primitive.cleanup) {
-		ctx->primitive.cleanup(ctx);
+	if (ctx->ops.cleanup) {
+		ctx->ops.cleanup(ctx);
 		return;
 	}
 
@@ -250,7 +250,7 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
  * @ctx:		monitoring context
  * @sample_int:		time interval between samplings
  * @aggr_int:		time interval between aggregations
- * @primitive_upd_int:	time interval between monitoring primitive updates
+ * @ops_upd_int:	time interval between monitoring operations updates
  * @min_nr_reg:		minimal number of regions
  * @max_nr_reg:		maximum number of regions
  *
@@ -260,7 +260,7 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
  * Return: 0 on success, negative error code otherwise.
  */
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		    unsigned long aggr_int, unsigned long primitive_upd_int,
+		    unsigned long aggr_int, unsigned long ops_upd_int,
 		    unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
 	if (min_nr_reg < 3)
@@ -270,7 +270,7 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
-	ctx->primitive_update_interval = primitive_upd_int;
+	ctx->ops_update_interval = ops_upd_int;
 	ctx->min_nr_regions = min_nr_reg;
 	ctx->max_nr_regions = max_nr_reg;
 
@@ -516,10 +516,10 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
 {
 	bool ret = __damos_valid_target(r, s);
 
-	if (!ret || !s->quota.esz || !c->primitive.get_scheme_score)
+	if (!ret || !s->quota.esz || !c->ops.get_scheme_score)
 		return ret;
 
-	return c->primitive.get_scheme_score(c, t, r, s) >= s->quota.min_score;
+	return c->ops.get_scheme_score(c, t, r, s) >= s->quota.min_score;
 }
 
 static void damon_do_apply_schemes(struct damon_ctx *c,
@@ -576,7 +576,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 
 		/* Apply the scheme */
-		if (c->primitive.apply_scheme) {
+		if (c->ops.apply_scheme) {
 			if (quota->esz &&
 					quota->charged_sz + sz > quota->esz) {
 				sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
@@ -586,7 +586,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 				damon_split_region_at(c, t, r, sz);
 			}
 			ktime_get_coarse_ts64(&begin);
-			sz_applied = c->primitive.apply_scheme(c, t, r, s);
+			sz_applied = c->ops.apply_scheme(c, t, r, s);
 			ktime_get_coarse_ts64(&end);
 			quota->total_charged_ns += timespec64_to_ns(&end) -
 				timespec64_to_ns(&begin);
@@ -660,7 +660,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 			damos_set_effective_quota(quota);
 		}
 
-		if (!c->primitive.get_scheme_score)
+		if (!c->ops.get_scheme_score)
 			continue;
 
 		/* Fill up the score histogram */
@@ -669,7 +669,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 			damon_for_each_region(r, t) {
 				if (!__damos_valid_target(r, s))
 					continue;
-				score = c->primitive.get_scheme_score(
+				score = c->ops.get_scheme_score(
 						c, t, r, s);
 				quota->histogram[score] +=
 					r->ar.end - r->ar.start;
@@ -848,14 +848,15 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 }
 
 /*
- * Check whether it is time to check and apply the target monitoring regions
+ * Check whether it is time to check and apply the operations-related data
+ * structures.
  *
  * Returns true if it is.
  */
-static bool kdamond_need_update_primitive(struct damon_ctx *ctx)
+static bool kdamond_need_update_operations(struct damon_ctx *ctx)
 {
-	return damon_check_reset_time_interval(&ctx->last_primitive_update,
-			ctx->primitive_update_interval);
+	return damon_check_reset_time_interval(&ctx->last_ops_update,
+			ctx->ops_update_interval);
 }
 
 /*
@@ -873,11 +874,11 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	if (kthread_should_stop())
 		return true;
 
-	if (!ctx->primitive.target_valid)
+	if (!ctx->ops.target_valid)
 		return false;
 
 	damon_for_each_target(t, ctx) {
-		if (ctx->primitive.target_valid(t))
+		if (ctx->ops.target_valid(t))
 			return false;
 	}
 
@@ -976,8 +977,8 @@ static int kdamond_fn(void *data)
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
-	if (ctx->primitive.init)
-		ctx->primitive.init(ctx);
+	if (ctx->ops.init)
+		ctx->ops.init(ctx);
 	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
 		done = true;
 
@@ -987,16 +988,16 @@ static int kdamond_fn(void *data)
 		if (kdamond_wait_activation(ctx))
 			continue;
 
-		if (ctx->primitive.prepare_access_checks)
-			ctx->primitive.prepare_access_checks(ctx);
+		if (ctx->ops.prepare_access_checks)
+			ctx->ops.prepare_access_checks(ctx);
 		if (ctx->callback.after_sampling &&
 				ctx->callback.after_sampling(ctx))
 			done = true;
 
 		kdamond_usleep(ctx->sample_interval);
 
-		if (ctx->primitive.check_accesses)
-			max_nr_accesses = ctx->primitive.check_accesses(ctx);
+		if (ctx->ops.check_accesses)
+			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx,
@@ -1008,13 +1009,13 @@ static int kdamond_fn(void *data)
 			kdamond_apply_schemes(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
-			if (ctx->primitive.reset_aggregated)
-				ctx->primitive.reset_aggregated(ctx);
+			if (ctx->ops.reset_aggregated)
+				ctx->ops.reset_aggregated(ctx);
 		}
 
-		if (kdamond_need_update_primitive(ctx)) {
-			if (ctx->primitive.update)
-				ctx->primitive.update(ctx);
+		if (kdamond_need_update_operations(ctx)) {
+			if (ctx->ops.update)
+				ctx->ops.update(ctx);
 			sz_limit = damon_region_sz_limit(ctx);
 		}
 	}
@@ -1025,8 +1026,8 @@ static int kdamond_fn(void *data)
 
 	if (ctx->callback.before_terminate)
 		ctx->callback.before_terminate(ctx);
-	if (ctx->primitive.cleanup)
-		ctx->primitive.cleanup(ctx);
+	if (ctx->ops.cleanup)
+		ctx->ops.cleanup(ctx);
 
 	pr_debug("kdamond (%d) finishes\n", current->pid);
 	mutex_lock(&ctx->kdamond_lock);
diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 0d3a14c00acf..8f7f32595055 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -74,7 +74,7 @@ static void damon_dbgfs_test_set_targets(struct kunit *test)
 	char buf[64];
 
 	/* Make DAMON consider target has no pid */
-	ctx->primitive = (struct damon_primitive){};
+	ctx->ops = (struct damon_operations){};
 
 	dbgfs_set_targets(ctx, 0, NULL);
 	sprint_target_ids(ctx, buf, 64);
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 78ff645433c6..719278a8cc5e 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -56,7 +56,7 @@ static ssize_t dbgfs_attrs_read(struct file *file,
 	mutex_lock(&ctx->kdamond_lock);
 	ret = scnprintf(kbuf, ARRAY_SIZE(kbuf), "%lu %lu %lu %lu %lu\n",
 			ctx->sample_interval, ctx->aggr_interval,
-			ctx->primitive_update_interval, ctx->min_nr_regions,
+			ctx->ops_update_interval, ctx->min_nr_regions,
 			ctx->max_nr_regions);
 	mutex_unlock(&ctx->kdamond_lock);
 
@@ -277,7 +277,7 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 
 static inline bool target_has_pid(const struct damon_ctx *ctx)
 {
-	return ctx->primitive.target_valid == damon_va_target_valid;
+	return ctx->ops.target_valid == damon_va_target_valid;
 }
 
 static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
@@ -477,9 +477,9 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 
 	/* Configure the context for the address space type */
 	if (id_is_pid)
-		damon_va_set_primitives(ctx);
+		damon_va_set_operations(ctx);
 	else
-		damon_pa_set_primitives(ctx);
+		damon_pa_set_operations(ctx);
 
 	ret = dbgfs_set_targets(ctx, nr_targets, target_pids);
 	if (!ret)
@@ -735,7 +735,7 @@ static struct damon_ctx *dbgfs_new_ctx(void)
 	if (!ctx)
 		return NULL;
 
-	damon_va_set_primitives(ctx);
+	damon_va_set_operations(ctx);
 	ctx->callback.before_terminate = dbgfs_before_terminate;
 	return ctx;
 }
diff --git a/mm/damon/prmtv-common.c b/mm/damon/ops-common.c
similarity index 99%
rename from mm/damon/prmtv-common.c
rename to mm/damon/ops-common.c
index 92a04f5831d6..e346cc10d143 100644
--- a/mm/damon/prmtv-common.c
+++ b/mm/damon/ops-common.c
@@ -10,7 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 
-#include "prmtv-common.h"
+#include "ops-common.h"
 
 /*
  * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
diff --git a/mm/damon/prmtv-common.h b/mm/damon/ops-common.h
similarity index 100%
rename from mm/damon/prmtv-common.h
rename to mm/damon/ops-common.h
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5e8244f65a1a..9f0abd0369bc 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -14,7 +14,7 @@
 #include <linux/swap.h>
 
 #include "../internal.h"
-#include "prmtv-common.h"
+#include "ops-common.h"
 
 static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
 		unsigned long addr, void *arg)
@@ -261,15 +261,15 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 	return DAMOS_MAX_SCORE;
 }
 
-void damon_pa_set_primitives(struct damon_ctx *ctx)
+void damon_pa_set_operations(struct damon_ctx *ctx)
 {
-	ctx->primitive.init = NULL;
-	ctx->primitive.update = NULL;
-	ctx->primitive.prepare_access_checks = damon_pa_prepare_access_checks;
-	ctx->primitive.check_accesses = damon_pa_check_accesses;
-	ctx->primitive.reset_aggregated = NULL;
-	ctx->primitive.target_valid = damon_pa_target_valid;
-	ctx->primitive.cleanup = NULL;
-	ctx->primitive.apply_scheme = damon_pa_apply_scheme;
-	ctx->primitive.get_scheme_score = damon_pa_scheme_score;
+	ctx->ops.init = NULL;
+	ctx->ops.update = NULL;
+	ctx->ops.prepare_access_checks = damon_pa_prepare_access_checks;
+	ctx->ops.check_accesses = damon_pa_check_accesses;
+	ctx->ops.reset_aggregated = NULL;
+	ctx->ops.target_valid = damon_pa_target_valid;
+	ctx->ops.cleanup = NULL;
+	ctx->ops.apply_scheme = damon_pa_apply_scheme;
+	ctx->ops.get_scheme_score = damon_pa_scheme_score;
 }
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 29da37192e4a..3c93095c793c 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -384,7 +384,7 @@ static int __init damon_reclaim_init(void)
 	if (!ctx)
 		return -ENOMEM;
 
-	damon_pa_set_primitives(ctx);
+	damon_pa_set_operations(ctx);
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
 	target = damon_new_target();
diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index f0d0ba591792..1a55bb6c36c3 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -314,7 +314,7 @@ static struct kunit_case damon_test_cases[] = {
 };
 
 static struct kunit_suite damon_test_suite = {
-	.name = "damon-primitives",
+	.name = "damon-operations",
 	.test_cases = damon_test_cases,
 };
 kunit_test_suite(damon_test_suite);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 6d3454dd3204..c0eb32025f9b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -15,7 +15,7 @@
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
 
-#include "prmtv-common.h"
+#include "ops-common.h"
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
 #undef DAMON_MIN_REGION
@@ -739,17 +739,17 @@ static int damon_va_scheme_score(struct damon_ctx *context,
 	return DAMOS_MAX_SCORE;
 }
 
-void damon_va_set_primitives(struct damon_ctx *ctx)
+void damon_va_set_operations(struct damon_ctx *ctx)
 {
-	ctx->primitive.init = damon_va_init;
-	ctx->primitive.update = damon_va_update;
-	ctx->primitive.prepare_access_checks = damon_va_prepare_access_checks;
-	ctx->primitive.check_accesses = damon_va_check_accesses;
-	ctx->primitive.reset_aggregated = NULL;
-	ctx->primitive.target_valid = damon_va_target_valid;
-	ctx->primitive.cleanup = NULL;
-	ctx->primitive.apply_scheme = damon_va_apply_scheme;
-	ctx->primitive.get_scheme_score = damon_va_scheme_score;
+	ctx->ops.init = damon_va_init;
+	ctx->ops.update = damon_va_update;
+	ctx->ops.prepare_access_checks = damon_va_prepare_access_checks;
+	ctx->ops.check_accesses = damon_va_check_accesses;
+	ctx->ops.reset_aggregated = NULL;
+	ctx->ops.target_valid = damon_va_target_valid;
+	ctx->ops.cleanup = NULL;
+	ctx->ops.apply_scheme = damon_va_apply_scheme;
+	ctx->ops.get_scheme_score = damon_va_scheme_score;
 }
 
 #include "vaddr-test.h"
-- 
2.17.1

