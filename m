Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5486449646B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381908AbiAURsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:48:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:56027 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381864AbiAURrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642787272; x=1674323272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QxJ1Z8BS1hZL8whFuL6RPwtcoEig2y1OhfDG0d4TBGA=;
  b=NVePwGBIdXl2dpSNudMBLrA0pqQxu9fWJvOTbwCzPFqTA43aJl+E4gNO
   wnrCAiB6ovqDGpZIWXJU3i+bbZx+JMLpTIRm5HQA+rbAa5OBZl0ik0iR6
   JjAm/xuzFFKT4tAknIiZ39Ksc38vHofwzjJCaxvMKyE1LTwPc6o52leC4
   YzlmTwZTSzpgZAP8kJOkEAnGu+YiczatPHh44SXjovw+qa2Lnoz2UO2TJ
   KLcfAHl1+By0emWYUDftqODofl3a5IDOpSMRsbuyk27cdW1xSX303335B
   2JsTTaUKzvUbt6J7XnclrsZ70Nfx3S0yUujKCdveCKtYbEGve5ZtXgCzc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="243302305"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="243302305"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 09:47:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="623394799"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 09:47:51 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 4/6] x86/cpu: Read/save PPIN MSR during initialization
Date:   Fri, 21 Jan 2022 09:47:41 -0800
Message-Id: <20220121174743.1875294-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220121174743.1875294-1-tony.luck@intel.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/common.c     | 2 ++
 arch/x86/kernel/cpu/mce/core.c   | 7 +------
 3 files changed, 5 insertions(+), 6 deletions(-)

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
index 8a039d1ea57f..64deb7727d00 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -91,6 +91,7 @@ DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
+	int	msr_ppin;
 } ppin_info[] = {
 	[X86_VENDOR_INTEL] = {
 		.feature = X86_FEATURE_INTEL_PPIN,
@@ -155,6 +156,7 @@ static void ppin_init(struct cpuinfo_x86 *c)
 
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

