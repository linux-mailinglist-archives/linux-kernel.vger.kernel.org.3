Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5806E52838C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbiEPLwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiEPLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:52:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDCDE0CD;
        Mon, 16 May 2022 04:52:45 -0700 (PDT)
Date:   Mon, 16 May 2022 13:52:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652701963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=IGQoFo6P4J8ycetSQ9hix8XVM9tdehbPuVsOA2YMnpY=;
        b=o5VqGT3u6TokCE09NMVOBcUAt5UL6w/bE3iLaWlV8nKtqJBtxwWPCHaysjuXmcqjxq1IGx
        Yy7XHK7C3l4KYLpTW0PCw5z1bzNZINNqYbA/z6qFQ7XsCjAmfJxr2dDl2Ra30zX4urDzao
        jzaPO9UmPwKmXKyemCjIl8Xj2F+G3qD7jU4uLt/CxJJaUmn40dPKd6y5f4w/8ifqq42oxV
        qja0pS4N/FtYHIkv2G1Q9Z0eWH+tg+/Lz5Z0KynqFRcoGcIh3D7Vx6lZ948emlDRczSeAq
        Z5cWR8FFcxssEbMRHj5K/ghJRn1g4UuR+mn4WQApZsBrpkm/IIFZTh1gQ0JIIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652701963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=IGQoFo6P4J8ycetSQ9hix8XVM9tdehbPuVsOA2YMnpY=;
        b=hno4nql7AiY2RAC5NAIwwtsl5MuMSNpe2byludSqSmOcLXQDD0HhftUo9Yq3S2iqrfiAgy
        Q2JdwHbQ7HGogmCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.18-rc7-rt9
Message-ID: <YoI7CnKuf1+iudvB@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.18-rc7-rt9 patch set. 

Changes since v5.18-rc7-rt8:

  - Replace the patch adding the swait queue to dentry::d_wait with an
    alternative solution.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.18-rc7-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/incr/patch-5.18-rc7-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.18-rc7-rt9

The RT patch against v5.18-rc7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patch-5.18-rc7-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patches-5.18-rc7-rt9.tar.xz

Sebastian

diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index 502b56597f107..45cfd50a95210 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -239,7 +239,7 @@ int afs_silly_iput(struct dentry *dentry, struct inode *inode)
 	struct dentry *alias;
 	int ret;
 
-	DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(wq);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	_enter("%p{%pd},%llx", dentry, dentry, vnode->fid.vnode);
 
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 48eb8c30c6dbf..1929e80c09ee1 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -69,7 +69,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 	struct inode *inode;
 	struct super_block *sb = parent->d_sb;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
-	DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(wq);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	cifs_dbg(FYI, "%s: for %s\n", __func__, name->name);
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 1d4b0c9a41ae8..e9ac408b693aa 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2587,24 +2587,21 @@ static inline void end_dir_add(struct inode *dir, unsigned n)
 
 static void d_wait_lookup(struct dentry *dentry)
 {
-	struct swait_queue __wait;
-
-	if (!d_in_lookup(dentry))
-		return;
-
-	INIT_LIST_HEAD(&__wait.task_list);
-	do {
-		prepare_to_swait_exclusive(dentry->d_wait, &__wait, TASK_UNINTERRUPTIBLE);
-		spin_unlock(&dentry->d_lock);
-		schedule();
-		spin_lock(&dentry->d_lock);
-	} while (d_in_lookup(dentry));
-	finish_swait(dentry->d_wait, &__wait);
+	if (d_in_lookup(dentry)) {
+		DECLARE_WAITQUEUE(wait, current);
+		add_wait_queue(dentry->d_wait, &wait);
+		do {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			spin_unlock(&dentry->d_lock);
+			schedule();
+			spin_lock(&dentry->d_lock);
+		} while (d_in_lookup(dentry));
+	}
 }
 
 struct dentry *d_alloc_parallel(struct dentry *parent,
 				const struct qstr *name,
-				struct swait_queue_head *wq)
+				wait_queue_head_t *wq)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2712,18 +2709,30 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 }
 EXPORT_SYMBOL(d_alloc_parallel);
 
