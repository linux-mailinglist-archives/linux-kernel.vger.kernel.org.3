Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2972F470363
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242560AbhLJPEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242520AbhLJPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:04:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2CBC0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:00:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BBDCB8287A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86F7C341CE;
        Fri, 10 Dec 2021 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639148434;
        bh=y8H2kQ+tPKgYwCE/ltPr01vYVYZxxqWoen6fskpcMaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wt+UhGrlWtr+uavnEf3zkUDnl3VqoboivqmVA9ZYYNQoTMapB1x7/VQ5t0XpI17GV
         jiIVI7v7AhImubbO2iRL78fxCOtJ+++24nDn/pMd0H1pOQ/ax+cjM3vinSrZxkbWBQ
         X0C/2NOR3Cibp5pkt9il7zWAKL4ACoEW319XOce1BcOfMD/RsLZc1cIjPsfvoE4tw9
         m9yXlgIQzrra2GTD2mwgUL9O42BvVoINfQXT7BNKPO77M1xS7YSdysuUfljwlhKVKl
         HFO+MAjolsO0jI76NFkC1NS+hoRl7i9Sh4s9wLOfhRCLYmRKJABIP8MJlBiZLapWP0
         H5NO7PnHab0yg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/6] mm/damon/reclaim: Provide reclamation statistics
Date:   Fri, 10 Dec 2021 15:00:13 +0000
Message-Id: <20211210150016.35349-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211210150016.35349-1-sj@kernel.org>
References: <20211210150016.35349-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements new DAMON_RECLAIM parameters for statistics
reporting.  Those can be used for understanding how DAMON_RECLAIM is
working, and for tuning the other parameters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index dc1485044eaf..bc476cef688e 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -185,6 +185,36 @@ module_param(monitor_region_end, ulong, 0600);
 static int kdamond_pid __read_mostly = -1;
 module_param(kdamond_pid, int, 0400);
 
+/*
+ * Number of memory regions that tried to be reclaimed.
+ */
+static unsigned long nr_reclaim_tried_regions __read_mostly;
+module_param(nr_reclaim_tried_regions, ulong, 0400);
+
+/*
+ * Total bytes of memory regions that tried to be reclaimed.
+ */
+static unsigned long bytes_reclaim_tried_regions __read_mostly;
+module_param(bytes_reclaim_tried_regions, ulong, 0400);
+
+/*
+ * Number of memory regions that successfully be reclaimed.
+ */
+static unsigned long nr_reclaimed_regions __read_mostly;
+module_param(nr_reclaimed_regions, ulong, 0400);
+
+/*
+ * Total bytes of memory regions that successfully be reclaimed.
+ */
+static unsigned long bytes_reclaimed_regions __read_mostly;
+module_param(bytes_reclaimed_regions, ulong, 0400);
+
+/*
+ * Number of times that the time/space quota limits have exceeded
+ */
+static unsigned long nr_quota_exceeds __read_mostly;
+module_param(nr_quota_exceeds, ulong, 0400);
+
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
@@ -333,6 +363,21 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
 
+static int damon_reclaim_after_aggregation(struct damon_ctx *c)
+{
+	struct damos *s;
+
+	/* update the stats parameter */
+	damon_for_each_scheme(s, c) {
+		nr_reclaim_tried_regions = s->stat.nr_tried;
+		bytes_reclaim_tried_regions = s->stat.sz_tried;
+		nr_reclaimed_regions = s->stat.nr_applied;
+		bytes_reclaimed_regions = s->stat.sz_applied;
+		nr_quota_exceeds = s->stat.qt_exceeds;
+	}
+	return 0;
+}
+
 static int __init damon_reclaim_init(void)
 {
 	ctx = damon_new_ctx();
@@ -340,6 +385,7 @@ static int __init damon_reclaim_init(void)
 		return -ENOMEM;
 
 	damon_pa_set_primitives(ctx);
+	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
 	/* 4242 means nothing but fun */
 	target = damon_new_target(4242);
-- 
2.17.1

