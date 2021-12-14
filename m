Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE84745DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhLNPEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:04:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:31439 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235188AbhLNPDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236526837"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="236526837"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="614300164"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 14 Dec 2021 07:03:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6D3117EB; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
Subject: [PATCH 07/26] x86/tdx: Handle CPUID via #VE
Date:   Tue, 14 Dec 2021 18:02:45 +0300
Message-Id: <20211214150304.62613-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guests, most CPUID leaf/sub-leaf combinations are virtualized
by the TDX module while some trigger #VE.

Implement the #VE handling for EXIT_REASON_CPUID by handing it through
the hypercall, which in turn lets the TDX module handle it by invoking
the host VMM.

More details on CPUID Virtualization can be found in the TDX module
specification [1], the section titled "CPUID Virtualization".

[1] - https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-module-1.0-public-spec-v0.931.pdf

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 8be8090ca19f..e1c757d1720c 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -130,6 +130,31 @@ static bool tdx_write_msr_safe(unsigned int msr, unsigned int low,
 	return ret ? false : true;
 }
 
+static bool tdx_handle_cpuid(struct pt_regs *regs)
+{
+	struct tdx_hypercall_output out;
+
+	/*
+	 * Emulate the CPUID instruction via a hypercall. More info about
+	 * ABI can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
+	 */
+	if (_tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out))
+		return false;
+
+	/*
+	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
+	 * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.
+	 * So copy the register contents back to pt_regs.
+	 */
+	regs->ax = out.r12;
+	regs->bx = out.r13;
+	regs->cx = out.r14;
+	regs->dx = out.r15;
+
+	return true;
+}
+
 bool tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -166,8 +191,18 @@ bool tdx_get_ve_info(struct ve_info *ve)
  */
 static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 {
-	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-	return false;
+	bool ret = false;
+
+	switch (ve->exit_reason) {
+	case EXIT_REASON_CPUID:
+		ret = tdx_handle_cpuid(regs);
+		break;
+	default:
+		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+		break;
+	}
+
+	return ret;
 }
 
 /* Handle the kernel #VE */
@@ -190,6 +225,9 @@ static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 	case EXIT_REASON_MSR_WRITE:
 		ret = tdx_write_msr_safe(regs->cx, regs->ax, regs->dx);
 		break;
+	case EXIT_REASON_CPUID:
+		ret = tdx_handle_cpuid(regs);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		break;
-- 
2.32.0

