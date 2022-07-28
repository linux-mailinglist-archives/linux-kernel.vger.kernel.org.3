Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C75848CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiG1XxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiG1Xwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:52:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78D4C6E89A;
        Thu, 28 Jul 2022 16:52:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [76.135.27.191])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2DA3220FE9A5;
        Thu, 28 Jul 2022 16:52:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DA3220FE9A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659052368;
        bh=7O98qmAn6+g8y6QrqaZ8tTTvu9eWnVBeLGCQsf5st1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iI4pP1h1fp8H82UNKonSaNZ4H6Nyug3Zdi/bXNbGwUHHZnT/aI25mCu+kY+UJt3j5
         WLnlXyk/S1xfqBtqV60v/NxL/lYIrw0QNiEKe4s9BhGGbd7lFvAGEpvJDO7tS+iL8Q
         hGuKYOIaVEuWpVaV10L34WCJEl2gW5curhYoS+hg=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/7] tracing: Add namespace instance directory to tracefs
Date:   Thu, 28 Jul 2022 16:52:36 -0700
Message-Id: <20220728235241.2249-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728235241.2249-1-beaub@linux.microsoft.com>
References: <20220728235241.2249-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some tracing systems require a group or namespace isolation, such as
user_events. The namespace directory in tracefs is a singleton like the
instances directory. It also acts like the instances directory in that
user-mode processes can create a directory within the namespace if they
have appropriate permissions.

This change only covers adding the ability for a tracing system to
create the namespace directory. A system for adding and managing
namespaces will reside within another tracing API.

Link: https://lore.kernel.org/all/20220312010140.1880-1-beaub@linux.microsoft.com/

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 fs/tracefs/inode.c      | 119 ++++++++++++++++++++++++++++++++++++++--
 include/linux/tracefs.h |   5 ++
 2 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 81d26abf486f..7bf95cc65d78 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -24,6 +24,11 @@
 
 #define TRACEFS_DEFAULT_MODE	0700
 
+enum tracefs_dir_type {
+	TRACEFS_DIR_INSTANCES,
+	TRACEFS_DIR_NAMESPACES,
+};
+
 static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
@@ -50,6 +55,8 @@ static const struct file_operations tracefs_file_operations = {
 static struct tracefs_dir_ops {
 	int (*mkdir)(const char *name);
 	int (*rmdir)(const char *name);
+	int (*ns_mkdir)(const char *name);
+	int (*ns_rmdir)(const char *name);
 } tracefs_ops __ro_after_init;
 
 static char *get_dname(struct dentry *dentry)
@@ -67,9 +74,8 @@ static char *get_dname(struct dentry *dentry)
 	return name;
 }
 
