Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D85487CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiAGTNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:13:05 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:56522 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAGTNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Mu1MS8v1YzWJzK/MkK2PdJuPfEK7bSkcuv2REn2NNb8=; b=dIi4im8Bs6aHDOq1WtOtg23xKy
        GIqoPfETwRdhZGA5aVzai4O8s00JtAygFf6vxflWWwkRTphEQDAV+oyHzuI0CWmeNR7jVhOwEV6+y
        EPiOTqO5F3Qz95gVMbbOD3M0PqeG841KF8LNkrBvcb2EW4JPE9oRpS1X4XuutPQIYvyAsGJmngt5W
        ++XkmCOcrrimDnqAo7aklRvF20yHH/tN6/YOdjAFakbSTceqfevV56+g8T9Zes54rcfG5UcZk91Wj
        nbGeejMi2gQ+4LvB+0PBEv5KKLzRnqDXvudvONQSB7P/Mhje5JR6qEXpjwBJTHPBg1Vnc68cZCo91
        6qblIVfA==;
Received: from [179.113.53.20] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1n5ufb-0004cp-Oy; Fri, 07 Jan 2022 20:13:00 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com
Cc:     linux-doc@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        stern@rowland.harvard.edu, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, gpiccoli@igalia.com, kernel@gpiccoli.net
Subject: [PATCH V3] notifier/panic: Introduce panic_notifier_filter
Date:   Fri,  7 Jan 2022 16:12:33 -0300
Message-Id: <20220107191233.172644-1-gpiccoli@igalia.com>
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



V3:

* Implemented Alan's suggestion (thanks!), simplifying the check code
in the notifiers register/unregister functions. Notice that the
suggestion was missing a negative in the check function, I even
renamed it now, to be more clear:
s/is_panic_notifier_filtered/should_register_panic_notifier

The condition is !(A && B && C), and C is the check function, that
returns true when a symbol *is found* in the notifier filter; hence
we need to invert that here, as you can see in the code.


* Implemented Andy's suggestion (thanks!), to reduce the code in
the parameter parsing loop. Notice that strsep() modifies the buffer,
so not sure if it was a typo but the correct code here is:

single_param = strsep(&full_param_buffer, ",");


* "Bumped" the log output of the parsing function: users should be
warned in the errors (invalid symbol or exceeded entries) and
informed (pr_info) in case the parsing succeeded - I think pr_debug
was useless there.

Cheers,

Guilherme



 .../admin-guide/kernel-parameters.txt         | 14 +++++-
 include/linux/panic_notifier.h                | 10 +++++
 kernel/notifier.c                             | 44 +++++++++++++++++--
 kernel/panic.c                                | 43 ++++++++++++++++++
 4 files changed, 106 insertions(+), 5 deletions(-)

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
index b8251dc0bc0f..4fc450bbf677 100644
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
+static bool should_register_panic_notifier(struct notifier_block *n)
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
@@ -140,10 +163,15 @@ int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
 		struct notifier_block *n)
 {
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&nh->lock, flags);
-	ret = notifier_chain_register(&nh->head, n);
+
+	if (!(nh == &panic_notifier_list &&
+	     (panic_nf_count > 0) &&
+	     !should_register_panic_notifier(n)))
+		ret = notifier_chain_register(&nh->head, n);
+
 	spin_unlock_irqrestore(&nh->lock, flags);
 	return ret;
 }
@@ -155,6 +183,9 @@ EXPORT_SYMBOL_GPL(atomic_notifier_chain_register);
  *	@n: Entry to remove from notifier chain
  *
  *	Removes a notifier from an atomic notifier chain.
+ *	If "panic_notifier_filter" is provided, we hereby filter the
+ *	panic_notifier_list and only allow unregistering the functions
+ *	that are present in the filter.
  *
  *	Returns zero on success or %-ENOENT on failure.
  */
@@ -162,10 +193,15 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 		struct notifier_block *n)
 {
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&nh->lock, flags);
-	ret = notifier_chain_unregister(&nh->head, n);
+
+	if (!(nh == &panic_notifier_list &&
+	     (panic_nf_count > 0) &&
+	     !should_register_panic_notifier(n)))
+		ret = notifier_chain_unregister(&nh->head, n);
+
 	spin_unlock_irqrestore(&nh->lock, flags);
 	synchronize_rcu();
 	return ret;
diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..2603700a07a4 100644
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
@@ -146,6 +157,38 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
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
+	while ((func = strsep(&buf, ","))) {
+		addr = kallsyms_lookup_name(func);
+
+		if (!addr) {
+			pr_warn("panic_notifier_filter: invalid symbol %s\n", func);
+			continue;
+		}
+
+		if (panic_nf_count < PANIC_NF_MAX) {
+			panic_nf_functions[panic_nf_count] = addr;
+			panic_nf_count++;
+			pr_info("panic_notifier_filter: added symbol %s\n", func);
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

