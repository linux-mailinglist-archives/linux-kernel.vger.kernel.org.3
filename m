Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20C751505E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378866AbiD2QJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378830AbiD2QJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7201AA66C4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E04B0B83643
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C58C385A4;
        Fri, 29 Apr 2022 16:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248377;
        bh=msKXmTZ8EoExf7bXR/os1gnEhMEw5XzveVWRnGdG0P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1U7HO1NfvXXl46gRopjqJg2hmkrtrWhWJQ549la6DlvSXQRmM1HCCszrhvRPnxYx
         oFT2iJWNFVK+nmAxmGeaCZOO1BQ5XuuqqL39cceYnkgAmHnTUDQAMu56Jl6cRcV19C
         +NtiNQMMWWM5MQq4g0c0T3/gq60gWumIGpBJnl49QeTNtMRFBiWe0UE4BmC+9NOHUV
         9a7RNVzUFFQg7GeheAqjJGbaVAS4Py/rHP4xuy6OlPXLbDL/N9/grKGDVp2Jh50koB
         Btkg5r7V/fC6tJPoGpjR6GihUo5qrD1mPPWBhPIQEeTtMJGRLydol5RZbnIonR7tIV
         Hlmu+hiETYneg==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 04/14] mm/damon/vaddr: move 'damon_set_regions()' to core
Date:   Fri, 29 Apr 2022 16:05:56 +0000
Message-Id: <20220429160606.127307-5-sj@kernel.org>
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

This commit moves 'damon_set_regions()' from vaddr to core, as it is
aimed to be used by not only 'vaddr' but also other parts of DAMON.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 73 +++++++++++++++++++++++++++++++++++++++++++
 mm/damon/vaddr.c      | 73 -------------------------------------------
 3 files changed, 75 insertions(+), 73 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6cb5ab5d8e9d..d1e6ee28a2ff 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -494,6 +494,8 @@ static inline void damon_insert_region(struct damon_region *r,
 
 void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
+int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
+		unsigned int nr_ranges);
 
 struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 18c08e90563e..ebfe572f6a85 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -167,6 +167,79 @@ void damon_destroy_region(struct damon_region *r, struct damon_target *t)
 	damon_free_region(r);
 }
 
+/*
+ * Check whether a region is intersecting an address range
+ *
+ * Returns true if it is.
+ */
+static bool damon_intersect(struct damon_region *r,
+		struct damon_addr_range *re)
+{
+	return !(r->ar.end <= re->start || re->end <= r->ar.start);
+}
+
+/*
+ * damon_set_regions() - Set regions of a target for given address ranges.
+ * @t:		the given target.
+ * @ranges:	array of new monitoring target ranges.
+ * @nr_ranges:	length of @ranges.
+ *
+ * This function adds new regions to, or modify existing regions of a
+ * monitoring target to fit in specific ranges.
+ *
+ * Return: 0 if success, or negative error code otherwise.
+ */
+int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
+		unsigned int nr_ranges)
+{
+	struct damon_region *r, *next;
+	unsigned int i;
+
+	/* Remove regions which are not in the new ranges */
+	damon_for_each_region_safe(r, next, t) {
+		for (i = 0; i < nr_ranges; i++) {
+			if (damon_intersect(r, &ranges[i]))
+				break;
+		}
+		if (i == nr_ranges)
+			damon_destroy_region(r, t);
+	}
+
+	/* Add new regions or resize existing regions to fit in the ranges */
+	for (i = 0; i < nr_ranges; i++) {
+		struct damon_region *first = NULL, *last, *newr;
+		struct damon_addr_range *range;
+
+		range = &ranges[i];
+		/* Get the first/last regions intersecting with the range */
+		damon_for_each_region(r, t) {
+			if (damon_intersect(r, range)) {
+				if (!first)
+					first = r;
+				last = r;
+			}
+			if (r->ar.start >= range->end)
+				break;
+		}
+		if (!first) {
+			/* no region intersects with this range */
+			newr = damon_new_region(
+					ALIGN_DOWN(range->start,
+						DAMON_MIN_REGION),
+					ALIGN(range->end, DAMON_MIN_REGION));
+			if (!newr)
+				return -ENOMEM;
+			damon_insert_region(newr, damon_prev_region(r), r, t);
+		} else {
+			/* resize intersecting regions to fit in this range */
+			first->ar.start = ALIGN_DOWN(range->start,
+					DAMON_MIN_REGION);
+			last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
+		}
+	}
+	return 0;
+}
+
 struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 6879dd7a6ca5..c1ddd598f087 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -286,79 +286,6 @@ static void damon_va_init(struct damon_ctx *ctx)
  * Functions for the dynamic monitoring target regions update
  */
 
-/*
- * Check whether a region is intersecting an address range
- *
- * Returns true if it is.
- */
-static bool damon_intersect(struct damon_region *r,
-		struct damon_addr_range *re)
-{
-	return !(r->ar.end <= re->start || re->end <= r->ar.start);
-}
-
-/*
- * damon_set_regions() - Set regions of a target for given address ranges.
- * @t:		the given target.
- * @ranges:	array of new monitoring target ranges.
- * @nr_ranges:	length of @ranges.
- *
- * This function adds new regions to, or modify existing regions of a
- * monitoring target to fit in specific ranges.
- *
- * Return: 0 if success, or negative error code otherwise.
- */
-static int damon_set_regions(struct damon_target *t,
-		struct damon_addr_range *ranges, unsigned int nr_ranges)
-{
-	struct damon_region *r, *next;
-	unsigned int i;
-
-	/* Remove regions which are not in the new ranges */
-	damon_for_each_region_safe(r, next, t) {
-		for (i = 0; i < nr_ranges; i++) {
-			if (damon_intersect(r, &ranges[i]))
-				break;
-		}
-		if (i == nr_ranges)
-			damon_destroy_region(r, t);
-	}
-
-	/* Add new regions or resize existing regions to fit in the ranges */
-	for (i = 0; i < nr_ranges; i++) {
-		struct damon_region *first = NULL, *last, *newr;
-		struct damon_addr_range *range;
-
-		range = &ranges[i];
-		/* Get the first/last regions intersecting with the range */
-		damon_for_each_region(r, t) {
-			if (damon_intersect(r, range)) {
-				if (!first)
-					first = r;
-				last = r;
-			}
-			if (r->ar.start >= range->end)
-				break;
-		}
-		if (!first) {
-			/* no region intersects with this range */
-			newr = damon_new_region(
-					ALIGN_DOWN(range->start,
-						DAMON_MIN_REGION),
-					ALIGN(range->end, DAMON_MIN_REGION));
-			if (!newr)
-				return -ENOMEM;
-			damon_insert_region(newr, damon_prev_region(r), r, t);
-		} else {
-			/* resize intersecting regions to fit in this range */
-			first->ar.start = ALIGN_DOWN(range->start,
-					DAMON_MIN_REGION);
-			last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
-		}
-	}
-	return 0;
-}
-
 /*
  * Update damon regions for the three big regions of the given target
  *
-- 
2.25.1

