Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4069F507DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358592AbiDTApt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbiDTApm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:45:42 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACC717A93;
        Tue, 19 Apr 2022 17:42:57 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 533441BF205;
        Wed, 20 Apr 2022 00:42:49 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 01/11] x86: kernel FineIBT
Date:   Tue, 19 Apr 2022 17:42:31 -0700
Message-Id: <20220420004241.2093-2-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Moreira <joao@overdrivepizza.com>

Make kernel code compatible to be compiled with FineIBT.
- Set FineIBT defines.
- Mark functions reached from assembly as coarse-grained.
- Add FineIBT handler function, which is invoked on policy violations.

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
---
 arch/x86/entry/entry_64.S            |   1 +
 arch/x86/include/asm/ibt.h           |  16 ++++
 arch/x86/include/asm/setup.h         |  12 +--
 arch/x86/include/asm/special_insns.h |   4 +-
 arch/x86/kernel/cpu/common.c         |   2 +-
 arch/x86/kernel/fineibt.c            | 123 +++++++++++++++++++++++++++
 arch/x86/kernel/head64.c             |  12 +--
 arch/x86/kernel/smpboot.c            |   2 +-
 8 files changed, 156 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/kernel/fineibt.c

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4faac48ebec5..901b702fb16d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -295,6 +295,7 @@ SYM_CODE_START(ret_from_fork)
 	/* kernel thread */
 	UNWIND_HINT_EMPTY
 	movq	%r12, %rdi
+	FINEIBT_HASH(0x89f22991)
 	CALL_NOSPEC rbx
 	/*
 	 * A kernel thread is allowed to return here after successfully
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 689880eca9ba..580aa8b83bb2 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -21,6 +21,16 @@
 
 #define HAS_KERNEL_IBT	1
 
+#if defined(CONFIG_X86_KERNEL_FINEIBT) && !defined(BUILD_VDSO) && !defined(BUILD_VDSO32_64)
+#define HAS_KERNEL_FINEIBT  1
+#define FINEIBT_HASH(hash) mov $hash, %r11d
+#define __coarseendbr __attribute__((coarsecf_check))
+#else
+#define HAS_KERNEL_FINEIBT  0
+#define FINEIBT_HASH(hash)
+#define __coarseendbr
+#endif
+
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_X86_64
@@ -29,6 +39,7 @@
 #define ASM_ENDBR	"endbr32\n\t"
 #endif
 
+#undef __noendbr
 #define __noendbr	__attribute__((nocf_check))
 
 static inline __attribute_const__ u32 gen_endbr(void)
@@ -80,12 +91,17 @@ extern __noendbr void ibt_restore(u64 save);
 #else /* !IBT */
 
 #define HAS_KERNEL_IBT	0
+#define HAS_KERNEL_FINEIBT 0
+#define FINEIBT_HASH(hash)
 
 #ifndef __ASSEMBLY__
 
 #define ASM_ENDBR
 
+#undef __noendbr
 #define __noendbr
+#undef __coarseendbr
+#define __coarseendbr
 
 static inline bool is_endbr(u32 val) { return false; }
 
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 896e48d45828..d2a2f6456403 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -49,10 +49,10 @@ extern unsigned long saved_video_mode;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
-extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
-extern unsigned long __startup_secondary_64(void);
-extern void startup_64_setup_env(unsigned long physbase);
-extern void early_setup_idt(void);
+extern unsigned long __coarseendbr __startup_64(unsigned long physaddr, struct boot_params *bp);
+extern unsigned long __coarseendbr __startup_secondary_64(void);
+extern void __coarseendbr startup_64_setup_env(unsigned long physbase);
+extern void __coarseendbr early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
 #ifdef CONFIG_X86_INTEL_MID
@@ -137,8 +137,8 @@ extern void probe_roms(void);
 asmlinkage void __init i386_start_kernel(void);
 
 #else
-asmlinkage void __init x86_64_start_kernel(char *real_mode);
-asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
+asmlinkage void __init __coarseendbr x86_64_start_kernel(char *real_mode);
+asmlinkage void __init __coarseendbr x86_64_start_reservations(char *real_mode_data);
 
 #endif /* __i386__ */
 #endif /* _SETUP */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 68c257a3de0d..7f32ef8d23f0 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -49,7 +49,7 @@ static inline unsigned long __native_read_cr3(void)
 	return val;
 }
 
-static inline void native_write_cr3(unsigned long val)
+static inline void __coarseendbr native_write_cr3(unsigned long val)
 {
 	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
@@ -74,7 +74,7 @@ static inline unsigned long native_read_cr4(void)
 	return val;
 }
 
-void native_write_cr4(unsigned long val);
+void __coarseendbr native_write_cr4(unsigned long val);
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 static inline u32 rdpkru(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ed4417500700..70e94194ee2b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -463,7 +463,7 @@ void native_write_cr0(unsigned long val)
 }
 EXPORT_SYMBOL(native_write_cr0);
 
