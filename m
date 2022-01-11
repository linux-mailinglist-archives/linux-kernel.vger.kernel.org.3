Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A2E48AF93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbiAKObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:31:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48296 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241927AbiAKObA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:31:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 20D831F3B1;
        Tue, 11 Jan 2022 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641911459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQ7qVJhcgF4KUO20Jdl/feQBRd4hCeRpI1Zc7yFB16k=;
        b=EThISaRyIAa68H5i5Pn6pSh/gkbys6cNELKpar7D4QEY0qv2SdTCqtr/cZlH71rxq62Zu0
        PVE4NTaPqS33rvXLQY67n8hGGnSmz1XuKvW/Ex8rh0ln7fCZ9HCNc2yQYd0rhp9YMGPaB/
        Om8KiO9cScF5lh4rTyD1Ku4mDzz3gXk=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id CAB4FA3B89;
        Tue, 11 Jan 2022 14:30:58 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Chris Down <chris@chrisdown.name>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [RFC 1/2] printk/dynamic_debug: Remove cyclic dependency between printk.h and dynamic_debug.h
Date:   Tue, 11 Jan 2022 15:30:45 +0100
Message-Id: <20220111143046.14680-2-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220111143046.14680-1-pmladek@suse.com>
References: <20220111143046.14680-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`make headerdep` reports many circular dependencies with the same
pattern:

In file included from linux/printk.h,
                 from linux/dynamic_debug.h:188
                 from linux/printk.h:559 <-- here

It looks like false positive:

   + printk.h includes dynamic_debug.h when CONFIG_DYNAMIC_DEBUG_CORE
   + dynamic_debug.h includes printk.h when !CONFIG_DYNAMIC_DEBUG_CORE

Anyway, it would be great to get rid of this dependency because it is
tricky and it might hit us in the future. Also it might hide another
more complicated cyclic dependencies.

One solution would be to move the inlined ddebug_dyndbg_module_param_cb()
and dynamic_debug_exec_queries() from 'dynamic_debug.h' into some .c so
that it will not be needed to inline printk() in 'dynamic_debug.h'.

The obvious location would be 'lib/dynamic_debug.c'. But it is built
only when CONFIG_DYNAMIC_DEBUG_CORE is set. And the problematic
inline variants are used only when this config option is _not_ set.
So that it is not that easy.

Instead, this patch adds 'include/linux/printk_core.h' and moves some
lowlevel printk API there. Then the raw _printk() can be called from
the inlined code in 'dynamic_debug.h'.

Note that it is not enough to declare _printk() in 'dynamic_debug.h'.
It would break build with CONFIG_PRINTK where it is an inlined nope.

The drawback of this approach is that _printk() does not add metadata for
printk indexing and the message is not listed in <debugfs>/printk/index/.
But it should be acceptable here. The strings are used only for debugging.

The advantage is that this approach might be used to solve other cyclic
dependencies, for example in bug.h.

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 MAINTAINERS                   |  1 +
 include/linux/dynamic_debug.h | 10 ++---
 include/linux/printk.h        | 57 +-------------------------
 include/linux/printk_core.h   | 76 +++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 61 deletions(-)
 create mode 100644 include/linux/printk_core.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7168aa..eadb77da01db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15340,6 +15340,7 @@ R:	Steven Rostedt <rostedt@goodmis.org>
 R:	John Ogness <john.ogness@linutronix.de>
 S:	Maintained
 F:	include/linux/printk.h
+F:	include/linux/printk_core.h
 F:	kernel/printk/
 
 PRINTK INDEXING
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index dce631e678dd..63f6ebd6a14c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -185,7 +185,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #include <linux/string.h>
 #include <linux/errno.h>
-#include <linux/printk.h>
+#include <linux/printk_core.h>
 
 static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 				    const char *modname)
