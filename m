Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1234A9418
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbiBDGmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiBDGmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:42:01 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD7AC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 22:42:01 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c3so4338874pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 22:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rISkLwI8y1o4MK01DmaMEQr2ev7FtgdoKg4XunSBNQo=;
        b=RtuYQApiZlqwEDImEzb2GYKdSK/hcGq8amHc0axonzvlu/rfQpHhlQmQ55mzluQBPe
         koo+4H8gyxaYOs63q2bhNnCiNZUykE9kdm/RtzrDWSeJjn5ER0T25klg1K9oK/IOcf91
         WGjLpZvJD5s5cPlGDepMde4o9VSV+RdW47H5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rISkLwI8y1o4MK01DmaMEQr2ev7FtgdoKg4XunSBNQo=;
        b=0k/FAxz18M9kk1vOAW/+JlRTUaoNOZqFXqzdIFv5CBYOuN1N+6W4Piayy+4gQ4h0Hh
         XyIfhvwO/8rVqwpW8cXvsB8mmksuRCJe00go9O4K+e1tFl8f3TvAzkGqCUDbN3w1ySt2
         q+lxR+4BSSR4DfaB2AmE3CeZSluTdNPB7tJEUhR7FXbT+cguUD5mo7Xz5rn3BQHmIhOs
         IJLQluXG1KQLGOPNDrXP6/Chw0dS1ofz49hOR/fQmhHE9u3uGss4cjCmK6qdEIWwUnYP
         oaZy8fx8OHDGvqhiogQ2Zf3KgWQcNBFVc3zaafdLMzZLZ/87NC6CE5Tg57d5AvPmgEDq
         PQbQ==
X-Gm-Message-State: AOAM532VeSVl2RWAqcCUK2rwioVtH4E8FXLQIR475WOIgmyMIyCV5SyB
        biF1X+D3uZ0y6hjler7UXDVYwpwhhG2QuVgd
X-Google-Smtp-Source: ABdhPJzLKxKlfA89Wiett/3ZCPywkiJx4TjC5hegGObysT6sIK74AXfzPDmgKnBOVmanEwky+BzWOg==
X-Received: by 2002:a17:90a:f3d5:: with SMTP id ha21mr1494389pjb.175.1643956920195;
        Thu, 03 Feb 2022 22:42:00 -0800 (PST)
Received: from localhost.localdomain ([210.107.197.32])
        by smtp.googlemail.com with ESMTPSA id ga21sm5050809pjb.2.2022.02.03.22.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 22:41:59 -0800 (PST)
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
Cc:     Jonghyeon Kim <tome01@ajou.ac.kr>, SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: Rebase DAMON_RECALIM watermarks for NUMA nodes
Date:   Fri,  4 Feb 2022 15:40:59 +0900
Message-Id: <20220204064059.6244-1-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current DAMON_RECALIM is not compatible the NUMA memory system. To proactively
reclaim memory, DAMON_RECLAIM kernel thread(kdamond) has to wake up before
kswapd does reclaim memory. However, the current watermark for proactive
reclamation is based on entire system free memory. So, though the one memory
node is fully used, kdamond is not waked up.

This patch allows kdamond thread to select watermark options for monitoring
specific node or whole system free memory.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 include/linux/damon.h |  4 +++-
 mm/damon/core.c       | 15 +++++++++++----
 mm/damon/dbgfs.c      |  3 ++-
 mm/damon/reclaim.c    | 12 +++++++++++-
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 114cfb96d37a..3846b985bcb9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -220,6 +220,7 @@ struct damos_stat {
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
+ * @node:		NUMA node of target regions.
  *
  * For each aggregation interval, DAMON finds regions which fit in the
  * condition (&min_sz_region, &max_sz_region, &min_nr_accesses,
@@ -251,6 +252,7 @@ struct damos {
 	struct damos_watermarks wmarks;
 	struct damos_stat stat;
 	struct list_head list;
+	int node;
 };
 
 struct damon_ctx;
@@ -477,7 +479,7 @@ struct damos *damon_new_scheme(
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
 		unsigned int min_age_region, unsigned int max_age_region,
 		enum damos_action action, struct damos_quota *quota,
-		struct damos_watermarks *wmarks);
+		struct damos_watermarks *wmarks, int node);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 07449d46d3d3..dfa87cda0266 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -87,7 +87,7 @@ struct damos *damon_new_scheme(
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
 		unsigned int min_age_region, unsigned int max_age_region,
 		enum damos_action action, struct damos_quota *quota,
-		struct damos_watermarks *wmarks)
+		struct damos_watermarks *wmarks, int node)
 {
 	struct damos *scheme;
 
@@ -125,6 +125,8 @@ struct damos *damon_new_scheme(
 	scheme->wmarks.low = wmarks->low;
 	scheme->wmarks.activated = true;
 
+	scheme->node = node;
+
 	return scheme;
 }
 
@@ -936,13 +938,18 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	return true;
 }
 
-static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
+static unsigned long damos_wmark_metric_value(struct damos *scheme)
 {
 	struct sysinfo i;
+	enum damos_wmark_metric metric = scheme->wmarks.metric;
+	int target_node = scheme->node;
 
 	switch (metric) {
 	case DAMOS_WMARK_FREE_MEM_RATE:
-		si_meminfo(&i);
+		if (target_node == NUMA_NO_NODE)
+			si_meminfo(&i);
+		else
+			si_meminfo_node(&i, target_node);
 		return i.freeram * 1000 / i.totalram;
 	default:
 		break;
@@ -961,7 +968,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
 		return 0;
 
-	metric = damos_wmark_metric_value(scheme->wmarks.metric);
+	metric = damos_wmark_metric_value(scheme);
 	/* higher than high watermark or lower than low watermark */
 	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
 		if (scheme->wmarks.activated)
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 78ff645433c6..3f61cbde7ec4 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -224,7 +224,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 
 		pos += parsed;
 		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
-				min_age, max_age, action, &quota, &wmarks);
+				min_age, max_age, action, &quota, &wmarks,
+				NUMA_NO_NODE);
 		if (!scheme)
 			goto fail;
 
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index d85e0898f905..ad80f14d164f 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -189,6 +189,14 @@ module_param(monitor_region_start, ulong, 0600);
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
 
+/*
+ * NUMA node of target to monitor
+ *
+ * If node is NUMA_NO_NODE, watermark is based on system entire memory.
+ */
+static int node __read_mostly = NUMA_NO_NODE;
+module_param(node, int, 0600);
+
 /*
  * PID of the DAMON thread
  *
@@ -298,7 +306,9 @@ static struct damos *damon_reclaim_new_scheme(void)
 			/* under the quota. */
 			&quota,
 			/* (De)activate this according to the watermarks. */
-			&wmarks);
+			&wmarks,
+			/* Watermarks is based on this NUMA node */
+			node);
 
 	return scheme;
 }
-- 
2.17.1

