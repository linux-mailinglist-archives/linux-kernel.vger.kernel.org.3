Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A142D4FA137
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiDIBbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiDIBa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4263911BE6C;
        Fri,  8 Apr 2022 18:27:45 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XPyJAz5Yw0z3xA72HV5UuxdUQxaUlkm1+mdUDY7MvM=;
        b=D6kZae/sXhGln2e19jG+cs+JwO5qWWVbCN8mhFKmQd5JRc526qLchEfz5jUw+Om8ak2JEE
        3NhfI0kpYbRkaXgE0kGaFj2ylR3J7lM7uWeqN5N+4pWD4cRQXtza2pvB9wEfpV0prNlScW
        RiNN++9JgRz6EvonicZcBl2iO3TLHI3GnZP5vkhrJfigXW8yPqH9vMHsk1zSZnXF/FAI12
        txNVTj13jtEnXZ3Udr6Xu7xDbN1f9LjWMnxyqAnh1Sks5yuSuD2LLSaT12s15M6R3jU5Ab
        eLsvXZmbCj+7oeNQDyQG6EuUIcmI/u5P1lbKVQ10cEAeBcrJz0mFTiUcG/8tfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XPyJAz5Yw0z3xA72HV5UuxdUQxaUlkm1+mdUDY7MvM=;
        b=JnF10r0jp15Y70g7fzchMjw6OD3XbugUvXSKdSpCEVEWF98An7uKa+jfgyEpe8kK8rXOtB
        BGF+hhycN4mzptDw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Provide common base for SEAMCALL and TDCALL C
 wrappers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-3-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946766280.4207.15998649771822894901.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     527a534c732604931959e73e9c3a8952d8c1a994
Gitweb:        https://git.kernel.org/tip/527a534c732604931959e73e9c3a8952d8c1a994
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:11 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:50 -07:00

x86/tdx: Provide common base for SEAMCALL and TDCALL C wrappers

Secure Arbitration Mode (SEAM) is an extension of VMX architecture.  It
defines a new VMX root operation (SEAM VMX root) and a new VMX non-root
operation (SEAM VMX non-root) which are both isolated from the legacy
VMX operation where the host kernel runs.

A CPU-attested software module (called 'TDX module') runs in SEAM VMX
root to manage and protect VMs running in SEAM VMX non-root.  SEAM VMX
root is also used to host another CPU-attested software module (called
'P-SEAMLDR') to load and update the TDX module.

Host kernel transits to either P-SEAMLDR or TDX module via the new
SEAMCALL instruction, which is essentially a VMExit from VMX root mode
to SEAM VMX root mode.  SEAMCALLs are leaf functions defined by
P-SEAMLDR and TDX module around the new SEAMCALL instruction.

A guest kernel can also communicate with TDX module via TDCALL
instruction.

TDCALLs and SEAMCALLs use an ABI different from the x86-64 system-v ABI.
RAX is used to carry both the SEAMCALL leaf function number (input) and
the completion status (output).  Additional GPRs (RCX, RDX, R8-R11) may
be further used as both input and output operands in individual leaf.

TDCALL and SEAMCALL share the same ABI and require the largely same
code to pass down arguments and retrieve results.

Define an assembly macro that can be used to implement C wrapper for
both TDCALL and SEAMCALL.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-3-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/tdx.h      | 29 ++++++++++-
 arch/x86/kernel/asm-offsets.c   |  9 +++-
 arch/x86/virt/vmx/tdx/tdxcall.S | 96 ++++++++++++++++++++++++++++++++-
 3 files changed, 134 insertions(+)
 create mode 100644 arch/x86/virt/vmx/tdx/tdxcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ba8042c..cb4c4e6 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -4,10 +4,38 @@
 #define _ASM_X86_TDX_H
 
 #include <linux/init.h>