@@ -202,9 +202,8 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 						const char *modname)
 {
 	if (strstr(param, "dyndbg")) {
-		/* avoid pr_warn(), which wants pr_fmt() fully defined */
-		printk(KERN_WARNING "dyndbg param is supported only in "
-			"CONFIG_DYNAMIC_DEBUG builds\n");
+		/* Use raw _printk() to avoid cyclic dependency. */
+		_printk(KERN_WARNING "dyndbg param is supported only in CONFIG_DYNAMIC_DEBUG builds\n");
 		return 0; /* allow and ignore */
 	}
 	return -EINVAL;
@@ -223,7 +222,8 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 
 static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
 {
-	pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
+	/* Use raw _printk() to avoid cyclic dependency. */
+	_printk(KERN_WARNING "kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
 	return 0;
 }
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 9497f6b98339..c20f55df7fa6 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -5,6 +5,7 @@
 #include <linux/stdarg.h>
 #include <linux/init.h>
 #include <linux/kern_levels.h>
+#include <linux/printk_core.h>
 #include <linux/linkage.h>
 #include <linux/cache.h>
 #include <linux/ratelimit_types.h>
@@ -144,32 +145,6 @@ void early_printk(const char *s, ...) { }
 struct dev_printk_info;
 
 #ifdef CONFIG_PRINTK
-asmlinkage __printf(4, 0)
-int vprintk_emit(int facility, int level,
-		 const struct dev_printk_info *dev_info,
-		 const char *fmt, va_list args);
-
-asmlinkage __printf(1, 0)
-int vprintk(const char *fmt, va_list args);
-
-asmlinkage __printf(1, 2) __cold
-int _printk(const char *fmt, ...);
-
-/*
- * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
- */
-__printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
-
-extern void __printk_safe_enter(void);
-extern void __printk_safe_exit(void);
-/*
- * The printk_deferred_enter/exit macros are available only as a hack for
- * some code paths that need to defer all printk console printing. Interrupts
- * must be disabled for the deferred duration.
- */
-#define printk_deferred_enter __printk_safe_enter
-#define printk_deferred_exit __printk_safe_exit
-
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
  * with all other unrelated printk_ratelimit() callsites.  Instead use
@@ -189,7 +164,6 @@ devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write, void *buf,
 
 extern void wake_up_klogd(void);
 
-char *log_buf_addr_get(void);
 u32 log_buf_len_get(void);
 void log_buf_vmcoreinfo_setup(void);
 void __init setup_log_buf(int early);
@@ -200,30 +174,6 @@ extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 #else
-static inline __printf(1, 0)
-int vprintk(const char *s, va_list args)
-{
-	return 0;
-}
-static inline __printf(1, 2) __cold
-int _printk(const char *s, ...)
-{
-	return 0;
-}
-static inline __printf(1, 2) __cold
-int _printk_deferred(const char *s, ...)
-{
-	return 0;
-}
-
-static inline void printk_deferred_enter(void)
-{
-}
-
-static inline void printk_deferred_exit(void)
-{
-}
-
 static inline int printk_ratelimit(void)
 {
 	return 0;
@@ -238,11 +188,6 @@ static inline void wake_up_klogd(void)
 {
 }
 
-static inline char *log_buf_addr_get(void)
-{
-	return NULL;
-}
-
 static inline u32 log_buf_len_get(void)
 {
 	return 0;
diff --git a/include/linux/printk_core.h b/include/linux/printk_core.h
new file mode 100644
index 000000000000..a2b8727a2873
--- /dev/null
+++ b/include/linux/printk_core.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KERNEL_PRINTK_CORE__
+#define __KERNEL_PRINTK_CORE__
+
+#include <linux/stdarg.h>
+#include <linux/kern_levels.h>
+#include <linux/linkage.h>
+
+/* Low level printk API. Use carefully! */
+
+#ifdef CONFIG_PRINTK
+
+struct dev_printk_info;
+
+asmlinkage __printf(4, 0)
+int vprintk_emit(int facility, int level,
+		 const struct dev_printk_info *dev_info,
+		 const char *fmt, va_list args);
+
+asmlinkage __printf(1, 0)
+int vprintk(const char *fmt, va_list args);
+
+asmlinkage __printf(1, 2) __cold
+int _printk(const char *fmt, ...);
+
+/*
+ * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
+ */
+__printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
+
+extern void __printk_safe_enter(void);
+extern void __printk_safe_exit(void);
+/*
+ * The printk_deferred_enter/exit macros are available only as a hack for
+ * some code paths that need to defer all printk console printing. Interrupts
+ * must be disabled for the deferred duration.
+ */
+#define printk_deferred_enter __printk_safe_enter
+#define printk_deferred_exit __printk_safe_exit
+
+char *log_buf_addr_get(void);
+
+#else /* CONFIG_PRINTK */
+
+static inline __printf(1, 0)
+int vprintk(const char *s, va_list args)
+{
+	return 0;
+}
+static inline __printf(1, 2) __cold
+int _printk(const char *s, ...)
+{
+	return 0;
+}
+static inline __printf(1, 2) __cold
+int _printk_deferred(const char *s, ...)
+{
+	return 0;
+}
+
+static inline void printk_deferred_enter(void)
+{
+}
+
+static inline void printk_deferred_exit(void)
+{
+}
+
+static inline char *log_buf_addr_get(void)
+{
+	return NULL;
+}
+
+#endif /* CONFING_PRINTK */
+
+#endif
-- 
2.26.2

