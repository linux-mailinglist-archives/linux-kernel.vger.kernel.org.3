Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F37515064
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378877AbiD2QKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378818AbiD2QJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731FA6E24
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88FD9622B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E04C385A4;
        Fri, 29 Apr 2022 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248383;
        bh=UiOUnirJF3MSoLl+83kD68mLG2ETBQfUjmFNgrkOyS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNguhYF/YQzTN4g/KZmySdsW+LAML/ITFMa1efNXZD8VCCrM9tFh3pf8O1cUa2toC
         7iSOdGD5VbVh5aJn6q617Q4uYOFvQDIV2t2FhQ3BHXxPpg9em0rIl7IErPke57ZAtS
         CPDeMpkJ+eFFxwsBVS3KeAxeNlN0Zw/0+FXrhiBojfMBYYrBowIuhV+oB1FYuPg1TZ
         QV+RyRyuw1ZARstzCcoDwIRGrQZhG8Hm8HLuTPsMLVcpZmc3wW08DQUrsIPWxV0za0
         bn4sk/SLZJ+f7mBoH8RjddKgk4qEvfEi5nwtg+Ilog+EkoFEODqERE5B92lgCA12IN
         a1Q/iWm/V/3Ag==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 13/14] mm/damon/reclaim: support online inputs update
Date:   Fri, 29 Apr 2022 16:06:05 +0000
Message-Id: <20220429160606.127307-14-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429160606.127307-1-sj@kernel.org>
References: <20220429160606.127307-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

DAMON_RECLAIM reads the user input parameters only when it starts.  To
allow more efficient online tuning, this commit implements a new input
parameter called 'commit_inputs'.  Writing true to the parameter makes
DAMON_RECLAIM reads the input parameters again.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 95 ++++++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 33 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 75cfd96a6060..f37c5d4b27fa 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -29,6 +29,18 @@
  */
 static bool enabled __read_mostly;
 
+/*
+ * Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
+ *
+ * Input parameters that updated while DAMON_RECLAIM is running are not applied
+ * by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
+ * of parametrs except ``enabled`` again.  Once the re-reading is done, this
+ * parameter is set as ``N``.  If invalid parameters are found while the
+ * re-reading, DAMON_RECLAIM will be disabled.
+ */
+static bool commit_inputs __read_mostly;
+module_param(commit_inputs, bool, 0600);
+
 /*
  * Time threshold for cold memory regions identification in microseconds.
  *
@@ -289,57 +301,56 @@ static struct damos *damon_reclaim_new_scheme(void)
 	return scheme;
 }
 
-static int damon_reclaim_turn(bool on)
+static int damon_reclaim_apply_parameters(void)
 {
-	struct damon_region *region;
 	struct damos *scheme;
-	int err;
-
-	if (!on) {
-		err = damon_stop(&ctx, 1);
-		if (!err)
-			kdamond_pid = -1;
-		return err;
-	}
+	struct damon_addr_range addr_range;
+	int err = 0;
 
 	err = damon_set_attrs(ctx, sample_interval, aggr_interval, 0,
 			min_nr_regions, max_nr_regions);
 	if (err)
 		return err;
 
+	/* Will be freed by next 'damon_set_schemes()' below */
+	scheme = damon_reclaim_new_scheme();
+	if (!scheme)
+		return -ENOMEM;
+	err = damon_set_schemes(ctx, &scheme, 1);
+	if (err)
+		return err;
+
 	if (monitor_region_start > monitor_region_end)
 		return -EINVAL;
 	if (!monitor_region_start && !monitor_region_end &&
 			!get_monitoring_region(&monitor_region_start,
 				&monitor_region_end))
 		return -EINVAL;
-	/* DAMON will free this on its own when finish monitoring */
-	region = damon_new_region(monitor_region_start, monitor_region_end);
-	if (!region)
-		return -ENOMEM;
-	damon_add_region(region, target);
+	addr_range.start = monitor_region_start;
+	addr_range.end = monitor_region_end;
+	return damon_set_regions(target, &addr_range, 1);
+}
 
-	/* Will be freed by 'damon_set_schemes()' below */
-	scheme = damon_reclaim_new_scheme();
-	if (!scheme) {
-		err = -ENOMEM;
-		goto free_region_out;
+static int damon_reclaim_turn(bool on)
+{
+	int err;
+
+	if (!on) {
+		err = damon_stop(&ctx, 1);
+		if (!err)
+			kdamond_pid = -1;
+		return err;
 	}
-	err = damon_set_schemes(ctx, &scheme, 1);
+
+	err = damon_reclaim_apply_parameters();
 	if (err)
-		goto free_scheme_out;
+		return err;
 
 	err = damon_start(&ctx, 1, true);
-	if (!err) {
-		kdamond_pid = ctx->kdamond->pid;
-		return 0;
-	}
-
-free_scheme_out:
-	damon_destroy_scheme(scheme);
-free_region_out:
-	damon_destroy_region(region, target);
-	return err;
+	if (err)
+		return err;
+	kdamond_pid = ctx->kdamond->pid;
+	return 0;
 }
 
 #define ENABLE_CHECK_INTERVAL_MS	1000
@@ -389,6 +400,7 @@ MODULE_PARM_DESC(enabled,
 static int damon_reclaim_after_aggregation(struct damon_ctx *c)
 {
 	struct damos *s;
+	int err = 0;
 
 	/* update the stats parameter */
 	damon_for_each_scheme(s, c) {
@@ -398,7 +410,23 @@ static int damon_reclaim_after_aggregation(struct damon_ctx *c)
 		bytes_reclaimed_regions = s->stat.sz_applied;
 		nr_quota_exceeds = s->stat.qt_exceeds;
 	}
-	return 0;
+
+	if (commit_inputs) {
+		err = damon_reclaim_apply_parameters();
+		commit_inputs = false;
+	}
+	return err;
+}
+
+static int damon_reclaim_after_wmarks_check(struct damon_ctx *c)
+{
+	int err = 0;
+
+	if (commit_inputs) {
+		err = damon_reclaim_apply_parameters();
+		commit_inputs = false;
+	}
+	return err;
 }
 
 static int __init damon_reclaim_init(void)
@@ -410,6 +438,7 @@ static int __init damon_reclaim_init(void)
 	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
 		return -EINVAL;
 
+	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
 	target = damon_new_target();
-- 
2.25.1

