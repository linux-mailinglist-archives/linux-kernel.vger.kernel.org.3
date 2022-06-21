Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64B955376E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353717AbiFUQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351084AbiFUQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:08:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0606269
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B87ADB8199C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65126C3411C;
        Tue, 21 Jun 2022 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655827678;
        bh=euksLrjk67Wk59tAQKTIr4gaODHLYBXTvJjSpa9Gjck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cg09REsCpaDDL6bA8pUIUBNUUY++opctNPxK0HUhb48j9DVxPtsZAjPMRDnygEp9R
         eoEF5uz3dalY44ol8gWUn2QS+S3QZJugi0/ZLkMywqgpA/oTEnRpFyYVRoDrmA6fzg
         gMt18kE9qMCenviPZrMYfJWklLif/rs+gVZdparEbL2hbIwwfr2HVsAGNcHyS+BwpN
         eb9kajiKbNPtLfAYNRTySNuddvjvT7Tf7jHttLYdnSUa+S3/XynyTHisIdal24ubOJ
         wZG0x83CzyHbnlkKQc/9Pfs9uBy/CqWZxR8Hn7l0yhvoz4NtFO029fYwEtOSlZyx9m
         9j3+W8N/jVxMg==
Date:   Tue, 21 Jun 2022 09:07:56 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: handle decompress only post
 processing in softirq
Message-ID: <YrHs3K/MHSAKzG2s@google.com>
References: <20220620173843.1462198-1-daeho43@gmail.com>
 <20220620173843.1462198-2-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620173843.1462198-2-daeho43@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can we do like this which has no functional change but refactored
some functions?

---
 fs/f2fs/compress.c | 208 ++++++++++++++++++++++++++++-----------------
 fs/f2fs/data.c     |  52 ++++++++----
 fs/f2fs/f2fs.h     |  17 ++--
 3 files changed, 172 insertions(+), 105 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index fa237e5c7173..494ce3634b62 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -729,28 +729,18 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	return ret;
 }
 
-void f2fs_decompress_cluster(struct decompress_io_ctx *dic)
+static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic, bool end_io)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
-	struct f2fs_inode_info *fi = F2FS_I(dic->inode);
 	const struct f2fs_compress_ops *cops =
-			f2fs_cops[fi->i_compress_algorithm];
-	int ret;
+		f2fs_cops[F2FS_I(dic->inode)->i_compress_algorithm];
 	int i;
 
-	trace_f2fs_decompress_pages_start(dic->inode, dic->cluster_idx,
-				dic->cluster_size, fi->i_compress_algorithm);
-
-	if (dic->failed) {
-		ret = -EIO;
-		goto out_end_io;
-	}
+	if (!(end_io ^ f2fs_low_mem_mode(F2FS_I_SB(dic->inode))))
+		return 0;
 
 	dic->tpages = page_array_alloc(dic->inode, dic->cluster_size);
-	if (!dic->tpages) {
-		ret = -ENOMEM;
-		goto out_end_io;
-	}
+	if (!dic->tpages)
+		return 1;
 
 	for (i = 0; i < dic->cluster_size; i++) {
 		if (dic->rpages[i]) {
@@ -759,28 +749,100 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic)
 		}
 
 		dic->tpages[i] = f2fs_compress_alloc_page();
-		if (!dic->tpages[i]) {
-			ret = -ENOMEM;
-			goto out_end_io;
-		}
+		if (!dic->tpages[i])
+			return 1;
 	}
 
+	dic->rbuf = f2fs_vmap(dic->tpages, dic->cluster_size);
+	if (!dic->rbuf)
+		return 1;
+
+	dic->cbuf = f2fs_vmap(dic->cpages, dic->nr_cpages);
+	if (!dic->cbuf)
+		return 1;
+
+	cops = f2fs_cops[F2FS_I(dic->inode)->i_compress_algorithm];
 	if (cops->init_decompress_ctx) {
-		ret = cops->init_decompress_ctx(dic);
+		int ret = cops->init_decompress_ctx(dic);
+
 		if (ret)
-			goto out_end_io;
+			return 1;
 	}
 
