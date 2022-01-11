Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7548AFEA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbiAKOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbiAKOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:53:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5C7C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 06:53:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u25so68247277edf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+BSTvDaR8q9ZbGFHEWnz5GWg0gMLRTM+z4m8NSdoTRA=;
        b=sl7x7P/h2rPgH/FwoISYVQ03Or+RjPrP7BIJmflNZlnl03ZXtmytOvEe7eDb1vxLRh
         EXrV5/bxfYy8U+kUoiRWyBgDoQVal0TQfjP0yAkd/C46SSuTSPVh5T6WD7v/7+l1DczZ
         HuW4veT/YDEm9Q4yku2lOa2A3XRCaOo42FJ7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+BSTvDaR8q9ZbGFHEWnz5GWg0gMLRTM+z4m8NSdoTRA=;
        b=xk+iGcsQTlJrZAUtVPj6XwqRhoWFaq+xLZqPVU+C28dwguJsvQVjA3goY2bFZriMSM
         Jp/IoZjbRZ1dtFMIjxz+sVgw4dxJrGfBfsvVn8kqP27XbKWTbMqCE4jVNY2Up+PQiavL
         aVITui0pb/wtb/IkG8okh44HGdclnvofSs2crw310BLceyWZyXEZMO6SdieOTmC16pke
         Gckas8QipNAVo+UEna7uvEDbmgBbQ5v4+LI4RBPJ/je13NwSm/TMx/HxOYR4R03h92uF
         0fKxNRkdmw3McpK4I2TkKV7Yiy2BozQdjJ/TJnn8Ht09CJf3yNDClGN3bAsY9xsPOriA
         hMFw==
X-Gm-Message-State: AOAM531ZSbMfayxnQWTK3Ce1Vw4FdW02YI7RUxUwlU8EIVQWD/mAuMJZ
        nhJhwqS7DrSC8RJOQhMlykwJMA==
X-Google-Smtp-Source: ABdhPJyvrsSs3ZBg/p3T6F2rc40/Y0GON6AFeQMR3l0bTiTgRsqeWZzMwUGc8zgEY9p7JiYe0QB8Ig==
X-Received: by 2002:aa7:d859:: with SMTP id f25mr4667368eds.292.1641912785691;
        Tue, 11 Jan 2022 06:53:05 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:36c0])
        by smtp.gmail.com with ESMTPSA id 24sm3608683eje.158.2022.01.11.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 06:53:05 -0800 (PST)
Date:   Tue, 11 Jan 2022 14:53:04 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC 1/2] printk/dynamic_debug: Remove cyclic dependency between
 printk.h and dynamic_debug.h
Message-ID: <Yd2Z0NrG1+Yhmseg@chrisdown.name>
References: <20220111143046.14680-1-pmladek@suse.com>
 <20220111143046.14680-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220111143046.14680-2-pmladek@suse.com>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Petr,

Petr Mladek writes:
>`make headerdep` reports many circular dependencies with the same
>pattern:
>
>In file included from linux/printk.h,
>                 from linux/dynamic_debug.h:188
>                 from linux/printk.h:559 <-- here
>
>It looks like false positive:
>
>   + printk.h includes dynamic_debug.h when CONFIG_DYNAMIC_DEBUG_CORE
>   + dynamic_debug.h includes printk.h when !CONFIG_DYNAMIC_DEBUG_CORE
>
>Anyway, it would be great to get rid of this dependency because it is
>tricky and it might hit us in the future. Also it might hide another
>more complicated cyclic dependencies.

Sounds reasonable.

>One solution would be to move the inlined ddebug_dyndbg_module_param_cb()
>and dynamic_debug_exec_queries() from 'dynamic_debug.h' into some .c so
>that it will not be needed to inline printk() in 'dynamic_debug.h'.
>
>The obvious location would be 'lib/dynamic_debug.c'. But it is built
>only when CONFIG_DYNAMIC_DEBUG_CORE is set. And the problematic
>inline variants are used only when this config option is _not_ set.
>So that it is not that easy.
>
>Instead, this patch adds 'include/linux/printk_core.h' and moves some
>lowlevel printk API there. Then the raw _printk() can be called from
>the inlined code in 'dynamic_debug.h'.
>
>Note that it is not enough to declare _printk() in 'dynamic_debug.h'.
>It would break build with CONFIG_PRINTK where it is an inlined nope.

