Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F6D495F76
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380549AbiAUNKR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 08:10:17 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:23857 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245103AbiAUNKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:10:16 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-2fp-tSzhPpi_DP4pLkh_6Q-1; Fri, 21 Jan 2022 08:10:12 -0500
X-MC-Unique: 2fp-tSzhPpi_DP4pLkh_6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDBD983DEE1;
        Fri, 21 Jan 2022 13:10:10 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A985078AA0;
        Fri, 21 Jan 2022 13:09:11 +0000 (UTC)
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
Subject: [RFC PATCH v3 2/4] ipc: Store ipc sysctls in the ipc namespace
Date:   Fri, 21 Jan 2022 14:08:39 +0100
Message-Id: <5cee8775a57c18d56701b39d28dfbe9ad8a7cc38.1642769810.git.legion@kernel.org>
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

The ipc sysctls are not available for modification inside the user
namespace. Following the mqueue sysctls, we changed the implementation
to be more userns friendly.

So far, the changes do not provide additional access to files. This
will be done in a future patch.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/ipc_namespace.h |  21 ++++
 ipc/ipc_sysctl.c              | 189 ++++++++++++++++++++++------------
 ipc/namespace.c               |   4 +
 3 files changed, 147 insertions(+), 67 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index fa787d97d60a..94af746704fa 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -67,6 +67,9 @@ struct ipc_namespace {
 	struct ctl_table_set	mq_set;
 	struct ctl_table_header	*mq_sysctls;
 
+	struct ctl_table_set	set;
+	struct ctl_table_header	*ipc_sysctls;
+
 	/* user_ns which owns the ipc ns */
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
@@ -188,4 +191,22 @@ static inline bool setup_mq_sysctls(struct ipc_namespace *ns)
 }
 
 #endif /* CONFIG_POSIX_MQUEUE_SYSCTL */
+
+#ifdef CONFIG_SYSVIPC_SYSCTL
+
+bool setup_ipc_sysctls(struct ipc_namespace *ns);
+void retire_ipc_sysctls(struct ipc_namespace *ns);
+
+#else /* CONFIG_SYSVIPC_SYSCTL */
+
+static inline void retire_ipc_sysctls(struct ipc_namespace *ns)
+{
+}
+
+static inline bool setup_ipc_sysctls(struct ipc_namespace *ns)
+{
+	return true;
+}
+
+#endif /* CONFIG_SYSVIPC_SYSCTL */
 #endif
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index f101c171753f..dd87ba12f5e3 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -13,43 +13,22 @@
 #include <linux/capability.h>
 #include <linux/ipc_namespace.h>
 #include <linux/msg.h>
+#include <linux/slab.h>
 #include "util.h"
 
-static void *get_ipc(struct ctl_table *table)
-{
-	char *which = table->data;
-	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
-	which = (which - (char *)&init_ipc_ns) + (char *)ipc_ns;
-	return which;
-}
-
-static int proc_ipc_dointvec(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct ctl_table ipc_table;
-
-	memcpy(&ipc_table, table, sizeof(ipc_table));
-	ipc_table.data = get_ipc(table);
-
-	return proc_dointvec(&ipc_table, write, buffer, lenp, ppos);
-}
-
-static int proc_ipc_dointvec_minmax(struct ctl_table *table, int write,
+static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct ipc_namespace *ns = table->extra1;
 	struct ctl_table ipc_table;
+	int err;
 
 	memcpy(&ipc_table, table, sizeof(ipc_table));
-	ipc_table.data = get_ipc(table);
 
-	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
-}
+	ipc_table.extra1 = SYSCTL_ZERO;
+	ipc_table.extra2 = SYSCTL_ONE;
 
-static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
-	int err = proc_ipc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	err = proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
 
 	if (err < 0)
 		return err;
@@ -58,17 +37,6 @@ static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
 	return err;
 }
 
-static int proc_ipc_doulongvec_minmax(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct ctl_table ipc_table;
-	memcpy(&ipc_table, table, sizeof(ipc_table));
-	ipc_table.data = get_ipc(table);
-
-	return proc_doulongvec_minmax(&ipc_table, write, buffer,
-					lenp, ppos);
-}
-
 static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -87,11 +55,17 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 	void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct ipc_namespace *ns = table->extra1;
+	struct ctl_table ipc_table;
 	int ret, semmni;
-	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+
+	memcpy(&ipc_table, table, sizeof(ipc_table));
+
+	ipc_table.extra1 = NULL;
+	ipc_table.extra2 = NULL;
 
 	semmni = ns->sem_ctls[3];
-	ret = proc_ipc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
 
 	if (!ret)
 		ret = sem_check_semmni(current->nsproxy->ipc_ns);
@@ -108,12 +82,18 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 static int proc_ipc_dointvec_minmax_checkpoint_restore(struct ctl_table *table,
 		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct user_namespace *user_ns = current->nsproxy->ipc_ns->user_ns;
+	struct ipc_namespace *ns = table->extra1;
+	struct ctl_table ipc_table;
 
-	if (write && !checkpoint_restore_ns_capable(user_ns))
+	if (write && !checkpoint_restore_ns_capable(ns->user_ns))
 		return -EPERM;
 
-	return proc_ipc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	memcpy(&ipc_table, table, sizeof(ipc_table));
+
+	ipc_table.extra1 = SYSCTL_ZERO;
+	ipc_table.extra2 = SYSCTL_INT_MAX;
+
+	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
 }
 #endif
 
@@ -121,27 +101,27 @@ int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
 int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
 