-	dic->rbuf = f2fs_vmap(dic->tpages, dic->cluster_size);
-	if (!dic->rbuf) {
-		ret = -ENOMEM;
-		goto out_destroy_decompress_ctx;
+	return 0;
+}
+
+static void f2fs_release_decomp_mem(struct decompress_io_ctx *dic,
+		bool bypass_destroy_callback, bool end_io)
+{
+	const struct f2fs_compress_ops *cops =
+		f2fs_cops[F2FS_I(dic->inode)->i_compress_algorithm];
+
+	if (end_io ^ f2fs_low_mem_mode(F2FS_I_SB(dic->inode)))
+		return;
+
+	if (!bypass_destroy_callback && cops->destroy_decompress_ctx)
+		cops->destroy_decompress_ctx(dic);
+
+	if (dic->cbuf)
+		vm_unmap_ram(dic->cbuf, dic->nr_cpages);
+
+	if (dic->rbuf)
+		vm_unmap_ram(dic->rbuf, dic->cluster_size);
+}
+
+static void f2fs_free_dic(struct decompress_io_ctx *dic,
+		bool bypass_destroy_callback)
+{
+	int i;
+
+	f2fs_release_decomp_mem(dic, bypass_destroy_callback, false);
+
+	if (dic->tpages) {
+		for (i = 0; i < dic->cluster_size; i++) {
+			if (dic->rpages[i])
+				continue;
+			if (!dic->tpages[i])
+				continue;
+			f2fs_compress_free_page(dic->tpages[i]);
+		}
+		page_array_free(dic->inode, dic->tpages, dic->cluster_size);
 	}
 
-	dic->cbuf = f2fs_vmap(dic->cpages, dic->nr_cpages);
-	if (!dic->cbuf) {
+	if (dic->cpages) {
+		for (i = 0; i < dic->nr_cpages; i++) {
+			if (!dic->cpages[i])
+				continue;
+			f2fs_compress_free_page(dic->cpages[i]);
+		}
+		page_array_free(dic->inode, dic->cpages, dic->nr_cpages);
+	}
+
+	page_array_free(dic->inode, dic->rpages, dic->nr_rpages);
+	kmem_cache_free(dic_entry_slab, dic);
+}
+
+void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
+	struct f2fs_inode_info *fi = F2FS_I(dic->inode);
+	const struct f2fs_compress_ops *cops =
+			f2fs_cops[fi->i_compress_algorithm];
+	bool bypass_callback = false;
+	int ret;
+
+	trace_f2fs_decompress_pages_start(dic->inode, dic->cluster_idx,
+				dic->cluster_size, fi->i_compress_algorithm);
+
+	if (dic->failed) {
+		ret = -EIO;
+		goto out_end_io;
+	}
+
+	if (f2fs_prepare_decomp_mem(dic, true)) {
+		bypass_callback = true;
 		ret = -ENOMEM;
-		goto out_vunmap_rbuf;
+		goto out_release;
 	}
 
 	dic->clen = le32_to_cpu(dic->cbuf->clen);
@@ -788,7 +850,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic)
 
 	if (dic->clen > PAGE_SIZE * dic->nr_cpages - COMPRESS_HEADER_SIZE) {
 		ret = -EFSCORRUPTED;
-		goto out_vunmap_cbuf;
+		goto out_release;
 	}
 
 	ret = cops->decompress_pages(dic);
@@ -809,17 +871,13 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic)
 		}
 	}
 
-out_vunmap_cbuf:
-	vm_unmap_ram(dic->cbuf, dic->nr_cpages);
-out_vunmap_rbuf:
-	vm_unmap_ram(dic->rbuf, dic->cluster_size);
-out_destroy_decompress_ctx:
-	if (cops->destroy_decompress_ctx)
-		cops->destroy_decompress_ctx(dic);
+out_release:
+	f2fs_release_decomp_mem(dic, bypass_callback, true);
+
 out_end_io:
 	trace_f2fs_decompress_pages_end(dic->inode, dic->cluster_idx,
 							dic->clen, ret);
