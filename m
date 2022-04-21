Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1046E50A4FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390471AbiDUQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiDUQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2323542EF0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE88761D09
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1128BC385A1;
        Thu, 21 Apr 2022 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650557159;
        bh=VVe3j0YQ+Cidqf5v6vAbgMUL/5uLwWmI3G/CApfYCig=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=or6jC1vCCTurM4j5pClK6zvbFvQ2JvEIHkWSQciAvTyrHMZH8A5ukoCq0d2uORHS+
         BoxqGZp5c/YzEIBmg6T2J0jl5mBLpcxvD8exCYcKF4U9G3tzLwSFidg2Yo3RNoSkVQ
         1zGz0d3nuSK9ZGPC34/U3Km7oIjxm8Bngpn/SS770L868tlhrUYGjAp6mEXzueWadX
         THAO6YSe9zyY4IpJnXAoTkS4UbsSblME3HHt33iGRDgPVOAoMuYcFeu28eqtcaslQe
         YKDLZC5SE79CxEi5swtmi3De4ZnNj2MceQ1W3C7EwRTL53PAfvOG3CPYCrr8R5zEmT
         aPZDZUP050OjA==
Date:   Thu, 21 Apr 2022 09:05:57 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: use flush command instead of FUA for zoned
 device
Message-ID: <YmGA5X4mtmXc3p/m@google.com>
References: <20220419215703.1271395-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419215703.1271395-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flush
command to keep the write order.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 change log from v1:
  - minor clean up

 fs/f2fs/file.c | 3 ++-
 fs/f2fs/node.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f08e6208e183..eae2e7908072 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -372,7 +372,8 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
 	clear_inode_flag(inode, FI_APPEND_WRITE);
 flush_out:
-	if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
+	if ((!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER) ||
+	    (atomic && !test_opt(sbi, NOBARRIER) && f2fs_sb_has_blkzoned(sbi)))
 		ret = f2fs_issue_flush(sbi, inode->i_ino);
 	if (!ret) {
 		f2fs_remove_ino_entry(sbi, ino, UPDATE_INO);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c45d341dcf6e..144f9f966690 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1631,7 +1631,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		goto redirty_out;
 	}
 
-	if (atomic && !test_opt(sbi, NOBARRIER))
+	if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_sb_has_blkzoned(sbi))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
 	/* should add to global list before clearing PAGECACHE status */
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

