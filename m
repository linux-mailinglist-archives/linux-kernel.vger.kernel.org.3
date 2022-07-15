Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7290A5764A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiGOPmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiGOPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:42:25 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE605508B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:42:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJPnC2I_1657899733;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJPnC2I_1657899733)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:42:14 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>
Subject: [PATCH v2 02/16] erofs: clean up z_erofs_collector_begin()
Date:   Fri, 15 Jul 2022 23:41:49 +0800
Message-Id: <20220715154203.48093-3-hsiangkao@linux.alibaba.com>
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

Rearrange the code and get rid of all gotos.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 1b6816dd235f..c7be447ac64d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -521,7 +521,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
-	struct erofs_workgroup *grp;
+	struct erofs_workgroup *grp = NULL;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
@@ -530,33 +530,31 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
-	if (map->m_flags & EROFS_MAP_META) {
-		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-		goto tailpacking;
+	if (!(map->m_flags & EROFS_MAP_META)) {
+		grp = erofs_find_workgroup(fe->inode->i_sb,
+					   map->m_pa >> PAGE_SHIFT);
+	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
 	}
 
-	grp = erofs_find_workgroup(fe->inode->i_sb, map->m_pa >> PAGE_SHIFT);
 	if (grp) {
 		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
+		ret = -EEXIST;
 	} else {
-tailpacking:
 		ret = z_erofs_register_pcluster(fe);
-		if (!ret)
-			goto out;
-		if (ret != -EEXIST)
-			return ret;
 	}
 
-	ret = z_erofs_lookup_pcluster(fe);
-	if (ret) {
-		erofs_workgroup_put(&fe->pcl->obj);
+	if (ret == -EEXIST) {
+		ret = z_erofs_lookup_pcluster(fe);
+		if (ret) {
+			erofs_workgroup_put(&fe->pcl->obj);
+			return ret;
+		}
+	} else if (ret) {
 		return ret;
 	}
 
-out:
 	z_erofs_pagevec_ctor_init(&fe->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  fe->pcl->pagevec, fe->pcl->vcnt);
 	/* since file-backed online pages are traversed in reverse order */
-- 
2.24.4

