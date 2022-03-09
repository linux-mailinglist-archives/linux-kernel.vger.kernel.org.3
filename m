Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FC64D3431
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 17:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiCIQXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbiCIQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:19:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD9C190B74
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646842505; x=1678378505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WM6eCdkxZ9CYApmaiSTssyYOiXBFLkK74l7LdadqI1Q=;
  b=h2TmMF7b93quSonBZpgJzkmVyXfSFyxnc8gzg55j6FO5loQSp0x5yt+R
   HKTukTKKCSsv1epYTKWRWbnAo4A2Yw8yDXobA4Z2fJBeRT/OaHmAzdo45
   LcXkR57NkMbP3CRlerCGZ1N0jW/xlFBEPvXv0VODI4e2SfPlw8m3GAugD
   GgVgvLmx6iJ2eXKOYL3FUxHN7xgplLjGGQTx5R3bl1Cb6DRb4hDe7aO0x
   4KbH77XIM/OYIFERcNDVcpw5J8aTf6P4GLL1JANPLbbzPK6iybFQseCtc
   Cm9xlutxrT+Tvdk8vnpfw4X1GoEmFv17/pFVeFKs/UBYwWiGBdxfA+rHO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235617247"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="235617247"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 08:14:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="711991410"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2022 08:14:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 640E794; Wed,  9 Mar 2022 18:15:04 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com
Cc:     aarcange@redhat.com, ak@linux.intel.com, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/tdx: Handle CPUID via #VE
Date:   Wed,  9 Mar 2022 19:15:02 +0300
Message-Id: <20220309161502.22884-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <133a741f-02ae-49bd-1bc4-87ec42ab024b@intel.com>
References: <133a741f-02ae-49bd-1bc4-87ec42ab024b@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 arch/x86/coco/tdx.c | 58 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index a2f19c78583a..3d468a2b9ec6 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -163,6 +163,48 @@ static bool write_msr(struct pt_regs *regs)
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
@@ -186,6 +228,18 @@ void tdx_get_ve_info(struct ve_info *ve)
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
@@ -196,6 +250,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 		return read_msr(regs);
 	case EXIT_REASON_MSR_WRITE:
 		return write_msr(regs);
+	case EXIT_REASON_CPUID:
+		return handle_cpuid(regs);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return false;
@@ -207,7 +263,7 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 	bool ret;
 
 	if (user_mode(regs))
-		ret = false;
+		ret = virt_exception_user(regs, ve);
 	else
 		ret = virt_exception_kernel(regs, ve);
 
-- 
2.34.1

