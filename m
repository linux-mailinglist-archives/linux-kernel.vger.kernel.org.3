Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE714FA124
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiDIBcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbiDIBaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0FB10E048;
        Fri,  8 Apr 2022 18:27:32 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CX3z/yPVKvpbtBImND/jOu+8PglVUANMoEPCH99YPfY=;
        b=GxvUVR2HLfGOljq0a11/nUto3+RpgbqeF9VsYPxn9WihkKnZyGS+N/kAlwfVgunGk72Iss
        YezH1jRdkceXlWJuoG73FQ56ywuyjr6CHEinm5PbpbUrwPGLQHZOlNxw/usQKRk/SoNyIt
        setSQCODY7n/gXDoepFj893ObMewlff2DbH6F4ceYaYt0GKtkSFlmt+fUDOtg3dE2HtVHs
        WFLZm5fRCar1Sh1EHfVkSgLE5OSu2c1ikgBruDOEduaH0qAEO4UxFv9XKvO+kc5wWZ9zt+
        QE9OT7rUtGSOB3LdQF/xmnS+cEKg/AuGKUVRdhilGp+7zBq1uxkt9tkSq+lcCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CX3z/yPVKvpbtBImND/jOu+8PglVUANMoEPCH99YPfY=;
        b=TK6PJFro4y1exnp9D3OCxxjdXfF1fYw/h0S3HM5V6wYNoZl6LwCDXgdbuMJ/TtpWLbyYLb
        oA/lKvS8EmY7hGDw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/boot: Port I/O: Add decompression-time support for TDX
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-17-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-17-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946765004.4207.16449897788455145951.tip-bot2@tip-bot2>
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

Commit-ID:     4c5b9aac6cade51aef64cc6ed67f2ad5acda9aed
Gitweb:        https://git.kernel.org/tip/4c5b9aac6cade51aef64cc6ed67f2ad5acda9aed
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:25 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:52 -07:00

x86/boot: Port I/O: Add decompression-time support for TDX

Port I/O instructions trigger #VE in the TDX environment. In response to
the exception, kernel emulates these instructions using hypercalls.

But during early boot, on the decompression stage, it is cumbersome to
deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
handling.

Hook up TDX-specific port I/O helpers if booting in TDX environment.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220405232939.73860-17-kirill.shutemov@linux.intel.com
---
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/boot/compressed/tdcall.S |  3 +-
 arch/x86/boot/compressed/tdx.c    | 61 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/shared/tdx.h | 32 ++++++++++++++++-
 arch/x86/include/asm/tdx.h        | 27 +-------------
 5 files changed, 97 insertions(+), 28 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 732f6b2..8fd0e6a 100644
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
index 0000000..46d0495
--- /dev/null
+++ b/arch/x86/boot/compressed/tdcall.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../coco/tdx/tdcall.S"
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 5f6d01a..918a760 100644
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
index 8209ba9..e53f262 100644
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
index 81a1ec1..7944fd1 100644
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
@@ -42,21 +36,6 @@ struct tdx_module_output {
 };
 
 /*
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
-/*
  * Used by the #VE exception handler to gather the #VE exception
  * info from the TDX module. This is a software only structure
  * and not part of the TDX module/VMM ABI.
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
