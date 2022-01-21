Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF35D4963B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350857AbiAURXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:23:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235853AbiAURXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642785813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0AmHO2q/+hDIoxZtSfsJSm37YCDI5FTTMIiZEGOOaeM=;
        b=YKlTrpXLa2VhbJcTXp21o4AWKoRNGBEfyOIZQNc1beC+QBUKm7jXy1+Ig7lxjswEb/CtxH
        qU54H7Ez+P6LmGoq8xLDrAbQvcRkpA5g3l/uDlJrgyUzW11G8s6N6z5JNLDmmllcjuvNCJ
        4e9qDEo9cFZEM/qXlopRgVMbXDm9JLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-PmIW_5J7NvOMlzG3U4P65g-1; Fri, 21 Jan 2022 12:23:32 -0500
X-MC-Unique: PmIW_5J7NvOMlzG3U4P65g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFF1D104FC1B;
        Fri, 21 Jan 2022 17:23:30 +0000 (UTC)
Received: from llong.com (unknown [10.22.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 431AA84A01;
        Fri, 21 Jan 2022 17:23:30 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] ipc/mqueue: Use get_tree_nodev() in mqueue_get_tree()
Date:   Fri, 21 Jan 2022 12:23:15 -0500
Message-Id: <20220121172315.19652-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the stress-ng clone benchmark with multiple testing
threads, it was found that there were significant spinlock contention
in sget_fc().  The contended spinlock was the sb_lock. It is under
heavy contention because the following code in the critcal section
of sget_fc():

  hlist_for_each_entry(old, &fc->fs_type->fs_supers, s_instances) {
      if (test(old, fc))
          goto share_extant_sb;
  }

After testing with added instrumentation code, it was found that the
the benchmark could generate thousands of ipc namespaces with the
corresponding number of entries in the mqueue's fs_supers list where
the namespaces are the key for the search. This leads to excessive time
in scanning the list for a match.

Looking back at the mqueue calling sequence leading to sget_fc():

  mq_init_ns()
  => mq_create_mount()
  => fc_mount()
  => vfs_get_tree()
  => mqueue_get_tree()
  => get_tree_keyed()
  => vfs_get_super()
  => sget_fc()

Currently, mq_init_ns() is the only mqueue function that will indirectly
call mqueue_get_tree() with a newly allocated ipc namespace as the
key for searching.  As a result, there will never be a match with the
exising ipc namespaces stored in the mqueue's fs_supers list.

So using get_tree_keyed() to do an existing ipc namespace search is just
a waste of time. Instead, we could use get_tree_nodev() to eliminate
the useless search. By doing so, we can greatly reduce the sb_lock hold
time and avoid the spinlock contention problem in case a large number
of ipc namespaces are present.

Of course, if the code is modified in the future to allow
mqueue_get_tree() to be called with an existing ipc namespace instead
of a new one, we will have to use get_tree_keyed() in this case.

The following stress-ng clone benchmark command was run on a 2-socket
48-core Intel system:

./stress-ng --clone 32 --verbose --oomable --metrics-brief -t 20

The "bogo ops/s" increased from 5948.45 before patch to 9137.06 after
patch. This is an increase of 54% in performance.

Fixes: 935c6912b198 ("ipc: Convert mqueue fs to fs_context")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 ipc/mqueue.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5becca9be867..089c34d0732c 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -45,6 +45,7 @@
 
 struct mqueue_fs_context {
 	struct ipc_namespace	*ipc_ns;
+	bool			 newns;	/* Set if newly created ipc namespace */
 };
 
 #define MQUEUE_MAGIC	0x19800202
@@ -427,6 +428,14 @@ static int mqueue_get_tree(struct fs_context *fc)
 {
 	struct mqueue_fs_context *ctx = fc->fs_private;
 
+	/*
+	 * With a newly created ipc namespace, we don't need to do a search
+	 * for an ipc namespace match, but we still need to set s_fs_info.
+	 */
+	if (ctx->newns) {
+		fc->s_fs_info = ctx->ipc_ns;
+		return get_tree_nodev(fc, mqueue_fill_super);
+	}
 	return get_tree_keyed(fc, mqueue_fill_super, ctx->ipc_ns);
 }
 
@@ -454,6 +463,10 @@ static int mqueue_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+/*
+ * mq_init_ns() is currently the only caller of mq_create_mount().
+ * So the ns parameter is always a newly created ipc namespace.
+ */
 static struct vfsmount *mq_create_mount(struct ipc_namespace *ns)
 {
 	struct mqueue_fs_context *ctx;
@@ -465,6 +478,7 @@ static struct vfsmount *mq_create_mount(struct ipc_namespace *ns)
 		return ERR_CAST(fc);
 
 	ctx = fc->fs_private;
+	ctx->newns = true;
 	put_ipc_ns(ctx->ipc_ns);
 	ctx->ipc_ns = get_ipc_ns(ns);
 	put_user_ns(fc->user_ns);
-- 
2.27.0

