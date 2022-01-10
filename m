Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE0F488F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiAJEuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiAJEuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:50:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A79DC061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:50:00 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c3so10890700pls.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 20:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7eaHDcJw9BaKKm+5s7Ae8qdzCyb5lHod7ssKAvYz3E=;
        b=c4J9IXZnO4YSB/1miLPOlLoxWW5bQXz2YR84bSxYDA0u0dmLOEQIpAodtIsSSeKkz8
         mOzHiJyJKPf04WZvIebkwOq8bQHr9zdGY9ovHSu5ONHYzk7vbBmXI2FOoJ9NX2viJJaa
         d4lynSu7kOcEt6JWQFFLHs7b91QCRwIyCiwBjTDHoOsBeKs7rKFOqtzmkWILaJOt79lQ
         9J5x4o2hDLPsJhvNFHetEOCjZvXZA9TtStSXcIPViCWP5JM/E6eeHq6Apt/YF5iSvIcj
         /8c15ApEOd8TsBWBSdN9hkPCNZMJjhFz3r6GTw3RuSx4U+yQBTtbBpc0I+900quzF+PG
         U7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7eaHDcJw9BaKKm+5s7Ae8qdzCyb5lHod7ssKAvYz3E=;
        b=uhNYYs9KdSYd8gnSnWs+Ofe2j948QlIJb0sIAIQQjv8rKqxSEBP3zAQNwBCSXQIor6
         dFW1qT2t6pMIi9H/e5kiKHVVF69d8J54BVc7VeH5T6sl4JkbAE+Uojt0iaHpRd2p3/sE
         BPnQ+RUGrKp9ixKrxchC/MLB0XaefI1EoNyBrcO17QwIcYOAmlM+sLcZga3VkZukdqRo
         in3fBKDPF0ircIaE2rUzl7hpRvcdfYsC4HfwDYt4/rah1rGUAheway8yn8d4XTxUJefQ
         7EbZD6ipMa5XpeB9t6lnSltmT9ueGVouaqwO9+y2SuEuAewTVMz2XtSog4uO5GcUUtyj
         CW2g==
X-Gm-Message-State: AOAM533O1uS7mxf+Q0QgtPcyBDzZg7eO0ApuSVwt27fKYTUj5Pd+78qi
        sMdGQMWKGnhRAs+9ZAK+Dd+rpA==
X-Google-Smtp-Source: ABdhPJzSWHthtVHHcxdjw8k5kk4Hc+2xmNKACbF/dWRNV40DAMfLl4gFtaHCJv9YB/bQN90wd5tc0g==
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr27355236pjb.125.1641790199785;
        Sun, 09 Jan 2022 20:49:59 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v8sm5449997pfu.68.2022.01.09.20.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 20:49:59 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH v2 2/2] ext4: fast commit may miss file actions
Date:   Mon, 10 Jan 2022 12:48:49 +0800
Message-Id: <20220110044850.2806-3-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110044850.2806-1-yinxin.x@bytedance.com>
References: <20220110044850.2806-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in the follow scenario:
1. jbd start transaction n
2. task A get new handle for transaction n+1
3. task A do some actions and add inode to FC_Q_MAIN fc_q
4. jbd complete transaction n and clear FC_Q_MAIN fc_q
5. task A call fsync

fast commit will lost the file actions during a full commit.

we should also add updates to staging queue during a full commit.
and in ext4_fc_cleanup(), when reset a inode's fc track range, check
it's i_sync_tid, if it bigger than current transaction tid, do not
rest it, or we will lost the track range.

And EXT4_MF_FC_COMMITTING is not needed anymore, so drop it.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
v2: drop EXT4_MF_FC_COMMITTING
---
 fs/ext4/ext4.h        |  5 +----
 fs/ext4/fast_commit.c | 11 ++++++-----
 fs/ext4/super.c       |  1 -
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a060bb56e654..589b1e335ad4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1793,10 +1793,7 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 enum {
 	EXT4_MF_MNTDIR_SAMPLED,
 	EXT4_MF_FS_ABORTED,	/* Fatal error detected */
-	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
-	EXT4_MF_FC_COMMITTING	/* File system underoing a fast
-				 * commit.
-				 */
+	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
 };
 
 static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 444c0e5be932..7966e3bdba27 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -365,7 +365,8 @@ static int ext4_fc_track_template(
 	spin_lock(&sbi->s_fc_lock);
 	if (list_empty(&EXT4_I(inode)->i_fc_list))
 		list_add_tail(&EXT4_I(inode)->i_fc_list,
-				(ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING)) ?
+				(sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
+				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
 				&sbi->s_fc_q[FC_Q_STAGING] :
 				&sbi->s_fc_q[FC_Q_MAIN]);
 	spin_unlock(&sbi->s_fc_lock);
@@ -418,7 +419,8 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	node->fcd_name.len = dentry->d_name.len;
 
 	spin_lock(&sbi->s_fc_lock);
-	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING))
+	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
+		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
 		list_add_tail(&node->fcd_list,
 				&sbi->s_fc_dentry_q[FC_Q_STAGING]);
 	else
@@ -884,7 +886,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 	int ret = 0;
 
 	spin_lock(&sbi->s_fc_lock);
-	ext4_set_mount_flag(sb, EXT4_MF_FC_COMMITTING);
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
 		while (atomic_read(&ei->i_fc_updates)) {
@@ -1202,7 +1203,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		ext4_fc_reset_inode(&iter->vfs_inode);
+		if (iter->i_sync_tid <= tid)
+			ext4_fc_reset_inode(&iter->vfs_inode);
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
 #if (BITS_PER_LONG < 64)
@@ -1231,7 +1233,6 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
 				&sbi->s_fc_q[FC_Q_MAIN]);
 
-	ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
 	if (tid >= sbi->s_fc_ineligible_tid) {
 		sbi->s_fc_ineligible_tid = 0;
 		ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6049547d3c0f..5404516ea7e0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4626,7 +4626,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_STAGING]);
 	sbi->s_fc_bytes = 0;
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
-	ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
 	sbi->s_fc_ineligible_tid = 0;
 	spin_lock_init(&sbi->s_fc_lock);
 	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
-- 
2.20.1

