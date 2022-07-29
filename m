Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE7858535B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiG2QSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiG2QSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:18:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C952788CEE;
        Fri, 29 Jul 2022 09:18:45 -0700 (PDT)
Date:   Fri, 29 Jul 2022 18:18:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659111524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ccHi5rpdoxagvk/VMmpwdyqLPl6kfS83BVw+V7teFMs=;
        b=EXsW3S2hMw9RB5yAYHiTJzh7sLUDN/pEhVwOMBoD2EAk4Tfe9vO+q5TDgvkvQcDRp1pIOp
        9wCUsfnEHZXvQviXglQhFDunsbcb1ViTQmKAgM//wAqbeioyHkitaie2tGlP0iBELuJUbX
        7ItjfHTHFisvrttTr8RXtCoZikqJGXVbIOIoDGdwLuoEX4b5DMrphNmy6QrRDo0WUpfShW
        gloBtgT6YDzR2UJYoXTaqmrjpqQ9jfgBonUb98EFhM4K/0K4IdVoGzGnbeRsvuzPUkGC+N
        X7dDm4HTCuaekGamtlysS6Bb27s9whQbM/IpMr9E3I6FXUKwWvCzEBeEzpn8Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659111524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ccHi5rpdoxagvk/VMmpwdyqLPl6kfS83BVw+V7teFMs=;
        b=kib4G+q7LID5qN7Q/Nrs9+zjt800o+Vyi6fMK1ybYqM5xZOrUlYmWx+b4iio0QzOfrwH8h
        EL+JyJzjp5vWfkCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.19-rc8-rt9
Message-ID: <YuQIY/NA2o5j9HVR@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.19-rc8-rt9 patch set. 

Changes since v5.19-rc8-rt8:

  - Redo the dcache patch based on feedback from upstream.

  - Add a comment to the scheduler code based on feedback from upstream.

  - Printing a pointer usually leads to warning on PREEMPT_RT. Reported
    by Mike Galbraith.


Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.19-rc8-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/incr/patch-5.19-rc8-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.19-rc8-rt9

The RT patch against v5.19-rc8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patch-5.19-rc8-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patches-5.19-rc8-rt9.tar.xz

Sebastian

diff --git a/fs/dcache.c b/fs/dcache.c
index 0b5fd3a17ff7c..a95064f972c80 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2239,6 +2239,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		} 
 	}
 	res = d_splice_alias(inode, found);
+	d_lookup_done(found);
 	if (res) {
 		dput(found);
 		return res;
@@ -2580,11 +2581,13 @@ static inline unsigned start_dir_add(struct inode *dir)
 	}
 }
 
-static inline void end_dir_add(struct inode *dir, unsigned n)
+static inline void end_dir_add(struct inode *dir, unsigned int n,
+			       wait_queue_head_t *d_wait)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
+	wake_up_all(d_wait);
 }
 
 static void d_wait_lookup(struct dentry *dentry)
@@ -2735,13 +2738,13 @@ static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 	return d_wait;
 }
 
-void __d_lookup_done(struct dentry *dentry)
+void __d_lookup_unhash_wake(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
 	wake_up_all(__d_lookup_unhash(dentry));
 	spin_unlock(&dentry->d_lock);
 }
-EXPORT_SYMBOL(__d_lookup_done);
+EXPORT_SYMBOL(__d_lookup_unhash_wake);
 
 /* inode->i_lock held if inode is non-NULL */
 
@@ -2750,7 +2753,6 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 	wait_queue_head_t *d_wait;
 	struct inode *dir = NULL;
 	unsigned n;
-
 	spin_lock(&dentry->d_lock);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir = dentry->d_parent->d_inode;
@@ -2766,10 +2768,8 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 		fsnotify_update_flags(dentry);
 	}
 	__d_rehash(dentry);
-	if (dir) {
-		end_dir_add(dir, n);
-		wake_up_all(d_wait);
-	}
+	if (dir)
+		end_dir_add(dir, n, d_wait);
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2982,10 +2982,8 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	write_seqcount_end(&target->d_seq);
 	write_seqcount_end(&dentry->d_seq);
 
