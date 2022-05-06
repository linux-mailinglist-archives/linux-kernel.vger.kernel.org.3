Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EC751DFC7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391875AbiEFTub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391653AbiEFTuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:50:20 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A026A074
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:46:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VCTGrli_1651866393;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VCTGrli_1651866393)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 May 2022 03:46:34 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/3] erofs: refine on-disk definition comments
Date:   Sat,  7 May 2022 03:46:12 +0800
Message-Id: <20220506194612.117120-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
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

Fix some outdated comments and typos, hopefully helpful.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 1238ca104f09..000fa2738974 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -79,15 +79,15 @@ struct erofs_super_block {
 
 /*
  * erofs inode datalayout (i_format in on-disk inode):
- * 0 - inode plain without inline data A:
+ * 0 - uncompressed flat inode without tail-packing inline data:
  * inode, [xattrs], ... | ... | no-holed data
- * 1 - inode VLE compression B (legacy):
- * inode, [xattrs], extents ... | ...
- * 2 - inode plain with inline data C:
- * inode, [xattrs], last_inline_data, ... | ... | no-holed data
- * 3 - inode compression D:
+ * 1 - compressed inode with non-compact indexes:
+ * inode, [xattrs], [map_header], extents ... | ...
+ * 2 - uncompressed flat inode with tail-packing inline data:
+ * inode, [xattrs], tailpacking data, ... | ... | no-holed data
+ * 3 - compressed inode with compact indexes:
  * inode, [xattrs], map_header, extents ... | ...
- * 4 - inode chunk-based E:
+ * 4 - chunk-based inode with (optional) multi-device support:
  * inode, [xattrs], chunk indexes ... | ...
  * 5~7 - reserved
  */
@@ -106,7 +106,7 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 }
 
-/* bit definitions of inode i_advise */
+/* bit definitions of inode i_format */
 #define EROFS_I_VERSION_BITS            1
 #define EROFS_I_DATALAYOUT_BITS         3
 
@@ -140,8 +140,9 @@ struct erofs_inode_compact {
 	__le32 i_size;
 	__le32 i_reserved;
 	union {
-		/* file total compressed blocks for data mapping 1 */
+		/* total compressed blocks for compressed inodes */
 		__le32 compressed_blocks;
+		/* block address for uncompressed flat inodes */
 		__le32 raw_blkaddr;
 
 		/* for device files, used to indicate old/new device # */
@@ -156,9 +157,9 @@ struct erofs_inode_compact {
 	__le32 i_reserved2;
 };
 
-/* 32 bytes on-disk inode */
+/* 32-byte on-disk inode */
 #define EROFS_INODE_LAYOUT_COMPACT	0
-/* 64 bytes on-disk inode */
+/* 64-byte on-disk inode */
 #define EROFS_INODE_LAYOUT_EXTENDED	1
 
 /* 64-byte complete form of an ondisk inode */
@@ -171,8 +172,9 @@ struct erofs_inode_extended {
 	__le16 i_reserved;
 	__le64 i_size;
 	union {
-		/* file total compressed blocks for data mapping 1 */
+		/* total compressed blocks for compressed inodes */
 		__le32 compressed_blocks;
+		/* block address for uncompressed flat inodes */
 		__le32 raw_blkaddr;
 
 		/* for device files, used to indicate old/new device # */
@@ -365,17 +367,16 @@ enum {
 
 struct z_erofs_vle_decompressed_index {
 	__le16 di_advise;
-	/* where to decompress in the head cluster */
+	/* where to decompress in the head lcluster */
 	__le16 di_clusterofs;
 
 	union {
-		/* for the head cluster */
+		/* for the HEAD lclusters */
 		__le32 blkaddr;
 		/*
-		 * for the rest clusters
-		 * eg. for 4k page-sized cluster, maximum 4K*64k = 256M)
-		 * [0] - pointing to the head cluster
-		 * [1] - pointing to the tail cluster
+		 * for the NONHEAD lclusters
+		 * [0] - distance to its HEAD lcluster
+		 * [1] - distance to the next HEAD lcluster
 		 */
 		__le16 delta[2];
 	} di_u;
-- 
2.24.4

