Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC524CA803
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242940AbiCBO24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242872AbiCBO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:28:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6B121815
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231281; x=1677767281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnDahWq3F75kxQHu5qsHb1NDho9J16nOjdVGdB1wIqY=;
  b=Hz0ck8O/Ya+S6oiVweWUPpp1EgbxfElZqo09b8McYx/HNXkvMc1D6/+E
   Y3/P4czWwezsrbFqd8hqOEjX48frYmGuJHOBP35+mHu62FdWK+/hmqGHj
   oGDNUGl6b/JEO0MWCcVsyidMMf+laXRKWHDf4SF5IMIjDvs7D93SsoCw5
   ww4gvqPTVe8p7SK5HjG0paFaXDp5/5NJ2PNWSs6rAYqysA6uDTd/GgNa2
   7g0S+Br/1WL/dSOSCqe/4P8Ob/YUZ/ET1I0n7FzvpTNLLaVxc5LfqqVsH
   MhYya5KZPS/dy8BSYVpQQJXuxZp5QawuT46gp+1lfkIri1ZxCT6mE0fOR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233376428"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="233376428"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="511019642"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 06:27:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BFA5C93; Wed,  2 Mar 2022 16:28:11 +0200 (EET)
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
Subject: [PATCHv5 01/30] x86/tdx: Detect running as a TDX guest in early boot
Date:   Wed,  2 Mar 2022 17:27:37 +0300
Message-Id: <20220302142806.51844-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/Kconfig                         | 12 ++++++++++++
 arch/x86/coco/Makefile                   |  2 ++
 arch/x86/coco/tdx.c                      | 23 +++++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h       |  1 +
 arch/x86/include/asm/disabled-features.h |  8 +++++++-
 arch/x86/include/asm/tdx.h               | 21 +++++++++++++++++++++
 arch/x86/kernel/head64.c                 |  4 ++++
 7 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/coco/tdx.c
 create mode 100644 arch/x86/include/asm/tdx.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 57a4e0285a80..c346d66b51fc 100644
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
+	  some attacks from the VMM.
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
index c1ead00017a7..32f4c6e6f199 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -4,3 +4,5 @@ KASAN_SANITIZE_core.o	:= n
 CFLAGS_core.o		+= -fno-stack-protector
 
 obj-y += core.o
+
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
new file mode 100644
index 000000000000..00898e3eb77f
--- /dev/null
+++ b/arch/x86/coco/tdx.c
@@ -0,0 +1,23 @@
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
+	BUILD_BUG_ON(sizeof(sig) != sizeof(TDX_IDENT) - 1);
+	if (memcmp(TDX_IDENT, sig, sizeof(sig)))
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

