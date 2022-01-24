Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF294982D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiAXPCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:02:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:19100 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239970AbiAXPCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036542; x=1674572542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/z7OrzV1y617WdUQU00LsxqK+cIPCzyFS6bpxBGqoJM=;
  b=OHQXKjEG3fR4xObY61Ww/flHGTvL+s3Baj63c0vJjv64ivNgIVX8uyz3
   EoztkWmspa9Ndj9Mul/Ymt6pCQtyB19RtlrH0Ozjv6tl3NszOtVZdAEnI
   QxEexf06G/Irc7MZ4Em5H+0x2gH15ohOjkUm2KRk8FaHHZZnL/UwgipWG
   Qxab06q1G6aQIguLOMNBEc099D3ANvaTMAoE2lk6BQWo0gNOU2VYrqKSE
   ZGEGYtHpV9Hl3TPV0eY3Ahficd+XowcSVPNc4wjemlMp+uzxJ323gazI+
   B3HGSvnl8ziBbpdzxIGEddukx1RV+3xENgtOoRRcVpYfb9vmQEL9312Z2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233423226"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233423226"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="479104629"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2022 07:02:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5BEFA2DD; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
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
Subject: [PATCHv2 02/29] x86/tdx: Extend the cc_platform_has() API to support TDX guests
Date:   Mon, 24 Jan 2022 18:01:48 +0300
Message-Id: <20220124150215.36893-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
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

Since intel_cc_platform_has() function only gets called when
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
index 09e6744af3f8..1491f25c844e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
 	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 211d9fcdd729..67415037c33c 100644
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
index 6a6ffcd978f6..c72b3919bca9 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -13,14 +13,11 @@
 
 #include <asm/mshyperv.h>
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
@@ -76,6 +73,8 @@ bool cc_platform_has(enum cc_attr attr)
 {
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
+	else if (is_tdx_guest())
+		return intel_cc_platform_has(attr);
 
 	if (hv_is_isolation_supported())
 		return hyperv_cc_platform_has(attr);
-- 
2.34.1

