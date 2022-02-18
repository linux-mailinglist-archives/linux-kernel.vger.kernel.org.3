Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70ED4BBD3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiBRQRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:17:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiBRQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:31 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C122B2C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201034; x=1676737034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oecRlJXk1lZ1V7jBCAVFz1hrIwNYs5tPscRaBCf99iM=;
  b=A8mh2jOH1mNYyzHOBP57ac+bm7OEZANNsfyLaHFB95F+xiH4Y82ErVx0
   Hco32gLfoO/tbm3MrjtwkP226kwYzLd4svRLI+BItIMOYq6ebyNKv7p/m
   Pp2qC/Ukw1qT1MOf7lxNSdLypAwWYmHW0nBDQdvI0w70b4FLtZvnXa6/m
   l6uFZSyH3GxLoSmr6oNNA2tRpD6Rv9pwOlJJMjFPkQ6rrtnRFggu4mXSn
   rNCNkN9kASCUdX0j5LQ1ZGxNvQNfDNy/oI+ZdG5iR3PDeZqs22aV0sVSZ
   BuEOgwJZtLpF+QhezfiH+86J1d+I4aHOb/qQBrob7GhfGqyAcB5TCC0qF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="311897831"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="311897831"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="635870609"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2022 08:17:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2CE156A8; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
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
Subject: [PATCHv3 03/32] x86/tdx: Detect running as a TDX guest in early boot
Date:   Fri, 18 Feb 2022 19:16:49 +0300
Message-Id: <20220218161718.67148-4-kirill.shutemov@linux.intel.com>
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

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

cc_platform_has() API is used in the kernel to enable confidential
computing features. Since TDX guest is a confidential computing
platform, it also needs to use this API.

In preparation of extending cc_platform_has() API to support TDX guest,
use CPUID instruction to detect support for TDX guests in the early
boot code (via tdx_early_init()). Since copy_bootdata() is the first
user of cc_platform_has() API, detect the TDX guest status before it.

Since cc_plaform_has() API will be used frequently across the boot
code, instead of repeatedly detecting the TDX guest status using the
CPUID instruction, detect once and cache the result.

Define a synthetic feature flag (X86_FEATURE_TDX_GUEST) and set this
bit in a valid TDX guest platform.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kbuild                          |  1 +
 arch/x86/Kconfig                         | 12 ++++++++++++
 arch/x86/coco/Makefile                   |  2 ++
 arch/x86/coco/tdx.c                      | 22 ++++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h       |  1 +
 arch/x86/include/asm/disabled-features.h |  8 +++++++-
 arch/x86/include/asm/tdx.h               | 21 +++++++++++++++++++++
 arch/x86/kernel/head64.c                 |  4 ++++
 8 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/coco/Makefile
 create mode 100644 arch/x86/coco/tdx.c
 create mode 100644 arch/x86/include/asm/tdx.h

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f384cb1a4f7a..b4861abb4386 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y += coco/
 obj-y += entry/
 
 obj-$(CONFIG_PERF_EVENTS) += events/
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 391c4cac8958..ea4190c53db6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -880,6 +880,18 @@ config ACRN_GUEST
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
+	  potential attacks from the VMM.
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
new file mode 100644
index 000000000000..b285d485a72e
--- /dev/null
+++ b/arch/x86/coco/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
new file mode 100644
index 000000000000..77c26c6b932d
--- /dev/null
+++ b/arch/x86/coco/tdx.c
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
+	if (memcmp(TDX_IDENT, sig, 12))
+		return;
+
+	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
+
+	pr_info("Guest detected\n");
+}
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5cd22090e53d..cacc8dde854b 100644
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
2.34.1

