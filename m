Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686065764A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiGOPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiGOPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:42:27 -0400
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B9528A7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:42:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJPnC6._1657899741;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJPnC6._1657899741)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:42:22 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 09/16] erofs: get rid of `enum z_erofs_page_type'
Date:   Fri, 15 Jul 2022 23:41:56 +0800
Message-Id: <20220715154203.48093-10-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
References: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove it since pagevec[] is no longer used.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2d5e2ed3e5f5..f2a513299d82 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -27,17 +27,6 @@ static struct z_erofs_pcluster_slab pcluster_pool[] __read_mostly = {
 	_PCLP(Z_EROFS_PCLUSTER_MAX_PAGES)
 };
 
-/* (obsoleted) page type for online pages */
-enum z_erofs_page_type {
-	/* including Z_EROFS_VLE_PAGE_TAIL_EXCLUSIVE */
-	Z_EROFS_PAGE_TYPE_EXCLUSIVE,
-
-	Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED,
-
-	Z_EROFS_VLE_PAGE_TYPE_HEAD,
-	Z_EROFS_VLE_PAGE_TYPE_MAX
-};
-
 struct z_erofs_bvec_iter {
 	struct page *bvpage;
 	struct z_erofs_bvset *bvset;
@@ -429,7 +418,6 @@ int erofs_try_to_free_cached_page(struct page *page)
 	return ret;
 }
 
-/* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
 static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
 				   struct z_erofs_bvec *bvec)
 {
@@ -447,13 +435,11 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
 
 /* callers must be with pcluster lock held */
 static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
-			       struct z_erofs_bvec *bvec,
-			       enum z_erofs_page_type type)
+			       struct z_erofs_bvec *bvec, bool exclusive)
 {
 	int ret;
 
-	if (fe->mode >= COLLECT_PRIMARY &&
-	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE) {
+	if (fe->mode >= COLLECT_PRIMARY && exclusive) {
 		/* give priority for inplaceio to use file pages first */
 		if (z_erofs_try_inplace_io(fe, bvec))
 			return 0;
@@ -718,10 +704,9 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
-	bool tight = true;
+	bool tight = true, exclusive;
 
 	enum z_erofs_cache_alloctype cache_strategy;
-	enum z_erofs_page_type page_type;
 	unsigned int cur, end, spiltted, index;
 	int err = 0;
 
@@ -798,12 +783,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto next_part;
 	}
 
-	/* let's derive page type */
-	page_type = cur ? Z_EROFS_VLE_PAGE_TYPE_HEAD :
-		(!spiltted ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
-			(tight ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
-				Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED));
-
+	exclusive = (!cur && (!spiltted || tight));
 	if (cur)
 		tight &= (fe->mode >= COLLECT_PRIMARY_FOLLOWED);
 
@@ -812,7 +792,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 					.page = page,
 					.offset = offset - map->m_la,
 					.end = end,
-				  }), page_type);
+				  }), exclusive);
 	/* should allocate an additional short-lived page for bvset */
 	if (err == -EAGAIN && !fe->candidate_bvpage) {
 		fe->candidate_bvpage = alloc_page(GFP_NOFS | __GFP_NOFAIL);
-- 
2.24.4

