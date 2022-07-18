Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04FB578E03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiGRXDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiGRXC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:02:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F102AC6B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:02:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso1217893pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YhbyvF2560CrN/uHVk5GP1DJRcLB2iUBdTbsGNA6XJo=;
        b=nFbyzfdTuOTDQrLak2iGUJB1tB0HESUtwy27GUd80D7xmaZ+R+aE/fVCmPgaoEsgJK
         7LIiZpeQhUZAHXAP3urmDRhqbjj/pfhpM12X96QI8vSpOYqD8lm8JzIw9fO/9QVbruof
         NPdPJXN1fWWuJksmZoQRrgh/Yl0u7YSqC8cidxjhJuonTU6yN50/XU8DIfwFCJmkBURQ
         iVuahQ2eepVbY0qTzOUiSlZmOoZv7mRyRDwvqTidOvlrO9v0ewasLMOergTKU/FqBMfk
         slnunM8CWKzqcg7R1Xla45F00ZztGrqXfPOPQEj/Q9Ndm8ZI1xQg+kPz1IBDV6wooyea
         oNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YhbyvF2560CrN/uHVk5GP1DJRcLB2iUBdTbsGNA6XJo=;
        b=K5JuTo1x08LMY7UXFZYQtyVfNFvxV8SsZ0uZcuJoEVSce6C8K3FLr0TE+FVtS3wojc
         +ik+LXHEnzTInvgQj9uSTrvwXPbHKA6WHPoWqcktb3Yd/7mqoiJfG1W3n6HDDKtQj3Vn
         AN8Sj0GfUdD4O7zsZQbMBp2URIdhJ7FYN/YIbC7ur6NwNCbRl0mdMqSqCp5XgfT3kgAe
         Z3LmyFOs8YiT7gmBAifVX3/6nuNqs/BFDfBiUZDq7kO9JP4bogmCQbSUrDobw8cR1jcg
         kvDr2rbYioS70qVkRBOJO1O5v7+GBX/ynxCshsgsLfAHrB25eXY1PApOs7qp+QxNKeiA
         q8Jw==
X-Gm-Message-State: AJIora8RgnPxbVlTuI/KvYHBviumvJ6yHFoOETK++addkQQauNJaGX/H
        rhvAeEZzcu/gaIGX9SImiJWob1e8bFw=
X-Google-Smtp-Source: AGRyM1v1la4KV7gGQYSHFEtqr12Po850VE+8GhhiZ60oO0virr++MzdE4J6KAWXcMgXfdjp23nv/8g==
X-Received: by 2002:a17:90a:590e:b0:1f1:afeb:996 with SMTP id k14-20020a17090a590e00b001f1afeb0996mr12474099pji.205.1658185372678;
        Mon, 18 Jul 2022 16:02:52 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:d2fc:81d3:e812:8c86])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b0016ce31d1d97sm5011590plh.114.2022.07.18.16.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 16:02:52 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: introduce sysfs atomic write statistics
Date:   Mon, 18 Jul 2022 16:02:48 -0700
Message-Id: <20220718230248.3791635-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

introduce the below 4 new sysfs node for atomic write statistics.
- current_atomic_write: the total current atomic write block count,
                        which is not committed yet.
- peak_atomic_write: the peak value of total current atomic write block
                     count after boot.
- committed_atomic_block: the accumulated total committed atomic write
                          block count after boot.
- revoked_atomic_block: the accumulated total revoked atomic write block
                        count after boot.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 25 ++++++++++++++
 fs/f2fs/data.c                          |  7 ++--
 fs/f2fs/f2fs.h                          | 30 ++++++++++++++++
 fs/f2fs/file.c                          |  1 +
 fs/f2fs/segment.c                       |  6 ++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         | 46 +++++++++++++++++++++++++
 7 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 22c1efd49773..ed43d589354d 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -586,3 +586,28 @@ Date:		June 2022
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:	Shows the number of unusable blocks in a section which was defined by
 		the zone capacity reported by underlying zoned device.
+
+What:		/sys/fs/f2fs/<disk>/current_atomic_write
+Date:		July 2022
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show the total current atomic write block count, which is not committed yet.
+		This is a read-only entry.
+
+What:		/sys/fs/f2fs/<disk>/peak_atomic_write
+Date:		July 2022
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show the peak value of total current atomic write block count after boot.
+		If you write "0" here, you can initialize to "0".
+
+What:		/sys/fs/f2fs/<disk>/committed_atomic_block
+Date:		July 2022
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show the accumulated total committed atomic write block count after boot.
+		If you write "0" here, you can initialize to "0".
+
+What:		/sys/fs/f2fs/<disk>/revoked_atomic_block
+Date:		July 2022
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show the accumulated total revoked atomic write block count after boot.
+		If you write "0" here, you can initialize to "0".
+
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c448c3ee7ac3..42eb694685cc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3423,12 +3423,11 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
 	pgoff_t index = page->index;
 	int err = 0;
-	block_t ori_blk_addr;
+	block_t ori_blk_addr = NULL_ADDR;
 
 	/* If pos is beyond the end of file, reserve a new block in COW inode */
 	if ((pos & PAGE_MASK) >= i_size_read(inode))
-		return __reserve_data_block(cow_inode, index, blk_addr,
-					node_changed);
+		goto reserve_block;
 
 	/* Look for the block in COW inode first */
 	err = __find_data_block(cow_inode, index, blk_addr);
@@ -3442,10 +3441,12 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	if (err)
 		return err;
 