-void __d_lookup_done(struct dentry *dentry)
+static wait_queue_head_t *__d_lookup_clear_d_wait(struct dentry *dentry)
 {
+	wait_queue_head_t *d_wait;
 	struct hlist_bl_head *b = in_lookup_hash(dentry->d_parent,
 						 dentry->d_name.hash);
 	hlist_bl_lock(b);
 	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
 	__hlist_bl_del(&dentry->d_u.d_in_lookup_hash);
-	swake_up_all(dentry->d_wait);
+	d_wait = dentry->d_wait;
 	dentry->d_wait = NULL;
 	hlist_bl_unlock(b);
 	INIT_HLIST_NODE(&dentry->d_u.d_alias);
 	INIT_LIST_HEAD(&dentry->d_lru);
+	return d_wait;
+}
+
+void __d_lookup_done(struct dentry *dentry)
+{
+	wait_queue_head_t *wq_head;
+
+	spin_lock(&dentry->d_lock);
+	wq_head = __d_lookup_clear_d_wait(dentry);
+	spin_unlock(&dentry->d_lock);
+	wake_up_all(wq_head);
 }
 EXPORT_SYMBOL(__d_lookup_done);
 
@@ -2731,13 +2740,15 @@ EXPORT_SYMBOL(__d_lookup_done);
 
 static inline void __d_add(struct dentry *dentry, struct inode *inode)
 {
+	wait_queue_head_t *d_wait = NULL;
 	struct inode *dir = NULL;
+
 	unsigned n;
 	spin_lock(&dentry->d_lock);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir = dentry->d_parent->d_inode;
 		n = start_dir_add(dir);
-		__d_lookup_done(dentry);
+		d_wait = __d_lookup_clear_d_wait(dentry);
 	}
 	if (inode) {
 		unsigned add_flags = d_flags_for_inode(inode);
@@ -2751,6 +2762,8 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 	if (dir)
 		end_dir_add(dir, n);
 	spin_unlock(&dentry->d_lock);
+	if (d_wait)
+		wake_up_all(d_wait);
 	if (inode)
 		spin_unlock(&inode->i_lock);
 }
@@ -2895,6 +2908,7 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 static void __d_move(struct dentry *dentry, struct dentry *target,
 		     bool exchange)
 {
+	wait_queue_head_t *d_wait = NULL;
 	struct dentry *old_parent, *p;
 	struct inode *dir = NULL;
 	unsigned n;
@@ -2926,7 +2940,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	if (unlikely(d_in_lookup(target))) {
 		dir = target->d_parent->d_inode;
 		n = start_dir_add(dir);
-		__d_lookup_done(target);
+		d_wait = __d_lookup_clear_d_wait(target);
 	}
 
 	write_seqcount_begin(&dentry->d_seq);
@@ -2970,6 +2984,8 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 		spin_unlock(&old_parent->d_lock);
 	spin_unlock(&target->d_lock);
 	spin_unlock(&dentry->d_lock);
+	if (d_wait)
+		wake_up_all(d_wait);
 }
 
 /*
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 5ef0c106fb9db..b4e5657110457 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -158,7 +158,7 @@ static int fuse_direntplus_link(struct file *file,
 	struct inode *dir = d_inode(parent);
 	struct fuse_conn *fc;
 	struct inode *inode;
-	DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(wq);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (!o->nodeid) {
 		/*
diff --git a/fs/namei.c b/fs/namei.c
index b94b5ad7682fb..509657fdf4f56 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1683,7 +1683,7 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 {
 	struct dentry *dentry, *old;
 	struct inode *inode = dir->d_inode;
-	DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(wq);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	/* Don't go there if it's already dead */
 	if (unlikely(IS_DEADDIR(inode)))
