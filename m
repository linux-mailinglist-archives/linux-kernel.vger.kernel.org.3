Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626F94DA754
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352943AbiCPBYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352936AbiCPBYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:24:19 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A411F8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:23:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V7JXUrL_1647393780;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7JXUrL_1647393780)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 09:23:03 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: support inode lookup with metabuf
Date:   Wed, 16 Mar 2022 09:22:46 +0800
Message-Id: <20220316012246.95131-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220316012246.95131-1-hsiangkao@linux.alibaba.com>
References: <20220316012246.95131-1-hsiangkao@linux.alibaba.com>
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

This converts the remaining inode lookup part by using metabuf in a
straight-forward way. Except that it doesn't use kmap_atomic()
anymore since we now have to maintain two metabuf together.

After this patch, all uncompressed paths are handled with metabuf
instead of page structure.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/namei.c | 54 +++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 8629e616028c..554efa363317 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
+ * Copyright (C) 2022, Alibaba Cloud
  */
 #include "xattr.h"
 
@@ -86,14 +87,14 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
 	return ERR_PTR(-ENOENT);
 }
 
-static struct page *find_target_block_classic(struct inode *dir,
-					      struct erofs_qstr *name,
-					      int *_ndirents)
+static void *find_target_block_classic(struct erofs_buf *target,
+				       struct inode *dir,
+				       struct erofs_qstr *name,
+				       int *_ndirents)
 {
 	unsigned int startprfx, endprfx;
 	int head, back;
-	struct address_space *const mapping = dir->i_mapping;
-	struct page *candidate = ERR_PTR(-ENOENT);
+	void *candidate = ERR_PTR(-ENOENT);
 
 	startprfx = endprfx = 0;
 	head = 0;
@@ -101,10 +102,11 @@ static struct page *find_target_block_classic(struct inode *dir,
 
 	while (head <= back) {
 		const int mid = head + (back - head) / 2;
-		struct page *page = read_mapping_page(mapping, mid, NULL);
+		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+		struct erofs_dirent *de;
 
-		if (!IS_ERR(page)) {
-			struct erofs_dirent *de = kmap_atomic(page);
+		de = erofs_bread(&buf, dir, mid, EROFS_KMAP);
+		if (!IS_ERR(de)) {
 			const int nameoff = nameoff_from_disk(de->nameoff,
 							      EROFS_BLKSIZ);
 			const int ndirents = nameoff / sizeof(*de);
@@ -113,13 +115,12 @@ static struct page *find_target_block_classic(struct inode *dir,
 			struct erofs_qstr dname;
 
 			if (!ndirents) {
-				kunmap_atomic(de);
-				put_page(page);
+				erofs_put_metabuf(&buf);
 				erofs_err(dir->i_sb,
 					  "corrupted dir block %d @ nid %llu",
 					  mid, EROFS_I(dir)->nid);
 				DBG_BUGON(1);
-				page = ERR_PTR(-EFSCORRUPTED);
+				de = ERR_PTR(-EFSCORRUPTED);
 				goto out;
 			}
 
@@ -135,7 +136,6 @@ static struct page *find_target_block_classic(struct inode *dir,
 
 			/* string comparison without already matched prefix */
 			diff = erofs_dirnamecmp(name, &dname, &matched);
-			kunmap_atomic(de);
 
 			if (!diff) {
 				*_ndirents = 0;
@@ -145,11 +145,12 @@ static struct page *find_target_block_classic(struct inode *dir,
 				startprfx = matched;
 
 				if (!IS_ERR(candidate))
-					put_page(candidate);
-				candidate = page;
+					erofs_put_metabuf(target);
+				*target = buf;
+				candidate = de;
 				*_ndirents = ndirents;
 			} else {
-				put_page(page);
+				erofs_put_metabuf(&buf);
 
 				back = mid - 1;
 				endprfx = matched;
@@ -158,8 +159,8 @@ static struct page *find_target_block_classic(struct inode *dir,
 		}
 out:		/* free if the candidate is valid */
 		if (!IS_ERR(candidate))
-			put_page(candidate);
-		return page;
+			erofs_put_metabuf(target);
+		return de;
 	}
 	return candidate;
 }
@@ -169,8 +170,7 @@ int erofs_namei(struct inode *dir,
 		erofs_nid_t *nid, unsigned int *d_type)
 {
 	int ndirents;
-	struct page *page;
-	void *data;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_dirent *de;
 	struct erofs_qstr qn;
 
@@ -181,26 +181,20 @@ int erofs_namei(struct inode *dir,
 	qn.end = name->name + name->len;
 
 	ndirents = 0;
-	page = find_target_block_classic(dir, &qn, &ndirents);
 
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	de = find_target_block_classic(&buf, dir, &qn, &ndirents);
+	if (IS_ERR(de))
+		return PTR_ERR(de);
 
-	data = kmap_atomic(page);
 	/* the target page has been mapped */
 	if (ndirents)
-		de = find_target_dirent(&qn, data, EROFS_BLKSIZ, ndirents);
-	else
-		de = (struct erofs_dirent *)data;
+		de = find_target_dirent(&qn, (u8 *)de, EROFS_BLKSIZ, ndirents);
 
 	if (!IS_ERR(de)) {
 		*nid = le64_to_cpu(de->nid);
 		*d_type = de->file_type;
 	}
-
-	kunmap_atomic(data);
-	put_page(page);
-
+	erofs_put_metabuf(&buf);
 	return PTR_ERR_OR_ZERO(de);
 }
 
-- 
2.24.4