-	f2fs_decompress_end_io(dic, ret);
+	f2fs_decompress_end_io(dic, ret, in_task);
 }
 
 /*
@@ -829,7 +887,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic)
  * (or in the case of a failure, cleans up without actually decompressing).
  */
 void f2fs_end_read_compressed_page(struct page *page, bool failed,
-						block_t blkaddr)
+		block_t blkaddr, bool in_task)
 {
 	struct decompress_io_ctx *dic =
 			(struct decompress_io_ctx *)page_private(page);
@@ -839,12 +897,12 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
 
 	if (failed)
 		WRITE_ONCE(dic->failed, true);
-	else if (blkaddr)
+	else if (blkaddr && in_task)
 		f2fs_cache_compressed_page(sbi, page,
 					dic->inode->i_ino, blkaddr);
 
 	if (atomic_dec_and_test(&dic->remaining_pages))
-		f2fs_decompress_cluster(dic);
+		f2fs_decompress_cluster(dic, in_task);
 }
 
 static bool is_page_in_cluster(struct compress_ctx *cc, pgoff_t index)
@@ -1552,16 +1610,14 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 	return err;
 }
 
-static void f2fs_free_dic(struct decompress_io_ctx *dic);
-
 struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 {
 	struct decompress_io_ctx *dic;
 	pgoff_t start_idx = start_idx_of_cluster(cc);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	int i;
 
-	dic = f2fs_kmem_cache_alloc(dic_entry_slab, GFP_F2FS_ZERO,
-					false, F2FS_I_SB(cc->inode));
+	dic = f2fs_kmem_cache_alloc(dic_entry_slab, GFP_F2FS_ZERO, false, sbi);
 	if (!dic)
 		return ERR_PTR(-ENOMEM);
 
@@ -1602,52 +1658,43 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 		dic->cpages[i] = page;
 	}
 
+	if (f2fs_prepare_decomp_mem(dic, false))
+		goto out_free;
+
 	return dic;
 
 out_free:
-	f2fs_free_dic(dic);
+	f2fs_free_dic(dic, true);
 	return ERR_PTR(-ENOMEM);
 }
 
-static void f2fs_free_dic(struct decompress_io_ctx *dic)
+static void f2fs_late_free_dic(struct work_struct *work)
 {
-	int i;
-
-	if (dic->tpages) {
-		for (i = 0; i < dic->cluster_size; i++) {
-			if (dic->rpages[i])
-				continue;
-			if (!dic->tpages[i])
-				continue;
-			f2fs_compress_free_page(dic->tpages[i]);
-		}
-		page_array_free(dic->inode, dic->tpages, dic->cluster_size);
-	}
-
-	if (dic->cpages) {
-		for (i = 0; i < dic->nr_cpages; i++) {
-			if (!dic->cpages[i])
-				continue;
-			f2fs_compress_free_page(dic->cpages[i]);
-		}
-		page_array_free(dic->inode, dic->cpages, dic->nr_cpages);
-	}
+	struct decompress_io_ctx *dic =
+		container_of(work, struct decompress_io_ctx, free_work);
 
-	page_array_free(dic->inode, dic->rpages, dic->nr_rpages);
-	kmem_cache_free(dic_entry_slab, dic);
+	f2fs_free_dic(dic, false);
 }
 
-static void f2fs_put_dic(struct decompress_io_ctx *dic)
+static void f2fs_put_dic(struct decompress_io_ctx *dic, bool in_task)
 {
-	if (refcount_dec_and_test(&dic->refcnt))
-		f2fs_free_dic(dic);
+	if (refcount_dec_and_test(&dic->refcnt)) {
+		if (in_task) {
+			f2fs_free_dic(dic, false);
+		} else {
+			INIT_WORK(&dic->free_work, f2fs_late_free_dic);
+			queue_work(F2FS_I_SB(dic->inode)->post_read_wq,
+					&dic->free_work);
+		}
+	}
 }
 
 /*
  * Update and unlock the cluster's pagecache pages, and release the reference to
  * the decompress_io_ctx that was being held for I/O completion.
  */
-static void __f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed)
+static void __f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
+				bool in_task)
 {
 	int i;
 
@@ -1668,7 +1715,7 @@ static void __f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed)
 		unlock_page(rpage);
 	}
 
-	f2fs_put_dic(dic);
+	f2fs_put_dic(dic, in_task);
 }
 
 static void f2fs_verify_cluster(struct work_struct *work)
@@ -1685,14 +1732,15 @@ static void f2fs_verify_cluster(struct work_struct *work)
 			SetPageError(rpage);
 	}
 
-	__f2fs_decompress_end_io(dic, false);
+	__f2fs_decompress_end_io(dic, false, true);
 }
 
 /*
  * This is called when a compressed cluster has been decompressed
  * (or failed to be read and/or decompressed).
  */
