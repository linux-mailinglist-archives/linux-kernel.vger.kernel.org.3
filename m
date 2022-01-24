Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E30F4982F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbiAXPDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:63899 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239195AbiAXPC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036548; x=1674572548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rz6Q1RPO6JdnPBoGEUw9pTSfnxOZX28u8jhsGtM79xQ=;
  b=Lj9eNTrtVnaQUJ6w9bgmE7yfa06J8FS9YXhYqRoEP1fRofU+5fBiJJhG
   wenCDBOX2kHy82Tk4n9Po0n9O/4Z275T6TcZNUlZt+1Mvld97Q59dbgCM
   zghYRynmccCGDdTWEyL5ymS8zRG6hcEz5RKLQQ9cs+8lcho2IliRLMzKO
   iS06HNCFJq8DIZr8BXS99sKF4MzrUXF9KkEo+rfGXbvtrgjAUK/ZRS8Tw
   576H7FtR3twmIuhPbwB5JTTC004UlB4nsqumVCjSdHDtg10USebN2qN7e
   KVK9rLJp/O1OCKkKzkduz8O2uHgK1DWIoKk5prAnqjsIkxpj4uUOxxXJa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226734697"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226734697"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617258453"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2022 07:02:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 942654DB; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 06/29] x86/tdx: Add MSR support for TDX guests
Date:   Mon, 24 Jan 2022 18:01:52 +0300
Message-Id: <20220124150215.36893-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use hypercall to emulate MSR read/write for the TDX platform.

There are two viable approaches for doing MSRs in a TD guest:

1. Execute the RDMSR/WRMSR instructions like most VMs and bare metal
   do. Some will succeed, others will cause a #VE. All of those that
   cause a #VE will be handled with a TDCALL.
2. Use paravirt infrastructure.  The paravirt hook has to keep a list
   of which MSRs would cause a #VE and use a TDCALL.  All other MSRs
   execute RDMSR/WRMSR instructions directly.

The second option can be ruled out because the list of MSRs was
challenging to maintain. That leaves option #1 as the only viable
solution for the minimal TDX support.

For performance-critical MSR writes (like TSC_DEADLINE), future patches
will replace the WRMSR/#VE sequence with the direct TDCALL.

RDMSR and WRMSR specification details can be found in
Guest-Host-Communication Interface (GHCI) for Intel Trust Domain
Extensions (Intel TDX) specification, sec titled "TDG.VP.
VMCALL<Instruction.RDMSR>" and "TDG.VP.VMCALL<Instruction.WRMSR>".

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index eeb456631a65..29a03a4bdb53 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -91,6 +91,39 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static bool tdx_read_msr(unsigned int msr, u64 *val)
+{
+	struct tdx_hypercall_output out;
+
+	/*
+	 * Emulate the MSR read via hypercall. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), sec titled "TDG.VP.VMCALL<Instruction.RDMSR>".
+	 */
+	if (_tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out))
+		return false;
+
+	*val = out.r11;
+
+	return true;
+}
+
+static bool tdx_write_msr(unsigned int msr, unsigned int low,
+			       unsigned int high)
+{
+	u64 ret;
+
+	/*
+	 * Emulate the MSR write via hypercall. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI) sec titled "TDG.VP.VMCALL<Instruction.WRMSR>".
+	 */
+	ret = _tdx_hypercall(EXIT_REASON_MSR_WRITE, msr, (u64)high << 32 | low,
+			     0, 0, NULL);
+
+	return ret ? false : true;
+}
+
 bool tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -132,11 +165,22 @@ static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 {
 	bool ret = false;
+	u64 val;
 
 	switch (ve->exit_reason) {
 	case EXIT_REASON_HLT:
 		ret = tdx_halt();
 		break;
+	case EXIT_REASON_MSR_READ:
+		ret = tdx_read_msr(regs->cx, &val);
+		if (ret) {
+			regs->ax = lower_32_bits(val);
+			regs->dx = upper_32_bits(val);
+		}
+		break;
+	case EXIT_REASON_MSR_WRITE:
+		ret = tdx_write_msr(regs->cx, regs->ax, regs->dx);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		break;
-- 
2.34.1

