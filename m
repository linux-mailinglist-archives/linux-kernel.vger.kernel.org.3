Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D44AE4A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388929AbiBHWdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386217AbiBHTn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:57 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896CC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:43:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y7so265902plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQBAIvQLg20+7U3cvyTRGOoJ39hD5GGWkL0kfjAijZk=;
        b=CVu9Gz+7ny2CqqZn2AmzB3OZOJ8utvXtXJT+uTffuOURUE7m4sHaUmMxkTYnuAhjoE
         WpvdEV50nl2YkgqjdIKaYtuRoS3DB4UiLkqWjg/dv4A+P3BReIxixbAewFUz2NQQubFe
         KQD5fRBJmUpctn8R3PjppV/eI3j0rSXbamBOg2pu/94SJA4cfQBIt6b9fZP60mKKypUB
         pzmXNpsKN5p1sAx5d1LjmQkGihT8h7oNOAHEGN3TYqf7AvNBnnOiuPJqolor6KiojPLv
         39Y4hiOKcfBzu+T0JM4gSp34xrYGPzsM06mtkCY6KPhOnsuzaH9X2Qc1v45E0KMUOFtp
         3P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EQBAIvQLg20+7U3cvyTRGOoJ39hD5GGWkL0kfjAijZk=;
        b=s1N/M/TJAr22BItTOg36HQRYZ2rQoKYwUaia9AH8Tj57LuFQja93/97zUL6JdaS/e9
         aRE8YITynTeQxBmsfGgzUhwARKcHlMMOkfwsmTBi4I+FK7kYG/ceiBUM4y73qWW5gYmc
         tKKkEqJFZOa3FRkdSt7d+52jmZX93vcdcw+1A9i/u40joPVNkLnoB+Ttd3sisTkY9BkI
         pWAzKKN4Bw9/sx0HWnTr5YhKcVETxNXMoETqGRoAXbFhirRCkPq1htLiDvLARZozxf37
         mGT9rHmtonEycvX/Vnz7jB1C7ytVU7+bpCcMvy1Jh1Qjpl3VGGOfL608IYFocpKxV688
         KiAw==
X-Gm-Message-State: AOAM533kcTkneyU9GkjP4mIaaPvAfYLSraMzwLXyj2AnYOvh58KSMTRZ
        0dsul55qpxYW+5SW+I29nas=
X-Google-Smtp-Source: ABdhPJyICADZ4Q8xypnNJExN/AykweFdN/mOihQHXR6DZjO77wctgdJUTCWQBnfu9A3Uju2fskiKyA==
X-Received: by 2002:a17:903:2d2:: with SMTP id s18mr6187922plk.56.1644349436130;
        Tue, 08 Feb 2022 11:43:56 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:55 -0800 (PST)
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
Subject: [PATCH 10/12] locking: Add CONFIG_LOCK_TRACEPOINTS option
Date:   Tue,  8 Feb 2022 11:43:22 -0800
Message-Id: <20220208194324.85333-11-namhyung@kernel.org>
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

This option enables the following tracepoints for lock analysis.  This
can be used to trace lock/unlock pairs and their contentions without
enabling LOCKDEP and LOCK_STAT.

 * lock_acquire
 * lock_release
 * lock_contended
 * lock_acquired

It selects CONFIG_LOCK_INFO to have lock names properly, and make the
lockdep functions inline to check if the corresponding tracepoint is
enabled before calling the function.  Then it could avoid unnecessary
overhead setting up the arguments in the tracepoint when disabled.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/lockdep.h       | 141 +++++++++++++++++++++++++++++++++-
 include/linux/lockdep_types.h |   8 +-
 include/trace/events/lock.h   |   4 +-
 kernel/locking/Makefile       |   1 +
 kernel/locking/lockdep.c      |  40 +++++++++-
 lib/Kconfig.debug             |   9 +++
 6 files changed, 195 insertions(+), 8 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 38cbef7601c7..4e728d2957db 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -14,6 +14,8 @@
 #include <linux/smp.h>
 #include <asm/percpu.h>
 
+#include <linux/tracepoint-defs.h>
+
 struct task_struct;
 
 /* for sysctl */
@@ -367,12 +369,104 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
 {
 }
 
+#ifdef CONFIG_LOCK_TRACEPOINTS
+DECLARE_TRACEPOINT(lock_acquire);
+DECLARE_TRACEPOINT(lock_release);
+
+extern void __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
+			   int trylock, int read, int check,
+			   struct lockdep_map *nest_lock, unsigned long ip);
+extern void __lock_release(struct lockdep_map *lock, unsigned long ip);
+
+static inline void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
+				int trylock, int read, int check,
+				struct lockdep_map *nest_lock, unsigned long ip)
+{
+	if (tracepoint_enabled(lock_acquire))
+		__lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
+}
+
+static inline void lock_release(struct lockdep_map *lock, unsigned long ip)
+{
+	if (tracepoint_enabled(lock_release))
+		__lock_release(lock, ip);
+}
+#else /* !CONFIG_LOCK_TRACEPOINTS */
 # define lock_acquire(l, s, t, r, c, n, i)	do { } while (0)
 # define lock_release(l, i)			do { } while (0)
