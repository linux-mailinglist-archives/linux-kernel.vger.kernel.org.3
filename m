Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23DF4C39AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiBXX3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiBXX3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:29:37 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BAF1B01A6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645745346; x=1677281346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s8DBedEo1WzI6yMZ91C3qboE0lHTnwhPxaydO9hb9nk=;
  b=hd0I6eBod+HRjl33IGxqFZ5qs2a4BStIduJEwD4L3ovq1GdZ5DV1d+J4
   5Hn9quQqzFQRBucwZ0HigNAsMzE6wReF/sSNEZ+pX0DL/wHz39mk1tOCD
   Zslxn6G/9EVJM9VKCgaY54xKIDH4SDMEpK6Qyj55jo5BizFOOEypgW1dx
   BbIw8ARe5GrQXWg/LA5njl1hTDDIs81HYuPpIvJbOEdLqZ9vNUCn0e6Sp
   CCfm3XkUJKwZiyGY8dKmDgdcq2rLrMiXra4nN7J2ufQfksxAIUwepUz5E
   o+vGKfIoj1ocL3vFvwDBOdNMcmp1XOFB4ROD9NC/8AmsH+cGLQP02WZhD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="235883035"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="235883035"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:29:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="506505991"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2022 15:28:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9C07194; Fri, 25 Feb 2022 01:29:16 +0200 (EET)
Date:   Fri, 25 Feb 2022 02:29:16 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 04/30] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <20220224232916.6rqw6qkyjsgpbdl3@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-5-kirill.shutemov@linux.intel.com>
 <052d7b15-1b3f-490e-fb30-538334b67a0a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052d7b15-1b3f-490e-fb30-538334b67a0a@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:01:42AM -0800, Dave Hansen wrote:
> On 2/24/22 07:56, Kirill A. Shutemov wrote:
> > +	tdcall
> > +
> > +	/*
> > +	 * TDVMCALL leaf does not suppose to fail. If it fails something
> > +	 * is horribly wrong with TDX module. Stop the world.
> > +	 */
> > +	testq %rax, %rax
> > +	jne .Lpanic
> 
> This should be:
> 
> 	"A TDVMCALL is not supposed to fail."
> 
> I also wish this was mentioning something about the difference between a
> failure and return code.
> 
> 	/*
> 	 * %rax==0 indicates a failure of the TDVMCALL mechanism itself
> 	 * and that something has gone horribly wrong with the TDX
> 	 * module.
> 	 *
> 	 * The return status of the hypercall operation is separate
> 	 * (in %r10).  Hypercall errors are a part of normal operation
> 	 * and are handled by callers.
> 	 */
> 
> I've been confused by this exact thing multiple times over the months
> that I've been looking at this code.  I think it deserves a good comment.

Sure. The updated patch is below.

From 3952126750fe5bd8ef94015e036292f48883e369 Mon Sep 17 00:00:00 2001
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Sun, 21 Feb 2021 22:24:44 -0800
Subject: [PATCH] x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper
 functions

Guests communicate with VMMs with hypercalls. Historically, these
are implemented using instructions that are known to cause VMEXITs
like VMCALL, VMLAUNCH, etc. However, with TDX, VMEXITs no longer
expose the guest state to the host. This prevents the old hypercall
mechanisms from working. So, to communicate with VMM, TDX
specification defines a new instruction called TDCALL.

In a TDX based VM, since the VMM is an untrusted entity, an intermediary
layer -- TDX module -- facilitates secure communication between the host
and the guest. TDX module is loaded like a firmware into a special CPU
mode called SEAM. TDX guests communicate with the TDX module using the
TDCALL instruction.

A guest uses TDCALL to communicate with both the TDX module and VMM.
The value of the RAX register when executing the TDCALL instruction is
used to determine the TDCALL type. A variant of TDCALL used to communicate
with the VMM is called TDVMCALL.

Add generic interfaces to communicate with the TDX module and VMM
(using the TDCALL instruction).

__tdx_hypercall()    - Used by the guest to request services from the
		       VMM (via TDVMCALL).
__tdx_module_call()  - Used to communicate with the TDX module (via
		       TDCALL).

Also define an additional wrapper _tdx_hypercall(), which adds error
handling support for the TDCALL failure.

The __tdx_module_call() and __tdx_hypercall() helper functions are
implemented in assembly in a .S file.  The TDCALL ABI requires
shuffling arguments in and out of registers, which proved to be
awkward with inline assembly.

Just like syscalls, not all TDVMCALL use cases need to use the same
number of argument registers. The implementation here picks the current
worst-case scenario for TDCALL (4 registers). For TDCALLs with fewer
than 4 arguments, there will end up being a few superfluous (cheap)
instructions. But, this approach maximizes code reuse.

For registers used by the TDCALL instruction, please check TDX GHCI
specification, the section titled "TDCALL instruction" and "TDG.VP.VMCALL
Interface".

