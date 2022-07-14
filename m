Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1391574F07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiGNNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239748AbiGNNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:21:20 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0535E30A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:21:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPOX_1657804875;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPOX_1657804875)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:17 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 12/16] erofs: introduce struct z_erofs_decompress_backend
Date:   Thu, 14 Jul 2022 21:20:47 +0800
Message-Id: <20220714132051.46012-13-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
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

Let's introduce struct z_erofs_decompress_backend in order to pass
on the decompression backend context between helper functions more
easier and avoid too many arguments.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 142 +++++++++++++++++++++++++----------------------
 fs/erofs/zdata.h |   3 +-
 2 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f24b866bc975..7aea6bb1e018 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -847,9 +847,22 @@ static bool z_erofs_page_is_invalidated(struct page *page)
 	return !page->mapping && !z_erofs_is_shortlived_page(page);
 }
 
-static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
-				   struct page **pages, struct page **pagepool)
+struct z_erofs_decompress_backend {
+	struct page *onstack_pages[Z_EROFS_ONSTACK_PAGES];
+	struct super_block *sb;
+	struct z_erofs_pcluster *pcl;
+
+	/* pages with the longest decompressed length for deduplication */
+	struct page **decompressed_pages;
+	/* pages to keep the compressed data */
+	struct page **compressed_pages;
+
+	struct page **pagepool;
+};
+
+static int z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
 {
+	struct z_erofs_pcluster *pcl = be->pcl;
 	struct z_erofs_bvec_iter biter;
 	struct page *old_bvpage;
 	int i, err = 0;
@@ -857,39 +870,39 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
 	z_erofs_bvec_iter_begin(&biter, &pcl->bvset, Z_EROFS_INLINE_BVECS, 0);
 	for (i = 0; i < pcl->vcnt; ++i) {
 		struct z_erofs_bvec bvec;
-		unsigned int pagenr;
+		unsigned int pgnr;
 
 		z_erofs_bvec_dequeue(&biter, &bvec, &old_bvpage);
 
 		if (old_bvpage)
-			z_erofs_put_shortlivedpage(pagepool, old_bvpage);
+			z_erofs_put_shortlivedpage(be->pagepool, old_bvpage);
 
-		pagenr = (bvec.offset + pcl->pageofs_out) >> PAGE_SHIFT;
-		DBG_BUGON(pagenr >= pcl->nr_pages);
+		pgnr = (bvec.offset + pcl->pageofs_out) >> PAGE_SHIFT;
+		DBG_BUGON(pgnr >= pcl->nr_pages);
 		DBG_BUGON(z_erofs_page_is_invalidated(bvec.page));
 		/*
 		 * currently EROFS doesn't support multiref(dedup),
 		 * so here erroring out one multiref page.
 		 */
-		if (pages[pagenr]) {
+		if (be->decompressed_pages[pgnr]) {
 			DBG_BUGON(1);
-			z_erofs_page_mark_eio(pages[pagenr]);
-			z_erofs_onlinepage_endio(pages[pagenr]);
+			z_erofs_page_mark_eio(be->decompressed_pages[pgnr]);
+			z_erofs_onlinepage_endio(be->decompressed_pages[pgnr]);
 			err = -EFSCORRUPTED;
 		}
-		pages[pagenr] = bvec.page;
+		be->decompressed_pages[pgnr] = bvec.page;
 	}
 
 	old_bvpage = z_erofs_bvec_iter_end(&biter);
 	if (old_bvpage)
-		z_erofs_put_shortlivedpage(pagepool, old_bvpage);
+		z_erofs_put_shortlivedpage(be->pagepool, old_bvpage);
 	return err;
 }
 
-static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
-			struct z_erofs_pcluster *pcl, struct page **pages,
-			struct page **pagepool, bool *overlapped)
+static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
+				  bool *overlapped)
 {
+	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	struct page **compressed_pages;
 	int i, err = 0;
@@ -919,7 +932,7 @@ static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
 		if (!z_erofs_is_shortlived_page(page)) {
-			if (erofs_page_is_managed(sbi, page)) {
+			if (erofs_page_is_managed(EROFS_SB(be->sb), page)) {
 				if (!PageUptodate(page))
 					err = -EIO;
 				continue;
@@ -927,59 +940,55 @@ static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
 
 			pgnr = (bvec->offset + pcl->pageofs_out) >> PAGE_SHIFT;
 			DBG_BUGON(pgnr >= pcl->nr_pages);
-			if (pages[pgnr]) {
+			if (be->decompressed_pages[pgnr]) {
 				DBG_BUGON(1);
-				z_erofs_page_mark_eio(pages[pgnr]);
-				z_erofs_onlinepage_endio(pages[pgnr]);
+				z_erofs_page_mark_eio(
+						be->decompressed_pages[pgnr]);
+				z_erofs_onlinepage_endio(
+						be->decompressed_pages[pgnr]);
 				err = -EFSCORRUPTED;
 			}
-			pages[pgnr] = page;
+			be->decompressed_pages[pgnr] = page;
 			*overlapped = true;
 		}
 	}
 
 	if (err) {
 		kfree(compressed_pages);
-		return ERR_PTR(err);
+		return err;
 	}
-	return compressed_pages;
+	be->compressed_pages = compressed_pages;
+	return 0;
 }
 
-static int z_erofs_decompress_pcluster(struct super_block *sb,
-				       struct z_erofs_pcluster *pcl,
-				       struct page **pagepool, int err)
+static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
+				       int err)
 {
-	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
+	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	unsigned int i, inputsize, outputsize, llen, nr_pages;
-	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
-	struct page **pages, **compressed_pages, *page;
-
+	unsigned int i, inputsize, outputsize, llen, nr_pages, err2;
+	struct page *page;
 	bool overlapped, partial;
 
-	might_sleep();
 	DBG_BUGON(!READ_ONCE(pcl->nr_pages));
-
 	mutex_lock(&pcl->lock);
 	nr_pages = pcl->nr_pages;
 
-	if (nr_pages <= Z_EROFS_VMAP_ONSTACK_PAGES)
-		pages = pages_onstack;
-	else
-		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
-				       GFP_KERNEL | __GFP_NOFAIL);
-
-	for (i = 0; i < nr_pages; ++i)
-		pages[i] = NULL;
-
-	err = z_erofs_parse_out_bvecs(pcl, pages, pagepool);
-	compressed_pages = z_erofs_parse_in_bvecs(sbi, pcl, pages,
-						pagepool, &overlapped);
-	if (IS_ERR(compressed_pages)) {
-		err = PTR_ERR(compressed_pages);
-		compressed_pages = NULL;
+	if (nr_pages <= Z_EROFS_ONSTACK_PAGES) {
+		be->decompressed_pages = be->onstack_pages;
+		memset(be->decompressed_pages, 0,
+		       sizeof(struct page *) * nr_pages);
+	} else {
+		be->decompressed_pages =
+			kvcalloc(nr_pages, sizeof(struct page *),
+				 GFP_KERNEL | __GFP_NOFAIL);
 	}
 
+	err = z_erofs_parse_out_bvecs(be);
+	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
+	if (err2)
+		err = err2;
 	if (err)
 		goto out;
 
@@ -998,9 +1007,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		inputsize = pclusterpages * PAGE_SIZE;
 
 	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
-					.sb = sb,
-					.in = compressed_pages,
-					.out = pages,
+					.sb = be->sb,
+					.in = be->compressed_pages,
+					.out = be->decompressed_pages,
 					.pageofs_in = pcl->pageofs_in,
 					.pageofs_out = pcl->pageofs_out,
 					.inputsize = inputsize,
@@ -1008,7 +1017,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
 					.partial_decoding = partial
-				 }, pagepool);
+				 }, be->pagepool);
 
 out:
 	/* must handle all compressed pages before actual file pages */