+#include <linux/bits.h>
 
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+/*
+ * SW-defined error codes.
+ *
+ * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
+ * TDX module.
+ */
+#define TDX_ERROR			_BITUL(63)
+#define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
+#define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Used to gather the output registers values of the TDCALL and SEAMCALL
+ * instructions when requesting services from the TDX module.
+ *
+ * This is a software only structure and not part of the TDX module/VMM ABI.
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
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 void __init tdx_early_init(void);
@@ -18,4 +46,5 @@ static inline void tdx_early_init(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+#endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 9fb0a2f..7dca52f 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -18,6 +18,7 @@
 #include <asm/bootparam.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_XEN
 #include <xen/interface/xen.h>
@@ -66,6 +67,14 @@ static void __used common(void)
 #endif
 
 	BLANK();
+	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
+	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
+	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+
+	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
 	OFFSET(BP_secure_boot, boot_params, secure_boot);
 	OFFSET(BP_loadflags, boot_params, hdr.loadflags);
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
new file mode 100644
index 0000000..49a5435
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asm-offsets.h>
+#include <asm/tdx.h>
+
+/*
+ * TDCALL and SEAMCALL are supported in Binutils >= 2.36.
+ */
+#define tdcall		.byte 0x66,0x0f,0x01,0xcc
+#define seamcall	.byte 0x66,0x0f,0x01,0xcf
+
+/*
+ * TDX_MODULE_CALL - common helper macro for both
+ *                 TDCALL and SEAMCALL instructions.
+ *
+ * TDCALL   - used by TDX guests to make requests to the
+ *            TDX module and hypercalls to the VMM.
+ * SEAMCALL - used by TDX hosts to make requests to the
+ *            TDX module.
+ */
+.macro TDX_MODULE_CALL host:req
+	/*
+	 * R12 will be used as temporary storage for struct tdx_module_output
+	 * pointer. Since R12-R15 registers are not used by TDCALL/SEAMCALL
+	 * services supported by this function, it can be reused.
+	 */
+
+	/* Callee saved, so preserve it */
+	push %r12
+
+	/*
+	 * Push output pointer to stack.
+	 * After the operation, it will be fetched into R12 register.
+	 */
+	push %r9
+
+	/* Mangle function call ABI into TDCALL/SEAMCALL ABI: */
+	/* Move Leaf ID to RAX */
+	mov %rdi, %rax
+	/* Move input 4 to R9 */
+	mov %r8,  %r9
+	/* Move input 3 to R8 */
+	mov %rcx, %r8
+	/* Move input 1 to RCX */
+	mov %rsi, %rcx
+	/* Leave input param 2 in RDX */
+
+	.if \host
+	seamcall
+	/*
+	 * SEAMCALL instruction is essentially a VMExit from VMX root
+	 * mode to SEAM VMX root mode.  VMfailInvalid (CF=1) indicates
+	 * that the targeted SEAM firmware is not loaded or disabled,
+	 * or P-SEAMLDR is busy with another SEAMCALL.  %rax is not
+	 * changed in this case.
+	 *
+	 * Set %rax to TDX_SEAMCALL_VMFAILINVALID for VMfailInvalid.
+	 * This value will never be used as actual SEAMCALL error code as
+	 * it is from the Reserved status code class.
+	 */
+	jnc .Lno_vmfailinvalid
+	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
+.Lno_vmfailinvalid:
+
+	.else
+	tdcall
+	.endif
+
+	/*
+	 * Fetch output pointer from stack to R12 (It is used
+	 * as temporary storage)
+	 */
+	pop %r12
+
+	/*
+	 * Since this macro can be invoked with NULL as an output pointer,
+	 * check if caller provided an output struct before storing output
+	 * registers.
+	 *
+	 * Update output registers, even if the call failed (RAX != 0).
+	 * Other registers may contain details of the failure.
+	 */
+	test %r12, %r12
+	jz .Lno_output_struct
+
+	/* Copy result registers to output struct: */
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
+.endm
