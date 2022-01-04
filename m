Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD94849C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiADVYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiADVYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:24:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D83C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 13:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99BA4615B6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 21:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB919C36AF2;
        Tue,  4 Jan 2022 21:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641331472;
        bh=YiWOX5NHugXaDJT6Ol1nD26li2vyW4k8fkEADYyvcpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/XeR0ge7IecEcEoypLgMUedgfPysRkHsJRD3+yW2ljdA8Q2wPGq71noN3eDTlbc6
         2/SAMRrXCjndlnTeiGs+bFaroRXJjwqWY64h9LQDmejyaR8NOdEQJubQTAiJVqCRzE
         ZoF0f6h1DUEAScti5ZLYnfuVFmHnOHD20GcTCgMlW0xQES0vF7pJVcjB6eRwACRImo
         EdBBH/cohz5xgJm70PGj4ofxBeyVXqzR6aBk3MM/xBexAfPacmjIdbZy3F7T1EYirf
         NIVEgZOstRMqeuz+Kp0W1HFGhBsQ6OuLq8F/GxxvawQbeqrB2gXXM3Az/KpJTzjFOo
         If7JG/hGy+wdA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Eric Biggers <ebiggers@google.com>, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/6] f2fs: reduce indentation in f2fs_file_write_iter()
Date:   Tue,  4 Jan 2022 13:24:15 -0800
Message-Id: <20220104212419.1879225-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104212419.1879225-1-jaegeuk@kernel.org>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Replace 'if (ret > 0)' with 'if (ret <= 0) goto out_unlock;'.
No change in behavior.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fc87d0f5b82b..808a7c24d993 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4338,44 +4338,48 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	ret = generic_write_checks(iocb, from);
-	if (ret > 0) {
-		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (!f2fs_overwrite_io(inode, iocb->ki_pos,
-						iov_iter_count(from)) ||
+	if (ret <= 0)
+		goto out_unlock;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!f2fs_overwrite_io(inode, iocb->ki_pos,
+					iov_iter_count(from)) ||
 				f2fs_has_inline_data(inode) ||
 				f2fs_force_buffered_io(inode, iocb, from)) {
-				ret = -EAGAIN;
-				goto out_unlock;
-			}
-		}
-		if (iocb->ki_flags & IOCB_DIRECT) {
-			ret = f2fs_convert_inline_inode(inode);
-			if (ret)
-				goto out_unlock;
-		}
-		/* Possibly preallocate the blocks for the write. */
-		target_size = iocb->ki_pos + iov_iter_count(from);
-		preallocated = f2fs_preallocate_blocks(iocb, from);
-		if (preallocated < 0) {
-			ret = preallocated;
+			ret = -EAGAIN;
 			goto out_unlock;
 		}
+	}
 
-		ret = __generic_file_write_iter(iocb, from);
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			goto out_unlock;
+	}
+	/* Possibly preallocate the blocks for the write. */
+	target_size = iocb->ki_pos + iov_iter_count(from);
+	preallocated = f2fs_preallocate_blocks(iocb, from);
+	if (preallocated < 0) {
+		ret = preallocated;
+		goto out_unlock;
+	}
 
-		/* Don't leave any preallocated blocks around past i_size. */
-		if (preallocated > 0 && i_size_read(inode) < target_size) {
-			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			filemap_invalidate_lock(inode->i_mapping);
-			f2fs_truncate(inode);
-			filemap_invalidate_unlock(inode->i_mapping);
-			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-		}
-		clear_inode_flag(inode, FI_PREALLOCATED_ALL);
+	ret = __generic_file_write_iter(iocb, from);
 
-		if (ret > 0)
-			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
+	/* Don't leave any preallocated blocks around past i_size. */
+	if (preallocated > 0 && i_size_read(inode) < target_size) {
+		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		filemap_invalidate_lock(inode->i_mapping);
+		f2fs_truncate(inode);
+		filemap_invalidate_unlock(inode->i_mapping);
+		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	}
+
+	clear_inode_flag(inode, FI_PREALLOCATED_ALL);
+
+	if (ret > 0)
+		f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
+
 out_unlock:
 	inode_unlock(inode);
 out:
-- 
2.34.1.448.ga2b2bfdf31-goog