@@ -3242,7 +3242,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
-	DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(wq);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 50812ded679ba..c6b263b5faf1f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -721,7 +721,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		unsigned long dir_verifier)
 {
 	struct qstr filename = QSTR_INIT(entry->name, entry->len);
-	DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(wq);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *dentry;
 	struct dentry *alias;
 	struct inode *inode;
@@ -2020,7 +2020,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
 		    umode_t mode)
 {
-	DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(wq);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
 	struct dentry *res;
 	struct iattr attr = { .ia_valid = ATTR_OPEN };
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 767fe79702100..6f325e10056ce 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -13,7 +13,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
 #include <linux/sched.h>
-#include <linux/swait.h>
+#include <linux/wait.h>
 #include <linux/namei.h>
 #include <linux/fsnotify.h>
 
@@ -180,7 +180,7 @@ nfs_async_unlink(struct dentry *dentry, const struct qstr *name)
 
 	data->cred = get_current_cred();
 	data->res.dir_attr = &data->dir_attr;
-	init_swait_queue_head(&data->wq);
+	init_waitqueue_head(&data->wq);
 
 	status = -EBUSY;
 	spin_lock(&dentry->d_lock);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 64cbe3af8a00c..c1031843cc6aa 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -95,7 +95,6 @@
 #include <linux/posix-timers.h>
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
-#include <linux/swait.h>
 #include <linux/cn_proc.h>
 #include <trace/events/oom.h>
 #include "internal.h"
@@ -2045,7 +2044,7 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 
 	child = d_hash_and_lookup(dir, &qname);
 	if (!child) {
-		DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(wq);
+		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 		child = d_alloc_parallel(dir, &qname, &wq);
 		if (IS_ERR(child))
 			goto end_instantiate;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index a4ddc8df10854..7d9cfc730bd4c 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -696,7 +696,7 @@ static bool proc_sys_fill_cache(struct file *file,
 
 	child = d_lookup(dir, &qname);
 	if (!child) {
-		DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(wq);
+		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 		child = d_alloc_parallel(dir, &qname, &wq);
 		if (IS_ERR(child))
 			return false;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 7c43c64343bb1..a07a51c858fb4 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -98,7 +98,7 @@ struct dentry {
 
 	union {
 		struct list_head d_lru;		/* LRU list */
-		struct swait_queue_head *d_wait;	/* in-lookup ones only */
+		wait_queue_head_t *d_wait;	/* in-lookup ones only */
 	};
 	struct list_head d_child;	/* child of parent list */
 	struct list_head d_subdirs;	/* our children */
@@ -230,7 +230,7 @@ extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
-					struct swait_queue_head *);
+					wait_queue_head_t *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
 extern struct dentry * d_exact_alias(struct dentry *, struct inode *);
@@ -349,7 +349,7 @@ static inline void dont_mount(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 }
 
-extern void __d_lookup_done(struct dentry *);
+extern void __d_lookup_done(struct dentry *dentry);
 
 static inline int d_in_lookup(const struct dentry *dentry)
 {
@@ -358,11 +358,8 @@ static inline int d_in_lookup(const struct dentry *dentry)
 
 static inline void d_lookup_done(struct dentry *dentry)
 {
-	if (unlikely(d_in_lookup(dentry))) {
-		spin_lock(&dentry->d_lock);
+	if (unlikely(d_in_lookup(dentry)))
 		__d_lookup_done(dentry);
-		spin_unlock(&dentry->d_lock);
-	}
 }
 
 extern void dput(struct dentry *);
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 706c5078fae80..2863e5a69c6ab 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1685,7 +1685,7 @@ struct nfs_unlinkdata {
 	struct nfs_removeargs args;
 	struct nfs_removeres res;
 	struct dentry *dentry;
-	struct swait_queue_head wq;
+	wait_queue_head_t wq;
 	const struct cred *cred;
 	struct nfs_fattr dir_attr;
 	long timeout;
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 25fe514fac960..76b9b796e6956 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -63,7 +63,6 @@ void swake_up_all(struct swait_queue_head *q)
 	struct swait_queue *curr;
 	LIST_HEAD(tmp);
 
-	WARN_ON(irqs_disabled());
 	raw_spin_lock_irq(&q->lock);
 	list_splice_init(&q->task_list, &tmp);
 	while (!list_empty(&tmp)) {
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
