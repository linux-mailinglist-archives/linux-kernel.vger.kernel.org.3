Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737F04745D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhLNPDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:03:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:54753 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235183AbhLNPDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219009481"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="219009481"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="481987980"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2021 07:03:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 88E2A99F; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
Subject: [PATCH 09/26] x86/tdx: Detect TDX at early kernel decompression time
Date:   Tue, 14 Dec 2021 18:02:47 +0300
Message-Id: <20211214150304.62613-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

The early decompression code does port I/O for its console output. But,
handling the decompression-time port I/O demands a different approach
from normal runtime because the IDT required to support #VE based port
I/O emulation is not yet set up. Paravirtualizing I/O calls during
the decompression step is acceptable because the decompression code size is
small enough and hence patching it will not bloat the image size a lot.

To support port I/O in decompression code, TDX must be detected before
the decompression code might do port I/O. Add support to detect for
TDX guest support before console_init() in the extract_kernel().
Detecting it above the console_init() is early enough for patching
port I/O.

Add an early_is_tdx_guest() interface to get the cached TDX guest
status in the decompression code.

The actual port I/O paravirtualization will come later in the series.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/misc.c   |  8 ++++++++
 arch/x86/boot/compressed/misc.h   |  2 ++
 arch/x86/boot/compressed/tdx.c    | 33 +++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/tdx.h    | 16 +++++++++++++++
 arch/x86/boot/cpuflags.c          | 13 ++++++++++--
 arch/x86/boot/cpuflags.h          |  2 ++
 7 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdx.c
 create mode 100644 arch/x86/boot/compressed/tdx.h

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f846c3..22a2a6cc2ab4 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -98,6 +98,7 @@ ifdef CONFIG_X86_64
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index a4339cb2d247..1b07755a5efd 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -370,6 +370,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	lines = boot_params->screen_info.orig_video_lines;
 	cols = boot_params->screen_info.orig_video_cols;
 
+	/*
+	 * Detect if we are running in TDX guest environment.
+	 *
+	 * It has to be done before console_init() to use paravirtualized
+	 * port I/O oprations if needed.
+	 */
+	early_tdx_detect();
+
 	console_init();
 
 	/*
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 16ed360b6692..0d8e275a9d96 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -28,6 +28,8 @@
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
 
+#include "tdx.h"
+
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
 
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
new file mode 100644
index 000000000000..2ee7d0bdf907
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tdx.c - Early boot code for TDX
+ */
+
+#include "../cpuflags.h"
+#include "../string.h"
+
+#define TDX_CPUID_LEAF_ID	0x21
+#define TDX_IDENT		"IntelTDX    "
+
+static bool tdx_guest_detected;
+
+void early_tdx_detect(void)
+{
+	u32 eax, sig[3];
+
+	if (cpuid_max_leaf() < TDX_CPUID_LEAF_ID)
+		return;
+
+	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
+
+	if (memcmp(TDX_IDENT, sig, 12))
+		return;
+
+	/* Cache TDX guest feature status */
+	tdx_guest_detected = true;
+}
+
+bool early_is_tdx_guest(void)
+{
+	return tdx_guest_detected;
+}
diff --git a/arch/x86/boot/compressed/tdx.h b/arch/x86/boot/compressed/tdx.h
new file mode 100644
index 000000000000..18970c09512e
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Intel Corporation */
+#ifndef BOOT_COMPRESSED_TDX_H
+#define BOOT_COMPRESSED_TDX_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_INTEL_TDX_GUEST
+void early_tdx_detect(void);
+bool early_is_tdx_guest(void);
+#else
+static inline void early_tdx_detect(void) { };
+static inline bool early_is_tdx_guest(void) { return false; }
+#endif
+
+#endif
diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index a0b75f73dc63..7f97bf88c540 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -71,8 +71,7 @@ int has_eflag(unsigned long mask)
 # define EBX_REG "=b"
 #endif
 
-static inline void cpuid_count(u32 id, u32 count,
-		u32 *a, u32 *b, u32 *c, u32 *d)
+void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d)
 {
 	asm volatile(".ifnc %%ebx,%3 ; movl  %%ebx,%3 ; .endif	\n\t"
 		     "cpuid					\n\t"
@@ -82,6 +81,16 @@ static inline void cpuid_count(u32 id, u32 count,
 	);
 }
 
+/* Get maximum leaf value using CPUID(0) */
+u32 cpuid_max_leaf(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	cpuid_count(0, 0, &eax, &ebx, &ecx, &edx);
+
+	return eax;
+}
+
 #define cpuid(id, a, b, c, d) cpuid_count(id, 0, a, b, c, d)
 
 void get_cpuflags(void)
diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
index 2e20814d3ce3..dea67090a22f 100644
--- a/arch/x86/boot/cpuflags.h
+++ b/arch/x86/boot/cpuflags.h
@@ -17,5 +17,7 @@ extern u32 cpu_vendor[3];
 
 int has_eflag(unsigned long mask);
 void get_cpuflags(void);
+void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d);
+u32 cpuid_max_leaf(void);
 
 #endif
-- 
2.32.0