-void __no_profile native_write_cr4(unsigned long val)
+void __no_profile __coarseendbr native_write_cr4(unsigned long val)
 {
 	unsigned long bits_changed = 0;
 
diff --git a/arch/x86/kernel/fineibt.c b/arch/x86/kernel/fineibt.c
new file mode 100644
index 000000000000..685e4308d86e
--- /dev/null
+++ b/arch/x86/kernel/fineibt.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains the FineIBT handler function.
+ */
+
+#include <linux/export.h>
+#include <linux/printk.h>
+#include <linux/kernel.h>
+#include<linux/spinlock.h>
+#include <asm/ibt.h>
+
+void __noendbr __fineibt_handler(void);
+
+void __fineibt_debug(void) {
+	asm volatile ("nop\n");
+	printk("fineibt debug\n");
+};
+EXPORT_SYMBOL(__fineibt_debug);
+
+#define FINEIBT_VADDR_LEN 4096
+#define DO_ALL_PUSHS    \
+	asm("nop\n\t"         \
+	    "push %rsi\n\t"   \
+	    "push %rdi\n\t"   \
+	    "push %rdx\n\t"   \
+	    "push %rcx\n\t"   \
+	    "push %rbx\n\t"   \
+	    "push %rax\n\t"   \
+	    "push %r8\n\t"    \
+	    "push %r9\n\t"    \
+	    "push %r10\n\t"   \
+	    "push %r11\n\t"   \
+	    "push %r12\n\t"   \
+	    "push %r13\n\t"   \
+	    "push %r14\n\t"   \
+	    "push %r15\n\t")
+
+#define DO_ALL_POPS    \
+	asm("nop\n\t"        \
+	    "pop %r15\n\t"   \
+	    "pop %r14\n\t"   \
+	    "pop %r13\n\t"   \
+	    "pop %r12\n\t"   \
+	    "pop %r11\n\t"   \
+	    "pop %r10\n\t"   \
+	    "pop %r9\n\t"    \
+	    "pop %r8\n\t"    \
+	    "pop %rax\n\t"   \
+	    "pop %rbx\n\t"   \
+	    "pop %rcx\n\t"   \
+	    "pop %rdx\n\t"   \
+	    "pop %rdi\n\t"   \
+	    "pop %rsi\n\t")
+
+struct fineibt_violation{
+	void * vaddr;
+	void * caddr;
+	bool printed;
+};
+
+typedef struct fineibt_violation fineibt_violation;
+
+static fineibt_violation vlts[FINEIBT_VADDR_LEN];
+static unsigned long vlts_next = 0;
+static bool vlts_initialize = true;
+static DEFINE_SPINLOCK(fineibt_lock);
+
+void __noendbr __fineibt_handler(void){
+	unsigned i;
+	unsigned long flags;
+	bool skip;
+	void * ret;
+	void * caller;
+
+	DO_ALL_PUSHS;
+
+	spin_lock_irqsave(&fineibt_lock, flags);
+	skip = false;
+
+	asm("\t movq 0x90(%%rsp),%0" : "=r"(ret));
+	asm("\t movq 0x98(%%rsp),%0" : "=r"(caller));
+
+	if(vlts_initialize){
+		for(i = 0; i < FINEIBT_VADDR_LEN; i++) {
+			vlts[i].vaddr = 0;
+			vlts[i].caddr = 0;
+			vlts[i].printed = 0;
+		}
+		vlts_initialize = false;
+	}
+
+	if(vlts_next >= FINEIBT_VADDR_LEN) {
+		if(vlts_next == FINEIBT_VADDR_LEN) {
+			printk("FineIBT reached max buffer\n");
+			vlts_next++;
+		}
+		skip = true;
+	}
+
+	for(i = 0; i < vlts_next; i++){
+		if(vlts[i].vaddr == ret && vlts[i].caddr == caller) {
+			skip = true;
+			break;
+		}
+	}
+
+	if(!skip) {
+		vlts[vlts_next].vaddr = ret;
+		vlts[vlts_next].caddr = caller;
+		vlts[vlts_next].printed = 0;
+		vlts_next = vlts_next + 1;
+	}
+
+	spin_unlock_irqrestore(&fineibt_lock, flags);
+
+	if(!skip) {
+		printk("FineIBT violation: %px:%px:%u\n", ret, caller,
+				vlts_next);
+	}
+	DO_ALL_POPS;
+}
+
+EXPORT_SYMBOL(__fineibt_handler);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4f5ecbbaae77..f773d771e07d 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -162,7 +162,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
  * boot-time crashes. To work around this problem, every global pointer must
  * be adjusted using fixup_pointer().
  */
-unsigned long __head __startup_64(unsigned long physaddr,
+unsigned long __head __coarseendbr __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
 	unsigned long load_delta, *p;
@@ -308,7 +308,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	return sme_postprocess_startup(bp, pmd);
 }
 
-unsigned long __startup_secondary_64(void)
+unsigned long __coarseendbr __startup_secondary_64(void)
 {
 	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
@@ -464,8 +464,8 @@ static void __init copy_bootdata(char *real_mode_data)
 	sme_unmap_bootdata(real_mode_data);
 }
 
-asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
-{
+asmlinkage __visible void __init __coarseendbr
+x86_64_start_kernel(char * real_mode_data) {
 	/*
 	 * Build-time sanity checks on the kernel image and module
 	 * area mappings. (these are purely build-time and produce no code)
@@ -597,7 +597,7 @@ static void startup_64_load_idt(unsigned long physbase)
 }
 
 /* This is used when running on kernel addresses */
-void early_setup_idt(void)
+void __coarseendbr early_setup_idt(void)
 {
 	/* VMM Communication Exception */
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
@@ -610,7 +610,7 @@ void early_setup_idt(void)
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __head __coarseendbr startup_64_setup_env(unsigned long physbase)
 {
 	/* Load GDT */
 	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 2ef14772dc04..5fa17d5716bb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -214,7 +214,7 @@ static int enable_start_cpu0;
 /*
  * Activate a secondary processor.
  */
-static void notrace start_secondary(void *unused)
+static void notrace __coarseendbr start_secondary(void *unused)
 {
 	/*
 	 * Don't put *anything* except direct CPU state initialization
-- 
2.35.1