-static struct ctl_table ipc_kern_table[] = {
+static struct ctl_table ipc_sysctls[] = {
 	{
 		.procname	= "shmmax",
 		.data		= &init_ipc_ns.shm_ctlmax,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmax),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_doulongvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 	},
 	{
 		.procname	= "shmall",
 		.data		= &init_ipc_ns.shm_ctlall,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlall),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_doulongvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 	},
 	{
 		.procname	= "shmmni",
 		.data		= &init_ipc_ns.shm_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ipc_mni,
 	},
@@ -151,15 +131,13 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "msgmax",
 		.data		= &init_ipc_ns.msg_ctlmax,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmax),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
 	},
@@ -168,7 +146,7 @@ static struct ctl_table ipc_kern_table[] = {
 		.data		= &init_ipc_ns.msg_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ipc_mni,
 	},
@@ -186,7 +164,7 @@ static struct ctl_table ipc_kern_table[] = {
 		.data		= &init_ipc_ns.msg_ctlmnb,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmnb),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
 	},
@@ -204,8 +182,6 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
 		.mode		= 0666,
 		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "msg_next_id",
@@ -213,8 +189,6 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
 		.mode		= 0666,
 		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "shm_next_id",
@@ -222,25 +196,106 @@ static struct ctl_table ipc_kern_table[] = {
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
 		.mode		= 0666,
 		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
 	},
 #endif
 	{}
 };
 
-static struct ctl_table ipc_root_table[] = {
-	{
-		.procname	= "kernel",
-		.mode		= 0555,
-		.child		= ipc_kern_table,
-	},
-	{}
+static struct ctl_table_set *set_lookup(struct ctl_table_root *root)
+{
+	return &current->nsproxy->ipc_ns->set;
+}
+
+static int set_is_seen(struct ctl_table_set *set)
+{
+	return &current->nsproxy->ipc_ns->set == set;
+}
+
+static struct ctl_table_root set_root = {
+	.lookup = set_lookup,
 };
 
+bool setup_ipc_sysctls(struct ipc_namespace *ns)
+{
+	struct ctl_table *tbl;
+
+	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
+
+	tbl = kmemdup(ipc_sysctls, sizeof(ipc_sysctls), GFP_KERNEL);
+	if (tbl) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(ipc_sysctls); i++) {
+			if (tbl[i].data == &init_ipc_ns.shm_ctlmax) {
+				tbl[i].data = &ns->shm_ctlmax;
+
+			} else if (tbl[i].data == &init_ipc_ns.shm_ctlall) {
+				tbl[i].data = &ns->shm_ctlall;
+
+			} else if (tbl[i].data == &init_ipc_ns.shm_ctlmni) {
+				tbl[i].data = &ns->shm_ctlmni;
+
+			} else if (tbl[i].data == &init_ipc_ns.shm_rmid_forced) {
+				tbl[i].data = &ns->shm_rmid_forced;
+				tbl[i].extra1 = ns;
+
+			} else if (tbl[i].data == &init_ipc_ns.msg_ctlmax) {
+				tbl[i].data = &ns->msg_ctlmax;
+
+			} else if (tbl[i].data == &init_ipc_ns.msg_ctlmni) {
+				tbl[i].data = &ns->msg_ctlmni;
+
+			} else if (tbl[i].data == &init_ipc_ns.msg_ctlmnb) {
+				tbl[i].data = &ns->msg_ctlmnb;
+
+			} else if (tbl[i].data == &init_ipc_ns.sem_ctls) {
+				tbl[i].data = &ns->sem_ctls;
+				tbl[i].extra1 = ns;
+#ifdef CONFIG_CHECKPOINT_RESTORE
+			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SEM_IDS].next_id) {
+				tbl[i].data = &ns->ids[IPC_SEM_IDS].next_id;
+				tbl[i].extra1 = ns;
+
+			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_MSG_IDS].next_id) {
+				tbl[i].data = &ns->ids[IPC_MSG_IDS].next_id;
+				tbl[i].extra1 = ns;
+
+			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SHM_IDS].next_id) {
+				tbl[i].data = &ns->ids[IPC_SHM_IDS].next_id;
+				tbl[i].extra1 = ns;
+#endif
+			} else {
+				tbl[i].data = NULL;
+			}
+		}
+
+		ns->ipc_sysctls = __register_sysctl_table(&ns->set, "kernel", tbl);
+	}
+	if (!ns->ipc_sysctls) {
+		kfree(tbl);
+		retire_sysctl_set(&ns->set);
+		return false;
+	}
+
+	return true;
+}
+
+void retire_ipc_sysctls(struct ipc_namespace *ns)
+{
+	struct ctl_table *tbl;
+
+	tbl = ns->ipc_sysctls->ctl_table_arg;
+	unregister_sysctl_table(ns->ipc_sysctls);
+	retire_sysctl_set(&ns->set);
+	kfree(tbl);
+}
+
 static int __init ipc_sysctl_init(void)
 {
-	register_sysctl_table(ipc_root_table);
+	if (!setup_ipc_sysctls(&init_ipc_ns)) {
+		pr_warn("ipc sysctl registration failed\n");
+		return -ENOMEM;
+	}
 	return 0;
 }
 
diff --git a/ipc/namespace.c b/ipc/namespace.c
index f760243ca685..754f3237194a 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -63,6 +63,9 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (!setup_mq_sysctls(ns))
 		goto fail_put;
 
+	if (!setup_ipc_sysctls(ns))
+		goto fail_put;
+
 	sem_init_ns(ns);
 	msg_init_ns(ns);
 	shm_init_ns(ns);
@@ -130,6 +133,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	shm_exit_ns(ns);
 
 	retire_mq_sysctls(ns);
+	retire_ipc_sysctls(ns);
 
 	dec_ipc_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-- 
2.33.0

