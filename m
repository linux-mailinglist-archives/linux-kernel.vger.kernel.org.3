Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8184BBD5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiBRQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:18:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbiBRQRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDCE22BE4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201040; x=1676737040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lW76XWoHEmDrfZOgnDMzIKPN2jpQBKZ8nzllyPMLMsc=;
  b=YAMkXWk/Way+NmvbDdmZlDZzuNTDcw5MW+0i37JVflKldsysxxcTdUwl
   4a58qr0gAv/YMOfTl31WjgFE5i+A3UFmpGXH67uYwWn+aCC8UUJ94V8Vg
   qPyQVeoSlW6pzDwkY0hDRENrB0i5NXxY5EernSd5hnF1kFggxaVtzGxZb
   qqWfsH4mKNAZvYTOsMpzKZ8fo1+uzWFuHxwuh9lF/fcZs8EWbM8d0pIrl
   s3wxaghbLPCjoMfyzEKKpkPy3pv2BNdf5JbTw2GYgir+2rjc4McDyPzZG
   xtryWuYczcMNNFLYblNE1n7ahC351+SYNZbWfmnifTiaaAOkkVqhVGibb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="251355311"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="251355311"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="541945052"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 18 Feb 2022 08:17:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A6A02A24; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
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
Subject: [PATCHv3 13/32] x86/tdx: Detect TDX at early kernel decompression time
Date:   Fri, 18 Feb 2022 19:16:59 +0300
Message-Id: <20220218161718.67148-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
the decompression step is acceptable because the decompression code size is
small enough and hence patching it will not bloat the image size a lot.

To support port I/O in decompression code, TDX must be detected before
the decompression code might do port I/O. Detect whether the kernel runs
in a TDX guest.

Add an early_is_tdx_guest() interface to query the cached TDX guest
status in the decompression code.

The actual port I/O paravirtualization will come later in the series.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
index 000000000000..8a72ce2e880f
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
+	if (memcmp(TDX_IDENT, sig, 12))
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
index e6e23ade53a6..d4c28b9f2fbc 100644
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

