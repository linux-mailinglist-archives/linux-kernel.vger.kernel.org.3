Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378A54FFAA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiDMPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbiDMPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7436262
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D537761DAB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 15:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A37EC385A4;
        Wed, 13 Apr 2022 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649864962;
        bh=rYLGXIpB12ST+Babui2aYL7ah1DI8YjqH2/JvSIYjEo=;
        h=From:To:Cc:Subject:Date:From;
        b=YSMjDAd6mAh74VfoYdtiMyGXlYez7jk0UIELx+kZbh0JCrLX2LoVYiTSRLDIQSNgD
         L2o4xlIbG9mCmLC1zhZiEcvUT0BuIy9XeIvgVzIkCSvOy6CRRvhDnMdTcz3b9JX6iN
         1LagXRzTXH4dDA5Kg9UMqymwNhfB+O/tU1sIPgTwDcAOIpcRdMYsCJGdwD5aw/BjaJ
         PY+Gi31UdeQo8P+cwu6+tRzJbkZbnj8lkTIimMnyfC1xeBujmAKku4nfz7obPqZGD8
         4h53duXTLw/6C0nS/fBuFTq5BzK2sybAW0Vm42OvhCJMrTJ3uQZhMoekTqIJX1pAqQ
         /jwrptYW3r6aw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: remove obsolete whint_mode
Date:   Wed, 13 Apr 2022 08:49:19 -0700
Message-Id: <20220413154920.2024872-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
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

This patch removes obsolete whint_mode.

Fixes: commit 41d36a9f3e53 ("fs: remove kiocb.ki_hint")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.rst | 70 ----------------------
 fs/f2fs/f2fs.h                     |  3 -
 fs/f2fs/segment.c                  | 95 ------------------------------
 fs/f2fs/super.c                    | 31 +---------
 4 files changed, 1 insertion(+), 198 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 4a2426f0485a..ad8dc8c040a2 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -235,12 +235,6 @@ offgrpjquota		 Turn off group journalled quota.
 offprjjquota		 Turn off project journalled quota.
 quota			 Enable plain user disk quota accounting.
 noquota			 Disable all plain disk quota option.
-whint_mode=%s		 Control which write hints are passed down to block
-			 layer. This supports "off", "user-based", and
-			 "fs-based".  In "off" mode (default), f2fs does not pass
-			 down hints. In "user-based" mode, f2fs tries to pass
-			 down hints given by users. And in "fs-based" mode, f2fs
-			 passes down hints with its policy.
 alloc_mode=%s		 Adjust block allocation policy, which supports "reuse"
 			 and "default".
 fsync_mode=%s		 Control the policy of fsync. Currently supports "posix",
@@ -751,70 +745,6 @@ In order to identify whether the data in the victim segment are valid or not,
 F2FS manages a bitmap. Each bit represents the validity of a block, and the
 bitmap is composed of a bit stream covering whole blocks in main area.
 
-Write-hint Policy
------------------
-
-1) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET.
-
-2) whint_mode=user-based. F2FS tries to pass down hints given by
-users.
-
-===================== ======================== ===================
-User                  F2FS                     Block
-===================== ======================== ===================
-N/A                   META                     WRITE_LIFE_NOT_SET
-N/A                   HOT_NODE                 "
-N/A                   WARM_NODE                "
-N/A                   COLD_NODE                "
-ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
-extension list        "                        "
-
--- buffered io
-WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
-WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
-WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
-WRITE_LIFE_NONE       "                        "
-WRITE_LIFE_MEDIUM     "                        "
-WRITE_LIFE_LONG       "                        "
-
--- direct io
-WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
-WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
-WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
-WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
-WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
-WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
-===================== ======================== ===================
-
-3) whint_mode=fs-based. F2FS passes down hints with its policy.
-
-===================== ======================== ===================
-User                  F2FS                     Block
-===================== ======================== ===================
-N/A                   META                     WRITE_LIFE_MEDIUM;
-N/A                   HOT_NODE                 WRITE_LIFE_NOT_SET
-N/A                   WARM_NODE                "
-N/A                   COLD_NODE                WRITE_LIFE_NONE
-ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
-extension list        "                        "
-
--- buffered io
-WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
-WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
-WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_LONG
-WRITE_LIFE_NONE       "                        "
-WRITE_LIFE_MEDIUM     "                        "
-WRITE_LIFE_LONG       "                        "
-
--- direct io
-WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
-WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
-WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
-WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
-WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
-WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
-===================== ======================== ===================
-
 Fallocate(2) Policy
 -------------------
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f793bbe1e6ce..d76afbb8efdf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -154,7 +154,6 @@ struct f2fs_mount_info {
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	/* For which write hints are passed down to block layer */
-	int whint_mode;
 	int alloc_mode;			/* segment allocation policy */
 	int fsync_mode;			/* fsync policy */
 	int fs_mode;			/* fs mode: LFS or ADAPTIVE */
@@ -3640,8 +3639,6 @@ void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init f2fs_create_segment_manager_caches(void);
 void f2fs_destroy_segment_manager_caches(void);
 int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
-enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
-			enum page_type type, enum temp_type temp);
 unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 			unsigned int segno);
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a6bb46ccbac2..6d6f7b4e907b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3110,101 +3110,6 @@ int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
 	}
 }
 
