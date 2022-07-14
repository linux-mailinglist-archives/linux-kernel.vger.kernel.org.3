Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E161D574F01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiGNNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbiGNNVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:21:24 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0A95E32F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:21:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPQf_1657804878;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPQf_1657804878)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:20 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 14/16] erofs: introduce z_erofs_do_decompressed_bvec()
Date:   Thu, 14 Jul 2022 21:20:49 +0800
Message-Id: <20220714132051.46012-15-hsiangkao@linux.alibaba.com>
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

Both out_bvecs and in_bvecs share the common logic for decompressed
buffers. So let's make a helper for this.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 49 ++++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4093d8a4ce93..391755dafecd 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -861,6 +861,26 @@ struct z_erofs_decompress_backend {
 	unsigned int onstack_used;
 };
 
+static int z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
+					struct z_erofs_bvec *bvec)
+{
+	unsigned int pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
+	struct page *oldpage;
+
+	DBG_BUGON(pgnr >= be->pcl->nr_pages);
+	oldpage = be->decompressed_pages[pgnr];
+	be->decompressed_pages[pgnr] = bvec->page;
+
+	/* error out if one pcluster is refenenced multiple times. */
+	if (oldpage) {
+		DBG_BUGON(1);
+		z_erofs_page_mark_eio(oldpage);
+		z_erofs_onlinepage_endio(oldpage);
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
+
 static int z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
 {
 	struct z_erofs_pcluster *pcl = be->pcl;
@@ -871,27 +891,14 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
 	z_erofs_bvec_iter_begin(&biter, &pcl->bvset, Z_EROFS_INLINE_BVECS, 0);
 	for (i = 0; i < pcl->vcnt; ++i) {
 		struct z_erofs_bvec bvec;
-		unsigned int pgnr;
 
 		z_erofs_bvec_dequeue(&biter, &bvec, &old_bvpage);
 
 		if (old_bvpage)
 			z_erofs_put_shortlivedpage(be->pagepool, old_bvpage);
 
-		pgnr = (bvec.offset + pcl->pageofs_out) >> PAGE_SHIFT;
-		DBG_BUGON(pgnr >= pcl->nr_pages);
 		DBG_BUGON(z_erofs_page_is_invalidated(bvec.page));
-		/*
-		 * currently EROFS doesn't support multiref(dedup),
-		 * so here erroring out one multiref page.
-		 */
-		if (be->decompressed_pages[pgnr]) {
-			DBG_BUGON(1);
-			z_erofs_page_mark_eio(be->decompressed_pages[pgnr]);
-			z_erofs_onlinepage_endio(be->decompressed_pages[pgnr]);
-			err = -EFSCORRUPTED;
-		}
-		be->decompressed_pages[pgnr] = bvec.page;
+		err = z_erofs_do_decompressed_bvec(be, &bvec);
 	}
 
 	old_bvpage = z_erofs_bvec_iter_end(&biter);
@@ -911,7 +918,6 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 	for (i = 0; i < pclusterpages; ++i) {
 		struct z_erofs_bvec *bvec = &pcl->compressed_bvecs[i];
 		struct page *page = bvec->page;
-		unsigned int pgnr;
 
 		/* compressed pages ought to be present before decompressing */
 		if (!page) {
@@ -933,18 +939,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 					err = -EIO;
 				continue;
 			}
-
-			pgnr = (bvec->offset + pcl->pageofs_out) >> PAGE_SHIFT;
-			DBG_BUGON(pgnr >= pcl->nr_pages);
-			if (be->decompressed_pages[pgnr]) {
-				DBG_BUGON(1);
-				z_erofs_page_mark_eio(
-						be->decompressed_pages[pgnr]);
-				z_erofs_onlinepage_endio(
-						be->decompressed_pages[pgnr]);
-				err = -EFSCORRUPTED;
-			}
-			be->decompressed_pages[pgnr] = page;
+			err = z_erofs_do_decompressed_bvec(be, bvec);
 			*overlapped = true;
 		}
 	}
-- 
2.24.4

