Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E929B4EE8C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbiDAHG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343638AbiDAHGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:06:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE14692A8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:04:28 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KVB1c0zj7zDq6P;
        Fri,  1 Apr 2022 15:02:12 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 15:04:26 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 15:04:26 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <yuyufen@huawei.com>
Subject: [PATCH 3/5] f2fs: replace function time_to_inject by f2fs_should_fail
Date:   Fri, 1 Apr 2022 15:19:07 +0800
Message-ID: <20220401071909.505086-4-yuyufen@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220401071909.505086-1-yuyufen@huawei.com>
References: <20220401071909.505086-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all time_to_inject by f2fs_should_fail to apply new
fault inject.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       |  4 ++--
 fs/f2fs/dir.c        |  2 +-
 fs/f2fs/f2fs.h       | 16 ++++++++--------
 fs/f2fs/file.c       |  2 +-
 fs/f2fs/gc.c         |  2 +-
 fs/f2fs/inode.c      |  2 +-
 fs/f2fs/node.c       |  2 +-
 fs/f2fs/segment.c    |  4 ++--
 fs/f2fs/super.c      |  4 ++--
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a8fc4fa511a8..820eb95b08f1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -611,7 +611,7 @@ int f2fs_acquire_orphan_inode(struct f2fs_sb_info *sbi)
 
 	spin_lock(&im->ino_lock);
 
