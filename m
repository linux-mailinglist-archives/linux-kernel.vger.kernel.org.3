Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654415A64D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiH3NcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiH3NcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:32:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162CCD5E8E;
        Tue, 30 Aug 2022 06:31:59 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MH7QY49p7zYcqR;
        Tue, 30 Aug 2022 21:27:33 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 21:31:56 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <djwong@kernel.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zengheng4@huawei.com>
Subject: [PATCH -next 1/2] xfs: simplify if-else condition in xfs_validate_new_dalign
Date:   Tue, 30 Aug 2022 21:39:38 +0800
Message-ID: <20220830133939.2726749-2-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830133939.2726749-1-zengheng4@huawei.com>
References: <20220830133939.2726749-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"else" is not generally useful after a return,
so remove them which makes if condition a bit
more clear.

There is no logical changes.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/xfs/xfs_mount.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index f10c88cee116..e8bb3c2e847e 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -300,26 +300,28 @@ xfs_validate_new_dalign(
 	"alignment check failed: sunit/swidth vs. blocksize(%d)",
 			mp->m_sb.sb_blocksize);
 		return -EINVAL;
-	} else {
-		/*
-		 * Convert the stripe unit and width to FSBs.
-		 */
-		mp->m_dalign = XFS_BB_TO_FSBT(mp, mp->m_dalign);
-		if (mp->m_dalign && (mp->m_sb.sb_agblocks % mp->m_dalign)) {
-			xfs_warn(mp,
-		"alignment check failed: sunit/swidth vs. agsize(%d)",
-				 mp->m_sb.sb_agblocks);
-			return -EINVAL;
-		} else if (mp->m_dalign) {
-			mp->m_swidth = XFS_BB_TO_FSBT(mp, mp->m_swidth);
-		} else {
-			xfs_warn(mp,
-		"alignment check failed: sunit(%d) less than bsize(%d)",
-				 mp->m_dalign, mp->m_sb.sb_blocksize);
-			return -EINVAL;
-		}
 	}
 
+	/*
+	 * Convert the stripe unit and width to FSBs.
+	 */
+	mp->m_dalign = XFS_BB_TO_FSBT(mp, mp->m_dalign);
+	if (mp->m_dalign && (mp->m_sb.sb_agblocks % mp->m_dalign)) {
+		xfs_warn(mp,
+	"alignment check failed: sunit/swidth vs. agsize(%d)",
+			mp->m_sb.sb_agblocks);
+		return -EINVAL;
+	}
+
+	if (!mp->m_dalign) {
+		xfs_warn(mp,
+	"alignment check failed: sunit(%d) less than bsize(%d)",
+			mp->m_dalign, mp->m_sb.sb_blocksize);
+		return -EINVAL;
+	}
+
+	mp->m_swidth = XFS_BB_TO_FSBT(mp, mp->m_swidth);
+
 	if (!xfs_has_dalign(mp)) {
 		xfs_warn(mp,
 "cannot change alignment: superblock does not support data alignment");
-- 
2.25.1

