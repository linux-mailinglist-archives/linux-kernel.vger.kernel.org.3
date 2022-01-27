Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA41649E1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbiA0L4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbiA0L4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7774DC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:56:40 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E86141EC059E;
        Thu, 27 Jan 2022 12:56:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643284599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmP+QGjor7GR/9r6ai02b7ZRi5Z42G2ZxxkhGELN/CU=;
        b=YCojKoLGSBxRUWxnWcMSETT5rv0DugvNh6D0sPhX8pr3Y01hkGz1ZsbzLY4qVqCRC+IiyR
        h2Ly/1t2GVsrlXTGdSe7aLN6kfRrLANlzmtUcqW+xmjJ39UGxdFXMVF8kQYvQrSs+Jwszg
        gpyO++VEZDMYGeKPlv8Ik06PY2FxuoE=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH v2 5/6] x86/cpu: Remove "noexec"
Date:   Thu, 27 Jan 2022 12:56:25 +0100
Message-Id: <20220127115626.14179-6-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220127115626.14179-1-bp@alien8.de>
References: <20220127115626.14179-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It doesn't make any sense to disable non-executable mappings -
security-wise or else.

So rip out that switch and move the remaining code into setup.c and
delete setup_nx.c

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 --
 Documentation/x86/x86_64/boot-options.rst     |  9 ---
 arch/x86/include/asm/proto.h                  |  1 -
 arch/x86/kernel/setup.c                       | 28 ++++++++-
 arch/x86/mm/Makefile                          |  3 +-
 arch/x86/mm/init_64.c                         |  1 -
 arch/x86/mm/setup_nx.c                        | 62 -------------------
 7 files changed, 26 insertions(+), 83 deletions(-)
 delete mode 100644 arch/x86/mm/setup_nx.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e3894159c22b..dd398f83b335 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3389,11 +3389,6 @@
 
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
index ccb7e86bf8d9..e72c60210285 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -164,15 +164,6 @@ Rebooting
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
index feed36d44d04..0f899c8d7a4e 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -35,7 +35,6 @@ void xen_entry_INT80_compat(void);
 #endif
 
 void x86_configure_nx(void);
-void x86_report_nx(void);
 
 extern int reboot_force;
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f7a132eb794d..07a395803957 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -740,6 +740,30 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
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
@@ -880,9 +904,7 @@ void __init setup_arch(char **cmdline_p)
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
index fe3d3061fc11..d957dc15b371 100644
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
index 96d34ebb20a9..d2e484efdfa1 100644
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
index ed5667f5169f..000000000000
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
-- 
2.29.2

