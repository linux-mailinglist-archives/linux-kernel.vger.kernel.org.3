Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC164DA036
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350136AbiCOQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350119AbiCOQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:38:29 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E087157141
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:37:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V7IiZEe_1647362233;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V7IiZEe_1647362233)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 00:37:13 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1 3/3] mm/damon/sysfs: Add CMA memory monitoring
Date:   Wed, 16 Mar 2022 00:37:07 +0800
Message-Id: <0325c53c46291f96e6d99223fc4d2d8454de5d97.1647378112.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1647378112.git.xhao@linux.alibaba.com>
References: <cover.1647378112.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users can do the CMA memory monitoring by writing a special
keyword 'cma' to the 'operations' sysfs file. Then, DAMON will
check the special keyword and configure the monitoring context to
run with the CMA reserved physical address space.

Unlike other physical memorys monitoring, the monitoring target region
will be automatically set.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h |   1 +
 mm/damon/Makefile     |   2 +-
 mm/damon/paddr-cma.c  | 104 ++++++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs.c      |   1 +
 4 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 mm/damon/paddr-cma.c

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f23cbfa4248d..27eaa6d6c43a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -266,6 +266,7 @@ struct damos {
 enum damon_ops_id {
 	DAMON_OPS_VADDR,
 	DAMON_OPS_PADDR,
+	DAMON_OPS_CMA,
 	NR_DAMON_OPS,
 };
 
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index dbf7190b4144..d32048f70f6d 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -2,7 +2,7 @@
 
 obj-y				:= core.o
 obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
-obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
+obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o paddr-cma.o
 obj-$(CONFIG_DAMON_SYSFS)	+= sysfs.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
diff --git a/mm/damon/paddr-cma.c b/mm/damon/paddr-cma.c
new file mode 100644
index 000000000000..ad422854c8c6
--- /dev/null
+++ b/mm/damon/paddr-cma.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON Primitives for The CMA Physical Address Space
+ *
+ * Author: Xin Hao <xhao@linux.alibaba.com>
+ */
+#ifdef CONFIG_CMA
+
+#define pr_fmt(fmt) "damon-cma: " fmt
+
+#include <linux/cma.h>
+
+#include "ops-common.h"
+#include "../cma.h"
+
+static int damon_cma_area_regions(struct damon_addr_range *regions, int nr_cma_area)
+{
+	int i;
+
+	if (!nr_cma_area || !regions)
+		return -EINVAL;
+
+	for (i = 0; i < nr_cma_area; i++) {
+		phys_addr_t base = cma_get_base(&cma_areas[i]);
+
+		regions[i].start = base;
+		regions[i].end = base + cma_get_size(&cma_areas[i]);
+	}
+
+	return 0;
+}
+
+static void __damon_cma_init_regions(struct damon_ctx *ctx,
+				     struct damon_target *t)
+{
+	struct damon_target *ti;
+	struct damon_region *r;
+	struct damon_addr_range regions[MAX_CMA_AREAS];
+	unsigned long sz = 0, nr_pieces;
+	int i, tidx = 0;
+
+	if (damon_cma_area_regions(regions, cma_area_count)) {
+		damon_for_each_target(ti, ctx) {
+			if (ti == t)
+				break;
+			tidx++;
+		}
+		pr_err("Failed to get CMA regions of %dth target\n", tidx);
+		return;
+	}
+
+	for (i = 0; i < cma_area_count; i++)
+		sz += regions[i].end - regions[i].start;
+	if (ctx->min_nr_regions)
+		sz /= ctx->min_nr_regions;
+	if (sz < DAMON_MIN_REGION)
+		sz = DAMON_MIN_REGION;
+
+	/* Set the initial three regions of the target */
+	for (i = 0; i < cma_area_count; i++) {
+		r = damon_new_region(regions[i].start, regions[i].end);
+		if (!r) {
+			pr_err("%d'th init region creation failed\n", i);
+			return;
+		}
+		damon_add_region(r, t);
+
+		nr_pieces = (regions[i].end - regions[i].start) / sz;
+		damon_evenly_split_region(t, r, nr_pieces);
+	}
+}
+
+static void damon_cma_init(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, ctx) {
+		/* the user may set the target regions as they want */
+		if (!damon_nr_regions(t))
+			__damon_cma_init_regions(ctx, t);
+	}
+}
+
+static int __init damon_cma_initcall(void)
+{
+	struct damon_operations ops = {
+		.id = DAMON_OPS_CMA,
+		.init = damon_cma_init,
+		.update = NULL,
+		.prepare_access_checks = damon_pa_prepare_access_checks,
+		.check_accesses = damon_pa_check_accesses,
+		.reset_aggregated = NULL,
+		.target_valid = NULL,
+		.cleanup = NULL,
+		.apply_scheme = damon_pa_apply_scheme,
+		.get_scheme_score = damon_pa_scheme_score,
+	};
+
+	return damon_register_ops(&ops);
+};
+
+subsys_initcall(damon_cma_initcall);
+
+#endif /* CONFIG_CMA */
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d39f74969469..8a34880cc2c4 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1761,6 +1761,7 @@ static struct kobj_type damon_sysfs_attrs_ktype = {
 static const char * const damon_sysfs_ops_strs[] = {
 	"vaddr",
 	"paddr",
+	"cma",
 };
 
 struct damon_sysfs_context {
-- 
2.27.0

