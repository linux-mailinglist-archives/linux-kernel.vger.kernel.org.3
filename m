Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FA75247C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351387AbiELIVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiELIV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:21:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9112160BB2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39C8AB826AF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88574C34100;
        Thu, 12 May 2022 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652343684;
        bh=LDuxo0C/j3JuilvCVq9g1dgYPVnODmnuaK6uUmG5w1Y=;
        h=From:To:Cc:Subject:Date:From;
        b=f+ogQxCHH3bdUp5bz/e462d+PUtXMQ3likb+EijEc9xeC8kgEH4R5YxnB/TH6E1tH
         C5HOTjnW5hzTSBIRHw22Hc9FPzpToGVs1BPc4iZvfkrRnRK4ygVzfuIJPfnXhKBwfN
         IRL4bkRhM49D72iH2W8U8aJBdVpbTMG67wBYjQzLH+mI5Z/6+av/EQY/DHSLqs+f4M
         5cZeZFKlvT/T8OyG2d/V0eYsFlcZ7N5dqrVnEzHLp6wYkylS8evSCGuPeNI7GaTb7G
         McA1FQOUh/tA1myBooo0uB5PZN69RhCFTbOgdMdgIp3/Ol/8GxTHOSl9OADqQg/ENA
         wKtne9jffTS7w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: separate NOCoW and pinfile semantics
Date:   Thu, 12 May 2022 16:21:16 +0800
Message-Id: <20220512082116.2991611-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinning a file is heavy, because skipping pinned files make GC
running with heavy load or no effect.

So that this patch proposes to separate nocow and pinfile semantics:
- NOCoW flag can only be set on regular file.
- NOCoW file will only trigger IPU at common writeback/flush.
- NOCow file will do OPU during GC.

This flag can satisfying the demand of:
1) avoiding fragment of file's physical block
2) userspace doesn't want to pin file's physical address

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/data.c |  3 ++-
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 25 ++++++++++++++++++++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 54a7a8ad994d..c8eab78f7d89 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2495,7 +2495,8 @@ bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
 	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
 		return false;
 
-	if (f2fs_is_pinned_file(inode))
+	if (f2fs_is_pinned_file(inode) ||
+			F2FS_I(inode)->i_flags & F2FS_NOCOW_FL)
 		return true;
 
 	/* if this is cold file, we should overwrite to avoid fragmentation */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 492af5b96de1..e91ece55f5e8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2916,6 +2916,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_NOCOMP_FL			0x00000400 /* Don't compress */
 #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
+#define F2FS_NOCOW_FL			0x00800000 /* Do not cow file */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 09287876dbb7..7f92a3a157f7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1851,6 +1851,20 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	if (IS_NOQUOTA(inode))
 		return -EPERM;
 
+	if ((iflags ^ masked_flags) & F2FS_NOCOW_FL) {
+		int ret;
+
+		if (!S_ISREG(inode->i_mode))
+			return -EINVAL;
+		if (f2fs_should_update_outplace(inode, NULL))
+			return -EINVAL;
+		if (f2fs_is_pinned_file(inode))
+			return -EINVAL;
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			return ret;
+	}
+
 	if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
 		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
 			return -EOPNOTSUPP;
@@ -1926,6 +1940,7 @@ static const struct {
 	{ F2FS_NOCOMP_FL,	FS_NOCOMP_FL },
 	{ F2FS_INDEX_FL,	FS_INDEX_FL },
 	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
+	{ F2FS_NOCOW_FL,	FS_NOCOW_FL },
 	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
 	{ F2FS_CASEFOLD_FL,	FS_CASEFOLD_FL },
 };
@@ -1957,7 +1972,8 @@ static const struct {
 		FS_NOCOMP_FL |		\
 		FS_DIRSYNC_FL |		\
 		FS_PROJINHERIT_FL |	\
-		FS_CASEFOLD_FL)
+		FS_CASEFOLD_FL |	\
+		FS_NOCOW_FL)
 
 /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
 static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
@@ -3081,6 +3097,13 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
+	if (F2FS_I(inode)->i_flags & F2FS_NOCOW_FL) {
+		f2fs_info(F2FS_I_SB(inode), "inode (%lu) is already NOCOW one",
+			inode->i_ino);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!pin) {
 		clear_inode_flag(inode, FI_PIN_FILE);
 		f2fs_i_gc_failures_write(inode, 0);
-- 
2.25.1