-/* This returns write hints for each segment type. This hints will be
- * passed down to block layer. There are mapping tables which depend on
- * the mount option 'whint_mode'.
- *
- * 1) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET.
- *
- * 2) whint_mode=user-based. F2FS tries to pass down hints given by users.
- *
- * User                  F2FS                     Block
- * ----                  ----                     -----
- *                       META                     WRITE_LIFE_NOT_SET
- *                       HOT_NODE                 "
- *                       WARM_NODE                "
- *                       COLD_NODE                "
- * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
- * extension list        "                        "
- *
- * -- buffered io
- * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
- * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
- * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
- * WRITE_LIFE_NONE       "                        "
- * WRITE_LIFE_MEDIUM     "                        "
- * WRITE_LIFE_LONG       "                        "
- *
- * -- direct io
- * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
- * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
- * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
- * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
- * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
- * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
- *
- * 3) whint_mode=fs-based. F2FS passes down hints with its policy.
- *
- * User                  F2FS                     Block
- * ----                  ----                     -----
- *                       META                     WRITE_LIFE_MEDIUM;
- *                       HOT_NODE                 WRITE_LIFE_NOT_SET
- *                       WARM_NODE                "
- *                       COLD_NODE                WRITE_LIFE_NONE
- * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
- * extension list        "                        "
- *
- * -- buffered io
- * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
- * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
- * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_LONG
- * WRITE_LIFE_NONE       "                        "
- * WRITE_LIFE_MEDIUM     "                        "
- * WRITE_LIFE_LONG       "                        "
- *
- * -- direct io
- * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
- * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
- * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
- * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
- * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
- * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
- */
-
-enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
-				enum page_type type, enum temp_type temp)
-{
-	if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_USER) {
-		if (type == DATA) {
-			if (temp == WARM)
-				return WRITE_LIFE_NOT_SET;
-			else if (temp == HOT)
-				return WRITE_LIFE_SHORT;
-			else if (temp == COLD)
-				return WRITE_LIFE_EXTREME;
-		} else {
-			return WRITE_LIFE_NOT_SET;
-		}
-	} else if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_FS) {
-		if (type == DATA) {
-			if (temp == WARM)
-				return WRITE_LIFE_LONG;
-			else if (temp == HOT)
-				return WRITE_LIFE_SHORT;
-			else if (temp == COLD)
-				return WRITE_LIFE_EXTREME;
-		} else if (type == NODE) {
-			if (temp == WARM || temp == HOT)
-				return WRITE_LIFE_NOT_SET;
-			else if (temp == COLD)
-				return WRITE_LIFE_NONE;
-		} else if (type == META) {
-			return WRITE_LIFE_MEDIUM;
-		}
-	}
-	return WRITE_LIFE_NOT_SET;
-}
-
 static int __get_segment_type_2(struct f2fs_io_info *fio)
 {
 	if (fio->type == DATA)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fb8fea9f703a..6ab39bf36761 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -214,7 +214,6 @@ static match_table_t f2fs_tokens = {
 	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
-	{Opt_whint, "whint_mode=%s"},
 	{Opt_alloc, "alloc_mode=%s"},
 	{Opt_fsync, "fsync_mode=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption=%s"},
@@ -975,22 +974,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			f2fs_info(sbi, "quota operations not supported");
 			break;
 #endif
-		case Opt_whint:
-			name = match_strdup(&args[0]);
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "user-based")) {
-				F2FS_OPTION(sbi).whint_mode = WHINT_MODE_USER;
-			} else if (!strcmp(name, "off")) {
-				F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
-			} else if (!strcmp(name, "fs-based")) {
-				F2FS_OPTION(sbi).whint_mode = WHINT_MODE_FS;
-			} else {
-				kfree(name);
-				return -EINVAL;
-			}
-			kfree(name);
-			break;
 		case Opt_alloc:
 			name = match_strdup(&args[0]);
 			if (!name)
@@ -1328,12 +1311,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
-	/* Not pass down write hints if the number of active logs is lesser
-	 * than NR_CURSEG_PERSIST_TYPE.
-	 */
-	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_PERSIST_TYPE)
-		F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
-
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
@@ -1974,10 +1951,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",prjquota");
 #endif
 	f2fs_show_quota_options(seq, sbi->sb);
-	if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_USER)
-		seq_printf(seq, ",whint_mode=%s", "user-based");
-	else if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_FS)
-		seq_printf(seq, ",whint_mode=%s", "fs-based");
 
 	fscrypt_show_test_dummy_encryption(seq, ',', sbi->sb);
 
@@ -2029,7 +2002,6 @@ static void default_options(struct f2fs_sb_info *sbi)
 		F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
 
 	F2FS_OPTION(sbi).inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
-	F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
 	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
 	F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
 	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
@@ -2310,8 +2282,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
-	if (*flags & SB_RDONLY ||
-		F2FS_OPTION(sbi).whint_mode != org_mount_opt.whint_mode) {
+	if (*flags & SB_RDONLY) {
 		sync_inodes_sb(sb);
 
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
-- 
2.36.0.rc0.470.gd361397f0d-goog

