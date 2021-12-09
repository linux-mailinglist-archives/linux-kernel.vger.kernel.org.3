Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43146ED92
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbhLIQzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:55:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38260 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhLIQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:55:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1635DCE2739
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 16:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F35C341CD;
        Thu,  9 Dec 2021 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639068696;
        bh=SeE9LhsXrmUvDFto+PQCLGTe/QjMvyWQxM4r3s7CDWs=;
        h=From:To:Cc:Subject:Date:From;
        b=LMnhW5IqQYBUuytouiC4IL13VhESqt162Ro2IX5CrQEQReIfH2RoBak6/9CPTGSFF
         8+RUIiAAK1JMxs7w6iSwi68tzdtl7/hYAlcFE04hAWG9pD+gUw7mKKZi9q4vVJ4eWV
         sQ85iDtxbzf1FXsziW+9o1JPXS2AY8qM4lN2C07xP30vI/3PzjAGDzeKHsDicgayA5
         /dCgL++xJngxmWvKcIuzp/N2BPRen5NfNAZ6lJFYdcj/hxydLK+15KMgKw8bgJex5b
         qr0bWfy0isQjm36YN/HiWp/LjCKx4QiNvA89MBGWSxxWWjkyKkB3jIsU+UKfM9FPF1
         Z8RksRn0Q1WMA==
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH] tools/lib/lockdep: drop leftover liblockdep headers
Date:   Thu,  9 Dec 2021 11:51:13 -0500
Message-Id: <20211209165113.150581-1-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up remaining headers that are specific to liblockdep but lived in
the shared header directory.

Note that there are still headers that were originally created for
liblockdep, that still have liblockdep references, but they are used by
other tools/ code at this point.

Signed-off-by: Sasha Levin <sashal@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/include/linux/debug_locks.h | 14 ------
 tools/include/linux/hardirq.h     | 12 ------
 tools/include/linux/irqflags.h    | 39 -----------------
 tools/include/linux/lockdep.h     | 72 -------------------------------
 tools/include/linux/proc_fs.h     |  4 --
 tools/include/linux/spinlock.h    |  2 -
 tools/include/linux/stacktrace.h  | 33 --------------
 7 files changed, 176 deletions(-)
 delete mode 100644 tools/include/linux/debug_locks.h
 delete mode 100644 tools/include/linux/hardirq.h
 delete mode 100644 tools/include/linux/irqflags.h
 delete mode 100644 tools/include/linux/lockdep.h
 delete mode 100644 tools/include/linux/proc_fs.h
 delete mode 100644 tools/include/linux/stacktrace.h

