Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CA25764A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiGOPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiGOPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:42:31 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBFF58841
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:42:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJPnC79_1657899744;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJPnC79_1657899744)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:42:25 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 11/16] erofs: get rid of `z_pagemap_global'
Date:   Fri, 15 Jul 2022 23:41:58 +0800
Message-Id: <20220715154203.48093-12-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
References: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to introduce multi-reference pclusters for compressed data
deduplication, let's get rid of the global page array for now since
it needs to be re-designed then at least.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 28 ++++------------------------
 fs/erofs/zdata.h |  1 -
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d1f907f4757d..3f735ca0415e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -291,9 +291,6 @@ struct z_erofs_decompress_frontend {
 	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
 	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
 
-static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
-static DEFINE_MUTEX(z_pagemap_global_lock);
-
 static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 			       enum z_erofs_cache_alloctype type,
 			       struct page **pagepool)
@@ -966,26 +963,11 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 	mutex_lock(&pcl->lock);
 	nr_pages = pcl->nr_pages;
 
-	if (nr_pages <= Z_EROFS_VMAP_ONSTACK_PAGES) {
+	if (nr_pages <= Z_EROFS_VMAP_ONSTACK_PAGES)
 		pages = pages_onstack;
-	} else if (nr_pages <= Z_EROFS_VMAP_GLOBAL_PAGES &&
-		   mutex_trylock(&z_pagemap_global_lock)) {
-		pages = z_pagemap_global;
-	} else {
-		gfp_t gfp_flags = GFP_KERNEL;
-
-		if (nr_pages > Z_EROFS_VMAP_GLOBAL_PAGES)
-			gfp_flags |= __GFP_NOFAIL;
-
+	else
 		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
-				       gfp_flags);
-
-		/* fallback to global pagemap for the lowmem scenario */
-		if (!pages) {
-			mutex_lock(&z_pagemap_global_lock);
-			pages = z_pagemap_global;
-		}
-	}
+				       GFP_KERNEL | __GFP_NOFAIL);
 
 	for (i = 0; i < nr_pages; ++i)
 		pages[i] = NULL;
@@ -1065,9 +1047,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		z_erofs_onlinepage_endio(page);
 	}
 
-	if (pages == z_pagemap_global)
-		mutex_unlock(&z_pagemap_global_lock);
-	else if (pages != pages_onstack)
+	if (pages != pages_onstack)
 		kvfree(pages);
 
 	pcl->nr_pages = 0;
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 75f6fd435388..43c91bd2d84f 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -175,6 +175,5 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 
 #define Z_EROFS_VMAP_ONSTACK_PAGES	\
 	min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
-#define Z_EROFS_VMAP_GLOBAL_PAGES	2048
 
 #endif
-- 
2.24.4

