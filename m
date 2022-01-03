Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD753483487
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbiACQEv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jan 2022 11:04:51 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:43374 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231807AbiACQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:04:50 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-a6jDEbciPvGDJaKc2IAQjw-1; Mon, 03 Jan 2022 11:04:45 -0500
X-MC-Unique: a6jDEbciPvGDJaKc2IAQjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03F5F801AAB;
        Mon,  3 Jan 2022 16:04:44 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4ADE57953D;
        Mon,  3 Jan 2022 16:04:37 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v1] ipc: Store mqueue sysctls in the ipc namespace
Date:   Mon,  3 Jan 2022 17:04:03 +0100
Message-Id: <0f0408bb7fbf3187966a9bf19a98642a5d9669fe.1641225760.git.legion@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=legion@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the mqueue sysctls take ipc namespaces into account in a
rather hacky way. This works in most cases, but does not respect the
user namespace.

Within the user namespace, the user cannot change the /proc/sys/fs/mqueue/*
parametres. This poses a problem in the rootless containers.

To solve this I changed the implementation of the mqueue sysctls just
like some other sysctls.

Before this change:

$ echo 5 | unshare -r -U -i tee /proc/sys/fs/mqueue/msg_max
tee: /proc/sys/fs/mqueue/msg_max: Permission denied
5

After this change:

$ echo 5 | unshare -r -U -i tee /proc/sys/fs/mqueue/msg_max
5

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/ipc_namespace.h |  20 ++---
 ipc/mq_sysctl.c               | 140 +++++++++++++++++++++-------------
 ipc/mqueue.c                  |  10 +--
 ipc/namespace.c               |   6 ++
 4 files changed, 103 insertions(+), 73 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index b75395ec8d52..8ecb965905f5 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -10,6 +10,7 @@
 #include <linux/ns_common.h>
 #include <linux/refcount.h>
 #include <linux/rhashtable-types.h>
+#include <linux/sysctl.h>
 
 struct user_namespace;
 
@@ -63,6 +64,11 @@ struct ipc_namespace {
 	unsigned int    mq_msg_default;
 	unsigned int    mq_msgsize_default;
 
+#ifdef CONFIG_POSIX_MQUEUE_SYSCTL
+	struct ctl_table_set	set;
+	struct ctl_table_header *sysctls;
+#endif
+
 	/* user_ns which owns the ipc ns */
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
@@ -167,17 +173,7 @@ static inline void put_ipc_ns(struct ipc_namespace *ns)
 }
 #endif
 
-#ifdef CONFIG_POSIX_MQUEUE_SYSCTL
-
-struct ctl_table_header;
-extern struct ctl_table_header *mq_register_sysctl_table(void);
-
-#else /* CONFIG_POSIX_MQUEUE_SYSCTL */
-
-static inline struct ctl_table_header *mq_register_sysctl_table(void)
-{
-	return NULL;
-}
+void retire_mq_sysctls(struct ipc_namespace *ns);
+bool setup_mq_sysctls(struct ipc_namespace *ns);
 
-#endif /* CONFIG_POSIX_MQUEUE_SYSCTL */
 #endif
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 72a92a08c848..f9826700f08c 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -9,39 +9,9 @@
 #include <linux/ipc_namespace.h>
 #include <linux/sysctl.h>
 
-#ifdef CONFIG_PROC_SYSCTL
-static void *get_mq(struct ctl_table *table)
-{
-	char *which = table->data;
-	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
-	which = (which - (char *)&init_ipc_ns) + (char *)ipc_ns;
-	return which;
-}
-
-static int proc_mq_dointvec(struct ctl_table *table, int write,
-			    void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct ctl_table mq_table;
-	memcpy(&mq_table, table, sizeof(mq_table));
-	mq_table.data = get_mq(table);
-
-	return proc_dointvec(&mq_table, write, buffer, lenp, ppos);
-}
-
-static int proc_mq_dointvec_minmax(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct ctl_table mq_table;
-	memcpy(&mq_table, table, sizeof(mq_table));
-	mq_table.data = get_mq(table);
-
-	return proc_dointvec_minmax(&mq_table, write, buffer,
-					lenp, ppos);
-}
-#else
-#define proc_mq_dointvec NULL
-#define proc_mq_dointvec_minmax NULL
-#endif
+#include <linux/stat.h>
+#include <linux/capability.h>
+#include <linux/slab.h>
 
 static int msg_max_limit_min = MIN_MSGMAX;
 static int msg_max_limit_max = HARD_MSGMAX;
@@ -55,14 +25,14 @@ static struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_queues_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_mq_dointvec,
+		.proc_handler	= proc_dointvec,
 	},
 	{
 		.procname	= "msg_max",
 		.data		= &init_ipc_ns.mq_msg_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_mq_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_max_limit_min,
 		.extra2		= &msg_max_limit_max,
 	},
@@ -71,7 +41,7 @@ static struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_msgsize_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_mq_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_maxsize_limit_min,
 		.extra2		= &msg_maxsize_limit_max,
 	},
@@ -80,7 +50,7 @@ static struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_msg_default,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_mq_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_max_limit_min,
 		.extra2		= &msg_max_limit_max,
 	},
@@ -89,32 +59,92 @@ static struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_msgsize_default,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_mq_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_maxsize_limit_min,
 		.extra2		= &msg_maxsize_limit_max,
 	},
 	{}
 };
 
