Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454B5476D30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhLPJQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:16:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55304 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhLPJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:16:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B500161CD6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC68C36AE4;
        Thu, 16 Dec 2021 09:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639646208;
        bh=P1QMsZOfJCidhTVblCUZbljZNHmQSIofc23szP58Yfs=;
        h=From:To:Cc:Subject:Date:From;
        b=DFrCYxOkDBttlIkWihE1W31BqMtAassuxaqmldX2dXRcU88cix4mMhlTXCRm8cHwg
         8CHG2uAZ3edZxoqM6l1abgouMBN/pu+nvtU3xGQKhyNibSuZlT54Rr5pYOkqKKieSr
         10xk+THV2jkfqQDLncju/wfOUlauI3lD0NTppzXyO8HU8+2HujGaDBJzEsRmvJwStx
         q5j7TN7kXUOuADNbpU6toWU9kUNOG7XliaQP8fB6G8CIyYNk9S7x09qUIMSk/90836
         08daGI92Mf9mGA5rDk5E5ZG1+pclzgK0bCyyHB+tjAJ16P70sGURLWYUJkbOZuOb59
         nDjYZAXmLuhNw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: don't drop compressed page cache in .{invalidate,release}page
Date:   Thu, 16 Dec 2021 17:08:30 +0800
Message-Id: <20211216090830.5461-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For compressed inode, in .{invalidate,release}page, we will call
f2fs_invalidate_compress_pages() to drop all compressed page cache of
current inode.

But we don't need to drop compressed page cache synchronously in
.invalidatepage, because, all trancation paths of compressed physical
block has been covered with f2fs_invalidate_compress_page().

And also we don't need to drop compressed page cache synchronously
in .releasepage, because, if there is out-of-memory, we can count
on page cache reclaim on sbi->compress_inode.

BTW, this patch may fix the issue reported below:

https://lore.kernel.org/linux-f2fs-devel/20211202092812.197647-1-changfengnan@vivo.com/T/#u

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2737fcc0dbcf..40274c32dbc0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3528,12 +3528,9 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 
 	clear_page_private_gcing(page);
 
-	if (test_opt(sbi, COMPRESS_CACHE)) {
-		if (f2fs_compressed_file(inode))
-			f2fs_invalidate_compress_pages(sbi, inode->i_ino);
-		if (inode->i_ino == F2FS_COMPRESS_INO(sbi))
-			clear_page_private_data(page);
-	}
+	if (test_opt(sbi, COMPRESS_CACHE) &&
+			inode->i_ino == F2FS_COMPRESS_INO(sbi))
+		clear_page_private_data(page);
 
 	if (page_private_atomic(page))
 		return f2fs_drop_inmem_page(inode, page);
@@ -3552,15 +3549,10 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	if (page_private_atomic(page))
 		return 0;
 
-	if (test_opt(F2FS_P_SB(page), COMPRESS_CACHE)) {
-		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
-		struct inode *inode = page->mapping->host;
-
-		if (f2fs_compressed_file(inode))
-			f2fs_invalidate_compress_pages(sbi, inode->i_ino);
-		if (inode->i_ino == F2FS_COMPRESS_INO(sbi))
-			clear_page_private_data(page);
-	}
+	if (test_opt(F2FS_P_SB(page), COMPRESS_CACHE) &&
+			inode->i_ino ==
+			F2FS_COMPRESS_INO(F2FS_I_SB(page->mapping->host)))
+		clear_page_private_data(page);
 
 	clear_page_private_gcing(page);
 
-- 
2.32.0

