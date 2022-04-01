Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E194EE8C1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbiDAHGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbiDAHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:06:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05BD65D3B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:04:27 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KVB3p0gZTz1HBJn;
        Fri,  1 Apr 2022 15:04:06 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 15:04:25 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 15:04:25 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <yuyufen@huawei.com>
Subject: [PATCH 1/5] f2fs: extract f2fs root debugfs to init_f2fs_fs
Date:   Fri, 1 Apr 2022 15:19:05 +0800
Message-ID: <20220401071909.505086-2-yuyufen@huawei.com>
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

Then, we don't need to depend on CONFIG_F2FS_STAT_FS to create
f2fs root debugfs directory /sys/kernel/debug/f2fs.

This patch is prepared for following f2fs fault injection,
which will create sub directory 'fault_inject' into f2fs root debugfs.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/f2fs/debug.c | 19 ++-----------------
 fs/f2fs/f2fs.h  |  4 ++--
 fs/f2fs/super.c | 22 ++++++++++++++++++++--
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index fcdf253cd211..15b3567cd208 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -22,9 +22,6 @@
 
 static LIST_HEAD(f2fs_stat_list);
 static DEFINE_RAW_SPINLOCK(f2fs_stat_lock);
-#ifdef CONFIG_DEBUG_FS
-static struct dentry *f2fs_debugfs_root;
-#endif
 
 /*
  * This function calculates BDF of every segments
@@ -648,18 +645,6 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi)
 
 void __init f2fs_create_root_stats(void)
 {
-#ifdef CONFIG_DEBUG_FS
-	f2fs_debugfs_root = debugfs_create_dir("f2fs", NULL);
-
-	debugfs_create_file("status", 0444, f2fs_debugfs_root, NULL,
-			    &stat_fops);
-#endif
-}
-
-void f2fs_destroy_root_stats(void)
-{
-#ifdef CONFIG_DEBUG_FS
-	debugfs_remove_recursive(f2fs_debugfs_root);
-	f2fs_debugfs_root = NULL;
-#endif
+	if (f2fs_debugfs_root)
+		debugfs_create_file("status", 0444, f2fs_debugfs_root, NULL, &stat_fops);
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cd1e65bcf0b0..be3014029a4e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -62,6 +62,8 @@ enum {
 	FAULT_MAX,
 };
 
+extern struct dentry *f2fs_debugfs_root;
+
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 #define F2FS_ALL_FAULT_TYPE		((1 << FAULT_MAX) - 1)
 
@@ -3994,7 +3996,6 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 int f2fs_build_stats(struct f2fs_sb_info *sbi);
 void f2fs_destroy_stats(struct f2fs_sb_info *sbi);
 void __init f2fs_create_root_stats(void);
-void f2fs_destroy_root_stats(void);
 void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #else
 #define stat_inc_cp_count(si)				do { } while (0)
@@ -4035,7 +4036,6 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
 static inline void __init f2fs_create_root_stats(void) { }
-static inline void f2fs_destroy_root_stats(void) { }
 static inline void f2fs_update_sit_info(struct f2fs_sb_info *sbi) {}
 #endif
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ea939db18f88..04e41360303c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -27,6 +27,7 @@
 #include <linux/part_stat.h>
 #include <linux/zstd.h>
 #include <linux/lz4.h>
+#include <linux/debugfs.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -39,6 +40,7 @@
 #include <trace/events/f2fs.h>
 
 static struct kmem_cache *f2fs_inode_cachep;
+struct dentry *f2fs_debugfs_root;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 
@@ -4575,6 +4577,21 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(f2fs_inode_cachep);
 }
 
+static void f2fs_create_debugfs(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	f2fs_debugfs_root = debugfs_create_dir("f2fs", NULL);
+#endif
+}
+
+static void f2fs_destroy_debugfs(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(f2fs_debugfs_root);
+	f2fs_debugfs_root = NULL;
+#endif
+}
+
 static int __init init_f2fs_fs(void)
 {
 	int err;
@@ -4615,6 +4632,7 @@ static int __init init_f2fs_fs(void)
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
 		goto free_shrinker;
+	f2fs_create_debugfs();
 	f2fs_create_root_stats();
 	err = f2fs_init_post_read_processing();
 	if (err)
@@ -4651,7 +4669,7 @@ static int __init init_f2fs_fs(void)
 free_post_read:
 	f2fs_destroy_post_read_processing();
 free_root_stats:
-	f2fs_destroy_root_stats();
+	f2fs_destroy_debugfs();
 	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
 	unregister_shrinker(&f2fs_shrinker_info);
@@ -4684,7 +4702,7 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_bio_entry_cache();
 	f2fs_destroy_iostat_processing();
 	f2fs_destroy_post_read_processing();
-	f2fs_destroy_root_stats();
+	f2fs_destroy_debugfs();
 	unregister_filesystem(&f2fs_fs_type);
 	unregister_shrinker(&f2fs_shrinker_info);
 	f2fs_exit_sysfs();
-- 
2.31.1

