Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EEE4DA033
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350120AbiCOQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiCOQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:38:26 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AED57145
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:37:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V7IiZEH_1647362230;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V7IiZEH_1647362230)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 00:37:11 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1 1/3] mm/damon: rename damon_evenly_split_region()
Date:   Wed, 16 Mar 2022 00:37:05 +0800
Message-Id: <537ed6bc00ea35dbd73270477d77707891e97b0c.1647378112.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1647378112.git.xhao@linux.alibaba.com>
References: <cover.1647378112.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch rename damon_va_evenly_split_region() to
damon_evenly_split_region() is aimed to call it
in the physical address space.

So there fix it, and move it to "ops-common.c" file.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/ops-common.c | 39 +++++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |  3 +++
 mm/damon/vaddr-test.h |  6 +++---
 mm/damon/vaddr.c      | 41 +----------------------------------------
 4 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index e346cc10d143..fd5e98005358 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -131,3 +131,42 @@ int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
 	/* Return coldness of the region */
 	return DAMOS_MAX_SCORE - hotness;
 }
+
+/*
+ * Size-evenly split a region into 'nr_pieces' small regions
+ *
+ * Returns 0 on success, or negative error code otherwise.
+ */
+int damon_evenly_split_region(struct damon_target *t,
+		struct damon_region *r, unsigned int nr_pieces)
+{
+	unsigned long sz_orig, sz_piece, orig_end;
+	struct damon_region *n = NULL, *next;
+	unsigned long start;
+
+	if (!r || !nr_pieces)
+		return -EINVAL;
+
+	orig_end = r->ar.end;
+	sz_orig = r->ar.end - r->ar.start;
+	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
+
+	if (!sz_piece)
+		return -EINVAL;
+
+	r->ar.end = r->ar.start + sz_piece;
+	next = damon_next_region(r);
+	for (start = r->ar.end; start + sz_piece <= orig_end;
+			start += sz_piece) {
+		n = damon_new_region(start, start + sz_piece);
+		if (!n)
+			return -ENOMEM;
+		damon_insert_region(n, r, next, t);
+		r = n;
+	}
+	/* complement last region for possible rounding error */
+	if (n)
+		n->ar.end = orig_end;
+
+	return 0;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index e790cb5f8fe0..fd441016a2ae 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -14,3 +14,6 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
 
 int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
+
+int damon_evenly_split_region(struct damon_target *t,
+		struct damon_region *r, unsigned int nr_pieces);
diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 1a55bb6c36c3..161906ab66a7 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -256,7 +256,7 @@ static void damon_test_split_evenly_fail(struct kunit *test,
 
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test,
-			damon_va_evenly_split_region(t, r, nr_pieces), -EINVAL);
+			damon_evenly_split_region(t, r, nr_pieces), -EINVAL);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1u);
 
 	damon_for_each_region(r, t) {
@@ -277,7 +277,7 @@ static void damon_test_split_evenly_succ(struct kunit *test,
 
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test,
-			damon_va_evenly_split_region(t, r, nr_pieces), 0);
+			damon_evenly_split_region(t, r, nr_pieces), 0);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_pieces);
 
 	damon_for_each_region(r, t) {
@@ -294,7 +294,7 @@ static void damon_test_split_evenly_succ(struct kunit *test,
 
 static void damon_test_split_evenly(struct kunit *test)
 {
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(NULL, NULL, 5),
+	KUNIT_EXPECT_EQ(test, damon_evenly_split_region(NULL, NULL, 5),
 			-EINVAL);
 
 	damon_test_split_evenly_fail(test, 0, 100, 0);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b2ec0aa1ff45..0870e178b1b8 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -56,45 +56,6 @@ static struct mm_struct *damon_get_mm(struct damon_target *t)
  * Functions for the initial monitoring target regions construction
  */
 
-/*
- * Size-evenly split a region into 'nr_pieces' small regions
- *
- * Returns 0 on success, or negative error code otherwise.
- */
-static int damon_va_evenly_split_region(struct damon_target *t,
-		struct damon_region *r, unsigned int nr_pieces)
-{
-	unsigned long sz_orig, sz_piece, orig_end;
-	struct damon_region *n = NULL, *next;
-	unsigned long start;
-
-	if (!r || !nr_pieces)
-		return -EINVAL;
-
-	orig_end = r->ar.end;
-	sz_orig = r->ar.end - r->ar.start;
-	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
-
-	if (!sz_piece)
-		return -EINVAL;
-
-	r->ar.end = r->ar.start + sz_piece;
-	next = damon_next_region(r);
-	for (start = r->ar.end; start + sz_piece <= orig_end;
-			start += sz_piece) {
-		n = damon_new_region(start, start + sz_piece);
-		if (!n)
-			return -ENOMEM;
-		damon_insert_region(n, r, next, t);
-		r = n;
-	}
-	/* complement last region for possible rounding error */
-	if (n)
-		n->ar.end = orig_end;
-
-	return 0;
-}
-
 static unsigned long sz_range(struct damon_addr_range *r)
 {
 	return r->end - r->start;
@@ -265,7 +226,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 		damon_add_region(r, t);
 
 		nr_pieces = (regions[i].end - regions[i].start) / sz;
-		damon_va_evenly_split_region(t, r, nr_pieces);
+		damon_evenly_split_region(t, r, nr_pieces);
 	}
 }
 
-- 
2.27.0

