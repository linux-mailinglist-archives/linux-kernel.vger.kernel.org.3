Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41848AF94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbiAKObD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:31:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48328 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbiAKObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:31:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48D621F3B8;
        Tue, 11 Jan 2022 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641911460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eW5ogIRA+3JJSpuPtEkeBh+OEyLoW7/5NuZZjnwaAw=;
        b=ek/XVNEUf/iS5hOX5nxXhjB4npCGu9WGcTQezhzo19aHtAALQxs1e9vnyshShaWaf08WVi
        Pm5DgGPrHc1yuKswS/h7Caal9Uie53D52FLt2nsCPGcnH4VXLzitynrnJaoj8w9cJ4oTs7
        NAARLYDwTJIE5YdeEcEK8F4UibneD/g=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id F32B9A3B88;
        Tue, 11 Jan 2022 14:30:59 +0000 (UTC)
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
Subject: [RFC 2/2] printk/bug: Remove cyclic dependency between bug.h and printk.h
Date:   Tue, 11 Jan 2022 15:30:46 +0100
Message-Id: <20220111143046.14680-3-pmladek@suse.com>
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

In file included from linux/bug.h,
                 from linux/jump_label.h:262
                 from linux/dynamic_debug.h:6
                 from linux/printk.h:504
                 from asm-generic/bug.h:22
                 from linux/bug.h:32 <-- here

It does not cause real problem because 'asm-generic/bug.h' uses only
plain printk() and no_printk(). And these two functions are defined
in 'printk.h' before 'dynamic_debug.h' is included.

There is no easy solution because all affected code does some inline
tricks:

  + printk() adds struct pi_entry metadata
  + dynamic_pr_debug() adds struct _ddebug metadata
  + static_branch_likely() adds assembly that realizes the jump
  + BUG() prints __FILE__, __LINE__, __func__ where it is inlined

One solution would be to modify BUG() and pass __FILE__, __LINE__,
__func__ into a helper function implemented in a .c source file.
It will not require including "printk.h" in "bug.h". The drawback
is code complication.

Alternative solution is to include "printk_core.h" and use the raw
_printk(). The drawback is that the string will not be listed in
printk index. But it will afftect only few architectires that do
not define HAVE_ARCH_BUG.

This patch uses the alternative solution because it seems to be
easier to maintain. The BUG() definitions are already complicated
enough thanks to all the ifdefs.

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/asm-generic/bug.h   |  4 ++--
 include/linux/printk.h      | 11 -----------
 include/linux/printk_core.h | 11 +++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index edb0e2a602a8..140afb8bdfe7 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -19,7 +19,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/panic.h>
-#include <linux/printk.h>
+#include <linux/printk_core.h>
 
 #ifdef CONFIG_BUG
 
@@ -55,7 +55,7 @@ struct bug_entry {
  */
 #ifndef HAVE_ARCH_BUG
 #define BUG() do { \
-	printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
+	_printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
 	barrier_before_unreachable(); \
 	panic("BUG!"); \
 } while (0)
diff --git a/include/linux/printk.h b/include/linux/printk.h
index c20f55df7fa6..23530b0a2a07 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -123,17 +123,6 @@ struct va_format {
  */
 #define DEPRECATED	"[Deprecated]: "
 
-/*
- * Dummy printk for disabled debugging statements to use whilst maintaining
- * gcc's format checking.
- */
-#define no_printk(fmt, ...)				\
-({							\
-	if (0)						\
-		printk(fmt, ##__VA_ARGS__);		\
-	0;						\
-})
-
 #ifdef CONFIG_EARLY_PRINTK
 extern asmlinkage __printf(1, 2)
 void early_printk(const char *fmt, ...);
diff --git a/include/linux/printk_core.h b/include/linux/printk_core.h
index a2b8727a2873..37fc0e13fdbd 100644
--- a/include/linux/printk_core.h
+++ b/include/linux/printk_core.h
@@ -6,6 +6,17 @@
 #include <linux/kern_levels.h>
 #include <linux/linkage.h>
 
+/*
+ * Dummy printk for disabled debugging statements to use whilst maintaining
+ * gcc's format checking.
+ */
+#define no_printk(fmt, ...)				\
+({							\
+	if (0)						\
+		_printk(fmt, ##__VA_ARGS__);		\
+	0;						\
+})
+
 /* Low level printk API. Use carefully! */
 
 #ifdef CONFIG_PRINTK
-- 
2.26.2