-static int tracefs_syscall_mkdir(struct user_namespace *mnt_userns,
-				 struct inode *inode, struct dentry *dentry,
-				 umode_t mode)
+static int tracefs_syscall_mkdir_core(int type, struct inode *inode,
+				      struct dentry *dentry)
 {
 	char *name;
 	int ret;
@@ -84,7 +90,22 @@ static int tracefs_syscall_mkdir(struct user_namespace *mnt_userns,
 	 * mkdir routine to handle races.
 	 */
 	inode_unlock(inode);
-	ret = tracefs_ops.mkdir(name);
+
+	switch (type) {
+	case TRACEFS_DIR_INSTANCES:
+		ret = tracefs_ops.mkdir(name);
+		break;
+
+	case TRACEFS_DIR_NAMESPACES:
+		ret = tracefs_ops.ns_mkdir(name);
+		break;
+
+	default:
+		pr_debug("tracefs: unknown mkdir type '%d'\n", type);
+		ret = -ENOENT;
+		break;
+	}
+
 	inode_lock(inode);
 
 	kfree(name);
@@ -92,7 +113,24 @@ static int tracefs_syscall_mkdir(struct user_namespace *mnt_userns,
 	return ret;
 }
 
-static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
+static int tracefs_syscall_mkdir(struct user_namespace *mnt_userns,
+				 struct inode *inode, struct dentry *dentry,
+				 umode_t mode)
+{
+	return tracefs_syscall_mkdir_core(TRACEFS_DIR_INSTANCES,
+					  inode, dentry);
+}
+
+static int tracefs_syscall_ns_mkdir(struct user_namespace *mnt_userns,
+				    struct inode *inode, struct dentry *dentry,
+				    umode_t mode)
+{
+	return tracefs_syscall_mkdir_core(TRACEFS_DIR_NAMESPACES,
+					  inode, dentry);
+}
+
+static int tracefs_syscall_rmdir_core(int type, struct inode *inode,
+				      struct dentry *dentry)
 {
 	char *name;
 	int ret;
@@ -111,7 +149,20 @@ static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
 	inode_unlock(inode);
 	inode_unlock(d_inode(dentry));
 
-	ret = tracefs_ops.rmdir(name);
+	switch (type) {
+	case TRACEFS_DIR_INSTANCES:
+		ret = tracefs_ops.rmdir(name);
+		break;
+
+	case TRACEFS_DIR_NAMESPACES:
+		ret = tracefs_ops.ns_rmdir(name);
+		break;
+
+	default:
+		pr_debug("tracefs: unknown rmdir type '%d'\n", type);
+		ret = -ENOENT;
+		break;
+	}
 
 	inode_lock_nested(inode, I_MUTEX_PARENT);
 	inode_lock(d_inode(dentry));
@@ -121,12 +172,30 @@ static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
 	return ret;
 }
 
+static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
+{
+	return tracefs_syscall_rmdir_core(TRACEFS_DIR_INSTANCES,
+					  inode, dentry);
+}
+
+static int tracefs_syscall_ns_rmdir(struct inode *inode, struct dentry *dentry)
+{
+	return tracefs_syscall_rmdir_core(TRACEFS_DIR_NAMESPACES,
+					  inode, dentry);
+}
+
 static const struct inode_operations tracefs_dir_inode_operations = {
 	.lookup		= simple_lookup,
 	.mkdir		= tracefs_syscall_mkdir,
 	.rmdir		= tracefs_syscall_rmdir,
 };
 
+static const struct inode_operations tracefs_dir_inode_ns_operations = {
+	.lookup		= simple_lookup,
+	.mkdir		= tracefs_syscall_ns_mkdir,
+	.rmdir		= tracefs_syscall_ns_rmdir,
+};
+
 static struct inode *tracefs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
@@ -582,6 +651,44 @@ __init struct dentry *tracefs_create_instance_dir(const char *name,
 	return dentry;
 }
 
+/**
+ * tracefs_create_namespace_dir - create the tracing namespaces directory
+ * @name: The name of the namespaces directory to create
+ * @parent: The parent directory that the namespaces directory will exist
+ * @mkdir: The function to call when a mkdir is performed.
+ * @rmdir: The function to call when a rmdir is performed.
+ *
+ * Only one namespaces directory is allowed.
+ *
+ * The namespaces directory is special as it allows for mkdir and rmdir
+ * to be done by userspace. When a mkdir or rmdir is performed, the inode
+ * locks are released and the methods passed in (@mkdir and @rmdir) are
+ * called without locks and with the name of the directory being created
+ * within the namespaces directory.
+ *
+ * Returns the dentry of the namespaces directory.
+ */
+__init struct dentry *tracefs_create_namespace_dir(const char *name,
+					  struct dentry *parent,
+					  int (*mkdir)(const char *name),
+					  int (*rmdir)(const char *name))
+{
+	struct dentry *dentry;
+
+	/* Only allow one instance of the namespaces directory. */
+	if (WARN_ON(tracefs_ops.ns_mkdir || tracefs_ops.ns_rmdir))
+		return NULL;
+
+	dentry = __create_dir(name, parent, &tracefs_dir_inode_ns_operations);
+	if (!dentry)
+		return NULL;
+
+	tracefs_ops.ns_mkdir = mkdir;
+	tracefs_ops.ns_rmdir = rmdir;
+
+	return dentry;
+}
+
 static void remove_one(struct dentry *victim)
 {
 	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 99912445974c..04870dee6c87 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -33,6 +33,11 @@ struct dentry *tracefs_create_instance_dir(const char *name, struct dentry *pare
 					   int (*mkdir)(const char *name),
 					   int (*rmdir)(const char *name));
 
+struct dentry *tracefs_create_namespace_dir(const char *name,
+					    struct dentry *parent,
+					    int (*mkdir)(const char *name),
+					    int (*rmdir)(const char *name));
+
 bool tracefs_initialized(void);
 
 #endif /* CONFIG_TRACING */
-- 
2.25.1

