Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF5574F00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiGNNV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiGNNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:21:22 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB7E5E328
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:21:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPPf_1657804877;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPPf_1657804877)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:18 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 13/16] erofs: try to leave (de)compressed_pages on stack if possible
Date:   Thu, 14 Jul 2022 21:20:48 +0800
Message-Id: <20220714132051.46012-14-hsiangkao@linux.alibaba.com>
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

For the most cases, small pclusters can be decompressed with page
arrays on stack.

Try to leave both (de)compressed_pages on stack if possible as before.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 7aea6bb1e018..4093d8a4ce93 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -858,6 +858,7 @@ struct z_erofs_decompress_backend {
 	struct page **compressed_pages;
 
 	struct page **pagepool;
+	unsigned int onstack_used;
 };
 
 static int z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
@@ -904,14 +905,9 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 {
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	struct page **compressed_pages;
 	int i, err = 0;
 
-	/* XXX: will have a better approach in the following commits */
-	compressed_pages = kmalloc_array(pclusterpages, sizeof(struct page *),
-					 GFP_KERNEL | __GFP_NOFAIL);
 	*overlapped = false;
-
 	for (i = 0; i < pclusterpages; ++i) {
 		struct z_erofs_bvec *bvec = &pcl->compressed_bvecs[i];
 		struct page *page = bvec->page;
@@ -922,7 +918,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 			DBG_BUGON(1);
 			continue;
 		}
-		compressed_pages[i] = page;
+		be->compressed_pages[i] = page;
 
 		if (z_erofs_is_inline_pcluster(pcl)) {
 			if (!PageUptodate(page))
@@ -953,11 +949,8 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 		}
 	}
 
-	if (err) {
-		kfree(compressed_pages);
+	if (err)
 		return err;
-	}
-	be->compressed_pages = compressed_pages;
 	return 0;
 }
 
@@ -975,15 +968,28 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	mutex_lock(&pcl->lock);
 	nr_pages = pcl->nr_pages;
 
+	/* allocate (de)compressed page arrays if cannot be kept on stack */
+	be->decompressed_pages = NULL;
+	be->compressed_pages = NULL;
+	be->onstack_used = 0;
 	if (nr_pages <= Z_EROFS_ONSTACK_PAGES) {
 		be->decompressed_pages = be->onstack_pages;
+		be->onstack_used = nr_pages;
 		memset(be->decompressed_pages, 0,
 		       sizeof(struct page *) * nr_pages);
-	} else {
+	}
+
+	if (pclusterpages + be->onstack_used <= Z_EROFS_ONSTACK_PAGES)
+		be->compressed_pages = be->onstack_pages + be->onstack_used;
+
+	if (!be->decompressed_pages)
 		be->decompressed_pages =
 			kvcalloc(nr_pages, sizeof(struct page *),
 				 GFP_KERNEL | __GFP_NOFAIL);
-	}
+	if (!be->compressed_pages)
+		be->compressed_pages =
+			kvcalloc(pclusterpages, sizeof(struct page *),
+				 GFP_KERNEL | __GFP_NOFAIL);
 
 	err = z_erofs_parse_out_bvecs(be);
 	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
@@ -1037,7 +1043,9 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
 	}
-	kfree(be->compressed_pages);
+	if (be->compressed_pages < be->onstack_pages ||
+	    be->compressed_pages >= be->onstack_pages + Z_EROFS_ONSTACK_PAGES)
+		kvfree(be->compressed_pages);
 
 	for (i = 0; i < nr_pages; ++i) {
 		page = be->decompressed_pages[i];
-- 
2.24.4

