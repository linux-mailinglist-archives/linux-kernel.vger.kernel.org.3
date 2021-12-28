Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CA7480DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 00:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhL1X3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 18:29:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46974 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbhL1X33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 18:29:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D78EA61253
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 23:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D38DC36AEC;
        Tue, 28 Dec 2021 23:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640734168;
        bh=+W4Oqyxsm7ff3R73yaM0f6Rum7JsCPq38OtMkyiCoKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCWgzBz/bMbVpSoRSJdTIDljXNnGThcVb9xcHOfIJ2qLRZ0fnt5yJvs63w4cff7v7
         K2xqlHan6172tT6brpg9lm/2b0Jgg8Wb31DwJd61ixLhNPnLltlQlgGJem5zZPBckf
         Aq39Fwa+P7KCPyAX4119WCxSNToAuT4GfOnc0v9skE6VcXVFPg3OzeI8uxML/c2DL0
         fxhg3Iy2f/1rSB+u6R9jzxEJg05TlJxCHk8I1Ql1Tx4vNxq8+FEyzbfUcgb2zoZvzg
         2VKHp3zIkYtOpms2mcDpQaP14x8RtzW2DyhMNe7lYA5YPlsqvXnLv2AklQ/L01O22E
         fUuFZr3XeCIJg==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v5 4/5] erofs: support inline data decompression
Date:   Wed, 29 Dec 2021 07:29:19 +0800
Message-Id: <20211228232919.21413-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211228054604.114518-5-hsiangkao@linux.alibaba.com>
References: <20211228054604.114518-5-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, we have already support tail-packing inline for
uncompressed file, let's also implement this for compressed
files to save I/Os and storage space.

Different from normal pclusters, compressed data is available
in advance because of other metadata I/Os. Therefore, they
directly move into the bypass queue without extra I/O submission.

It's the last compression feature before folio/subpage support.

