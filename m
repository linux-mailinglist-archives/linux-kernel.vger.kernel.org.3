Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535165896AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbiHDDmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbiHDDlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:41:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3E05F9B9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8CCE617F7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFBEC433D6;
        Thu,  4 Aug 2022 03:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659584510;
        bh=S8s5z1x3ID9OVqTTN45HZoXxESI7Zk4SGH+wg8AEPjA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZiqwPPMwnfQ7aY1aeRE5SKLlWmnmo9H9WVkOuDp50PiPuD1JQ03kf44hA8pdYGTZH
         MRebCDpy2rwtSrz3LhwzUaLRRNRB1lnd8TS3A8BrnNGzZjYHyYlxgXED4Fmfcy0ddI
         ywR3AXGw+BdB19oS5DKZksVKiWqP14WSx8uvy7B//HU+oebmTeOH/z/hpXfQnYeC/5
         HAd+lbFIVuJFiN0wHgzJKM3rL6UvVRSL9FZy8oIy/ZwoBsmk21zDoNFcBMfpQarSLM
         QdGngn9ibV5HW7Vs4b5wHYT0OZVsSywK6EODUFlkUkDyZCiV+hrv1g6jKR5s2h9A3U
         5/0v41w5XxVMw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do not set compression bit if kernel doesn't support
Date:   Wed,  3 Aug 2022 20:41:46 -0700
Message-Id: <20220804034146.3357114-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kernel doesn't have CONFIG_F2FS_FS_COMPRESSION, a file having FS_COMPR_FL via
ioctl(FS_IOC_SETFLAGS) is unaccessible due to f2fs_is_compress_backend_ready().
Let's avoid it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 7 ++++++-
 fs/f2fs/file.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4e274c91360b..2f3c4eef89c2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4295,8 +4295,9 @@ static inline void f2fs_update_extent_tree_range_compressed(struct inode *inode,
 				unsigned int c_len) { }
 #endif
 
-static inline void set_compress_context(struct inode *inode)
+static inline int set_compress_context(struct inode *inode)
 {
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
 	F2FS_I(inode)->i_compress_algorithm =
@@ -4319,6 +4320,10 @@ static inline void set_compress_context(struct inode *inode)
 	stat_inc_compr_inode(inode);
 	inc_compr_inode_stat(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 static inline bool f2fs_disable_compressed_file(struct inode *inode)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d2159d6880d6..67e5a6cd25e8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1878,8 +1878,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 				return -EINVAL;
 			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
 				return -EINVAL;
-
-			set_compress_context(inode);
+			if (set_compress_context(inode))
+				return -EOPNOTSUPP;
 		}
 	}
 
-- 
2.37.1.455.g008518b4e5-goog

