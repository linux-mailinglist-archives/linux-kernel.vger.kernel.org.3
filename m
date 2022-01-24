Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFE4982D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbiAXPC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:02:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:64659 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239696AbiAXPCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036541; x=1674572541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Djfyc1VSSpZn3ALeKiQbg54iksPf4MVncppAVM6UlBY=;
  b=Nib/8vHeyFGyW0RdrrAeCo+GnnIGo15JSmR/kIHfqXxuMNqB9PRlRB+p
   vnEtB5zFHRMO4vWQBbLM7CwPwyzdDUNSoxHsl8t+76/tkSX5pfVHK11JG
   h+Y4NmdfnluQNPM5iyU/BTzWv1QwsOs8G+GfYTW8bf7vkKlwM4zSy6baz
   5zL3gNpuQjW/wx6O2r2yq6Wc1pdnFq4dsPNuQVZdLL0Q6V8ooQtXpOYzC
   ClrCYcX6corEv9YEstoTR51mCSEt6pRHUURIw4DOEseF13NA2/+n9PYCM
   uUlFxn5u2uB5tssoJdfWbGiVgik+65I8PnN9wnfq9PWq7GtQV9eWd5EhJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270498557"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270498557"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="580395625"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2022 07:02:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A1BE9501; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
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
Subject: [PATCHv2 07/29] x86/tdx: Handle CPUID via #VE
Date:   Mon, 24 Jan 2022 18:01:53 +0300
Message-Id: <20220124150215.36893-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
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
specification, the section titled "CPUID Virtualization".

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 29a03a4bdb53..f213c67b4ecc 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -124,6 +124,31 @@ static bool tdx_write_msr(unsigned int msr, unsigned int low,
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
@@ -157,8 +182,18 @@ bool tdx_get_ve_info(struct ve_info *ve)
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
@@ -181,6 +216,9 @@ static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 	case EXIT_REASON_MSR_WRITE:
 		ret = tdx_write_msr(regs->cx, regs->ax, regs->dx);
 		break;
+	case EXIT_REASON_CPUID:
+		ret = tdx_handle_cpuid(regs);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		break;
-- 
2.34.1

