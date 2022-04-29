Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5850D51505D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378841AbiD2QJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378815AbiD2QJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A54996BD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FA8622B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D751FC385AE;
        Fri, 29 Apr 2022 16:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248378;
        bh=7UakBPu0iWJJixVSPO62y2876KNAoXM3u3qWB69JqFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3B5SxHBvRaT5/G6adHHMtRK1xtcEqNd1DCbK4qQKQGIzcpcGiuWNkCIo3jtI9AoD
         QzxvnUIrn84esYMn7uZ3++BzUf6qwtGbAIPSWlHCzrBTGIO1D1OueFEtAxy++fQFX9
         k6SL7vpnc4mbZzFD8MgPcGEpvVbmDXJyGPscEGPh1YuI5iwHhH9SAk6YyHD70d94ay
         SVy7pGKcbrkKaz8FhH0cCjR294AEWuX6p2bldo+fRgO8CPDshrxhTuLgOLcM3Sy++r
         r6Nn130sH/bf+GSSIw+hPTMLsV8hwg6eTB9b4hjC72pAJ3ICSM1m+80qsgjGUa8YhG
         9+SaRKEB/5Pkw==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 05/14] mm/damon/vaddr: remove damon_va_apply_three_regions()
Date:   Fri, 29 Apr 2022 16:05:57 +0000
Message-Id: <20220429160606.127307-6-sj@kernel.org>
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

'damon_va_apply_three_regions()' is just a wrapper of its general
version, 'damon_set_regions()'.  This commit replaces the wrapper calls
to directly call the general version.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr-test.h |  6 +++---
 mm/damon/vaddr.c      | 18 +-----------------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index dbf2b8759607..602266e5ae22 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -98,7 +98,7 @@ static struct damon_region *__nth_region_of(struct damon_target *t, int idx)
 }
 
 /*
- * Test 'damon_va_apply_three_regions()'
+ * Test 'damon_set_regions()'
  *
  * test			kunit object
  * regions		an array containing start/end addresses of current
@@ -113,7 +113,7 @@ static struct damon_region *__nth_region_of(struct damon_target *t, int idx)
  * the change, DAMON periodically reads the mappings, simplifies it to the
  * three regions, and updates the monitoring target regions to fit in the three
  * regions.  The update of current target regions is the role of
- * 'damon_va_apply_three_regions()'.
+ * 'damon_set_regions()'.
  *
  * This test passes the given target regions and the new three regions that
  * need to be applied to the function and check whether it updates the regions
@@ -134,7 +134,7 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		damon_add_region(r, t);
 	}
 
-	damon_va_apply_three_regions(t, three_regions);
+	damon_set_regions(t, three_regions, 3);
 
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c1ddd598f087..9a56ff60f244 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -282,22 +282,6 @@ static void damon_va_init(struct damon_ctx *ctx)
 	}
 }
 
-/*
- * Functions for the dynamic monitoring target regions update
- */
-
-/*
- * Update damon regions for the three big regions of the given target
- *
- * t		the given target
- * bregions	the three big regions of the target
- */
-static void damon_va_apply_three_regions(struct damon_target *t,
-		struct damon_addr_range bregions[3])
-{
-	damon_set_regions(t, bregions, 3);
-}
-
 /*
  * Update regions for current memory mappings
  */
@@ -309,7 +293,7 @@ static void damon_va_update(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		if (damon_va_three_regions(t, three_regions))
 			continue;
-		damon_va_apply_three_regions(t, three_regions);
+		damon_set_regions(t, three_regions, 3);
 	}
 }
 
-- 
2.25.1