-void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed)
+void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
+				bool in_task)
 {
 	if (!failed && dic->need_verity) {
 		/*
@@ -1704,7 +1752,7 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed)
 		INIT_WORK(&dic->verity_work, f2fs_verify_cluster);
 		fsverity_enqueue_verify_work(&dic->verity_work);
 	} else {
-		__f2fs_decompress_end_io(dic, failed);
+		__f2fs_decompress_end_io(dic, failed, in_task);
 	}
 }
 
@@ -1713,12 +1761,12 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed)
  *
  * This is called when the page is no longer needed and can be freed.
  */
-void f2fs_put_page_dic(struct page *page)
+void f2fs_put_page_dic(struct page *page, bool in_task)
 {
 	struct decompress_io_ctx *dic =
 			(struct decompress_io_ctx *)page_private(page);
 
-	f2fs_put_dic(dic);
+	f2fs_put_dic(dic, in_task);
 }
 
 /*
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7fcbcf979737..c448c3ee7ac3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -119,7 +119,7 @@ struct bio_post_read_ctx {
 	block_t fs_blkaddr;
 };
 
-static void f2fs_finish_read_bio(struct bio *bio)
+static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 {
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
@@ -133,8 +133,9 @@ static void f2fs_finish_read_bio(struct bio *bio)
 
 		if (f2fs_is_compressed_page(page)) {
 			if (bio->bi_status)
-				f2fs_end_read_compressed_page(page, true, 0);
-			f2fs_put_page_dic(page);
+				f2fs_end_read_compressed_page(page, true, 0,
+							in_task);
+			f2fs_put_page_dic(page, in_task);
 			continue;
 		}
 
@@ -191,7 +192,7 @@ static void f2fs_verify_bio(struct work_struct *work)
 		fsverity_verify_bio(bio);
 	}
 
-	f2fs_finish_read_bio(bio);
+	f2fs_finish_read_bio(bio, true);
 }
 
 /*
@@ -203,7 +204,7 @@ static void f2fs_verify_bio(struct work_struct *work)
  * can involve reading verity metadata pages from the file, and these verity
  * metadata pages may be encrypted and/or compressed.
  */
-static void f2fs_verify_and_finish_bio(struct bio *bio)
+static void f2fs_verify_and_finish_bio(struct bio *bio, bool in_task)
 {
 	struct bio_post_read_ctx *ctx = bio->bi_private;
 
@@ -211,7 +212,7 @@ static void f2fs_verify_and_finish_bio(struct bio *bio)
 		INIT_WORK(&ctx->work, f2fs_verify_bio);
 		fsverity_enqueue_verify_work(&ctx->work);
 	} else {
-		f2fs_finish_read_bio(bio);
+		f2fs_finish_read_bio(bio, in_task);
 	}
 }
 
@@ -224,7 +225,8 @@ static void f2fs_verify_and_finish_bio(struct bio *bio)
  * that the bio includes at least one compressed page.  The actual decompression
  * is done on a per-cluster basis, not a per-bio basis.
  */
-static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx)
+static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx,
+		bool in_task)
 {
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
@@ -237,7 +239,7 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx)
 		/* PG_error was set if decryption failed. */
 		if (f2fs_is_compressed_page(page))
 			f2fs_end_read_compressed_page(page, PageError(page),
-						blkaddr);
+						blkaddr, in_task);
 		else
 			all_compressed = false;
 
@@ -262,15 +264,16 @@ static void f2fs_post_read_work(struct work_struct *work)
 		fscrypt_decrypt_bio(ctx->bio);
 
 	if (ctx->enabled_steps & STEP_DECOMPRESS)
-		f2fs_handle_step_decompress(ctx);
+		f2fs_handle_step_decompress(ctx, true);
 
-	f2fs_verify_and_finish_bio(ctx->bio);
+	f2fs_verify_and_finish_bio(ctx->bio, true);
 }
 
 static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(bio_first_page_all(bio));
 	struct bio_post_read_ctx *ctx;
+	bool intask = in_task();
 
 	iostat_update_and_unbind_ctx(bio, 0);
 	ctx = bio->bi_private;