-static struct ctl_table mq_sysctl_dir[] = {
-	{
-		.procname	= "mqueue",
-		.mode		= 0555,
-		.child		= mq_sysctls,
-	},
-	{}
-};
+static struct ctl_table_set *
+set_lookup(struct ctl_table_root *root)
+{
+	return &current->nsproxy->ipc_ns->set;
+}
 
-static struct ctl_table mq_sysctl_root[] = {
-	{
-		.procname	= "fs",
-		.mode		= 0555,
-		.child		= mq_sysctl_dir,
-	},
-	{}
+static int set_is_seen(struct ctl_table_set *set)
+{
+	return &current->nsproxy->ipc_ns->set == set;
+}
+
+static int set_permissions(struct ctl_table_header *head, struct ctl_table *table)
+{
+	struct ipc_namespace *ns = container_of(head->set, struct ipc_namespace, set);
+	int mode;
+
+	/* Allow users with CAP_SYS_RESOURCE unrestrained access */
+	if (ns_capable(ns->user_ns, CAP_SYS_RESOURCE))
+		mode = (table->mode & S_IRWXU) >> 6;
+	else
+	/* Allow all others at most read-only access */
+		mode = table->mode & S_IROTH;
+	return (mode << 6) | (mode << 3) | mode;
+}
+
+static struct ctl_table_root set_root = {
+	.lookup = set_lookup,
+	.permissions = set_permissions,
 };
 
-struct ctl_table_header *mq_register_sysctl_table(void)
+bool setup_mq_sysctls(struct ipc_namespace *ns)
+{
+#ifdef CONFIG_POSIX_MQUEUE_SYSCTL
+	struct ctl_table *tbl;
+
+	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
+
+	tbl = kmemdup(mq_sysctls, sizeof(mq_sysctls), GFP_KERNEL);
+	if (tbl) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(mq_sysctls); i++) {
+			if (tbl[i].data == &init_ipc_ns.mq_queues_max)
+				tbl[i].data = &ns->mq_queues_max;
+
+			else if (tbl[i].data == &init_ipc_ns.mq_msg_max)
+				tbl[i].data = &ns->mq_msg_max;
+
+			else if (tbl[i].data == &init_ipc_ns.mq_msgsize_max)
+				tbl[i].data = &ns->mq_msgsize_max;
+
+			else if (tbl[i].data == &init_ipc_ns.mq_msg_default)
+				tbl[i].data = &ns->mq_msg_default;
+
+			else if (tbl[i].data == &init_ipc_ns.mq_msgsize_default)
+				tbl[i].data = &ns->mq_msgsize_default;
+			else
+				tbl[i].data = NULL;
+		}
+
+		ns->sysctls = __register_sysctl_table(&ns->set, "fs/mqueue", tbl);
+	}
+	if (!ns->sysctls) {
+		kfree(tbl);
+		retire_sysctl_set(&ns->set);
+		return false;
+	}
+#endif
+	return true;
+}
+
+void retire_mq_sysctls(struct ipc_namespace *ns)
 {
-	return register_sysctl_table(mq_sysctl_root);
+#ifdef CONFIG_POSIX_MQUEUE_SYSCTL
+	struct ctl_table *tbl;
+
+	tbl = ns->sysctls->ctl_table_arg;
+	unregister_sysctl_table(ns->sysctls);
+	retire_sysctl_set(&ns->set);
+	kfree(tbl);
+#endif
 }
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5becca9be867..1b4a3be71636 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -163,8 +163,6 @@ static void remove_notification(struct mqueue_inode_info *info);
 
 static struct kmem_cache *mqueue_inode_cachep;
 
-static struct ctl_table_header *mq_sysctl_table;
-
 static inline struct mqueue_inode_info *MQUEUE_I(struct inode *inode)
 {
 	return container_of(inode, struct mqueue_inode_info, vfs_inode);
@@ -1713,8 +1711,10 @@ static int __init init_mqueue_fs(void)
 	if (mqueue_inode_cachep == NULL)
 		return -ENOMEM;
 
-	/* ignore failures - they are not fatal */
-	mq_sysctl_table = mq_register_sysctl_table();
+	if (!setup_mq_sysctls(&init_ipc_ns)) {
+		pr_warn("sysctl registration failed\n");
+		return -ENOMEM;
+	}
 
 	error = register_filesystem(&mqueue_fs_type);
 	if (error)
@@ -1731,8 +1731,6 @@ static int __init init_mqueue_fs(void)
 out_filesystem:
 	unregister_filesystem(&mqueue_fs_type);
 out_sysctl:
-	if (mq_sysctl_table)
-		unregister_sysctl_table(mq_sysctl_table);
 	kmem_cache_destroy(mqueue_inode_cachep);
 	return error;
 }
diff --git a/ipc/namespace.c b/ipc/namespace.c
index ae83f0f2651b..f760243ca685 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -59,6 +59,10 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (err)
 		goto fail_put;
 
+	err = -ENOMEM;
+	if (!setup_mq_sysctls(ns))
+		goto fail_put;
+
 	sem_init_ns(ns);
 	msg_init_ns(ns);
 	shm_init_ns(ns);
@@ -125,6 +129,8 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
 
+	retire_mq_sysctls(ns);
+
 	dec_ipc_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-- 
2.33.0

