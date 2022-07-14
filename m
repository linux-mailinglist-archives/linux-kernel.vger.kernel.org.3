Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EA0574EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiGNNVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbiGNNVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:21:12 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1853A5D0C0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:21:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPIs_1657804866;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPIs_1657804866)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:07 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 06/16] erofs: introduce `z_erofs_parse_in_bvecs'
Date:   Thu, 14 Jul 2022 21:20:41 +0800
Message-Id: <20220714132051.46012-7-hsiangkao@linux.alibaba.com>
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

`z_erofs_decompress_pcluster()' is too long therefore it'd be better
to introduce another helper to parse compressed pages (or laterly,
compressed bvecs.)

BTW, since `compressed_bvecs' is too long as a part of the function
name, `in_bvecs' is used here instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 132 ++++++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 52 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e96704db106e..757d352bc2c7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -913,6 +913,76 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
 	return err;
 }
 
+static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
+			struct z_erofs_pcluster *pcl, struct page **pages,
+			struct page **pagepool, bool *overlapped)
+{
+	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	struct page **compressed_pages;
+	int i, err = 0;
+
+	/* XXX: will have a better approach in the following commits */
+	compressed_pages = kmalloc_array(pclusterpages, sizeof(struct page *),
+					 GFP_KERNEL | __GFP_NOFAIL);
+	*overlapped = false;
+
+	for (i = 0; i < pclusterpages; ++i) {
+		unsigned int pagenr;
+		struct page *page = pcl->compressed_pages[i];
+
+		/* compressed pages ought to be present before decompressing */
+		if (!page) {
+			DBG_BUGON(1);
+			continue;
+		}
+		compressed_pages[i] = page;
+
+		if (z_erofs_is_inline_pcluster(pcl)) {
+			if (!PageUptodate(page))
+				err = -EIO;
+			continue;
+		}
+
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
+		if (!z_erofs_is_shortlived_page(page)) {
+			if (erofs_page_is_managed(sbi, page)) {
+				if (!PageUptodate(page))
+					err = -EIO;
+				continue;
+			}
+
+			/*
+			 * only if non-head page can be selected
+			 * for inplace decompression
+			 */
+			pagenr = z_erofs_onlinepage_index(page);
+
+			DBG_BUGON(pagenr >= pcl->nr_pages);
+			if (pages[pagenr]) {
+				DBG_BUGON(1);
+				SetPageError(pages[pagenr]);
+				z_erofs_onlinepage_endio(pages[pagenr]);
+				err = -EFSCORRUPTED;
+			}
+			pages[pagenr] = page;
+
+			*overlapped = true;
+		}
+
+		/* PG_error needs checking for all non-managed pages */
+		if (PageError(page)) {
+			DBG_BUGON(PageUptodate(page));
+			err = -EIO;
+		}
+	}
+
+	if (err) {
+		kfree(compressed_pages);
+		return ERR_PTR(err);
+	}
+	return compressed_pages;
+}
+
 static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct z_erofs_pcluster *pcl,
 				       struct page **pagepool)
@@ -957,54 +1027,11 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		pages[i] = NULL;
 
 	err = z_erofs_parse_out_bvecs(pcl, pages, pagepool);
-
-	overlapped = false;
-	compressed_pages = pcl->compressed_pages;
-
-	for (i = 0; i < pclusterpages; ++i) {
-		unsigned int pagenr;
-
-		page = compressed_pages[i];
-		/* all compressed pages ought to be valid */
-		DBG_BUGON(!page);
-
-		if (z_erofs_is_inline_pcluster(pcl)) {
-			if (!PageUptodate(page))
-				err = -EIO;
-			continue;
-		}
-
-		DBG_BUGON(z_erofs_page_is_invalidated(page));
-		if (!z_erofs_is_shortlived_page(page)) {
-			if (erofs_page_is_managed(sbi, page)) {
-				if (!PageUptodate(page))
-					err = -EIO;
-				continue;
-			}
-
-			/*
-			 * only if non-head page can be selected
-			 * for inplace decompression
-			 */
-			pagenr = z_erofs_onlinepage_index(page);
-
-			DBG_BUGON(pagenr >= nr_pages);
-			if (pages[pagenr]) {
-				DBG_BUGON(1);
-				SetPageError(pages[pagenr]);
-				z_erofs_onlinepage_endio(pages[pagenr]);
-				err = -EFSCORRUPTED;
-			}
-			pages[pagenr] = page;
-
-			overlapped = true;
-		}
-
-		/* PG_error needs checking for all non-managed pages */
-		if (PageError(page)) {
-			DBG_BUGON(PageUptodate(page));
-			err = -EIO;
-		}
+	compressed_pages = z_erofs_parse_in_bvecs(sbi, pcl, pages,
+						pagepool, &overlapped);
+	if (IS_ERR(compressed_pages)) {
+		err = PTR_ERR(compressed_pages);
+		compressed_pages = NULL;
 	}
 
 	if (err)
@@ -1040,21 +1067,22 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 out:
 	/* must handle all compressed pages before actual file pages */
 	if (z_erofs_is_inline_pcluster(pcl)) {
-		page = compressed_pages[0];
-		WRITE_ONCE(compressed_pages[0], NULL);
+		page = pcl->compressed_pages[0];
+		WRITE_ONCE(pcl->compressed_pages[0], NULL);
 		put_page(page);
 	} else {
 		for (i = 0; i < pclusterpages; ++i) {
-			page = compressed_pages[i];
+			page = pcl->compressed_pages[i];
 
 			if (erofs_page_is_managed(sbi, page))
 				continue;
 
 			/* recycle all individual short-lived pages */
 			(void)z_erofs_put_shortlivedpage(pagepool, page);
-			WRITE_ONCE(compressed_pages[i], NULL);
+			WRITE_ONCE(pcl->compressed_pages[i], NULL);
 		}
 	}
+	kfree(compressed_pages);
 
 	for (i = 0; i < nr_pages; ++i) {
 		page = pages[i];
-- 
2.24.4

