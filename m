Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EFD4F534E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454311AbiDFDU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449346AbiDFCPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:15:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0E61B2558
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201723; x=1680737723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ia7XSoQgZLAv+AkOkspH/dc44a6T0r2MvrqAQyc1PU=;
  b=j7gjqT3IYYkETFPGBRtigPfurGRoUYQYhsoeuk5oO3voe7hBpRiGsEQ1
   FcCu1PjH99aC5vOdjoUQGslktmQuP6mGeMy5d2+x3tPw9oqkpeEchc3jF
   YbaRe+NP692kQb+lFhdymImZ1mPzYGTuC50OtILb9MqpONYfuOBJ1PXVb
   RPr9pKfBMipG0exNEQmH20VHPnPx/HRuZKtSsEruwI0YOw5eK9xy3rPAx
   k27eTI8w4Is/+1g/4rnty7uTatfQIxOk1e3uBgVozJZweNXfkBxiqn23q
   UAptFnVCrf7ooOEY+9Ptkg660COdTVaO+E/Y8xOd5Pi1dXhnS/rWbEiLZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261065455"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="261065455"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="608652719"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2022 16:34:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 50B78BE1; Wed,  6 Apr 2022 02:29:46 +0300 (EEST)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv8 16/30] x86/boot: Port I/O: add decompression-time support for TDX
Date:   Wed,  6 Apr 2022 02:29:25 +0300
Message-Id: <20220405232939.73860-17-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/boot/compressed/tdcall.S |  3 ++
 arch/x86/boot/compressed/tdx.c    | 61 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h | 32 ++++++++++++++++
 arch/x86/include/asm/tdx.h        | 27 --------------
 5 files changed, 97 insertions(+), 28 deletions(-)
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
index 000000000000..46d0495e0d3a
--- /dev/null
+++ b/arch/x86/boot/compressed/tdcall.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../coco/tdx/tdcall.S"
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 5f6d01a2f1f4..918a7606f53c 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -2,9 +2,65 @@
 
 #include "../cpuflags.h"
 #include "../string.h"
+#include "../io.h"
+#include "error.h"
+
+#include <vdso/limits.h>
+#include <uapi/asm/vmx.h>
 
 #include <asm/shared/tdx.h>
 
+/* Called from __tdx_hypercall() for unrecoverable failure */
+void __tdx_hypercall_failed(void)
+{
+	error("TDVMCALL failed. TDX module bug?");
+}
+
+static inline unsigned int tdx_io_in(int size, u16 port)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_IO_INSTRUCTION,
+		.r12 = size,
+		.r13 = 0,
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
+		.r13 = 1,
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
 void early_tdx_detect(void)
 {
 	u32 eax, sig[3];
@@ -13,4 +69,9 @@ void early_tdx_detect(void)
 
 	if (memcmp(TDX_IDENT, sig, sizeof(sig)))
 		return;
+
+	/* Use hypercalls instead of I/O instructions */
+	pio_ops.f_inb  = tdx_inb;
+	pio_ops.f_outb = tdx_outb;
+	pio_ops.f_outw = tdx_outw;
 }
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 8209ba9ffe1a..e53f26228fbb 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -2,7 +2,39 @@
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
+/* Called from __tdx_hypercall() for unrecoverable failure */
+void __tdx_hypercall_failed(void);
+
+#endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 81a1ec14e476..7944fd1ae07d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -3,17 +3,11 @@
 #ifndef _ASM_X86_TDX_H
 #define _ASM_X86_TDX_H
 
-#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/bits.h>
 #include <asm/ptrace.h>
 #include <asm/shared/tdx.h>
 
-#define TDX_HYPERCALL_STANDARD  0
-
-#define TDX_HCALL_HAS_OUTPUT	BIT(0)
-#define TDX_HCALL_ISSUE_STI	BIT(1)
-
 /*
  * SW-defined error codes.
  *
@@ -41,21 +35,6 @@ struct tdx_module_output {
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
@@ -80,12 +59,6 @@ void __init tdx_early_init(void);
 u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		      struct tdx_module_output *out);
 
-/* Used to request services from the VMM */
-u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
-
-/* Called from __tdx_hypercall() for unrecoverable failure */
-void __tdx_hypercall_failed(void);
-
 void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
-- 
2.35.1

