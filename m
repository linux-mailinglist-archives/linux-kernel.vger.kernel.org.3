Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857834745E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhLNPEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:04:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:16125 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235205AbhLNPD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219677534"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="219677534"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="481987938"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2021 07:03:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3040B410; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
Subject: [PATCH 02/26] x86/tdx: Extend the cc_platform_has() API to support TDX guests
Date:   Tue, 14 Dec 2021 18:02:40 +0300
Message-Id: <20211214150304.62613-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Confidential Computing (CC) features (like string I/O unroll support,
memory encryption/decryption support, etc) are conditionally enabled
in the kernel using cc_platform_has() API. Since TDX guests also need
to use these CC features, extend cc_platform_has() API and add TDX
guest-specific CC attributes support.

Use is_tdx_guest() API to detect for the TDX guest status and return
TDX-specific CC attributes. To enable use of CC APIs in the TDX guest,
select ARCH_HAS_CC_PLATFORM in the CONFIG_INTEL_TDX_GUEST case.

This is a preparatory patch and just creates the framework for adding
TDX guest specific CC attributes.

Since is_tdx_guest() function (through cc_platform_has() API) is used in
the early boot code, disable the instrumentation flags and function
tracer. This is similar to AMD SEV and cc_platform.c.

Since intel_cc_platform_has() function only gets triggered when
is_tdx_guest() is true (valid CONFIG_INTEL_TDX_GUEST case), remove the
redundant #ifdef in intel_cc_platform_has().

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig              | 1 +
 arch/x86/kernel/Makefile      | 3 +++
 arch/x86/kernel/cc_platform.c | 9 ++++-----
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a61ac6f8821a..8e781f166030 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -877,6 +877,7 @@ config INTEL_TDX_GUEST
 	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 64f9babcfd95..8c9a9214dd34 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -22,6 +22,7 @@ CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
 CFLAGS_REMOVE_cc_platform.o = -pg
+CFLAGS_REMOVE_tdx.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
@@ -31,6 +32,7 @@ KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 KASAN_SANITIZE_sev.o					:= n
 KASAN_SANITIZE_cc_platform.o				:= n
+KASAN_SANITIZE_tdx.o					:= n
 
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
@@ -50,6 +52,7 @@ KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
+CFLAGS_tdx.o		+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index cc1ffe710dd2..e291e071aa63 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -12,14 +12,11 @@
 #include <linux/mem_encrypt.h>
 
 #include <asm/processor.h>
+#include <asm/tdx.h>
 
-static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
+static bool intel_cc_platform_has(enum cc_attr attr)
 {
-#ifdef CONFIG_INTEL_TDX_GUEST
 	return false;
-#else
-	return false;
-#endif
 }
 
 /*
@@ -67,6 +64,8 @@ bool cc_platform_has(enum cc_attr attr)
 {
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
+	else if (is_tdx_guest())
+		return intel_cc_platform_has(attr);
 
 	return false;
 }
-- 
2.32.0

