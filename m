Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB6575603
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbiGNTwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGNTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:52:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACED52894;
        Thu, 14 Jul 2022 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657828363; x=1689364363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8zvHnrEhJCvm8EcU2wOLPua+0Ne80byROhMMiOLNSEc=;
  b=fAYg5QY8NaFXNXQWDCvYs52xXb90RWlWN8TkoQ7texZuZoRRCtM5Ib/z
   KxkigdUID3Sva49wBdmMO2fPdcs4HKoR+IHJhfpsuwIJ5kmyBIv3rn5r8
   zRkex9kToI1UbBo+AuZqZ2qb3NcHny43BFx7ukd2AlBSHfqcizFidc93C
   AkYXFUD0POOsc0PTy/iYzYxByE4SrxOdz3lAef5IAbSbQG7mlN2dKIiFs
   ErUPLlsJl0vfrUPwtzew5Vu0zNdlb0o17x4p/53pLpvzRaJs3G4NQ9oSY
   4LHKlmvHg72Wx6uxjT/6tdlWQUULjYftUqOs0hqWwcK+2Z6qTvgs+of7t
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="285639553"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="285639553"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 12:52:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="663916188"
Received: from vyvo-mobl2.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.254.65.221])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 12:52:42 -0700
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc:     pawan.kumar.gupta@linux.intel.com,
        antonio.gomez.iglesias@linux.intel.com,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] x86/speculation: Add BHI_DIS support
Date:   Thu, 14 Jul 2022 12:52:35 -0700
Message-Id: <20220714195236.9311-1-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Branch History Injection (BHI) attacks can be mitigated using the
BHI_DIS_S indirect predictor control bit located in MSR_IA32_SPEC_CTRL
register. Set BHI_DIS in MSR_IA32_SPC_CTRL to prevent predicted
targets of indirect branches executed in CPL0, CPL1, or CPL2 from
being selected based on branch history from branches executed in CPL3.
Support for this feature is enumerated by CPUID.7.2.EDX[BHI_CTRL] (bit 4).

Users wanting BHI protection can specify spectre_v2=eibrs,bhi_dis to
enable hardware BHI protections.  On platforms where BHI protections
are not available in the hardware revert to eibrs,retpoline
mitigations.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 Documentation/admin-guide/hw-vuln/spectre.rst |  5 ++
 .../admin-guide/kernel-parameters.txt         |  2 +
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  8 +++
 arch/x86/include/asm/nospec-branch.h          |  1 +
 arch/x86/kernel/cpu/bugs.c                    | 53 +++++++++++++++++--
 arch/x86/kernel/cpu/scattered.c               |  1 +
 tools/arch/x86/include/asm/msr-index.h        |  8 +++
 8 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 9e9556826450..cde2f860a7b7 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -605,6 +605,11 @@ kernel command line.
                 eibrs                   enhanced IBRS
                 eibrs,retpoline         enhanced IBRS + Retpolines
                 eibrs,lfence            enhanced IBRS + LFENCE
+                eibrs,bhi_dis		enhanced IBRS + Hardware BHI prevention
+
+                Specifying eibrs,bhi_dis on hardware that is missing that
+                feature will cause the software to fall back to
+                "eibrs,retpoline" mode.
 
 		Not specifying this option is equivalent to
 		spectre_v2=auto.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2d26cb7e853..e0cb07b3f388 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5592,6 +5592,8 @@
 			eibrs		  - enhanced IBRS
 			eibrs,retpoline   - enhanced IBRS + Retpolines
 			eibrs,lfence      - enhanced IBRS + LFENCE
+			eibrs,bhi_dis	  - enhanced IBRS + Hardware BHI
+					    prevention
 			ibrs		  - use IBRS to protect kernel
 
 			Not specifying this option is equivalent to
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 00f5227c8459..eab1baa8036f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -302,6 +302,7 @@
 #define X86_FEATURE_RETPOLINE_LFENCE	(11*32+13) /* "" Use LFENCE for Spectre variant 2 */
 #define X86_FEATURE_RETHUNK		(11*32+14) /* "" Use REturn THUNK */
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
+#define X86_FEATURE_BHI_CTRL		(11*32+16) /* "" Branch History Injection control */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index cc615be27a54..55bfa2764033 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -53,6 +53,8 @@
 #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
