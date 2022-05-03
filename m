Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19354518968
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiECQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239103AbiECQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:16:08 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E98AF1EAD4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:12:35 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-ACE-lopCPbagO-0vhgpgGA-1; Tue, 03 May 2022 12:12:11 -0400
X-MC-Unique: ACE-lopCPbagO-0vhgpgGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E18CCB15AA6;
        Tue,  3 May 2022 13:40:23 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D8539E89;
        Tue,  3 May 2022 13:40:21 +0000 (UTC)
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
Subject: [PATCH v2 2/4] ipc: Remove extra1 field abuse to pass ipc namespace
Date:   Tue,  3 May 2022 15:39:55 +0200
Message-Id: <93df64a8fe93ba20ebbe1d9f8eda484b2f325426.1651584847.git.legion@kernel.org>
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

Eric Biederman pointed out that using .extra1 to pass ipc namespace
looks like an ugly hack and there is a better solution. We can get the
ipc_namespace using the .data field.

Link: https://lore.kernel.org/lkml/87czib9g38.fsf@email.froward.int.ebiederm.org/
Fixes: 1f5c135ee509 ("ipc: Store ipc sysctls in the ipc namespace")
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index d1d5204cf589..eb7ba8e0a355 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -19,16 +19,11 @@
 static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct ipc_namespace *ns = table->extra1;
-	struct ctl_table ipc_table;
+	struct ipc_namespace *ns =
+		container_of(table->data, struct ipc_namespace, shm_rmid_forced);
 	int err;
 
-	memcpy(&ipc_table, table, sizeof(ipc_table));
-
-	ipc_table.extra1 = SYSCTL_ZERO;
-	ipc_table.extra2 = SYSCTL_ONE;
-
-	err = proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
+	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (err < 0)
 		return err;
@@ -55,15 +50,10 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 	void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct ipc_namespace *ns = table->extra1;
-	struct ctl_table ipc_table;
+	struct ipc_namespace *ns =
+		container_of(table->data, struct ipc_namespace, sem_ctls);
 	int ret, semmni;
 
-	memcpy(&ipc_table, table, sizeof(ipc_table));
-
-	ipc_table.extra1 = NULL;
-	ipc_table.extra2 = NULL;
-
 	semmni = ns->sem_ctls[3];
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
 
@@ -131,6 +121,8 @@ static struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "msgmax",
@@ -237,7 +229,6 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
 			} else if (tbl[i].data == &init_ipc_ns.shm_rmid_forced) {
 				tbl[i].data = &ns->shm_rmid_forced;
-				tbl[i].extra1 = ns;
 
 			} else if (tbl[i].data == &init_ipc_ns.msg_ctlmax) {
 				tbl[i].data = &ns->msg_ctlmax;
@@ -250,7 +241,6 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
 			} else if (tbl[i].data == &init_ipc_ns.sem_ctls) {
 				tbl[i].data = &ns->sem_ctls;
-				tbl[i].extra1 = ns;
 #ifdef CONFIG_CHECKPOINT_RESTORE
 			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SEM_IDS].next_id) {
 				tbl[i].data = &ns->ids[IPC_SEM_IDS].next_id;
-- 
2.33.3

