Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADA84796CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhLQWCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:02:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:26498 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhLQWBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778511; x=1671314511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OBpDZUm4EngfnhF5Yo9KgToppXO+yZbVrmisYzFVZ8w=;
  b=jeD+ELrgGEEQDye6MYXpKMtQkZwxTbWSf5Npnp0u3wKMKIsD/FS6q8Jc
   dGxfAvICcsV65ucNThSoE0CBwuqkjeMSU1/1gr8eIJPSIAhb7dSj3kLQV
   F8+VF/N0bZflYCSp3Stit/MS5TxNMQ7l47JnfafsZ8tcxEscrEFpsZkVF
   Dg6kHTtQQa/iTfOw9FHDeXCbIQ6kQhJ1JEtqZJOVaSFGo9JNe9H55ucW9
   C1ulXO+SFDPzFsFemVBWQAfHIK9HdFTGH6BDe1QbuMGnVsDoBiuX1vkIC
   VLSjmohLur8YBMtZb8Fatr1DEa3SC7N8VOIS9OaR7zP/V0yyCUXJWqvao
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381601"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381601"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928104"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:50 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 08/11] x86/traps: Demand-populate PASID MSR via #GP
Date:   Fri, 17 Dec 2021 22:01:33 +0000
Message-Id: <20211217220136.2762116-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All tasks start with PASID state disabled. This means that the first
time they execute an ENQCMD instruction they will take a #GP fault.

Modify the #GP fault handler to check if the "mm" for the task has
already been allocated a PASID. If so, try to fix the #GP fault by
loading the IA32_PASID MSR.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Directly write IA32_PASID MSR in fixup while local IRQ is still disabled
  (Thomas)
- Move #ifdef over to CONFIG_IOMMU_SVA since it is what
  defines mm->pasid and ->pasid_activated (Dave Hansen).
- Rename try_fixup_pasid() -> try_fixup_enqcmd_gp(). This
  code really is highly specific to ENQCMD, not PASIDs (Dave Hansen).
- Add lockdep assert and comment about context (Dave Hansen).
- Re-flow the if() mess (Dave Hansen).

 arch/x86/kernel/traps.c | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c9d566dcf89a..7ef00dee35be 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
+#include <linux/ioasid.h>
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -559,6 +560,57 @@ static bool fixup_iopl_exception(struct pt_regs *regs)
 	return true;
 }
 
+/*
+ * The unprivileged ENQCMD instruction generates #GPs if the
+ * IA32_PASID MSR has not been populated.  If possible, populate
+ * the MSR from a PASID previously allocated to the mm.
+ */
+static bool try_fixup_enqcmd_gp(void)
+{
+#ifdef CONFIG_IOMMU_SVA
+	u32 pasid;
+
+	/*
+	 * MSR_IA32_PASID is managed using XSAVE.  Directly
+	 * writing to the MSR is only possible when fpregs
+	 * are valid and the fpstate is not.  This is
+	 * guaranteed when handling a userspace exception
+	 * in *before* interrupts are re-enabled.
+	 */
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Hardware without ENQCMD will not generate
+	 * #GPs that can be fixed up here.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return false;
+
+	pasid = current->mm->pasid;
+
+	/*
+	 * If the mm has not been allocated a
+	 * PASID, the #GP can not be fixed up.
+	 */
+	if (!pasid_valid(pasid))
+		return false;
+
+	/*
+	 * Did this thread already have its PASID activated?
+	 * If so, the #GP must be from something else.
+	 */
+	if (current->pasid_activated)
+		return false;
+
+	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
+	current->pasid_activated = 1;
+
+	return true;
+#else
+	return false;
+#endif
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
@@ -567,6 +619,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	unsigned long gp_addr;
 	int ret;
 
+	if (user_mode(regs) && try_fixup_enqcmd_gp())
+		return;
+
 	cond_local_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
-- 
2.34.1

