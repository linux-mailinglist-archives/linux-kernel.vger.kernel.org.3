Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE58480696
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 06:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhL1FqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 00:46:19 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59614 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234859AbhL1FqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 00:46:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0240kf_1640670365;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V0240kf_1640670365)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 13:46:14 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     Yue Hu <huyue2@yulong.com>, LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v4 2/5] erofs: introduce z_erofs_fixup_insize
Date:   Tue, 28 Dec 2021 13:46:01 +0800
Message-Id: <20211228054604.114518-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
References: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for the upcoming ztailpacking feature, introduce
z_erofs_fixup_insize() and pageofs_in to wrap up the process
to get the exact compressed size via zero padding.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h          |  4 +++-
 fs/erofs/decompressor.c      | 34 +++++++++++++++++++++++++---------
 fs/erofs/decompressor_lzma.c | 19 ++++++++-----------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 579406504919..19e6c56a9f47 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -12,7 +12,7 @@ struct z_erofs_decompress_req {
 	struct super_block *sb;
 	struct page **in, **out;
 
-	unsigned short pageofs_out;
+	unsigned short pageofs_in, pageofs_out;
 	unsigned int inputsize, outputsize;
 
 	/* indicate the algorithm will be used for decompression */
@@ -87,6 +87,8 @@ static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
 	return page->mapping == MNGD_MAPPING(sbi);
 }
 
+int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
+			 unsigned int padbufsize);
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct page **pagepool);
 
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1d137fd42306..b8b2a3e34053 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -184,6 +184,24 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 	return src;
 }
 
+/*
+ * Get the exact inputsize with zero_padding feature.
+ *  - For LZ4, it should work if zero_padding feature is on (5.3+);
+ *  - For MicroLZMA, it'd be enabled all the time.
+ */
+int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
+			 unsigned int padbufsize)
+{
+	const char *padend;
+
+	padend = memchr_inv(padbuf, 0, padbufsize);
+	if (!padend)
+		return -EFSCORRUPTED;
+	rq->inputsize -= padend - padbuf;
+	rq->pageofs_in += padend - padbuf;
+	return 0;
+}
+
 static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 				      u8 *out)
 {
@@ -198,21 +216,19 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	inputmargin = 0;
 	support_0padding = false;
 
-	/* decompression inplace is only safe when zero_padding is enabled */
+	/* LZ4 decompression inplace is only safe if zero_padding is enabled */
 	if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
 		support_0padding = true;
-
-		while (!headpage[inputmargin & ~PAGE_MASK])
-			if (!(++inputmargin & ~PAGE_MASK))
-				break;
-
-		if (inputmargin >= rq->inputsize) {
+		ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
+				min_t(unsigned int, rq->inputsize,
+				      EROFS_BLKSIZ - rq->pageofs_in));
+		if (ret) {
 			kunmap_atomic(headpage);
-			return -EIO;
+			return ret;
 		}
 	}
 
-	rq->inputsize -= inputmargin;
+	inputmargin = rq->pageofs_in;
 	src = z_erofs_lz4_handle_overlap(ctx, headpage, &inputmargin,
 					 &maptype, support_0padding);
 	if (IS_ERR(src))
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 50045510a1f4..05a3063cf2bc 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -156,7 +156,7 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
 	const unsigned int nrpages_in =
 		PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
-	unsigned int inputmargin, inlen, outlen, pageofs;
+	unsigned int inlen, outlen, pageofs;
 	struct z_erofs_lzma *strm;
 	u8 *kin;
 	bool bounced = false;
@@ -164,16 +164,13 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 
 	/* 1. get the exact LZMA compressed size */
 	kin = kmap(*rq->in);
-	inputmargin = 0;
-	while (!kin[inputmargin & ~PAGE_MASK])
-		if (!(++inputmargin & ~PAGE_MASK))
-			break;
-
-	if (inputmargin >= PAGE_SIZE) {
+	err = z_erofs_fixup_insize(rq, kin + rq->pageofs_in,
+				   min_t(unsigned int, rq->inputsize,
+					 EROFS_BLKSIZ - rq->pageofs_in));
+	if (err) {
 		kunmap(*rq->in);
-		return -EFSCORRUPTED;
+		return err;
 	}
-	rq->inputsize -= inputmargin;
 
 	/* 2. get an available lzma context */
 again:
@@ -193,9 +190,9 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	xz_dec_microlzma_reset(strm->state, inlen, outlen,
 			       !rq->partial_decoding);
 	pageofs = rq->pageofs_out;
-	strm->buf.in = kin + inputmargin;
+	strm->buf.in = kin + rq->pageofs_in;
 	strm->buf.in_pos = 0;
-	strm->buf.in_size = min_t(u32, inlen, PAGE_SIZE - inputmargin);
+	strm->buf.in_size = min_t(u32, inlen, PAGE_SIZE - rq->pageofs_in);
 	inlen -= strm->buf.in_size;
 	strm->buf.out = NULL;
 	strm->buf.out_pos = 0;
-- 
2.24.4

