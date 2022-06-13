Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B9549EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350761AbiFMUWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347992AbiFMUWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:22:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF20D19F9;
        Mon, 13 Jun 2022 12:01:30 -0700 (PDT)
Date:   Mon, 13 Jun 2022 21:01:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655146888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2e6yFy5HhGWMohdTtuAybmHn7JSg3oKogJZRx3s/jDA=;
        b=ltqtlJqYVqb5J3DJGhFBysQDW4sauNH592tMtE3hVK4nwESb0/UPiLcjEW7m0DwTDO1lwF
        vtixLNFDb35xsCL/7xwgaPvG2rDHzVXz7JKf771FiXcPtKPmvpVYmVQcakBUQLC0wgmemm
        o0sdhXHBwBhSgd2qpOoLgm0uUyC07xdPazJu6jqX9vBSCMYX6i/J0fon370XKR2W5BgOJM
        8jHCHcDHYAiHKXo5vcjjkAiO0r7soFbo+1kgBy+zK749fYwhBSCK/O8YXmEjoxILLQpXyO
        vxfSQuyt9awQsPrKh+VisDogrT45iBMbRks7Wk/K6Zlc4+HaRsK1ssTd+vU8OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655146888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2e6yFy5HhGWMohdTtuAybmHn7JSg3oKogJZRx3s/jDA=;
        b=RW+zagoU94hsC24v0V+X8fzt4AI3i68eqW4kvCop57r1mlt6wPv3Uwt6ScNs3OiKXRiG2/
        DUsbNanYIBtAnHBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.19-rc2-rt3
Message-ID: <YqeJhwD3aPNpVPZn@linutronix.de>
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

I'm pleased to announce the v5.19-rc2-rt3 patch set. 

Changes since v5.19-rc2-rt2:

  - Don't a spinlock_t in the zram driver on non-PREEMPT_RT builds.

  - Redo the dcache patch and move the wake-up back under the
    dentry::lock lock protection to avoid problems on spurious wake-ups.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.19-rc2-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/incr/patch-5.19-rc2-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.19-rc2-rt3

The RT patch against v5.19-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patch-5.19-rc2-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patches-5.19-rc2-rt3.tar.xz

Sebastian

diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index c82e846802608..7995b00a8ca99 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -63,7 +63,9 @@ struct zram_table_entry {
 		unsigned long element;
 	};
 	unsigned long flags;
+#ifdef CONFIG_PREEMPT_RT
 	spinlock_t lock;
+#endif
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	ktime_t ac_time;
 #endif
diff --git a/fs/dcache.c b/fs/dcache.c
index e9ac408b693aa..0b5fd3a17ff7c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2564,9 +2564,11 @@ EXPORT_SYMBOL(d_rehash);
 static inline unsigned start_dir_add(struct inode *dir)
 {
 	/*
-	 * The caller has a spinlock_t (dentry::d_lock) acquired which disables
-	 * preemption on !PREEMPT_RT. On PREEMPT_RT the lock does not disable
-	 * preemption and it has be done explicitly.
+	 * The caller holds a spinlock (dentry::d_lock). On !PREEMPT_RT
+	 * kernels spin_lock() implicitly disables preemption, but not on
+	 * PREEMPT_RT.  So for RT it has to be done explicitly to protect
+	 * the sequence count write side critical section against a reader
+	 * or another writer preempting, which would result in a live lock.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_disable();
@@ -2709,11 +2711,19 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 }
 EXPORT_SYMBOL(d_alloc_parallel);
 
-static wait_queue_head_t *__d_lookup_clear_d_wait(struct dentry *dentry)
+/*
+ * - Unhash the dentry
+ * - Retrieve and clear the waitqueue head in dentry
+ * - Return the waitqueue head
+ */
+static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 {
 	wait_queue_head_t *d_wait;
-	struct hlist_bl_head *b = in_lookup_hash(dentry->d_parent,
-						 dentry->d_name.hash);
+	struct hlist_bl_head *b;
+
+	lockdep_assert_held(&dentry->d_lock);
+
+	b = in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
 	hlist_bl_lock(b);
 	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
 	__hlist_bl_del(&dentry->d_u.d_in_lookup_hash);
@@ -2727,12 +2737,9 @@ static wait_queue_head_t *__d_lookup_clear_d_wait(struct dentry *dentry)
 
 void __d_lookup_done(struct dentry *dentry)
 {
-	wait_queue_head_t *wq_head;
-
 	spin_lock(&dentry->d_lock);
-	wq_head = __d_lookup_clear_d_wait(dentry);
+	wake_up_all(__d_lookup_unhash(dentry));
 	spin_unlock(&dentry->d_lock);
-	wake_up_all(wq_head);
 }
 EXPORT_SYMBOL(__d_lookup_done);
 
@@ -2740,15 +2747,15 @@ EXPORT_SYMBOL(__d_lookup_done);
 
 static inline void __d_add(struct dentry *dentry, struct inode *inode)
 {
-	wait_queue_head_t *d_wait = NULL;
+	wait_queue_head_t *d_wait;
 	struct inode *dir = NULL;
-
 	unsigned n;
+
 	spin_lock(&dentry->d_lock);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir = dentry->d_parent->d_inode;
 		n = start_dir_add(dir);
-		d_wait = __d_lookup_clear_d_wait(dentry);
+		d_wait = __d_lookup_unhash(dentry);
 	}
 	if (inode) {
 		unsigned add_flags = d_flags_for_inode(inode);
@@ -2759,11 +2766,11 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 		fsnotify_update_flags(dentry);
 	}
 	__d_rehash(dentry);
-	if (dir)
+	if (dir) {
 		end_dir_add(dir, n);
-	spin_unlock(&dentry->d_lock);
-	if (d_wait)
 		wake_up_all(d_wait);
+	}
+	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
 }
@@ -2908,8 +2915,8 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 static void __d_move(struct dentry *dentry, struct dentry *target,
 		     bool exchange)
 {
-	wait_queue_head_t *d_wait = NULL;
 	struct dentry *old_parent, *p;
+	wait_queue_head_t *d_wait;
 	struct inode *dir = NULL;
 	unsigned n;
 
@@ -2940,7 +2947,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	if (unlikely(d_in_lookup(target))) {
 		dir = target->d_parent->d_inode;
 		n = start_dir_add(dir);
-		d_wait = __d_lookup_clear_d_wait(target);
+		d_wait = __d_lookup_unhash(target);
 	}
 
 	write_seqcount_begin(&dentry->d_seq);
@@ -2975,8 +2982,10 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	write_seqcount_end(&target->d_seq);
 	write_seqcount_end(&dentry->d_seq);
 
-	if (dir)
+	if (dir) {
 		end_dir_add(dir, n);
+		wake_up_all(d_wait);
+	}
 
 	if (dentry->d_parent != old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
@@ -2984,8 +2993,6 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 		spin_unlock(&old_parent->d_lock);
 	spin_unlock(&target->d_lock);
 	spin_unlock(&dentry->d_lock);
-	if (d_wait)
-		wake_up_all(d_wait);
 }
 
 /*
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