Based on previous patch by Sean Christopherson.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/Makefile        |   2 +-
 arch/x86/coco/tdcall.S        | 188 ++++++++++++++++++++++++++++++++++
 arch/x86/coco/tdx.c           |  18 ++++
 arch/x86/include/asm/tdx.h    |  27 +++++
 arch/x86/kernel/asm-offsets.c |  10 ++
 5 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/coco/tdcall.S

diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
index 32f4c6e6f199..14af5412e3cd 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -5,4 +5,4 @@ CFLAGS_core.o		+= -fno-stack-protector
 
 obj-y += core.o
 
-obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o tdcall.o
diff --git a/arch/x86/coco/tdcall.S b/arch/x86/coco/tdcall.S
new file mode 100644
index 000000000000..4767e0b5f0d9
--- /dev/null
+++ b/arch/x86/coco/tdcall.S
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asm-offsets.h>
+#include <asm/asm.h>
+#include <asm/frame.h>
+#include <asm/unwind_hints.h>
+
+#include <linux/linkage.h>
+#include <linux/bits.h>
+#include <linux/errno.h>
+
+#include "../virt/tdxcall.S"
+
+/*
+ * Bitmasks of exposed registers (with VMM).
+ */
+#define TDX_R10		BIT(10)
+#define TDX_R11		BIT(11)
+#define TDX_R12		BIT(12)
+#define TDX_R13		BIT(13)
+#define TDX_R14		BIT(14)
+#define TDX_R15		BIT(15)
+
+/*
+ * These registers are clobbered to hold arguments for each
+ * TDVMCALL. They are safe to expose to the VMM.
+ * Each bit in this mask represents a register ID. Bit field
+ * details can be found in TDX GHCI specification, section
+ * titled "TDCALL [TDG.VP.VMCALL] leaf".
+ */
+#define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
+					  TDX_R12 | TDX_R13 | \
+					  TDX_R14 | TDX_R15 )
+
+/*
+ * __tdx_module_call()  - Used by TDX guests to request services from
+ * the TDX module (does not include VMM services).
+ *
+ * Transforms function call register arguments into the TDCALL
+ * register ABI.  After TDCALL operation, TDX module output is saved
+ * in @out (if it is provided by the user)
+ *
+ *-------------------------------------------------------------------------
+ * TDCALL ABI:
+ *-------------------------------------------------------------------------
+ * Input Registers:
+ *
+ * RAX                 - TDCALL Leaf number.
+ * RCX,RDX,R8-R9       - TDCALL Leaf specific input registers.
+ *
+ * Output Registers:
+ *
+ * RAX                 - TDCALL instruction error code.
+ * RCX,RDX,R8-R11      - TDCALL Leaf specific output registers.
+ *
+ *-------------------------------------------------------------------------
+ *
+ * __tdx_module_call() function ABI:
+ *
+ * @fn  (RDI)          - TDCALL Leaf ID,    moved to RAX
+ * @rcx (RSI)          - Input parameter 1, moved to RCX
+ * @rdx (RDX)          - Input parameter 2, moved to RDX
+ * @r8  (RCX)          - Input parameter 3, moved to R8
+ * @r9  (R8)           - Input parameter 4, moved to R9
+ *
+ * @out (R9)           - struct tdx_module_output pointer
+ *                       stored temporarily in R12 (not
+ *                       shared with the TDX module). It
+ *                       can be NULL.
+ *
+ * Return status of TDCALL via RAX.
+ */
+SYM_FUNC_START(__tdx_module_call)
+	FRAME_BEGIN
+	TDX_MODULE_CALL host=0
+	FRAME_END
+	ret
+SYM_FUNC_END(__tdx_module_call)
+
+/*
+ * __tdx_hypercall() - Make hypercalls to a TDX VMM.
+ *
+ * Transforms values in  function call argument struct tdx_hypercall_args @args
+ * into the TDCALL register ABI. After TDCALL operation, VMM output is saved
+ * back in @args.
+ *
+ *-------------------------------------------------------------------------
+ * TD VMCALL ABI:
+ *-------------------------------------------------------------------------
+ *
+ * Input Registers:
+ *
+ * RAX                 - TDCALL instruction leaf number (0 - TDG.VP.VMCALL)
+ * RCX                 - BITMAP which controls which part of TD Guest GPR
+ *                       is passed as-is to the VMM and back.
+ * R10                 - Set 0 to indicate TDCALL follows standard TDX ABI
+ *                       specification. Non zero value indicates vendor
+ *                       specific ABI.
+ * R11                 - VMCALL sub function number
+ * RBX, RBP, RDI, RSI  - Used to pass VMCALL sub function specific arguments.
+ * R8-R9, R12-R15      - Same as above.
+ *
+ * Output Registers:
+ *
+ * RAX                 - TDCALL instruction status (Not related to hypercall
+ *                        output).
+ * R10                 - Hypercall output error code.
+ * R11-R15             - Hypercall sub function specific output values.
+ *
+ *-------------------------------------------------------------------------
+ *
+ * __tdx_hypercall() function ABI:
+ *
+ * @args  (RDI)        - struct tdx_hypercall_args for input and output
+ * @flags (RSI)        - TDX_HCALL_* flags
+ *
+ * On successful completion, return the hypercall error code.
+ */
+SYM_FUNC_START(__tdx_hypercall)
+	FRAME_BEGIN
+
+	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/* Mangle function call ABI into TDCALL ABI: */
+	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
+	xor %eax, %eax
+
+	/* Copy hypercall registers from arg struct: */
+	movq TDX_HYPERCALL_r10(%rdi), %r10
+	movq TDX_HYPERCALL_r11(%rdi), %r11
+	movq TDX_HYPERCALL_r12(%rdi), %r12
+	movq TDX_HYPERCALL_r13(%rdi), %r13
+	movq TDX_HYPERCALL_r14(%rdi), %r14
+	movq TDX_HYPERCALL_r15(%rdi), %r15
+
+	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
+
+	tdcall
+
+	/*
+	 * RAX==0 indicates a failure of the TDVMCALL mechanism itself and that
+	 * something has gone horribly wrong with the TDX module.
+	 *
+	 * The return status of the hypercall operation is in a separate
+	 * register (in R10). Hypercall errors are a part of normal operation
+	 * and are handled by callers.
+	 */
+	testq %rax, %rax
+	jne .Lpanic
+
+	/* TDVMCALL leaf return code is in R10 */
+	movq %r10, %rax
+
+	/* Copy hypercall result registers to arg struct if needed */
+	testq $TDX_HCALL_HAS_OUTPUT, %rsi
+	jz .Lout
+
+	movq %r10, TDX_HYPERCALL_r10(%rdi)
+	movq %r11, TDX_HYPERCALL_r11(%rdi)
+	movq %r12, TDX_HYPERCALL_r12(%rdi)
+	movq %r13, TDX_HYPERCALL_r13(%rdi)
+	movq %r14, TDX_HYPERCALL_r14(%rdi)
+	movq %r15, TDX_HYPERCALL_r15(%rdi)
+.Lout:
+	/*
+	 * Zero out registers exposed to the VMM to avoid speculative execution
+	 * with VMM-controlled values. This needs to include all registers
+	 * present in TDVMCALL_EXPOSE_REGS_MASK (except R12-R15). R12-R15
+	 * context will be restored.
+	 */
+	xor %r10d, %r10d
+	xor %r11d, %r11d
+
+	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
+	pop %r12
+	pop %r13
+	pop %r14
+	pop %r15
+
+	FRAME_END
+
+	retq
+.Lpanic:
+	ud2
+SYM_FUNC_END(__tdx_hypercall)
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 00898e3eb77f..17365fd40ba2 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -7,6 +7,24 @@
 #include <linux/cpufeature.h>
 #include <asm/tdx.h>
 
