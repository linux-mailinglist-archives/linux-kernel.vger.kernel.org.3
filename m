Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E964AC92F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiBGTIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiBGTBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:01:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1D1C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:01:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B70FB80EF6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C53C004E1;
        Mon,  7 Feb 2022 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644260493;
        bh=1z4+8gpqxj72CPk/HjiSfJW7EPGIvmZN1bDrBSpbKN0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=NQHYuftBOc5t8Oo06uZvStrpkRmBAyJpWSeVPylj/To+PITo/vir27kNPSO5jTeqO
         smwDF8X8HzWU/foESicd/Ka+33hJqPlTMHlQv/NlOs16hPLPuNRO8fpS+aXS1gDoH8
         yZDJCWBcWie7gj3Pfa1lrsavwMCQAWRU5MmpdyzCulJ+0o1C2bdjlmYikxUVA5G36y
         d1nrC/VHjo5GcNpZhXZtAv1zD5JPVQw8wHHpYi/bh3qp/GYxTuUUjtDncw50R1eK12
         5YWr/9NYcbHLFDP4we46NI9yRL0xQAUuHv7EP2wRLltfRKNQw3efGuxnsAoo/TCuCT
         MG55Xn2H4Fd+w==
Date:   Mon, 7 Feb 2022 11:01:31 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add a way to limit roll forward
 recovery time
Message-ID: <YgFsi7cvYOs6oB3e@google.com>
References: <20220127214102.2040254-1-jaegeuk@kernel.org>
 <YfsjEb2ii3eyPzng@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfsjEb2ii3eyPzng@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a sysfs entry to call checkpoint during fsync() in order to avoid
long elapsed time to run roll-forward recovery when booting the device.
Default value doesn't enforce the limitation which is same as before.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 v3 from v2:
  - add missing percpu init
  - percpu_sum only when it's used

 v2 from v1:
  - make the default w/o enforcement

 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/checkpoint.c                    |  1 +
 fs/f2fs/debug.c                         |  3 +++
 fs/f2fs/f2fs.h                          |  3 +++
 fs/f2fs/node.c                          |  2 ++
 fs/f2fs/node.h                          |  3 +++
 fs/f2fs/recovery.c                      |  4 ++++
 fs/f2fs/super.c                         | 14 ++++++++++++--
 fs/f2fs/sysfs.c                         |  2 ++
 9 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 87d3884c90ea..ce8103f522cb 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -567,3 +567,9 @@ Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	You can set the trial count limit for GC urgent high mode with this value.
 		If GC thread gets to the limit, the mode will turn back to GC normal mode.
 		By default, the value is zero, which means there is no limit like before.
+
+What:		/sys/fs/f2fs/<disk>/max_roll_forward_node_blocks
+Date:		January 2022
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	Controls max # of node block writes to be used for roll forward
+		recovery. This can limit the roll forward recovery time.
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a13b6b4af220..203a1577942d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1547,6 +1547,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	/* update user_block_counts */
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
+	percpu_counter_set(&sbi->rf_node_block_count, 0);
 
 	/* Here, we have one bio having CP pack except cp pack 2 page */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 8c50518475a9..9a13902c7702 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -532,6 +532,9 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->ndirty_meta, si->meta_pages);
 		seq_printf(s, "  - imeta: %4d\n",
 			   si->ndirty_imeta);
