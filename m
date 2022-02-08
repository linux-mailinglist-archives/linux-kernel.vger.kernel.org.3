Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033324AE43A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiBHW1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386210AbiBHTnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:53 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAF9C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:43:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x3so260097pll.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtfxXV8dKCbzToaKyltKN5n+I8WYCzRTP+RYfb80lWg=;
        b=XUq514eRiY9wbsvgrpwwKkARfww22ZpIfFHny81Qbx3Tw7LIwx9vrgumGG6VHb9w0t
         cC5kocX99lLRPvEBY09ZpEZRgmC2cqGqcw8Lx4D0VxABOQx7DequWFPBlNucVtDx4u0t
         I6wR8Jg5UlDd/PCuVvz+OHFqpSvZkTjHHBnCvRyqhqgQQy5Sl7K0N+zCpOeHImOIoHYu
         0IyqIlgnvXqhR76TGMsZz08h5LeQEjGtUdJMfSTdfDAUA5ujJhwZWjKcd0MT/6kXvuTz
         V90HLlabqJZwgqPPRARGR7hKPzfjzpgRLRPul3nY8FTCzvV0T1W2vrz0NUxc6v0wJi83
         EFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PtfxXV8dKCbzToaKyltKN5n+I8WYCzRTP+RYfb80lWg=;
        b=f84nelbophVl1hKOX28nseADQeiicLQeSY0a8mPufROhUodYUVbmozIfbZ/iDfR+9V
         d2uBRzCQSJiXuOBQGpW/GImXQQpqpG2blXURU+qPr+iZzMXpPKmcdTOj0YfyIDjVFT0B
         o2AxYuZz/nz2S8B2ueze3i4m1b5lXHpWZt4PPbYKZqsngapTIOMB+wQi/dM3GB+wZpKu
         PmwDZcjnrkiJLWozBgc7H5UNOhZiiG5t+OctBYrEtE/+wdfdCLFDPoxsuHLRxeTVNR7e
         lp7aHjhpRRUBhIYYEEzj3yKTKwHiNEHjBVWXqXYLKKaFGXcK7oQ6xQV4yzGyaNlfTR7F
         u3rA==
X-Gm-Message-State: AOAM5339TtqUCG2JPGU8jr0JLIjIWsUuQ3SVuqv5HfFgfP6SnFtTBlSU
        I5gdPk9mbyWfInXGE6QjT+8=
X-Google-Smtp-Source: ABdhPJzEptAvXS5zwLxHTE/rqGD7+OXvH0aJTUABsMWsfAa4ZduPphnGoFO8o/nHHQqmEMGP3S+Bfg==
X-Received: by 2002:a17:903:1212:: with SMTP id l18mr5764427plh.45.1644349430346;
        Tue, 08 Feb 2022 11:43:50 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:49 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: [PATCH 07/12] locking: Introduce CONFIG_LOCK_INFO
Date:   Tue,  8 Feb 2022 11:43:19 -0800
Message-Id: <20220208194324.85333-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208194324.85333-1-namhyung@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory work to have tracepoints separated from the
lockdep.  I'd like to keep minimal information of locks (name, for
now) to be used by the tracepoints in the lockdep_map structure.