-	if (time_to_inject(sbi, FAULT_ORPHAN)) {
+	if (f2fs_should_fail(sbi, FAULT_ORPHAN)) {
 		spin_unlock(&im->ino_lock);
 		f2fs_show_injection_info(sbi, FAULT_ORPHAN);
 		return -ENOSPC;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f8fcbe91059b..c070d64504d6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -276,7 +276,7 @@ static void f2fs_read_end_io(struct bio *bio)
 	iostat_update_and_unbind_ctx(bio, 0);
 	ctx = bio->bi_private;
 
-	if (time_to_inject(sbi, FAULT_READ_IO)) {
+	if (f2fs_should_fail(sbi, FAULT_READ_IO)) {
 		f2fs_show_injection_info(sbi, FAULT_READ_IO);
 		bio->bi_status = BLK_STS_IOERR;
 	}
@@ -303,7 +303,7 @@ static void f2fs_write_end_io(struct bio *bio)
 	iostat_update_and_unbind_ctx(bio, 1);
 	sbi = bio->bi_private;
 
-	if (time_to_inject(sbi, FAULT_WRITE_IO)) {
+	if (f2fs_should_fail(sbi, FAULT_WRITE_IO)) {
 		f2fs_show_injection_info(sbi, FAULT_WRITE_IO);
 		bio->bi_status = BLK_STS_IOERR;
 	}
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a0e51937d92e..ab50f8f3597b 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -727,7 +727,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
 	}
 
 start:
-	if (time_to_inject(F2FS_I_SB(dir), FAULT_DIR_DEPTH)) {
+	if (f2fs_should_fail(F2FS_I_SB(dir), FAULT_DIR_DEPTH)) {
 		f2fs_show_injection_info(F2FS_I_SB(dir), FAULT_DIR_DEPTH);
 		return -ENOSPC;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 50077b0388d1..beb935f807d6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2231,7 +2231,7 @@ static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 
 static inline int f2fs_trylock_op(struct f2fs_sb_info *sbi)
 {
-	if (time_to_inject(sbi, FAULT_LOCK_OP)) {
+	if (f2fs_should_fail(sbi, FAULT_LOCK_OP)) {
 		f2fs_show_injection_info(sbi, FAULT_LOCK_OP);
 		return 0;
 	}
@@ -2321,7 +2321,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	if (ret)
 		return ret;
 
-	if (time_to_inject(sbi, FAULT_BLOCK)) {
+	if (f2fs_should_fail(sbi, FAULT_BLOCK)) {
 		f2fs_show_injection_info(sbi, FAULT_BLOCK);
 		release = *count;
 		goto release_quota;
@@ -2579,7 +2579,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 			return err;
 	}
 
-	if (time_to_inject(sbi, FAULT_BLOCK)) {
+	if (f2fs_should_fail(sbi, FAULT_BLOCK)) {
 		f2fs_show_injection_info(sbi, FAULT_BLOCK);
 		goto enospc;
 	}
@@ -2699,7 +2699,7 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 		if (page)
 			return page;
 
-		if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC)) {
+		if (f2fs_should_fail(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC)) {
 			f2fs_show_injection_info(F2FS_M_SB(mapping),
 							FAULT_PAGE_ALLOC);
 			return NULL;
@@ -2715,7 +2715,7 @@ static inline struct page *f2fs_pagecache_get_page(
 				struct address_space *mapping, pgoff_t index,
 				int fgp_flags, gfp_t gfp_mask)
 {
-	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_GET)) {
+	if (f2fs_should_fail(F2FS_M_SB(mapping), FAULT_PAGE_GET)) {
 		f2fs_show_injection_info(F2FS_M_SB(mapping), FAULT_PAGE_GET);
 		return NULL;
 	}
@@ -2778,7 +2778,7 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
 	if (nofail)
 		return f2fs_kmem_cache_alloc_nofail(cachep, flags);
 
-	if (time_to_inject(sbi, FAULT_SLAB_ALLOC)) {
+	if (f2fs_should_fail(sbi, FAULT_SLAB_ALLOC)) {
 		f2fs_show_injection_info(sbi, FAULT_SLAB_ALLOC);
 		return NULL;
 	}
@@ -3350,7 +3350,7 @@ static inline bool is_dot_dotdot(const u8 *name, size_t len)
 static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
 					size_t size, gfp_t flags)
 {
-	if (time_to_inject(sbi, FAULT_KMALLOC)) {
+	if (f2fs_should_fail(sbi, FAULT_KMALLOC)) {
 		f2fs_show_injection_info(sbi, FAULT_KMALLOC);
 		return NULL;
 	}
@@ -3367,7 +3367,7 @@ static inline void *f2fs_kzalloc(struct f2fs_sb_info *sbi,
 static inline void *f2fs_kvmalloc(struct f2fs_sb_info *sbi,
 					size_t size, gfp_t flags)
 {
-	if (time_to_inject(sbi, FAULT_KVMALLOC)) {
+	if (f2fs_should_fail(sbi, FAULT_KVMALLOC)) {
 		f2fs_show_injection_info(sbi, FAULT_KVMALLOC);
 		return NULL;
 	}
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d3f39a704b8b..b73729c111bd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -782,7 +782,7 @@ int f2fs_truncate(struct inode *inode)
 
 	trace_f2fs_truncate(inode);
 
-	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE)) {
+	if (f2fs_should_fail(F2FS_I_SB(inode), FAULT_TRUNCATE)) {
 		f2fs_show_injection_info(F2FS_I_SB(inode), FAULT_TRUNCATE);
 		return -EIO;
 	}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ea5b93b689cd..0a513c5e6b1e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -68,7 +68,7 @@ static int gc_thread_func(void *data)
 			continue;
 		}
 
-		if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
+		if (f2fs_should_fail(sbi, FAULT_CHECKPOINT)) {
 			f2fs_show_injection_info(sbi, FAULT_CHECKPOINT);
 			f2fs_stop_checkpoint(sbi, false);
 		}
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 71f232dcf3c2..036e40fca681 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -786,7 +786,7 @@ void f2fs_evict_inode(struct inode *inode)
 	if (F2FS_HAS_BLOCKS(inode))
 		err = f2fs_truncate(inode);
 
-	if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
+	if (f2fs_should_fail(sbi, FAULT_EVICT_INODE)) {
 		f2fs_show_injection_info(sbi, FAULT_EVICT_INODE);
 		err = -EIO;
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0b6e741e94a0..ee9ddbe5630e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2543,7 +2543,7 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i = NULL;
 retry:
-	if (time_to_inject(sbi, FAULT_ALLOC_NID)) {
+	if (f2fs_should_fail(sbi, FAULT_ALLOC_NID)) {
 		f2fs_show_injection_info(sbi, FAULT_ALLOC_NID);
 		return false;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 22dfeb991529..1e1436b8c125 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -493,7 +493,7 @@ int f2fs_commit_inmem_pages(struct inode *inode)
  */
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 {
-	if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
+	if (f2fs_should_fail(sbi, FAULT_CHECKPOINT)) {
 		f2fs_show_injection_info(sbi, FAULT_CHECKPOINT);
 		f2fs_stop_checkpoint(sbi, false);
 	}
@@ -1237,7 +1237,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		dc->len += len;
 
-		if (time_to_inject(sbi, FAULT_DISCARD)) {
+		if (f2fs_should_fail(sbi, FAULT_DISCARD)) {
 			f2fs_show_injection_info(sbi, FAULT_DISCARD);
 			err = -EIO;
 			goto submit;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4366469aae80..e18f60165f44 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1347,7 +1347,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 {
 	struct f2fs_inode_info *fi;
 
-	if (time_to_inject(F2FS_SB(sb), FAULT_SLAB_ALLOC)) {
+	if (f2fs_should_fail(F2FS_SB(sb), FAULT_SLAB_ALLOC)) {
 		f2fs_show_injection_info(F2FS_SB(sb), FAULT_SLAB_ALLOC);
 		return NULL;
 	}
@@ -2551,7 +2551,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 
 int f2fs_dquot_initialize(struct inode *inode)
 {
-	if (time_to_inject(F2FS_I_SB(inode), FAULT_DQUOT_INIT)) {
+	if (f2fs_should_fail(F2FS_I_SB(inode), FAULT_DQUOT_INIT)) {
 		f2fs_show_injection_info(F2FS_I_SB(inode), FAULT_DQUOT_INIT);
 		return -ESRCH;
 	}
-- 
2.31.1

