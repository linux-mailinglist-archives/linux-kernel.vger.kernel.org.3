Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D05951CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiHPFQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiHPFQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:16:32 -0400
X-Greylist: delayed 649 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 14:37:21 PDT
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC061F8DF5;
        Mon, 15 Aug 2022 14:37:19 -0700 (PDT)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oNhbJ-0006l4-5P;
        Mon, 15 Aug 2022 17:26:21 -0400
Date:   Mon, 15 Aug 2022 17:26:20 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>, linux-fs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC] fs,ipc: batch RCU synchronization in free_ipc
Message-ID: <20220815172620.5d7d4a78@imladris.surriel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TL;DR: it runs better than it looks, and I am looking for ideas on how to make it look better

---8<---

The following program will get ENOSPACE sooner or later, because
the way ipc namespaces get freed currently results in only one
ipc namespace being freed every RCU grace period.

int main()
{
	int i;

	for (i = 0; i < 1000000; i++) {
		if (unshare(CLONE_NEWIPC) < 0)
			error(EXIT_FAILURE, errno, "unshare");
	}
}

There are various ways to solve this issue, they all come down to
batching the RCU synchronization, so multiple ipc namespaces can
be freed in the same RCU grace period.

Unfortunately there seems to be a tradeoff between temporarily
allocating things on the stack, and having slightly uglier code,
or adding a struct rcu_work to the struct vfsmount.

I am not entirely happy with the way this code looks, and hoping
for suggestions on how to improve it.

However, I am quite happy with how this code runs. Between batching
the kern_unmount RCU synchronization, moving to the expedited RCU
grace period in kern_unmount_array, and grabbing things off the
llist that were added after the work item started, freeing ipc
namespaces is 2-3 orders of magnitude faster than before, and
able to keep up with the test case above.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 ipc/namespace.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index e1fcaedba4fa..ba33015f1a23 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -127,10 +127,6 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 
 static void free_ipc_ns(struct ipc_namespace *ns)
 {
-	/* mq_put_mnt() waits for a grace period as kern_unmount()
-	 * uses synchronize_rcu().
-	 */
-	mq_put_mnt(ns);
 	sem_exit_ns(ns);
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
@@ -144,14 +140,33 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	kfree(ns);
 }
 
+#define FREE_IPC_BATCH 64
 static LLIST_HEAD(free_ipc_list);
 static void free_ipc(struct work_struct *unused)
 {
-	struct llist_node *node = llist_del_all(&free_ipc_list);
-	struct ipc_namespace *n, *t;
+	struct ipc_namespace *ipc_nses[FREE_IPC_BATCH];
+	struct vfsmount *mounts[FREE_IPC_BATCH];
+	int i, j;
+
+ next_batch:
+	i = 0;
+	for (i = 0; !llist_empty(&free_ipc_list) && i < FREE_IPC_BATCH; i++) {
+		struct llist_node *node = llist_del_first(&free_ipc_list);
+		struct ipc_namespace *n = llist_entry(node,
+						      struct ipc_namespace,
+						      mnt_llist);
+		ipc_nses[i] = n;
+		mounts[i] = n->mq_mnt;
+	}
+
+	/* Consolidate the RCU synchronization across the whole batch. */
+	kern_unmount_array(mounts, i);
+
+	for (j = 0; j < i; j++)
+		free_ipc_ns(ipc_nses[j]);
 
-	llist_for_each_entry_safe(n, t, node, mnt_llist)
-		free_ipc_ns(n);
+	if (i == FREE_IPC_BATCH)
+		goto next_batch;
 }
 
 /*
-- 
2.24.1

