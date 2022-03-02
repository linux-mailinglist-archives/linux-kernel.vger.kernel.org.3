Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE3E4CA804
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbiCBO3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242919AbiCBO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:28:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2969027CD3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231283; x=1677767283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sga19Mm5EXhxhuTIFBfsx/RQtM2Nj9M4rLT3+qfADcc=;
  b=emQJ+MWzbK7KlL0oLKYZun//hyTYnVcJZztg1E1MlZN/jWmwUn5NfNYq
   ZirYCS8oa4dN0SrnkU9xQMq6Q4fvLM+9pscL1qcm6YV5wtXvcX0sEGb+U
   KKtIcliVCJQri8qkCvyYPwIww3X86eHKhw8nKJ+tXTp77HuNv00JhAR7r
   izjabMMnG6Fbv0pihrqPKNICUJvifCx3Gao0WdFvhLsORk3eIDzE/QxHe
   /XNOcTok3S9NbJtO4y6PDTjWa2IXKPPC7Ka/1Llsjva9FHcI+e/wtnRp0
   rBr6w297hG02IWNG8d2WVnGME/0RBaCr6uc/6e5QmFxP2Q55mJmW/DaIJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233376430"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="233376430"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="641715730"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2022 06:27:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E01951C9; Wed,  2 Mar 2022 16:28:11 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 03/30] x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions
Date:   Wed,  2 Mar 2022 17:27:39 +0300
Message-Id: <20220302142806.51844-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

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
index e5ff8ed59adf..003c4d101297 100644
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
@@ -35,10 +40,32 @@ struct tdx_module_output {
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
2.34.1

