Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C367B4A8C1C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353635AbiBCTCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiBCTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:02:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2567BC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:02:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B63E16194B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 19:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707D8C340E8;
        Thu,  3 Feb 2022 19:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643914932;
        bh=cJG9o5eRJ7YKbd6n5DSg9CwYjNG9DgWrahvpoQ7Qonk=;
        h=From:To:Cc:Subject:Date:From;
        b=PjqcSqb60rsEKs3aCMdcvdPf2Cgl8zARK3XuFKckymcpDKk/Th5F7QVMJyaBPPmvi
         ab65P90ABnbMlJ97b0bKPJwTsAABhAjATHPmE1HzC13RYQtngQE9ZaUVZD7ATnxATK
         /TwWoZzsmPBGwUiTI5U3vJbWmaI2JMfjD6Rdrcb2/eaFu+2nzfeIj7eRdYQhyT48GF
         UXaHYNZ5igVT+w95Tqt/TEoCK7iCML23hjf9IMZ3vfLjbZwc6fYaZI3Yqxmv1R8omP
         V6tw9CEBrEwQoFcywDwBz+7UShnMjY+1UovbXs8rmDC6N2CLJaxFod0WmoxhPJeSPe
         3jYVAdISA9+bg==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix small compressed files inlining
Date:   Fri,  4 Feb 2022 03:02:03 +0800
Message-Id: <20220203190203.30794-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Prior to ztailpacking feature, it's enough that each lcluster has
two pclusters at most, and the last pcluster should be turned into
an uncompressed pcluster if necessary. For example,
  _________________________________________________
 |_ pcluster n-2 _|_ pcluster n-1 _|____ EOFed ____|

which should be converted into:
  _________________________________________________
 |_ pcluster n-2 _|_ pcluster n-1 (uncompressed)' _|

That is fine since either pcluster n-1 or (uncompressed)' takes one
physical block.

However, after ztailpacking supported, the game is changed since the
last pcluster can be inlined now. And such case above is quite common
for inlining small files. Therefore, in order to inline such files
more effectively, special EOF lclusters are now supported which can
have three parts at most, as illustrated below:
  _________________________________________________
 |_ pcluster n-2 _|_ pcluster n-1 _|____ EOFed ____|
                                   ^ i_size

Actually similar code exists in Yue Hu's original patchset [1], but I
removed this part on purpose. After evaluating more real cases with
small files, I've changed my mind.

[1] https://lore.kernel.org/r/20211215094449.15162-1-huyue2@yulong.com
Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 18d7fd1a5064..723ebfa6a27d 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -630,6 +630,13 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+			/*
+			 * For ztailpacking files, in order to inline data more
+			 * effectively, special EOF lclusters are now supported
+			 * which can have three parts at most.
+			 */
+			if (ztailpacking && end >= inode->i_size)
+				end = inode->i_size;
 			break;
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
-- 
2.20.1

