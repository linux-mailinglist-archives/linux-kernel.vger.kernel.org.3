Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2E4CA801
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242924AbiCBO2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbiCBO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:28:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF6228
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231280; x=1677767280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qt8QdDJBofSwwEFGDmw50R0B2vlNiwakGUwUbF8PEPo=;
  b=Z6/DYk4+L+8X5v32QQj8fWOW0O1ulegURlUND0Ubb3pt3Wk/+BJKU41M
   kzYwYRQ5fvACvo0Dh+s7fC0w57DSgXSKzH+6/8jrqzRiZ/qSNNA/RLteU
   fR4k0APkeFm3FKPDL1gkezcSMCqCYXx9+ZNHt1fkDQWDiOw3rilR4fXR8
   DKJFTcqbVNas74gr8eeMjRflROv60tJTFVN5uZiC+bKdhoHNKNJNaU5mI
   SwC9f6eAMmHc2Pix8cUxjA0Ph2TVMpzwzZsgbOu46K3rNldwIYkmTrhKP
   mbkdL0ps843Vw7BgLlZmDJbAjM6M/YDpfPIH2ABdRsh/VS0cyzJgF6L5q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="339840689"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="339840689"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="639791161"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2022 06:27:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D1FC119E; Wed,  2 Mar 2022 16:28:11 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 02/30] x86/tdx: Provide common base for SEAMCALL and TDCALL C wrappers
Date:   Wed,  2 Mar 2022 17:27:38 +0300
Message-Id: <20220302142806.51844-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
 arch/x86/include/asm/tdx.h    | 28 +++++++++++
 arch/x86/kernel/asm-offsets.c |  9 ++++
 arch/x86/virt/tdxcall.S       | 95 +++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 arch/x86/virt/tdxcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ba8042ce61c2..e5ff8ed59adf 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,6 +8,33 @@
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+/*
+ * SW-defined error codes.
+ *
+ * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
+ * TDX module.
+ */
+#define TDX_ERROR			(1UL << 63)
+#define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(40, 47))
+#define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | 0xFFFF0000ULL)
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
@@ -18,4 +45,5 @@ static inline void tdx_early_init(void) { };
 
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
index 000000000000..b9ec23c95fd5
--- /dev/null
+++ b/arch/x86/virt/tdxcall.S
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asm-offsets.h>
+#include <asm/tdx.h>
+
+/*
+ * TDX_MODULE_CALL - common helper macro for both
+ *                 TDCALL and SEAMCALL instructions.
+ *
+ * TDCALL   - used by TDX guests to make requests to the
+ *            TDX module and hypercalls to the VMM.
+ * SEAMCALL - used by TDX hosts to make requests to the
+ *            TDX module.
+ *
+ * Both instruction are supported in Binutils >= 2.36.
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
+	 * This value will never be used as actual SEAMCALL error code as
+	 * it is from the Reserved status code class.
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

