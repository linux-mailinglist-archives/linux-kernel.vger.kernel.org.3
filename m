Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5846E4C30A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiBXP7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbiBXP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD61FEB34
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718224; x=1677254224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I9uK/HGgxs+4LApXPKoF4d7SoeHV8nK2K+EnhCg+LAs=;
  b=h7NcFLmNPN4HxrYthGKrCYFcA2RDTC+WUWLadppJptOsbTccjp1Tboxn
   iHD8TDZc4sOuxZDOOonQMZ64dr/LjSdOoXWh71xxDmcE0hHAYj6vQ0Len
   fYGHfVZ26f4K1+SOgkjw+zHRnEk15YSA8pfmgYqjumszjrDufaWD+xE6T
   Sqb8PQniy1Lyauq6d9hB8SiSOXTxMTHaeEViHxJLzvr20zIRexOaL8wmR
   QLUTqP80tsb0jWvtbD/0R0dlFKo86/UJt9slm4fDC+0F3NnIxoNbegP4i
   ppiyZ5jLOJuRox0Pv0FtwLhlit68jsJmjflBtHIERtkzQ8O74Obu30drc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="276893921"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="276893921"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:56:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="506362057"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2022 07:56:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9808188D; Thu, 24 Feb 2022 17:56:34 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 09/30] x86/tdx: Add MSR support for TDX guests
Date:   Thu, 24 Feb 2022 18:56:09 +0300
Message-Id: <20220224155630.52734-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/coco/tdx.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 0a2e6be0cdae..89992593a209 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -116,6 +116,44 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static bool read_msr(struct pt_regs *regs)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_MSR_READ,
+		.r12 = regs->cx,
+	};
+
+	/*
+	 * Emulate the MSR read via hypercall. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), section titled "TDG.VP.VMCALL<Instruction.RDMSR>".
+	 */
+	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
+		return false;
+
+	regs->ax = lower_32_bits(args.r11);
+	regs->dx = upper_32_bits(args.r11);
+	return true;
+}
+
+static bool write_msr(struct pt_regs *regs)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_MSR_WRITE,
+		.r12 = regs->cx,
+		.r13 = (u64)regs->dx << 32 | regs->ax,
+	};
+
+	/*
+	 * Emulate the MSR write via hypercall. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.WRMSR>".
+	 */
+	return !__tdx_hypercall(&args, 0);
+}
+
 void tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -158,6 +196,10 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 	switch (ve->exit_reason) {
 	case EXIT_REASON_HLT:
 		return handle_halt();
+	case EXIT_REASON_MSR_READ:
+		return read_msr(regs);
+	case EXIT_REASON_MSR_WRITE:
+		return write_msr(regs);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return false;
-- 
2.34.1

