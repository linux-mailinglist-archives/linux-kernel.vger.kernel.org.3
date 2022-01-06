Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A26486AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbiAFUAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:00:40 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:35042 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243514AbiAFUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/cYCB+nyk4l4LuYJm0hQlGdnM/7wWMNahx2RxhyHSEI=; b=B08r6w4nhIB1WN6jhyhIAqNBfZ
        I1hO8vd79TpZVOIDMtNTVLdsIsBSVnNqns9EqjGvtw+0gUB10e+sZxm8YMOPJehRVwndI17uIPZ50
        7OEWiFnB6iPW8tHlWRdyjlE9YPQsNKabXXg0u0W3CokEVpYlwGMbra+Am77hZqbOGoZbnCwEWHnhe
        dNQRuI5jSamLMjxh/OCZxz08/yC6XIUChxxc5x71qwsNMPF7PJCJL+c8MTuEUaZcRPofmmDbsj9RQ
        ftm8dxngNOzBSDZ3DXxxmpMIuhdILhlKGlrVS57A17xhkjEP7JG1/SExW9vYTg+a6/2KPjdLyO+bT
        qrl/FCJw==;
Received: from [179.113.53.20] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1n5Yw0-0009ZF-7e; Thu, 06 Jan 2022 21:00:29 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com
Cc:     linux-doc@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        stern@rowland.harvard.edu, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, gpiccoli@igalia.com, kernel@gpiccoli.net
Subject: [PATCH V2] notifier/panic: Introduce panic_notifier_filter
Date:   Thu,  6 Jan 2022 17:00:07 -0300
Message-Id: <20220106200007.112357-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel notifier infrastructure allows function callbacks to be
added in multiple lists, which are then called in the proper time,
like in a reboot or panic event. The panic_notifier_list specifically
contains the callbacks that are executed during a panic event. As any
other notifier list, the panic one has no filtering and all functions
previously registered are executed.

The kdump infrastructure, on the other hand, enables users to set
a crash kernel that is kexec'ed in a panic event, and vmcore/logs
are collected in such crash kernel. When kdump is set, by default
the panic notifiers are ignored - the kexec jumps to the crash kernel
before the list is checked and callbacks executed.

There are some cases though in which kdump users might want to
allow panic notifier callbacks to execute _before_ the kexec to
the crash kernel, for a variety of reasons - for example, users
may think kexec is very prone to fail and want to give a chance
to kmsg dumpers to run (and save logs using pstore), or maybe
some panic notifier is required to properly quiesce some hardware
that must be used to the crash kernel. For these cases, we have
the kernel parameter "crash_kexec_post_notifiers".

But there's a problem: currently it's an "all-or-nothing" situation,
the kdump user choice is either to execute all panic notifiers or
none of them. Given that panic notifiers may increase the risk of a
kdump failure, this is a tough decision and may affect the debug of
hard to reproduce bugs, if for some reason the user choice is to
enable panic notifiers, but kdump then fails.

So, this patch aims to ease this decision: we hereby introduce a filter
for the panic notifier list, in which users may select specifically
which callbacks they wish to run, allowing a safer kdump. The allowlist
should be provided using the parameter "panic_notifier_filter=a,b,..."
where a, b are valid callback names. Invalid symbols are discarded.

Currently up to 16 symbols may be passed in this list, we consider
that this numbers allows enough flexibility (and no matter what
architecture is used, at most 30 panic callbacks are registered).
In an experiment using a qemu x86 virtual machine, by default only
six callbacks are registered in the panic notifier list.
Once a valid callback name is provided in the list, such function
is allowed to be registered/unregistered in the panic_notifier_list;
all other panic callbacks are ignored. Notice that this filter is
only for the panic notifiers and has no effect in the other notifiers.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V2: Sorry, I've made a confusion/typo in the header file, by
inverting the types of 2 variables. Fixed now, and below I kept
the design comments. Cheers!


Hi folks, thanks in advance for reviews/suggestions! Some design
decisions are worth to mention:

