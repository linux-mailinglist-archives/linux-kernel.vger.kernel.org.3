Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9F58E3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiHIXkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiHIXkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:40:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2957FE41
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660088405; x=1691624405;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PTqrAIcpv0GfYknHCGQZmOiAGAIDjc6DcU9d4RdwYY0=;
  b=TJ2ShycVW2M9IEhSOKUs2SEH5DFv44AzAdHQ50GzIgmv3l/lGa6vkRhy
   PVoN2vCAndiSmBqP/W4ZttS3wOe0TmqDThFExAx7wpM0DUmdc8hDKEgl8
   ulwiD2p87ELf8cVRboKSmnkiqehht+0KNBQZPXUsrw+yZjn1C9GW8ZaD9
   5bBEIAjfAOTqUwpuPPtEb4BYyrdMBzypGqdgY7VVntpOWk+EY/R9gYQAC
   J923mD+PEr5qv3T0VUUcZr3LpOWZIEqFsfx5EGzT8Kdg/a8VlzW177T1d
   cIvuTmQTog7nvqeqRTAXZo1Uu2ooSgB1cfxN8dnOnE3szLtK2hx5WrIIu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="277895582"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="277895582"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 16:40:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="731306637"
Received: from aihernan-mobl1.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.212.107.39])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 16:40:04 -0700
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/apic: Don't disable x2APIC if locked
Date:   Tue,  9 Aug 2022 16:40:00 -0700
Message-Id: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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

Introduce support for a new feature that will allow the BIOS to lock
the APIC in x2APIC mode.  If the APIC is locked in x2APIC mode and the
kernel tries to disable the APIC or revert to legacy APIC mode a GP
fault will occur.

Introduce support for a new MSR (IA32_XAPIC_DISABLE_STATUS) and handle the
new locked mode when the LEGACY_XAPIC_DISABLED bit is set.

If the LEGACY_XAPIC_DISABLED is set, prevent the kernel
from trying to disable it.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 arch/x86/include/asm/cpu.h       |  2 ++
 arch/x86/include/asm/msr-index.h | 13 ++++++++++
 arch/x86/kernel/apic/apic.c      | 44 +++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 4 deletions(-)

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
index 6d303d1d276c..cb9aab893022 100644
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
+			pr_warn("APIC locked in x2apic mode, can't disable");
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
+		pr_warn("x2apic lock mismatch between BSP and AP.");
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

