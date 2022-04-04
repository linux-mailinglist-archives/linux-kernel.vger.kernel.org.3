Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90714F1BA0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380625AbiDDVVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379935AbiDDSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:24:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D798D22B37;
        Mon,  4 Apr 2022 11:22:19 -0700 (PDT)
Date:   Mon, 04 Apr 2022 18:22:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649096538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZakpqfaTx6lO1VIWJ0OCzSwvivmkKgp+Du7SeMUvK2c=;
        b=cBCoj8ciMjLvzRkb+ThdEDvEHyvzXVlqs6TKiA06UCOEaoT3VqgDGSHNf6nby1jNEbXyvI
        gfxre6H179OqxVvCz7rOVwW9wlaXZAyMeRdymLHxJZNWQRuA9tZK0zKtYu1x3B/MOnc5i+
        m8dYfvIUBiPiP0SkAOFWzBRUl10e0fm4lDJzGbOfxF6Eh9L8awNo/jqH0ME8H5Jc+RpwKK
        7mFl0rmJVKVPuW931ldFFkSDCK8CO9fqALY17O4z0SAUNOEm1cyoi64wNk++rrrh9qLrSV
        jq/VJWNhu1RADNeTLgyEriULQY5wWtKWm7CIFa3sVJIQQr1ib2oVOEtAvhtyvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649096538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZakpqfaTx6lO1VIWJ0OCzSwvivmkKgp+Du7SeMUvK2c=;
        b=x4la8kf/Yb/H8rueyVxWPuVjbXIcRHcEMdUv1d4DLhVmb1a9i+Zzzbg254xnYA2M1oCJxo
        iuqaX7FK8Cs9hkCg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove "noexec"
Cc:     Borislav Petkov <bp@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220127115626.14179-6-bp@alien8.de>
References: <20220127115626.14179-6-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164909653744.389.3722817751612158002.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     76ea0025a214cdf0d2c204f4c21cbffa9fb57c32
Gitweb:        https://git.kernel.org/tip/76ea0025a214cdf0d2c204f4c21cbffa9fb57c32
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 27 Jan 2022 12:56:25 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 10:17:03 +02:00

x86/cpu: Remove "noexec"

It doesn't make any sense to disable non-executable mappings -
security-wise or else.

So rip out that switch and move the remaining code into setup.c and
delete setup_nx.c

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220127115626.14179-6-bp@alien8.de
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +-
 Documentation/x86/x86_64/boot-options.rst       |  9 +--
 arch/x86/include/asm/proto.h                    |  1 +-
 arch/x86/kernel/setup.c                         | 28 ++++++-
 arch/x86/mm/Makefile                            |  3 +-
 arch/x86/mm/init_64.c                           |  1 +-
 arch/x86/mm/setup_nx.c                          | 62 +----------------
 7 files changed, 26 insertions(+), 83 deletions(-)
 delete mode 100644 arch/x86/mm/setup_nx.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 39ac2c1..a2299b2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3456,11 +3456,6 @@
 
 	noexec		[IA-64]
 
-	noexec		[X86]
-			On X86-32 available only on PAE configured kernels.
-			noexec=on: enable non-executable mappings (default)
-			noexec=off: disable non-executable mappings
-
 	nosmap		[PPC]
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 07aa000..fb6030a 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -157,15 +157,6 @@ Rebooting
      newer BIOS, or newer board) using this option will ignore the built-in
      quirk table, and use the generic default reboot actions.
 
-Non Executable Mappings
-=======================
-
-  noexec=on|off
-    on
-      Enable(default)
-    off
-      Disable
-
 NUMA
 ====
 
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index feed36d..0f899c8 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -35,7 +35,6 @@ void xen_entry_INT80_compat(void);
 #endif
 
 void x86_configure_nx(void);
-void x86_report_nx(void);
 
 extern int reboot_force;
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c95b9ac..249981b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -756,6 +756,30 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 	return 0;
 }
 
