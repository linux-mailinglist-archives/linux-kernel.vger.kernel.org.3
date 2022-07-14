Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390DB574F02
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbiGNNWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbiGNNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:21:25 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086CD5D0C0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:21:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPRP_1657804880;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPRP_1657804880)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:21 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 15/16] erofs: record the longest decompressed size in this round
Date:   Thu, 14 Jul 2022 21:20:50 +0800
Message-Id: <20220714132051.46012-16-hsiangkao@linux.alibaba.com>
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

Currently, `pcl->length' records the longest decompressed length
as long as the pcluster itself isn't reclaimed.  However, such
number is unneeded for the general cases since it doesn't indicate
the exact decompressed size in this round.

Instead, let's record the decompressed size for this round instead,
thus `pcl->nr_pages' can be completely dropped and pageofs_out is
also designed to be kept in sync with `pcl->length'.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 76 +++++++++++++++++-------------------------------
 fs/erofs/zdata.h | 11 +++----
 2 files changed, 30 insertions(+), 57 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 391755dafecd..8dcfc2a9704e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -482,7 +482,6 @@ static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
 	struct z_erofs_pcluster *pcl = fe->pcl;
-	unsigned int length;
 
 	/* to avoid unexpected loop formed by corrupted images */
 	if (fe->owned_head == &pcl->next || pcl == fe->tailpcl) {
@@ -495,24 +494,6 @@ static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe)
 		return -EFSCORRUPTED;
 	}
 
-	length = READ_ONCE(pcl->length);
-	if (length & Z_EROFS_PCLUSTER_FULL_LENGTH) {
-		if ((map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) > length) {
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-	} else {
-		unsigned int llen = map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT;
-
-		if (map->m_flags & EROFS_MAP_FULL_MAPPED)
-			llen |= Z_EROFS_PCLUSTER_FULL_LENGTH;
-
-		while (llen > length &&
-		       length != cmpxchg_relaxed(&pcl->length, length, llen)) {
-			cpu_relax();
-			length = READ_ONCE(pcl->length);
-		}
-	}
 	mutex_lock(&pcl->lock);
 	/* used to check tail merging loop due to corrupted images */
 	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
@@ -543,9 +524,8 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 
 	atomic_set(&pcl->obj.refcount, 1);
 	pcl->algorithmformat = map->m_algorithmformat;
-	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
-		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
-			Z_EROFS_PCLUSTER_FULL_LENGTH : 0);
+	pcl->length = 0;
+	pcl->partial = true;
 
 	/* new pclusters should be claimed as type 1, primary and followed */
 	pcl->next = fe->owned_head;
@@ -703,7 +683,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	bool tight = true, exclusive;
 
 	enum z_erofs_cache_alloctype cache_strategy;
-	unsigned int cur, end, spiltted, index;
+	unsigned int cur, end, spiltted;
 	int err = 0;
 
 	/* register locked file pages as online pages in pack */
@@ -806,12 +786,17 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	/* bump up the number of spiltted parts of a page */
 	++spiltted;
 
-	/* also update nr_pages */
-	index = page->index - (map->m_la >> PAGE_SHIFT);
-	fe->pcl->nr_pages = max_t(pgoff_t, fe->pcl->nr_pages, index + 1);
+	if (fe->pcl->length < offset + end - map->m_la) {
+		fe->pcl->length = offset + end - map->m_la;
+		fe->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
+	}
+	if ((map->m_flags & EROFS_MAP_FULL_MAPPED) &&
+	    fe->pcl->length == map->m_llen)
+		fe->pcl->partial = false;
 next_part:
-	/* can be used for verification */
+	/* shorten the remaining extent to update progress */
 	map->m_llen = offset + cur - map->m_la;
+	map->m_flags &= ~EROFS_MAP_FULL_MAPPED;
 
 	end = cur;
 	if (end > 0)
@@ -858,7 +843,7 @@ struct z_erofs_decompress_backend {
 	struct page **compressed_pages;
 
 	struct page **pagepool;
-	unsigned int onstack_used;
+	unsigned int onstack_used, nr_pages;
 };
 
 static int z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
@@ -867,7 +852,7 @@ static int z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
 	unsigned int pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
 	struct page *oldpage;
 
-	DBG_BUGON(pgnr >= be->pcl->nr_pages);
+	DBG_BUGON(pgnr >= be->nr_pages);
 	oldpage = be->decompressed_pages[pgnr];
 	be->decompressed_pages[pgnr] = bvec->page;
 
@@ -955,23 +940,22 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	unsigned int i, inputsize, outputsize, llen, nr_pages, err2;
+	unsigned int i, inputsize, err2;
 	struct page *page;
-	bool overlapped, partial;
+	bool overlapped;
 
-	DBG_BUGON(!READ_ONCE(pcl->nr_pages));
 	mutex_lock(&pcl->lock);
-	nr_pages = pcl->nr_pages;
+	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
 
 	/* allocate (de)compressed page arrays if cannot be kept on stack */
 	be->decompressed_pages = NULL;
 	be->compressed_pages = NULL;
 	be->onstack_used = 0;
-	if (nr_pages <= Z_EROFS_ONSTACK_PAGES) {
+	if (be->nr_pages <= Z_EROFS_ONSTACK_PAGES) {
 		be->decompressed_pages = be->onstack_pages;
-		be->onstack_used = nr_pages;
+		be->onstack_used = be->nr_pages;
 		memset(be->decompressed_pages, 0,
-		       sizeof(struct page *) * nr_pages);
+		       sizeof(struct page *) * be->nr_pages);
 	}
 
 	if (pclusterpages + be->onstack_used <= Z_EROFS_ONSTACK_PAGES)
@@ -979,7 +963,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 
 	if (!be->decompressed_pages)
 		be->decompressed_pages =
-			kvcalloc(nr_pages, sizeof(struct page *),
+			kvcalloc(be->nr_pages, sizeof(struct page *),
 				 GFP_KERNEL | __GFP_NOFAIL);
 	if (!be->compressed_pages)
 		be->compressed_pages =
@@ -993,15 +977,6 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	if (err)
 		goto out;
 
-	llen = pcl->length >> Z_EROFS_PCLUSTER_LENGTH_BIT;
-	if (nr_pages << PAGE_SHIFT >= pcl->pageofs_out + llen) {
-		outputsize = llen;
-		partial = !(pcl->length & Z_EROFS_PCLUSTER_FULL_LENGTH);
-	} else {
-		outputsize = (nr_pages << PAGE_SHIFT) - pcl->pageofs_out;
-		partial = true;
-	}
-
 	if (z_erofs_is_inline_pcluster(pcl))
 		inputsize = pcl->tailpacking_size;
 	else
@@ -1014,10 +989,10 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.pageofs_in = pcl->pageofs_in,
 					.pageofs_out = pcl->pageofs_out,
 					.inputsize = inputsize,
-					.outputsize = outputsize,
+					.outputsize = pcl->length,
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
-					.partial_decoding = partial
+					.partial_decoding = pcl->partial,
 				 }, be->pagepool);
 
 out:
@@ -1042,7 +1017,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	    be->compressed_pages >= be->onstack_pages + Z_EROFS_ONSTACK_PAGES)
 		kvfree(be->compressed_pages);
 
-	for (i = 0; i < nr_pages; ++i) {
+	for (i = 0; i < be->nr_pages; ++i) {
 		page = be->decompressed_pages[i];
 		if (!page)
 			continue;
@@ -1060,7 +1035,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	if (be->decompressed_pages != be->onstack_pages)
 		kvfree(be->decompressed_pages);
 
-	pcl->nr_pages = 0;
+	pcl->length = 0;
+	pcl->partial = true;
 	pcl->bvset.nextpage = NULL;
 	pcl->vcnt = 0;
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index ec09ca035fbb..a7fd44d21d9e 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -12,9 +12,6 @@
 #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
 #define Z_EROFS_INLINE_BVECS		2
 
-#define Z_EROFS_PCLUSTER_FULL_LENGTH    0x00000001
-#define Z_EROFS_PCLUSTER_LENGTH_BIT     1
-
 /*
  * let's leave a type here in case of introducing
  * another tagged pointer later.
@@ -53,7 +50,7 @@ struct z_erofs_pcluster {
 	/* A: point to next chained pcluster or TAILs */
 	z_erofs_next_pcluster_t next;
 
-	/* A: lower limit of decompressed length and if full length or not */
+	/* L: the maximum decompression size of this round */
 	unsigned int length;
 
 	/* L: total number of bvecs */
@@ -65,9 +62,6 @@ struct z_erofs_pcluster {
 	/* I: page offset of inline compressed data */
 	unsigned short pageofs_in;
 
-	/* L: maximum relative page index in bvecs */
-	unsigned short nr_pages;
-
 	union {
 		/* L: inline a certain number of bvec for bootstrap */
 		struct z_erofs_bvset_inline bvset;
@@ -87,6 +81,9 @@ struct z_erofs_pcluster {
 	/* I: compression algorithm format */
 	unsigned char algorithmformat;
 
+	/* L: whether partial decompression or not */
+	bool partial;
+
 	/* A: compressed bvecs (can be cached or inplaced pages) */
 	struct z_erofs_bvec compressed_bvecs[];
 };
-- 
2.24.4

