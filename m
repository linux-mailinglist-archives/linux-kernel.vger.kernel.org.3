Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3E4A6BFB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 07:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbiBBGxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 01:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbiBBGwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DACC06176F;
        Tue,  1 Feb 2022 22:31:18 -0800 (PST)
Date:   Wed, 02 Feb 2022 06:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643783476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4vU6gabHd1ocOg84fSAEe1CJwG1Qhq4TzEBgwvyT40=;
        b=YvWXSzmCCdxRXanVFk+tABAFWKsbhqySZ5t+yW1XmtLe8a/vBy3YxMv27DAcsJFlUMGqdu
        at8SuvGn02Q3FSM5Xt+ygutFrsHu9i/O/cl5aT5B+n1qJdyqHSh/HYxE9a3pvOtdTz+oW9
        PoLtgnmN67bFYmvNCqjW5VOGEtKYx/OkAZAIqYEaw7PdM5U1Hai+hFiLsFUc859QELny2x
        QSS0ayu1c7KiYqbgt8rEQWCMk+Pb2RYQqNDoeh9k6Hm0r3B49KraY7HQVEV+Ygn5iGQVLv
        iUHIAsIhTSPOIRCtr0WLIPXWO6yKs61C4zPn/8GOwXbrlGPY5TeYWp8CdHGcOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643783476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4vU6gabHd1ocOg84fSAEe1CJwG1Qhq4TzEBgwvyT40=;
        b=Ph4Qsc61UYuHRfglnB5ScmYswjsWmGaXPUJ+uDDzQA9bh85uWQ94851+pJttUBYVg4LiI2
        o+lImeEpHgZB1JDA==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Merge Intel and AMD ppin_init() functions
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220131230111.2004669-2-tony.luck@intel.com>
References: <20220131230111.2004669-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <164378347590.16921.3765101452089124681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0dcab41d3487acadf64d0667398e032341bd9918
Gitweb:        https://git.kernel.org/tip/0dcab41d3487acadf64d0667398e032341bd9918
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 31 Jan 2022 15:01:07 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Feb 2022 12:56:23 +01:00

x86/cpu: Merge Intel and AMD ppin_init() functions

The code to decide whether a system supports the PPIN (Protected
Processor Inventory Number) MSR was cloned from the Intel
implementation. Apart from the X86_FEATURE bit and the MSR numbers it is
identical.

Merge the two functions into common x86 code, but use x86_match_cpu()
instead of the switch (c->x86_model) that was used by the old Intel
code.

No functional change.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220131230111.2004669-2-tony.luck@intel.com
---
 arch/x86/kernel/cpu/amd.c       | 30 +-------------
 arch/x86/kernel/cpu/common.c    | 74 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mce/intel.c | 42 +------------------
 3 files changed, 74 insertions(+), 72 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 4edb6f0..bad0fa4 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -394,35 +394,6 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
 }
 
