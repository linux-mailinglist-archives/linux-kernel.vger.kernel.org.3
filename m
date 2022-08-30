Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901CC5A7128
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiH3WyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiH3WyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE47756C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A9B5615B3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75248C433D7;
        Tue, 30 Aug 2022 22:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661900050;
        bh=KEid+7kvUT3KgTg6693WIkEqqlhKnYmQIIvaC6xRZ84=;
        h=From:To:Cc:Subject:Date:From;
        b=YfrUOS2KHTb/I5OSrN0nhxWjcz6EbMXxna1r0dihmtHU3Ixx4FzrnjAA6igduRNun
         Kqjij67/zLqnufSaXsgE47ZyBYarG6+eGDDbL6vOHqphZl8pkN3Y35FFtNwlA+Nq14
         hfuXTBhYE6dmNfjhFujLEyMLJ3NcHuL3S13QJUeGkA2+odl9NdCi5hIqrEmsO7Cg78
         3DdeFQAcFoSu7gPlGaCUqavOKxonSSzDtZRWhKEWUdMang1+GudxJYNWnw5LT3i3qe
         8jmdRRyf3ppMCBgcdJSqSrDSot78d/IQDkL3FbL1MVQ2stOIQyS5VaUvO7reBHb+K4
         ULTc90sp4Hpdg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH v2] f2fs: fix to disallow getting inner inode via f2fs_iget()
Date:   Wed, 31 Aug 2022 06:53:58 +0800
Message-Id: <20220830225358.300027-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao.yu@oppo.com>

Introduce f2fs_iget_inner() for f2fs_fill_super() to get inner inode:
meta inode, node inode or compressed inode, and add f2fs_check_nid_range()
in f2fs_iget() to avoid getting inner inode from external interfaces.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
v2:
- don't override errno from f2fs_check_nid_range()
- fix compile error
 fs/f2fs/compress.c |  2 +-
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/inode.c    | 13 ++++++++++++-
 fs/f2fs/super.c    |  4 ++--
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 730256732a9e..c38b22bb6432 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1947,7 +1947,7 @@ int f2fs_init_compress_inode(struct f2fs_sb_info *sbi)
 	if (!test_opt(sbi, COMPRESS_CACHE))
 		return 0;
 
-	inode = f2fs_iget(sbi->sb, F2FS_COMPRESS_INO(sbi));
+	inode = f2fs_iget_inner(sbi->sb, F2FS_COMPRESS_INO(sbi));
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 	sbi->compress_inode = inode;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 408d8034ed74..35f9e1a6a1bf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3467,6 +3467,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc);
 void f2fs_set_inode_flags(struct inode *inode);
 bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page);
 void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page);
+struct inode *f2fs_iget_inner(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
 int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 6d11c365d7b4..965f87c1dd63 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -480,7 +480,7 @@ static int do_read_inode(struct inode *inode)
 	return 0;
 }
 
-struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
+struct inode *f2fs_iget_inner(struct super_block *sb, unsigned long ino)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct inode *inode;
@@ -568,6 +568,17 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	return ERR_PTR(ret);
 }
 
+struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
+{
+	int ret;
+
+	ret = f2fs_check_nid_range(F2FS_SB(sb), ino);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return f2fs_iget_inner(sb, ino);
+}
+
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
 {
 	struct inode *inode;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b8e5fe244596..a5f5e7483791 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4157,7 +4157,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_xattr_cache;
 
 	/* get an inode for meta space */
-	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
+	sbi->meta_inode = f2fs_iget_inner(sb, F2FS_META_INO(sbi));
 	if (IS_ERR(sbi->meta_inode)) {
 		f2fs_err(sbi, "Failed to read F2FS meta data inode");
 		err = PTR_ERR(sbi->meta_inode);
@@ -4265,7 +4265,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_nm;
 
 	/* get an inode for node space */
-	sbi->node_inode = f2fs_iget(sb, F2FS_NODE_INO(sbi));
+	sbi->node_inode = f2fs_iget_inner(sb, F2FS_NODE_INO(sbi));
 	if (IS_ERR(sbi->node_inode)) {
 		f2fs_err(sbi, "Failed to read node inode");
 		err = PTR_ERR(sbi->node_inode);
-- 
2.25.1

