Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC34FA126
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiDIBbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbiDIBa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA1511F7B3;
        Fri,  8 Apr 2022 18:27:46 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCLyQzxs8GcSO5HFA9nS0D0i1pM8j4J5EtCby3Xnt4M=;
        b=BfxwQ9Nmvh6ucJITv46bEHrLhCqS4HEyTKajBJFRmVR2qWMZ5qvAI6cLnOxoBtQsNlMCq6
        eS2rMQii+0G5G5akLXwhWHVOzSBKkZEofatd8H7lYobbWbXyqZkc3nd3IDomgMgxglmh1a
        fJn6wPAifZRt5ed1uE7dYFMuKCG7cJsGIz2y/afwl6Vjn12DHvHmX8e9Wl977aZ7BKz6L9
        luWq8fqdtTz00CJHwd30W7+i8MXyGVpADdhMz7WthsPPhBJAQp7JnlPzMTl3JICZfA+KYJ
        DJOmk98XcKXHqWSuYMQmm2oxU8i5pFvWfec9oIrAAQWASVuVDXPG2hj+DHzwHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCLyQzxs8GcSO5HFA9nS0D0i1pM8j4J5EtCby3Xnt4M=;
        b=pUhw7rHtnPSy1nmSMRSwwQgpLAbgAQbLZt/15BbOQu543rgrjfiEtnpN+37CYZpEGV5suu
        wGbgRShd2v9znjCw==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Detect running as a TDX guest in early boot
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-2-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946766375.4207.9891279817932124985.tip-bot2@tip-bot2>
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

Commit-ID:     59bd54a84d15e9335de5b8abe7b3b9713a36b99b
Gitweb:        https://git.kernel.org/tip/59bd54a84d15e9335de5b8abe7b3b9713a36b99b
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:10 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:50 -07:00

x86/tdx: Detect running as a TDX guest in early boot

In preparation of extending cc_platform_has() API to support TDX guest,
use CPUID instruction to detect support for TDX guests in the early
boot code (via tdx_early_init()). Since copy_bootdata() is the first
user of cc_platform_has() API, detect the TDX guest status before it.

Define a synthetic feature flag (X86_FEATURE_TDX_GUEST) and set this
bit in a valid TDX guest platform.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-2-kirill.shutemov@linux.intel.com
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
index b0142e0..4ae2732 100644
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
index c1ead00..c816acf 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -4,3 +4,5 @@ KASAN_SANITIZE_core.o	:= n
 CFLAGS_core.o		+= -fno-stack-protector
 
 obj-y += core.o
+
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx/
diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
new file mode 100644
index 0000000..c929d53
--- /dev/null
+++ b/arch/x86/coco/tdx/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += tdx.o
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
new file mode 100644
index 0000000..9767447
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
index 73e643a..20df73b 100644
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
index 1231d63..b37de82 100644
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
index 0000000..ba8042c
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
index 4f5ecbb..6dff50c 100644
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
