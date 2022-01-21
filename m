Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DD8495F78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380554AbiAUNKZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 08:10:25 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:58576 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245103AbiAUNKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:10:22 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-ArJwf6q4PCK3KbstVWpcDA-1; Fri, 21 Jan 2022 08:10:16 -0500
X-MC-Unique: ArJwf6q4PCK3KbstVWpcDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0242101F7A5;
        Fri, 21 Jan 2022 13:10:14 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F36078AA0;
        Fri, 21 Jan 2022 13:10:11 +0000 (UTC)
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
Subject: [RFC PATCH v3 3/4] ipc: Merge ipc_sysctl and mq_sysctl
Date:   Fri, 21 Jan 2022 14:08:40 +0100
Message-Id: <1dba01b2f206a097fb2fc614338e1a7aebac5567.1642769810.git.legion@kernel.org>
In-Reply-To: <cover.1642769810.git.legion@kernel.org>
References: <87tuebwo99.fsf@email.froward.int.ebiederm.org> <cover.1642769810.git.legion@kernel.org>
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

Both mq_sysctl and ipc_sysctl are in the ipc namespace and both use
identical helpers so they can be merged into a single source file.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/ipc_namespace.h |  41 ++---------
 ipc/Makefile                  |   7 +-
 ipc/ipc_sysctl.c              | 131 ++++++++++++++++++++++++++++++++--
 ipc/mq_sysctl.c               | 131 ----------------------------------
 ipc/mqueue.c                  |   5 --
 ipc/namespace.c               |   4 --
 ipc/util.h                    |   4 +-
 7 files changed, 132 insertions(+), 191 deletions(-)
 delete mode 100644 ipc/mq_sysctl.c

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 94af746704fa..461540d1cac4 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -64,10 +64,8 @@ struct ipc_namespace {
 	unsigned int    mq_msg_default;
 	unsigned int    mq_msgsize_default;
 
-	struct ctl_table_set	mq_set;
-	struct ctl_table_header	*mq_sysctls;
-
 	struct ctl_table_set	set;
+	struct ctl_table_header	*mq_sysctls;
 	struct ctl_table_header	*ipc_sysctls;
 
 	/* user_ns which owns the ipc ns */
@@ -88,8 +86,6 @@ extern void shm_destroy_orphaned(struct ipc_namespace *ns);
 static inline void shm_destroy_orphaned(struct ipc_namespace *ns) {}
 #endif /* CONFIG_SYSVIPC */
 
-#ifdef CONFIG_POSIX_MQUEUE
-extern int mq_init_ns(struct ipc_namespace *ns);
 /*
  * POSIX Message Queue default values:
  *
@@ -123,6 +119,9 @@ extern int mq_init_ns(struct ipc_namespace *ns);
 #define DFLT_MSGSIZE		     8192U
 #define DFLT_MSGSIZEMAX		     8192
 #define HARD_MSGSIZEMAX	    (16*1024*1024)
+
+#ifdef CONFIG_POSIX_MQUEUE
+extern int mq_init_ns(struct ipc_namespace *ns);
 #else
 static inline int mq_init_ns(struct ipc_namespace *ns) { return 0; }
 #endif
@@ -174,39 +173,7 @@ static inline void put_ipc_ns(struct ipc_namespace *ns)
 }
 #endif
 
-#ifdef CONFIG_POSIX_MQUEUE_SYSCTL
-
-void retire_mq_sysctls(struct ipc_namespace *ns);
-bool setup_mq_sysctls(struct ipc_namespace *ns);
-
-#else /* CONFIG_POSIX_MQUEUE_SYSCTL */
-
-static inline void retire_mq_sysctls(struct ipc_namespace *ns)
-{
-}
-
-static inline bool setup_mq_sysctls(struct ipc_namespace *ns)
-{
-	return true;
-}
-
-#endif /* CONFIG_POSIX_MQUEUE_SYSCTL */
-
-#ifdef CONFIG_SYSVIPC_SYSCTL
-
 bool setup_ipc_sysctls(struct ipc_namespace *ns);
 void retire_ipc_sysctls(struct ipc_namespace *ns);
 
-#else /* CONFIG_SYSVIPC_SYSCTL */
-
-static inline void retire_ipc_sysctls(struct ipc_namespace *ns)
-{
-}
-
-static inline bool setup_ipc_sysctls(struct ipc_namespace *ns)
-{
-	return true;
-}
-
-#endif /* CONFIG_SYSVIPC_SYSCTL */
 #endif
diff --git a/ipc/Makefile b/ipc/Makefile
index c2558c430f51..f79eab42a4dc 100644
--- a/ipc/Makefile
+++ b/ipc/Makefile
@@ -4,9 +4,6 @@
 #
 
 obj-$(CONFIG_SYSVIPC_COMPAT) += compat.o
-obj-$(CONFIG_SYSVIPC) += util.o msgutil.o msg.o sem.o shm.o syscall.o
-obj-$(CONFIG_SYSVIPC_SYSCTL) += ipc_sysctl.o
-obj-$(CONFIG_POSIX_MQUEUE) += mqueue.o msgutil.o
+obj-$(CONFIG_SYSVIPC) += util.o msgutil.o msg.o sem.o shm.o syscall.o ipc_sysctl.o
+obj-$(CONFIG_POSIX_MQUEUE) += mqueue.o msgutil.o ipc_sysctl.o
 obj-$(CONFIG_IPC_NS) += namespace.o
-obj-$(CONFIG_POSIX_MQUEUE_SYSCTL) += mq_sysctl.o
-
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index dd87ba12f5e3..9fc8e3e75be7 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -201,6 +201,59 @@ static struct ctl_table ipc_sysctls[] = {
 	{}
 };
 
+static int msg_max_limit_min = MIN_MSGMAX;
+static int msg_max_limit_max = HARD_MSGMAX;
+
+static int msg_maxsize_limit_min = MIN_MSGSIZEMAX;
+static int msg_maxsize_limit_max = HARD_MSGSIZEMAX;
+
+static struct ctl_table mq_sysctls[] = {
+	{
+		.procname	= "queues_max",
+		.data		= &init_ipc_ns.mq_queues_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "msg_max",
+		.data		= &init_ipc_ns.mq_msg_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &msg_max_limit_min,
+		.extra2		= &msg_max_limit_max,
+	},
+	{
+		.procname	= "msgsize_max",
+		.data		= &init_ipc_ns.mq_msgsize_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &msg_maxsize_limit_min,
+		.extra2		= &msg_maxsize_limit_max,
+	},
+	{
+		.procname	= "msg_default",
+		.data		= &init_ipc_ns.mq_msg_default,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &msg_max_limit_min,
+		.extra2		= &msg_max_limit_max,
+	},
+	{
+		.procname	= "msgsize_default",
+		.data		= &init_ipc_ns.mq_msgsize_default,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &msg_maxsize_limit_min,
+		.extra2		= &msg_maxsize_limit_max,
+	},
+	{}
+};
+
 static struct ctl_table_set *set_lookup(struct ctl_table_root *root)
 {
 	return &current->nsproxy->ipc_ns->set;
@@ -215,12 +268,10 @@ static struct ctl_table_root set_root = {
 	.lookup = set_lookup,
 };
 
-bool setup_ipc_sysctls(struct ipc_namespace *ns)
+static bool register_ipc_sysctl_table(struct ipc_namespace *ns)
 {
 	struct ctl_table *tbl;
 
-	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
-
 	tbl = kmemdup(ipc_sysctls, sizeof(ipc_sysctls), GFP_KERNEL);
 	if (tbl) {
 		int i;
@@ -273,23 +324,91 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 	}
 	if (!ns->ipc_sysctls) {
 		kfree(tbl);
-		retire_sysctl_set(&ns->set);
 		return false;
 	}
 
 	return true;
 }
 
-void retire_ipc_sysctls(struct ipc_namespace *ns)
+static void unregister_ipc_sysctl_table(struct ipc_namespace *ns)
 {
 	struct ctl_table *tbl;
 
 	tbl = ns->ipc_sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->ipc_sysctls);
-	retire_sysctl_set(&ns->set);
 	kfree(tbl);
 }
 
+static bool register_mqueue_sysctl_table(struct ipc_namespace *ns)
+{
+	struct ctl_table *tbl;
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
+		ns->mq_sysctls = __register_sysctl_table(&ns->set, "fs/mqueue", tbl);
+	}
+	if (!ns->mq_sysctls) {
+		kfree(tbl);
+		return false;
+	}
+
+	return true;
+}
+
+static void unregister_mqueue_sysctl_table(struct ipc_namespace *ns)
+{
+	struct ctl_table *tbl;
+
+	tbl = ns->mq_sysctls->ctl_table_arg;
+	unregister_sysctl_table(ns->mq_sysctls);
+	kfree(tbl);
+}
+
+bool setup_ipc_sysctls(struct ipc_namespace *ns)
+{
+	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
+
+	if (IS_ENABLED(CONFIG_SYSVIPC_SYSCTL))
+		register_ipc_sysctl_table(ns);
+
+	if (IS_ENABLED(CONFIG_POSIX_MQUEUE_SYSCTL))
+		register_mqueue_sysctl_table(ns);
+
+	return true;
+}
+
+void retire_ipc_sysctls(struct ipc_namespace *ns)
+{
+	if (IS_ENABLED(CONFIG_SYSVIPC_SYSCTL))
+		unregister_ipc_sysctl_table(ns);
+
+	if (IS_ENABLED(CONFIG_POSIX_MQUEUE_SYSCTL))
+		unregister_mqueue_sysctl_table(ns);
+
+	retire_sysctl_set(&ns->set);
+}
+
 static int __init ipc_sysctl_init(void)
 {
 	if (!setup_ipc_sysctls(&init_ipc_ns)) {
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
deleted file mode 100644
index fbf6a8b93a26..000000000000
--- a/ipc/mq_sysctl.c
+++ /dev/null
@@ -1,131 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  Copyright (C) 2007 IBM Corporation
- *
- *  Author: Cedric Le Goater <clg@fr.ibm.com>
- */
-
-#include <linux/nsproxy.h>
-#include <linux/ipc_namespace.h>
-#include <linux/sysctl.h>
-
-#include <linux/stat.h>
-#include <linux/capability.h>
-#include <linux/slab.h>
-
-static int msg_max_limit_min = MIN_MSGMAX;
-static int msg_max_limit_max = HARD_MSGMAX;
-
-static int msg_maxsize_limit_min = MIN_MSGSIZEMAX;
-static int msg_maxsize_limit_max = HARD_MSGSIZEMAX;
-
-static struct ctl_table mq_sysctls[] = {
-	{
-		.procname	= "queues_max",
-		.data		= &init_ipc_ns.mq_queues_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "msg_max",
-		.data		= &init_ipc_ns.mq_msg_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_max_limit_min,
-		.extra2		= &msg_max_limit_max,
-	},
-	{
-		.procname	= "msgsize_max",
-		.data		= &init_ipc_ns.mq_msgsize_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_maxsize_limit_min,
-		.extra2		= &msg_maxsize_limit_max,
-	},
-	{
-		.procname	= "msg_default",
-		.data		= &init_ipc_ns.mq_msg_default,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_max_limit_min,
-		.extra2		= &msg_max_limit_max,
-	},
-	{
-		.procname	= "msgsize_default",
-		.data		= &init_ipc_ns.mq_msgsize_default,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &msg_maxsize_limit_min,
-		.extra2		= &msg_maxsize_limit_max,
-	},
-	{}
-};
-
-static struct ctl_table_set *set_lookup(struct ctl_table_root *root)
-{
-	return &current->nsproxy->ipc_ns->mq_set;
-}
-
-static int set_is_seen(struct ctl_table_set *set)
-{
-	return &current->nsproxy->ipc_ns->mq_set == set;
-}
-
-static struct ctl_table_root set_root = {
-	.lookup = set_lookup,
-};
-
-bool setup_mq_sysctls(struct ipc_namespace *ns)
-{
-	struct ctl_table *tbl;
-
-	setup_sysctl_set(&ns->mq_set, &set_root, set_is_seen);
-
-	tbl = kmemdup(mq_sysctls, sizeof(mq_sysctls), GFP_KERNEL);
-	if (tbl) {
-		int i;
-
-		for (i = 0; i < ARRAY_SIZE(mq_sysctls); i++) {
-			if (tbl[i].data == &init_ipc_ns.mq_queues_max)
-				tbl[i].data = &ns->mq_queues_max;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msg_max)
-				tbl[i].data = &ns->mq_msg_max;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msgsize_max)
-				tbl[i].data = &ns->mq_msgsize_max;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msg_default)
-				tbl[i].data = &ns->mq_msg_default;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msgsize_default)
-				tbl[i].data = &ns->mq_msgsize_default;
-			else
-				tbl[i].data = NULL;
-		}
-
-		ns->mq_sysctls = __register_sysctl_table(&ns->mq_set, "fs/mqueue", tbl);
-	}
-	if (!ns->mq_sysctls) {
-		kfree(tbl);
-		retire_sysctl_set(&ns->mq_set);
-		return false;
-	}
-
-	return true;
-}
-
-void retire_mq_sysctls(struct ipc_namespace *ns)
-{
-	struct ctl_table *tbl;
-
-	tbl = ns->mq_sysctls->ctl_table_arg;
-	unregister_sysctl_table(ns->mq_sysctls);
-	retire_sysctl_set(&ns->mq_set);
-	kfree(tbl);
-}
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 1b4a3be71636..f08e9f8db195 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1711,11 +1711,6 @@ static int __init init_mqueue_fs(void)
 	if (mqueue_inode_cachep == NULL)
 		return -ENOMEM;
 
