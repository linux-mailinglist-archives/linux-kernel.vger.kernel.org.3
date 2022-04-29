Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C30515062
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378861AbiD2QJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378819AbiD2QJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8787A27D9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A6D1B83646
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83742C385B1;
        Fri, 29 Apr 2022 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248377;
        bh=hkH1/D7DIhccs3phYKPyf0rRvOlpVSoyczyAzJPRUHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2oQ5YlJWhwYr5aDiYSpJvGwNWzQclH7BzdPO1RpDEF1pIUVslcZhTkfcV78fYy4p
         g+Qmw3mkhkUZvNLugyv4BxahKNzJzvbNPjh/cZUet2skkNpgbmB5QoHZD6Kc9yIgsw
         NjP9TGxk56CY5BpjwjBvuwmq1RcHrkYmuFxbH9tdKZMOzjldzX9fLet5pPv2PmYLAX
         rfBgt6xMaqODabEVibdgmgFZdZy5A9/ZceavcBx5pWiaPyDKL7pBt/DqyTR4wrlgx9
         rOsSiOzYwiw//bbtab9DtbcEKLTHMgHMnOj5JpAV58pIBKxbG6xl4ujVdCNiW2ltX3
         mDfOmWD8XOBDQ==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 03/14] mm/damon/vaddr: generalize damon_va_apply_three_regions()
Date:   Fri, 29 Apr 2022 16:05:55 +0000
Message-Id: <20220429160606.127307-4-sj@kernel.org>
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

'damon_va_apply_three_regions()' is for adjusting address ranges to fit
in three discontiguous ranges.  The function can be generalized for
arbitrary number of discontiguous ranges and reused for future usage,
such as arbitrary online regions update.  For such future usage, this
commit introduces a generalized version of the function called
'damon_set_regions()'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 66 ++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d6abf76c1771..6879dd7a6ca5 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -298,59 +298,77 @@ static bool damon_intersect(struct damon_region *r,
 }
 
 /*
- * Update damon regions for the three big regions of the given target
+ * damon_set_regions() - Set regions of a target for given address ranges.
+ * @t:		the given target.
+ * @ranges:	array of new monitoring target ranges.
+ * @nr_ranges:	length of @ranges.
  *
- * t		the given target
- * bregions	the three big regions of the target
+ * This function adds new regions to, or modify existing regions of a
+ * monitoring target to fit in specific ranges.
+ *
+ * Return: 0 if success, or negative error code otherwise.
  */
-static void damon_va_apply_three_regions(struct damon_target *t,
-		struct damon_addr_range bregions[3])
+static int damon_set_regions(struct damon_target *t,
+		struct damon_addr_range *ranges, unsigned int nr_ranges)
 {
 	struct damon_region *r, *next;
 	unsigned int i;
 
-	/* Remove regions which are not in the three big regions now */
+	/* Remove regions which are not in the new ranges */
 	damon_for_each_region_safe(r, next, t) {
-		for (i = 0; i < 3; i++) {
-			if (damon_intersect(r, &bregions[i]))
+		for (i = 0; i < nr_ranges; i++) {
+			if (damon_intersect(r, &ranges[i]))
 				break;
 		}
-		if (i == 3)
+		if (i == nr_ranges)
 			damon_destroy_region(r, t);
 	}
 
-	/* Adjust intersecting regions to fit with the three big regions */
-	for (i = 0; i < 3; i++) {
-		struct damon_region *first = NULL, *last;
-		struct damon_region *newr;
-		struct damon_addr_range *br;
+	/* Add new regions or resize existing regions to fit in the ranges */
+	for (i = 0; i < nr_ranges; i++) {
+		struct damon_region *first = NULL, *last, *newr;
+		struct damon_addr_range *range;
 
-		br = &bregions[i];
-		/* Get the first and last regions which intersects with br */
+		range = &ranges[i];
+		/* Get the first/last regions intersecting with the range */
 		damon_for_each_region(r, t) {
-			if (damon_intersect(r, br)) {
+			if (damon_intersect(r, range)) {
 				if (!first)
 					first = r;
 				last = r;
 			}
-			if (r->ar.start >= br->end)
+			if (r->ar.start >= range->end)
 				break;
 		}
 		if (!first) {
-			/* no damon_region intersects with this big region */
+			/* no region intersects with this range */
 			newr = damon_new_region(
-					ALIGN_DOWN(br->start,
+					ALIGN_DOWN(range->start,
 						DAMON_MIN_REGION),
-					ALIGN(br->end, DAMON_MIN_REGION));
+					ALIGN(range->end, DAMON_MIN_REGION));
 			if (!newr)
-				continue;
+				return -ENOMEM;
 			damon_insert_region(newr, damon_prev_region(r), r, t);
 		} else {
-			first->ar.start = ALIGN_DOWN(br->start,
+			/* resize intersecting regions to fit in this range */
+			first->ar.start = ALIGN_DOWN(range->start,
 					DAMON_MIN_REGION);
-			last->ar.end = ALIGN(br->end, DAMON_MIN_REGION);
+			last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
 		}
 	}
+	return 0;
+}
+
+/*
+ * Update damon regions for the three big regions of the given target
+ *
+ * t		the given target
+ * bregions	the three big regions of the target
+ */
+static void damon_va_apply_three_regions(struct damon_target *t,
+		struct damon_addr_range bregions[3])
+{
+	damon_set_regions(t, bregions, 3);
 }
 
 /*
-- 
2.25.1

