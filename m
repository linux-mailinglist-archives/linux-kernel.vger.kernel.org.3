Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47924A52C8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiAaXBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:01:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:53702 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235389AbiAaXBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643670079; x=1675206079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=quHtX6b2lWq0OCMDIPUYUvGCuDxHqCPbaufrchm5fIA=;
  b=JYPlpCiosiRymR2nVfeijrN8GsXhw6f+iUp2jCvpNOHAFhHz5cPBshTH
   kTyksJmx6ekJvHKCUk4cZiNnZt9AJrPbBLOMX0hqa/zpPUJim3/gfL+L+
   DgYlKqJ2qGukiDwdpwK2rUw4ZBNnRRtgtAfqcwQAS5Rl1kE+QGWUWhrYu
   a6Y2gzmpufTnRFn2n+jM7Nd2ebPNB3fR8C0A5G1EHgIYZal2Rx15Ojgvw
   //qNN/j9TvUU7pvQXy+YGxoC0fkKuj5L+5E67oiaV19wZocM31WLPvKU/
   W2bhOkL18vZzDYr8WAMVewQBl8ZanjYJHTCs5jJbqCSE7dRBSmvrARw60
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247521224"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247521224"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="522831337"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:18 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 1/5] x86/cpu: Merge Intel and AMD ppin_init() functions
Date:   Mon, 31 Jan 2022 15:01:07 -0800
Message-Id: <20220131230111.2004669-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220131230111.2004669-1-tony.luck@intel.com>
References: <20220121174743.1875294-1-tony.luck@intel.com>
 <20220131230111.2004669-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to decide whether a system supports the PPIN (Protected
Processor Inventory Number) MSR was cloned from the Intel
implementation. Apart from the X86_FEATURE bit and the MSR numbers it is
identical.

Merge the two functions into common x86 code, but use x86_match_cpu()
instead of the switch (c->x86_model) that was used by the old Intel
code.

No functional change.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/amd.c       | 30 -------------
 arch/x86/kernel/cpu/common.c    | 74 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/intel.c | 42 -------------------
 3 files changed, 74 insertions(+), 72 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 4edb6f0f628c..bad0fa4c1779 100644
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
index 7b8382c11788..b0bd8a6b5beb 100644
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
index baafbb37be67..95275a5e57e0 100644
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
 
-- 
2.31.1