+/*
+ * Wrapper for standard use of __tdx_hypercall with no output aside from
+ * return code.
+ */
+static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = fn,
+		.r12 = r12,
+		.r13 = r13,
+		.r14 = r14,
+		.r15 = r15,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
+
 void __init tdx_early_init(void)
 {
 	u32 eax, sig[3];
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e59c7960cc0d..d2a7e4ef4c1f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -3,11 +3,16 @@
 #ifndef _ASM_X86_TDX_H
 #define _ASM_X86_TDX_H
 
+#include <linux/bits.h>
 #include <linux/init.h>
 
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+#define TDX_HYPERCALL_STANDARD  0
+
+#define TDX_HCALL_HAS_OUTPUT	BIT(0)
+
 /*
  * SW-defined error codes.
  *
@@ -33,10 +38,32 @@ struct tdx_module_output {
 	u64 r11;
 };
 
+/*
+ * Used in __tdx_hypercall() to pass down and get back registers' values of
+ * the TDCALL instruction when requesting services from the VMM.
+ *
+ * This is a software only structure and not part of the TDX module/VMM ABI.
+ */
+struct tdx_hypercall_args {
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 void __init tdx_early_init(void);
 
+/* Used to communicate with the TDX module */
+u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+		      struct tdx_module_output *out);
+
+/* Used to request services from the VMM */
+u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 7dca52f5cfc6..0b465e7d0a2f 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -74,6 +74,16 @@ static void __used common(void)
 	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
 	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+	BLANK();
+	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
+	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
+	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
+	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
+	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
+	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
+#endif
+
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
 	OFFSET(BP_secure_boot, boot_params, secure_boot);
-- 
 Kirill A. Shutemov
