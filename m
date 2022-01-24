Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27F74982D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbiAXPCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:02:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:63896 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239183AbiAXPCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036541; x=1674572541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Be7yIAQHIpAuRjuHid+cUNvWzrmqEPVws+GfaHNYB9Q=;
  b=FvhkOMUrfpbdg6ChrMYXWZLVmqc+K/dMEcCtHPddqg+GpzJVyhmmjLot
   9wS/aNHJjPL9YEX+52MVYbbrb7zXCTtR3s5zzWQhisqLq0Y9zThdfO7hV
   GkZ0zniQd86FYZIvjGfUqzys9AMbjIl5C2k8RVP8VB0NEtva0I30HjpS3
   mf7OuQPnztr1LFtbVu4D/hoVNzgVZm0jk68U3nfzbbNcEzWyu71mLuSHZ
   c4SbLugn07J9MzUUxmnj/myxreDtTbFjLtMZDAKH+aEazYLSWngomI7SE
   FsU5sl9cLbZPm6dAJYp9LfZokhYcoET0rIaJ/MhphY2vhAKrJKLqGgvSW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226734623"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226734623"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476743202"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2022 07:02:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6A1873CC; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions
Date:   Mon, 24 Jan 2022 18:01:49 +0300
Message-Id: <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/x86/include/asm/tdx.h    |  40 +++++
 arch/x86/kernel/Makefile      |   2 +-
 arch/x86/kernel/asm-offsets.c |  20 +++
 arch/x86/kernel/tdcall.S      | 269 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c         |  23 +++
 5 files changed, 353 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/tdcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e375a950a033..5107a4d9ba8f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,11 +8,51 @@
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+#define TDX_HYPERCALL_STANDARD  0
+
+/*
+ * Used in __tdx_module_call() to gather the output registers'
+ * values of the TDCALL instruction when requesting services from
+ * the TDX module. This is a software only structure and not part
+ * of the TDX module/VMM ABI
+ */
+struct tdx_module_output {
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+};
+
+/*
+ * Used in __tdx_hypercall() to gather the output registers' values
+ * of the TDCALL instruction when requesting services from the VMM.
+ * This is a software only structure and not part of the TDX
+ * module/VMM ABI.
+ */
+struct tdx_hypercall_output {
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
 bool is_tdx_guest(void);
 
+/* Used to communicate with the TDX module */
+u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+		      struct tdx_module_output *out);
+
+/* Used to request services from the VMM */
+u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
+		    u64 r15, struct tdx_hypercall_output *out);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 67415037c33c..ce3e044f7f12 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -133,7 +133,7 @@ obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
 
 obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
-obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdcall.o tdx.o
 
 obj-$(CONFIG_EISA)		+= eisa.o
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 9fb0a2f8b62a..8a3c6b34be7d 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -18,6 +18,7 @@
 #include <asm/bootparam.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_XEN
 #include <xen/interface/xen.h>
@@ -65,6 +66,25 @@ static void __used common(void)
 	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+	BLANK();
+	/* Offset for fields in tdx_module_output */
+	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
+	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
+	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+
+	/* Offset for fields in tdx_hypercall_output */
+	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_output, r10);
+	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_output, r11);
+	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_output, r12);
+	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_output, r13);
+	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_output, r14);
+	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_output, r15);
+#endif
+
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
 	OFFSET(BP_secure_boot, boot_params, secure_boot);
diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
new file mode 100644
index 000000000000..46a49a96cf6c
--- /dev/null
+++ b/arch/x86/kernel/tdcall.S
@@ -0,0 +1,269 @@
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
+/* Frame offset + 8 (for arg1) */
+#define ARG7_SP_OFFSET		(FRAME_OFFSET + 0x08)
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
+ * TDX guests use the TDCALL instruction to make requests to the
+ * TDX module and hypercalls to the VMM. It is supported in
+ * Binutils >= 2.36.
+ */
+#define tdcall .byte 0x66,0x0f,0x01,0xcc
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
+
+	/*
+	 * R12 will be used as temporary storage for
+	 * struct tdx_module_output pointer. Since R12-R15
+	 * registers are not used by TDCALL services supported
+	 * by this function, it can be reused.
+	 */
+
+	/* Callee saved, so preserve it */
+	push %r12
+
+	/*
+	 * Push output pointer to stack.
+	 * After the TDCALL operation, it will be fetched
+	 * into R12 register.
+	 */
+	push %r9
+
+	/* Mangle function call ABI into TDCALL ABI: */
+	/* Move TDCALL Leaf ID to RAX */
+	mov %rdi, %rax
+	/* Move input 4 to R9 */
+	mov %r8,  %r9
+	/* Move input 3 to R8 */
+	mov %rcx, %r8
+	/* Move input 1 to RCX */
+	mov %rsi, %rcx
+	/* Leave input param 2 in RDX */
+
+	tdcall
+
+	/*
+	 * Fetch output pointer from stack to R12 (It is used
+	 * as temporary storage)
+	 */
+	pop %r12
+
+	/* Check for TDCALL success: 0 - Successful, otherwise failed */
+	test %rax, %rax
+	jnz .Lno_output_struct
+
+	/*
+	 * Since this function can be initiated without an output pointer,
+	 * check if caller provided an output struct before storing
+	 * output registers.
+	 */
+	test %r12, %r12
+	jz .Lno_output_struct
+
+	/* Copy TDCALL result registers to output struct: */
+	movq %rcx, TDX_MODULE_rcx(%r12)
+	movq %rdx, TDX_MODULE_rdx(%r12)
+	movq %r8,  TDX_MODULE_r8(%r12)
+	movq %r9,  TDX_MODULE_r9(%r12)
+	movq %r10, TDX_MODULE_r10(%r12)
+	movq %r11, TDX_MODULE_r11(%r12)
+
+.Lno_output_struct:
+	/* Restore the state of R12 register */
+	pop %r12
+
+	FRAME_END
+	ret
+SYM_FUNC_END(__tdx_module_call)
+
+/*
+ * __tdx_hypercall() - Make hypercalls to a TDX VMM.
+ *
+ * Transforms function call register arguments into the TDCALL
+ * register ABI.  After TDCALL operation, VMM output is saved in @out.
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
+ * @type  (RDI)        - TD VMCALL type, moved to R10
+ * @fn    (RSI)        - TD VMCALL sub function, moved to R11
+ * @r12   (RDX)        - Input parameter 1, moved to R12
+ * @r13   (RCX)        - Input parameter 2, moved to R13
+ * @r14   (R8)         - Input parameter 3, moved to R14
+ * @r15   (R9)         - Input parameter 4, moved to R15
+ *
+ * @out   (stack)      - struct tdx_hypercall_output pointer (cannot be NULL)
+ *
+ * On successful completion, return TDCALL status or -EINVAL for invalid
+ * inputs.
+ */
+SYM_FUNC_START(__tdx_hypercall)
+	FRAME_BEGIN
+
+	/* Move argument 7 from caller stack to RAX */
+	movq ARG7_SP_OFFSET(%rsp), %rax
+
+	/* Check if caller provided an output struct */
+	test %rax, %rax
+	/* If out pointer is NULL, return -EINVAL */
+	jz .Lret_err
+
+	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/*
+	 * Save output pointer (rax) on the stack, it will be used again
+	 * when storing the output registers after the TDCALL operation.
+	 */
+	push %rax
+
+	/* Mangle function call ABI into TDCALL ABI: */
+	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
+	xor %eax, %eax
+	/* Move TDVMCALL type (standard vs vendor) in R10 */
+	mov %rdi, %r10
+	/* Move TDVMCALL sub function id to R11 */
+	mov %rsi, %r11
+	/* Move input 1 to R12 */
+	mov %rdx, %r12
+	/* Move input 2 to R13 */
+	mov %rcx, %r13
+	/* Move input 3 to R14 */
+	mov %r8,  %r14
+	/* Move input 4 to R15 */
+	mov %r9,  %r15
+
+	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
+
+	tdcall
+
+	/* Restore output pointer to R9 */
+	pop  %r9
+
+	/* Copy hypercall result registers to output struct: */
+	movq %r10, TDX_HYPERCALL_r10(%r9)
+	movq %r11, TDX_HYPERCALL_r11(%r9)
+	movq %r12, TDX_HYPERCALL_r12(%r9)
+	movq %r13, TDX_HYPERCALL_r13(%r9)
+	movq %r14, TDX_HYPERCALL_r14(%r9)
+	movq %r15, TDX_HYPERCALL_r15(%r9)
+
+	/*
+	 * Zero out registers exposed to the VMM to avoid
+	 * speculative execution with VMM-controlled values.
+	 * This needs to include all registers present in
+	 * TDVMCALL_EXPOSE_REGS_MASK (except R12-R15).
+	 * R12-R15 context will be restored.
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
+	jmp .Lhcall_done
+.Lret_err:
+       movq $-EINVAL, %rax
+.Lhcall_done:
+       FRAME_END
+
+       retq
+SYM_FUNC_END(__tdx_hypercall)
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 1ef6979a6434..d40b6df51e26 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -9,6 +9,29 @@
 
 static bool tdx_guest_detected __ro_after_init;
 
+/*
+ * Wrapper for standard use of __tdx_hypercall with panic report
+ * for TDCALL error.
+ */
+static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
+				 u64 r15, struct tdx_hypercall_output *out)
+{
+	struct tdx_hypercall_output dummy_out;
+	u64 err;
+
+	/* __tdx_hypercall() does not accept NULL output pointer */
+	if (!out)
+		out = &dummy_out;
+
+	/* Non zero return value indicates buggy TDX module, so panic */
+	err = __tdx_hypercall(TDX_HYPERCALL_STANDARD, fn, r12, r13, r14,
+			      r15, out);
+	if (err)
+		panic("Hypercall fn %llu failed (Buggy TDX module!)\n", fn);
+
+	return out->r10;
+}
+
 bool is_tdx_guest(void)
 {
 	return tdx_guest_detected;
-- 
2.34.1

