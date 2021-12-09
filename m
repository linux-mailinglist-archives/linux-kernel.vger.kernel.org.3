Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052DE46F34D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhLISqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:46:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36768 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLISqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:46:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7BBB5CE27D3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 18:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97946C004DD;
        Thu,  9 Dec 2021 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639075356;
        bh=QiKstchJv+BrfI7jqC+XbVfFY9A5AR8xbhxUveQsJ84=;
        h=From:To:Cc:Subject:Date:From;
        b=RsQ6rNaDnRFnzSOu5reHuT5fA0es2TDMLC/VPNkc+94ULWCynlolNYOn/jz4UkaSz
         KcoLCkFBv5CQPqtf3i/tOQVipMZp32kp/BjOw2qUgp4CXPIQGFdxh1cNLy3GhXQRvH
         hirZ2p7YC13HbZBrZ/yCfgWxx6xGGCcYQNVt7zpu0BEGPmLEN1v+qKTSrDSWJ4PvCm
         lJX60yzsL4Zagdhztx9PFehYA8QUAOYV6LiOtkXEtqtBUqKMPQX1mTcodxFuesp82j
         tTdiqmzoG6a8ucKYmIxjLYUvLx7+G6mL4nWaKJKbRuVkTPcyPqt22ATNgZDxFIks+K
         eBlSFnAGbiNng==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid EINVAL by SBI_NEED_FSCK when pinning a file
Date:   Thu,  9 Dec 2021 10:42:34 -0800
Message-Id: <20211209184234.2583205-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Android OTA failed due to SBI_NEED_FSCK flag when pinning the file. Let's avoid
it since we can do in-place-updates.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Change-Id: I3fd33c984417c10b38e23de6cec017b03d588945
---
 fs/f2fs/data.c |  7 +++++--
 fs/f2fs/file.c | 10 +++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a9652a8e669b..40c0d1426a11 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2525,6 +2525,11 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
+	/* The below cases were checked when setting it. */
+	if (f2fs_is_pinned_file(inode))
+		return false;
+	if (fio && is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+		return true;
 	if (f2fs_lfs_mode(sbi))
 		return true;
 	if (S_ISDIR(inode->i_mode))
@@ -2533,8 +2538,6 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (f2fs_is_atomic_file(inode))
 		return true;
-	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
-		return true;
 
 	/* swap file is migrating in aligned write mode */
 	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a15f8ba239f0..5ec6bef3937f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3145,17 +3145,17 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
-	if (f2fs_should_update_outplace(inode, NULL)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if (!pin) {
 		clear_inode_flag(inode, FI_PIN_FILE);
 		f2fs_i_gc_failures_write(inode, 0);
 		goto done;
 	}
 
+	if (f2fs_should_update_outplace(inode, NULL)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (f2fs_pin_file_control(inode, false)) {
 		ret = -EAGAIN;
 		goto out;
-- 
2.34.1.173.g76aa8bc2d0-goog