diff --git a/tools/include/linux/debug_locks.h b/tools/include/linux/debug_locks.h
deleted file mode 100644
index 72d595ce764ae..0000000000000
--- a/tools/include/linux/debug_locks.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LIBLOCKDEP_DEBUG_LOCKS_H_
-#define _LIBLOCKDEP_DEBUG_LOCKS_H_
-
-#include <stddef.h>
-#include <linux/compiler.h>
-#include <asm/bug.h>
-
-#define DEBUG_LOCKS_WARN_ON(x) WARN_ON(x)
-
-extern bool debug_locks;
-extern bool debug_locks_silent;
-
-#endif
diff --git a/tools/include/linux/hardirq.h b/tools/include/linux/hardirq.h
deleted file mode 100644
index b25580b6a9be4..0000000000000
--- a/tools/include/linux/hardirq.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LIBLOCKDEP_LINUX_HARDIRQ_H_
-#define _LIBLOCKDEP_LINUX_HARDIRQ_H_
-
-#define SOFTIRQ_BITS	0UL
-#define HARDIRQ_BITS	0UL
-#define SOFTIRQ_SHIFT	0UL
-#define HARDIRQ_SHIFT	0UL
-#define hardirq_count()	0UL
-#define softirq_count()	0UL
-
-#endif
diff --git a/tools/include/linux/irqflags.h b/tools/include/linux/irqflags.h
deleted file mode 100644
index 501262aee8ff2..0000000000000
--- a/tools/include/linux/irqflags.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LIBLOCKDEP_LINUX_TRACE_IRQFLAGS_H_
-#define _LIBLOCKDEP_LINUX_TRACE_IRQFLAGS_H_
-
-# define lockdep_hardirq_context()	0
-# define lockdep_softirq_context(p)	0
-# define lockdep_hardirqs_enabled()	0
-# define lockdep_softirqs_enabled(p)	0
-# define lockdep_hardirq_enter()	do { } while (0)
-# define lockdep_hardirq_exit()		do { } while (0)
-# define lockdep_softirq_enter()	do { } while (0)
-# define lockdep_softirq_exit()		do { } while (0)
-# define INIT_TRACE_IRQFLAGS
-
-# define stop_critical_timings() do { } while (0)
-# define start_critical_timings() do { } while (0)
-
-#define raw_local_irq_disable() do { } while (0)
-#define raw_local_irq_enable() do { } while (0)
-#define raw_local_irq_save(flags) ((flags) = 0)
-#define raw_local_irq_restore(flags) ((void)(flags))
-#define raw_local_save_flags(flags) ((flags) = 0)
-#define raw_irqs_disabled_flags(flags) ((void)(flags))
-#define raw_irqs_disabled() 0
-#define raw_safe_halt()
-
-#define local_irq_enable() do { } while (0)
-#define local_irq_disable() do { } while (0)
-#define local_irq_save(flags) ((flags) = 0)
-#define local_irq_restore(flags) ((void)(flags))
-#define local_save_flags(flags)	((flags) = 0)
-#define irqs_disabled() (1)
-#define irqs_disabled_flags(flags) ((void)(flags), 0)
-#define safe_halt() do { } while (0)
-
-#define trace_lock_release(x, y)
-#define trace_lock_acquire(a, b, c, d, e, f, g)
-
-#endif
diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
deleted file mode 100644
index e56997288f2b0..0000000000000
--- a/tools/include/linux/lockdep.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LIBLOCKDEP_LOCKDEP_H_
-#define _LIBLOCKDEP_LOCKDEP_H_
-
-#include <sys/prctl.h>
-#include <sys/syscall.h>
-#include <string.h>
-#include <limits.h>
-#include <linux/utsname.h>
-#include <linux/compiler.h>
-#include <linux/export.h>
-#include <linux/kern_levels.h>
-#include <linux/err.h>
-#include <linux/rcu.h>
-#include <linux/list.h>
-#include <linux/hardirq.h>
-#include <unistd.h>
-
-#define MAX_LOCK_DEPTH 63UL
-
-#define asmlinkage
-#define __visible
-
-#include "../../../include/linux/lockdep.h"
-
-struct task_struct {
-	u64 curr_chain_key;
-	int lockdep_depth;
-	unsigned int lockdep_recursion;
-	struct held_lock held_locks[MAX_LOCK_DEPTH];
-	gfp_t lockdep_reclaim_gfp;
-	int pid;
-	int state;
-	char comm[17];
-};
-
-#define TASK_RUNNING 0
-
-extern struct task_struct *__curr(void);
-
-#define current (__curr())
-
-static inline int debug_locks_off(void)
-{
-	return 1;
-}
-
-#define task_pid_nr(tsk) ((tsk)->pid)
-
-#define KSYM_NAME_LEN 128
-#define printk(...) dprintf(STDOUT_FILENO, __VA_ARGS__)
-#define pr_err(format, ...) fprintf (stderr, format, ## __VA_ARGS__)
-#define pr_warn pr_err
-#define pr_cont pr_err
-
-#define list_del_rcu list_del
-
-#define atomic_t unsigned long
-#define atomic_inc(x) ((*(x))++)
-
-#define print_tainted() ""
-#define static_obj(x) 1
-
-#define debug_show_all_locks()
-extern void debug_check_no_locks_held(void);
-
-static __used bool __is_kernel_percpu_address(unsigned long addr, void *can_addr)
-{
-	return false;
-}
-
-#endif
diff --git a/tools/include/linux/proc_fs.h b/tools/include/linux/proc_fs.h
deleted file mode 100644
index 8b3b03b64fda5..0000000000000
--- a/tools/include/linux/proc_fs.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef _TOOLS_INCLUDE_LINUX_PROC_FS_H
-#define _TOOLS_INCLUDE_LINUX_PROC_FS_H
-
-#endif /* _TOOLS_INCLUDE_LINUX_PROC_FS_H */
diff --git a/tools/include/linux/spinlock.h b/tools/include/linux/spinlock.h
index c934572d935cc..622266b197d0d 100644
--- a/tools/include/linux/spinlock.h
+++ b/tools/include/linux/spinlock.h
@@ -37,6 +37,4 @@ static inline bool arch_spin_is_locked(arch_spinlock_t *mutex)
 	return true;
 }
 
-#include <linux/lockdep.h>
-
 #endif
diff --git a/tools/include/linux/stacktrace.h b/tools/include/linux/stacktrace.h
deleted file mode 100644
index ae343ac35bfa7..0000000000000
--- a/tools/include/linux/stacktrace.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LIBLOCKDEP_LINUX_STACKTRACE_H_
-#define _LIBLOCKDEP_LINUX_STACKTRACE_H_
-
-#include <execinfo.h>
-
-struct stack_trace {
-	unsigned int nr_entries, max_entries;
-	unsigned long *entries;
-	int skip;
-};
-
-static inline void print_stack_trace(struct stack_trace *trace, int spaces)
-{
-	backtrace_symbols_fd((void **)trace->entries, trace->nr_entries, 1);
-}
-
-#define save_stack_trace(trace)	\
-	((trace)->nr_entries =	\
-		backtrace((void **)(trace)->entries, (trace)->max_entries))
-
-static inline int dump_stack(void)
-{
-	void *array[64];
-	size_t size;
-
-	size = backtrace(array, 64);
-	backtrace_symbols_fd(array, size, 1);
-
-	return 0;
-}
-
-#endif
-- 
2.33.0

