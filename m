Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D424A951E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357008AbiBDIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356405AbiBDIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:30:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0452AC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:30:30 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7856F1EC06BB;
        Fri,  4 Feb 2022 09:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643963428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Wm/vo/0N1xgCjuTyNPDV+8iEIsMJC/6KGhKiCjg6tE=;
        b=R8YxpdFuFS+gr1xOASUtnb+bod5Nt6rb2ekO9B7cNlmnruo4zBoWGcLPfEfr+otGcNFBPm
        ThHdMQHZUGOXnYkLmt7HgG6hOcG9il3MQx3pYeLnVxoj4vZbS6xWwpjnHF1e0+C18hCjf2
        RrRVwU2c9wU543cf+ZyW6vAE7s66Ap8=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] x86/mce: Use arch atomic and bit helpers
Date:   Fri,  4 Feb 2022 09:30:15 +0100
Message-Id: <20220204083015.17317-4-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220204083015.17317-1-bp@alien8.de>
References: <20220204083015.17317-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The arch helpers do not have explicit KASAN instrumentation. Use them in
noinstr code.

Inline a couple more functions with single call sites, while at it:

mce_severity_amd_smca() has a single call-site which is noinstr so force
the inlining and fix:

  vmlinux.o: warning: objtool: mce_severity_amd.constprop.0()+0xca: call to \
	  mce_severity_amd_smca() leaves .noinstr.text section

Always inline mca_msr_reg():

   text    data     bss     dec     hex filename
16065240        128031326       36405368        180501934       ac23dae vmlinux.before
16065240        128031294       36405368        180501902       ac23d8e vmlinux.after

and mce_no_way_out() as the latter one is used only once, to fix:

  vmlinux.o: warning: objtool: mce_read_aux()+0x53: call to mca_msr_reg() leaves .noinstr.text section
  vmlinux.o: warning: objtool: do_machine_check()+0xc9: call to mce_no_way_out() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c     | 58 ++++++++++--------------------
 arch/x86/kernel/cpu/mce/internal.h | 23 ++++++++++--
 arch/x86/kernel/cpu/mce/severity.c |  2 +-
 3 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..0e7147430ec0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -173,27 +173,6 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