+void x86_configure_nx(void)
+{
+	if (boot_cpu_has(X86_FEATURE_NX))
+		__supported_pte_mask |= _PAGE_NX;
+	else
+		__supported_pte_mask &= ~_PAGE_NX;
+}
+
+static void __init x86_report_nx(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_NX)) {
+		printk(KERN_NOTICE "Notice: NX (Execute Disable) protection "
+		       "missing in CPU!\n");
+	} else {
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
+		printk(KERN_INFO "NX (Execute Disable) protection: active\n");
+#else
+		/* 32bit non-PAE kernel, NX cannot be used */
+		printk(KERN_NOTICE "Notice: NX (Execute Disable) protection "
+		       "cannot be enabled: non-PAE kernel!\n");
+#endif
+	}
+}
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -896,9 +920,7 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * x86_configure_nx() is called before parse_early_param() to detect
 	 * whether hardware doesn't support NX (so that the early EHCI debug
-	 * console setup can safely call set_fixmap()). It may then be called
-	 * again from within noexec_setup() during parsing early parameters
-	 * to honor the respective command line option.
+	 * console setup can safely call set_fixmap()).
 	 */
 	x86_configure_nx();
 
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index fe3d306..d957dc1 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -20,13 +20,12 @@ CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 endif
 
 obj-y				:=  init.o init_$(BITS).o fault.o ioremap.o extable.o mmap.o \
-				    pgtable.o physaddr.o setup_nx.o tlb.o cpu_entry_area.o maccess.o
+				    pgtable.o physaddr.o tlb.o cpu_entry_area.o maccess.o
 
 obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
 CFLAGS_physaddr.o		:= -fno-stack-protector
-CFLAGS_setup_nx.o		:= -fno-stack-protector
 CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
 
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 96d34eb..d2e484e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -110,7 +110,6 @@ int force_personality32;
 /*
  * noexec32=on|off
  * Control non executable heap for 32bit processes.
- * To control the stack too use noexec=off
  *
  * on	PROT_READ does not imply PROT_EXEC for 32-bit processes (default)
  * off	PROT_READ implies PROT_EXEC
diff --git a/arch/x86/mm/setup_nx.c b/arch/x86/mm/setup_nx.c
deleted file mode 100644
index ed5667f..0000000
--- a/arch/x86/mm/setup_nx.c
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/spinlock.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/pgtable.h>
-
-#include <asm/proto.h>
-#include <asm/cpufeature.h>
-
-static int disable_nx;
-
-/*
- * noexec = on|off
- *
- * Control non-executable mappings for processes.
- *
- * on      Enable
- * off     Disable
- */
-static int __init noexec_setup(char *str)
-{
-	if (!str)
-		return -EINVAL;
-	if (!strncmp(str, "on", 2)) {
-		disable_nx = 0;
-	} else if (!strncmp(str, "off", 3)) {
-		disable_nx = 1;
-	}
-	x86_configure_nx();
-	return 0;
-}
-early_param("noexec", noexec_setup);
-
-void x86_configure_nx(void)
-{
-	if (boot_cpu_has(X86_FEATURE_NX) && !disable_nx)
-		__supported_pte_mask |= _PAGE_NX;
-	else
-		__supported_pte_mask &= ~_PAGE_NX;
-}
-
-void __init x86_report_nx(void)
-{
-	if (!boot_cpu_has(X86_FEATURE_NX)) {
-		printk(KERN_NOTICE "Notice: NX (Execute Disable) protection "
-		       "missing in CPU!\n");
-	} else {
-#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
-		if (disable_nx) {
-			printk(KERN_INFO "NX (Execute Disable) protection: "
-			       "disabled by kernel command line option\n");
-		} else {
-			printk(KERN_INFO "NX (Execute Disable) protection: "
-			       "active\n");
-		}
-#else
-		/* 32bit non-PAE kernel, NX cannot be used */
-		printk(KERN_NOTICE "Notice: NX (Execute Disable) protection "
-		       "cannot be enabled: non-PAE kernel!\n");
-#endif
-	}
-}