To make the work easier, CONFIG_LOCK_INFO was added to indicate that
it needs to save the lock info.  And convert existing code using lock
information to depend on it rather than CONFIG_LOCKDEP and/or
CONFIG_DEBUG_LOCK_ALLOC directly.  Future users of the lock
information should select it too.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 drivers/gpu/drm/drm_connector.c                |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence.h           |  2 +-
 drivers/gpu/drm/i915/selftests/lib_sw_fence.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h |  2 +-
 drivers/tty/tty_ldsem.c                        |  2 +-
 fs/btrfs/disk-io.c                             |  2 +-
 fs/btrfs/disk-io.h                             |  2 +-
 fs/cifs/connect.c                              |  2 +-
 fs/kernfs/file.c                               |  2 +-
 include/linux/completion.h                     |  2 +-
 include/linux/jbd2.h                           |  2 +-
 include/linux/kernfs.h                         |  2 +-
 include/linux/kthread.h                        |  2 +-
 include/linux/local_lock_internal.h            |  8 ++++----
 include/linux/mmu_notifier.h                   |  2 +-
 include/linux/mutex.h                          |  8 ++++----
 include/linux/percpu-rwsem.h                   |  4 ++--
 include/linux/regmap.h                         |  4 ++--
 include/linux/rtmutex.h                        |  6 +++---
 include/linux/rwlock_api_smp.h                 |  4 ++--
 include/linux/rwlock_rt.h                      |  4 ++--
 include/linux/rwlock_types.h                   |  6 +++---
 include/linux/rwsem.h                          |  6 +++---
 include/linux/seqlock.h                        |  4 ++--
 include/linux/spinlock_api_smp.h               |  4 ++--
 include/linux/spinlock_rt.h                    |  4 ++--
 include/linux/spinlock_types.h                 |  4 ++--
 include/linux/spinlock_types_raw.h             |  4 ++--
 include/linux/swait.h                          |  2 +-
 include/linux/tty_ldisc.h                      |  2 +-
 include/linux/wait.h                           |  2 +-
 include/linux/ww_mutex.h                       |  6 +++---
 include/media/v4l2-ctrls.h                     |  2 +-
 include/net/sock.h                             |  2 +-
 kernel/locking/mutex-debug.c                   |  2 +-
 kernel/locking/mutex.c                         | 16 ++++++++--------
 kernel/locking/percpu-rwsem.c                  |  2 +-
 kernel/locking/rtmutex_api.c                   | 10 +++++-----
 kernel/locking/rwsem.c                         |  4 ++--
 kernel/locking/spinlock.c                      |  2 +-
 kernel/locking/spinlock_debug.c                |  4 ++--
 kernel/locking/spinlock_rt.c                   |  8 ++++----
 kernel/locking/ww_rt_mutex.c                   |  2 +-
 kernel/printk/printk.c                         |  4 ++--
 lib/Kconfig.debug                              |  5 +++++
 mm/memcontrol.c                                |  2 +-
 mm/mmu_notifier.c                              |  2 +-
 net/core/dev.c                                 |  2 +-
 net/sunrpc/svcsock.c                           |  2 +-
 net/sunrpc/xprtsock.c                          |  2 +-
 51 files changed, 96 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index a50c82bc2b2f..94931b32a491 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -676,7 +676,7 @@ const char *drm_get_connector_force_name(enum drm_connector_force force)
 	}
 }
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 static struct lockdep_map connector_list_iter_dep_map = {
 	.name = "drm_connector_list_iter"
 };
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.h b/drivers/gpu/drm/i915/i915_sw_fence.h
index a7c603bc1b01..8c05d161a069 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.h
+++ b/drivers/gpu/drm/i915/i915_sw_fence.h
@@ -43,7 +43,7 @@ void __i915_sw_fence_init(struct i915_sw_fence *fence,
 			  i915_sw_fence_notify_t fn,
 			  const char *name,
 			  struct lock_class_key *key);
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 #define i915_sw_fence_init(fence, fn)				\
 do {								\
 	static struct lock_class_key __key;			\
diff --git a/drivers/gpu/drm/i915/selftests/lib_sw_fence.h b/drivers/gpu/drm/i915/selftests/lib_sw_fence.h
index e54d6bc23dc3..ad7de5187830 100644
--- a/drivers/gpu/drm/i915/selftests/lib_sw_fence.h
+++ b/drivers/gpu/drm/i915/selftests/lib_sw_fence.h
@@ -12,7 +12,7 @@
 
 #include "../i915_sw_fence.h"
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 #define onstack_fence_init(fence)				\
 do {								\
 	static struct lock_class_key __key;			\
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 9236f9106826..c0e7038a939f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -21,7 +21,7 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  const struct iwl_cfg_trans_params *cfg_trans)
 {
 	struct iwl_trans *trans;
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 	static struct lock_class_key __key;
 #endif
 
@@ -31,7 +31,7 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 
 	trans->trans_cfg = cfg_trans;
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 	lockdep_init_map(&trans->sync_cmd_lockdep_map, "sync_cmd_lockdep_map",
 			 &__key, 0);
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 1bcaa3598785..47ef1e852d85 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1011,7 +1011,7 @@ struct iwl_trans {
 
 	struct dentry *dbgfs_dir;
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map sync_cmd_lockdep_map;
 #endif
 
diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 3be428c16260..87c44f3f0c27 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -57,7 +57,7 @@ struct ldsem_waiter {
 void __init_ldsem(struct ld_semaphore *sem, const char *name,
 		  struct lock_class_key *key)
 {
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	/*
 	 * Make sure we are not reinitializing a held semaphore:
 	 */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index be41e35bee92..2a3a257ced49 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -144,7 +144,7 @@ struct async_submit_bio {
  * same as our lockdep setup here.  If BTRFS_MAX_LEVEL changes, this code
  * needs update as well.
  */
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 # if BTRFS_MAX_LEVEL != 8
 #  error
 # endif
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 5e8bef4b7563..31ff5e95cb92 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -148,7 +148,7 @@ int btrfs_init_root_free_objectid(struct btrfs_root *root);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 void btrfs_set_buffer_lockdep_class(u64 objectid,
 			            struct extent_buffer *eb, int level);
 #else
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 11a22a30ee14..b117027019b2 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2573,7 +2573,7 @@ cifs_match_super(struct super_block *sb, void *data)
 	return rc;
 }
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 static struct lock_class_key cifs_key[2];
 static struct lock_class_key cifs_slock_key[2];
 
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9414a7a60a9f..5cb58ec61ba8 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -994,7 +994,7 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 	kn->ns = ns;
 	kn->priv = priv;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	if (key) {
 		lockdep_init_map(&kn->dep_map, "kn->active", key, 0);
 		kn->flags |= KERNFS_LOCKDEP;
diff --git a/include/linux/completion.h b/include/linux/completion.h
index 51d9ab079629..b6c408e62291 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -64,7 +64,7 @@ static inline void complete_release(struct completion *x) {}
  * This macro declares and initializes a completion structure on the kernel
  * stack.
  */
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 # define DECLARE_COMPLETION_ONSTACK(work) \
 	struct completion work = COMPLETION_INITIALIZER_ONSTACK(work)
 # define DECLARE_COMPLETION_ONSTACK_MAP(work, map) \
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index fd933c45281a..990a87ff8ab0 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1275,7 +1275,7 @@ struct journal_s
 	 */
 	__u32 j_csum_seed;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	/**
 	 * @j_trans_commit_map:
 	 *
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 861c4f0f8a29..48c5c02395cf 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -131,7 +131,7 @@ struct kernfs_elem_attr {
 struct kernfs_node {
 	atomic_t		count;
 	atomic_t		active;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 #endif
 	/*
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 3df4ea04716f..d0d5ca007c7a 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -172,7 +172,7 @@ struct kthread_delayed_work {
  * kthread_worker.lock needs its own lockdep class key when defined on
  * stack with lockdep enabled.  Use the following macros in such cases.
  */
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 # define KTHREAD_WORKER_INIT_ONSTACK(worker)				\
 	({ kthread_init_worker(&worker); worker; })
 # define DEFINE_KTHREAD_WORKER_ONSTACK(worker)				\
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 975e33b793a7..56f03f588aa7 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -9,13 +9,13 @@
 #ifndef CONFIG_PREEMPT_RT
 
 typedef struct {
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 	struct task_struct	*owner;
 #endif
 } local_lock_t;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 # define LOCAL_LOCK_DEBUG_INIT(lockname)		\
 	.dep_map = {					\
 		.name = #lockname,			\
@@ -42,12 +42,12 @@ static inline void local_lock_debug_init(local_lock_t *l)
 {
 	l->owner = NULL;
 }
-#else /* CONFIG_DEBUG_LOCK_ALLOC */
+#else /* CONFIG_LOCK_INFO */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
 static inline void local_lock_debug_init(local_lock_t *l) { }
-#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+#endif /* !CONFIG_LOCK_INFO */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
 
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 45fc2c81e370..ff88b1f5b173 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -264,7 +264,7 @@ struct mmu_interval_notifier {
 
 #ifdef CONFIG_MMU_NOTIFIER
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
 #endif
 
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 8f226d460f51..369c1abbf3d0 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,7 +20,7 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
 		, .dep_map = {					\
 			.name = #lockname,			\
@@ -70,7 +70,7 @@ struct mutex {
 #ifdef CONFIG_DEBUG_MUTEXES
 	void			*magic;
 #endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 #endif
 };
@@ -134,7 +134,7 @@ extern bool mutex_is_locked(struct mutex *lock);
 
 struct mutex {
 	struct rt_mutex_base	rtmutex;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 #endif
 };
@@ -174,7 +174,7 @@ do {							\
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.
  */
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
 extern void _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest_lock);
 
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 5fda40f97fe9..9d2427579d9a 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -15,12 +15,12 @@ struct percpu_rw_semaphore {
 	struct rcuwait		writer;
 	wait_queue_head_t	waiters;
 	atomic_t		block;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 #endif
 };
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 #define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
 #else
 #define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 22652e5fbc38..174493a0512a 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -666,12 +666,12 @@ struct regmap *__devm_regmap_init_spi_avmm(struct spi_device *spi,
 					   const char *lock_name);
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
- * for each call. No-op if CONFIG_LOCKDEP is not set.
+ * for each call. No-op if CONFIG_LOCK_INFO is not set.
  *
  * @fn: Real function to call (in the form __[*_]regmap_init[_*])
  * @name: Config variable name (#config in the calling macro)
  **/
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 #define __regmap_lockdep_wrapper(fn, name, ...)				\
 (									\
 	({								\
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 7d049883a08a..8eafdd6dcf35 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -56,7 +56,7 @@ extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
  */
 struct rt_mutex {
 	struct rt_mutex_base	rtmutex;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 #endif
 };
@@ -76,7 +76,7 @@ do { \
 	__rt_mutex_init(mutex, __func__, &__key); \
 } while (0)
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)	\
 	.dep_map = {					\
 		.name = #mutexname,			\
@@ -97,7 +97,7 @@ do { \
 
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
 extern void _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockdep_map *nest_lock);
 #define rt_mutex_lock(lock) rt_mutex_lock_nested(lock, 0)
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index dceb0a59b692..7fb42c921669 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -142,7 +142,7 @@ static inline int __raw_write_trylock(rwlock_t *lock)
  * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
  */
-#if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
+#if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_LOCK_INFO)
 
 static inline void __raw_read_lock(rwlock_t *lock)
 {
@@ -217,7 +217,7 @@ static inline void __raw_write_lock_nested(rwlock_t *lock, int subclass)
 	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
 }
 
-#endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_DEBUG_LOCK_ALLOC */
+#endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_LOCK_INFO */
 
 static inline void __raw_write_unlock(rwlock_t *lock)
 {
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 8544ff05e594..140c418c51b5 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -6,7 +6,7 @@
 #error Do not #include directly. Use <linux/spinlock.h>.
 #endif
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 extern void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
 			     struct lock_class_key *key);
 #else
@@ -84,7 +84,7 @@ static __always_inline void write_lock(rwlock_t *rwlock)
 	rt_write_lock(rwlock);
 }
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 static __always_inline void write_lock_nested(rwlock_t *rwlock, int subclass)
 {
 	rt_write_lock_nested(rwlock, subclass);
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 1948442e7750..3e621bfd7cd0 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -5,7 +5,7 @@
 # error "Do not include directly, include spinlock_types.h"
 #endif
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 # define RW_DEP_MAP_INIT(lockname)					\
 	.dep_map = {							\
 		.name = #lockname,					\
@@ -28,7 +28,7 @@ typedef struct {
 	unsigned int magic, owner_cpu;
 	void *owner;
 #endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map dep_map;
 #endif
 } rwlock_t;
@@ -57,7 +57,7 @@ typedef struct {
 typedef struct {
 	struct rwbase_rt	rwbase;
 	atomic_t		readers;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 #endif
 } rwlock_t;
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index f9348769e558..c488485861f5 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,7 +16,7 @@
 #include <linux/atomic.h>
 #include <linux/err.h>
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 # define __RWSEM_DEP_MAP_INIT(lockname)			\
 	.dep_map = {					\
 		.name = #lockname,			\
@@ -60,7 +60,7 @@ struct rw_semaphore {
 #ifdef CONFIG_DEBUG_RWSEMS
 	void *magic;
 #endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 #endif
 };
@@ -127,7 +127,7 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
 
 struct rw_semaphore {
 	struct rwbase_rt	rwbase;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 #endif
 };
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 37ded6b8fee6..c673f807965e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -64,7 +64,7 @@
  */
 typedef struct seqcount {
 	unsigned sequence;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map dep_map;
 #endif
 } seqcount_t;
@@ -79,7 +79,7 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 	s->sequence = 0;
 }
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 
 # define SEQCOUNT_DEP_MAP_INIT(lockname)				\
 		.dep_map = { .name = #lockname }
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 51fa0dab68c4..94e5ddbcc2d1 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -99,7 +99,7 @@ static inline int __raw_spin_trylock(raw_spinlock_t *lock)
  * even on CONFIG_PREEMPTION, because lockdep assumes that interrupts are
  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
  */
-#if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
+#if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_LOCK_INFO)
 
 static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
 {
@@ -134,7 +134,7 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 }
 
-#endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_DEBUG_LOCK_ALLOC */
+#endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_LOCK_INFO */
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 835aedaf68ac..2605668e0fdd 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -6,7 +6,7 @@
 #error Do not include directly. Use spinlock.h
 #endif
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 extern void __rt_spin_lock_init(spinlock_t *lock, const char *name,
 				struct lock_class_key *key, bool percpu);
 #else
@@ -45,7 +45,7 @@ static __always_inline void spin_lock(spinlock_t *lock)
 	rt_spin_lock(lock);
 }
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 # define __spin_lock_nested(lock, subclass)				\
 	rt_spin_lock_nested(lock, subclass)
 
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 2dfa35ffec76..fb9e778a0ee5 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -18,7 +18,7 @@ typedef struct spinlock {
 	union {
 		struct raw_spinlock rlock;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 # define LOCK_PADSIZE (offsetof(struct raw_spinlock, dep_map))
 		struct {
 			u8 __padding[LOCK_PADSIZE];
@@ -49,7 +49,7 @@ typedef struct spinlock {
 
 typedef struct spinlock {
 	struct rt_mutex_base	lock;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 #endif
 } spinlock_t;
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index 91cb36b65a17..564092a30cc4 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -17,7 +17,7 @@ typedef struct raw_spinlock {
 	unsigned int magic, owner_cpu;
 	void *owner;
 #endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map dep_map;
 #endif
 } raw_spinlock_t;
@@ -26,7 +26,7 @@ typedef struct raw_spinlock {
 
 #define SPINLOCK_OWNER_INIT	((void *)-1L)
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 # define RAW_SPIN_DEP_MAP_INIT(lockname)		\
 	.dep_map = {					\
 		.name = #lockname,			\
diff --git a/include/linux/swait.h b/include/linux/swait.h
index 6a8c22b8c2a5..643c9fe68d63 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -75,7 +75,7 @@ extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name
 		__init_swait_queue_head((q), #q, &__key);	\
 	} while (0)
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 # define __SWAIT_QUEUE_HEAD_INIT_ONSTACK(name)			\
 	({ init_swait_queue_head(&name); name; })
 # define DECLARE_SWAIT_QUEUE_HEAD_ONSTACK(name)			\
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index e85002b56752..5af6fb3649ab 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -20,7 +20,7 @@ struct ld_semaphore {
 	unsigned int		wait_readers;
 	struct list_head	read_wait;
 	struct list_head	write_wait;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map	dep_map;
 #endif
 };
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 851e07da2583..aa811a05b070 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -70,7 +70,7 @@ extern void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *n
 		__init_waitqueue_head((wq_head), #wq_head, &__key);		\
 	} while (0)
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 # define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
 	({ init_waitqueue_head(&name); name; })
 # define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index bb763085479a..12a6ad18176d 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -63,7 +63,7 @@ struct ww_acquire_ctx {
 	struct ww_class *ww_class;
 	void *contending_lock;
 #endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map dep_map;
 #endif
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
@@ -142,7 +142,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	ctx->done_acquire = 0;
 	ctx->contending_lock = NULL;
 #endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
 	lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
 			 &ww_class->acquire_key, 0);
@@ -184,7 +184,7 @@ static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
  */
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	mutex_release(&ctx->dep_map, _THIS_IP_);
 #endif
 #ifdef DEBUG_WW_MUTEXES
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index b3ce438f1329..f2c30a4fe203 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -489,7 +489,7 @@ int v4l2_ctrl_handler_init_class(struct v4l2_ctrl_handler *hdl,
 				 unsigned int nr_of_controls_hint,
 				 struct lock_class_key *key, const char *name);
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 
 /**
  * v4l2_ctrl_handler_init - helper function to create a static struct
diff --git a/include/net/sock.h b/include/net/sock.h
index ff9b508d9c5f..e88c7de283ed 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -103,7 +103,7 @@ typedef struct {
 	 * the slock as a lock variant (in addition to
 	 * the slock itself):
 	 */
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	struct lockdep_map dep_map;
 #endif
 } socket_lock_t;
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index bc8abb8549d2..33fc3c06b714 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -79,7 +79,7 @@ void debug_mutex_unlock(struct mutex *lock)
 void debug_mutex_init(struct mutex *lock, const char *name,
 		      struct lock_class_key *key)
 {
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	/*
 	 * Make sure we are not reinitializing a held lock:
 	 */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5e3585950ec8..8733b96ce20a 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -149,7 +149,7 @@ static inline bool __mutex_trylock(struct mutex *lock)
 	return !__mutex_trylock_common(lock, false);
 }
 
-#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#ifndef CONFIG_LOCK_INFO
 /*
  * Lockdep annotations are contained to the slow paths for simplicity.
  * There is nothing that would stop spreading the lockdep annotations outwards
@@ -245,7 +245,7 @@ static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
 	}
 }
 
-#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#ifndef CONFIG_LOCK_INFO
 /*
  * We split the mutex lock/unlock logic into separate fastpath and
  * slowpath functions, to reduce the register pressure on the fastpath.
@@ -533,7 +533,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  */
 void __sched mutex_unlock(struct mutex *lock)
 {
-#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#ifndef CONFIG_LOCK_INFO
 	if (__mutex_unlock_fast(lock))
 		return;
 #endif
@@ -591,7 +591,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		if (ww_ctx->acquired == 0)
 			ww_ctx->wounded = 0;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 		nest_lock = &ww_ctx->dep_map;
 #endif
 	}
@@ -778,7 +778,7 @@ int ww_mutex_trylock(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
 }
 EXPORT_SYMBOL(ww_mutex_trylock);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 void __sched
 mutex_lock_nested(struct mutex *lock, unsigned int subclass)
 {
@@ -937,7 +937,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	wake_up_q(&wake_q);
 }
 
-#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#ifndef CONFIG_LOCK_INFO
 /*
  * Here come the less common (and hence less performance-critical) APIs:
  * mutex_lock_interruptible() and mutex_trylock().
@@ -1078,7 +1078,7 @@ int __sched mutex_trylock(struct mutex *lock)
 }
 EXPORT_SYMBOL(mutex_trylock);
 
-#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#ifndef CONFIG_LOCK_INFO
 int __sched
 ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
@@ -1109,7 +1109,7 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 }
 EXPORT_SYMBOL(ww_mutex_lock_interruptible);
 
-#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+#endif /* !CONFIG_LOCK_INFO */
 #endif /* !CONFIG_PREEMPT_RT */
 
 /**
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 70a32a576f3f..98ff434a5f95 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -20,7 +20,7 @@ int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 	rcuwait_init(&sem->writer);
 	init_waitqueue_head(&sem->waiters);
 	atomic_set(&sem->block, 0);
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
 	lockdep_init_map(&sem->dep_map, name, key, 0);
 #endif
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 900220941caa..ce08dabf4f93 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -40,7 +40,7 @@ void rt_mutex_base_init(struct rt_mutex_base *rtb)
 }
 EXPORT_SYMBOL(rt_mutex_base_init);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 /**
  * rt_mutex_lock_nested - lock a rt_mutex
  *
@@ -59,7 +59,7 @@ void __sched _rt_mutex_lock_nest_lock(struct rt_mutex *lock, struct lockdep_map
 }
 EXPORT_SYMBOL_GPL(_rt_mutex_lock_nest_lock);
 
-#else /* !CONFIG_DEBUG_LOCK_ALLOC */
+#else /* !CONFIG_LOCK_INFO */
 
 /**
  * rt_mutex_lock - lock a rt_mutex
@@ -517,7 +517,7 @@ static __always_inline int __mutex_lock_common(struct mutex *lock,
 	return ret;
 }
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 void __sched mutex_lock_nested(struct mutex *lock, unsigned int subclass)
 {
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
@@ -557,7 +557,7 @@ void __sched mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 }
 EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
 
-#else /* CONFIG_DEBUG_LOCK_ALLOC */
+#else /* CONFIG_LOCK_INFO */
 
 void __sched mutex_lock(struct mutex *lock)
 {
@@ -585,7 +585,7 @@ void __sched mutex_lock_io(struct mutex *lock)
 	io_schedule_finish(token);
 }
 EXPORT_SYMBOL(mutex_lock_io);
-#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+#endif /* !CONFIG_LOCK_INFO */
 
 int __sched mutex_trylock(struct mutex *lock)
 {
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 69aba4abe104..8da694940165 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -304,7 +304,7 @@ rwsem_owner_flags(struct rw_semaphore *sem, unsigned long *pflags)
 void __init_rwsem(struct rw_semaphore *sem, const char *name,
 		  struct lock_class_key *key)
 {
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	/*
 	 * Make sure we are not reinitializing a held semaphore:
 	 */
@@ -1378,7 +1378,7 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 {
 	init_rwbase_rt(&(sem)->rwbase);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
 	lockdep_init_map_wait(&sem->dep_map, name, key, 0, LD_WAIT_SLEEP);
 #endif
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 7f49baaa4979..e814ca0b76c3 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -34,7 +34,7 @@ EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
  * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
  */
-#if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
+#if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_LOCK_INFO)
 /*
  * The __lock_function inlines are taken from
  * spinlock : include/linux/spinlock_api_smp.h
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 14235671a1a7..011f66515693 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -16,7 +16,7 @@
 void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 			  struct lock_class_key *key, short inner)
 {
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	/*
 	 * Make sure we are not reinitializing a held lock:
 	 */
@@ -35,7 +35,7 @@ EXPORT_SYMBOL(__raw_spin_lock_init);
 void __rwlock_init(rwlock_t *lock, const char *name,
 		   struct lock_class_key *key)
 {
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 	/*
 	 * Make sure we are not reinitializing a held lock:
 	 */
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 48a19ed8486d..22cd3eb36c98 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -56,7 +56,7 @@ void __sched rt_spin_lock(spinlock_t *lock)
 }
 EXPORT_SYMBOL(rt_spin_lock);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 void __sched rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
@@ -129,7 +129,7 @@ int __sched rt_spin_trylock_bh(spinlock_t *lock)
 }
 EXPORT_SYMBOL(rt_spin_trylock_bh);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 void __rt_spin_lock_init(spinlock_t *lock, const char *name,
 			 struct lock_class_key *key, bool percpu)
 {
@@ -239,7 +239,7 @@ void __sched rt_write_lock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_write_lock);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
 {
 	rtlock_might_resched();
@@ -269,7 +269,7 @@ void __sched rt_write_unlock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
 		      struct lock_class_key *key)
 {
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index d1473c624105..aecb2e4e5f07 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -56,7 +56,7 @@ __ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx,
 		if (ww_ctx->acquired == 0)
 			ww_ctx->wounded = 0;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 		nest_lock = &ww_ctx->dep_map;
 #endif
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82abfaf3c2aa..e45664e0ca30 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -93,7 +93,7 @@ EXPORT_SYMBOL_GPL(console_drivers);
  */
 int __read_mostly suppress_printk;
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
 };
@@ -1752,7 +1752,7 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
  * They allow to pass console_lock to another printk() call using a busy wait.
  */
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 static struct lockdep_map console_owner_dep_map = {
 	.name = "console_owner"
 };
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..5f64ffe23c35 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1394,6 +1394,7 @@ config LOCKDEP
 	select STACKTRACE
 	select KALLSYMS
 	select KALLSYMS_ALL
+	select LOCK_INFO
 
 config LOCKDEP_SMALL
 	bool
@@ -1447,6 +1448,10 @@ config DEBUG_LOCKDEP
 	  additional runtime checks to debug itself, at the price
 	  of more runtime overhead.
 
+config LOCK_INFO
+	bool
+	default n
+
 config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
 	select PREEMPT_COUNT
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09d342c7cbd0..d4ecfdd5eb8f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1671,7 +1671,7 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 	return total;
 }
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 static struct lockdep_map memcg_oom_lock_dep_map = {
 	.name = "memcg_oom_lock",
 };
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 459d195d2ff6..26da67834cba 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -22,7 +22,7 @@
 /* global SRCU for all MMs */
 DEFINE_STATIC_SRCU(srcu);
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 struct lockdep_map __mmu_notifier_invalidate_range_start_map = {
 	.name = "mmu_notifier_invalidate_range_start"
 };
diff --git a/net/core/dev.c b/net/core/dev.c
index 1baab07820f6..7548a6c606ca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -406,7 +406,7 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
 DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
 EXPORT_PER_CPU_SYMBOL(softnet_data);
 
-#ifdef CONFIG_LOCKDEP
+#ifdef CONFIG_LOCK_INFO
 /*
  * register_netdevice() inits txq->_xmit_lock and sets lockdep class
  * according to dev->type
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 478f857cdaed..14d87c2d0df1 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -74,7 +74,7 @@ static void		svc_sock_free(struct svc_xprt *);
 static struct svc_xprt *svc_create_socket(struct svc_serv *, int,
 					  struct net *, struct sockaddr *,
 					  int, int);
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 static struct lock_class_key svc_key[2];
 static struct lock_class_key svc_slock_key[2];
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index d8ee06a9650a..cd66a6608ba2 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1719,7 +1719,7 @@ static void xs_local_set_port(struct rpc_xprt *xprt, unsigned short port)
 {
 }
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#ifdef CONFIG_LOCK_INFO
 static struct lock_class_key xs_key[3];
 static struct lock_class_key xs_slock_key[3];
 
-- 
2.35.0.263.gb82422642f-goog

