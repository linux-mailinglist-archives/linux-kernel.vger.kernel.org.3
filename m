Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD0A4A95C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354950AbiBDJKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357324AbiBDJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:10:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205BC061748
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 064DC614B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C49EC004E1;
        Fri,  4 Feb 2022 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643965810;
        bh=rb2wJPVBUi7SSDcM4ZjaKH33BmO66QdukLi4kREAYQI=;
        h=From:To:Cc:Subject:Date:From;
        b=QLs72LqEdqR3krZ4rfFl6N0Y022GIXBLQT7CASXshBCbmJR4eaoUkFW6Bj/mpwIjl
         5U46GAG2PSww5Jyz8GiHrOf0cmNSYo8msB2NER2o7+QovY+lcJx/MelOPIJQL70Twf
         lI+gwvnEpF3H/WKFWdfAa72VrDRIht98zwml5r7Zjx6e2RQSVnUwrObKr+BPEAsLJb
         TCf6IwNM8wQt9GRjmQC9qmfH9Kf9WKEO7nLAMcgljS+rzFG2ZU0jEV/8sDymrC9svm
         Y6Vvas16EHjhzOQyuV04K03E2YqB/OzoZo4dnME0nhDFqMe4tPMBSguChEZ9DYkBT8
         8jBeaCxPEqh/w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: skip f2fs_preallocate_blocks() for overwrite case
Date:   Fri,  4 Feb 2022 17:10:05 +0800
Message-Id: <20220204091005.49407-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is potential hangtask happened during swapfile's writeback:

- loop_kthread_worker_fn		- do_checkpoint
  - kthread_worker_fn
   - loop_queue_work
    - lo_rw_aio
     - f2fs_file_write_iter
      - f2fs_preallocate_blocks
       - f2fs_map_blocks
					 - down_write
        - down_read
         - rwsem_down_read_slowpath
          - schedule

One cause is f2fs_preallocate_blocks() will always be called no matter
the physical block addresses are allocated or not.

This patch tries to check whether block addresses are all allocated with
i_size and i_blocks of inode, it's rough because blocks can be allocated
beyond i_size, however, we can afford skipping block preallocation in this
condition since it's not necessary to do preallocation all the time.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- check overwrite case with i_size and i_blocks roughly.
 fs/f2fs/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cfdc41f87f5d..09565d10611d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4390,6 +4390,16 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 	int flag;
 	int ret;
 
+	/*
+	 * It tries to check whether block addresses are all allocated,
+	 * it's rough because blocks can be allocated beyond i_size,
+	 * however, we can afford skipping block preallocation since
+	 * it's not necessary all the time.
+	 */
+	if (F2FS_BLK_ALIGN(i_size_read(inode)) ==
+			SECTOR_TO_BLOCK(inode->i_blocks))
+		return 0;
+
 	/* If it will be an out-of-place direct write, don't bother. */
 	if (dio && f2fs_lfs_mode(sbi))
 		return 0;
-- 
2.32.0

