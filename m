Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59EE4B5E39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiBNX13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:27:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBNX12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:27:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9222DE02E8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:27:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F0C2B80DCF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8FEC340E9;
        Mon, 14 Feb 2022 23:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644881236;
        bh=1rUwvY875LcPgPbddOenVKZ0pqUKLLYVQWdprK8vuL4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=sg5q9SmFqYCq11rnUvanZEhYF70xWXNghcej86iEvOPdn/vYIFSdX+F6od7INs+Gq
         8yCRumER+hZcvhojrZdS4vcXR3dY5YpuK92+RCfHXcC2XtqAToa9lg67NjItD+Bbh4
         ZZ6FeRyXnVykXry3LI0jGIo4j1vw35m5888XL11OicovXysXJUyqkYttapcRRKQZ2B
         GNaW3VI0NCQmoPYvQArKiJ7GZbbpHi0i/tFJFnI03PEYDjfO37Uw/AwBNtfNcYNjuw
         /oHTirlYJ+lLOxohfuZYSpjds1bRqH6oYxHDHglCz7sESUEMCtTDYwBEubm28X4nUT
         fFRE7svXBU6Dw==
Date:   Mon, 14 Feb 2022 15:27:15 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2 v2] f2fs: avoid an infinite loop in
 f2fs_sync_dirty_inodes
Message-ID: <YgrlUzJyvgrFSREc@google.com>
References: <20220212142023.2508247-1-jaegeuk@kernel.org>
 <20220212142023.2508247-2-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212142023.2508247-2-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one read IO is always failing, we can fall into an infinite loop in
f2fs_sync_dirty_inodes. This happens during xfstests/generic/475.

[  142.803335] Buffer I/O error on dev dm-1, logical block 8388592, async page read
...
[  382.887210]  submit_bio_noacct+0xdd/0x2a0
[  382.887213]  submit_bio+0x80/0x110
[  382.887223]  __submit_bio+0x4d/0x300 [f2fs]
[  382.887282]  f2fs_submit_page_bio+0x125/0x200 [f2fs]
[  382.887299]  __get_meta_page+0xc9/0x280 [f2fs]
[  382.887315]  f2fs_get_meta_page+0x13/0x20 [f2fs]
[  382.887331]  f2fs_get_node_info+0x317/0x3c0 [f2fs]
[  382.887350]  f2fs_do_write_data_page+0x327/0x6f0 [f2fs]
[  382.887367]  f2fs_write_single_data_page+0x5b7/0x960 [f2fs]
[  382.887386]  f2fs_write_cache_pages+0x302/0x890 [f2fs]
[  382.887405]  ? preempt_count_add+0x7a/0xc0
[  382.887408]  f2fs_write_data_pages+0xfd/0x320 [f2fs]
[  382.887425]  ? _raw_spin_unlock+0x1a/0x30
[  382.887428]  do_writepages+0xd3/0x1d0
[  382.887432]  filemap_fdatawrite_wbc+0x69/0x90
[  382.887434]  filemap_fdatawrite+0x50/0x70
[  382.887437]  f2fs_sync_dirty_inodes+0xa4/0x270 [f2fs]
[  382.887453]  f2fs_write_checkpoint+0x189/0x1640 [f2fs]
[  382.887469]  ? schedule_timeout+0x114/0x150
[  382.887471]  ? ttwu_do_activate+0x6d/0xb0
[  382.887473]  ? preempt_count_add+0x7a/0xc0
[  382.887476]  kill_f2fs_super+0xca/0x100 [f2fs]
[  382.887491]  deactivate_locked_super+0x35/0xa0
[  382.887494]  deactivate_super+0x40/0x50
[  382.887497]  cleanup_mnt+0x139/0x190
[  382.887499]  __cleanup_mnt+0x12/0x20
[  382.887501]  task_work_run+0x64/0xa0
[  382.887505]  exit_to_user_mode_prepare+0x1b7/0x1c0
[  382.887508]  syscall_exit_to_user_mode+0x27/0x50
[  382.887510]  do_syscall_64+0x48/0xc0
[  382.887513]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Change log from v1:
  - fix a regression to report EIO too early

 fs/f2fs/checkpoint.c | 13 ++++++++-----
 fs/f2fs/f2fs.h       |  3 +++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 203a1577942d..56c81c68ef71 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1059,13 +1059,13 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 	struct inode *inode;
 	struct f2fs_inode_info *fi;
 	bool is_dir = (type == DIR_INODE);
-	unsigned long ino = 0;
+	unsigned long ino = 0, retry_count = DEFAULT_RETRY_SYNC_DIR_COUNT;
 
 	trace_f2fs_sync_dirty_inodes_enter(sbi->sb, is_dir,
 				get_pages(sbi, is_dir ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA));
 retry:
-	if (unlikely(f2fs_cp_error(sbi))) {
+	if (unlikely(f2fs_cp_error(sbi) || (is_dir && !retry_count))) {
 		trace_f2fs_sync_dirty_inodes_exit(sbi->sb, is_dir,
 				get_pages(sbi, is_dir ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA));
@@ -1096,10 +1096,13 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 
 		iput(inode);
 		/* We need to give cpu to another writers. */
-		if (ino == cur_ino)
-			cond_resched();
-		else
+		if (ino == cur_ino) {
+			retry_count--;
+			io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+		} else {
+			retry_count = DEFAULT_RETRY_SYNC_DIR_COUNT;
 			ino = cur_ino;
+		}
 	} else {
 		/*
 		 * We should submit bio, since it exists several
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c9515c3c54fd..f40ef7b61965 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -577,6 +577,9 @@ enum {
 /* maximum retry quota flush count */
 #define DEFAULT_RETRY_QUOTA_FLUSH_COUNT		8
 
+/* maximum retry sync dirty inodes */
+#define DEFAULT_RETRY_SYNC_DIR_COUNT	3000
+
 #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
 
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
-- 
2.35.1.265.g69c8d7142f-goog

