Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50A05B00D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiIGJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGJrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDAF9D8E3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A48461847
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA80C433C1;
        Wed,  7 Sep 2022 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662544035;
        bh=wxDlJ0c4hKUVZs9suWhzzgYGQD2Bvgrvh0QGKG1hKb0=;
        h=From:To:Cc:Subject:Date:From;
        b=KzWTPFGlB0P12wKBjBa0PAsUsgQmI+XWbylhGg2ID3BaFeW+8gAMJxPyjMHw/G6M8
         hKWBXYwaVtUWIYMffQlH9KQsCNPVTLmrDUVe4jF5uayxgTvhwWITUrGXEDRTEzLKn2
         PzYybZytft/jRhtY38w3yviwzoCF7ij2E/gqgoH/SaBVQ+culyJ40YOJieRJHEpdmY
         7uEM9me+FXZjju3kW8rjTrqfdUfM1sxQw0BZia9VGkj05eLtekZRnUSEtyPeU1bNMA
         x42tYBDiR+NmJmF9BalC781hveOE0AKOTbBi693J0/Q/wx9NLwmyr9GSi4Z/5srRgQ
         BJkNt/w7e21uA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to do sanity on destination blkaddr during recovery
Date:   Wed,  7 Sep 2022 17:47:08 +0800
Message-Id: <20220907094708.3679424-1-chao@kernel.org>
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

As Wenqing Liu reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=216456

loop5: detected capacity change from 0 to 131072
F2FS-fs (loop5): recover_inode: ino = 6, name = hln, inline = 1
F2FS-fs (loop5): recover_data: ino = 6 (i_size: recover) err = 0
F2FS-fs (loop5): recover_inode: ino = 6, name = hln, inline = 1
F2FS-fs (loop5): recover_data: ino = 6 (i_size: recover) err = 0
F2FS-fs (loop5): recover_inode: ino = 6, name = hln, inline = 1
F2FS-fs (loop5): recover_data: ino = 6 (i_size: recover) err = 0
F2FS-fs (loop5): Bitmap was wrongly set, blk:5634
------------[ cut here ]------------
WARNING: CPU: 3 PID: 1013 at fs/f2fs/segment.c:2198
RIP: 0010:update_sit_entry+0xa55/0x10b0 [f2fs]
Call Trace:
 <TASK>
 f2fs_do_replace_block+0xa98/0x1890 [f2fs]
 f2fs_replace_block+0xeb/0x180 [f2fs]
 recover_data+0x1a69/0x6ae0 [f2fs]
 f2fs_recover_fsync_data+0x120d/0x1fc0 [f2fs]
 f2fs_fill_super+0x4665/0x61e0 [f2fs]
 mount_bdev+0x2cf/0x3b0
 legacy_get_tree+0xed/0x1d0
 vfs_get_tree+0x81/0x2b0
 path_mount+0x47e/0x19d0
 do_mount+0xce/0xf0
 __x64_sys_mount+0x12c/0x1a0
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

If we enable CONFIG_F2FS_CHECK_FS config, it will trigger a kernel panic
instead of warning.

The root cause is: in fuzzed image, SIT table is inconsistent with inode
mapping table, result in triggering such warning during SIT table update.

This patch introduces a new flag DATA_GENERIC_ENHANCE_UPDATE, w/ this
flag, data block recovery flow can check destination blkaddr's validation
in SIT table, and skip f2fs_replace_block() to avoid inconsistent status.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 10 +++++++++-
 fs/f2fs/f2fs.h       |  4 ++++
 fs/f2fs/recovery.c   |  8 ++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7bf1feb5ac78..dd7c7e7f2f4a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -140,7 +140,7 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 	unsigned int segno, offset;
 	bool exist;
 
-	if (type != DATA_GENERIC_ENHANCE && type != DATA_GENERIC_ENHANCE_READ)
+	if (type == DATA_GENERIC)
 		return true;
 
 	segno = GET_SEGNO(sbi, blkaddr);
@@ -148,6 +148,13 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 	se = get_seg_entry(sbi, segno);
 
 	exist = f2fs_test_bit(offset, se->cur_valid_map);
+	if (exist && type == DATA_GENERIC_ENHANCE_UPDATE) {
+		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
+			 blkaddr, exist);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		return exist;
+	}
+
 	if (!exist && type == DATA_GENERIC_ENHANCE) {
 		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
 			 blkaddr, exist);
@@ -185,6 +192,7 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 	case DATA_GENERIC:
 	case DATA_GENERIC_ENHANCE:
 	case DATA_GENERIC_ENHANCE_READ:
+	case DATA_GENERIC_ENHANCE_UPDATE:
 		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
 				blkaddr < MAIN_BLKADDR(sbi))) {
 			f2fs_warn(sbi, "access invalid blkaddr:%u",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 35f9e1a6a1bf..baf621ca2fe7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -266,6 +266,10 @@ enum {
 					 * condition of read on truncated area
 					 * by extent_cache
 					 */
+	DATA_GENERIC_ENHANCE_UPDATE,	/*
+					 * strong check on range and segment
+					 * bitmap for update case
+					 */
 	META_GENERIC,
 };
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index dcd0a1e35095..8326003e6918 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -698,6 +698,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 				goto err;
 			}
 
+			if (f2fs_is_valid_blkaddr(sbi, dest,
+					DATA_GENERIC_ENHANCE_UPDATE)) {
+				f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%lu, ofs:%u",
+					dest, inode->i_ino, dn.ofs_in_node);
+				err = -EFSCORRUPTED;
+				goto err;
+			}
+
 			/* write dummy data page */
 			f2fs_replace_block(sbi, &dn, src, dest,
 						ni.version, false, false);
-- 
2.25.1