@@ -281,16 +284,29 @@ static void f2fs_read_end_io(struct bio *bio)
 	}
 
 	if (bio->bi_status) {
-		f2fs_finish_read_bio(bio);
+		f2fs_finish_read_bio(bio, intask);
 		return;
 	}
 
-	if (ctx && (ctx->enabled_steps & (STEP_DECRYPT | STEP_DECOMPRESS))) {
-		INIT_WORK(&ctx->work, f2fs_post_read_work);
-		queue_work(ctx->sbi->post_read_wq, &ctx->work);
-	} else {
-		f2fs_verify_and_finish_bio(bio);
+	if (ctx) {
+		unsigned int enabled_steps = ctx->enabled_steps &
+					(STEP_DECRYPT | STEP_DECOMPRESS);
+
+		/*
+		 * If we have only decompression step between decompression and
+		 * decrypt, we don't need post processing for this.
+		 */
+		if (enabled_steps == STEP_DECOMPRESS &&
+				!f2fs_low_mem_mode(sbi)) {
+			f2fs_handle_step_decompress(ctx, intask);
+		} else if (enabled_steps) {
+			INIT_WORK(&ctx->work, f2fs_post_read_work);
+			queue_work(ctx->sbi->post_read_wq, &ctx->work);
+			return;
+		}
 	}
+
+	f2fs_verify_and_finish_bio(bio, intask);
 }
 
 static void f2fs_write_end_io(struct bio *bio)
@@ -2222,7 +2238,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
 			if (atomic_dec_and_test(&dic->remaining_pages))
-				f2fs_decompress_cluster(dic);
+				f2fs_decompress_cluster(dic, true);
 			continue;
 		}
 
@@ -2240,7 +2256,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 					page->index, for_write);
 			if (IS_ERR(bio)) {
 				ret = PTR_ERR(bio);
-				f2fs_decompress_end_io(dic, ret);
+				f2fs_decompress_end_io(dic, ret, true);
 				f2fs_put_dnode(&dn);
 				*bio_ret = NULL;
 				return ret;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fea97093d927..c9a31934b948 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1588,6 +1588,7 @@ struct decompress_io_ctx {
 	void *private;			/* payload buffer for specified decompression algorithm */
 	void *private2;			/* extra payload buffer */
 	struct work_struct verity_work;	/* work to verify the decompressed pages */
+	struct work_struct free_work;	/* work for late free this structure itself */
 };
 
 #define NULL_CLUSTER			((unsigned int)(~0))
@@ -4166,9 +4167,9 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
 bool f2fs_is_compress_backend_ready(struct inode *inode);
 int f2fs_init_compress_mempool(void);
 void f2fs_destroy_compress_mempool(void);
-void f2fs_decompress_cluster(struct decompress_io_ctx *dic);
+void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task);
 void f2fs_end_read_compressed_page(struct page *page, bool failed,
-							block_t blkaddr);
+				block_t blkaddr, bool in_task);
 bool f2fs_cluster_is_empty(struct compress_ctx *cc);
 bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
 bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
@@ -4187,8 +4188,9 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 				unsigned nr_pages, sector_t *last_block_in_bio,
 				bool is_readahead, bool for_write);
 struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
-void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed);
-void f2fs_put_page_dic(struct page *page);
+void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
+				bool in_task);
+void f2fs_put_page_dic(struct page *page, bool in_task);
 unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn);
 int f2fs_init_compress_ctx(struct compress_ctx *cc);
 void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse);
@@ -4234,13 +4236,14 @@ static inline struct page *f2fs_compress_control_page(struct page *page)
 }
 static inline int f2fs_init_compress_mempool(void) { return 0; }
 static inline void f2fs_destroy_compress_mempool(void) { }
-static inline void f2fs_decompress_cluster(struct decompress_io_ctx *dic) { }
+static inline void f2fs_decompress_cluster(struct decompress_io_ctx *dic,
+				bool in_task) { }
 static inline void f2fs_end_read_compressed_page(struct page *page,
-						bool failed, block_t blkaddr)
+				bool failed, block_t blkaddr, bool in_task)
 {
 	WARN_ON_ONCE(1);
 }
-static inline void f2fs_put_page_dic(struct page *page)
+static inline void f2fs_put_page_dic(struct page *page, bool in_task)
 {
 	WARN_ON_ONCE(1);
 }
-- 
2.37.0.rc0.104.g0611611a94-goog

