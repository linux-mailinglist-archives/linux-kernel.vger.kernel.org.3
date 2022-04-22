Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2350B7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiDVM5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiDVM4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:56:51 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D6C0527F5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:53:57 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-aAbXDRs3NLWNoZry2Z3Lxw-1; Fri, 22 Apr 2022 08:53:52 -0400
X-MC-Unique: aAbXDRs3NLWNoZry2Z3Lxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36940101AA45;
        Fri, 22 Apr 2022 12:53:51 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2EFEC28107;
        Fri, 22 Apr 2022 12:53:48 +0000 (UTC)
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
Subject: [PATCH v1 1/4] ipc: Remove extra1 field abuse to pass ipc namespace
Date:   Fri, 22 Apr 2022 14:53:37 +0200
Message-Id: <e2c8df40672ca854b754cc3a412be2d6f684ac8b.1650631347.git.legion@kernel.org>
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

Eric Biederman pointed out that using .extra1 to pass ipc namespace
looks like an ugly hack and there is a better solution.

Link: https://lore.kernel.org/lkml/87czib9g38.fsf@email.froward.int.ebiederm.org/
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 15210ac47e9e..eb7ba8e0a355 100644
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
@@ -55,20 +50,15 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
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
 
 	if (!ret)
-		ret = sem_check_semmni(current->nsproxy->ipc_ns);
+		ret = sem_check_semmni(ns);
 
 	/*
 	 * Reset the semmni value if an error happens.
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
2.33.2

