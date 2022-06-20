Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3A5522CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbiFTRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243005AbiFTRiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:38:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAB89FF6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:38:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cv13so8129445pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9D/lAkOuBFw6zW0V5YMmBuLImut+YhLFpoU4rmqoJFs=;
        b=WPIAhIOz39T9UYPiSBlN/zmxZO0UuE6ekeTFGiYAiIDJX3RwvfzruYvFzHjuVwbk3T
         tiGDOOgeKOy6Bhv6hswl756A4nB1weYKzpvv0asPn2clSXvKKZDWX4IvBnOxBZCeJ5tM
         LobLPScYAp7QAa+CmTCx6lUZ2spVAEXEbhOm2EoFrNnyVxSE8NQJryEdXGqSXYj7DMii
         2BmZx4qr1ffOAUQplXPW+Z6THR75B3pFqE+n3lVffwJyQTnFq/x2+ep9BN0yU/ptHcy0
         LLXZxcllB6sDPsNmapzI5zoEwLBMzmkT5/VZ6tfWTr2IfFnm6Owmgrq29N+sqH5Fn7Gv
         xIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9D/lAkOuBFw6zW0V5YMmBuLImut+YhLFpoU4rmqoJFs=;
        b=MtwjikV3/3RQWDHOK6KBXVZm9OeZyc9UHDDSuUCOz1J7sKv9m+PCmjCY1QWKuiiuqE
         8P9I8Aq5eiWNeqqbapqgicwKveuNNtDDs5+jMdTkje6q1VjWwHhI1wzoImiVGQ/cdN4Z
         9nuABVu+LetxpttPCoEcElmujdQvVq+eiJR8pHepzMWgfMt2lemQBGGROPmDG+k4A9Mo
         2YuTjzB5aQG+KZdW0zbPUmTQJG7K0xqkcr05F6nx/MVqcQYvrTqw0jl0aECLFhAD5cKk
         1scA7tpsRfmPaYvq0Oa+yzUuum78N1qc/c1tB/Fxd+vMe1zghsxJaFUDmQk9j4mWWPRT
         mUtw==
X-Gm-Message-State: AJIora9TlS7Ao3apOPd6iMKdw+Da3mVWXBXOMnpNAATDku0+XiM6Qlq4
        QAdN+/ZPJXOtz/uO0MKoko3tuvH4/1s=
X-Google-Smtp-Source: AGRyM1uFc4U1iWjFryFepsU/XmJxxDyUM8zOcLxDpdElqQ5WQkiRoc/rZorD+JxUd7Qn2LEAp0wgEQ==
X-Received: by 2002:a17:90b:240e:b0:1e0:775b:f8fc with SMTP id nr14-20020a17090b240e00b001e0775bf8fcmr28147184pjb.132.1655746728546;
        Mon, 20 Jun 2022 10:38:48 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:1db8:e686:ccbc:a11b])
        by smtp.gmail.com with ESMTPSA id f185-20020a62dbc2000000b0051868677e6dsm373268pfg.51.2022.06.20.10.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:38:48 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/2] f2fs: handle decompress only post processing in softirq
Date:   Mon, 20 Jun 2022 10:38:43 -0700
Message-Id: <20220620173843.1462198-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220620173843.1462198-1-daeho43@gmail.com>
References: <20220620173843.1462198-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Now decompression is being handled in workqueue and it makes read I/O
latency non-deterministic, because of the non-deterministic scheduling
nature of workqueues. So, I made it handled in softirq context only if
possible, not in low memory devices, since this modification will
maintain decompresion related memory a little longer.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v1: fixed build errors reported by kernel test robot <lkp@intel.com>
---
 fs/f2fs/compress.c | 180 +++++++++++++++++++++++++++++----------------
 fs/f2fs/data.c     |  52 ++++++++-----
 fs/f2fs/f2fs.h     |  17 +++--
 3 files changed, 162 insertions(+), 87 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 24824cd96f36..ddd47ad464d9 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -729,14 +729,18 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	return ret;
 }
 
-void f2fs_decompress_cluster(struct decompress_io_ctx *dic)
+static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic);
+static void f2fs_release_decomp_mem(struct decompress_io_ctx *dic,
+		bool bypass_destroy_callback);
+
+void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
 	struct f2fs_inode_info *fi = F2FS_I(dic->inode);
 	const struct f2fs_compress_ops *cops =
 			f2fs_cops[fi->i_compress_algorithm];
+	bool bypass_callback = false;
 	int ret;
-	int i;
 
 	trace_f2fs_decompress_pages_start(dic->inode, dic->cluster_idx,
 				dic->cluster_size, fi->i_compress_algorithm);
@@ -746,49 +750,20 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic)
 		goto out_end_io;
 	}
 