-u32 mca_msr_reg(int bank, enum mca_msr reg)
-{
-	if (mce_flags.smca) {
-		switch (reg) {
-		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
-		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
-		case MCA_MISC:	 return MSR_AMD64_SMCA_MCx_MISC(bank);
-		case MCA_STATUS: return MSR_AMD64_SMCA_MCx_STATUS(bank);
-		}
-	}
-
-	switch (reg) {
-	case MCA_CTL:	 return MSR_IA32_MCx_CTL(bank);
-	case MCA_ADDR:	 return MSR_IA32_MCx_ADDR(bank);
-	case MCA_MISC:	 return MSR_IA32_MCx_MISC(bank);
-	case MCA_STATUS: return MSR_IA32_MCx_STATUS(bank);
-	}
-
-	return 0;
-}
-
 static void __print_mce(struct mce *m)
 {
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
@@ -814,7 +793,8 @@ EXPORT_SYMBOL_GPL(machine_check_poll);
  * the severity assessment code. Pretend that EIPV was set, and take the
  * ip/cs values from the pt_regs that mce_gather_info() ignored earlier.
  */
-static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
+static __always_inline void
+quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
 {
 	if (bank != 0)
 		return;
@@ -838,8 +818,8 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
  */
-static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
-			  struct pt_regs *regs)
+static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
+					  struct pt_regs *regs)
 {
 	char *tmp = *msg;
 	int i;
@@ -849,7 +829,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
-		__set_bit(i, validp);
+		arch___set_bit(i, validp);
 		if (mce_flags.snb_ifu_quirk)
 			quirk_sandybridge_ifu(i, m, regs);
 
@@ -1015,13 +995,13 @@ static noinstr int mce_start(int *no_way_out)
 	if (!timeout)
 		return ret;
 
-	atomic_add(*no_way_out, &global_nwo);
+	arch_atomic_add(*no_way_out, &global_nwo);
 	/*
 	 * Rely on the implied barrier below, such that global_nwo
 	 * is updated before mce_callin.
 	 */
-	order = atomic_inc_return(&mce_callin);
-	cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
+	order = arch_atomic_inc_return(&mce_callin);
+	arch_cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
 
 	/* Enable instrumentation around calls to external facilities */
 	instrumentation_begin();
@@ -1029,10 +1009,10 @@ static noinstr int mce_start(int *no_way_out)
 	/*
 	 * Wait for everyone.
 	 */
-	while (atomic_read(&mce_callin) != num_online_cpus()) {
+	while (arch_atomic_read(&mce_callin) != num_online_cpus()) {
 		if (mce_timed_out(&timeout,
 				  "Timeout: Not all CPUs entered broadcast exception handler")) {
-			atomic_set(&global_nwo, 0);
+			arch_atomic_set(&global_nwo, 0);
 			goto out;
 		}
 		ndelay(SPINUNIT);
@@ -1047,7 +1027,7 @@ static noinstr int mce_start(int *no_way_out)
 		/*
 		 * Monarch: Starts executing now, the others wait.
 		 */
-		atomic_set(&mce_executing, 1);
+		arch_atomic_set(&mce_executing, 1);
 	} else {
 		/*
 		 * Subject: Now start the scanning loop one by one in
@@ -1055,10 +1035,10 @@ static noinstr int mce_start(int *no_way_out)
 		 * This way when there are any shared banks it will be
 		 * only seen by one CPU before cleared, avoiding duplicates.
 		 */
-		while (atomic_read(&mce_executing) < order) {
+		while (arch_atomic_read(&mce_executing) < order) {
 			if (mce_timed_out(&timeout,
 					  "Timeout: Subject CPUs unable to finish machine check processing")) {
-				atomic_set(&global_nwo, 0);
+				arch_atomic_set(&global_nwo, 0);
 				goto out;
 			}
 			ndelay(SPINUNIT);
@@ -1068,7 +1048,7 @@ static noinstr int mce_start(int *no_way_out)
 	/*
 	 * Cache the global no_way_out state.
 	 */
-	*no_way_out = atomic_read(&global_nwo);
+	*no_way_out = arch_atomic_read(&global_nwo);
 
 	ret = order;
 
@@ -1153,12 +1133,12 @@ static noinstr int mce_end(int order)
 	return ret;
 }
 
-static void mce_clear_state(unsigned long *toclear)
+static __always_inline void mce_clear_state(unsigned long *toclear)
 {
 	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		if (test_bit(i, toclear))
+		if (arch_test_bit(i, toclear))
 			mce_wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 }
@@ -1208,8 +1188,8 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 	int severity, i, taint = 0;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		__clear_bit(i, toclear);
-		if (!test_bit(i, valid_banks))
+		arch___clear_bit(i, toclear);
+		if (!arch_test_bit(i, valid_banks))
 			continue;
 
 		if (!mce_banks[i].ctl)
@@ -1244,7 +1224,7 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 		     severity == MCE_UCNA_SEVERITY) && !no_way_out)
 			continue;
 
-		__set_bit(i, toclear);
+		arch___set_bit(i, toclear);
 
 		/* Machine check event was not enabled. Clear, but ignore. */
 		if (severity == MCE_NO_SEVERITY)
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 52c633950b38..a04b61e27827 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -182,8 +182,6 @@ enum mca_msr {
 	MCA_MISC,
 };
 
-u32 mca_msr_reg(int bank, enum mca_msr reg);
-
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
 
@@ -209,4 +207,25 @@ static inline void winchip_machine_check(struct pt_regs *regs) {}
 
 noinstr u64 mce_rdmsrl(u32 msr);
 
+static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
+{
+	if (mce_flags.smca) {
+		switch (reg) {
+		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
+		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
+		case MCA_MISC:	 return MSR_AMD64_SMCA_MCx_MISC(bank);
+		case MCA_STATUS: return MSR_AMD64_SMCA_MCx_STATUS(bank);
+		}
+	}
+
+	switch (reg) {
+	case MCA_CTL:	 return MSR_IA32_MCx_CTL(bank);
+	case MCA_ADDR:	 return MSR_IA32_MCx_ADDR(bank);
+	case MCA_MISC:	 return MSR_IA32_MCx_MISC(bank);
+	case MCA_STATUS: return MSR_IA32_MCx_STATUS(bank);
+	}
+
+	return 0;
+}
+
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 7aa2bda93cbb..ca0d775346fb 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -301,7 +301,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	}
 }
 
-static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
+static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
 {
 	u64 mcx_cfg;
 
-- 
2.29.2