+#endif /* CONFIG_LOCK_TRACEPOINTS */
+
 # define lock_downgrade(l, i)			do { } while (0)
 # define lock_set_class(l, n, k, s, i)		do { } while (0)
 # define lock_set_subclass(l, s, i)		do { } while (0)
 # define lockdep_init()				do { } while (0)
+
+#ifdef CONFIG_LOCK_INFO
+
+static inline void
+lockdep_init_map_type(struct lockdep_map *lock, const char *name,
+		      struct lock_class_key *key, int subclass,
+		      u8 inner, u8 outer, u8 type)
+{
+	if (!name)
+		name = "NULL";
+
+	lock->name = name;
+}
+
+static inline void
+lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
+		       struct lock_class_key *key, int subclass,
+		       u8 inner, u8 outer)
+{
+	lockdep_init_map_type(lock, name, key, subclass, inner, outer, 0);
+}
+
+static inline void
+lockdep_init_map_wait(struct lockdep_map *lock, const char *name,
+		      struct lock_class_key *key, int subclass, u8 inner)
+{
+	lockdep_init_map_waits(lock, name, key, subclass, inner, 0);
+}
+
+static inline void
+lockdep_init_map(struct lockdep_map *lock, const char *name,
+		 struct lock_class_key *key, int subclass)
+{
+	lockdep_init_map_wait(lock, name, key, subclass, 0);
+}
+
+/* Reinitialize a lock name - other info will be ignore. */
+# define lockdep_set_class(lock, key)				\
+	lockdep_init_map(&(lock)->dep_map, #key, key, 0)
+
+# define lockdep_set_class_and_name(lock, key, name)		\
+	lockdep_init_map(&(lock)->dep_map, name, key, 0)
+
+# define lockdep_set_class_and_subclass(lock, key, sub)		\
+	lockdep_init_map(&(lock)->dep_map, #key, key, sub)
+
+# define lockdep_set_subclass(lock, sub)			\
+	lockdep_init_map(&(lock)->dep_map, #lock, NULL, sub)
+
+# define lockdep_set_novalidate_class(lock) \
+	lockdep_set_class_and_name(lock, NULL, #lock)
+
+/*
+ * To initialize a lockdep_map statically use this macro.
+ * Note that _name must not be NULL.
+ */
+# define STATIC_LOCKDEP_MAP_INIT(_name, _key)			\
+	{ .name = (_name), }
+
+# define STATIC_LOCKDEP_MAP_INIT_WAIT(_name, _key, _inner)	\
+	{ .name = (_name), }
+
+# define STATIC_LOCKDEP_MAP_INIT_TYPE(_name, _key, _inner, _outer, _type) \
+	{ .name = (_name), }
+
+#else /* !CONFIG_LOCK_INFO */
+
 # define lockdep_init_map_type(lock, name, key, sub, inner, outer, type) \
 		do { (void)(name); (void)(key); } while (0)
 # define lockdep_init_map_waits(lock, name, key, sub, inner, outer) \
@@ -394,6 +488,8 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
 #define STATIC_LOCKDEP_MAP_INIT_WAIT(_name, _key, _inner) { }
 #define STATIC_LOCKDEP_MAP_INIT_TYPE(_name, _key, _inner, _outer, _type) { }
 
+#endif /* CONFIG_LOCK_INFO */
+
 /*
  * We don't define lockdep_match_class() and lockdep_match_key() for !LOCKDEP
  * case since the result is not well defined and the caller should rather
@@ -479,7 +575,48 @@ do {								\
 	____err;						\
 })
 
-#else /* CONFIG_LOCK_STAT */
+#elif defined(CONFIG_LOCK_TRACEPOINTS)
+
+DECLARE_TRACEPOINT(lock_contended);
+DECLARE_TRACEPOINT(lock_acquired);
+
+extern void __lock_contended(struct lockdep_map *lock, unsigned long ip);
+extern void __lock_acquired(struct lockdep_map *lock, unsigned long ip);
+
+static inline void lock_contended(struct lockdep_map *lock, unsigned long ip)
+{
+	if (tracepoint_enabled(lock_contended))
+		__lock_contended(lock, ip);
+}
+
+static inline void lock_acquired(struct lockdep_map *lock, unsigned long ip)
+{
+	if (tracepoint_enabled(lock_acquired))
+		__lock_acquired(lock, ip);
+}
+
+#define LOCK_CONTENDED(_lock, try, lock)			\
+do {								\
+	if (!try(_lock)) {					\
+		lock_contended(&(_lock)->dep_map, _RET_IP_);	\
+		lock(_lock);					\
+	}							\
+	lock_acquired(&(_lock)->dep_map, _RET_IP_);		\
+} while (0)
+
+#define LOCK_CONTENDED_RETURN(_lock, try, lock)			\
+({								\
+	int ____err = 0;					\
+	if (!try(_lock)) {					\
+		lock_contended(&(_lock)->dep_map, _RET_IP_);	\
+		____err = lock(_lock);				\
+	}							\
+	if (!____err)						\
+		lock_acquired(&(_lock)->dep_map, _RET_IP_);	\
+	____err;						\
+})
+
+#else /* !CONFIG_LOCK_STAT && !CONFIG_LOCK_TRACEPOINTS */
 
 #define lock_contended(lockdep_map, ip) do {} while (0)
 #define lock_acquired(lockdep_map, ip) do {} while (0)
@@ -490,7 +627,7 @@ do {								\
 #define LOCK_CONTENDED_RETURN(_lock, try, lock) \
 	lock(_lock)
 
-#endif /* CONFIG_LOCK_STAT */
+#endif /* CONFIG_LOCK_STAT || CONFIG_LOCK_TRACEPOINTS */
 
 #ifdef CONFIG_PROVE_LOCKING
 extern void print_irqtrace_events(struct task_struct *curr);
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d22430840b53..340138c9023e 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -197,9 +197,13 @@ struct pin_cookie { unsigned int val; };
 struct lock_class_key { };
 
 /*
- * The lockdep_map takes no space if lockdep is disabled:
+ * The lockdep_map takes no space if lockdep and lock_info is disabled:
  */
-struct lockdep_map { };
+struct lockdep_map {
+#ifdef CONFIG_LOCK_INFO
+	const char	*name;
+#endif
+};
 
 struct pin_cookie { };
 
diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index d7512129a324..74667841ae02 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -8,7 +8,7 @@
 #include <linux/lockdep.h>
 #include <linux/tracepoint.h>
 
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_LOCK_TRACEPOINTS)
 
 TRACE_EVENT(lock_acquire,
 
@@ -62,7 +62,7 @@ DEFINE_EVENT(lock, lock_release,
 	TP_ARGS(lock, ip)
 );
 
-#ifdef CONFIG_LOCK_STAT
+#if defined(CONFIG_LOCK_STAT) || defined(CONFIG_LOCK_TRACEPOINTS)
 
 DEFINE_EVENT(lock, lock_contended,
 
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index d51cabf28f38..d772a37470a6 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -17,6 +17,7 @@ endif
 obj-$(CONFIG_DEBUG_IRQFLAGS) += irqflag-debug.o
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
 obj-$(CONFIG_LOCKDEP) += lockdep.o
+obj-$(CONFIG_LOCK_TRACEPOINTS) += lockdep.o
 ifeq ($(CONFIG_PROC_FS),y)
 obj-$(CONFIG_LOCKDEP) += lockdep_proc.o
 endif
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2e6892ec3756..f234e981d1c7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -58,11 +58,13 @@
 
 #include <asm/sections.h>
 
-#include "lockdep_internals.h"
-
 #define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
 
+#ifdef CONFIG_LOCKDEP
+
+#include "lockdep_internals.h"
+
 #ifdef CONFIG_PROVE_LOCKING
 int prove_locking = 1;
 module_param(prove_locking, int, 0644);
@@ -6566,3 +6568,37 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	dump_stack();
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
+
+#elif defined(CONFIG_LOCK_TRACEPOINTS)
+
+void __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
+			  int trylock, int read, int check,
+			  struct lockdep_map *nest_lock, unsigned long ip)
+{
+	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
+}
+EXPORT_SYMBOL_GPL(__lock_acquire);
+EXPORT_TRACEPOINT_SYMBOL_GPL(lock_acquire);
+
+void __lock_release(struct lockdep_map *lock, unsigned long ip)
+{
+	trace_lock_release(lock, ip);
+}
+EXPORT_SYMBOL_GPL(__lock_release);
+EXPORT_TRACEPOINT_SYMBOL_GPL(lock_release);
+
+void __lock_contended(struct lockdep_map *lock, unsigned long ip)
+{
+	trace_lock_contended(lock, ip);
+}
+EXPORT_SYMBOL_GPL(__lock_contended);
+EXPORT_TRACEPOINT_SYMBOL_GPL(lock_contended);
+
+void __lock_acquired(struct lockdep_map *lock, unsigned long ip)
+{
+	trace_lock_acquired(lock, ip);
+}
+EXPORT_SYMBOL_GPL(__lock_acquired);
+EXPORT_TRACEPOINT_SYMBOL_GPL(lock_acquired);
+
+#endif /* CONFIG_LOCKDEP */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5f64ffe23c35..749de6c1ba50 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1452,6 +1452,15 @@ config LOCK_INFO
 	bool
 	default n
 
+config LOCK_TRACEPOINTS
+	bool "Enable lock tracepoints"
+	depends on !LOCKDEP
+	select LOCK_INFO
+	help
+	  This enables all lock events required by "perf lock", subcommand of
+	  perf, without enabling LOCKDEP and LOCK_STAT.  If you want to use
+	  "perf lock", you also need to turn on CONFIG_EVENT_TRACING.
+
 config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
 	select PREEMPT_COUNT
-- 
2.35.0.263.gb82422642f-goog

