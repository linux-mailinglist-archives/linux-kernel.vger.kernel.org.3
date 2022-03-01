Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477E64C9519
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiCATw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiCATwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:52:21 -0500
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1556A5C358
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:51:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V6-vyGs_1646164206;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V6-vyGs_1646164206)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Mar 2022 03:50:07 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: clean up preload_compressed_pages()
Date:   Wed,  2 Mar 2022 03:49:51 +0800
Message-Id: <20220301194951.106227-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
References: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename preload_compressed_pages() as z_erofs_bind_cache()
since we're try to prepare for adapting folios.

Also, add a comment for the gfp setting. No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2673fc105861..59aecf42e45c 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -219,13 +219,17 @@ struct z_erofs_decompress_frontend {
 static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
 static DEFINE_MUTEX(z_pagemap_global_lock);
 
-static void preload_compressed_pages(struct z_erofs_decompress_frontend *fe,
-				     struct address_space *mc,
-				     enum z_erofs_cache_alloctype type,
-				     struct page **pagepool)
+static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
+			       enum z_erofs_cache_alloctype type,
+			       struct page **pagepool)
 {
+	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
 	struct z_erofs_pcluster *pcl = fe->pcl;
 	bool standalone = true;
+	/*
+	 * optimistic allocation without direct reclaim since inplace I/O
+	 * can be used if low memory otherwise.
+	 */
 	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
 			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
 	struct page **pages;
@@ -703,17 +707,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		WRITE_ONCE(fe->pcl->compressed_pages[0], fe->map.buf.page);
 		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
 	} else {
-		/* preload all compressed pages (can change mode if needed) */
+		/* bind cache first when cached decompression is preferred */
 		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
 					       map->m_la))
 			cache_strategy = TRYALLOC;
 		else
 			cache_strategy = DONTALLOC;
 
-		preload_compressed_pages(fe, MNGD_MAPPING(sbi),
-					 cache_strategy, pagepool);
+		z_erofs_bind_cache(fe, cache_strategy, pagepool);
 	}
-
 hitted:
 	/*
 	 * Ensure the current partial page belongs to this submit chain rather
-- 
2.24.4

