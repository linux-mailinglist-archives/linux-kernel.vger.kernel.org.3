Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C384DC24D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiCQJIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiCQJHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8C1D12E7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE55B6168D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09065C340E9;
        Thu, 17 Mar 2022 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647507999;
        bh=ycwRVWQvLfkuIJKDYUhPaC89I0gRNUO7LUP6RS/4T/I=;
        h=From:To:Cc:Subject:Date:From;
        b=fg5KhWdxJH08Bll6b/dfxCr5XjuKyHASMuGVajuWmQH2l3odPWb7mXYZp3rXRn5OM
         vq2WDDJx6/tYJEjl5ILEeV1n2QzWkWEuHVFq40yYGOHvqlGxcw+51yzump3QY7MyuG
         cm9rdAADmr++EuFWLCdORsiqh0sqm2ofIdGsfhvMIRqIkpgZmUyTFbItrLucIv3z0A
         E7nMuh7QjlGWeQst+4MqV+bR4/+ekZImNRJznIWaPCDKfyIU9bxGVlp4eikuwH/12w
         Jb+Eg+tAWpHFA66kTsMhGI1ZZYvD2H3pMut43M3rM0gzwxgpB3S+kdMYrmulV9r1pr
         WV1QMmWeq1DHw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: use aggressive GC policy during f2fs_disable_checkpoint()
Date:   Thu, 17 Mar 2022 17:06:34 +0800
Message-Id: <20220317090634.27354-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more aggressive GC policy as below to improve performance of GC
during f2fs_disable_checkpoint():
- use GC_URGENT_HIGH mode to enable greedy algorithm and SSR allocator;
- use asynchronous GC and in-batch write to imporve possibility of IO
merge.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3016b6354a68..e00b3993e2be 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -589,6 +589,9 @@ enum {
 /* dirty segments threshold for triggering CP */
 #define DEFAULT_DIRTY_THRESHOLD		4
 
+/* count of section which will be written in-batch during disabling checkpoint */
+#define INBATCH_WRITE_SECTION_COUNT	8
+
 /* for in-memory extent cache entry */
 #define F2FS_MIN_EXTENT_LEN	64	/* minimum extent length */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9176597fdf94..08f384b0bd0d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2080,9 +2080,11 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	unsigned int s_flags = sbi->sb->s_flags;
 	struct cp_control cpc;
+	unsigned int gc_mode;
 	int err = 0;
 	int ret;
 	block_t unusable;
+	int inbatch_cnt = 0;
 
 	if (s_flags & SB_RDONLY) {
 		f2fs_err(sbi, "checkpoint=disable on readonly fs");
@@ -2092,15 +2094,23 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	f2fs_update_time(sbi, DISABLE_TIME);
 
+	gc_mode = sbi->gc_mode;
+	sbi->gc_mode = GC_URGENT_HIGH;
+
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
 		f2fs_down_write(&sbi->gc_lock);
-		err = f2fs_gc(sbi, true, false, false, NULL_SEGNO);
+		err = f2fs_gc(sbi, false, false, false, NULL_SEGNO);
 		if (err == -ENODATA) {
 			err = 0;
 			break;
 		}
 		if (err && err != -EAGAIN)
 			break;
+
+		if (++inbatch_cnt == INBATCH_WRITE_SECTION_COUNT) {
+			writeback_inodes_sb(sbi->sb, WB_REASON_SYNC);
+			inbatch_cnt = 0;
+		}
 	}
 
 	ret = sync_filesystem(sbi->sb);
@@ -2129,6 +2139,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 out_unlock:
 	f2fs_up_write(&sbi->gc_lock);
 restore_flag:
+	sbi->gc_mode = gc_mode;
 	sbi->sb->s_flags = s_flags;	/* Restore SB_RDONLY status */
 	return err;
 }
-- 
2.32.0

