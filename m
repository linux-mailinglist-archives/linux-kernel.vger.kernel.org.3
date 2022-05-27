Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72BF535A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345110AbiE0HZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiE0HZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:25:41 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78597ED712
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:25:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hongnan.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VEW7hpz_1653636336;
Received: from localhost(mailfrom:hongnan.li@linux.alibaba.com fp:SMTPD_---0VEW7hpz_1653636336)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 15:25:36 +0800
From:   Hongnan Li <hongnan.li@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] erofs: update ctx->pos for every emitted dirent
Date:   Fri, 27 May 2022 15:25:36 +0800
Message-Id: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

erofs_readdir update ctx->pos after filling a batch of dentries
and it may cause dir/files duplication for NFS readdirplus which
depends on ctx->pos to fill dir correctly. So update ctx->pos for
every emitted dirent in erofs_fill_dentries to fix it.

Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
---
 fs/erofs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 18e59821c597..3015974fe2ff 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -22,11 +22,12 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
 }
 
 static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
-			       void *dentry_blk, unsigned int *ofs,
+			       void *dentry_blk, void *dentry_begin,
 			       unsigned int nameoff, unsigned int maxsize)
 {
-	struct erofs_dirent *de = dentry_blk + *ofs;
+	struct erofs_dirent *de = dentry_begin;
 	const struct erofs_dirent *end = dentry_blk + nameoff;
+	loff_t begin_pos = ctx->pos;
 
 	while (de < end) {
 		const char *de_name;
@@ -59,9 +60,9 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			/* stopped by some reason */
 			return 1;
 		++de;
-		*ofs += sizeof(struct erofs_dirent);
+		ctx->pos += sizeof(struct erofs_dirent);
 	}
-	*ofs = maxsize;
+	ctx->pos = begin_pos + maxsize;
 	return 0;
 }
 
@@ -110,11 +111,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 				goto skip_this;
 		}
 
-		err = erofs_fill_dentries(dir, ctx, de, &ofs,
+		err = erofs_fill_dentries(dir, ctx, de, de + ofs,
 					  nameoff, maxsize);
 skip_this:
-		ctx->pos = blknr_to_addr(i) + ofs;
-
 		if (err)
 			break;
 		++i;
-- 
2.35.1