Signed-off-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v4:
 - fix original non-managed handling, found with LZMA
   compression.

 fs/erofs/zdata.c | 139 +++++++++++++++++++++++++++++++++--------------
 fs/erofs/zdata.h |  24 +++++++-
 2 files changed, 119 insertions(+), 44 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bc765d8a6dc2..49da3931b2e3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -82,12 +82,13 @@ static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int nrpages)
 
 static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
 {
+	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pcluster_pool); ++i) {
 		struct z_erofs_pcluster_slab *pcs = pcluster_pool + i;
 
-		if (pcl->pclusterpages > pcs->maxpages)
+		if (pclusterpages > pcs->maxpages)
 			continue;
 
 		kmem_cache_free(pcs->slab, pcl);
@@ -298,6 +299,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 		container_of(grp, struct z_erofs_pcluster, obj);
 	int i;
 
+	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
 	/*
 	 * refcount of workgroup is now freezed as 1,
 	 * therefore no need to worry about available decompression users.
@@ -331,6 +333,7 @@ int erofs_try_to_free_cached_page(struct page *page)
 	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
 		unsigned int i;
 
+		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
 		for (i = 0; i < pcl->pclusterpages; ++i) {
 			if (pcl->compressed_pages[i] == page) {
 				WRITE_ONCE(pcl->compressed_pages[i], NULL);
@@ -458,6 +461,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 				       struct inode *inode,
 				       struct erofs_map_blocks *map)
 {
+	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl;
 	struct z_erofs_collection *cl;
 	struct erofs_workgroup *grp;
@@ -469,12 +473,12 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	}
 
 	/* no available pcluster, let's allocate one */
-	pcl = z_erofs_alloc_pcluster(map->m_plen >> PAGE_SHIFT);
+	pcl = z_erofs_alloc_pcluster(ztailpacking ? 1 :
+				     map->m_plen >> PAGE_SHIFT);
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
 	atomic_set(&pcl->obj.refcount, 1);
-	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
 		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
@@ -494,16 +498,25 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	mutex_init(&cl->lock);
 	DBG_BUGON(!mutex_trylock(&cl->lock));
 
-	grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
-	if (IS_ERR(grp)) {
-		err = PTR_ERR(grp);
-		goto err_out;
-	}
+	if (ztailpacking) {
+		pcl->obj.index = 0;	/* which indicates ztailpacking */
+		pcl->pageofs_in = erofs_blkoff(map->m_pa);
+		pcl->tailpacking_size = map->m_plen;
+	} else {
+		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
 
-	if (grp != &pcl->obj) {
-		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
-		err = -EEXIST;
-		goto err_out;
+		grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
+		if (IS_ERR(grp)) {
+			err = PTR_ERR(grp);
+			goto err_out;
+		}
+
+		if (grp != &pcl->obj) {
+			clt->pcl = container_of(grp,
+					struct z_erofs_pcluster, obj);
+			err = -EEXIST;
+			goto err_out;
+		}
 	}
 	/* used to check tail merging loop due to corrupted images */
 	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
@@ -532,17 +545,20 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
 	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
-	if (!PAGE_ALIGNED(map->m_pa)) {
-		DBG_BUGON(1);
-		return -EINVAL;
+	if (map->m_flags & EROFS_MAP_META) {
+		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+		goto tailpacking;
 	}
 
 	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
 	if (grp) {
 		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
 	} else {
+tailpacking:
 		ret = z_erofs_register_collection(clt, inode, map);
-
 		if (!ret)
 			goto out;
 		if (ret != -EEXIST)
@@ -558,9 +574,9 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 out:
 	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  clt->cl->pagevec, clt->cl->vcnt);
-
 	/* since file-backed online pages are traversed in reverse order */
-	clt->icpage_ptr = clt->pcl->compressed_pages + clt->pcl->pclusterpages;
+	clt->icpage_ptr = clt->pcl->compressed_pages +
+			z_erofs_pclusterpages(clt->pcl);
 	return 0;
 }
 
@@ -681,14 +697,33 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (err)
 		goto err_out;
 
-	/* preload all compressed pages (maybe downgrade role if necessary) */
-	if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy, map->m_la))
-		cache_strategy = TRYALLOC;
-	else
-		cache_strategy = DONTALLOC;
+	if (z_erofs_is_inline_pcluster(clt->pcl)) {
+		struct page *mpage;
 
-	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
-				 cache_strategy, pagepool);
+		mpage = erofs_get_meta_page(inode->i_sb,
+					    erofs_blknr(map->m_pa));
+		if (IS_ERR(mpage)) {
+			err = PTR_ERR(mpage);
+			erofs_err(inode->i_sb,
+				  "failed to get inline page, err %d", err);
+			goto err_out;
+		}
+		/* TODO: new subpage feature will get rid of it */
+		unlock_page(mpage);
+
+		WRITE_ONCE(clt->pcl->compressed_pages[0], mpage);
+		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
+	} else {
+		/* preload all compressed pages (can change mode if needed) */
+		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
+					       map->m_la))
+			cache_strategy = TRYALLOC;
+		else
+			cache_strategy = DONTALLOC;
+
+		preload_compressed_pages(clt, MNGD_MAPPING(sbi),
+					 cache_strategy, pagepool);
+	}
 
 hitted:
 	/*
@@ -844,6 +879,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct page **pagepool)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	struct z_erofs_pagevec_ctor ctor;
 	unsigned int i, inputsize, outputsize, llen, nr_pages;
 	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
@@ -925,15 +961,20 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 	overlapped = false;
 	compressed_pages = pcl->compressed_pages;
 
-	for (i = 0; i < pcl->pclusterpages; ++i) {
+	for (i = 0; i < pclusterpages; ++i) {
 		unsigned int pagenr;
 
 		page = compressed_pages[i];
-
 		/* all compressed pages ought to be valid */
 		DBG_BUGON(!page);
