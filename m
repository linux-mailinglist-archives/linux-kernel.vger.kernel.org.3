Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E344AE4BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388518AbiBHWdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386215AbiBHTnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:55 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04E8C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:43:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c10so234587pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yy80CGDeGmOdUiLaU44tdYuu65avXredLZvHqvqZxvA=;
        b=coFrZx+umVb8C/9VoaeNS8agdUuDH1jjXrRj9GBST7lfrgMyXv+urqHK84NA+cqHK2
         YPP8ni+X5Tj3wenKzAOVxLCtqjfiED+u36ZZ9ETh3Bwnpy4r2M/jDQIWtW0kD7tvva6G
         pjqXROY4r0loXEnFtL3ug4ia+hY746GpzMeAFbHuyUR4/gs28nIldej+IlIS5Y156+Fz
         5Y+DXajDA+R/a+8V2WhjcIXodpHFPeTJcw8LsNLBv2zyWhu0/h6Ya6/k+ydhZ94Sax7g
         +DICq7kdEw6BwaGWi6hz1N7nDIXFOPBr0r4QYmYf8NMT52ruOU6Kv8biZ560q5sTpmpH
         wRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Yy80CGDeGmOdUiLaU44tdYuu65avXredLZvHqvqZxvA=;
        b=fds3bzHD+7AYHSnr5zKyX29d4hr2d7puTCGzchel4RlQNyTGKITGy+4NkUg1vUAtiW
         p4E+Lu9z3fjTefucWqUvkC/v3kIdgVxufHoBIYzP5K/sP9RStnXD1nMZ6W89Fb+1eE+k
         D/QE1SQ88zeI8pE8HPzOCIVML0MfdsjoVn2uRS9DozPUpCll3s0Ba7KOEg9raBMJs5y6
         UsXmDulyZ+GEhSNUEST/Fh6did+kHx5bEmBnj8UjOOQA/xjqF/YyWWH7IjliznhQsieA
         uNvGxHShN0UXabi3iZWazYT5tNRayhHDrW+XKLPxQ1WO0xCeAZO2C++LK30HzAJRJ4bS
         QFmw==
X-Gm-Message-State: AOAM533ngFyDB9/hyAFJ2nmHrMFcNbFwu4LO/Js0DW+8wv3jFeo+4WBy
        OfCAbwxhouNfSzP8VKiSub0=
X-Google-Smtp-Source: ABdhPJywJ/lu8GWNpkww16VbmJlUtxqslBTWQrZ6DMFizoxzO0kUsn0kJ6BhawqySiiptym920qTOw==
X-Received: by 2002:a63:6942:: with SMTP id e63mr4761524pgc.226.1644349434067;
        Tue, 08 Feb 2022 11:43:54 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:53 -0800 (PST)
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
Subject: [PATCH 09/12] locking: Add more static lockdep init macros
Date:   Tue,  8 Feb 2022 11:43:21 -0800
Message-Id: <20220208194324.85333-10-namhyung@kernel.org>
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

Add STATIC_LOCKDEP_MAP_INIT_{WAIT,TYPE} macros and use it for various
lock init codes.  This helps having different implementations of
CONFIG_LOCK_INFO like lockdep and tracepoints.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 drivers/gpu/drm/drm_connector.c     |  5 ++---
 include/linux/local_lock_internal.h | 10 ++++------
 include/linux/lockdep.h             | 23 +++++++++++++++++------
 include/linux/mutex.h               |  6 ++----
 include/linux/rtmutex.h             |  8 +++-----
 include/linux/rwlock_types.h        |  5 +----
 include/linux/rwsem.h               |  8 +++-----
 include/linux/spinlock_types_raw.h  | 24 ++++++++----------------
 kernel/printk/printk.c              | 10 ++++------
 kernel/rcu/update.c                 | 27 +++++++++------------------
 mm/memcontrol.c                     |  5 ++---
 11 files changed, 55 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 94931b32a491..7f470de2ef2b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -677,9 +677,8 @@ const char *drm_get_connector_force_name(enum drm_connector_force force)
 }
 
 #ifdef CONFIG_LOCK_INFO