+#define SPEC_CTRL_BHI_DIS_S_SHIFT	10	   /* Disable Branch History Injection behavior */
+#define SPEC_CTRL_BHI_DIS_S		BIT(SPEC_CTRL_BHI_DIS_S_SHIFT)
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
@@ -150,6 +152,12 @@
 						 * are restricted to targets in
 						 * kernel.
 						 */
+#define ARCH_CAP_BHI_NO			BIT(20)	/*
+						 * Predicted targets of CPL0
+						 * indirect branches are not
+						 * based on branch history from
+						 * CPL3.
+						 */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index bb05ed4f46bd..57c6fbf15579 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -237,6 +237,7 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_EIBRS,
 	SPECTRE_V2_EIBRS_RETPOLINE,
 	SPECTRE_V2_EIBRS_LFENCE,
+	SPECTRE_V2_EIBRS_BHI,
 	SPECTRE_V2_IBRS,
 };
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0dd04713434b..16e448f141e4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -933,6 +933,7 @@ static void __init retbleed_select_mitigation(void)
 		case SPECTRE_V2_EIBRS:
 		case SPECTRE_V2_EIBRS_RETPOLINE:
 		case SPECTRE_V2_EIBRS_LFENCE:
+		case SPECTRE_V2_EIBRS_BHI:
 			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
 			break;
 		default:
@@ -1016,6 +1017,7 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_EIBRS,
 	SPECTRE_V2_CMD_EIBRS_RETPOLINE,
 	SPECTRE_V2_CMD_EIBRS_LFENCE,
+	SPECTRE_V2_CMD_EIBRS_BHI,
 	SPECTRE_V2_CMD_IBRS,
 };
 
@@ -1096,7 +1098,8 @@ static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 	return mode == SPECTRE_V2_IBRS ||
 	       mode == SPECTRE_V2_EIBRS ||
 	       mode == SPECTRE_V2_EIBRS_RETPOLINE ||
-	       mode == SPECTRE_V2_EIBRS_LFENCE;
+	       mode == SPECTRE_V2_EIBRS_LFENCE ||
+	       mode == SPECTRE_V2_EIBRS_BHI;
 }
 
 static void __init
@@ -1198,6 +1201,7 @@ static const char * const spectre_v2_strings[] = {
 	[SPECTRE_V2_EIBRS]			= "Mitigation: Enhanced IBRS",
 	[SPECTRE_V2_EIBRS_LFENCE]		= "Mitigation: Enhanced IBRS + LFENCE",
 	[SPECTRE_V2_EIBRS_RETPOLINE]		= "Mitigation: Enhanced IBRS + Retpolines",
+	[SPECTRE_V2_EIBRS_BHI]			= "Mitigation: Enhanced IBRS + BHI disabled",
 	[SPECTRE_V2_IBRS]			= "Mitigation: IBRS",
 };
 
@@ -1215,6 +1219,7 @@ static const struct {
 	{ "eibrs",		SPECTRE_V2_CMD_EIBRS,		  false },
 	{ "eibrs,lfence",	SPECTRE_V2_CMD_EIBRS_LFENCE,	  false },
 	{ "eibrs,retpoline",	SPECTRE_V2_CMD_EIBRS_RETPOLINE,	  false },
+	{ "eibrs,bhi_dis",	SPECTRE_V2_CMD_EIBRS_BHI,	  false },
 	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
 	{ "ibrs",		SPECTRE_V2_CMD_IBRS,              false },
 };