s/nope/nop/, and you mean !CONFIG_PRINTK instead of CONFIG_PRINTK. Or did I 
misunderstand?

>
>The drawback of this approach is that _printk() does not add metadata for
>printk indexing and the message is not listed in <debugfs>/printk/index/.
>But it should be acceptable here. The strings are used only for debugging.

Agreed that these are fine to omit from a printk indexing perspective.

>The advantage is that this approach might be used to solve other cyclic
>dependencies, for example in bug.h.
>
>Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>Signed-off-by: Petr Mladek <pmladek@suse.com>

Thanks! Looks good to me with changelog fixes.

Acked-by: Chris Down <chris@chrisdown.name>

>---
> MAINTAINERS                   |  1 +
> include/linux/dynamic_debug.h | 10 ++---
> include/linux/printk.h        | 57 +-------------------------
> include/linux/printk_core.h   | 76 +++++++++++++++++++++++++++++++++++
> 4 files changed, 83 insertions(+), 61 deletions(-)
> create mode 100644 include/linux/printk_core.h
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index fb18ce7168aa..eadb77da01db 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -15340,6 +15340,7 @@ R:	Steven Rostedt <rostedt@goodmis.org>
> R:	John Ogness <john.ogness@linutronix.de>
> S:	Maintained
> F:	include/linux/printk.h
>+F:	include/linux/printk_core.h
> F:	kernel/printk/
>
> PRINTK INDEXING
>diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
>index dce631e678dd..63f6ebd6a14c 100644
>--- a/include/linux/dynamic_debug.h
>+++ b/include/linux/dynamic_debug.h
>@@ -185,7 +185,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>
> #include <linux/string.h>
> #include <linux/errno.h>
>-#include <linux/printk.h>
>+#include <linux/printk_core.h>
>
> static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
> 				    const char *modname)
>@@ -202,9 +202,8 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
> 						const char *modname)
> {
> 	if (strstr(param, "dyndbg")) {
>-		/* avoid pr_warn(), which wants pr_fmt() fully defined */
>-		printk(KERN_WARNING "dyndbg param is supported only in "
>-			"CONFIG_DYNAMIC_DEBUG builds\n");
>+		/* Use raw _printk() to avoid cyclic dependency. */
>+		_printk(KERN_WARNING "dyndbg param is supported only in CONFIG_DYNAMIC_DEBUG builds\n");
> 		return 0; /* allow and ignore */
> 	}
> 	return -EINVAL;
>@@ -223,7 +222,8 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
>
> static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
> {
>-	pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
>+	/* Use raw _printk() to avoid cyclic dependency. */
>+	_printk(KERN_WARNING "kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
> 	return 0;
> }
>
>diff --git a/include/linux/printk.h b/include/linux/printk.h
>index 9497f6b98339..c20f55df7fa6 100644
>--- a/include/linux/printk.h
>+++ b/include/linux/printk.h
>@@ -5,6 +5,7 @@
> #include <linux/stdarg.h>
> #include <linux/init.h>
> #include <linux/kern_levels.h>
>+#include <linux/printk_core.h>
> #include <linux/linkage.h>
> #include <linux/cache.h>
> #include <linux/ratelimit_types.h>
>@@ -144,32 +145,6 @@ void early_printk(const char *s, ...) { }
> struct dev_printk_info;
>
> #ifdef CONFIG_PRINTK
>-asmlinkage __printf(4, 0)
>-int vprintk_emit(int facility, int level,
>-		 const struct dev_printk_info *dev_info,
>-		 const char *fmt, va_list args);
>-
>-asmlinkage __printf(1, 0)
>-int vprintk(const char *fmt, va_list args);
>-
>-asmlinkage __printf(1, 2) __cold
>-int _printk(const char *fmt, ...);
>-
>-/*
>- * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
>- */
>-__printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
>-
>-extern void __printk_safe_enter(void);
>-extern void __printk_safe_exit(void);
>-/*
>- * The printk_deferred_enter/exit macros are available only as a hack for
>- * some code paths that need to defer all printk console printing. Interrupts
>- * must be disabled for the deferred duration.
>- */
>-#define printk_deferred_enter __printk_safe_enter
>-#define printk_deferred_exit __printk_safe_exit
>-
> /*
>  * Please don't use printk_ratelimit(), because it shares ratelimiting state
>  * with all other unrelated printk_ratelimit() callsites.  Instead use
>@@ -189,7 +164,6 @@ devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write, void *buf,
>
> extern void wake_up_klogd(void);
>
>-char *log_buf_addr_get(void);
> u32 log_buf_len_get(void);
> void log_buf_vmcoreinfo_setup(void);
> void __init setup_log_buf(int early);
>@@ -200,30 +174,6 @@ extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
> extern asmlinkage void dump_stack(void) __cold;
> void printk_trigger_flush(void);
> #else
>-static inline __printf(1, 0)
>-int vprintk(const char *s, va_list args)
>-{
>-	return 0;
>-}
>-static inline __printf(1, 2) __cold
>-int _printk(const char *s, ...)
>-{
>-	return 0;
>-}
>-static inline __printf(1, 2) __cold
>-int _printk_deferred(const char *s, ...)
>-{
>-	return 0;
>-}
>-
>-static inline void printk_deferred_enter(void)
>-{
>-}
>-
>-static inline void printk_deferred_exit(void)
>-{
>-}
>-
> static inline int printk_ratelimit(void)
> {
> 	return 0;
>@@ -238,11 +188,6 @@ static inline void wake_up_klogd(void)
> {
> }
>
>-static inline char *log_buf_addr_get(void)
>-{
>-	return NULL;
>-}
>-
> static inline u32 log_buf_len_get(void)
> {
> 	return 0;
>diff --git a/include/linux/printk_core.h b/include/linux/printk_core.h
>new file mode 100644
>index 000000000000..a2b8727a2873
>--- /dev/null
>+++ b/include/linux/printk_core.h
>@@ -0,0 +1,76 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef __KERNEL_PRINTK_CORE__
>+#define __KERNEL_PRINTK_CORE__
>+
>+#include <linux/stdarg.h>
>+#include <linux/kern_levels.h>
>+#include <linux/linkage.h>
>+
>+/* Low level printk API. Use carefully! */
>+
>+#ifdef CONFIG_PRINTK
>+
>+struct dev_printk_info;
>+
>+asmlinkage __printf(4, 0)
>+int vprintk_emit(int facility, int level,
>+		 const struct dev_printk_info *dev_info,
>+		 const char *fmt, va_list args);
>+
>+asmlinkage __printf(1, 0)
>+int vprintk(const char *fmt, va_list args);
>+
>+asmlinkage __printf(1, 2) __cold
>+int _printk(const char *fmt, ...);
>+
>+/*
>+ * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
>+ */
>+__printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
>+
>+extern void __printk_safe_enter(void);
>+extern void __printk_safe_exit(void);
>+/*
>+ * The printk_deferred_enter/exit macros are available only as a hack for
>+ * some code paths that need to defer all printk console printing. Interrupts
>+ * must be disabled for the deferred duration.
>+ */
>+#define printk_deferred_enter __printk_safe_enter
>+#define printk_deferred_exit __printk_safe_exit
>+
>+char *log_buf_addr_get(void);
>+
>+#else /* CONFIG_PRINTK */
>+
>+static inline __printf(1, 0)
>+int vprintk(const char *s, va_list args)
>+{
>+	return 0;
>+}
>+static inline __printf(1, 2) __cold
>+int _printk(const char *s, ...)
>+{
>+	return 0;
>+}
>+static inline __printf(1, 2) __cold
>+int _printk_deferred(const char *s, ...)
>+{
>+	return 0;
>+}
>+
>+static inline void printk_deferred_enter(void)
>+{
>+}
>+
>+static inline void printk_deferred_exit(void)
>+{
>+}
>+
>+static inline char *log_buf_addr_get(void)
>+{
>+	return NULL;
>+}
>+
>+#endif /* CONFING_PRINTK */
>+
>+#endif
>-- 
>2.26.2
>
