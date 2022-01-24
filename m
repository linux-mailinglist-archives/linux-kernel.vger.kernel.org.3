Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90FD4982EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbiAXPDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:43409 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239188AbiAXPC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036548; x=1674572548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcUqbzAY6M/ii9A7rG49fqPPHN0dWo5mN7mZmaHffu4=;
  b=cNStg1N01fqC1hP0HtlVF87eTL36pkMt8awZxzX1it4zCJvbLwAXUKj8
   8WOAodIIGdlnyeYYHV5hFaLnouaqgZ8ez/TEI9sQJjzZV2qwcY9On0omO
   riPw8+i747WFm/aQXMQOIMGeWaR3VY9gR/Xo/1QfHBRAJs8gQcD3UCgjB
   CGxC70CNLZ4hnoiRkXWWB903xoPBBvYqQa//23eUuSih5qjm6WSrk/+JN
   n6jsGaSBP3iah3/logAVH0+KqqJ0zXivGdE1tE+svXt1gArLux14bBA/L
   NtnrSC+CqjL+mWA4Huack4CJN+zg4D3K06NJjZYgwHm+h3XSi8PWUmr6+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246280269"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246280269"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="532102238"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2022 07:02:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BC3DC56A; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
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
Subject: [PATCHv2 09/29] x86/tdx: Detect TDX at early kernel decompression time
Date:   Mon, 24 Jan 2022 18:01:55 +0300
Message-Id: <20220124150215.36893-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/boot/compressed/tdx.c    | 29 +++++++++++++++++++++++++++++
 arch/x86/boot/compressed/tdx.h    | 16 ++++++++++++++++
 arch/x86/boot/cpuflags.c          |  3 +--
 arch/x86/boot/cpuflags.h          |  1 +
 arch/x86/include/asm/shared/tdx.h |  7 +++++++
 arch/x86/include/asm/tdx.h        |  4 +---
 9 files changed, 66 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdx.c
 create mode 100644 arch/x86/boot/compressed/tdx.h
 create mode 100644 arch/x86/include/asm/shared/tdx.h

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6115274fe10f..732f6b21ecbd 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -101,6 +101,7 @@ ifdef CONFIG_X86_64
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index a4339cb2d247..d8373d766672 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -370,6 +370,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	lines = boot_params->screen_info.orig_video_lines;
 	cols = boot_params->screen_info.orig_video_cols;
 
+	/*
+	 * Detect TDX guest environment.
+	 *
+	 * It has to be done before console_init() in order to use
+	 * paravirtualized port I/O oprations if needed.
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
index 000000000000..6853376fe69a
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tdx.c - Early boot code for TDX
+ */
+
+#include "../cpuflags.h"
+#include "../string.h"
+
+#include <asm/shared/tdx.h>
+
+static bool tdx_guest_detected;
+
+bool early_is_tdx_guest(void)
+{
+	return tdx_guest_detected;
+}
+
+void early_tdx_detect(void)
+{
+	u32 eax, sig[3];
+
+	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
+
+	if (memcmp(TDX_IDENT, sig, 12))
+		return;
+
+	/* Cache TDX guest feature status */
+	tdx_guest_detected = true;
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
index a0b75f73dc63..a83d67ec627d 100644
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
diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
index 2e20814d3ce3..475b8fde90f7 100644
--- a/arch/x86/boot/cpuflags.h
+++ b/arch/x86/boot/cpuflags.h
@@ -17,5 +17,6 @@ extern u32 cpu_vendor[3];
 
 int has_eflag(unsigned long mask);
 void get_cpuflags(void);
+void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d);
 
 #endif
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
new file mode 100644
index 000000000000..12bede46d048
--- /dev/null
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_X86_SHARED_TDX_H
+#define _ASM_X86_SHARED_TDX_H
+
+#define TDX_CPUID_LEAF_ID	0x21
+#define TDX_IDENT		"IntelTDX    "
+
+#endif
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 9b4714a45bb9..53f7dd0fbe58 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -5,9 +5,7 @@
 
 #include <linux/init.h>
 #include <asm/ptrace.h>
-
-#define TDX_CPUID_LEAF_ID	0x21
-#define TDX_IDENT		"IntelTDX    "
+#include <asm/shared/tdx.h>
 
 #define TDX_HYPERCALL_STANDARD  0
 
-- 
2.34.1

