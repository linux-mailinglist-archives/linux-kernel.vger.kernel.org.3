Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47611507C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358117AbiDSV7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiDSV7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:59:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C6F40A26
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6CDEB81C84
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8239AC385A7;
        Tue, 19 Apr 2022 21:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650405424;
        bh=kvg9SXGdehN1yOUx+2cqBh0ZkhYF9DmxMqwB+3v5TRY=;
        h=From:To:Cc:Subject:Date:From;
        b=FhDIRLS2h0svfjr2wUFu6dKceIwBtTeYDlXfEG2hYER1g6bhyhUV0YwByzPI3HP1P
         ofvp4mrRiTMElQRuvcz3vGHMCbZ+l3mAasdHUELl6QKizFhvOj+nMfJdQrHEx4oVm3
         x/AU2g++u/xAom9mU7ihOkN4+U+xTMnatk2/lNCFBfVp/VXajUh+kxNtf9g3w8ngXw
         tmdVHXeHtsmqyZRUkM4S/aHcECet9RxEt7Wjl/JBY87UccD/z8TftMJc2PVtMI6eNo
         7DT6v+H8PRmaEdvlqrD7DAnFWvTjaW9XMQU2TqGXxpPfwJkHxyzslhxSbmfF3jPrGy
         NxKq+Zpzsd6vw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: use flush command instead of FUA for zoned device
Date:   Tue, 19 Apr 2022 14:57:03 -0700
Message-Id: <20220419215703.1271395-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
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

The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flush
command to keep the write order.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 4 +++-
 fs/f2fs/node.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f08e6208e183..2aef0632f35b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -372,7 +372,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
 	clear_inode_flag(inode, FI_APPEND_WRITE);
 flush_out:
-	if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
+	if ((!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER) ||
+			(atomic && !test_opt(sbi, NOBARRIER) &&
+					f2fs_sb_has_blkzoned(sbi)))
 		ret = f2fs_issue_flush(sbi, inode->i_ino);
 	if (!ret) {
 		f2fs_remove_ino_entry(sbi, ino, UPDATE_INO);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c280f482c741..7224a980056f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1633,7 +1633,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		goto redirty_out;
 	}
 
-	if (atomic && !test_opt(sbi, NOBARRIER))
+	if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_sb_has_blkzoned(sbi))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
 	/* should add to global list before clearing PAGECACHE status */
-- 
2.36.0.rc0.470.gd361397f0d-goog

