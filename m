Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8634745DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhLNPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:04:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:28570 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235179AbhLNPDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225852696"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="225852696"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="583474921"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2021 07:03:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5F5806C8; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
Subject: [PATCH 06/26] x86/tdx: Add MSR support for TDX guests
Date:   Tue, 14 Dec 2021 18:02:44 +0300
Message-Id: <20211214150304.62613-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
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
index 6749ca3b2e3d..8be8090ca19f 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -97,6 +97,39 @@ void __cpuidle tdx_guest_idle(void)
 	tdx_safe_halt();
 }
 
+static bool tdx_read_msr_safe(unsigned int msr, u64 *val)
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
+static bool tdx_write_msr_safe(unsigned int msr, unsigned int low,
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
@@ -141,11 +174,22 @@ static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 {
 	bool ret = false;
+	u64 val;
 
 	switch (ve->exit_reason) {
 	case EXIT_REASON_HLT:
 		ret = tdx_halt();
 		break;
+	case EXIT_REASON_MSR_READ:
+		ret = tdx_read_msr_safe(regs->cx, &val);
+		if (ret) {
+			regs->ax = lower_32_bits(val);
+			regs->dx = upper_32_bits(val);
+		}
+		break;
+	case EXIT_REASON_MSR_WRITE:
+		ret = tdx_write_msr_safe(regs->cx, regs->ax, regs->dx);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		break;
-- 
2.32.0

