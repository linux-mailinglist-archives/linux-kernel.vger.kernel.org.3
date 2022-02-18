Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1274BBD58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiBRQSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:18:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiBRQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510B431519
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201042; x=1676737042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u3x9XgG7VJ5RoOBjvNJruzRbem2Zn32xV8jdzKXZWH8=;
  b=HxbDw99bMBcZdPyexyWgD/rHRWeOTn2f5p8ZzDeogF8HZBlWjWVh2iiH
   7JPZZREw5Ao0ZXLJpq5/5XGngJXLxrDcaB4Gm8w1dyxaaBv2ZiwuaIOpg
   T7sH2yX5M6jX5eUaY/hNOV01c11XQ50+zHP5u5MYiBBk/L6jl0Tx2qPrE
   oO/eJsVqoqCCdpTVxP9TKL0v0WI9ydMz+jPwf/gsKdxYaAGAGMm4zUbK7
   Y6PGBsoGpjT5HybdTPRzq6umslvJg9a/4cYeDhQLQ4CdyEK9ZVJC0LUyA
   djFd50udeO5GUxyoAs9758hrSzTWauF4rzuD/jjXislmh0MRlW0BYX1hl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238559701"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238559701"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="635870701"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2022 08:17:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 850DF924; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
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
Subject: [PATCHv3 10/32] x86/tdx: Add MSR support for TDX guests
Date:   Fri, 18 Feb 2022 19:16:56 +0300
Message-Id: <20220218161718.67148-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 8adc759961f3..c0549dce2588 100644
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

