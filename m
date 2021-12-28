Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98B0480697
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 06:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhL1FqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 00:46:21 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:61516 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234861AbhL1FqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 00:46:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0240kf_1640670365;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V0240kf_1640670365)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 13:46:15 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     Yue Hu <huyue2@yulong.com>, LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v4 3/5] erofs: support unaligned data decompression
Date:   Tue, 28 Dec 2021 13:46:02 +0800
Message-Id: <20211228054604.114518-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
References: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, compressed data was assumed as block-aligned. This
should be changed due to in-block tail-packing inline data.

Signed-off-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index b8b2a3e34053..789bdc548a1a 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -121,7 +121,7 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 
 static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 			void *inpage, unsigned int *inputmargin, int *maptype,
-			bool support_0padding)
+			bool may_inplace)
 {
 	struct z_erofs_decompress_req *rq = ctx->rq;
 	unsigned int omargin, total, i, j;
@@ -130,7 +130,7 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 
 	if (rq->inplace_io) {
 		omargin = PAGE_ALIGN(ctx->oend) - ctx->oend;
-		if (rq->partial_decoding || !support_0padding ||
+		if (rq->partial_decoding || !may_inplace ||
 		    omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize))
 			goto docopy;
 
@@ -206,15 +206,13 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 				      u8 *out)
 {
 	struct z_erofs_decompress_req *rq = ctx->rq;
+	bool support_0padding = false, may_inplace = false;
 	unsigned int inputmargin;
 	u8 *headpage, *src;
-	bool support_0padding;
 	int ret, maptype;
 
 	DBG_BUGON(*rq->in == NULL);
 	headpage = kmap_atomic(*rq->in);
-	inputmargin = 0;
-	support_0padding = false;
 
 	/* LZ4 decompression inplace is only safe if zero_padding is enabled */
 	if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
@@ -226,11 +224,13 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 			kunmap_atomic(headpage);
 			return ret;
 		}
+		may_inplace = !((rq->pageofs_in + rq->inputsize) &
+				(EROFS_BLKSIZ - 1));
 	}
 
 	inputmargin = rq->pageofs_in;
 	src = z_erofs_lz4_handle_overlap(ctx, headpage, &inputmargin,
-					 &maptype, support_0padding);
+					 &maptype, may_inplace);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
@@ -320,7 +320,8 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const unsigned int righthalf = PAGE_SIZE - rq->pageofs_out;
+	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
+					     PAGE_SIZE - rq->pageofs_out);
 	unsigned char *src, *dst;
 
 	if (nrpages_out > 2) {
@@ -333,7 +334,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 		return 0;
 	}
 
-	src = kmap_atomic(*rq->in);
+	src = kmap_atomic(*rq->in) + rq->pageofs_in;
 	if (rq->out[0]) {
 		dst = kmap_atomic(rq->out[0]);
 		memcpy(dst + rq->pageofs_out, src, righthalf);
-- 
2.24.4

