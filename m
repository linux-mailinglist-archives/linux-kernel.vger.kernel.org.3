Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0314BB6D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiBRK1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:27:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiBRK1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:27:25 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E6B1C933
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:27:08 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id l9so6853144plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hqHpu7GNiQ7sov4kYNjqEALFPOD9/Tm3brs65rAgImQ=;
        b=WemAjxdvDJxi/gdw2o4cpnBr8UVsDgC7LoJYR2HABYI9q2Yigfb4FQH5fOL2C71Uvf
         xIQf4gjVALQLZiKGayJPcVxNBRVo4QLQ/NJs2iJMZwwd7Mqtrp/+2IfhnTYQgCqnHsqN
         xSSTfLBn3aMEA6feuwqU6IpJW9KLZpKGBMkXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hqHpu7GNiQ7sov4kYNjqEALFPOD9/Tm3brs65rAgImQ=;
        b=8FbjtzaybxZtW+0AFtalTjPLyX8lbob1/Ku7uL/iwrvQZs+NZwsil0jYnj8C1Sldfq
         dHZiyWG6bQx5HI9fnIiScL9feY/Le8JULleeSc5XpElDOU4i+e1pHEf3SjIBp0nkANtP
         FslQZgIoh6GN6laS3aEGwgqLv+78zPgeZLED1Q7rsPDVaF356aPf7hpQp+2HjPwHRYrQ
         a21A9PA0wmhEVCGt8MoaIlDO1BUUJ+aRIKfnh6ZLlq8Cnw5HsCHXYB2N50ZXY8NFFuKi
         ofqcaK5SBQI6dudcJm21jXzjHvW+e2/8AmIx89WyUrs2tIah3sJpeDjRlJgUQbN8SZVl
         oanw==
X-Gm-Message-State: AOAM530wbDu3tCycJLf7/j02R2UyU5WQ+mK8upRb0t3k6YAsXxLBBM8u
        XAz8h5PSngPZhXI3u/fJtQHJrQ==
X-Google-Smtp-Source: ABdhPJzE6KorrXyvR8/DrCYcXC6lVMeubBsEjGkeOFacWDvrtAQrxwge/nOKRo3E2hg0SgOLGXOVmA==
X-Received: by 2002:a17:902:b78b:b0:14f:69f:d6e1 with SMTP id e11-20020a170902b78b00b0014f069fd6e1mr6883593pls.85.1645180027444;
        Fri, 18 Feb 2022 02:27:07 -0800 (PST)
Received: from localhost.localdomain ([210.107.197.32])
        by smtp.googlemail.com with ESMTPSA id k13sm2767696pfc.176.2022.02.18.02.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:27:07 -0800 (PST)
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     akpm@linux-foundation.org
Cc:     Jonghyeon Kim <tome01@ajou.ac.kr>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/3] mm/damon/reclaim: Add per NUMA node proactive reclamation by DAMON_RECLAIM.
Date:   Fri, 18 Feb 2022 19:26:11 +0900
Message-Id: <20220218102611.31895-4-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218102611.31895-1-tome01@ajou.ac.kr>
References: <20220218102611.31895-1-tome01@ajou.ac.kr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To add DAMON_RECLAIM worker threads(kdamond) that do proactive
reclamation per NUMA node, each node must have its own context.
'per_node' is added to enable it.

If 'per_node' is true, kdamonds as online NUMA node will be waked up and
start monitoring to proactively reclaim memory. If 'per_node' is false,
only one kdamond thread will start monitoring for all system memory.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 mm/damon/reclaim.c | 147 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 43 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index b53d9c22fad1..85e8f97dd599 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -177,13 +177,27 @@ static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
 
 /*
- * PID of the DAMON thread
+ * Enable monitoring memory regions per NUMA node.
  *
- * If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.
+ * By default, watermarks consist of based on total system memory.
+ */
+static bool per_node __read_mostly;
+module_param(per_node, bool, 0600);
+
+/*
+ * Number of currently running DAMON worker threads
+ */
+static unsigned long nr_kdamond __read_mostly;
+module_param(nr_kdamond, ulong, 0400);
+
+/*
+ * First PID of the DAMON threads
+ *
+ * If DAMON_RECLAIM is enabled, this becomes the first PID of the worker threads.
  * Else, -1.
  */
