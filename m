Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489CE4FA157
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiDIBbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbiDIBaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2846A10FDD4;
        Fri,  8 Apr 2022 18:27:38 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSNCbEXDf7Baf0hjdjGUk5eIZjcWgfiwErMKtvV3JNg=;
        b=Xxs1YBVWzLKMwuw5w2pLwnPbNl2HhQ7nFdRMd4oVuYt6pqdAmrPrMdRoYrKWuV++FRVTwG
        hw7cgYE7RBKFQtNjX+nS5o6La02fmm+GBza5vx+Oc90Fi+F6udrQiIGV3ayrSn6PILjs5G
        unzvPWt9vuvdhRnoo8gMwUsuwBbE8h3Pbe92tQkVwnFMTd9+Tf2hIrix6ycHMt2Yox+Sw9
        vfTY5LQJthtyLd+/47C2+9TMXcjyVaaA4CDkK7tpb/v35fMjTa34ze0rObTHMnXfQkd787
        s7V8vOTYcdbuscbLDpAXep3BPYNE3NWPZLh5nBNN27IydnnhLjhYr/1O/pUxOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSNCbEXDf7Baf0hjdjGUk5eIZjcWgfiwErMKtvV3JNg=;
        b=xsDqe7mNLTVu6ipu/TicfzfDvJ91s3Oa0/zrrP3dwdwIVOPyipFouZTr7Fv2rNQkstokhQ
        DH5Utuyhyu2DgzAg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Handle CPUID via #VE
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-11-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-11-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946765554.4207.8561622581091318242.tip-bot2@tip-bot2>
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

Commit-ID:     c141fa2c2bbaff0d1f2dc51160626dd22bc16ae2
Gitweb:        https://git.kernel.org/tip/c141fa2c2bbaff0d1f2dc51160626dd22bc16ae2
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:19 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:51 -07:00

x86/tdx: Handle CPUID via #VE

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
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-11-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 58 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 00ff0a8..50c3b97 100644
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
 
