Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C474DDCED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbiCRPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiCRPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:32:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D1A181B34
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617457; x=1679153457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xBrD9faVfntgWnuya1iuDAqcY9OqfL5gZb7hKgUoxq0=;
  b=aEQtxgZpkKADnAkDBS55E6KWIBi0RH6zHDxWWEmMv3tNl2EUDF1zrk0X
   In4AxwXGQ0FAFJBfB4Hu5DCeRYKw3RQqm6QmOZJU/BU0nIZJh57LVEq61
   6zeic/rtJ6P5wmRJvU5g3s5ZBVx0flByTdRZYdlmHX03cJ+jBZwdyFwDT
   yhLLPRhdcEK+NssrxC292rlFITnXSz78AASDt2bJUpStk10bPWBgWF4Q+
   ajl3ejbk8mfh0ZuFOxvUoiq73iF3anVHFJu9UphJhc3UO9aPUzCnSUPkf
   WTmijm4D+qVld8KkW3Vxz6MwMRHMX9Vn98Bs+5X0w0xrZRdTtRb5GBF85
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="255982582"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="255982582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558495420"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2022 08:30:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2B3984E5; Fri, 18 Mar 2022 17:30:50 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv7 10/30] x86/tdx: Handle CPUID via #VE
Date:   Fri, 18 Mar 2022 18:30:28 +0300
Message-Id: <20220318153048.51177-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Note that VMM that handles the hypercall is not trusted. It can return
data that may steer the guest kernel in wrong direct. Only allow  VMM
to control range reserved for hypervisor communication.

Return all-zeros for any CPUID outside the hypervisor range. It matches
CPU behaviour for non-supported leaf.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/coco/tdx/tdx.c | 58 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 00ff0a830970..50c3b97d6db7 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -180,6 +180,48 @@ static bool write_msr(struct pt_regs *regs)
 	return !__tdx_hypercall(&args, 0);
 }
 
+static bool handle_cpuid(struct pt_regs *regs)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = hcall_func(EXIT_REASON_CPUID),
+		.r12 = regs->ax,
+		.r13 = regs->cx,
+	};
+
+	/*
+	 * Only allow VMM to control range reserved for hypervisor
+	 * communication.
+	 *
+	 * Return all-zeros for any CPUID outside the range. It matches CPU
+	 * behaviour for non-supported leaf.
+	 */
+	if (regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) {
+		regs->ax = regs->bx = regs->cx = regs->dx = 0;
+		return true;
+	}
+
+	/*
+	 * Emulate the CPUID instruction via a hypercall. More info about
+	 * ABI can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
+	 */
+	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
+		return false;
+
+	/*
+	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
+	 * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.
+	 * So copy the register contents back to pt_regs.
+	 */
+	regs->ax = args.r12;
+	regs->bx = args.r13;
+	regs->cx = args.r14;
+	regs->dx = args.r15;
+
+	return true;
+}
+
 void tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -210,6 +252,18 @@ void tdx_get_ve_info(struct ve_info *ve)
 	ve->instr_info  = upper_32_bits(out.r10);
 }
 
+/* Handle the user initiated #VE */
+static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
+{
+	switch (ve->exit_reason) {
+	case EXIT_REASON_CPUID:
+		return handle_cpuid(regs);
+	default:
+		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+		return false;
+	}
+}
+
 /* Handle the kernel #VE */
 static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 {
@@ -220,6 +274,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 		return read_msr(regs);
 	case EXIT_REASON_MSR_WRITE:
 		return write_msr(regs);
+	case EXIT_REASON_CPUID:
+		return handle_cpuid(regs);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return false;
@@ -231,7 +287,7 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 	bool ret;
 
 	if (user_mode(regs))
-		ret = false;
+		ret = virt_exception_user(regs, ve);
 	else
 		ret = virt_exception_kernel(regs, ve);
 
-- 
2.34.1