-static struct lockdep_map connector_list_iter_dep_map = {
-	.name = "drm_connector_list_iter"
-};
+static struct lockdep_map connector_list_iter_dep_map =
+	STATIC_LOCKDEP_MAP_INIT("drm_connector_list_iter", NULL);
 #endif
 
 /**
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 56f03f588aa7..dd280fcfadec 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -16,12 +16,10 @@ typedef struct {
 } local_lock_t;
 
 #ifdef CONFIG_LOCK_INFO
-# define LOCAL_LOCK_DEBUG_INIT(lockname)		\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_CONFIG,	\
-		.lock_type = LD_LOCK_PERCPU,		\
-	},						\
+# define LOCAL_LOCK_DEBUG_INIT(lockname)				\
+	.dep_map = STATIC_LOCKDEP_MAP_INIT_TYPE(#lockname, NULL,	\
+					LD_WAIT_CONFIG, LD_WAIT_INV,	\
+					LD_LOCK_PERCPU),		\
 	.owner = NULL,
 
 static inline void local_lock_acquire(local_lock_t *l)
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 0cc2b338a006..38cbef7601c7 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -237,6 +237,19 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
 #define lockdep_set_novalidate_class(lock) \
 	lockdep_set_class_and_name(lock, &__lockdep_no_validate__, #lock)
 
+/*
+ * To initialize a lockdep_map statically use this macro.
+ * Note that _name must not be NULL.
+ */
+#define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
+	{ .name = (_name), .key = (void *)(_key), }
+
+#define STATIC_LOCKDEP_MAP_INIT_WAIT(_name, _key, _inner)	\
+	{ .name = (_name), .key = (void *)(_key), .wait_type_inner = (_inner), }
+
+#define STATIC_LOCKDEP_MAP_INIT_TYPE(_name, _key, _inner, _outer, _type)	\
+	{ .name = (_name), .key = (void *)(_key), .wait_type_inner = (_inner),	\
+	  .wait_type_outer = (_outer), .lock_type = (_type), }
 /*
  * Compare locking classes
  */
@@ -377,6 +390,10 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
 
 #define lockdep_set_novalidate_class(lock) do { } while (0)
 
+#define STATIC_LOCKDEP_MAP_INIT(_name, _key) { }
+#define STATIC_LOCKDEP_MAP_INIT_WAIT(_name, _key, _inner) { }
+#define STATIC_LOCKDEP_MAP_INIT_TYPE(_name, _key, _inner, _outer, _type) { }
+
 /*
  * We don't define lockdep_match_class() and lockdep_match_key() for !LOCKDEP
  * case since the result is not well defined and the caller should rather
@@ -432,12 +449,6 @@ enum xhlock_context_t {
 };
 
 #define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
-/*
- * To initialize a lockdep_map statically use this macro.
- * Note that _name must not be NULL.
- */
-#define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
-	{ .name = (_name), .key = (void *)(_key), }
 
 static inline void lockdep_invariant_state(bool force) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 369c1abbf3d0..b2d018250a41 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -22,10 +22,8 @@
 
 #ifdef CONFIG_LOCK_INFO
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
-		, .dep_map = {					\
-			.name = #lockname,			\
-			.wait_type_inner = LD_WAIT_SLEEP,	\
-		}
+	, .dep_map = STATIC_LOCKDEP_MAP_INIT_WAIT(#lockname,	\
+					NULL, LD_WAIT_SLEEP)
 #else
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
 #endif
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 8eafdd6dcf35..887ffcd5fc09 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -77,11 +77,9 @@ do { \
 } while (0)
 
 #ifdef CONFIG_LOCK_INFO
-#define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)	\
-	.dep_map = {					\
-		.name = #mutexname,			\
-		.wait_type_inner = LD_WAIT_SLEEP,	\
-	}
+#define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)			\
+	.dep_map = STATIC_LOCKDEP_MAP_INIT_WAIT(#mutexname,		\
+						NULL, LD_WAIT_SLEEP)
 #else
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
 #endif
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 3e621bfd7cd0..438d8639a229 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -7,10 +7,7 @@
 
 #ifdef CONFIG_LOCK_INFO
 # define RW_DEP_MAP_INIT(lockname)					\
