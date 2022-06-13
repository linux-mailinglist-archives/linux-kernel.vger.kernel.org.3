Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82429549D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349190AbiFMTVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348552AbiFMTVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6541CB38
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D592060C26
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C84C34114;
        Mon, 13 Jun 2022 17:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655140987;
        bh=5Fok1MzW22buXw55Kbx09DXpCWfLARQYnQkHsxPjVgU=;
        h=From:To:Cc:Subject:Date:From;
        b=urm4WeNgQD64HPL+w0eL+IFtNJBWXZsbwagXOmHVMF4xq/DGrjJSTCR9H6XxUF/WZ
         rt6jpXhESVwWsHnVWMQ2WBEmz78qhENmmSBV89XOSQW1fsoc9pPHZGdImGEZqtDazU
         qAbtG2imSxIQmeCljO0T5otetIvwkOXqF2lmMIrflBrDbafuCYicyjEK2k7juHfqXE
         z7zcJxiQO5xYNCnb9vGZjXQkEOJocYFQLbzvqLIai/d4GD6xRDYr71FMCBAFXmn/Mr
         iX+yXNqmVjahye89pcu0mHyl7hSQ/gaaLeJYQBWs+IcT/+1RPLvTYYmJzTFR0hIA9E
         GrCJyrMzS5L2w==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do not skip updating inode when retrying to flush node page
Date:   Mon, 13 Jun 2022 10:23:05 -0700
Message-Id: <20220613172305.1559743-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's try to flush dirty inode again to improve subtle i_blocks mismatch.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 836c79a20afc..4181d03a7ef7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1943,7 +1943,6 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 			bool submitted = false;
-			bool may_dirty = true;
 
 			/* give a priority to WB_SYNC threads */
 			if (atomic_read(&sbi->wb_sync_req[NODE]) &&
@@ -1996,11 +1995,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			}
 
 			/* flush dirty inode */
-			if (IS_INODE(page) && may_dirty) {
-				may_dirty = false;
-				if (flush_dirty_inode(page))
-					goto lock_node;
-			}
+			if (IS_INODE(page) && flush_dirty_inode(page))
+				goto lock_node;
 write_node:
 			f2fs_wait_on_page_writeback(page, NODE, true, true);
 
-- 
2.36.1.476.g0c4daa206d-goog

