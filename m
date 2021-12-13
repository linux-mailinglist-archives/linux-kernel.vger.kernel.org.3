Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18765471F95
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhLMDbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:31:25 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29186 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLMDbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:31:24 -0500
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JC6S74ysJz96p0;
        Mon, 13 Dec 2021 11:29:11 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 11:31:22 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <ebiederm@xmission.com>, <keescook@chromium.org>,
        <jlayton@kernel.org>, <bfields@fieldses.org>, <mcgrof@kernel.org>,
        <yzaikin@google.com>, <apw@canonical.com>, <joe@perches.com>,
        <dwaipayanray1@gmail.com>, <lukas.bulwahn@gmail.com>,
        <julia.lawall@inria.fr>, <akpm@linux-foundation.org>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH v3] sysctl: Add a group of macro functions to initcall the sysctl table of each feature
Date:   Mon, 13 Dec 2021 11:31:19 +0800
Message-ID: <20211213033119.51263-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210085849.66169-1-nixiaoming@huawei.com>
References: <20211210085849.66169-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicated code, add a set of macro functions to initialize the
sysctl table for each feature.

The system initialization process is as follows:

	start_kernel () {
		...
		/* init proc and sysctl base,
		 * proc_root_init()-->proc_sys_init()-->sysctl_init_bases()
		 */
		proc_root_init(); /* init proc and sysctl base */
		...
		arch_call_rest_init();
	}

	arch_call_rest_init()-->rest_init()-->kernel_init()
	kernel_init() {
		...
		kernel_init_freeable(); /* do all initcalls */
		...
		do_sysctl_args(); /* Process the sysctl parameter: sysctl.*= */
	}

	kernel_init_freeable()--->do_basic_setup()-->do_initcalls()
	do_initcalls() {
		for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
			do_initcall_level
	}

The sysctl interface of each subfeature should be registered after
sysctl_init_bases() and before do_sysctl_args().
sysctl_init_bases() is executed before early_initcall().
do_sysctl_args() is executed after late_initcall().
To prevent the sysctl interface from being initialized before the feature
itself. The lowest level of late_initcall() is safe as a normal sysctl
interface registration level.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
v3:
  Adjust the commit information description and add document comments to
  sysctl_initcall().
v2: https://lore.kernel.org/lkml/20211210085849.66169-1-nixiaoming@huawei.com/
  Add a simple checkpatch check.
  Add code comment.
v1: https://lore.kernel.org/lkml/20211207011320.100102-1-nixiaoming@huawei.com/
---
 fs/coredump.c          |  7 +------
 fs/dcache.c            |  7 +------
 fs/exec.c              |  8 +-------
 fs/file_table.c        |  7 +------
 fs/inode.c             |  7 +------
 fs/locks.c             |  7 +------
 fs/namei.c             |  8 +-------
 fs/namespace.c         |  7 +------
 include/linux/sysctl.h | 34 ++++++++++++++++++++++++++++++++++
 kernel/stackleak.c     |  7 +------
 scripts/checkpatch.pl  |  6 ++++++
 11 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 570d98398668..8f6c6322651d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -943,12 +943,7 @@ static struct ctl_table coredump_sysctls[] = {
 	{ }
 };
 
-static int __init init_fs_coredump_sysctls(void)
-{
-	register_sysctl_init("kernel", coredump_sysctls);
-	return 0;
-}
-fs_initcall(init_fs_coredump_sysctls);
+kernel_sysctl_initcall(coredump_sysctls);
 #endif /* CONFIG_SYSCTL */
 
 /*
diff --git a/fs/dcache.c b/fs/dcache.c
index 0eef1102f460..c1570243aaee 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -195,12 +195,7 @@ static struct ctl_table fs_dcache_sysctls[] = {
 	{ }
 };
 
-static int __init init_fs_dcache_sysctls(void)
-{
-	register_sysctl_init("fs", fs_dcache_sysctls);
-	return 0;
-}
-fs_initcall(init_fs_dcache_sysctls);
+fs_sysctl_initcall(fs_dcache_sysctls);
 #endif
 
 /*
diff --git a/fs/exec.c b/fs/exec.c
index cc5ec43df028..3c30e686af79 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2124,11 +2124,5 @@ static struct ctl_table fs_exec_sysctls[] = {
 	{ }
 };
 
-static int __init init_fs_exec_sysctls(void)
-{
-	register_sysctl_init("fs", fs_exec_sysctls);
-	return 0;
-}
-
-fs_initcall(init_fs_exec_sysctls);
+fs_sysctl_initcall(fs_exec_sysctls);
 #endif /* CONFIG_SYSCTL */
diff --git a/fs/file_table.c b/fs/file_table.c
index 57edef16dce4..52b60e9378a7 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -116,12 +116,7 @@ static struct ctl_table fs_stat_sysctls[] = {
 	{ }
 };
 
-static int __init init_fs_stat_sysctls(void)
-{
-	register_sysctl_init("fs", fs_stat_sysctls);
-	return 0;
-}
-fs_initcall(init_fs_stat_sysctls);
+fs_sysctl_initcall(fs_stat_sysctls);
 #endif
 
 static struct file *__alloc_file(int flags, const struct cred *cred)