@@ -1024,29 +1033,29 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 				continue;
 
 			/* recycle all individual short-lived pages */
-			(void)z_erofs_put_shortlivedpage(pagepool, page);
+			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
 	}
-	kfree(compressed_pages);
+	kfree(be->compressed_pages);
 
 	for (i = 0; i < nr_pages; ++i) {
-		page = pages[i];
+		page = be->decompressed_pages[i];
 		if (!page)
 			continue;
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
 		/* recycle all individual short-lived pages */
-		if (z_erofs_put_shortlivedpage(pagepool, page))
+		if (z_erofs_put_shortlivedpage(be->pagepool, page))
 			continue;
 		if (err)
 			z_erofs_page_mark_eio(page);
 		z_erofs_onlinepage_endio(page);
 	}
 
-	if (pages != pages_onstack)
-		kvfree(pages);
+	if (be->decompressed_pages != be->onstack_pages)
+		kvfree(be->decompressed_pages);
 
 	pcl->nr_pages = 0;
 	pcl->bvset.nextpage = NULL;
@@ -1061,23 +1070,23 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 				     struct page **pagepool)
 {
+	struct z_erofs_decompress_backend be = {
+		.sb = io->sb,
+		.pagepool = pagepool,
+	};
 	z_erofs_next_pcluster_t owned = io->head;
 
 	while (owned != Z_EROFS_PCLUSTER_TAIL_CLOSED) {
-		struct z_erofs_pcluster *pcl;
-
-		/* no possible that 'owned' equals Z_EROFS_WORK_TPTR_TAIL */
+		/* impossible that 'owned' equals Z_EROFS_WORK_TPTR_TAIL */
 		DBG_BUGON(owned == Z_EROFS_PCLUSTER_TAIL);
-
-		/* no possible that 'owned' equals NULL */
+		/* impossible that 'owned' equals Z_EROFS_PCLUSTER_NIL */
 		DBG_BUGON(owned == Z_EROFS_PCLUSTER_NIL);
 
-		pcl = container_of(owned, struct z_erofs_pcluster, next);
-		owned = READ_ONCE(pcl->next);
+		be.pcl = container_of(owned, struct z_erofs_pcluster, next);
+		owned = READ_ONCE(be.pcl->next);
 
-		z_erofs_decompress_pcluster(io->sb, pcl, pagepool,
-					    io->eio ? -EIO : 0);
-		erofs_workgroup_put(&pcl->obj);
+		z_erofs_decompress_pcluster(&be, io->eio ? -EIO : 0);
+		erofs_workgroup_put(&be.pcl->obj);
 	}
 }
 
@@ -1103,7 +1112,6 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	if (sync) {
 		if (!atomic_add_return(bios, &io->pending_bios))
 			complete(&io->u.done);
-
 		return;
 	}
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 5964c942799e..ec09ca035fbb 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -173,7 +173,6 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 	}
 }
 
-#define Z_EROFS_VMAP_ONSTACK_PAGES	\
-	min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
+#define Z_EROFS_ONSTACK_PAGES		32
 
 #endif
-- 
2.24.4

