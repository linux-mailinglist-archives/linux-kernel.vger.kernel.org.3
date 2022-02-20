Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7AC4BCF3E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiBTPCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:02:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244057AbiBTPCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:02:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1234F25F8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645369311; x=1676905311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wmbo5gZ4hc5N3K1MCn1HX8gJC8K9lVZ9oVr8N6yehHg=;
  b=IKtgR7PRC2v9qxwtMEhtX/hFT6a/VzAdl5F4QzgsmFfmaYFGYgZ1qndS
   /DT78PNilqe7H15a98olLOnEPxpUhn69qHIJiAykNFPfSr4LRG03DCzGF
   WXi4A+c+U3eihR7cJsgW2qmhsrzNP3IzuVaa+DYXphYcFj8S+BSnogBjU
   HFVM21NgN2lfDmGAHaRi09DAgLuuzIdUquuyWV6lD/OknrfgMtc8xY3AJ
   JfpTyC98VObGtOBA2zzxGcZBXkXB/k1hRdmXhutqO26UjVyiBeSMC1X9t
   9v4rF5JE8BTIf2s/vYQNSxgCEgIY1aN2hqeZJ6bFwDmS83Z/+ZAia6cXu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="251563098"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="251563098"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 07:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="627118702"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Feb 2022 07:01:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E425C12C; Sun, 20 Feb 2022 17:01:59 +0200 (EET)
Date:   Sun, 20 Feb 2022 18:01:59 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 03/32] x86/tdx: Detect running as a TDX guest in early
 boot
Message-ID: <20220220150159.l6agp4yt2f3hk4fw@black.fi.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-4-kirill.shutemov@linux.intel.com>
 <5252a906-41e7-ec92-3b99-4a8d5cff4f0f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5252a906-41e7-ec92-3b99-4a8d5cff4f0f@intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:07:11PM -0800, Dave Hansen wrote:
> > Since cc_plaform_has() API will be used frequently across the boot
> > code, instead of repeatedly detecting the TDX guest status using the
> > CPUID instruction, detect once and cache the result.
> 
> Isn't this a remnant of an old implementation where there was a separate
> 'tdx_enabled' variable in addition to X86_FEATURE_TDX_GUEST?
> 
> Does this "caching" refer to X86_FEATURE_TDX_GUEST or the old thing?

Yeah, sorry. I failed to update commit message properly.

Updated patch is below.

From 0e824103625186b5001bae2c8f5767bfc7deb626 Mon Sep 17 00:00:00 2001
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Fri, 8 Oct 2021 16:03:03 -0700
Subject: [PATCH] x86/tdx: Detect running as a TDX guest in early boot

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
index 391c4cac8958..8dc575f3aba1 100644
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
 Kirill A. Shutemov
