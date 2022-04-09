Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592314FA11F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiDIBaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiDIBaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A743D10CF37;
        Fri,  8 Apr 2022 18:27:31 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kpVAhFVWWyvBiYJiDeEX/dJ7oQml4E+VxBw5Wb/zn0A=;
        b=VZD9LlnVI6Uz2w42BLPGGSwfQsNWwdEDMELevQEGg5jsJWkOquJiVD3Th6qM1PSfdnvJjY
        vWPpFaBnrDCeOHgaaS4h3BFeXnlbwxT1w6Bc6xEsCnJ8eflHJ5rPuvwCwChW7J2epBn+jA
        lFxIS+l1wk5z5e7z/3PR1wCGZLmAm6F7pIlmKJvhhwI9neARPk+WdlTWenuKY5YRZC1b38
        HxJwcwkOUd7kQCtL4egWllkgY6vruu+iZCZdm5NpKJYX5xLZgMyyTVplCfWs71v38ngiHx
        l+YBdtvCo5h5Sr7IRICM3pcEYg9UNFByR7d3CHTlWF4cQK8nTuFW3n9034BZDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kpVAhFVWWyvBiYJiDeEX/dJ7oQml4E+VxBw5Wb/zn0A=;
        b=0g51/joYjwQPOEfPxgDL+Zpkh6G86tSV2pTC82sqS9lTKmyT1n4ntUBANqAADa2RF2B2Vg
        A8QqVUYuaDIv7UDQ==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Port I/O: Add runtime hypercalls
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-18-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-18-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946764912.4207.5799449565853339329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     03149948832a078f759022ed5b92e722d8d23c26
Gitweb:        https://git.kernel.org/tip/03149948832a078f759022ed5b92e722d8d23c26
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:26 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:52 -07:00

x86/tdx: Port I/O: Add runtime hypercalls

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
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-18-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/core.c    |  7 +++-
 arch/x86/coco/tdx/tdx.c | 79 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 3f30087..df08edc 100644
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
index ab10bc7..e47e2ed 100644
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
