Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40074F537D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359702AbiDFDRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447705AbiDFCOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:14:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEAC1B30A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201720; x=1680737720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n55tPe1XJ/yrFRDZYdzFVt4dQYLLVDYsO32aYUePlY8=;
  b=M4Hl4FvHZlLVnXuFKVNEhiz0XgF34iTo/t9mPIwclo0Qsd9cTeylffAZ
   el2RvMBZ8mIT+kzEaCuJpXSTBcnvWWWG7tRJcUfzyiFCcxVEWS4/SHAP2
   8M0tdY+D1vjFxfRM9/8l+SGkJM9orKImQ4O9bdH8I9UCwKcvAca+aavj5
   fhQbKK6EfsIw5ec0Njls9/9bKPb18s79K7QoeTKTTqTa6dLCxmwO1r1GQ
   Q4NWnsHkEPeg3Qto4k/bTXr8tX5ackoNmLyMju6NZGD1+T/zEPM40p5rl
   1ayx8jQ6o0r6rylxHMrhl1KuA/BSl5PFYQgZZBSKSvonNJY32acle1gq9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260884663"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="260884663"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="641812562"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2022 16:34:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5F1EFC11; Wed,  6 Apr 2022 02:29:46 +0300 (EEST)
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv8 17/30] x86/tdx: Port I/O: add runtime hypercalls
Date:   Wed,  6 Apr 2022 02:29:26 +0300
Message-Id: <20220405232939.73860-18-kirill.shutemov@linux.intel.com>
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
first I/O instruction which leads SIGSEGV. If this is undesirable users
can enable kernel lockdown feature with 'lockdown=integrity' kernel
command line option. It makes ioperm() fail.

More robust handling of this situation (denying ioperm() in all TDX
guests) will be addressed in follow-on work.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/coco/core.c    |  7 +++-
 arch/x86/coco/tdx/tdx.c | 79 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 3f3008783e05..df08edc94f9b 100644
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
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index ab10bc73a7c5..e47e2ed6b03e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
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
@@ -341,6 +351,73 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
+	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	bool success;
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
+	int size, port;
+	bool in;
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
@@ -397,6 +474,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 		return handle_cpuid(regs);
 	case EXIT_REASON_EPT_VIOLATION:
 		return handle_mmio(regs, ve);
+	case EXIT_REASON_IO_INSTRUCTION:
+		return handle_io(regs, ve->exit_qual);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return false;
-- 
2.35.1

