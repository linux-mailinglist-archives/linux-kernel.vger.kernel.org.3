Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7197D50B7AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiDVM6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447670AbiDVM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:56:52 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 391E1527F5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:53:59 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-AnjXehsdPmmzQ8-DhAtM3A-1; Fri, 22 Apr 2022 08:53:54 -0400
X-MC-Unique: AnjXehsdPmmzQ8-DhAtM3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14DCF38337EE;
        Fri, 22 Apr 2022 12:53:54 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B64BC28107;
        Fri, 22 Apr 2022 12:53:51 +0000 (UTC)
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
Subject: [PATCH v1 2/4] ipc: Use proper ipc namespace
Date:   Fri, 22 Apr 2022 14:53:38 +0200
Message-Id: <32a29b3eb5f560e30ef24cfb86e480684b49ac62.1650631347.git.legion@kernel.org>
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

As Eric Biederman pointed out, changing the namespace broke checkpoint
restore. I have reverted my previous changes.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index eb7ba8e0a355..ff99d0305a5b 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -72,7 +72,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 static int proc_ipc_dointvec_minmax_checkpoint_restore(struct ctl_table *table,
 		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct ipc_namespace *ns = table->extra1;
+	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
 	struct ctl_table ipc_table;
 
 	if (write && !checkpoint_restore_ns_capable(ns->user_ns))
@@ -244,15 +244,12 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
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
2.33.2