-static void amd_detect_ppin(struct cpuinfo_x86 *c)
-{
-	unsigned long long val;
-
-	if (!cpu_has(c, X86_FEATURE_AMD_PPIN))
-		return;
-
-	/* When PPIN is defined in CPUID, still need to check PPIN_CTL MSR */
-	if (rdmsrl_safe(MSR_AMD_PPIN_CTL, &val))
-		goto clear_ppin;
-
-	/* PPIN is locked in disabled mode, clear feature bit */
-	if ((val & 3UL) == 1UL)
-		goto clear_ppin;
-
-	/* If PPIN is disabled, try to enable it */
-	if (!(val & 2UL)) {
-		wrmsrl_safe(MSR_AMD_PPIN_CTL,  val | 2UL);
-		rdmsrl_safe(MSR_AMD_PPIN_CTL, &val);
-	}
-
-	/* If PPIN_EN bit is 1, return from here; otherwise fall through */
-	if (val & 2UL)
-		return;
-
-clear_ppin:
-	clear_cpu_cap(c, X86_FEATURE_AMD_PPIN);
-}
-
 u32 amd_get_nodes_per_socket(void)
 {
 	return nodes_per_socket;
@@ -947,7 +918,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	amd_detect_cmp(c);
 	amd_get_topology(c);
 	srat_detect_node(c);
-	amd_detect_ppin(c);
 
 	init_amd_cacheinfo(c);
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7b8382c..b0bd8a6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -88,6 +88,78 @@ EXPORT_SYMBOL_GPL(get_llc_id);
 /* L2 cache ID of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
 
+static struct ppin_info {
+	int	feature;
+	int	msr_ppin_ctl;
+} ppin_info[] = {
+	[X86_VENDOR_INTEL] = {
+		.feature = X86_FEATURE_INTEL_PPIN,
+		.msr_ppin_ctl = MSR_PPIN_CTL,
+	},
+	[X86_VENDOR_AMD] = {
+		.feature = X86_FEATURE_AMD_PPIN,
+		.msr_ppin_ctl = MSR_AMD_PPIN_CTL,
+	},
+};
+
+static const struct x86_cpu_id ppin_cpuids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AMD_PPIN, &ppin_info[X86_VENDOR_AMD]),
+
+	/* Legacy models without CPUID enumeration */
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X, &ppin_info[X86_VENDOR_INTEL]),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X, &ppin_info[X86_VENDOR_INTEL]),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D, &ppin_info[X86_VENDOR_INTEL]),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, &ppin_info[X86_VENDOR_INTEL]),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, &ppin_info[X86_VENDOR_INTEL]),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, &ppin_info[X86_VENDOR_INTEL]),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D, &ppin_info[X86_VENDOR_INTEL]),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, &ppin_info[X86_VENDOR_INTEL]),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL, &ppin_info[X86_VENDOR_INTEL]),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM, &ppin_info[X86_VENDOR_INTEL]),
+
+	{}
+};
+
+static void ppin_init(struct cpuinfo_x86 *c)
+{
+	const struct x86_cpu_id *id;
+	unsigned long long val;
+	struct ppin_info *info;
+
+	id = x86_match_cpu(ppin_cpuids);
+	if (!id)
+		return;
+
+	/*
+	 * Testing the presence of the MSR is not enough. Need to check
+	 * that the PPIN_CTL allows reading of the PPIN.
+	 */
+	info = (struct ppin_info *)id->driver_data;
+
+	if (rdmsrl_safe(info->msr_ppin_ctl, &val))
+		goto clear_ppin;
+
+	if ((val & 3UL) == 1UL) {
+		/* PPIN locked in disabled mode */
+		goto clear_ppin;
+	}
+
+	/* If PPIN is disabled, try to enable */
+	if (!(val & 2UL)) {
+		wrmsrl_safe(info->msr_ppin_ctl,  val | 2UL);
+		rdmsrl_safe(info->msr_ppin_ctl, &val);
+	}
+
+	/* Is the enable bit set? */
+	if (val & 2UL) {
+		set_cpu_cap(c, info->feature);
+		return;
+	}
+
+clear_ppin:
+	clear_cpu_cap(c, info->feature);
+}
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
@@ -1655,6 +1727,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 			c->x86_capability[i] |= boot_cpu_data.x86_capability[i];
 	}
 
+	ppin_init(c);
+
 	/* Init Machine Check Exception if available. */
 	mcheck_cpu_init(c);
 
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index baafbb3..95275a5 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -470,47 +470,6 @@ void intel_clear_lmce(void)
 	wrmsrl(MSR_IA32_MCG_EXT_CTL, val);
 }
 
-static void intel_ppin_init(struct cpuinfo_x86 *c)
-{
-	unsigned long long val;
-
-	/*
-	 * Even if testing the presence of the MSR would be enough, we don't
-	 * want to risk the situation where other models reuse this MSR for
-	 * other purposes.
-	 */
-	switch (c->x86_model) {
-	case INTEL_FAM6_IVYBRIDGE_X:
-	case INTEL_FAM6_HASWELL_X:
-	case INTEL_FAM6_BROADWELL_D:
-	case INTEL_FAM6_BROADWELL_X:
-	case INTEL_FAM6_SKYLAKE_X:
-	case INTEL_FAM6_ICELAKE_X:
-	case INTEL_FAM6_ICELAKE_D:
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
-	case INTEL_FAM6_XEON_PHI_KNL:
-	case INTEL_FAM6_XEON_PHI_KNM:
-
-		if (rdmsrl_safe(MSR_PPIN_CTL, &val))
-			return;
-
-		if ((val & 3UL) == 1UL) {
-			/* PPIN locked in disabled mode */
-			return;
-		}
-
-		/* If PPIN is disabled, try to enable */
-		if (!(val & 2UL)) {
-			wrmsrl_safe(MSR_PPIN_CTL,  val | 2UL);
-			rdmsrl_safe(MSR_PPIN_CTL, &val);
-		}
-
-		/* Is the enable bit set? */
-		if (val & 2UL)
-			set_cpu_cap(c, X86_FEATURE_INTEL_PPIN);
-	}
-}
-
 /*
  * Enable additional error logs from the integrated
  * memory controller on processors that support this.
@@ -535,7 +494,6 @@ void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
 	intel_init_cmci();
 	intel_init_lmce();
-	intel_ppin_init(c);
 	intel_imc_init(c);
 }
 
