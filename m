Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC54CA809
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242930AbiCBO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbiCBO25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:28:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A868F37BE8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231288; x=1677767288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zM1OfSXhEZoDKc5HeMFDG5xNEMbxTSoChkiPDD1Qwxc=;
  b=i3ogyTdoHLB0NjFEJyHkbRZVNNthWvi36aZ/enTqB6FmGfNuvs3nZP2W
   wYtcYOf+PERuYLc9pTQDJ9e1bLok9TuuPATIp9xf/1wmYwI4jQhBdrCBO
   2ShWBu19mIABD/R8XAH63fXRyaX/nW5kAjnWrMy8ooOwhzlKq9meyC44i
   lHQ5FKCoXgc2bZuDPJOLAZBEy5nnON6wc15x8e+mG0I747sv8UVbUo/5y
   NS4fd2Q1G/yHY11zTifjwQkxpHvbpkF3FfG7vBZqHYINbkSgWj0/vItn2
   VgB9G/lnfEzL/kOZiI+OfKEcVf4uNmVbprvXhThCmrYtlqWdGG0ht1WXJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233376454"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="233376454"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="545512459"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Mar 2022 06:28:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4D52636A; Wed,  2 Mar 2022 16:28:12 +0200 (EET)
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
Subject: [PATCHv5 10/30] x86/tdx: Handle CPUID via #VE
Date:   Wed,  2 Mar 2022 17:27:46 +0300
Message-Id: <20220302142806.51844-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
to control range reserved for hypervisor communication. Return all-zeros
for any CPUID outside the range.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index f3c6767a42d2..d00b367f8052 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -159,6 +159,47 @@ static bool write_msr(struct pt_regs *regs)
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
+	 * Return all-zeros for any CPUID outside the range.
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
@@ -182,6 +223,18 @@ void tdx_get_ve_info(struct ve_info *ve)
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
@@ -192,6 +245,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 		return read_msr(regs);
 	case EXIT_REASON_MSR_WRITE:
 		return write_msr(regs);
+	case EXIT_REASON_CPUID:
+		return handle_cpuid(regs);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return false;
@@ -203,7 +258,7 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 	bool ret;
 
 	if (user_mode(regs))
-		ret = false;
+		ret = virt_exception_user(regs, ve);
 	else
 		ret = virt_exception_kernel(regs, ve);
 
-- 
2.34.1

