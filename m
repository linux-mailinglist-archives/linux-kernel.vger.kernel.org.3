Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ED84EE8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbiDAHGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiDAHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:06:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12FF66CAC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:04:27 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KVB3p3Pg2z1HBKp;
        Fri,  1 Apr 2022 15:04:06 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 15:04:26 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 15:04:25 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <yuyufen@huawei.com>
Subject: [PATCH 2/5] f2fs: use common fault injection frmework
Date:   Fri, 1 Apr 2022 15:19:06 +0800
Message-ID: <20220401071909.505086-3-yuyufen@huawei.com>
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

For now, f2fs use mount options 'fault_injection' and 'fault_type'
to enable fault injection. We set inject_type and inject_rate in sysfs
to control fault injection.

In fact, common fault injection framework have provided a systematic
way to support error injection via debugfs, which has more richer
and easier control means than the current one.

For example, we can set 'interval' to specify the interval between
failures, and set 'times' to specify how many times failures may happen
at most. More fault injection usage can be seen in (Documentation/
fault-injection/fault-injection.rst)

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/f2fs/Kconfig        |  2 +-
 fs/f2fs/Makefile       |  1 +
 fs/f2fs/f2fs.h         | 26 ++++++++++++++++
 fs/f2fs/fault_inject.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/super.c        |  3 ++
 5 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 fs/f2fs/fault_inject.c

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 03ef087537c7..d40a69077383 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -86,7 +86,7 @@ config F2FS_CHECK_FS
 
 config F2FS_FAULT_INJECTION
 	bool "F2FS fault injection facility"
-	depends on F2FS_FS
+	depends on F2FS_FS && FAULT_INJECTION && DEBUG_FS
 	help
 	  Test F2FS to inject faults such as ENOMEM, ENOSPC, and so on.
 
diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 8a7322d229e4..ff25d7095b95 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -10,3 +10,4 @@ f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
 f2fs-$(CONFIG_FS_VERITY) += verity.o
 f2fs-$(CONFIG_F2FS_FS_COMPRESSION) += compress.o
 f2fs-$(CONFIG_F2FS_IOSTAT) += iostat.o
+f2fs-$(CONFIG_F2FS_FAULT_INJECTION)	+= fault_inject.o
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index be3014029a4e..50077b0388d1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -27,6 +27,7 @@
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
+#include <linux/fault-inject.h>
 
 struct pagevec;
 
@@ -1592,6 +1593,14 @@ struct decompress_io_ctx {
 	struct work_struct verity_work;	/* work to verify the decompressed pages */
 };
 
+struct f2fs_fault_inject {
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	struct fault_attr attr;
+	struct dentry *parent;
+	unsigned int inject_type;
+#endif
+};
+
 #define NULL_CLUSTER			((unsigned int)(~0))
 #define MIN_COMPRESS_LOG_SIZE		2
 #define MAX_COMPRESS_LOG_SIZE		8
@@ -1846,6 +1855,8 @@ struct f2fs_sb_info {
 	spinlock_t iostat_lat_lock;
 	struct iostat_lat_info *iostat_io_lat;
 #endif
+
+	struct f2fs_fault_inject fault_inject;
 };
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -1879,6 +1890,21 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 }
 #endif
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+bool f2fs_should_fail(struct f2fs_sb_info *sbi, unsigned int type);
+void f2fs_fault_inject_init(struct f2fs_sb_info *sbi);
+void f2fs_fault_inject_fini(struct f2fs_sb_info *sbi);
+void f2fs_stop_fault_inject(struct f2fs_sb_info *sbi);
+#else
+static inline bool f2fs_should_fail(struct f2fs_sb_info *sbi, unsigned int type)
+{
+	return false;
+};
+static inline void f2fs_fault_inject_init(struct f2fs_sb_info *sbi) {};
+static inline void f2fs_fault_inject_fini(struct f2fs_sb_info *sbi) {};
+static inline void f2fs_stop_fault_inject(struct f2fs_sb_info *sbi) {};
+#endif
+
 /*
  * Test if the mounted volume is a multi-device volume.
  *   - For a single regular disk volume, sbi->s_ndevs is 0.
diff --git a/fs/f2fs/fault_inject.c b/fs/f2fs/fault_inject.c
new file mode 100644
index 000000000000..a62328b38ad6
--- /dev/null
+++ b/fs/f2fs/fault_inject.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Huawei Technologies Co., Ltd.
+ *
+ */
+#include <linux/f2fs_fs.h>
+#include "f2fs.h"
+
+static DECLARE_FAULT_ATTR(fail_default_attr);
+
+void f2fs_fault_inject_init(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fault_inject *fault_inj = &sbi->fault_inject;
+	struct dentry *dir, *parent;
+	struct fault_attr *attr = &fault_inj->attr;
+	const char *name = sbi->sb->s_id;
+
+	if (!f2fs_debugfs_root) {
+		f2fs_warn(sbi, "root debugfs have not created");
+		return;
+	}
+
+	/* create debugfs directory and attribute */
+	parent = debugfs_create_dir(name, f2fs_debugfs_root);
+	if (!parent) {
+		f2fs_warn(sbi, "%s: failed to create debugfs directory\n", name);
+		return;
+	}
+
+	*attr = fail_default_attr;
+	dir = fault_create_debugfs_attr("fault_inject", parent, attr);
+	if (IS_ERR(dir)) {
+		f2fs_warn(sbi, "%s: failed to create debugfs attr\n", name);
+		debugfs_remove_recursive(parent);
+		return;
+	}
+	fault_inj->parent = parent;
+
+	debugfs_create_x32("inject_type", 0600, dir, &fault_inj->inject_type);
+}
+
+void f2fs_fault_inject_fini(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fault_inject *fault_inj = &sbi->fault_inject;
+
+	debugfs_remove_recursive(fault_inj->parent);
+}
+
+bool f2fs_should_fail(struct f2fs_sb_info *sbi, unsigned int type)
+{
+	struct f2fs_fault_inject *fault_inj = &sbi->fault_inject;
+
+	if (!(fault_inj->inject_type & (1 << type)))
+		return false;
+
+	if (!should_fail(&fault_inj->attr, 1))
+		return false;
+
+	return true;
+}
+
+void f2fs_stop_fault_inject(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fault_inject *fault_inj = &sbi->fault_inject;
+
+	fault_inj->inject_type = 0;
+}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 04e41360303c..4366469aae80 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1600,6 +1600,8 @@ static void f2fs_put_super(struct super_block *sb)
 	 */
 	f2fs_destroy_stats(sbi);
 
+	f2fs_fault_inject_fini(sbi);
+
 	/* destroy f2fs internal modules */
 	f2fs_destroy_node_manager(sbi);
 	f2fs_destroy_segment_manager(sbi);
@@ -4418,6 +4420,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	f2fs_update_time(sbi, CP_TIME);
 	f2fs_update_time(sbi, REQ_TIME);
 	clear_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
+	f2fs_fault_inject_init(sbi);
 	return 0;
 
 sync_free_meta:
-- 
2.31.1