-	if (dir) {
-		end_dir_add(dir, n);
-		wake_up_all(d_wait);
-	}
+	if (dir)
+		end_dir_add(dir, n, d_wait);
 
 	if (dentry->d_parent != old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index a07a51c858fb4..c73e5e327e76f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -349,7 +349,7 @@ static inline void dont_mount(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 }
 
-extern void __d_lookup_done(struct dentry *dentry);
+extern void __d_lookup_unhash_wake(struct dentry *dentry);
 
 static inline int d_in_lookup(const struct dentry *dentry)
 {
@@ -359,7 +359,7 @@ static inline int d_in_lookup(const struct dentry *dentry)
 static inline void d_lookup_done(struct dentry *dentry)
 {
 	if (unlikely(d_in_lookup(dentry)))
-		__d_lookup_done(dentry);
+		__d_lookup_unhash_wake(dentry);
 }
 
 extern void dput(struct dentry *);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 377e7d4139d87..fd7b06dcab48f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3300,6 +3300,36 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_PREEMPT_RT
+
+/*
+ * Consider:
+ *
+ *  set_special_state(X);
+ *
+ *  do_things()
+ *    // Somewhere in there is an rtlock that can be contended:
+ *    current_save_and_set_rtlock_wait_state();
+ *    [...]
+ *    schedule_rtlock(); (A)
+ *    [...]
+ *    current_restore_rtlock_saved_state();
+ *
+ *  schedule(); (B)
+ *
+ * If p->saved_state is anything else than TASK_RUNNING, then p blocked on an
+ * rtlock (A) *before* voluntarily calling into schedule() (B) after setting its
+ * state to X. For things like ptrace (X=TASK_TRACED), the task could have more
+ * work to do upon acquiring the lock in do_things() before whoever called
+ * wait_task_inactive() should return. IOW, we have to wait for:
+ *
+ *   p.saved_state = TASK_RUNNING
+ *   p.__state     = X
+ *
+ * which implies the task isn't blocked on an RT lock and got to schedule() (B).
+ *
+ * Also see comments in ttwu_state_match().
+ */
+
 static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
 {
 	unsigned long flags;
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3c1853a9d1c09..371d6f5abaad5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -750,37 +750,40 @@ static int __init debug_boot_weak_hash_enable(char *str)
 }
 early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
 
-static DEFINE_STATIC_KEY_FALSE(filled_random_ptr_key);
+static bool filled_random_ptr_key;
+static siphash_key_t ptr_key __read_mostly;
 
-static void enable_ptr_key_workfn(struct work_struct *work)
+static void fill_ptr_key_workfn(struct work_struct *work)
 {
-	static_branch_enable(&filled_random_ptr_key);
+	int ret;
+
+	ret = get_random_bytes_wait(&ptr_key, sizeof(ptr_key));
+	if (WARN_ON(ret < 0))
+		return;
+	/* Pairs with smp_rmb() before reading ptr_key. */
+	smp_wmb();
+	WRITE_ONCE(filled_random_ptr_key, true);
 }
 
+static int vsprintf_init_hashval(void)
+{
+	static DECLARE_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
+
+	queue_work(system_unbound_wq, &fill_ptr_key_work);
+	return 0;
+}
+subsys_initcall(vsprintf_init_hashval)
+
 /* Maps a pointer to a 32 bit unique identifier. */
 static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
 {
-	static siphash_key_t ptr_key __read_mostly;
 	unsigned long hashval;
 
-	if (!static_branch_likely(&filled_random_ptr_key)) {
-		static bool filled = false;
-		static DEFINE_SPINLOCK(filling);
-		static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
-		unsigned long flags;
-
-		if (!system_unbound_wq || !rng_is_initialized() ||
-		    !spin_trylock_irqsave(&filling, flags))
-			return -EAGAIN;
-
-		if (!filled) {
-			get_random_bytes(&ptr_key, sizeof(ptr_key));
-			queue_work(system_unbound_wq, &enable_ptr_key_work);
-			filled = true;
-		}
-		spin_unlock_irqrestore(&filling, flags);
-	}
+	if (!READ_ONCE(filled_random_ptr_key))
+		return -EBUSY;
 
+	/* Pairs with smp_wmb() after writing ptr_key. */
+	smp_rmb();
 
 #ifdef CONFIG_64BIT
 	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
