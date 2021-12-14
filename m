Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6B54745E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhLNPEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:04:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:28585 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhLNPDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225852712"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="225852712"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="754837189"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2021 07:03:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 960509F0; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
Subject: [PATCH 10/26] x86/tdx: Support TDX guest port I/O at decompression time
Date:   Tue, 14 Dec 2021 18:02:48 +0300
Message-Id: <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Port IO triggers a #VE exception in TDX guests.  During normal runtime,
the kernel will handle those exceptions for any port IO.

But for the early code in the decompressor, #VE cannot be used because
the IDT needed for handling the exception is not set up.

Replace IN/OUT instructions with TDX IO hypercalls by defining helper
macros __in/__out and by re-defining them in the decompressor code.
Also, since TDX IO hypercall requires an IO size parameter, allow
__in/__out macros to accept size as an input parameter.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/misc.h   |  8 ++++--
 arch/x86/boot/compressed/tdcall.S |  3 +++
 arch/x86/boot/compressed/tdx.h    | 44 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/io.h         | 16 ++++++++---
 5 files changed, 66 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 22a2a6cc2ab4..1bfe30ebadbe 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -99,6 +99,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdcall.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 0d8e275a9d96..6502adf71a2f 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -19,6 +19,12 @@
 /* cpu_feature_enabled() cannot be used this early */
 #define USE_EARLY_PGTABLE_L5
 
+/*
+ * Redefine __in/__out macros via tdx.h before including
+ * linux/io.h.
+ */
+#include "tdx.h"
+
 #include <linux/linkage.h>
 #include <linux/screen_info.h>
 #include <linux/elf.h>
@@ -28,8 +34,6 @@
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
 
-#include "tdx.h"
-
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
 
diff --git a/arch/x86/boot/compressed/tdcall.S b/arch/x86/boot/compressed/tdcall.S
new file mode 100644
index 000000000000..aafadc136c88
--- /dev/null
+++ b/arch/x86/boot/compressed/tdcall.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../kernel/tdcall.S"
diff --git a/arch/x86/boot/compressed/tdx.h b/arch/x86/boot/compressed/tdx.h
index 18970c09512e..5d39608a2af4 100644
--- a/arch/x86/boot/compressed/tdx.h
+++ b/arch/x86/boot/compressed/tdx.h
@@ -6,8 +6,52 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_INTEL_TDX_GUEST
+
+#include <vdso/limits.h>
+#include <uapi/asm/vmx.h>
+#include <asm/tdx.h>
+
 void early_tdx_detect(void);
 bool early_is_tdx_guest(void);
+
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
+#define __out(bwl, bw, sz)						\
+do {									\
+	if (early_is_tdx_guest()) {					\
+		tdx_io_out(sz, port, value);				\
+	} else {							\
+		asm volatile("out" #bwl " %" #bw "0, %w1" : :		\
+				"a"(value), "Nd"(port));		\
+	}								\
+} while (0)
+
+#define __in(bwl, bw, sz)						\
+do {									\
+	if (early_is_tdx_guest()) {					\
+		value = tdx_io_in(sz, port);				\
+	} else {							\
+		asm volatile("in" #bwl " %w1, %" #bw "0" :		\
+				"=a"(value) : "Nd"(port));		\
+	}								\
+} while (0)
+
 #else
 static inline void early_tdx_detect(void) { };
 static inline bool early_is_tdx_guest(void) { return false; }
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index f6d91ecb8026..f5bb8972b4b2 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -257,18 +257,26 @@ static inline void slow_down_io(void)
 
 #endif
 
+#ifndef __out
+#define __out(bwl, bw, sz)						\
+	asm volatile("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port))
+#endif
+
+#ifndef __in
+#define __in(bwl, bw, sz)						\
+	asm volatile("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port))
+#endif
+
 #define BUILDIO(bwl, bw, type)						\
 static inline void out##bwl(unsigned type value, int port)		\
 {									\
-	asm volatile("out" #bwl " %" #bw "0, %w1"			\
-		     : : "a"(value), "Nd"(port));			\
+	__out(bwl, bw, sizeof(type));					\
 }									\
 									\
 static inline unsigned type in##bwl(int port)				\
 {									\
 	unsigned type value;						\
-	asm volatile("in" #bwl " %w1, %" #bw "0"			\
-		     : "=a"(value) : "Nd"(port));			\
+	__in(bwl, bw, sizeof(type));					\
 	return value;							\
 }									\
 									\
-- 
2.32.0