-		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
+		if (z_erofs_is_inline_pcluster(pcl)) {
+			if (!PageUptodate(page))
+				err = -EIO;
+			continue;
+		}
+
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
 		if (!z_erofs_is_shortlived_page(page)) {
 			if (erofs_page_is_managed(sbi, page)) {
 				if (!PageUptodate(page))
@@ -978,11 +1019,16 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		partial = true;
 	}
 
-	inputsize = pcl->pclusterpages * PAGE_SIZE;
+	if (z_erofs_is_inline_pcluster(pcl))
+		inputsize = pcl->tailpacking_size;
+	else
+		inputsize = pclusterpages * PAGE_SIZE;
+
 	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.sb = sb,
 					.in = compressed_pages,
 					.out = pages,
+					.pageofs_in = pcl->pageofs_in,
 					.pageofs_out = cl->pageofs,
 					.inputsize = inputsize,
 					.outputsize = outputsize,
@@ -992,17 +1038,22 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 				 }, pagepool);
 
 out:
-	/* must handle all compressed pages before ending pages */
-	for (i = 0; i < pcl->pclusterpages; ++i) {
-		page = compressed_pages[i];
-
-		if (erofs_page_is_managed(sbi, page))
-			continue;
+	/* must handle all compressed pages before actual file pages */
+	if (z_erofs_is_inline_pcluster(pcl)) {
+		page = compressed_pages[0];
+		WRITE_ONCE(compressed_pages[0], NULL);
+		put_page(page);
+	} else {
+		for (i = 0; i < pclusterpages; ++i) {
+			page = compressed_pages[i];
 
-		/* recycle all individual short-lived pages */
-		(void)z_erofs_put_shortlivedpage(pagepool, page);
+			if (erofs_page_is_managed(sbi, page))
+				continue;
 
-		WRITE_ONCE(compressed_pages[i], NULL);
+			/* recycle all individual short-lived pages */
+			(void)z_erofs_put_shortlivedpage(pagepool, page);
+			WRITE_ONCE(compressed_pages[i], NULL);
+		}
 	}
 
 	for (i = 0; i < nr_pages; ++i) {
@@ -1288,6 +1339,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
 
+		/* close the main owned chain at first */
+		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
+		if (z_erofs_is_inline_pcluster(pcl)) {
+			move_to_bypass_jobqueue(pcl, qtail, owned_head);
+			continue;
+		}
+
 		/* no device id here, thus it will always succeed */
 		mdev = (struct erofs_map_dev) {
 			.m_pa = blknr_to_addr(pcl->obj.index),
@@ -1297,10 +1356,6 @@ static void z_erofs_submit_queue(struct super_block *sb,
 		cur = erofs_blknr(mdev.m_pa);
 		end = cur + pcl->pclusterpages;
 
-		/* close the main owned chain at first */
-		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
-				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
-
 		do {
 			struct page *page;
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 4a69515dea75..e043216b545f 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -62,8 +62,16 @@ struct z_erofs_pcluster {
 	/* A: lower limit of decompressed length and if full length or not */
 	unsigned int length;
 
-	/* I: physical cluster size in pages */
-	unsigned short pclusterpages;
+	/* I: page offset of inline compressed data */
+	unsigned short pageofs_in;
+
+	union {
+		/* I: physical cluster size in pages */
+		unsigned short pclusterpages;
+
+		/* I: tailpacking inline compressed size */
+		unsigned short tailpacking_size;
+	};
 
 	/* I: compression algorithm format */
 	unsigned char algorithmformat;
@@ -94,6 +102,18 @@ struct z_erofs_decompressqueue {
 	} u;
 };
 
+static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
+{
+	return !pcl->obj.index;
+}
+
+static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
+{
+	if (z_erofs_is_inline_pcluster(pcl))
+		return 1;
+	return pcl->pclusterpages;
+}
+
 #define Z_EROFS_ONLINEPAGE_COUNT_BITS   2
 #define Z_EROFS_ONLINEPAGE_COUNT_MASK   ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
 #define Z_EROFS_ONLINEPAGE_INDEX_SHIFT  (Z_EROFS_ONLINEPAGE_COUNT_BITS)
-- 
2.20.1