@@ -1251,6 +1256,13 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
+	if (cmd == SPECTRE_V2_CMD_EIBRS_BHI &&
+	    !boot_cpu_has(X86_FEATURE_BHI_CTRL)) {
+		pr_err("%s selected but BHI not available. Switching to EIBRS_RETPOLINE\n",
+		       mitigation_options[i].option);
+		cmd = SPECTRE_V2_CMD_EIBRS_RETPOLINE;
+	}
+
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
@@ -1264,7 +1276,8 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 
 	if ((cmd == SPECTRE_V2_CMD_EIBRS ||
 	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
+	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE ||
+	     cmd == SPECTRE_V2_CMD_EIBRS_BHI) &&
 	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
 		pr_err("%s selected but CPU doesn't have eIBRS. Switching to AUTO select\n",
 		       mitigation_options[i].option);
@@ -1334,6 +1347,31 @@ static void __init spec_ctrl_disable_kernel_rrsba(void)
 	}
 }
 
+/*
+ * This prevents predicted targets of indirect branches executed in CPL0, CPL1,
+ * or CPL2 from being selected based on branch history from branches executed in
+ * CPL3.
+ */
+static void __init spec_ctrl_bhi_dis(void)
+{
+	u64 ia32_cap;
+
+	if (!boot_cpu_has(X86_FEATURE_BHI_CTRL))
+		return;
+
+	ia32_cap = x86_read_arch_cap_msr();
+
+	/*
+	 * On certain hardware there is no reason to set this bit in the MSR
+	 * since it's ignored and BHI protections are always enabled anyway.
+	 */
+	if (ia32_cap & ARCH_CAP_BHI_NO)
+		return;
+
+	x86_spec_ctrl_base |= SPEC_CTRL_BHI_DIS_S;
+	write_spec_ctrl_current(x86_spec_ctrl_base, true);
+}
+
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -1398,6 +1436,10 @@ static void __init spectre_v2_select_mitigation(void)
 	case SPECTRE_V2_CMD_EIBRS_RETPOLINE:
 		mode = SPECTRE_V2_EIBRS_RETPOLINE;
 		break;
+
+	case SPECTRE_V2_CMD_EIBRS_BHI:
+		mode = SPECTRE_V2_EIBRS_BHI;
+		break;
 	}
 
 	if (mode == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
@@ -1426,6 +1468,10 @@ static void __init spectre_v2_select_mitigation(void)
 	case SPECTRE_V2_EIBRS_RETPOLINE:
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 		break;
+
+	case SPECTRE_V2_EIBRS_BHI:
+		spec_ctrl_bhi_dis();
+		break;
 	}
 
 	/*
@@ -1435,7 +1481,8 @@ static void __init spectre_v2_select_mitigation(void)
 	 */
 	if (mode == SPECTRE_V2_EIBRS_LFENCE ||
 	    mode == SPECTRE_V2_EIBRS_RETPOLINE ||
-	    mode == SPECTRE_V2_RETPOLINE)
+	    mode == SPECTRE_V2_RETPOLINE ||
+	    mode == SPECTRE_V2_EIBRS_BHI)
 		spec_ctrl_disable_kernel_rrsba();
 
 	spectre_v2_enabled = mode;
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index fd44b54c90d5..9a8f0c086859 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -28,6 +28,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
 	{ X86_FEATURE_INTEL_PPIN,	CPUID_EBX,  0, 0x00000007, 1 },
 	{ X86_FEATURE_RRSBA_CTRL,	CPUID_EDX,  2, 0x00000007, 2 },
+	{ X86_FEATURE_BHI_CTRL,		CPUID_EDX,  4, 0x00000007, 2 },
 	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
 	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },
 	{ X86_FEATURE_CQM_MBM_TOTAL,	CPUID_EDX,  1, 0x0000000f, 1 },
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 2eab6a3a8a8c..63f227aa9bf6 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -53,6 +53,8 @@
 #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
+#define SPEC_CTRL_BHI_DIS_S_SHIFT	10	   /* Disable Branch History Injection behavior */
+#define SPEC_CTRL_BHI_DIS_S		BIT(SPEC_CTRL_BHI_DIS_S_SHIFT)
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
@@ -149,6 +151,12 @@
 						 * are restricted to targets in
 						 * kernel.
 						 */
+#define ARCH_CAP_BHI_NO			BIT(20)	/*
+						 * Predicted targets of CPL0
+						 * indirect branches are not
+						 * based on branch history from
+						 * CPL3.
+						 */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
-- 
2.25.1