-	if (!setup_mq_sysctls(&init_ipc_ns)) {
-		pr_warn("sysctl registration failed\n");
-		return -ENOMEM;
-	}
-
 	error = register_filesystem(&mqueue_fs_type);
 	if (error)
 		goto out_sysctl;
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 754f3237194a..e18b6b5c2a46 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -60,9 +60,6 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 		goto fail_put;
 
 	err = -ENOMEM;
-	if (!setup_mq_sysctls(ns))
-		goto fail_put;
-
 	if (!setup_ipc_sysctls(ns))
 		goto fail_put;
 
@@ -132,7 +129,6 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
 
-	retire_mq_sysctls(ns);
 	retire_ipc_sysctls(ns);
 
 	dec_ipc_namespaces(ns->ucounts);
diff --git a/ipc/util.h b/ipc/util.h
index 2dd7ce0416d8..e88e486e9048 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -31,18 +31,16 @@
 #define IPCMNI			(1 << IPCMNI_SHIFT)
 #define IPCMNI_EXTEND		(1 << IPCMNI_EXTEND_SHIFT)
 
-#ifdef CONFIG_SYSVIPC_SYSCTL
 extern int ipc_mni;
 extern int ipc_mni_shift;
 extern int ipc_min_cycle;
 
+#ifdef CONFIG_SYSVIPC_SYSCTL
 #define ipcmni_seq_shift()	ipc_mni_shift
 #define IPCMNI_IDX_MASK		((1 << ipc_mni_shift) - 1)
 
 #else /* CONFIG_SYSVIPC_SYSCTL */
 
-#define ipc_mni			IPCMNI
-#define ipc_min_cycle		((int)RADIX_TREE_MAP_SIZE)
 #define ipcmni_seq_shift()	IPCMNI_SHIFT
 #define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
 #endif /* CONFIG_SYSVIPC_SYSCTL */
-- 
2.33.0

