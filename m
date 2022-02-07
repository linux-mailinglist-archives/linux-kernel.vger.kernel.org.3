Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9364B4ACD00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbiBHBDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245459AbiBGXDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:03:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF2C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275010; x=1675811010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G2ko2lJpyoW8LzCkDhi+2nZvr53q38fpGk6sB2Ue41w=;
  b=lJIboQtle/aq9nhdr4qja4xr8ksiEiC18tskTCVi3qQDGfzQN4+ljJMS
   mptSYo/41KEZbS4E5pk5KKW6WFMDpL6Kd7buBHX5skx+DQLb6IT1dTY5M
   Sja6qBCHHf3LTDQFsEn3TrZQdzC8tANx7YCa2YQTa3rwQLQiiYliIltnq
   j/wAxMP4ldLYg7HX4gflDAKFyxMqkBELeX3J5igCDhIWYRwrF1RnpR6gf
   TdiZWaIlASQBACnlSBTO1/adbz9/YA8Dbc72quHRlbk+tGDouY2Enl4WG
   wyqTQTBoMUcsMU4hwaVN5E0ZU1LUUJa0URoNNEJG3Hrrx6bYUWofJVaME
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229475019"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229475019"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:03:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540324084"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:05 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
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
Subject: [PATCH v4 08/11] x86/traps: Demand-populate PASID MSR via #GP
Date:   Mon,  7 Feb 2022 15:02:51 -0800
Message-Id: <20220207230254.3342514-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207230254.3342514-1-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4:
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).

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
2.35.1

