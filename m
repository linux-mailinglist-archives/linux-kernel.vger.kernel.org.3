Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFAA4982F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbiAXPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:19100 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240206AbiAXPCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036551; x=1674572551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cmM37ONetmfy+H/QLu0tbdNtpNyWydlaLbgWJ54yjjA=;
  b=W8uFv7VBoT16cJ/Mdev/lSajPYl0Uzmb6ptX8HVIwuVPpFo3YD60snTx
   5ZnL2fviT/tJhkKSx0ye4BEyBiNE4sTYIKl9FZKJBuJvW1rRE+AWN3yuv
   9FBd8dymKiadv6I9jpDY1n8mlzJ7VJ+5kWAyNDvSdkek8VgmMdkOIsEHF
   R/GZq8bWV6ZzPZXNchHmGttDQTCrOKiUPNYAXKCugN7nFe6jl8hzPtHiH
   JuOZxUdex6r88G4X3AM0nq+vN5h4f0PLGVW3fqWtxWNGVsL10C2AAPnA0
   Jhfq33hFA58KkHQNx1FydB1jUKkVmzRCHDLiGoM2hC/+4PpQcxAf1BvAz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233423319"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233423319"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695447691"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2022 07:02:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E64BA9E0; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
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
Subject: [PATCHv2 12/29] x86/boot/compressed: Support TDX guest port I/O at decompression time
Date:   Mon, 24 Jan 2022 18:01:58 +0300
Message-Id: <20220124150215.36893-13-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/x86/boot/compressed/tdx.c    | 59 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h | 23 ++++++++++++
 arch/x86/include/asm/tdx.h        | 21 -----------
 5 files changed, 86 insertions(+), 22 deletions(-)
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
index 000000000000..aafadc136c88
--- /dev/null
+++ b/arch/x86/boot/compressed/tdcall.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../kernel/tdcall.S"
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 6853376fe69a..f2e1449c74cd 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -5,6 +5,10 @@
 
 #include "../cpuflags.h"
 #include "../string.h"
+#include "../io.h"
+
+#include <vdso/limits.h>
+#include <uapi/asm/vmx.h>
 
 #include <asm/shared/tdx.h>
 
@@ -15,6 +19,54 @@ bool early_is_tdx_guest(void)
 	return tdx_guest_detected;
 }
 
+static inline unsigned int tdx_io_in(int size, int port)
+{
+	struct tdx_hypercall_output out;
+
+	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
+			size, 0, port, 0, &out);
+
+	return out.r10 ? UINT_MAX : out.r11;
+}
+
+static inline void tdx_io_out(int size, int port, u64 value)
+{
+	struct tdx_hypercall_output out;
+
+	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
+			size, 1, port, value, &out);
+}
+
+static inline unsigned char tdx_inb(int port)
+{
+	return tdx_io_in(1, port);
+}
+
+static inline unsigned short tdx_inw(int port)
+{
+	return tdx_io_in(2, port);
+}
+
+static inline unsigned int tdx_inl(int port)
+{
+	return tdx_io_in(4, port);
+}
+
+static inline void tdx_outb(unsigned char value, int port)
+{
+	tdx_io_out(1, port, value);
+}
+
+static inline void tdx_outw(unsigned short value, int port)
+{
+	tdx_io_out(2, port, value);
+}
+
+static inline void tdx_outl(unsigned int value, int port)
+{
+	tdx_io_out(4, port, value);
+}
+
 void early_tdx_detect(void)
 {
 	u32 eax, sig[3];
@@ -26,4 +78,11 @@ void early_tdx_detect(void)
 
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
index 12bede46d048..4a0218bedc75 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -1,7 +1,30 @@
 #ifndef _ASM_X86_SHARED_TDX_H
 #define _ASM_X86_SHARED_TDX_H
 
+#include <linux/types.h>
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
+#define TDX_HYPERCALL_STANDARD  0
+
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
+/* Used to request services from the VMM */
+u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
+		    u64 r15, struct tdx_hypercall_output *out);
+
 #endif
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 53f7dd0fbe58..27eb4ab2fdd2 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -7,8 +7,6 @@
 #include <asm/ptrace.h>
 #include <asm/shared/tdx.h>
 
-#define TDX_HYPERCALL_STANDARD  0
-
 /*
  * Used in __tdx_module_call() to gather the output registers'
  * values of the TDCALL instruction when requesting services from
@@ -24,21 +22,6 @@ struct tdx_module_output {
 	u64 r11;
 };
 
-/*
- * Used in __tdx_hypercall() to gather the output registers' values
- * of the TDCALL instruction when requesting services from the VMM.
- * This is a software only structure and not part of the TDX
- * module/VMM ABI.
- */
-struct tdx_hypercall_output {
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
@@ -64,10 +47,6 @@ bool is_tdx_guest(void);
 u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		      struct tdx_module_output *out);
 
-/* Used to request services from the VMM */
-u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
-		    u64 r15, struct tdx_hypercall_output *out);
-
 bool tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
-- 
2.34.1

