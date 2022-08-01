Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF25586DCB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiHAPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiHAPcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:32:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2A3C8D1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:32:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so12401331pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58O5KgclSAk428/9CaeCSINMTyAXe65Q2E+LYB9ZunI=;
        b=hdGwyLKhBSvFqSAdYtPM94obeKxxPB04Gd8llerE84DMUco0CBI7aO6kOydR7iXMUZ
         Dswr0RA0rGkgmDXtHrPifikjNl+kZ2wWbNr578RYodQuaELZ+MHByJ45k69DDYY+jqoU
         6NIEr/5KMAUyCoGBlJ9r5uiVME0BWgKDLNO7WTyBkcwoyVxkHND0qZpGuPyXzS46JVP9
         Y9GRen1RyqRfxufkXx6VgoI19ug3g7bMBzpdnOloi1JpQ3LZ+0k7lVkfMeaz7dZXncR4
         Sl9G0+sf7397D4/y34XkPq3AqhliHzAsQRtQBUEb7dgvZIZwK1rS67VMSzaWDzqonvaU
         m+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58O5KgclSAk428/9CaeCSINMTyAXe65Q2E+LYB9ZunI=;
        b=Jtf4hyce7QdbFuyAi1YQc1wZHpto3+bQBaPilKLo4P5b8l0pdzUPKR1js0vpLgpTWN
         7thzw6vGbukR0G3cOcbNsoeBiyzY73gRy/Yvl4ehrna3RtdYoOB3vUNbxdFHOvMRilH0
         H+zvD2hHOSNG4r+7hkqr8Baj7iPFPbFc3P24ZTja/cXxKgZ6mInuuNIJ8GdyPnJZnkCg
         m+qCDjfELUeMvNzSFtI2kZy134y65d8KC0F3y7KATOGyR3uFutFQRbeRhZa2/tIWQxs6
         KecaSM9JeOehmuJiW1XR/lFZz6uY7JG1nOBB3NpPRITGEBuv4WRgmYraEccTTRp/sm9S
         N4Bg==
X-Gm-Message-State: ACgBeo3OSN7Y8Ob7lnx/afoqAlQ7jLsO0vl8wx71qstpvuMZ+Ki3VYl4
        PW26sw00fNjPCyusnYJzb8IJeZKgof0=
X-Google-Smtp-Source: AA6agR5gkZgEDh+ByjvltOTflhYu2NZpoFfNr1gH/P2+w9XXvDMzj9xsh4Of9PunRrF7LwjhQWb6BA==
X-Received: by 2002:a17:90b:33cd:b0:1f0:3655:17a8 with SMTP id lk13-20020a17090b33cd00b001f0365517a8mr19555757pjb.33.1659367932472;
        Mon, 01 Aug 2022 08:32:12 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:7c40:5eed:9318:104a])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b0016bff65d5cbsm9907113plg.194.2022.08.01.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 08:32:12 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH] f2fs: fix null inode reference when FG GC for atomic file
Date:   Mon,  1 Aug 2022 08:32:09 -0700
Message-Id: <20220801153209.1653546-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Fixed null inode reference when doing foreground GC for data segments of
COW inodes.

Below is a finding by Ye Bin <yebin10@huawei.com>.

There is issue as follows when test f2fs atomic write:
F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th superblock
F2FS-fs (loop0): invalid crc_offset: 0
F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=1, run fsck to fix.
F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=2, run fsck to fix.
==================================================================
BUG: KASAN: null-ptr-deref in f2fs_get_dnode_of_data+0xac/0x16d0
Read of size 8 at addr 0000000000000028 by task rep/1990

CPU: 4 PID: 1990 Comm: rep Not tainted 5.19.0-rc6-next-20220715 #266
Call Trace:
 <TASK>
 dump_stack_lvl+0x6e/0x91
 print_report.cold+0x49a/0x6bb
 kasan_report+0xa8/0x130
 f2fs_get_dnode_of_data+0xac/0x16d0
 f2fs_do_write_data_page+0x2a5/0x1030
 move_data_page+0x3c5/0xdf0
 do_garbage_collect+0x2015/0x36c0
 f2fs_gc+0x554/0x1d30
 f2fs_balance_fs+0x7f5/0xda0
 f2fs_write_single_data_page+0xb66/0xdc0
 f2fs_write_cache_pages+0x716/0x1420
 f2fs_write_data_pages+0x84f/0x9a0
 do_writepages+0x130/0x3a0
 filemap_fdatawrite_wbc+0x87/0xa0
 file_write_and_wait_range+0x157/0x1c0
 f2fs_do_sync_file+0x206/0x12d0
 f2fs_sync_file+0x99/0xc0
 vfs_fsync_range+0x75/0x140
 f2fs_file_write_iter+0xd7b/0x1850
 vfs_write+0x645/0x780
 ksys_write+0xf1/0x1e0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

As the previous commit changed atomic write way which new a cow_inode for
atomic write file, and also mark cow_inode as FI_ATOMIC_FILE.
When f2fs_do_write_data_page write cow_inode will use cow_inode's cow_inode
which is NULL. Then will trigger null-ptr-deref.
To solve above issue, don't mark cow_inode as FI_ATOMIC_FILE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
Fiexes: 3db1de0e582c("f2fs: change the current atomic write way")
---
 fs/f2fs/f2fs.h    | 6 ++++++
 fs/f2fs/file.c    | 2 +-
 fs/f2fs/segment.c | 4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ecd870e5d6da..3bc69bb36cb4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -757,6 +757,7 @@ enum {
 	FI_ENABLE_COMPRESS,	/* enable compression in "user" compression mode */
 	FI_COMPRESS_RELEASED,	/* compressed blocks were released */
 	FI_ALIGNED_WRITE,	/* enable aligned write */
+	FI_COW_FILE,		/* indicate copy-on-write file for atomic write */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -3236,6 +3237,11 @@ static inline bool f2fs_is_atomic_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_ATOMIC_FILE);
 }
 
+static inline bool f2fs_is_cow_file(struct inode *inode)
+{
+	return is_inode_flag_set(inode, FI_COW_FILE);
+}
+
 static inline bool f2fs_is_first_block_written(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_FIRST_BLOCK_WRITTEN);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8098ed890e94..9a3571e6f564 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2061,7 +2061,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 
 	set_inode_flag(inode, FI_ATOMIC_FILE);
-	set_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
+	set_inode_flag(fi->cow_inode, FI_COW_FILE);
 	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7b1d2c29aba6..f14c5a807312 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -193,7 +193,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (f2fs_is_atomic_file(inode)) {
 		if (clean)
 			truncate_inode_pages_final(inode->i_mapping);
-		clear_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
+		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
 		iput(fi->cow_inode);
 		fi->cow_inode = NULL;
 		release_atomic_write_cnt(inode);
@@ -3172,7 +3172,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			return CURSEG_COLD_DATA;
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
-				f2fs_is_atomic_file(inode))
+				f2fs_is_cow_file(inode))
 			return CURSEG_HOT_DATA;
 		return f2fs_rw_hint_to_seg_type(inode->i_write_hint);
 	} else {
-- 
2.37.1.455.g008518b4e5-goog

