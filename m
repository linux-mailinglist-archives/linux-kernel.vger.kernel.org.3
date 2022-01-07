Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4CB487F20
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiAGWzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:55:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:7113 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbiAGWyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641596089; x=1673132089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iRXggUCYvjzFUYA6NKKQDmdD9Wpx+PMAccMrHW3rXH4=;
  b=jyEpHhMu8vVnxhODdUjel1gVBADUAhxLb/ZMVhN5sgOfUD40ocxsK83R
   HwDNzxGYuv3vgOCfwlUNbXNqjLKG5FqNQIok4TYGvQcRa1/ET7Jbp2M7Q
   JCPLshCiZ2m29TTsh343JPhErt7Bt/BWcM4wOWLa1nfRQ/MoTME1/yl0G
   YLcRBW79AaHWB4jX01T2NrZgqSbjHrMcnLH/hxipIrzyhRQAzpjeM2uL1
   Kgw150kKAwi9ukU75+jfbwEB3iTMTthFEphHNe4odoTdTOOC+/8hXDldq
   42JfDm6CncBnKY7VRqYdHWgo8K/y5BnrI8U6bUrxvnUeu31HpuOAGtVHQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="229762185"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="229762185"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:54:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="471452462"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:54:48 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH 3/5] x86/ras: Read/save PPIN MSR during initialization
Date:   Fri,  7 Jan 2022 14:54:40 -0800
Message-Id: <20220107225442.1690165-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107225442.1690165-1-tony.luck@intel.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/common.c     | 1 +
 arch/x86/kernel/cpu/mce/core.c   | 7 +------
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 355d38c0cf60..1db5bb3413ae 100644
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
index 3688f70ee0a2..9a90f96257d1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -155,6 +155,7 @@ static void ppin_init(struct cpuinfo_x86 *c)
 
 	/* Is the enable bit set? */
 	if (val & 2UL) {
+		c->ppin = __rdmsr(info->msr_ppin);
 		set_cpu_cap(c, info->feature);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ed365337a3b..ec38c0c6c235 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -139,12 +139,7 @@ noinstr void mce_setup(struct mce *m)
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

