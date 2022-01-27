Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF03849E2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbiA0M7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:59:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50838 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbiA0M7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:59:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B9F461B18
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5167BC340E8;
        Thu, 27 Jan 2022 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643288363;
        bh=0Sr9yEBbyUIa84z9osp9RUNqV4/8hEQ36jN422D9FyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HaZxcMlxAwG6MbSRF74ldQs97krXMn+dNkSP91l92KotkmIX84fLP7T9166SzEexW
         H41o9eJgktAzFdB2200ZR8qX0loHjFdYIBQViweYgvtKpA90eoNBzY5qOReYjd+C6H
         GMshApd3F0aOlQTNqHntXfnZg9o4PU+5HBnnTzZ39ZoVjp1p7kRk2bFK9XWbebpU6l
         Ya9zj8AQRxWx08TuGAM7FPBalX0sVb+V+0I5CgFbOHZ9RH4ysbv3vL52ICSQt6Z1a3
         jj+tbieE7842qQPNQPgwFNKIobBO6fkU4Z/Bt7FsQiTdxP+qCDEstw9gPKzdDDHWQp
         OLoglSxDFHMoQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Zhiguo Niu <zhiguo.niu@unisoc.com>,
        Jing Xia <jing.xia@unisoc.com>
Subject: [PATCH] f2fs: fix to avoid potential deadlock
Date:   Thu, 27 Jan 2022 13:44:49 +0800
Message-Id: <20220127054449.24711-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoted from Jing Xia's report, there is a potential deadlock may happen
between kworker and checkpoint as below:

[T:writeback]				[T:checkpoint]
- wb_writeback
 - blk_start_plug
bio contains NodeA was plugged in writeback threads
					- do_writepages  -- sync write inodeB, inc wb_sync_req[DATA]
					 - f2fs_write_data_pages
					  - f2fs_write_single_data_page -- write last dirty page
					   - f2fs_do_write_data_page
					    - set_page_writeback  -- clear page dirty flag and
					    PAGECACHE_TAG_DIRTY tag in radix tree
					    - f2fs_outplace_write_data
					     - f2fs_update_data_blkaddr
					      - f2fs_wait_on_page_writeback -- wait NodeA to writeback here
					   - inode_dec_dirty_pages
 - writeback_sb_inodes
  - writeback_single_inode
   - do_writepages
    - f2fs_write_data_pages -- skip writepages due to wb_sync_req[DATA]
     - wbc->pages_skipped += get_dirty_pages() -- PAGECACHE_TAG_DIRTY is not set but get_dirty_pages() returns one
  - requeue_inode -- requeue inode to wb->b_dirty queue due to non-zero.pages_skipped
 - blk_finish_plug

Let's try to avoid deadlock condition by forcing unplugging previous bio via
blk_finish_plug(current->plug) once we'v skipped writeback in writepages()
due to valid sbi->wb_sync_req[DATA/NODE].

Fixes: 687de7f1010c ("f2fs: avoid IO split due to mixed WB_SYNC_ALL and WB_SYNC_NONE")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Jing Xia <jing.xia@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 6 +++++-
 fs/f2fs/node.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 76d6fe7b0c8f..932a4c81acaf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3174,8 +3174,12 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	/* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		atomic_inc(&sbi->wb_sync_req[DATA]);
-	else if (atomic_read(&sbi->wb_sync_req[DATA]))
+	else if (atomic_read(&sbi->wb_sync_req[DATA])) {
+		/* to avoid potential deadlock */
+		if (current->plug)
+			blk_finish_plug(current->plug);
 		goto skip_write;
+	}
 
 	if (__should_serialize_io(inode, wbc)) {
 		mutex_lock(&sbi->writepages);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 556fcd8457f3..69c6bcaf5aae 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2106,8 +2106,12 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		atomic_inc(&sbi->wb_sync_req[NODE]);
-	else if (atomic_read(&sbi->wb_sync_req[NODE]))
+	else if (atomic_read(&sbi->wb_sync_req[NODE])) {
+		/* to avoid potential deadlock */
+		if (current->plug)
+			blk_finish_plug(current->plug);
 		goto skip_write;
+	}
 
 	trace_f2fs_writepages(mapping->host, wbc, NODE);
 
-- 
2.32.0