diff --git a/fs/inode.c b/fs/inode.c
index bef6ba9b8eb4..cd20d6dd8ffa 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -132,12 +132,7 @@ static struct ctl_table inodes_sysctls[] = {
 	{ }
 };
 
-static int __init init_fs_inode_sysctls(void)
-{
-	register_sysctl_init("fs", inodes_sysctls);
-	return 0;
-}
-early_initcall(init_fs_inode_sysctls);
+fs_sysctl_initcall(inodes_sysctls);
 #endif
 
 static int no_open(struct inode *inode, struct file *file)
diff --git a/fs/locks.c b/fs/locks.c
index 8c6df10cd9ed..d86a74d19ed3 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -113,12 +113,7 @@ static struct ctl_table locks_sysctls[] = {
 	{}
 };
 
-static int __init init_fs_locks_sysctls(void)
-{
-	register_sysctl_init("fs", locks_sysctls);
-	return 0;
-}
-early_initcall(init_fs_locks_sysctls);
+fs_sysctl_initcall(locks_sysctls);
 #endif /* CONFIG_SYSCTL */
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index 8d4f832f94aa..7eb636796fd4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1066,13 +1066,7 @@ static struct ctl_table namei_sysctls[] = {
 	{ }
 };
 
-static int __init init_fs_namei_sysctls(void)
-{
-	register_sysctl_init("fs", namei_sysctls);
-	return 0;
-}
-fs_initcall(init_fs_namei_sysctls);
-
+fs_sysctl_initcall(namei_sysctls);
 #endif /* CONFIG_SYSCTL */
 
 /**
diff --git a/fs/namespace.c b/fs/namespace.c
index 647af66f313d..7117214b7a85 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4626,11 +4626,6 @@ static struct ctl_table fs_namespace_sysctls[] = {
 	{ }
 };
 
-static int __init init_fs_namespace_sysctls(void)
-{
-	register_sysctl_init("fs", fs_namespace_sysctls);
-	return 0;
-}
-fs_initcall(init_fs_namespace_sysctls);
+fs_sysctl_initcall(fs_namespace_sysctls);
 
 #endif /* CONFIG_SYSCTL */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index acf0805cf3a0..1c09894d453e 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -231,6 +231,40 @@ extern int sysctl_init_bases(void);
 extern void __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name);
 #define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
+
+/**
+ * sysctl_initcall() - register and init sysctl leaf node to path
+ * @path: path name for sysctl base
+ * @table: sysctl leaf table to be registered to the path
+ *
+ * Leaf node in the sysctl tree:
+ * a) File, .child = NULL
+ * b) Directory, which is not shared by multiple features, .child != NULL
+ *
+ * The sysctl interface for each subfeature should be after sysctl_init_bases()
+ * and before do_sysctl_args().
+ * sysctl_init_bases() is executed before early_initcall().
+ * do_sysctl_args() is executed after late_initcall().
+ * Therefore, it is safe to add leaves to the sysctl tree using late_initcall().
+ */
+#define sysctl_initcall(path, table) \
+	static int __init init_##table(void) \
+	{ \
+		register_sysctl_init(path, table); \
+		return  0;\
+	} \
+	late_initcall(init_##table)
+
+/*
+ * Use xxx_sysctl_initcall() to initialize your sysctl interface unless you want
+ * to register the sysctl directory and share it with other features.
+ */
+#define kernel_sysctl_initcall(table) sysctl_initcall("kernel", table)
+#define fs_sysctl_initcall(table) sysctl_initcall("fs", table)
+#define vm_sysctl_initcall(table) sysctl_initcall("vm", table)
+#define debug_sysctl_initcall(table) sysctl_initcall("debug", table)
+#define dev_sysctl_initcall(table) sysctl_initcall("dev", table)
+
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 66b8af394e58..f084c1c787ba 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -57,12 +57,7 @@ static struct ctl_table stackleak_sysctls[] = {
 	{}
 };
 
-static int __init stackleak_sysctls_init(void)
-{
-	register_sysctl_init("kernel", stackleak_sysctls);
-	return 0;
-}
-late_initcall(stackleak_sysctls_init);
+kernel_sysctl_initcall(stackleak_sysctls);
 #endif /* CONFIG_SYSCTL */
 
 #define skip_erasing()	static_branch_unlikely(&stack_erasing_bypass)
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9d..e8701d54b458 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7212,6 +7212,12 @@ sub process {
 			     "Deprecated use of '$deprecated_api', prefer '$new_api' instead\n" . $herecurr);
 		}
 
+# check register_sysctl_init
+		if ($prevline =~ /{/ && $rawline =~ /\sregister_sysctl_init\(\"(kernel|fs|vm|debug|dev)\",\s+(.*)\)\;/) {
+			WARN("DEPRECATED_API",
+			     "Deprecated use of 'register_sysctl_init(\"$1\", $2);', prefer '$1_sysctl_initcall($2);' instead\n".$herecurr);
+		}
+
 # check for various structs that are normally const (ops, kgdb, device_tree)
 # and avoid what seem like struct definitions 'struct foo {'
 		if (defined($const_structs) &&
-- 
2.12.3

