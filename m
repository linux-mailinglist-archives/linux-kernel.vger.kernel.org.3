Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239734BBD5D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiBRQTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:19:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiBRQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:18:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3837D2AD66C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201068; x=1676737068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rvGoQhf1AAFFJIhc09uvI0V9j/8BuIi7JOVKvROWGcM=;
  b=JUhTZeoESeQSixcFCm0Za7qF4J9obHsW3Bx9vxx7KkiFZiKXdR89M36g
   H+EV8uglS4D6lQItRjCqTmH+SVOZTP5UrYS7aPs1biiC9440h02MghfTc
   7upsuQmbj51x/1n52Bwun6dbUIVcWH2RH/uSEmiCp2rVARD7ceewf26cS
   Qtec6OCOzdSLsOccMn8YRniuwJhkiBif5/MEUHnuQC1Y01pBDkuSJ9kON
   pCLxKSs928vCeVg6lcjv5l4vc4c/t2DTTSFfIEZ8DdsKbMzTQ1Tafdo2w
   jZ/hmJcFIc3yUnLlTDBwvvkzf3WGJtj+geISkUi8BcaYY/0OMwLYVyn4w
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="251098333"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="251098333"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="637782184"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2022 08:17:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D17A9AC1; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
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
Subject: [PATCHv3 17/32] x86/boot/compressed: Support TDX guest port I/O at decompression time
Date:   Fri, 18 Feb 2022 19:17:03 +0300
Message-Id: <20220218161718.67148-18-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port I/O instructions trigger #VE in the TDX environment. In response to
the exception, kernel emulates these instructions using hypercalls.

But during early boot, on the decompression stage, it is cumbersome to
deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
handling.

Hook up TDX-specific port I/O helpers if booting in TDX environment.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/boot/compressed/tdcall.S |  3 ++
 arch/x86/boot/compressed/tdx.c    | 71 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h | 29 +++++++++++++
 arch/x86/include/asm/tdx.h        | 24 -----------
 5 files changed, 104 insertions(+), 25 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 732f6b21ecbd..8fd0e6ae2e1f 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -101,7 +101,7 @@ ifdef CONFIG_X86_64
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
-vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/tdcall.S b/arch/x86/boot/compressed/tdcall.S
new file mode 100644
index 000000000000..59b80ab6b41c
--- /dev/null
+++ b/arch/x86/boot/compressed/tdcall.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../coco/tdcall.S"
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 8a72ce2e880f..6e6f3d6d09b0 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -2,6 +2,10 @@
 
 #include "../cpuflags.h"
 #include "../string.h"
+#include "../io.h"
+
+#include <vdso/limits.h>
+#include <uapi/asm/vmx.h>
 
 #include <asm/shared/tdx.h>
 
@@ -12,6 +16,66 @@ bool early_is_tdx_guest(void)
 	return tdx_guest_detected;
 }
 
+static inline unsigned int tdx_io_in(int size, u16 port)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_IO_INSTRUCTION,
+		.r12 = size,
+		.r13  = 0,
+		.r14 = port,
+	};
+
+	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
+		return UINT_MAX;
+
+	return args.r11;
+}
+
+static inline void tdx_io_out(int size, u16 port, u32 value)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_IO_INSTRUCTION,
+		.r12 = size,
+		.r13  = 1,
+		.r14 = port,
+		.r15 = value,
+	};
+
+	__tdx_hypercall(&args, 0);
+}
+
+static inline u8 tdx_inb(u16 port)
+{
+	return tdx_io_in(1, port);
+}
+
+static inline u16 tdx_inw(u16 port)
+{
+	return tdx_io_in(2, port);
+}
+
+static inline u32 tdx_inl(u16 port)
+{
+	return tdx_io_in(4, port);
+}
+
+static inline void tdx_outb(u8 value, u16 port)
+{
+	tdx_io_out(1, port, value);
+}
+
+static inline void tdx_outw(u16 value, u16 port)
+{
+	tdx_io_out(2, port, value);
+}
+
+static inline void tdx_outl(u32 value, u16 port)
+{
+	tdx_io_out(4, port, value);
+}
+
 void early_tdx_detect(void)
 {
 	u32 eax, sig[3];
@@ -23,4 +87,11 @@ void early_tdx_detect(void)
 
 	/* Cache TDX guest feature status */
 	tdx_guest_detected = true;
+
+	pio_ops.inb = tdx_inb;
+	pio_ops.inw = tdx_inw;
+	pio_ops.inl = tdx_inl;
+	pio_ops.outb = tdx_outb;
+	pio_ops.outw = tdx_outw;
+	pio_ops.outl = tdx_outl;
 }
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 8209ba9ffe1a..51bce6351124 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -2,7 +2,36 @@
 #ifndef _ASM_X86_SHARED_TDX_H
 #define _ASM_X86_SHARED_TDX_H
 
+#include <linux/bits.h>
+#include <linux/types.h>
+
+#define TDX_HYPERCALL_STANDARD  0
+
+#define TDX_HCALL_HAS_OUTPUT	BIT(0)
+#define TDX_HCALL_ISSUE_STI	BIT(1)
+
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+#ifndef __ASSEMBLY__
+
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
+/* Used to request services from the VMM */
+u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
+
+#endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index d4c28b9f2fbc..54803cb6ccf5 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -3,16 +3,10 @@
 #ifndef _ASM_X86_TDX_H
 #define _ASM_X86_TDX_H
 
-#include <linux/bits.h>
 #include <linux/init.h>
 #include <asm/ptrace.h>
 #include <asm/shared/tdx.h>
 
-#define TDX_HYPERCALL_STANDARD  0
-
-#define TDX_HCALL_HAS_OUTPUT	BIT(0)
-#define TDX_HCALL_ISSUE_STI	BIT(1)
-
 #define TDX_SEAMCALL_VMFAILINVALID     0x8000FF00FFFF0000ULL
 
 #ifndef __ASSEMBLY__
@@ -32,21 +26,6 @@ struct tdx_module_output {
 	u64 r11;
 };
 
-/*
- * Used in __tdx_hypercall() to pass down and get back registers' values of
- * the TDCALL instruction when requesting services from the VMM.
- *
- * This is a software only structure and not part of the TDX module/VMM ABI.
- */
-struct tdx_hypercall_args {
-	u64 r10;
-	u64 r11;
-	u64 r12;
-	u64 r13;
-	u64 r14;
-	u64 r15;
-};
-
 /*
  * Used by the #VE exception handler to gather the #VE exception
  * info from the TDX module. This is a software only structure
@@ -71,9 +50,6 @@ void __init tdx_early_init(void);
 u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		      struct tdx_module_output *out);
 
-/* Used to request services from the VMM */
-u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
-
 void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
-- 
2.34.1