-static int kdamond_pid __read_mostly = -1;
-module_param(kdamond_pid, int, 0400);
+static int kdamond_start_pid __read_mostly = -1;
+module_param(kdamond_start_pid, int, 0400);
 
 /*
  * Number of memory regions that tried to be reclaimed.
@@ -215,8 +229,8 @@ module_param(bytes_reclaimed_regions, ulong, 0400);
 static unsigned long nr_quota_exceeds __read_mostly;
 module_param(nr_quota_exceeds, ulong, 0400);
 
-static struct damon_ctx *ctx;
-static struct damon_target *target;
+static struct damon_ctx *ctxs[MAX_NUMNODES];
+static struct damon_target *targets[MAX_NUMNODES];
 
 struct damon_reclaim_ram_walk_arg {
 	unsigned long start;
@@ -251,7 +265,7 @@ static bool get_monitoring_region(unsigned long *start, unsigned long *end)
 	return true;
 }
 
-static struct damos *damon_reclaim_new_scheme(void)
+static struct damos *damon_reclaim_new_scheme(int node)
 {
 	struct damos_watermarks wmarks = {
 		.metric = DAMOS_WMARK_FREE_MEM_RATE,
@@ -259,6 +273,7 @@ static struct damos *damon_reclaim_new_scheme(void)
 		.high = wmarks_high,
 		.mid = wmarks_mid,
 		.low = wmarks_low,
+		.node = node,
 	};
 	struct damos_quota quota = {
 		/*
@@ -290,56 +305,99 @@ static struct damos *damon_reclaim_new_scheme(void)
 	return scheme;
 }
 
-static int damon_reclaim_turn(bool on)
+static int damon_reclaim_start(int nid)
 {
 	struct damon_region *region;
 	struct damos *scheme;
 	int err;
+	unsigned long start, end;
 
-	if (!on) {
-		err = damon_stop(&ctx, 1);
-		if (!err)
-			kdamond_pid = -1;
-		return err;
-	}
-
-	err = damon_set_attrs(ctx, sample_interval, aggr_interval, 0,
+	err = damon_set_attrs(ctxs[nid], sample_interval, aggr_interval, 0,
 			min_nr_regions, max_nr_regions);
 	if (err)
 		return err;
 
-	if (monitor_region_start > monitor_region_end)
-		return -EINVAL;
-	if (!monitor_region_start && !monitor_region_end &&
-			!get_monitoring_region(&monitor_region_start,
-				&monitor_region_end))
-		return -EINVAL;
+	if (per_node) {
+		monitor_region_start = monitor_region_end = 0;
+
+		start = PFN_PHYS(node_start_pfn(nid));
+		end = PFN_PHYS(node_start_pfn(nid) + node_present_pages(nid) - 1);
+		if (end <= start)
+			return -EINVAL;
+	} else {
+		if (!monitor_region_start && !monitor_region_end &&
+				!get_monitoring_region(&monitor_region_start,
+					&monitor_region_end))
+			return -EINVAL;
+		start = monitor_region_start;
+		end = monitor_region_end;
+	}
+
 	/* DAMON will free this on its own when finish monitoring */
-	region = damon_new_region(monitor_region_start, monitor_region_end);
+	region = damon_new_region(start, end);
 	if (!region)
 		return -ENOMEM;
-	damon_add_region(region, target);
+	damon_add_region(region, targets[nid]);
 
 	/* Will be freed by 'damon_set_schemes()' below */
-	scheme = damon_reclaim_new_scheme();
+	scheme = damon_reclaim_new_scheme(nid);
 	if (!scheme) {
 		err = -ENOMEM;
 		goto free_region_out;
 	}
-	err = damon_set_schemes(ctx, &scheme, 1);
+
+	err = damon_set_schemes(ctxs[nid], &scheme, 1);
 	if (err)
 		goto free_scheme_out;
 
-	err = damon_start(&ctx, 1);
+	err = damon_start_one(ctxs[nid]);
 	if (!err) {
-		kdamond_pid = ctx->kdamond->pid;
+		if (kdamond_start_pid == -1)
+			kdamond_start_pid = ctxs[nid]->kdamond->pid;
+		nr_kdamond++;
 		return 0;
 	}
 
 free_scheme_out:
 	damon_destroy_scheme(scheme);
 free_region_out:
-	damon_destroy_region(region, target);
+	damon_destroy_region(region, targets[nid]);
+
+	return err;
+}
+
+static int damon_reclaim_start_all(void)
+{
+	int nid, err;
+
+	if (!per_node)
+		return damon_reclaim_start(0);
+
+	for_each_online_node(nid) {
+		err = damon_reclaim_start(nid);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int damon_reclaim_turn(bool on)
+{
+	int err;
+
+	if (!on) {
+		err = damon_stop(ctxs, nr_kdamond);
+		if (!err) {
+			kdamond_start_pid = -1;
+			nr_kdamond = 0;
+			monitor_region_start = 0;
+			monitor_region_end = 0;
+		}
+		return err;
+	}
+
+	err = damon_reclaim_start_all();
 	return err;
 }
 
@@ -380,21 +438,24 @@ static int damon_reclaim_after_aggregation(struct damon_ctx *c)
 
 static int __init damon_reclaim_init(void)
 {
-	ctx = damon_new_ctx();
-	if (!ctx)
-		return -ENOMEM;
-
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
-		return -EINVAL;
-
-	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
-
-	target = damon_new_target();
-	if (!target) {
-		damon_destroy_ctx(ctx);
-		return -ENOMEM;
+	int nid;
+
+	for_each_node(nid) {
+		ctxs[nid] = damon_new_ctx();
+		if (!ctxs[nid])
+			return -ENOMEM;
+
+		if (damon_select_ops(ctxs[nid], DAMON_OPS_PADDR))
+			return -EINVAL;
+		ctxs[nid]->callback.after_aggregation = damon_reclaim_after_aggregation;
+
+		targets[nid] = damon_new_target();
+		if (!targets[nid]) {
+			damon_destroy_ctx(ctxs[nid]);
+			return -ENOMEM;
+		}
+		damon_add_target(ctxs[nid], targets[nid]);
 	}
-	damon_add_target(ctx, target);
 
 	schedule_delayed_work(&damon_reclaim_timer, 0);
 	return 0;
-- 
2.17.1