(a) I've played first with a list approach instead of a static
array, but noticed that..it'd require relying in memblock allocs,
since we need to set the filter pretty early in boot process. So,
decided to abandon that - a small array is cheap and much easier to
implement.

(b) The size of the array: I've counted < 30 panic notifiers for
any architecture, and in my experiment only six are registered by
default, in a qemu x86 guest. Also, doesn't make sense for the
filter users to add a bunch of callbacks to the list, or else
why are they using the filter in first place? So 16 seems a
good trade-off.

(c) Allowlist vs. denylist: this is something to consider. My
approach is that functions listed in the filter are *allowed*
to execute in the panic notifier, because this seems to me
the most appropriate use case - kdump users might want one or 2
callbacks to execute, and block all the other in a denylist
seems bummer. But I'm open to ideas, of course, if the denylist
approach seems more reasonable.

(d) I've also tested __setup() instead of early_param(), but
seems we don't catch all notifiers by then, so decided to set
the filter really early.

(e) Finally, an alternative would be to check the filter during
the notifier call chain, but I thought it is simple and likely
less invasive to just prevent registering the disallowed functions.

Cheers,

Guilherme


 .../admin-guide/kernel-parameters.txt         | 14 +++++-
 include/linux/panic_notifier.h                | 10 +++++
 kernel/notifier.c                             | 42 +++++++++++++++++-
 kernel/panic.c                                | 44 +++++++++++++++++++
 4 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2fba82431efb..2dc4e98823ae 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3727,13 +3727,25 @@
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
+	panic_notifier_filter=[function-list]
+			Limit the functions registered by the panic notifier
+			infrastructure. This allowlist is composed by function
+			names, comma separated (invalid symbols are filtered
+			out). Such functionality is useful for kdump users
+			that set "crash_kexec_post_notifiers" in order to
+			execute	panic notifiers, but at the same time wish to
+			have just a subset of notifiers, not all of them. The
+			list of functions is limited to 16 entries currently.
+
 	crash_kexec_post_notifiers
 			Run kdump after running panic-notifiers and dumping
 			kmsg. This only for the users who doubt kdump always
 			succeeds in any situation.
 			Note that this also increases risks of kdump failure,
 			because some panic notifiers can make the crashed
-			kernel more unstable.
+			kernel more unstable. See the "panic_notifier_filter"
+			parameter to have more control of which notifiers to
+			execute.
 
 	parkbd.port=	[HW] Parallel port number the keyboard adapter is
 			connected to, default is 0.
diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index 41e32483d7a7..9a96753e96d8 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -5,6 +5,16 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
 
+/*
+ * The panic notifier filter infrastructure - each array element holds a
+ * function address, to be checked against panic_notifier register/unregister
+ * operations; these functions are allowed to be registered in the panic
+ * notifier list. This setting is useful for kdump, since users may want
+ * some panic notifiers to execute, but not all of them.
+ */
+extern unsigned long panic_nf_functions[];
+extern int panic_nf_count;
+
 extern struct atomic_notifier_head panic_notifier_list;
 
 extern bool crash_kexec_post_notifiers;
diff --git a/kernel/notifier.c b/kernel/notifier.c
index b8251dc0bc0f..04cb9e956058 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/panic_notifier.h>
 #include <linux/kdebug.h>
 #include <linux/kprobes.h>
 #include <linux/export.h>