-	dic->tpages = page_array_alloc(dic->inode, dic->cluster_size);
-	if (!dic->tpages) {
-		ret = -ENOMEM;
-		goto out_end_io;
-	}
-
-	for (i = 0; i < dic->cluster_size; i++) {
-		if (dic->rpages[i]) {
-			dic->tpages[i] = dic->rpages[i];
-			continue;
-		}
-
-		dic->tpages[i] = f2fs_compress_alloc_page();
-		if (!dic->tpages[i]) {
+	if (f2fs_low_mem_mode(sbi)) {
+		if (f2fs_prepare_decomp_mem(dic)) {
+			bypass_callback = true;
 			ret = -ENOMEM;
-			goto out_end_io;
+			goto out_release;
 		}
 	}
 
-	if (cops->init_decompress_ctx) {
-		ret = cops->init_decompress_ctx(dic);
-		if (ret)
-			goto out_end_io;
-	}
-
-	dic->rbuf = f2fs_vmap(dic->tpages, dic->cluster_size);
-	if (!dic->rbuf) {
-		ret = -ENOMEM;
-		goto out_destroy_decompress_ctx;
-	}
-
-	dic->cbuf = f2fs_vmap(dic->cpages, dic->nr_cpages);
-	if (!dic->cbuf) {
-		ret = -ENOMEM;
-		goto out_vunmap_rbuf;
-	}
-
 	dic->clen = le32_to_cpu(dic->cbuf->clen);
 	dic->rlen = PAGE_SIZE << dic->log_cluster_size;
 
 	if (dic->clen > PAGE_SIZE * dic->nr_cpages - COMPRESS_HEADER_SIZE) {
 		ret = -EFSCORRUPTED;
-		goto out_vunmap_cbuf;
+		goto out_release;
 	}
 
 	ret = cops->decompress_pages(dic);
@@ -809,17 +784,14 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic)
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
+	if (f2fs_low_mem_mode(sbi))
+		f2fs_release_decomp_mem(dic, bypass_callback);
+
 out_end_io:
 	trace_f2fs_decompress_pages_end(dic->inode, dic->cluster_idx,
 							dic->clen, ret);
-	f2fs_decompress_end_io(dic, ret);
+	f2fs_decompress_end_io(dic, ret, in_task);
 }
 
 /*
@@ -829,7 +801,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic)
  * (or in the case of a failure, cleans up without actually decompressing).
  */
 void f2fs_end_read_compressed_page(struct page *page, bool failed,
-						block_t blkaddr)
+		block_t blkaddr, bool in_task)
 {
 	struct decompress_io_ctx *dic =
 			(struct decompress_io_ctx *)page_private(page);
@@ -839,12 +811,12 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
 
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
@@ -1552,16 +1524,73 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 	return err;
 }
 
-static void f2fs_free_dic(struct decompress_io_ctx *dic);
+static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic)
+{
+	const struct f2fs_compress_ops *cops =
+		f2fs_cops[F2FS_I(dic->inode)->i_compress_algorithm];
+	int i;
+
+	dic->tpages = page_array_alloc(dic->inode, dic->cluster_size);
+	if (!dic->tpages)
+		return 1;
+
+	for (i = 0; i < dic->cluster_size; i++) {
+		if (dic->rpages[i]) {
+			dic->tpages[i] = dic->rpages[i];
+			continue;
+		}
+
+		dic->tpages[i] = f2fs_compress_alloc_page();
+		if (!dic->tpages[i])
+			return 1;
+	}
+
+	dic->rbuf = f2fs_vmap(dic->tpages, dic->cluster_size);
+	if (!dic->rbuf)
+		return 1;
+
+	dic->cbuf = f2fs_vmap(dic->cpages, dic->nr_cpages);
+	if (!dic->cbuf)
+		return 1;
+
+	cops = f2fs_cops[F2FS_I(dic->inode)->i_compress_algorithm];
+	if (cops->init_decompress_ctx) {
+		int ret = cops->init_decompress_ctx(dic);
+
+		if (ret)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void f2fs_release_decomp_mem(struct decompress_io_ctx *dic,
+		bool bypass_destroy_callback)
+{
+	const struct f2fs_compress_ops *cops =
+		f2fs_cops[F2FS_I(dic->inode)->i_compress_algorithm];
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
+		bool bypass_destroy_callback);
 
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
 
@@ -1602,17 +1631,27 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 		dic->cpages[i] = page;
 	}
 
+	if (!f2fs_low_mem_mode(sbi)) {
+		if (f2fs_prepare_decomp_mem(dic))
+			goto out_free;
+	}
+
 	return dic;
 
 out_free:
-	f2fs_free_dic(dic);
+	f2fs_free_dic(dic, true);
 	return ERR_PTR(-ENOMEM);
 }
 
-static void f2fs_free_dic(struct decompress_io_ctx *dic)
+static void f2fs_free_dic(struct decompress_io_ctx *dic,
+		bool bypass_destroy_callback)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
 	int i;
 
+	if (!f2fs_low_mem_mode(sbi))
+		f2fs_release_decomp_mem(dic, bypass_destroy_callback);
+
 	if (dic->tpages) {
 		for (i = 0; i < dic->cluster_size; i++) {
 			if (dic->rpages[i])
@@ -1637,17 +1676,33 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic)
 	kmem_cache_free(dic_entry_slab, dic);
 }
 
-static void f2fs_put_dic(struct decompress_io_ctx *dic)
+static void f2fs_late_free_dic(struct work_struct *work)
+{
+	struct decompress_io_ctx *dic =
+		container_of(work, struct decompress_io_ctx, free_work);
+
+	f2fs_free_dic(dic, false);
+}
+
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
 
@@ -1668,7 +1723,7 @@ static void __f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed)
 		unlock_page(rpage);
 	}
 
-	f2fs_put_dic(dic);
+	f2fs_put_dic(dic, in_task);
 }
 
 static void f2fs_verify_cluster(struct work_struct *work)
@@ -1685,14 +1740,15 @@ static void f2fs_verify_cluster(struct work_struct *work)
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
@@ -1704,7 +1760,7 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed)
 		INIT_WORK(&dic->verity_work, f2fs_verify_cluster);
 		fsverity_enqueue_verify_work(&dic->verity_work);
 	} else {
-		__f2fs_decompress_end_io(dic, failed);
+		__f2fs_decompress_end_io(dic, failed, in_task);
 	}
 }
 
@@ -1713,12 +1769,12 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed)
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

