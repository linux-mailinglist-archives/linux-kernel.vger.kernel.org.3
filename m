Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ACD574EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbiGNNVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbiGNNVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:21:05 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445905E325
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:21:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPD9_1657804858;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPD9_1657804858)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:20:59 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 01/16] erofs: get rid of unneeded `inode', `map' and `sb'
Date:   Thu, 14 Jul 2022 21:20:36 +0800
Message-Id: <20220714132051.46012-2-hsiangkao@linux.alibaba.com>
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

Since commit 5c6dcc57e2e5 ("erofs: get rid of
`struct z_erofs_collector'"), these arguments can be dropped as well.

No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 724bb57075f6..1b6816dd235f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -404,10 +404,9 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 	f->mode = COLLECT_PRIMARY;
 }
 
-static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe,
-				   struct inode *inode,
-				   struct erofs_map_blocks *map)
+static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe)
 {
+	struct erofs_map_blocks *map = &fe->map;
 	struct z_erofs_pcluster *pcl = fe->pcl;
 	unsigned int length;
 
@@ -449,10 +448,9 @@ static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe,
 	return 0;
 }
 
-static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe,
-				     struct inode *inode,
-				     struct erofs_map_blocks *map)
+static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
+	struct erofs_map_blocks *map = &fe->map;
 	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl;
 	struct erofs_workgroup *grp;
@@ -494,7 +492,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe,
 	} else {
 		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
 
-		grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
+		grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
 		if (IS_ERR(grp)) {
 			err = PTR_ERR(grp);
 			goto err_out;
@@ -520,10 +518,9 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe,
 	return err;
 }
 
-static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
-				   struct inode *inode,
-				   struct erofs_map_blocks *map)
+static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 {
+	struct erofs_map_blocks *map = &fe->map;
 	struct erofs_workgroup *grp;
 	int ret;
 
@@ -541,19 +538,19 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
 		goto tailpacking;
 	}
 
-	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
+	grp = erofs_find_workgroup(fe->inode->i_sb, map->m_pa >> PAGE_SHIFT);
 	if (grp) {
 		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
 	} else {
 tailpacking:
-		ret = z_erofs_register_pcluster(fe, inode, map);
+		ret = z_erofs_register_pcluster(fe);
 		if (!ret)
 			goto out;
 		if (ret != -EEXIST)
 			return ret;
 	}
 
-	ret = z_erofs_lookup_pcluster(fe, inode, map);
+	ret = z_erofs_lookup_pcluster(fe);
 	if (ret) {
 		erofs_workgroup_put(&fe->pcl->obj);
 		return ret;
@@ -663,7 +660,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (!(map->m_flags & EROFS_MAP_MAPPED))
 		goto hitted;
 
-	err = z_erofs_collector_begin(fe, inode, map);
+	err = z_erofs_collector_begin(fe);
 	if (err)
 		goto err_out;
 
@@ -1259,13 +1256,13 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 	bio_put(bio);
 }
 
-static void z_erofs_submit_queue(struct super_block *sb,
-				 struct z_erofs_decompress_frontend *f,
+static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				 struct page **pagepool,
 				 struct z_erofs_decompressqueue *fgq,
 				 bool *force_fg)
 {
-	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+	struct super_block *sb = f->inode->i_sb;
+	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
 	void *bi_private;
@@ -1317,7 +1314,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			struct page *page;
 
 			page = pickup_page_for_submission(pcl, i++, pagepool,
-							  MNGD_MAPPING(sbi));
+							  mc);
 			if (!page)
 				continue;
 
@@ -1369,15 +1366,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
 }
 
-static void z_erofs_runqueue(struct super_block *sb,
-			     struct z_erofs_decompress_frontend *f,
+static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
 			     struct page **pagepool, bool force_fg)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
 	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
-	z_erofs_submit_queue(sb, f, pagepool, io, &force_fg);
+	z_erofs_submit_queue(f, pagepool, io, &force_fg);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
@@ -1475,7 +1471,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	(void)z_erofs_collector_end(&f);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
+	z_erofs_runqueue(&f, &pagepool,
 			 z_erofs_get_sync_decompress_policy(sbi, 0));
 
 	if (err)
@@ -1524,7 +1520,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
 	(void)z_erofs_collector_end(&f);
 
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
+	z_erofs_runqueue(&f, &pagepool,
 			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&pagepool);
-- 
2.24.4

