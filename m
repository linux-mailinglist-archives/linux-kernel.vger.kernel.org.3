Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71D15AC90B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiIEDU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbiIEDUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:20:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862C71903C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:20:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fa2so7217019pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 20:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=1XsIXzCfYSNzIOIGImGAWV+tb3SyPubQmBiPiBkaZ8w=;
        b=fL+HTU4o9FF6kWlGXP5zzc+Su7OgwNV24fv++3yiaEw0ZjONVHunjE7lZ3bxiWAzIm
         +2sOBeflg8s25jcAxgdKy7tL5rxPeUSx8uK0VHC56/tCH1h1/j5gaaGRXWM2QdVqLaD+
         f+fecuNxkczvsV9u3yniZ8s39kSiG5oBE+VNRYqHi3ZcXzq7rvlpoiehjUKjvLbuzuld
         hV1mTog0ETLjjPeqnaHtvj5H0Y2jptPlGyXwdnMQamoaQY3/ooL96D1LsLYzia7lzVRZ
         0cf0JvrRMo8OP6q5AHW7NMqusvVt2UEc7SGGoY6sQi3sEKNnPK4terCyy826uhtK7dIY
         BoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1XsIXzCfYSNzIOIGImGAWV+tb3SyPubQmBiPiBkaZ8w=;
        b=WjiWKiXupWnYF+HwY1wBoEIvWwCekaH+RelPi41oj4JXcqvtfFPKBa/lrfK/iwlQkc
         BcLrPAsoIbYU3U7Dy7trJWrxiMqhGAc5OjFCeZGAkoiQnOWF3FXyoMxAMPApzy8m5Bqw
         DBm62SrOXybf+MchiXSz6yVA6SOX7c+KPa4fiD32WN9RPK1qrheWfPKUL8e5Lzf/ZzcK
         sEeaJBckWdTYp4knOOb5MqHdEyIDfsfImL2hTaDv1LNcflBq/+O3uV4oDDzHIGXLxpQP
         gr12XUAmLXf54uWXZR6aUw5iqLP7i0+S1Xc7HvCWvQhN0Vt5jTB4B2I+oKqW+uO/P32F
         y7qQ==
X-Gm-Message-State: ACgBeo2BUpPdo5zh/3QLdUv//ytx7WqVtx04jgbJz8R1ZZEX9qkrSl3u
        DDW+uVsWEyN4R1d/tYOVceZJXZnTJIA=
X-Google-Smtp-Source: AA6agR5y83vwrBlpEZ0CWr8hny5Qz72uTm7u7os2hkcASUtX/LnGioJIsBg/ua/q9rZJ2MS7o8lBoQ==
X-Received: by 2002:a17:90a:ac2:b0:1fd:fad1:e506 with SMTP id r2-20020a17090a0ac200b001fdfad1e506mr17466968pje.66.1662348049040;
        Sun, 04 Sep 2022 20:20:49 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090ac98500b001f216407204sm5610265pjt.36.2022.09.04.20.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 20:20:48 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, zbestahu@gmail.com,
        Yue Hu <huyue2@coolpad.com>
Subject: [RFC PATCH v3 1/2] erofs: support interlaced uncompressed data for compressed files
Date:   Mon,  5 Sep 2022 11:20:07 +0800
Message-Id: <3d5e2da044c751afdd4dc8a5b845b18d2e14194b.1662347031.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1662347031.git.huyue2@coolpad.com>
References: <cover.1662347031.git.huyue2@coolpad.com>
In-Reply-To: <cover.1662347031.git.huyue2@coolpad.com>
References: <cover.1662347031.git.huyue2@coolpad.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

Currently, there is no start offset when writing uncompressed data to
disk blocks for compressed files. However, we are using in-place I/O
which will decrease the number of memory copies a lot if we write it
just from an offset of 'pageofs_out'. So, let's support it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/compress.h     |  3 +++
 fs/erofs/decompressor.c | 12 +++++++-----
 fs/erofs/erofs_fs.h     |  2 ++
 fs/erofs/zdata.c        | 12 +++++++++++-
 fs/erofs/zdata.h        |  3 +++
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 26fa170090b8..cef26c63d6b1 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -15,6 +15,9 @@ struct z_erofs_decompress_req {
 	unsigned short pageofs_in, pageofs_out;
 	unsigned int inputsize, outputsize;
 
+	/* cut point of interlaced uncompressed data */
+	unsigned int interlaced_offset;
+
 	/* indicate the algorithm will be used for decompression */
 	unsigned int alg;
 	bool inplace_io, partial_decoding, fillgaps;
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2d55569f96ac..e5dc8eb992b1 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -340,18 +340,20 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 	src = kmap_atomic(*rq->in) + rq->pageofs_in;
 	if (rq->out[0]) {
 		dst = kmap_atomic(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src, righthalf);
+		memcpy(dst + rq->pageofs_out, src + rq->interlaced_offset,
+		       righthalf);
 		kunmap_atomic(dst);
 	}
 
 	if (nrpages_out == 2) {
 		DBG_BUGON(!rq->out[1]);
-		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, lefthalf);
-		} else {
+		if (rq->out[1] != *rq->in) {
 			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, lefthalf);
+			memcpy(dst, rq->interlaced_offset ? src :
+						(src + righthalf), lefthalf);
 			kunmap_atomic(dst);
+		} else if (!rq->interlaced_offset) {
+			memmove(src, src + righthalf, lefthalf);
 		}
 	}
 	kunmap_atomic(src);
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 2b48373f690b..5c1de6d7ad71 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -295,11 +295,13 @@ struct z_erofs_lzma_cfgs {
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
+ * bit 4 : interlaced plain pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
+#define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
 
 struct z_erofs_map_header {
 	__le16	h_reserved1;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5792ca9e0d5e..bbaa3a924852 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -481,6 +481,7 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 
 static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
+	struct erofs_inode *const vi = EROFS_I(fe->inode);
 	struct erofs_map_blocks *map = &fe->map;
 	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl;
@@ -508,6 +509,12 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	pcl->pageofs_out = map->m_la & ~PAGE_MASK;
 	fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 
+	pcl->interlaced = false;
+	if ((vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER) &&
+	    pcl->algorithmformat == Z_EROFS_COMPRESSION_SHIFTED &&
+	    pcl->pageofs_out)
+		pcl->interlaced = true;
+
 	/*
 	 * lock all primary followed works before visible to others
 	 * and mutex_trylock *never* fails for a new pcluster.
@@ -972,7 +979,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	unsigned int i, inputsize;
+	unsigned int i, inputsize, interlaced_offset;
 	int err2;
 	struct page *page;
 	bool overlapped;
@@ -1015,6 +1022,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	else
 		inputsize = pclusterpages * PAGE_SIZE;
 
+	interlaced_offset = pcl->interlaced ? pcl->pageofs_out : 0;
+
 	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
@@ -1023,6 +1032,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.pageofs_out = pcl->pageofs_out,
 					.inputsize = inputsize,
 					.outputsize = pcl->length,
+					.interlaced_offset = interlaced_offset,
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index e7f04c4fbb81..75f3a52fc66f 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -87,6 +87,9 @@ struct z_erofs_pcluster {
 	/* L: indicate several pageofs_outs or not */
 	bool multibases;
 
+	/* I: whether interlaced uncompressed data or not */
+	bool interlaced;
+
 	/* A: compressed bvecs (can be cached or inplaced pages) */
 	struct z_erofs_bvec compressed_bvecs[];
 };
-- 
2.17.1

