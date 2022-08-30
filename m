Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69B55A6EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiH3VMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiH3VMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:12:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472DB86C09;
        Tue, 30 Aug 2022 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661893964; x=1693429964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DLynHZET2acG5Gj5TYndmhTuc8yNK1YXJbk/LA3IMMw=;
  b=dKJUWZJMJ6EyUlSZ+V96ViL9ihsqgLRGtn+UdfWXHlhcNlTh3aj8hS08
   kDkxWp/kQxQwpE+8SRy4RFRtTQcV17ieS3quFL68qra5s2b/ZDzJMA1W+
   ulPZnpIwSkhyjYwAFVSBrozAs2E5MXwEB2nxn7X/cAyKd7Ap0OZsQHNGH
   oYY0PfcgSG0rzoEv9s7per5iPtmi5Pay+UtV1nZLsfDGp/hKCNdZb1SbD
   KVl/rcyTgvSVtgOobnVTwcGomqKjuOg6m6nwf18tf8HOPuNAGnbYpXZiW
   Yf32rhra8TrsYogPTiX3LYW9ZFHHuWpAO693VyUqPGnAg4A/PG1VKkHYW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="278318068"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="278318068"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 14:12:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="701143474"
Received: from zhan8-mobl2.ccr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.254.103.46])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 14:12:42 -0700
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     pawan.kumar.gupta@linux.intel.com,
        antonio.gomez.iglesias@linux.intel.com,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Neelima Krishnan <neelima.krishnan@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] x86/apic: Don't disable x2APIC if locked
Date:   Tue, 30 Aug 2022 14:12:34 -0700
Message-Id: <20220830211235.2029116-1-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APIC supports two modes, legacy APIC (or xAPIC), and Extended APIC
(or x2APIC).  X2APIC mode is mostly compatible with legacy APIC, but
it disables the memory-mapped APIC interface in favor of one that uses
MSRs.  The APIC mode is controlled by the EXT bit in the APIC MSR.

The MMIO/xAPIC interface has some problems, most notably the APIC LEAK
[1].  This bug allows an attacker to use the APIC MMIO interface to
extract data from the SGX enclave.

Introduce support for a new feature that will allow the BIOS to lock
the APIC in x2APIC mode.  If the APIC is locked in x2APIC mode and the
kernel tries to disable the APIC or revert to legacy APIC mode a GP
fault will occur.

Introduce support for a new MSR (IA32_XAPIC_DISABLE_STATUS) and handle
the new locked mode when the LEGACY_XAPIC_DISABLED bit is set by
preventing the kernel from trying to disable the x2APIC.

On platforms with the IA32_XAPIC_DISABLE_STATUS MSR, if SGX or TDX are
enabled the LEGACY_XAPIC_DISABLED will be set by the BIOS.  If
legacy APIC is required, then it SGX and TDX need to be disabled in the
BIOS.

[1]: https://aepicleak.com/aepicleak.pdf

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
V1 -> V2:
	Updated commit message (Dave)
	Added note to nox2apic documentation and Kconfig (Dave)
	Made SGX depend on X2APIC (TGLX)
	Added Tested-by
	Added Dave's Ack

[v1] https://lore.kernel.org/lkml/20220809234000.783284-1-daniel.sneddon@linux.intel.com/

 .../admin-guide/kernel-parameters.txt         |  4 ++
 arch/x86/Kconfig                              |  7 ++-
 arch/x86/include/asm/cpu.h                    |  2 +
 arch/x86/include/asm/msr-index.h              | 13 ++++++
 arch/x86/kernel/apic/apic.c                   | 44 +++++++++++++++++--
 5 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 54a9756f2dad..a3bf1707dcd3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3804,6 +3804,10 @@
 
 	nox2apic	[X86-64,APIC] Do not enable x2APIC mode.
 
+			NOTE: this parameter will be ignored on systems with the
+			LEGACY_XAPIC_DISABLED bit set in the
+			IA32_XAPIC_DISABLE_STATUS MSR.
+
 	nps_mtm_hs_ctr=	[KNL,ARC]
 			This parameter sets the maximum duration, in
 			cycles, each HW thread of the CTOP can run
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..159c025ebb03 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -448,6 +448,11 @@ config X86_X2APIC
 	  This allows 32-bit apic IDs (so it can support very large systems),
 	  and accesses the local apic via MSRs not via mmio.
 
+	  Some Intel systems circa 2022 and later are locked into x2APIC mode
+	  and can not fall back to the legacy APIC modes if SGX or TDX are
+	  enabled in the BIOS.  They will be unable to boot without enabling
+	  this option.
+
 	  If you don't know what to do here, say N.
 
 config X86_MPPARSE
@@ -1919,7 +1924,7 @@ endchoice
 
 config X86_SGX
 	bool "Software Guard eXtensions (SGX)"