+		seq_printf(s, "  - fsync mark: %4lld\n",
+			   percpu_counter_sum_positive(
+					&si->sbi->rf_node_block_count));
 		seq_printf(s, "  - NATs: %9d/%9d\n  - SITs: %9d/%9d\n",
 			   si->dirty_nats, si->nats, si->dirty_sits, si->sits);
 		seq_printf(s, "  - free_nids: %9d/%9d\n  - alloc_nids: %9d\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 51c1392708e6..d220ab613cf1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -916,6 +916,7 @@ struct f2fs_nm_info {
 	nid_t max_nid;			/* maximum possible node ids */
 	nid_t available_nids;		/* # of available node ids */
 	nid_t next_scan_nid;		/* the next nid to be scanned */
+	nid_t max_rf_node_blocks;	/* max # of nodes for recovery */
 	unsigned int ram_thresh;	/* control the memory footprint */
 	unsigned int ra_nid_pages;	/* # of nid pages to be readaheaded */
 	unsigned int dirty_nats_ratio;	/* control dirty nats ratio threshold */
@@ -1687,6 +1688,8 @@ struct f2fs_sb_info {
 	atomic_t nr_pages[NR_COUNT_TYPE];
 	/* # of allocated blocks */
 	struct percpu_counter alloc_valid_block_count;
+	/* # of node block writes as roll forward recovery */
+	struct percpu_counter rf_node_block_count;
 
 	/* writeback control */
 	atomic_t wb_sync_req[META];	/* count # of WB_SYNC threads */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 93512f8859d5..0d9883457579 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1782,6 +1782,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			if (!atomic || page == last_page) {
 				set_fsync_mark(page, 1);
+				percpu_counter_inc(&sbi->rf_node_block_count);
 				if (IS_INODE(page)) {
 					if (is_inode_flag_set(inode,
 								FI_DIRTY_INODE))
@@ -3218,6 +3219,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
 	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
 	nm_i->dirty_nats_ratio = DEF_DIRTY_NAT_RATIO_THRESHOLD;
+	nm_i->max_rf_node_blocks = DEF_RF_NODE_BLOCKS;
 
 	INIT_RADIX_TREE(&nm_i->free_nid_root, GFP_ATOMIC);
 	INIT_LIST_HEAD(&nm_i->free_nid_list);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 18b98cf0465b..4c1d34bfea78 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -31,6 +31,9 @@
 /* control total # of nats */
 #define DEF_NAT_CACHE_THRESHOLD			100000
 
+/* control total # of node writes used for roll-fowrad recovery */
+#define DEF_RF_NODE_BLOCKS			0
+
 /* vector size for gang look-up from nat cache that consists of radix tree */
 #define NATVEC_SIZE	64
 #define SETVEC_SIZE	32
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 2af503f75b4f..ab33e474af07 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -56,6 +56,10 @@ bool f2fs_space_for_roll_forward(struct f2fs_sb_info *sbi)
 
 	if (sbi->last_valid_block_count + nalloc > sbi->user_block_count)
 		return false;
+	if (NM_I(sbi)->max_rf_node_blocks &&
+		percpu_counter_sum_positive(&sbi->rf_node_block_count) >=
+						NM_I(sbi)->max_rf_node_blocks)
+		return false;
 	return true;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9af6c20532ec..f9d627dbed58 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1501,8 +1501,9 @@ static void f2fs_free_inode(struct inode *inode)
 
 static void destroy_percpu_info(struct f2fs_sb_info *sbi)
 {
-	percpu_counter_destroy(&sbi->alloc_valid_block_count);
 	percpu_counter_destroy(&sbi->total_valid_inode_count);
+	percpu_counter_destroy(&sbi->rf_node_block_count);
+	percpu_counter_destroy(&sbi->alloc_valid_block_count);
 }
 
 static void destroy_device_list(struct f2fs_sb_info *sbi)
@@ -3619,11 +3620,20 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 	if (err)
 		return err;
 
+	err = percpu_counter_init(&sbi->rf_node_block_count, 0, GFP_KERNEL);
+	if (err)
+		goto err_valid_block;
+
 	err = percpu_counter_init(&sbi->total_valid_inode_count, 0,
 								GFP_KERNEL);
 	if (err)
-		percpu_counter_destroy(&sbi->alloc_valid_block_count);
+		goto err_node_block;
+	return 0;
 
+err_node_block:
+	percpu_counter_destroy(&sbi->rf_node_block_count);
+err_valid_block:
+	percpu_counter_destroy(&sbi->alloc_valid_block_count);
 	return err;
 }
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 281bc0133ee6..47efcf233afd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -732,6 +732,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ssr_sections, min_ssr_sections);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, dirty_nats_ratio, dirty_nats_ratio);
+F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, max_roll_forward_node_blocks, max_rf_node_blocks);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, migration_granularity, migration_granularity);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
@@ -855,6 +856,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(ram_thresh),
 	ATTR_LIST(ra_nid_pages),
 	ATTR_LIST(dirty_nats_ratio),
+	ATTR_LIST(max_roll_forward_node_blocks),
 	ATTR_LIST(cp_interval),
 	ATTR_LIST(idle_interval),
 	ATTR_LIST(discard_idle_interval),
-- 
2.35.0.263.gb82422642f-goog

