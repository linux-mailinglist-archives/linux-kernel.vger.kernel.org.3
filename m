Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1FE4CA821
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243111AbiCBOai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbiCBO3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:29:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A7551E52
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231304; x=1677767304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FI7ts3ddWiJt2vgVWaXRndDV9uR/SMBzOmQIiJZCOuA=;
  b=MjIddxeFchuzMndxuOb208alIknRG/rGHFN+zBc/EiNlCXsll+Aar45Q
   H+Zjwwcsc22C+dDjPh7Lee4c9gl+N3xZak/tdt6DfQxZgT8QQKnIBUm8l
   UI0t35VElsSsCycVwX8V5PnsWiIGSzi1GFB5tNPm1PMkUVN3TwuYTMdzd
   XAADd7PtEfIeIYOOYDp+UQa3ydmwthyLcopbCBiWpVT9NF5IHFj0Q/JGE
   xsaiWWLuHAKeNaISF7UfphyjSL6xPE3tE7CoW3PJlnIIJQ5dzvnDlSe12
   2697c/U6fwu5+UzrhEJVgiO30KuygRZTqCJs4EdM7vp+A6TnBukzK6sC9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233376494"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="233376494"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="551270237"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2022 06:28:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id AC4CD4A7; Wed,  2 Mar 2022 16:28:12 +0200 (EET)
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 17/30] x86/tdx: Port I/O: add runtime hypercalls
Date:   Wed,  2 Mar 2022 17:27:53 +0300
Message-Id: <20220302142806.51844-18-kirill.shutemov@linux.intel.com>
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

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

TDX hypervisors cannot emulate instructions directly. This includes
port I/O which is normally emulated in the hypervisor. All port I/O
instructions inside TDX trigger the #VE exception in the guest and
would be normally emulated there.

Use a hypercall to emulate port I/O. Extend the
tdx_handle_virt_exception() and add support to handle the #VE due to
port I/O instructions.

String I/O operations are not supported in TDX. Unroll them by declaring
CC_ATTR_GUEST_UNROLL_STRING_IO confidential computing attribute.

== Userspace Implications ==

The ioperm() facility allows userspace access to I/O instructions like
inb/outb.  Among other things, this allows writing userspace device
drivers.

This series has no special handling for ioperm(). Users will be able to
successfully request I/O permissions but will induce a #VE on their
first I/O instruction. If this is undesirable users can enable kernel
lockdown feature with 'lockdown=integrity' kernel command line option.
It makes ioperm() fail.

More robust handling of this situation (denying ioperm() in all TDX
guests) will be addressed in follow-on work.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/core.c |  7 +++-
 arch/x86/coco/tdx.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 9113baebbfd2..5615b75e6fc6 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -18,7 +18,12 @@ static u64 cc_mask __ro_after_init;
 
 static bool intel_cc_platform_has(enum cc_attr attr)
 {
-	return false;
+	switch (attr) {
+	case CC_ATTR_GUEST_UNROLL_STRING_IO:
+		return true;
+	default:
+		return false;
+	}
 }
 
 /*
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index e6163e7e3247..1f58375f61df 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -19,6 +19,16 @@
 #define EPT_READ	0
 #define EPT_WRITE	1
 
+/* Port I/O direction */
+#define PORT_READ	0
+#define PORT_WRITE	1
+
+/* See Exit Qualification for I/O Instructions in VMX documentation */
+#define VE_IS_IO_IN(e)		((e) & BIT(3))
+#define VE_GET_IO_SIZE(e)	(((e) & GENMASK(2, 0)) + 1)
+#define VE_GET_PORT_NUM(e)	((e) >> 16)
+#define VE_IS_IO_STRING(e)	((e) & BIT(4))
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -312,6 +322,73 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	return true;
 }
 
+static bool handle_in(struct pt_regs *regs, int size, int port)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
+		.r12 = size,
+		.r13 = PORT_READ,
+		.r14 = port,
+	};
+	bool success;
+	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+
+	/*
+	 * Emulate the I/O read via hypercall. More info about ABI can be found
+	 * in TDX Guest-Host-Communication Interface (GHCI) section titled
+	 * "TDG.VP.VMCALL<Instruction.IO>".
+	 */
+	success = !__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	/* Update part of the register affected by the emulated instruction */
+	regs->ax &= ~mask;
+	if (success)
+		regs->ax |= args.r11 & mask;
+
+	return success;
+}
+
+static bool handle_out(struct pt_regs *regs, int size, int port)
+{
+	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+
+	/*
+	 * Emulate the I/O write via hypercall. More info about ABI can be found
+	 * in TDX Guest-Host-Communication Interface (GHCI) section titled
+	 * "TDG.VP.VMCALL<Instruction.IO>".
+	 */
+	return !_tdx_hypercall(hcall_func(EXIT_REASON_IO_INSTRUCTION), size,
+			       PORT_WRITE, port, regs->ax & mask);
+}
+
+/*
+ * Emulate I/O using hypercall.
+ *
+ * Assumes the IO instruction was using ax, which is enforced
+ * by the standard io.h macros.
+ *
+ * Return True on success or False on failure.
+ */
+static bool handle_io(struct pt_regs *regs, u32 exit_qual)
+{
+	bool in;
+	int size, port;
+
+	if (VE_IS_IO_STRING(exit_qual))
+		return false;
+
+	in   = VE_IS_IO_IN(exit_qual);
+	size = VE_GET_IO_SIZE(exit_qual);
+	port = VE_GET_PORT_NUM(exit_qual);
+
+
+	if (in)
+		return handle_in(regs, size, port);
+	else
+		return handle_out(regs, size, port);
+}
+
 void tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -361,6 +438,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 		return handle_cpuid(regs);
 	case EXIT_REASON_EPT_VIOLATION:
 		return handle_mmio(regs, ve);
+	case EXIT_REASON_IO_INSTRUCTION:
+		return handle_io(regs, ve->exit_qual);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return false;
-- 
2.34.1