-	depends on X86_64 && CPU_SUP_INTEL
+	depends on X86_64 && CPU_SUP_INTEL && X86_X2APIC
 	depends on CRYPTO=y
 	depends on CRYPTO_SHA256=y
 	select SRCU
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 8cbf623f0ecf..b472ef76826a 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -94,4 +94,6 @@ static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 	return p1 & p2;
 }
 
+extern u64 x86_read_arch_cap_msr(void);
+
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6674bdb096f3..1e086b37a307 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -155,6 +155,11 @@
 						 * Return Stack Buffer Predictions.
 						 */
 
+#define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
+						 * IA32_XAPIC_DISABLE_STATUS MSR
+						 * supported
+						 */
+
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
 						 * Writeback and invalidate the
@@ -1054,4 +1059,12 @@
 #define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
 
+/* x2APIC locked status */
+#define MSR_IA32_XAPIC_DISABLE_STATUS	0xBD
+#define LEGACY_XAPIC_DISABLED		BIT(0) /*
+						* x2APIC mode is locked and
+						* disabling x2APIC will cause
+						* a #GP
+						*/
+
 #endif /* _ASM_X86_MSR_INDEX_H */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6d303d1d276c..c6876d3ea4b1 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -61,6 +61,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/irq_regs.h>
+#include <asm/cpu.h>
 
 unsigned int num_processors;
 
@@ -1751,11 +1752,26 @@ EXPORT_SYMBOL_GPL(x2apic_mode);
 
 enum {
 	X2APIC_OFF,
-	X2APIC_ON,
 	X2APIC_DISABLED,
+	/* All states below here have X2APIC enabled */
+	X2APIC_ON,
+	X2APIC_ON_LOCKED
 };
 static int x2apic_state;
 
+static bool x2apic_hw_locked(void)
+{
+	u64 ia32_cap;
+	u64 msr;
+
+	ia32_cap = x86_read_arch_cap_msr();
+	if (ia32_cap & ARCH_CAP_XAPIC_DISABLE) {
+		rdmsrl(MSR_IA32_XAPIC_DISABLE_STATUS, msr);
+		return (msr & LEGACY_XAPIC_DISABLED);
+	}
+	return false;
+}
+
 static void __x2apic_disable(void)
 {
 	u64 msr;
@@ -1793,6 +1809,10 @@ static int __init setup_nox2apic(char *str)
 				apicid);
 			return 0;
 		}
+		if (x2apic_hw_locked()) {
+			pr_warn("APIC locked in x2apic mode, can't disable\n");
+			return 0;
+		}
 		pr_warn("x2apic already enabled.\n");
 		__x2apic_disable();
 	}
@@ -1807,10 +1827,18 @@ early_param("nox2apic", setup_nox2apic);
 void x2apic_setup(void)
 {
 	/*
-	 * If x2apic is not in ON state, disable it if already enabled
+	 * Try to make the AP's APIC state match that of the BSP,  but if the
+	 * BSP is unlocked and the AP is locked then there is a state mismatch.
+	 * Warn about the mismatch in case a GP fault occurs due to a locked AP
+	 * trying to be turned off.
+	 */
+	if (x2apic_state != X2APIC_ON_LOCKED && x2apic_hw_locked())
+		pr_warn("x2apic lock mismatch between BSP and AP.\n");
+	/*
+	 * If x2apic is not in ON or LOCKED state, disable it if already enabled
 	 * from BIOS.
 	 */
-	if (x2apic_state != X2APIC_ON) {
+	if (x2apic_state < X2APIC_ON) {
 		__x2apic_disable();
 		return;
 	}
@@ -1831,6 +1859,11 @@ static __init void x2apic_disable(void)
 	if (x2apic_id >= 255)
 		panic("Cannot disable x2apic, id: %08x\n", x2apic_id);
 
+	if (x2apic_hw_locked()) {
+		pr_warn("Cannot disable locked x2apic, id: %08x\n", x2apic_id);
+		return;
+	}
+
 	__x2apic_disable();
 	register_lapic_address(mp_lapic_addr);
 }
@@ -1889,7 +1922,10 @@ void __init check_x2apic(void)
 	if (x2apic_enabled()) {
 		pr_info("x2apic: enabled by BIOS, switching to x2apic ops\n");
 		x2apic_mode = 1;
-		x2apic_state = X2APIC_ON;
+		if (x2apic_hw_locked())
+			x2apic_state = X2APIC_ON_LOCKED;
+		else
+			x2apic_state = X2APIC_ON;
 	} else if (!boot_cpu_has(X86_FEATURE_X2APIC)) {
 		x2apic_state = X2APIC_DISABLED;
 	}
-- 
2.25.1

