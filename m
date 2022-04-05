Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE64D4F5374
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359720AbiDFDRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447718AbiDFCOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:14:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA67F1B0BD6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201720; x=1680737720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NMBjF6uwmzeNao30BpVrAix1QyUVF8lfuLCrba2E85A=;
  b=bdXj9w1ZEeZzoGUNUGa4wx8DOgpnldugpahed96P1LffNJUAZHFfdcf6
   QhObqUcROS3ZGaELNcGc2Y9+PAVb9VJcrouBoGzIJY42Xsnbgw76y4pvT
   PdjnD8QBEgMzYuJitZ8OP/mmrAK6fVO8MCi1ZWJHWs1ehJx9/t5nmxF0r
   A7oyFPcGtNryu0ggKUfWJsBqiaKk7UhtIZd7fNO2KVSMXuHc8YC638WHn
   o58I3oJNrRWWJRMbC9/CeaENcWWAb38ASNmo/Se6qr563PdbsdhIyYG+S
   LpwczAl8LR0TEScsGHZWDgivRvGjxc1CqXZwSvtvvFdwzdoCdUo7JcVOX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260884431"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="260884431"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="549273439"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2022 16:34:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7DA655C; Wed,  6 Apr 2022 02:29:45 +0300 (EEST)
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCHv8 01/30] x86/tdx: Detect running as a TDX guest in early boot
Date:   Wed,  6 Apr 2022 02:29:10 +0300
Message-Id: <20220405232939.73860-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

In preparation of extending cc_platform_has() API to support TDX guest,
use CPUID instruction to detect support for TDX guests in the early
boot code (via tdx_early_init()). Since copy_bootdata() is the first
user of cc_platform_has() API, detect the TDX guest status before it.

Define a synthetic feature flag (X86_FEATURE_TDX_GUEST) and set this
bit in a valid TDX guest platform.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig                         | 12 ++++++++++++
 arch/x86/coco/Makefile                   |  2 ++
 arch/x86/coco/tdx/Makefile               |  3 +++
 arch/x86/coco/tdx/tdx.c                  | 22 ++++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h       |  1 +
 arch/x86/include/asm/disabled-features.h |  8 +++++++-
 arch/x86/include/asm/tdx.h               | 21 +++++++++++++++++++++
 arch/x86/kernel/head64.c                 |  4 ++++
 8 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/coco/tdx/Makefile
 create mode 100644 arch/x86/coco/tdx/tdx.c
 create mode 100644 arch/x86/include/asm/tdx.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..4ae27322869d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -878,6 +878,18 @@ config ACRN_GUEST
 	  IOT with small footprint and real-time features. More details can be
 	  found in https://projectacrn.org/.
 
+config INTEL_TDX_GUEST
+	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
+	depends on X86_64 && CPU_SUP_INTEL
+	depends on X86_X2APIC
+	help
+	  Support running as a guest under Intel TDX.  Without this support,
+	  the guest kernel can not boot or run under TDX.
+	  TDX includes memory encryption and integrity capabilities
+	  which protect the confidentiality and integrity of guest
+	  memory contents and CPU state. TDX guests are protected from
+	  some attacks from the VMM.
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
index c1ead00017a7..c816acf78b6a 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -4,3 +4,5 @@ KASAN_SANITIZE_core.o	:= n
 CFLAGS_core.o		+= -fno-stack-protector
 
 obj-y += core.o
+
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx/
diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
new file mode 100644
index 000000000000..c929d53ee059
--- /dev/null
+++ b/arch/x86/coco/tdx/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += tdx.o
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
new file mode 100644
index 000000000000..97674471fd1e
--- /dev/null
+++ b/arch/x86/coco/tdx/tdx.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2022 Intel Corporation */
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "tdx: " fmt
+
+#include <linux/cpufeature.h>
+#include <asm/tdx.h>
+
+void __init tdx_early_init(void)
+{
+	u32 eax, sig[3];
+
+	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
+
+	if (memcmp(TDX_IDENT, sig, sizeof(sig)))
+		return;
+
+	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
+
+	pr_info("Guest detected\n");
+}
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 73e643ae94b6..20df73b51025 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -238,6 +238,7 @@
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
 #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted function */
+#define X86_FEATURE_TDX_GUEST		( 8*32+22) /* Intel Trust Domain Extensions Guest */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 1231d63f836d..b37de8268c9a 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -68,6 +68,12 @@
 # define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+# define DISABLE_TDX_GUEST	0
+#else
+# define DISABLE_TDX_GUEST	(1 << (X86_FEATURE_TDX_GUEST & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -79,7 +85,7 @@
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
-#define DISABLED_MASK8	0
+#define DISABLED_MASK8	(DISABLE_TDX_GUEST)
 #define DISABLED_MASK9	(DISABLE_SMAP|DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
new file mode 100644
index 000000000000..ba8042ce61c2
--- /dev/null
+++ b/arch/x86/include/asm/tdx.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2022 Intel Corporation */
+#ifndef _ASM_X86_TDX_H
+#define _ASM_X86_TDX_H
+
+#include <linux/init.h>
+
+#define TDX_CPUID_LEAF_ID	0x21
+#define TDX_IDENT		"IntelTDX    "
+
+#ifdef CONFIG_INTEL_TDX_GUEST
+
+void __init tdx_early_init(void);
+
+#else
+
+static inline void tdx_early_init(void) { };
+
+#endif /* CONFIG_INTEL_TDX_GUEST */
+
+#endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4f5ecbbaae77..6dff50c3edd6 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -40,6 +40,7 @@
 #include <asm/extable.h>
 #include <asm/trapnr.h>
 #include <asm/sev.h>
+#include <asm/tdx.h>
 
 /*
  * Manage page tables very early on.
@@ -514,6 +515,9 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 
 	idt_setup_early_handler();
 
+	/* Needed before cc_platform_has() can be used for TDX */
+	tdx_early_init();
+
 	copy_bootdata(__va(real_mode_data));
 
 	/*
-- 
2.35.1

