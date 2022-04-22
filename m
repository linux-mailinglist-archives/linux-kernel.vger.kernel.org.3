Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F44650B7B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiDVM54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiDVM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:56:55 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1386527F5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:54:02 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-Yr3lvMn-Mpec8zFWnc3kCg-1; Fri, 22 Apr 2022 08:53:58 -0400
X-MC-Unique: Yr3lvMn-Mpec8zFWnc3kCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12A603C1E8FA;
        Fri, 22 Apr 2022 12:53:57 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57964C44CCF;
        Fri, 22 Apr 2022 12:53:54 +0000 (UTC)
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
Subject: [PATCH v1 3/4] ipc: Check permissions for checkpoint_restart sysctls at open time
Date:   Fri, 22 Apr 2022 14:53:39 +0200
Message-Id: <8b415b6b297d1143106bbcf57a269eb744bfdf81.1650631347.git.legion@kernel.org>
In-Reply-To: <cover.1650631347.git.legion@kernel.org>
References: <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com> <cover.1650631347.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
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
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 54 ++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index ff99d0305a5b..5a58598d48c8 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -68,25 +68,6 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 	return ret;
 }
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
-static int proc_ipc_dointvec_minmax_checkpoint_restore(struct ctl_table *table,
-		int write, void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
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
-- 
2.33.2

