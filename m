Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81C85522CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbiFTRiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiFTRis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:38:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B6E9FF6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:38:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso10110202pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkxuUdoBKH6pPxKTI0fRy8LqcjRJrSIkdt2qKGUgvrk=;
        b=SILLAXN7WMUOUoGPfiug7fjBfpf/5bu3meLBvf6cLyHMwnd8UH+yepwVnkQ4y1sfBU
         oU7mL7iWp39B50z2Ce8YT9nZYIP+qmRhs7v897Ap2zRKVNWJKiA90NouMzDHdKX/vIqB
         CDtGjTAme3tic1fC08U0CqhyLQ2mDDI6aquHe4agHcI6tfIh1C/R6vE8Wppt47Zn/0Dm
         24uMzHC4GZSbT+fsBz7AC+Upo07/S6tWzB+fwGooUS2V/5EtXETKXX6ryeUu9DtPWREy
         /wowA1H95kDd4JS0pjaUW7XYHwrCCsX83EKghRI5Qg0wdYIzNqpwOw5yUkvF1IMzJfVS
         sS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkxuUdoBKH6pPxKTI0fRy8LqcjRJrSIkdt2qKGUgvrk=;
        b=GH8ca0dtTOJRWlABW0+Oip7/Wa1F5mP45+pL+jDmn3lPnaB1NzrZN4Ef3TtBT3YK7S
         xXX8TYeijKZvJysmptzy/0gqLbhWFz2ZmxJpVvyhNTlnq3l9vQSukk70buWtuF6yaQqc
         W5lqw9Js1tntqVxXmkLidFs+SuMypo6nljeawhZx8oWu73kZCNd+FRqnkskWaRT4mpem
         IoeH46CAJE70zVpy9qxEtGNUKk5FMtpFxKwz+1FkYY7+h9Pb37aUMT8sMglnr/rCX5e4
         ro1BGQLIF5M9cPFVdG9BRlw20r/G1XXZ/MocUqP3eAeYhIiLsfuuTIMV+ai/mNJAzBpe
         1csg==
X-Gm-Message-State: AJIora9n1L3Y1w8MK1IQRgo+NqR0KvVu2XAIeCmZibaB1tkFQgYnO5Y1
        eXAf5drQ5imCh36O9CJkxOl4GRRuQz0=
X-Google-Smtp-Source: AGRyM1scAwUS1BBCT1XfPyX+ZzuLCIGM/DPTsyAo5YYquMdm5T+wMxmUmZKktKb5VQgIc0UbCjE0gw==
X-Received: by 2002:a17:90b:1d02:b0:1e6:961d:d56f with SMTP id on2-20020a17090b1d0200b001e6961dd56fmr28428340pjb.225.1655746727026;
        Mon, 20 Jun 2022 10:38:47 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:1db8:e686:ccbc:a11b])
        by smtp.gmail.com with ESMTPSA id f185-20020a62dbc2000000b0051868677e6dsm373268pfg.51.2022.06.20.10.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:38:46 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] f2fs: introduce memory mode
Date:   Mon, 20 Jun 2022 10:38:42 -0700
Message-Id: <20220620173843.1462198-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Introduce memory mode to supports "normal" and "low" memory modes.
"low" mode is to support low memory devices. Because of the nature of
low memory devices, in this mode, f2fs will try to save memory sometimes
by sacrificing performance. "normal" mode is the default mode and same
as before.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/filesystems/f2fs.rst |  5 +++++
 fs/f2fs/f2fs.h                     | 13 +++++++++++++
 fs/f2fs/super.c                    | 24 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index ad8dc8c040a2..2965601e21bb 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -336,6 +336,11 @@ discard_unit=%s		 Control discard unit, the argument can be "block", "segment"
 			 default, it is helpful for large sized SMR or ZNS devices to
 			 reduce memory cost by getting rid of fs metadata supports small
 			 discard.
+memory=%s		 Control memory mode. This supports "normal" and "low" modes.
+			 "low" mode is introduced to support low memory devices.
+			 Because of the nature of low memory devices, in this mode, f2fs
+			 will try to save memory sometimes by sacrificing performance.
+			 "normal" mode is the default mode and same as before.
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d9bbecd008d2..fea97093d927 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -159,6 +159,7 @@ struct f2fs_mount_info {
 	int fsync_mode;			/* fsync policy */
 	int fs_mode;			/* fs mode: LFS or ADAPTIVE */
 	int bggc_mode;			/* bggc mode: off, on or sync */
+	int memory_mode;		/* memory mode */
 	int discard_unit;		/*
 					 * discard command's offset/size should
 					 * be aligned to this unit: block,
@@ -1360,6 +1361,13 @@ enum {
 	DISCARD_UNIT_SECTION,	/* basic discard unit is section */
 };
 
+enum {
+	MEMORY_MODE_NORMAL,	/* memory mode for normal devices */
+	MEMORY_MODE_LOW,	/* memory mode for low memry devices */
+};
+
+
+
 static inline int f2fs_test_bit(unsigned int nr, char *addr);
 static inline void f2fs_set_bit(unsigned int nr, char *addr);
 static inline void f2fs_clear_bit(unsigned int nr, char *addr);
@@ -4398,6 +4406,11 @@ static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
 }
 
+static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW;
+}
+
 static inline bool f2fs_may_compress(struct inode *inode)
 {
 	if (IS_SWAPFILE(inode) || f2fs_is_pinned_file(inode) ||
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3112fe92f934..cf9cf24f9b56 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -160,6 +160,7 @@ enum {
 	Opt_gc_merge,
 	Opt_nogc_merge,
 	Opt_discard_unit,
+	Opt_memory_mode,
 	Opt_err,
 };
 
@@ -236,6 +237,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_gc_merge, "gc_merge"},
 	{Opt_nogc_merge, "nogc_merge"},
 	{Opt_discard_unit, "discard_unit=%s"},
+	{Opt_memory_mode, "memory=%s"},
 	{Opt_err, NULL},
 };
 
@@ -1235,6 +1237,22 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			}
 			kfree(name);
 			break;
+		case Opt_memory_mode:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "normal")) {
+				F2FS_OPTION(sbi).memory_mode =
+						MEMORY_MODE_NORMAL;
+			} else if (!strcmp(name, "low")) {
+				F2FS_OPTION(sbi).memory_mode =
+						MEMORY_MODE_LOW;
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -2006,6 +2024,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
 		seq_printf(seq, ",discard_unit=%s", "section");
 
+	if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_NORMAL)
+		seq_printf(seq, ",memory=%s", "normal");
+	else if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW)
+		seq_printf(seq, ",memory=%s", "low");
+
 	return 0;
 }
 
@@ -2027,6 +2050,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_ext_cnt = 0;
 	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
+	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
 
 	sbi->sb->s_flags &= ~SB_INLINECRYPT;
 
-- 
2.37.0.rc0.104.g0611611a94-goog

