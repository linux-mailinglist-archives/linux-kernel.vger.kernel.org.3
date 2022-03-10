Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8D34D51A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245446AbiCJS24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbiCJS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:28:54 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C9A7754
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:27:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V6pgl69_1646936864;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V6pgl69_1646936864)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Mar 2022 02:27:50 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: clean up z_erofs_extent_lookback
Date:   Fri, 11 Mar 2022 02:27:42 +0800
Message-Id: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Avoid the unnecessary tail recursion since it can be converted into
a loop directly in order to prevent potential stack overflow.

It's a pretty straightforward conversion.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 67 ++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index b4059b9c3bac..572f0b8151ba 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -431,48 +431,47 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 				   unsigned int lookback_distance)
 {
 	struct erofs_inode *const vi = EROFS_I(m->inode);
-	struct erofs_map_blocks *const map = m->map;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	unsigned long lcn = m->lcn;
-	int err;
 
-	if (lcn < lookback_distance) {
-		erofs_err(m->inode->i_sb,
-			  "bogus lookback distance @ nid %llu", vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
+	while (m->lcn >= lookback_distance) {
+		unsigned long lcn = m->lcn - lookback_distance;
+		int err;
 
-	/* load extent head logical cluster if needed */
-	lcn -= lookback_distance;
-	err = z_erofs_load_cluster_from_disk(m, lcn, false);
-	if (err)
-		return err;
+		/* load extent head logical cluster if needed */
+		err = z_erofs_load_cluster_from_disk(m, lcn, false);
+		if (err)
+			return err;
 
-	switch (m->type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		if (!m->delta[0]) {
+		switch (m->type) {
+		case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+			if (!m->delta[0]) {
+				erofs_err(m->inode->i_sb,
+					  "invalid lookback distance 0 @ nid %llu",
+					  vi->nid);
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+			lookback_distance = m->delta[0];
+			continue;
+		case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
+		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+			m->headtype = m->type;
+			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
+			return 0;
+		default:
 			erofs_err(m->inode->i_sb,
-				  "invalid lookback distance 0 @ nid %llu",
-				  vi->nid);
+				  "unknown type %u @ lcn %lu of nid %llu",
+				  m->type, lcn, vi->nid);
 			DBG_BUGON(1);
-			return -EFSCORRUPTED;
+			return -EOPNOTSUPP;
 		}
-		return z_erofs_extent_lookback(m, m->delta[0]);
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
-		m->headtype = m->type;
-		map->m_la = (lcn << lclusterbits) | m->clusterofs;
-		break;
-	default:
-		erofs_err(m->inode->i_sb,
-			  "unknown type %u @ lcn %lu of nid %llu",
-			  m->type, lcn, vi->nid);
-		DBG_BUGON(1);
-		return -EOPNOTSUPP;
 	}
-	return 0;
+
+	erofs_err(m->inode->i_sb, "bogus lookback distance @ nid %llu",
+		  vi->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
 }
 
 static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
-- 
2.24.4

