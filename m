Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFA8518863
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiECPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiECPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:24:52 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDDAC13F99
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:20:55 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-SsgRhW4WNgu8b4tCmGNYIw-1; Tue, 03 May 2022 11:20:40 -0400
X-MC-Unique: SsgRhW4WNgu8b4tCmGNYIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF5831D14E1C;
        Tue,  3 May 2022 13:40:26 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CB859E6F;
        Tue,  3 May 2022 13:40:24 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux Containers <containers@lists.linux.dev>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 3/4] ipc: Check permissions for checkpoint_restart sysctls at open time
Date:   Tue,  3 May 2022 15:39:56 +0200
Message-Id: <65fa8459803830608da4610a39f33c76aa933eb9.1651584847.git.legion@kernel.org>
In-Reply-To: <cover.1651584847.git.legion@kernel.org>
References: <87sfprudal.fsf@email.froward.int.ebiederm.org> <cover.1651584847.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Eric Biederman pointed out, it is possible not to use a custom
proc_handler and check permissions for every write, but to use a
.permission handler. That will allow the checkpoint_restart sysctls to
perform all of their permission checks at open time, and not need any
other special code.

Link: https://lore.kernel.org/lkml/87czib9g38.fsf@email.froward.int.ebiederm.org/
Fixes: 1f5c135ee509 ("ipc: Store ipc sysctls in the ipc namespace")
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 57 ++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index eb7ba8e0a355..5a58598d48c8 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -68,25 +68,6 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 	return ret;
 }
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
-static int proc_ipc_dointvec_minmax_checkpoint_restore(struct ctl_table *table,
-		int write, void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct ipc_namespace *ns = table->extra1;
-	struct ctl_table ipc_table;
-
-	if (write && !checkpoint_restore_ns_capable(ns->user_ns))
-		return -EPERM;
-
-	memcpy(&ipc_table, table, sizeof(ipc_table));
-
-	ipc_table.extra1 = SYSCTL_ZERO;
-	ipc_table.extra2 = SYSCTL_INT_MAX;
-
-	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
-}
-#endif
-
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
 int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
@@ -172,22 +153,28 @@ static struct ctl_table ipc_sysctls[] = {
 		.procname	= "sem_next_id",
 		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
-		.mode		= 0666,
-		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "msg_next_id",
 		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
-		.mode		= 0666,
-		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "shm_next_id",
 		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
-		.mode		= 0666,
-		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 #endif
 	{}
@@ -203,8 +190,25 @@ static int set_is_seen(struct ctl_table_set *set)
 	return &current->nsproxy->ipc_ns->ipc_set == set;
 }
 
+static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
+{
+	int mode = table->mode;
+
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+
+	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
+	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
+	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
+	    checkpoint_restore_ns_capable(ns->user_ns))
+		mode = 0666;
+#endif
+	return mode;
+}
+
 static struct ctl_table_root set_root = {
 	.lookup = set_lookup,
+	.permissions = ipc_permissions,
 };
 
 bool setup_ipc_sysctls(struct ipc_namespace *ns)
@@ -244,15 +248,12 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 #ifdef CONFIG_CHECKPOINT_RESTORE
 			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SEM_IDS].next_id) {
 				tbl[i].data = &ns->ids[IPC_SEM_IDS].next_id;
-				tbl[i].extra1 = ns;
 
 			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_MSG_IDS].next_id) {
 				tbl[i].data = &ns->ids[IPC_MSG_IDS].next_id;
-				tbl[i].extra1 = ns;
 
 			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SHM_IDS].next_id) {
 				tbl[i].data = &ns->ids[IPC_SHM_IDS].next_id;
-				tbl[i].extra1 = ns;
 #endif
 			} else {
 				tbl[i].data = NULL;
-- 
2.33.3

