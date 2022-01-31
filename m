Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775484A52CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiAaXB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:01:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:53702 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235638AbiAaXBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643670079; x=1675206079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+9Xepbi4V3tZGWxD6uy9Ve7FiBq+R8pLyM5H5ykMw4U=;
  b=bHgHnT3/GoPK1VOdgDg4GFFCR/Gab90qT4sUyOG8v1UzoWXhgKa6Pcuo
   LG/GBMb1I+tNb7qz02wbSIef0Z/eHMIGdtQqO0v/AcFpeD2sgNvtltAS6
   Zdjgd8zrPUfgozjNCnRIrsACpGC/ucD8YQ2la2vcoktdxJwV3fX9MILRb
   XO/rI+GAqe1dslneKsSXt3EaLHrUHvKC0yba6aJ5RSTD7AG14Gu7X/+Ll
   zxOdVFN1uAX1dx/0P7rW+AcChXzO87iHVywNM2c8m836GO6NVAUR2mgU5
   0CfEDT6Tu2glnbVXTLMFLyba8eITDG9frjTPyHDIpxhdUiSAEtFgBQHwP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247521228"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247521228"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="522831344"
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
Subject: [PATCH v3 3/5] x86/cpu: Read/save PPIN MSR during initialization
Date:   Mon, 31 Jan 2022 15:01:09 -0800
Message-Id: <20220131230111.2004669-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220131230111.2004669-1-tony.luck@intel.com>
References: <20220121174743.1875294-1-tony.luck@intel.com>
 <20220131230111.2004669-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the PPIN (Protected Processor Inventory Number) MSR is read by
every CPU that processes a machine check, CMCI, or just polls machine
check banks from a periodic timer. This is not a "fast" MSR, so this
adds to overhead of processing errors.

Add a new "ppin" field to the cpuinfo_x86 structure. Read and save the
PPIN during initialization. Use this copy in mce_setup() instead of
reading the MSR.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/processor.h | 2 ++
 arch/x86/kernel/cpu/common.c     | 4 ++++
 arch/x86/kernel/cpu/mce/core.c   | 7 +------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2c5f12ae7d04..a87e7c33d5ac 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -119,6 +119,8 @@ struct cpuinfo_x86 {
 	int			x86_cache_mbm_width_offset;
 	int			x86_power;
 	unsigned long		loops_per_jiffy;
+	/* protected processor identification number */
+	u64			ppin;
 	/* cpuid returned max cores value: */
 	u16			x86_max_cores;
 	u16			apicid;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0681c69a1f09..64deb7727d00 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -91,14 +91,17 @@ DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
+	int	msr_ppin;
 } ppin_info[] = {
 	[X86_VENDOR_INTEL] = {
 		.feature = X86_FEATURE_INTEL_PPIN,
 		.msr_ppin_ctl = MSR_PPIN_CTL,
+		.msr_ppin = MSR_PPIN
 	},
 	[X86_VENDOR_AMD] = {
 		.feature = X86_FEATURE_AMD_PPIN,
 		.msr_ppin_ctl = MSR_AMD_PPIN_CTL,
+		.msr_ppin = MSR_AMD_PPIN
 	},
 };
 
@@ -153,6 +156,7 @@ static void ppin_init(struct cpuinfo_x86 *c)
 
 	/* Is the enable bit set? */
 	if (val & 2UL) {
+		c->ppin = __rdmsr(info->msr_ppin);
 		set_cpu_cap(c, info->feature);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..4f1e825033ce 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -138,12 +138,7 @@ void mce_setup(struct mce *m)
 	m->socketid = cpu_data(m->extcpu).phys_proc_id;
 	m->apicid = cpu_data(m->extcpu).initial_apicid;
 	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
-
-	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
-		m->ppin = __rdmsr(MSR_PPIN);
-	else if (this_cpu_has(X86_FEATURE_AMD_PPIN))
-		m->ppin = __rdmsr(MSR_AMD_PPIN);
-
+	m->ppin = cpu_data(m->extcpu).ppin;
 	m->microcode = boot_cpu_data.microcode;
 }
 
-- 
2.31.1

