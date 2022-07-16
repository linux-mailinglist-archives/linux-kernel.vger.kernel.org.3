Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C90577260
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiGPXSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiGPXRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1767237DE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:33 -0700 (PDT)
Message-ID: <20220716230953.442937066@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ithq52Gx+iixg96k39i55L8lXk6+1urMKhPljXhhy5M=;
        b=RD2ZTbVGxpgYx2xHnJLhKdrR9TpRyheRmkAEzrEOEWkzDB4Ukw+t2vJTuhQO1WwKUXJo4q
        KbcJAeqltspsDr7gDwj64eWufE2h15/ccwSZpKV2wm2mUhh7O/GHjH6RbgTBT8Fwt33EVZ
        qezVc1BUikkMIM85qxt4UFPGfQ6jToBEqdNd+HXHVB6do5kLexhr4qR75u3VUNUqbfZ4df
        29JO3pBgXM3rR+UoT3Yd/B5dD2rr9zcqD0lATCoVzGS1jai9u50OLpwn/AwO0e1tdmFF+5
        Z3C9wBgZWfbuBIVHPdgyaMZLrO2qiICGYEGN+X/Q8RkDMAm/EdYAm89RceiyQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ithq52Gx+iixg96k39i55L8lXk6+1urMKhPljXhhy5M=;
        b=RXE/Y2xi68Iu624evLhKupppsTCt/fYBAR++Lhsf2/IqVwseeEu1DuhI8cqxV+2yeznLln
        yj5jUB0y+f6HtfCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 13/38] x86/modules: Make module_alloc() generally available
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:30 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_alloc() allocates from the module region which is also available
when CONFIG_MODULES=n. Non module builds should be able to allocate from
that region nevertheless e.g. for creating call thunks.

Split the code out and make it possible to select for !MODULES builds.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig           |    3 ++
 arch/x86/kernel/module.c   |   58 ------------------------------------------
 arch/x86/mm/Makefile       |    2 +
 arch/x86/mm/module_alloc.c |   62 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 58 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2236,6 +2236,9 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 
 	  If unsure, leave at the default value.
 
+config MODULE_ALLOC
+	def_bool MODULES
+
 config HOTPLUG_CPU
 	def_bool y
 	depends on SMP
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -8,21 +8,14 @@
 
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
-#include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/kasan.h>
 #include <linux/bug.h>
-#include <linux/mm.h>
-#include <linux/gfp.h>
 #include <linux/jump_label.h>
-#include <linux/random.h>
 #include <linux/memory.h>
 
 #include <asm/text-patching.h>
-#include <asm/page.h>
-#include <asm/setup.h>
 #include <asm/unwind.h>
 
 #if 0
@@ -36,57 +29,6 @@ do {							\
 } while (0)
 #endif
 
-#ifdef CONFIG_RANDOMIZE_BASE
-static unsigned long module_load_offset;
-
-/* Mutex protects the module_load_offset. */
-static DEFINE_MUTEX(module_kaslr_mutex);
-
-static unsigned long int get_module_load_offset(void)
-{
-	if (kaslr_enabled()) {
-		mutex_lock(&module_kaslr_mutex);
-		/*
-		 * Calculate the module_load_offset the first time this
-		 * code is called. Once calculated it stays the same until
-		 * reboot.
-		 */
-		if (module_load_offset == 0)
-			module_load_offset =
-				(get_random_int() % 1024 + 1) * PAGE_SIZE;
-		mutex_unlock(&module_kaslr_mutex);
-	}
-	return module_load_offset;
-}
-#else
-static unsigned long int get_module_load_offset(void)
-{
-	return 0;
-}
-#endif
-
-void *module_alloc(unsigned long size)
-{
-	gfp_t gfp_mask = GFP_KERNEL;
-	void *p;
-
-	if (PAGE_ALIGN(size) > MODULES_LEN)
-		return NULL;
-
-	p = __vmalloc_node_range(size, MODULE_ALIGN,
-				 MODULES_VADDR + get_module_load_offset(),
-				 MODULES_END, gfp_mask, PAGE_KERNEL,
-				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
-				 NUMA_NO_NODE, __builtin_return_address(0));
-
-	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
-		vfree(p);
-		return NULL;
-	}
-
-	return p;
-}
-
 #ifdef CONFIG_X86_32
 int apply_relocate(Elf32_Shdr *sechdrs,
 		   const char *strtab,
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -59,3 +59,5 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_enc
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+
+obj-$(CONFIG_MODULE_ALLOC)	+= module_alloc.o
--- /dev/null
+++ b/arch/x86/mm/module_alloc.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kasan.h>
+#include <linux/mm.h>
+#include <linux/moduleloader.h>
+#include <linux/mutex.h>
+#include <linux/random.h>
+#include <linux/vmalloc.h>
+
+#include <asm/setup.h>
+#include <asm/page.h>
+
+#ifdef CONFIG_RANDOMIZE_BASE
+static unsigned long module_load_offset;
+
+/* Mutex protects the module_load_offset. */
+static DEFINE_MUTEX(module_kaslr_mutex);
+
+static unsigned long int get_module_load_offset(void)
+{
+	if (kaslr_enabled()) {
+		mutex_lock(&module_kaslr_mutex);
+		/*
+		 * Calculate the module_load_offset the first time this
+		 * code is called. Once calculated it stays the same until
+		 * reboot.
+		 */
+		if (module_load_offset == 0)
+			module_load_offset =
+				(get_random_int() % 1024 + 1) * PAGE_SIZE;
+		mutex_unlock(&module_kaslr_mutex);
+	}
+	return module_load_offset;
+}
+#else
+static unsigned long int get_module_load_offset(void)
+{
+	return 0;
+}
+#endif
+
+void *module_alloc(unsigned long size)
+{
+	gfp_t gfp_mask = GFP_KERNEL;
+	void *p;
+
+	if (PAGE_ALIGN(size) > MODULES_LEN)
+		return NULL;
+
+	p = __vmalloc_node_range(size, MODULE_ALIGN,
+				 MODULES_VADDR + get_module_load_offset(),
+				 MODULES_END, gfp_mask, PAGE_KERNEL,
+				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
+				 NUMA_NO_NODE, __builtin_return_address(0));
+
+	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
+		vfree(p);
+		return NULL;
+	}
+
+	return p;
+}

