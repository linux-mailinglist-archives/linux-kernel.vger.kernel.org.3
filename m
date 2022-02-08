Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7964AD6F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358686AbiBHLbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356582AbiBHKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:52:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADBEC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:52:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E1461538
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64169C004E1;
        Tue,  8 Feb 2022 10:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644317523;
        bh=LOsnrHhtZ02v5wdKdIpP4CXhD4olCp1tiNeKEg5L2bY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZGsO2CWjFjH85KytSFltbGoyHDgWbO/Dc/g9b7Td1eDR+IV2ALxBKXIFYLDwZK1Oj
         cNWK2Xn/hl9E9p/B80AnW7flcfVTu6EU4bLsC+2fnlC/uww4gzRwUADmy44COeqpuY
         dhF1evwfHhsJcpvWXM/1UzZ9MKMmNl3/g7dDYR+N/0GP9NPCCc7VmaYBFJlAMvwKUE
         HeIUUW7Dl4xWGT7OgYqZZNBKTZX/B+7ZezvtKLJv+1px5zczdsr8BAOZsSbw3kYlPc
         JCx0o4fb+u0TjaNH51THr+tkcq2ozqk4LN2Cj3vuuNTmb/7p212imlyhO6r5ZBtq7g
         6fDvlM/G1q22w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH RFC] f2fs: sync node page without cp_rwsem during block_operations()
Date:   Tue,  8 Feb 2022 18:51:56 +0800
Message-Id: <20220208105156.3810115-1-chao@kernel.org>
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

Let's avoid holding cp_rwsem write lock during f2fs_sync_node_pages()
in block_operations(), then cp_rwsem write lock's coverage in checkpoint
can be shrunk, then it expects there will be more opportunity that
foreground operator can grab cp_rwsem read lock.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f7cb4277de70..7596faa0be45 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1190,6 +1190,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		.for_reclaim = 0,
 	};
 	int err = 0, cnt = 0;
+	bool sync_lockless = true;
+	unsigned int retry_cnt = 3;
 
 	/*
 	 * Let's flush inline_data in dirty node pages.
@@ -1249,15 +1251,25 @@ static int block_operations(struct f2fs_sb_info *sbi)
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		f2fs_up_write(&sbi->node_write);
+		if (!retry_cnt--)
+			sync_lockless = false;
+		if (sync_lockless) {
+			f2fs_up_write(&sbi->node_change);
+			f2fs_unlock_all(sbi);
+		}
 		atomic_inc(&sbi->wb_sync_req[NODE]);
 		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
 		atomic_dec(&sbi->wb_sync_req[NODE]);
 		if (err) {
-			f2fs_up_write(&sbi->node_change);
-			f2fs_unlock_all(sbi);
+			if (!sync_lockless) {
+				f2fs_up_write(&sbi->node_change);
+				f2fs_unlock_all(sbi);
+			}
 			return err;
 		}
 		cond_resched();
+		if (sync_lockless)
+			goto retry_flush_quotas;
 		goto retry_flush_nodes;
 	}
 
-- 
2.25.1