@@ -127,12 +128,34 @@ static int notifier_call_chain_robust(struct notifier_block **nl,
  *	use a spinlock, and call_chain is synchronized by RCU (no locks).
  */
 
+/*
+ * The following helper is part of the panic notifier filter infrastructure;
+ * users can filter what functions they wish to allow being registered in the
+ * notifier system, restricted to the panic notifier. This is useful for kdump
+ * for example, when some notifiers are relevant but running all of them imposes
+ * risks to the kdump kernel reliability.
+ */
+static bool is_panic_notifier_filtered(struct notifier_block *n)
+{
+	int i;
+
+	for (i = 0; i < panic_nf_count; i++) {
+		if ((unsigned long)(n->notifier_call) == panic_nf_functions[i])
+			return true;
+	}
+
+	return false;
+}
+
 /**
  *	atomic_notifier_chain_register - Add notifier to an atomic notifier chain
  *	@nh: Pointer to head of the atomic notifier chain
  *	@n: New entry in notifier chain
  *
  *	Adds a notifier to an atomic notifier chain.
+ *	If "panic_notifier_filter" is provided, we hereby filter the
+ *	panic_notifier_list and only allow registering the functions
+ *	that are present in the filter.
  *
  *	Currently always returns zero.
  */
@@ -140,10 +163,16 @@ int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
 		struct notifier_block *n)
 {
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&nh->lock, flags);
+	if (unlikely(panic_nf_count) && nh == &panic_notifier_list)
+		if (!is_panic_notifier_filtered(n))
+			goto panic_filtered_out;
+
 	ret = notifier_chain_register(&nh->head, n);
+
+panic_filtered_out:
 	spin_unlock_irqrestore(&nh->lock, flags);
 	return ret;
 }
@@ -155,6 +184,9 @@ EXPORT_SYMBOL_GPL(atomic_notifier_chain_register);
  *	@n: Entry to remove from notifier chain
  *
  *	Removes a notifier from an atomic notifier chain.
+ *	If "panic_notifier_filter" is provided, we hereby filter the
+ *	panic_notifier_list and only allow unregistering the functions
+ *	that are present in the filter.
  *
  *	Returns zero on success or %-ENOENT on failure.
  */
@@ -162,10 +194,16 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 		struct notifier_block *n)
 {
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&nh->lock, flags);
+	if (unlikely(panic_nf_count) && nh == &panic_notifier_list)
+		if (!is_panic_notifier_filtered(n))
+			goto panic_filtered_out;
+
 	ret = notifier_chain_unregister(&nh->head, n);
+
+panic_filtered_out:
 	spin_unlock_irqrestore(&nh->lock, flags);
 	synchronize_rcu();
 	return ret;
diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..c23fa2012be1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -31,6 +31,7 @@
 #include <linux/console.h>
 #include <linux/bug.h>
 #include <linux/ratelimit.h>
+#include <linux/kallsyms.h>
 #include <linux/debugfs.h>
 #include <asm/sections.h>
 
@@ -67,6 +68,16 @@ EXPORT_SYMBOL_GPL(panic_timeout);
 #define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
 unsigned long panic_print;
 
+/*
+ * Kernel has currently < 30 panic handlers no matter the arch,
+ * based on some code counting; so 16 items seems a good amount;
+ * users that are filtering panic notifiers shouldn't add all
+ * of them in theory, that doesn't make sense...
+ */
+#define	PANIC_NF_MAX	16
+unsigned long panic_nf_functions[PANIC_NF_MAX];
+int panic_nf_count;
+
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
@@ -146,6 +157,39 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 }
 EXPORT_SYMBOL(nmi_panic);
 
+static int __init panic_notifier_filter_setup(char *buf)
+{
+	char *func;
+	unsigned long addr;
+
+	if (!buf)
+		return -EINVAL;
+
+	while (buf) {
+		func = strsep(&buf, ",");
+		addr = kallsyms_lookup_name(func);
+
+		if (!addr) {
+			pr_info("panic_notifier_filter: invalid symbol %s\n", func);
+			continue;
+		}
+
+		if (panic_nf_count < PANIC_NF_MAX) {
+			panic_nf_functions[panic_nf_count] = addr;
+			panic_nf_count++;
+			pr_debug("panic_notifier_filter: added symbol %s\n", func);
+		} else {
+			pr_warn("panic_notifier_filter: exceeded maximum notifiers (%d), aborting\n",
+				PANIC_NF_MAX);
+			panic_nf_count = 0;
+			break;
+		}
+	}
+
+	return 0;
+}
+early_param("panic_notifier_filter", panic_notifier_filter_setup);
+
 static void panic_print_sys_info(void)
 {
 	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
-- 
2.34.1

