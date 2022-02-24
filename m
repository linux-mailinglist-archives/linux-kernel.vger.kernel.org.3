Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7B44C3093
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiBXP5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiBXP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288B33C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718191; x=1677254191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iAKapfo2TJyc613nnXWyeTmHnGckX06XMzYOp7xRyi0=;
  b=ByzT/3p267MaiBGeuCWtUmOzuXZOAGutBuyMA7JfP6ibtqJdI17cw0Yt
   BTEykOrrYommW807hCAjHd9RCXazw2SFrBwCVKM3+CaycAJNjD9moju75
   +XpP6w6K+9HNar4YxWef1ZYoy/zP3P8/2bLYFO4E4IvuxOKn/hE2G/j9P
   zH3WOWO0p2jVTmXcx/Z4g/M/S1xNMjmQwNHzB93A/Ki4aJ9tmyaGHvnNa
   SPUUxKtc6d7Dh8VbTJwDVJI9CRdZBju3vpmfEbhk/ckZnBZPZ5WfQtXuz
   vvtRBnck7UMD4CCr92CbHea2fx/SJAE+Zn4vbj2OJxlLdSvZgIG7j7URJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232889946"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="232889946"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:56:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="543744455"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Feb 2022 07:56:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A5F5D924; Thu, 24 Feb 2022 17:56:34 +0200 (EET)
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
Subject: [PATCHv4 10/30] x86/tdx: Handle CPUID via #VE
Date:   Thu, 24 Feb 2022 18:56:10 +0300
Message-Id: <20220224155630.52734-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 89992593a209..fd78b81a951d 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -154,6 +154,36 @@ static bool write_msr(struct pt_regs *regs)
 	return !__tdx_hypercall(&args, 0);
 }
 
+static bool handle_cpuid(struct pt_regs *regs)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_CPUID,
+		.r12 = regs->ax,
+		.r13 = regs->cx,
+	};
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
@@ -186,8 +216,13 @@ void tdx_get_ve_info(struct ve_info *ve)
  */
 static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 {
-	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-	return false;
+	switch (ve->exit_reason) {
+	case EXIT_REASON_CPUID:
+		return handle_cpuid(regs);
+	default:
+		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+		return false;
+	}
 }
 
 /* Handle the kernel #VE */
@@ -200,6 +235,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 		return read_msr(regs);
 	case EXIT_REASON_MSR_WRITE:
 		return write_msr(regs);
+	case EXIT_REASON_CPUID:
+		return handle_cpuid(regs);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return false;
-- 
2.34.1

