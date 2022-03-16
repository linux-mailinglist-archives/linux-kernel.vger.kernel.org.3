Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836CC4DA7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352313AbiCPCMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352691AbiCPCLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:11:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86155E75C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647396607; x=1678932607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pYp3W7FjT5zOS/F/OlOXBLVNt53le80VEYv7obQ0PJ4=;
  b=ZNV7zdvH5YR47WjHci6scIX+AqVbwPWNn1WsGZXIKyWMDL6hJ6xtybbT
   nm/PtuE1Cvpkk0YkXeXd8s87Tf6GQx6ZrQGECEP2ifTZZiAVDJljcNTiP
   xIMP04g4hv26jwL+XTRrFcUXWrFpNf8oQupigCe8EkZp/vumZ4h7Dmhzq
   VBBGPJeJ9RusVAzLiexrGd3Pk6N7H9aaPUJT4+MYg/xKIJ4JfApqqBMBj
   FEBUZL1F6/YjQ0xh+JwGmYcOXcQzvrMplSebe3sL4tlxr6s3p+f5gEqPf
   v08x8MEzCyJ0IIVBpruAapWuYdvquPqDYkyfmkbNZaZYaz4Y9E6OkuhIF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255299994"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="255299994"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="714416718"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 19:09:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 200F2829; Wed, 16 Mar 2022 04:10:10 +0200 (EET)
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv6 12/30] x86/tdx: Detect TDX at early kernel decompression time
Date:   Wed, 16 Mar 2022 05:08:38 +0300
Message-Id: <20220316020856.24435-13-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

The early decompression code does port I/O for its console output. But,
handling the decompression-time port I/O demands a different approach
from normal runtime because the IDT required to support #VE based port
I/O emulation is not yet set up. Paravirtualizing I/O calls during
the decompression step is acceptable because the decompression code
doesn't have a lot of call sites to IO instruction.

To support port I/O in decompression code, TDX must be detected before
the decompression code might do port I/O. Detect whether the kernel runs
in a TDX guest.

Add an early_is_tdx_guest() interface to query the cached TDX guest
status in the decompression code.

TDX is detected with CPUID. Make cpuid_count() accessible outside
boot/cpuflags.c.

TDX detection in the main kernel is very similar. Move common bits
into <asm/shared/tdx.h>.

The actual port I/O paravirtualization will come later in the series.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/misc.c   |  8 ++++++++
 arch/x86/boot/compressed/misc.h   |  2 ++
 arch/x86/boot/compressed/tdx.c    | 26 ++++++++++++++++++++++++++
 arch/x86/boot/compressed/tdx.h    | 15 +++++++++++++++
 arch/x86/boot/cpuflags.c          |  3 +--
 arch/x86/boot/cpuflags.h          |  1 +
 arch/x86/include/asm/shared/tdx.h |  8 ++++++++
 arch/x86/include/asm/tdx.h        |  4 +---
 9 files changed, 63 insertions(+), 5 deletions(-)
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
index a4339cb2d247..2b1169869b96 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -370,6 +370,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	lines = boot_params->screen_info.orig_video_lines;
 	cols = boot_params->screen_info.orig_video_cols;
 
+	/*
+	 * Detect TDX guest environment.
+	 *
+	 * It has to be done before console_init() in order to use
+	 * paravirtualized port I/O operations if needed.
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
index 000000000000..d4f195e9d1ef
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx.c
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+	if (memcmp(TDX_IDENT, sig, sizeof(sig)))
+		return;
+
+	/* Cache TDX guest feature status */
+	tdx_guest_detected = true;
+}
diff --git a/arch/x86/boot/compressed/tdx.h b/arch/x86/boot/compressed/tdx.h
new file mode 100644
index 000000000000..a7bff6ae002e
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+#endif /* BOOT_COMPRESSED_TDX_H */
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
index 000000000000..8209ba9ffe1a
--- /dev/null
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SHARED_TDX_H
+#define _ASM_X86_SHARED_TDX_H
+
+#define TDX_CPUID_LEAF_ID	0x21
+#define TDX_IDENT		"IntelTDX    "
+
+#endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8f84ffce7f38..119283d6ce26 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -6,9 +6,7 @@
 #include <linux/bits.h>
 #include <linux/init.h>
 #include <asm/ptrace.h>
-
-#define TDX_CPUID_LEAF_ID	0x21
-#define TDX_IDENT		"IntelTDX    "
+#include <asm/shared/tdx.h>
 
 #define TDX_HYPERCALL_STANDARD  0
 
-- 
2.34.1

