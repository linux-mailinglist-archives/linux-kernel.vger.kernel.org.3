Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33194BBD3E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiBRQRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:17:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiBRQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7E22BCB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201034; x=1676737034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e+EaalFBKesanPpHPz49PfBdxnZtE1tHhoVw3wRarAY=;
  b=Nzq8XJe5JKh30xd80HkHgGUoM4N8os7xrX2DArJVuJ5l7l5XFtuxU6fG
   3SmmFJj9QEdSx3shEAVV+/BKPiHXwSMRl2Cy9Qov1mWWKjZdjbyYAVI2f
   7oE5azTvrOzFbbRcZavq9rMjtr2m9t7oAaJrKPCcScyegeuWhvNTXgx17
   L9/tIYTUH+sFisTJXJDjhH8QWkvJKZKj3JFeAydQIvXiFvHLpBjHgEPhM
   VexWx7M72k4VMm4kVi72xqxv18VFzIuw9+dUtXuyg9wnk1z5sKNYp3SQX
   t4+XKknmj8/VsPmocGLUOVzF9uFmu0aSbtpBn9mexw47TiFaesZgzYGyP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231138280"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231138280"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="572355107"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2022 08:17:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3A6F3822; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 04/32] x86/tdx: Provide common base for SEAMCALL and TDCALL C wrappers
Date:   Fri, 18 Feb 2022 19:16:50 +0300
Message-Id: <20220218161718.67148-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/tdx.h    | 20 ++++++++
 arch/x86/kernel/asm-offsets.c |  9 ++++
 arch/x86/virt/tdxcall.S       | 91 +++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 arch/x86/virt/tdxcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ba8042ce61c2..2f8cb1e53e77 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,6 +8,25 @@
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+#define TDX_SEAMCALL_VMFAILINVALID     0x8000FF00FFFF0000ULL
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
@@ -18,4 +37,5 @@ static inline void tdx_early_init(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+#endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 9fb0a2f8b62a..7dca52f5cfc6 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -18,6 +18,7 @@
 #include <asm/bootparam.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_XEN
 #include <xen/interface/xen.h>
@@ -65,6 +66,14 @@ static void __used common(void)
 	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
 #endif
 
+	BLANK();
+	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
+	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
+	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
 	OFFSET(BP_secure_boot, boot_params, secure_boot);
diff --git a/arch/x86/virt/tdxcall.S b/arch/x86/virt/tdxcall.S
new file mode 100644
index 000000000000..90569faedacc
--- /dev/null
+++ b/arch/x86/virt/tdxcall.S
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asm-offsets.h>
+#include <asm/tdx.h>
+
+/*
+ * TDX guests use the TDCALL instruction to make requests to the
+ * TDX module and hypercalls to the VMM.
+ *
+ * TDX host user SEAMCALL instruction to make requests to TDX module.
+ *
+ * They are supported in Binutils >= 2.36.
+ */
+#define tdcall		.byte 0x66,0x0f,0x01,0xcc
+#define seamcall	.byte 0x66,0x0f,0x01,0xcf
+
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
+	 * This value will never be used as actual SEAMCALL error code.
+	 */
+	jnc .Lno_vmfailinvalid
+	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
+.Lno_vmfailinvalid:
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
+	/* Check for success: 0 - Successful, otherwise failed */
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
-- 
2.34.1

