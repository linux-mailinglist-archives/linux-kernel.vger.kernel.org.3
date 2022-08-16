Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0334E595F91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiHPPrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbiHPPr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:47:29 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA8532064
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:43:58 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-tlIXQnlMPj-Vw1maJoRJmw-1; Tue, 16 Aug 2022 11:43:53 -0400
X-MC-Unique: tlIXQnlMPj-Vw1maJoRJmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6970380231E;
        Tue, 16 Aug 2022 15:43:53 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.40.208.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14B452166B26;
        Tue, 16 Aug 2022 15:43:51 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH v1 1/3] sysctl: Allow change system v ipc sysctls inside ipc namespace
Date:   Tue, 16 Aug 2022 17:42:43 +0200
Message-Id: <63e9e1ff5f988108ceb663a2fbc23a137b0b4311.1660664258.git.legion@kernel.org>
In-Reply-To: <cover.1660664258.git.legion@kernel.org>
References: <87wnc1i2wo.fsf@email.froward.int.ebiederm.org> <cover.1660664258.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rootless containers are not allowed to modify kernel IPC parameters.

All default limits are set to such high values that in fact there are no
limits at all. All limits are not inherited and are initialized to
default values when a new ipc_namespace is created.

For new ipc_namespace:

size_t       ipc_ns.shm_ctlmax = SHMMAX; // (ULONG_MAX - (1UL << 24))
size_t       ipc_ns.shm_ctlall = SHMALL; // (ULONG_MAX - (1UL << 24))
int          ipc_ns.shm_ctlmni = IPCMNI; // (1 << 15)
int          ipc_ns.shm_rmid_forced = 0;
unsigned int ipc_ns.msg_ctlmax = MSGMAX; // 8192
unsigned int ipc_ns.msg_ctlmni = MSGMNI; // 32000
unsigned int ipc_ns.msg_ctlmnb = MSGMNB; // 16384

The shm_tot (total amount of shared pages) has also ceased to be
global, it is located in ipc_namespace and is not inherited from
anywhere.

In such conditions, it cannot be said that these limits limit anything.
The real limiter for them is cgroups.

If we allow rootless containers to change these parameters, then it can
only be reduced.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index ef313ecfb53a..87eb1b1e42fa 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -192,23 +192,47 @@ static int set_is_seen(struct ctl_table_set *set)
 
 static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
 {
-	int mode = table->mode;
-
-#ifdef CONFIG_CHECKPOINT_RESTORE
 	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
 
+#ifdef CONFIG_CHECKPOINT_RESTORE
 	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
 	    checkpoint_restore_ns_capable(ns->user_ns))
-		mode = 0666;
+		return 0666;
 #endif
-	return mode;
+	if (ns->user_ns != &init_user_ns) {
+		kuid_t ns_root_uid = make_kuid(ns->user_ns, 0);
+		kgid_t ns_root_gid = make_kgid(ns->user_ns, 0);
+
+		if (uid_valid(ns_root_uid) && uid_eq(current_euid(), ns_root_uid))
+			return table->mode >> 6;
+
+		if (gid_valid(ns_root_gid) && in_egroup_p(ns_root_gid))
+			return table->mode >> 3;
+	}
+
+	return table->mode;
+}
+
+static void ipc_set_ownership(struct ctl_table_header *head,
+			      struct ctl_table *table,
+			      kuid_t *uid, kgid_t *gid)
+{
+	struct ipc_namespace *ns =
+		container_of(head->set, struct ipc_namespace, ipc_set);
+
+	kuid_t ns_root_uid = make_kuid(ns->user_ns, 0);
+	kgid_t ns_root_gid = make_kgid(ns->user_ns, 0);
+
+	*uid = uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
+	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
 }
 
 static struct ctl_table_root set_root = {
 	.lookup = set_lookup,
 	.permissions = ipc_permissions,
+	.set_ownership = ipc_set_ownership,
 };
 
 bool setup_ipc_sysctls(struct ipc_namespace *ns)
-- 
2.33.4

