Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A82527743
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 13:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiEOLRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiEOLRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 07:17:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA84659D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 04:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0DCB60F4F
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B4AC385B8;
        Sun, 15 May 2022 11:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652613430;
        bh=d0TL17vMLRIGLh71PguP2wy7GGGqSL/xy2fQvHsvOL8=;
        h=From:To:Cc:Subject:Date:From;
        b=GrxZnQJi8vwlTzhfuxKigVFdkojTW2WthcuhEjXg/rKT5DICe8fYB8XsJSBQQTfI+
         MeEFoOv1vX6QEoBfYMJVYdNeELfOQlrEb3aI5F+mYAkxC1+TWt6oRuAy3cHk9Ckcjq
         bJ//p5emIVWUV+IF2sFSXQu5I2o9BamNlTdYpkfCzmYRz0uVYrI+uot0e40yhNaajY
         n6JW1ipf1+iI4l76ol3h7R4UuFBIR5gt7q8XzHYPPaRgoVTYh+k9YFAHPbpcdHqEBS
         LHk5BX2Rh9AKUFSri2SIYAsImfU8qxpFqLeEqMwK7R1lp9Galn/jkmv4eus6WoZMBl
         1uEcdAlwtcTdw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH v2] f2fs: separate NOCoW and pinfile semantics
Date:   Sun, 15 May 2022 18:39:34 +0800
Message-Id: <20220515103934.5306-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

After commit 5d539245cb18 ("f2fs: export FS_NOCOW_FL flag to user"),
Pin_file and NOCoW flags have already been twined closely. e.g.
once we set pinfile flag in file, nocow flag will be shown; and after
clearing pinfile flag, nocow flag will disappear.

So, in order to keep backward compatibility, let use below semantics:

f2fs_ioc_set_pin_file/f2fs_fileattr_set logic:
		pinfile			nocow
set		set pinfile | nocow	set nocow
clear		clear pinfile | nocow	clear nocow

File Behaviors:
w/ pinfile, w/ nocow:		use pinfile semantics
w/ pinfile, w/o nocow:		use pinfile semantics
w/o pinfile, w/ nocow:		use nocow semantics
w/o pinfile, w/o nocow:		no pinfile or nocow semantics

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
v2:
- keep compatibility in between pinfile and nocow flags
 fs/f2fs/data.c |  3 ++-
 fs/f2fs/f2fs.h |  8 +++++++-
 fs/f2fs/file.c | 16 +++++++++++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

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
index 18a0335799ad..d9445fc62bd7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2929,6 +2929,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_NOCOMP_FL			0x00000400 /* Don't compress */
 #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
+#define F2FS_NOCOW_FL			0x00800000 /* Do not cow file */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
 
@@ -2965,9 +2966,14 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 		if (set)
 			return;
 		fallthrough;
+	case FI_PIN_FILE:
+		if (set)
+			F2FS_I(inode)->i_flags |= F2FS_NOCOW_FL;
+		else
+			F2FS_I(inode)->i_flags &= ~F2FS_NOCOW_FL;
+		fallthrough;
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
-	case FI_PIN_FILE:
 	case FI_COMPRESS_RELEASED:
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b857384ccd12..da635a904e69 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1854,6 +1854,18 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	if (IS_NOQUOTA(inode))
 		return -EPERM;
 
+	if ((iflags ^ masked_flags) & F2FS_NOCOW_FL) {
+		int ret;
+
+		if (!S_ISREG(inode->i_mode))
+			return -EINVAL;
+		if (f2fs_should_update_outplace(inode, NULL))
+			return -EINVAL;
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			return ret;
+	}
+
 	if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
 		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
 			return -EOPNOTSUPP;
@@ -1929,6 +1941,7 @@ static const struct {
 	{ F2FS_NOCOMP_FL,	FS_NOCOMP_FL },
 	{ F2FS_INDEX_FL,	FS_INDEX_FL },
 	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
+	{ F2FS_NOCOW_FL,	FS_NOCOW_FL },
 	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
 	{ F2FS_CASEFOLD_FL,	FS_CASEFOLD_FL },
 };
@@ -1960,7 +1973,8 @@ static const struct {
 		FS_NOCOMP_FL |		\
 		FS_DIRSYNC_FL |		\
 		FS_PROJINHERIT_FL |	\
-		FS_CASEFOLD_FL)
+		FS_CASEFOLD_FL |	\
+		FS_NOCOW_FL)
 
 /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
 static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
-- 
2.32.0