-	.dep_map = {							\
-		.name = #lockname,					\
-		.wait_type_inner = LD_WAIT_CONFIG,			\
-	}
+	.dep_map = STATIC_LOCKDEP_MAP_INIT_WAIT(#lockname, NULL, LD_WAIT_CONFIG)
 #else
 # define RW_DEP_MAP_INIT(lockname)
 #endif
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c488485861f5..39126e6d97a1 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -17,11 +17,9 @@
 #include <linux/err.h>
 
 #ifdef CONFIG_LOCK_INFO
-# define __RWSEM_DEP_MAP_INIT(lockname)			\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_SLEEP,	\
-	},
+# define __RWSEM_DEP_MAP_INIT(lockname)				\
+	.dep_map = STATIC_LOCKDEP_MAP_INIT_WAIT(#lockname,	\
+					NULL, LD_WAIT_SLEEP),
 #else
 # define __RWSEM_DEP_MAP_INIT(lockname)
 #endif
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index 564092a30cc4..006250640e76 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -27,23 +27,15 @@ typedef struct raw_spinlock {
 #define SPINLOCK_OWNER_INIT	((void *)-1L)
 
 #ifdef CONFIG_LOCK_INFO
-# define RAW_SPIN_DEP_MAP_INIT(lockname)		\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_SPIN,	\
-	}
-# define SPIN_DEP_MAP_INIT(lockname)			\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_CONFIG,	\
-	}
+# define RAW_SPIN_DEP_MAP_INIT(lockname)					\
+	.dep_map = STATIC_LOCKDEP_MAP_INIT_WAIT(#lockname, NULL, LD_WAIT_SPIN)
 
-# define LOCAL_SPIN_DEP_MAP_INIT(lockname)		\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_CONFIG,	\
-		.lock_type = LD_LOCK_PERCPU,		\
-	}
+# define SPIN_DEP_MAP_INIT(lockname)						\
+	.dep_map = STATIC_LOCKDEP_MAP_INIT_WAIT(#lockname, NULL, LD_WAIT_CONFIG)
+
+# define LOCAL_SPIN_DEP_MAP_INIT(lockname)					\
+	.dep_map = STATIC_LOCKDEP_MAP_INIT_TYPE(#lockname, NULL, LD_WAIT_CONFIG,\
+						LD_WAIT_INV, LD_LOCK_PERCPU)
 #else
 # define RAW_SPIN_DEP_MAP_INIT(lockname)
 # define SPIN_DEP_MAP_INIT(lockname)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e45664e0ca30..7889df01a378 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -94,9 +94,8 @@ EXPORT_SYMBOL_GPL(console_drivers);
 int __read_mostly suppress_printk;
 
 #ifdef CONFIG_LOCK_INFO
-static struct lockdep_map console_lock_dep_map = {
-	.name = "console_lock"
-};
+static struct lockdep_map console_lock_dep_map =
+	STATIC_LOCKDEP_MAP_INIT("console_lock", NULL);
 #endif
 
 enum devkmsg_log_bits {
@@ -1753,9 +1752,8 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
  */
 
 #ifdef CONFIG_LOCK_INFO
-static struct lockdep_map console_owner_dep_map = {
-	.name = "console_owner"
-};
+static struct lockdep_map console_owner_dep_map =
+	STATIC_LOCKDEP_MAP_INIT("console_owner", NULL);
 #endif
 
 static DEFINE_RAW_SPINLOCK(console_owner_lock);
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 156892c22bb5..8202ab6ddb4c 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -243,30 +243,21 @@ core_initcall(rcu_set_runtime_mode);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key rcu_lock_key;
-struct lockdep_map rcu_lock_map = {
-	.name = "rcu_read_lock",
-	.key = &rcu_lock_key,
-	.wait_type_outer = LD_WAIT_FREE,
-	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT implies PREEMPT_RCU */
-};
+struct lockdep_map rcu_lock_map = /* PREEMPT_RT implies PREEMPT_RCU */
+	STATIC_LOCKDEP_MAP_INIT_TYPE("rcu_read_lock", &rcu_lock_key,
+				     LD_WAIT_CONFIG, LD_WAIT_FREE, 0);
 EXPORT_SYMBOL_GPL(rcu_lock_map);
 
 static struct lock_class_key rcu_bh_lock_key;
-struct lockdep_map rcu_bh_lock_map = {
-	.name = "rcu_read_lock_bh",
-	.key = &rcu_bh_lock_key,
-	.wait_type_outer = LD_WAIT_FREE,
-	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
-};
+struct lockdep_map rcu_bh_lock_map = /* PREEMPT_RT makes BH preemptable. */
+	STATIC_LOCKDEP_MAP_INIT_TYPE("rcu_read_lock_bh", &rcu_bh_lock_key,
+				     LD_WAIT_CONFIG, LD_WAIT_FREE, 0);
 EXPORT_SYMBOL_GPL(rcu_bh_lock_map);
 
 static struct lock_class_key rcu_sched_lock_key;
-struct lockdep_map rcu_sched_lock_map = {
-	.name = "rcu_read_lock_sched",
-	.key = &rcu_sched_lock_key,
-	.wait_type_outer = LD_WAIT_FREE,
-	.wait_type_inner = LD_WAIT_SPIN,
-};
+struct lockdep_map rcu_sched_lock_map =
+	STATIC_LOCKDEP_MAP_INIT_TYPE("rcu_read_lock_sched", &rcu_sched_lock_key,
+				     LD_WAIT_SPIN, LD_WAIT_FREE, 0);
 EXPORT_SYMBOL_GPL(rcu_sched_lock_map);
 
 // Tell lockdep when RCU callbacks are being invoked.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d4ecfdd5eb8f..a561a6c66b2f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1672,9 +1672,8 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 }
 
 #ifdef CONFIG_LOCK_INFO
-static struct lockdep_map memcg_oom_lock_dep_map = {
-	.name = "memcg_oom_lock",
-};
+static struct lockdep_map memcg_oom_lock_dep_map =
+	STATIC_LOCKDEP_MAP_INIT("memcg_oom_lock", NULL);
 #endif
 
 static DEFINE_SPINLOCK(memcg_oom_lock);
-- 
2.35.0.263.gb82422642f-goog