+reserve_block:
 	/* Finally, we should reserve a new block in COW inode for the update */
 	err = __reserve_data_block(cow_inode, index, blk_addr, node_changed);
 	if (err)
 		return err;
+	inc_atomic_write_cnt(inode);
 
 	if (ori_blk_addr != NULL_ADDR)
 		*blk_addr = ori_blk_addr;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1d97d06e0d87..8e0f9e867e86 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -813,6 +813,8 @@ struct f2fs_inode_info {
 	unsigned char i_compress_level;		/* compress level (lz4hc,zstd) */
 	unsigned short i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
+
+	unsigned int atomic_write_cnt;
 };
 
 static inline void get_extent_info(struct extent_info *ext,
@@ -1813,6 +1815,12 @@ struct f2fs_sb_info {
 	int max_fragment_chunk;			/* max chunk size for block fragmentation mode */
 	int max_fragment_hole;			/* max hole size for block fragmentation mode */
 
+	/* For atomic write statistics */
+	atomic64_t current_atomic_write;
+	s64 peak_atomic_write;
+	u64 committed_atomic_block;
+	u64 revoked_atomic_block;
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
@@ -2427,6 +2435,28 @@ static inline void inode_dec_dirty_pages(struct inode *inode)
 		dec_page_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
 }
 
+static inline void inc_atomic_write_cnt(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	u64 current_write;
+
+	fi->atomic_write_cnt++;
+	atomic64_inc(&sbi->current_atomic_write);
+	current_write = atomic64_read(&sbi->current_atomic_write);
+	if (current_write > sbi->peak_atomic_write)
+		sbi->peak_atomic_write = current_write;
+}
+
+static inline void release_atomic_write_cnt(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+
+	atomic64_sub(fi->atomic_write_cnt, &sbi->current_atomic_write);
+	fi->atomic_write_cnt = 0;
+}
+
 static inline s64 get_pages(struct f2fs_sb_info *sbi, int count_type)
 {
 	return atomic_read(&sbi->nr_pages[count_type]);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0f29af7876a6..49a62d134884 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2075,6 +2075,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	f2fs_update_time(sbi, REQ_TIME);
 	fi->atomic_write_task = current;
 	stat_update_max_atomic_write(inode);
+	fi->atomic_write_cnt = 0;
 out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ce571c0d7126..17cb518f88b3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -196,6 +196,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 		clear_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
 		iput(fi->cow_inode);
 		fi->cow_inode = NULL;
+		release_atomic_write_cnt(inode);
 		clear_inode_flag(inode, FI_ATOMIC_FILE);
 
 		spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
@@ -335,6 +336,11 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 	}
 
 out:
+	if (ret)
+		sbi->revoked_atomic_block += fi->atomic_write_cnt;
+	else
+		sbi->committed_atomic_block += fi->atomic_write_cnt;
+
 	__complete_revoke_list(inode, &revoke_list, ret ? true : false);
 
 	return ret;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index faf9a767d05a..1c6203798fb4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3615,6 +3615,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->max_fragment_chunk = DEF_FRAGMENT_SIZE;
 	sbi->max_fragment_hole = DEF_FRAGMENT_SIZE;
 	spin_lock_init(&sbi->gc_urgent_high_lock);
+	atomic64_set(&sbi->current_atomic_write, 0);
 
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6eeefe60a7af..eba5fb1629d7 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -339,6 +339,21 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			sbi->gc_reclaimed_segs[sbi->gc_segment_mode]);
 	}
 
+	if (!strcmp(a->attr.name, "current_atomic_write")) {
+		s64 current_write = atomic64_read(&sbi->current_atomic_write);
+
+		return sysfs_emit(buf, "%lld\n", current_write);
+	}
+
+	if (!strcmp(a->attr.name, "peak_atomic_write"))
+		return sysfs_emit(buf, "%lld\n", sbi->peak_atomic_write);
+
+	if (!strcmp(a->attr.name, "committed_atomic_block"))
+		return sysfs_emit(buf, "%llu\n", sbi->committed_atomic_block);
+
+	if (!strcmp(a->attr.name, "revoked_atomic_block"))
+		return sysfs_emit(buf, "%llu\n", sbi->revoked_atomic_block);
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	return sprintf(buf, "%u\n", *ui);
@@ -608,6 +623,27 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "peak_atomic_write")) {
+		if (t != 0)
+			return -EINVAL;
+		sbi->peak_atomic_write = 0;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "committed_atomic_block")) {
+		if (t != 0)
+			return -EINVAL;
+		sbi->committed_atomic_block = 0;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "revoked_atomic_block")) {
+		if (t != 0)
+			return -EINVAL;
+		sbi->revoked_atomic_block = 0;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -855,6 +891,12 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_reclaimed_segments, gc_reclaimed_segs);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_fragment_chunk, max_fragment_chunk);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_fragment_hole, max_fragment_hole);
 
+/* For atomic write */
+F2FS_RO_ATTR(F2FS_SBI, f2fs_sb_info, current_atomic_write, current_atomic_write);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, peak_atomic_write, peak_atomic_write);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, committed_atomic_block, committed_atomic_block);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, revoked_atomic_block, revoked_atomic_block);
+
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_urgent_sleep_time),
@@ -944,6 +986,10 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_reclaimed_segments),
 	ATTR_LIST(max_fragment_chunk),
 	ATTR_LIST(max_fragment_hole),
+	ATTR_LIST(current_atomic_write),
+	ATTR_LIST(peak_atomic_write),
+	ATTR_LIST(committed_atomic_block),
+	ATTR_LIST(revoked_atomic_block),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.37.0.170.g444d1eabd0-goog

