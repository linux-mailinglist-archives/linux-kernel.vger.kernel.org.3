Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6762548AFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiAKOzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiAKOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:55:01 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A39CC061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 06:55:01 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a18so67177617edj.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 06:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PqYfbAa8pU1gVmjYLttYBSyFlipgb5ScN7DsYmfVBaw=;
        b=wDvv8fIOKN3Ey5Cv2PlrUH9yaCpJRNal89V9ELdL4C7kmZakc40Ww8JNYPMk7XAKoH
         jXcxhGRKxQH6/AJEh+Qj85aDaIPVtB1WmMPneVXR2sCxXLHK5LOJRTsbG381GhN9kJeT
         Wf5KTxdC1YGKz07Zvsibd31PYBFh6EgLv/qps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PqYfbAa8pU1gVmjYLttYBSyFlipgb5ScN7DsYmfVBaw=;
        b=4pnw1BdNv28FOG4Vm5YPntgLF5IAwQZcLNQau3eYtBFdfUnG3tgksH+CttTolpEJpj
         ZRXzxAz7mlnb3Z/27soO2Msg4qxCj7vOOmtyMkxMVzyJkfwWHnbjb4TC7QHL3Q7JTQLI
         rdh4PVzatdd58I5VFOREoy9nGOT9xcQ4OCJkJYXWnK/FzUx+3SinI61SDh91slgcJxj6
         LG67lg6TplaGgqv9TWvAMorXnB3HRnHIh34DfN2YGJm2eHqLAuLZbLFslkLzmdTocCjt
         EowDxvbgq9qVfJ2wbEvRts8dJRj1A0js4qgupb8n0Biqmmmz6MYyfylotVAFJpxigMVS
         jGkg==
X-Gm-Message-State: AOAM531MbOs10cLCmSWRgmcwjSfuO6KNf0UnACLtrCu030kpN5fyNcLT
        L4dNlkzAhbk5mJcGqhq5VUp2PA==
X-Google-Smtp-Source: ABdhPJw6zBMRQ2xFOXz4OnvgWaSa8xoxXyqSinZwNsOQgAU8uoMz1jpjXNpO180xSV7o+ZgDvUTKrg==
X-Received: by 2002:a05:6402:95a:: with SMTP id h26mr4838228edz.130.1641912899578;
        Tue, 11 Jan 2022 06:54:59 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:36c0])
        by smtp.gmail.com with ESMTPSA id l1sm3590051ejh.57.2022.01.11.06.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 06:54:59 -0800 (PST)
Date:   Tue, 11 Jan 2022 14:54:58 +0000
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
Subject: Re: [RFC 2/2] printk/bug: Remove cyclic dependency between bug.h and
 printk.h
Message-ID: <Yd2aQmuDqsUU99Y6@chrisdown.name>
References: <20220111143046.14680-1-pmladek@suse.com>
 <20220111143046.14680-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220111143046.14680-3-pmladek@suse.com>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>`make headerdep` reports many circular dependencies with the same
>pattern:
>
>In file included from linux/bug.h,
>                 from linux/jump_label.h:262
>                 from linux/dynamic_debug.h:6
>                 from linux/printk.h:504
>                 from asm-generic/bug.h:22
>                 from linux/bug.h:32 <-- here
>
>It does not cause real problem because 'asm-generic/bug.h' uses only
>plain printk() and no_printk(). And these two functions are defined
>in 'printk.h' before 'dynamic_debug.h' is included.
>
>There is no easy solution because all affected code does some inline
>tricks:
>
>  + printk() adds struct pi_entry metadata
>  + dynamic_pr_debug() adds struct _ddebug metadata
>  + static_branch_likely() adds assembly that realizes the jump
>  + BUG() prints __FILE__, __LINE__, __func__ where it is inlined
>
>One solution would be to modify BUG() and pass __FILE__, __LINE__,
>__func__ into a helper function implemented in a .c source file.
>It will not require including "printk.h" in "bug.h". The drawback
>is code complication.
>
>Alternative solution is to include "printk_core.h" and use the raw
>_printk(). The drawback is that the string will not be listed in
>printk index. But it will afftect only few architectires that do
>not define HAVE_ARCH_BUG.
>
>This patch uses the alternative solution because it seems to be
>easier to maintain. The BUG() definitions are already complicated
>enough thanks to all the ifdefs.
>
>Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>Signed-off-by: Petr Mladek <pmladek@suse.com>

Thank you! Looks good.

Acked-by: Chris Down <chris@chrisdown.name>

>---
> include/asm-generic/bug.h   |  4 ++--
> include/linux/printk.h      | 11 -----------
> include/linux/printk_core.h | 11 +++++++++++
> 3 files changed, 13 insertions(+), 13 deletions(-)
>
>diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
>index edb0e2a602a8..140afb8bdfe7 100644
>--- a/include/asm-generic/bug.h
>+++ b/include/asm-generic/bug.h
>@@ -19,7 +19,7 @@
>
> #ifndef __ASSEMBLY__
> #include <linux/panic.h>
>-#include <linux/printk.h>
>+#include <linux/printk_core.h>
>
> #ifdef CONFIG_BUG
>
>@@ -55,7 +55,7 @@ struct bug_entry {
>  */
> #ifndef HAVE_ARCH_BUG
> #define BUG() do { \
>-	printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
>+	_printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
> 	barrier_before_unreachable(); \
> 	panic("BUG!"); \
> } while (0)
>diff --git a/include/linux/printk.h b/include/linux/printk.h
>index c20f55df7fa6..23530b0a2a07 100644
>--- a/include/linux/printk.h
>+++ b/include/linux/printk.h
>@@ -123,17 +123,6 @@ struct va_format {
>  */
> #define DEPRECATED	"[Deprecated]: "
>
>-/*
>- * Dummy printk for disabled debugging statements to use whilst maintaining
>- * gcc's format checking.
>- */
>-#define no_printk(fmt, ...)				\
>-({							\
>-	if (0)						\
>-		printk(fmt, ##__VA_ARGS__);		\
>-	0;						\
>-})
>-
> #ifdef CONFIG_EARLY_PRINTK
> extern asmlinkage __printf(1, 2)
> void early_printk(const char *fmt, ...);
>diff --git a/include/linux/printk_core.h b/include/linux/printk_core.h
>index a2b8727a2873..37fc0e13fdbd 100644
>--- a/include/linux/printk_core.h
>+++ b/include/linux/printk_core.h
>@@ -6,6 +6,17 @@
> #include <linux/kern_levels.h>
> #include <linux/linkage.h>
>
>+/*
>+ * Dummy printk for disabled debugging statements to use whilst maintaining
>+ * gcc's format checking.
>+ */
>+#define no_printk(fmt, ...)				\
>+({							\
>+	if (0)						\
>+		_printk(fmt, ##__VA_ARGS__);		\
>+	0;						\
>+})
>+
> /* Low level printk API. Use carefully! */
>
> #ifdef CONFIG_PRINTK
>-- 
>2.26.2
>
