Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDF74D520A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbiCJS3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243134AbiCJS2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:28:55 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A2EBD2E6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:27:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V6pgl6q_1646936870;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V6pgl6q_1646936870)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Mar 2022 02:27:51 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: refine managed inode stuffs
Date:   Fri, 11 Mar 2022 02:27:43 +0800
Message-Id: <20220310182743.102365-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set up the correct gfp mask and use it instead of hard coding.
Also add comments about .invalidatepage() to show more details.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 8 ++++++--
 fs/erofs/zdata.c | 7 +++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 12755217631f..e178100c162a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -532,6 +532,11 @@ static int erofs_managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
 	return ret;
 }
 
+/*
+ * It will be called only on inode eviction. In case that there are still some
+ * decompression requests in progress, wait with rescheduling for a bit here.
+ * We could introduce an extra locking instead but it seems unnecessary.
+ */
 static void erofs_managed_cache_invalidatepage(struct page *page,
 					       unsigned int offset,
 					       unsigned int length)
@@ -565,8 +570,7 @@ static int erofs_init_managed_cache(struct super_block *sb)
 	inode->i_size = OFFSET_MAX;
 
 	inode->i_mapping->a_ops = &managed_cache_aops;
-	mapping_set_gfp_mask(inode->i_mapping,
-			     GFP_NOFS | __GFP_HIGHMEM | __GFP_MOVABLE);
+	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	sbi->managed_cache = inode;
 	return 0;
 }
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 59aecf42e45c..f5e17c03b2fb 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1091,10 +1091,10 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 					       unsigned int nr,
 					       struct page **pagepool,
-					       struct address_space *mc,
-					       gfp_t gfp)
+					       struct address_space *mc)
 {
 	const pgoff_t index = pcl->obj.index;
+	gfp_t gfp = mapping_gfp_mask(mc);
 	bool tocache = false;
 
 	struct address_space *mapping;
@@ -1350,8 +1350,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			struct page *page;
 
 			page = pickup_page_for_submission(pcl, i++, pagepool,
-							  MNGD_MAPPING(sbi),
-							  GFP_NOFS);
+							  MNGD_MAPPING(sbi));
 			if (!page)
 				continue;
 
-- 
2.24.4

