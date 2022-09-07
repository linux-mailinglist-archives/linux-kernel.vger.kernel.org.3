Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047E45B02E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiIGL3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIGL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:29:36 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D68532BB1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:29:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VOy9MDS_1662550166;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VOy9MDS_1662550166)
          by smtp.aliyun-inc.com;
          Wed, 07 Sep 2022 19:29:28 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH] mm/damon: Remove duplicate get_monitoring_region() definitions
Date:   Wed,  7 Sep 2022 19:29:24 +0800
Message-Id: <20220907112924.65546-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lru_sort.c and reclaim.c, they are all define get_monitoring_region()
function, there is no need to define it separately.

BTW, this patch remove tow struct 'damon_lru_sort_ram_walk_arg' and
'damon_reclaim_ram_walk_arg', though the two struct are removed, if we
want to add more fields to these struct for other purposes later, it will
not too late for us to use them again.
For example:
    struct damon_reclaim_ram_walk_arg {
	struct damon_addr_range raw_walk;
	xxx  A;
	xxx  B;
    }
    struct damon_lru_sort_ram_walk_arg {
	struct damon_addr_range raw_walk;
	xxx  A;
	xxx  B;
    }

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/lru_sort.c   | 35 ++---------------------------------
 mm/damon/ops-common.c | 28 ++++++++++++++++++++++++++++
 mm/damon/ops-common.h |  1 +
 mm/damon/reclaim.c    | 35 ++---------------------------------
 4 files changed, 33 insertions(+), 66 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 9de6f00a71c5..5032d59d46e4 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -13,6 +13,8 @@
 #include <linux/sched.h>
 #include <linux/workqueue.h>

+#include "ops-common.h"
+
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
@@ -257,39 +259,6 @@ module_param(nr_cold_quota_exceeds, ulong, 0400);
 static struct damon_ctx *ctx;
 static struct damon_target *target;

-struct damon_lru_sort_ram_walk_arg {
-	unsigned long start;
-	unsigned long end;
-};
-
-static int walk_system_ram(struct resource *res, void *arg)
-{
-	struct damon_lru_sort_ram_walk_arg *a = arg;
-
-	if (a->end - a->start < resource_size(res)) {
-		a->start = res->start;
-		a->end = res->end;
-	}
-	return 0;
-}
-
-/*
- * Find biggest 'System RAM' resource and store its start and end address in
- * @start and @end, respectively.  If no System RAM is found, returns false.
- */
-static bool get_monitoring_region(unsigned long *start, unsigned long *end)
-{
-	struct damon_lru_sort_ram_walk_arg arg = {};
-
-	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
-	if (arg.end <= arg.start)
-		return false;
-
-	*start = arg.start;
-	*end = arg.end;
-	return true;
-}
-
 /* Create a DAMON-based operation scheme for hot memory regions */
 static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 {
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index b1335de200e7..01938f33038d 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -172,3 +172,31 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,

 	return hotness;
 }
+
+static inline int walk_system_ram(struct resource *res, void *arg)
+{
+	struct damon_addr_range *a = arg;
+
+	if (a->end - a->start < resource_size(res)) {
+		a->start = res->start;
+		a->end = res->end;
+	}
+	return 0;
+}
+
+/*
+ * Find biggest 'System RAM' resource and store its start and end address in
+ * @start and @end, respectively.  If no System RAM is found, returns false.
+ */
+bool get_monitoring_region(unsigned long *start, unsigned long *end)
+{
+	struct damon_addr_range arg = {};
+
+	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
+	if (arg.end <= arg.start)
+		return false;
+
+	*start = arg.start;
+	*end = arg.end;
+	return true;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 52329ff361cd..e6f1c9b48042 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -16,3 +16,4 @@ int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
 int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
+bool get_monitoring_region(unsigned long *start, unsigned long *end);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index a7faf51b4bd4..20e83eee3c7d 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -13,6 +13,8 @@
 #include <linux/sched.h>
 #include <linux/workqueue.h>

+#include "ops-common.h"
+
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
@@ -229,39 +231,6 @@ module_param(nr_quota_exceeds, ulong, 0400);
 static struct damon_ctx *ctx;
 static struct damon_target *target;

-struct damon_reclaim_ram_walk_arg {
-	unsigned long start;
-	unsigned long end;
-};
-
-static int walk_system_ram(struct resource *res, void *arg)
-{
-	struct damon_reclaim_ram_walk_arg *a = arg;
-
-	if (a->end - a->start < resource_size(res)) {
-		a->start = res->start;
-		a->end = res->end;
-	}
-	return 0;
-}
-
-/*
- * Find biggest 'System RAM' resource and store its start and end address in
- * @start and @end, respectively.  If no System RAM is found, returns false.
- */
-static bool get_monitoring_region(unsigned long *start, unsigned long *end)
-{
-	struct damon_reclaim_ram_walk_arg arg = {};
-
-	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
-	if (arg.end <= arg.start)
-		return false;
-
-	*start = arg.start;
-	*end = arg.end;
-	return true;
-}
-
 static struct damos *damon_reclaim_new_scheme(void)
 {
 	struct damos_watermarks wmarks = {
--
2.31.0
