Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B683F4F540F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359610AbiDFDRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384958AbiDFCOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:14:31 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F71B2566
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201717; x=1680737717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fa58IG6IkoYlTr3b12lt1ElQz5ZUgXZHAh5KeLMD4U=;
  b=Ku9Bw49/mVml5GAHuo574bTiG8Sngs0EgR50rTbDTkWGEbpqPvw8CRBn
   avqXA1fjSGoWzhlSTR3WPCexY6QEDdTQLieG7NizO45xFlMVgbbTEjETl
   pm5G3ld+Hvyt93ac5I7QHkVKz/oMVXJx7/jHrxw3k9I0SoBOjbkKm38BO
   ZfC0ar3q2ffr71fqeqqKkNBH929a7oNHPLzDmXAS9vhxb2Myph41bxm3t
   R6UXOrEcXijfi00ttYczLo3vbfaaRy30PE16DHGvae2/5ed3PCJXG08wT
   ZHjx0hea/QSe4oZLql37kO09XKQwo1790T2LWoep314jdpxBdciaOXls6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="321586049"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="321586049"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="652106922"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2022 16:34:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DFF83655; Wed,  6 Apr 2022 02:29:45 +0300 (EEST)
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
Subject: [PATCHv8 09/30] x86/tdx: Add MSR support for TDX guests
Date:   Wed,  6 Apr 2022 02:29:18 +0300
Message-Id: <20220405232939.73860-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Kernel relies on the exception fixup machinery to handle MSR access
errors. #VE handler uses the same exception fixup code as #GP. It
covers MSR accesses along with other types of fixups.

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
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/coco/tdx/tdx.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index ed7302581cc7..00ff0a830970 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -142,6 +142,44 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static bool read_msr(struct pt_regs *regs)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = hcall_func(EXIT_REASON_MSR_READ),
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
+		.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
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
@@ -178,6 +216,10 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
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
2.35.1

