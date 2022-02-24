Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EC34C3099
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiBXP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiBXP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6389FE408
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718227; x=1677254227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fpM+R64ZJtHaEddcdRF4eznJG7BpiVFYKcTcY8Y1O6Y=;
  b=H+dJyArYyeaAKHw2vxAeI/F/HORODTyrweUaNlof+6oC/wKX74HfJEYj
   WcTjRGUVdwCgLCsSD3t6kz93qJFzZbtn4hOI4oQzAsklpAMDFj05lCppN
   G/i4jb15Vwdueez1z1VzhWlLBxsQXntidumiShVtGN7EfqkUeeyl4eAis
   glBcE60JbjUU/X44P3V9rsPoMp7ZAB4f2+0domVhOr9G0I0KXgzmQnpn5
   6HZjHClBahYMNp0oMEXJGylaRpGJ5C8uXtMVwrn0WmyNx9Cqn86Qyrt4a
   U8IUsyHtcyQPqDOApPbvhLQaHpkNGYrTKBuunG09AFUM/BtwoSomPSg95
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="276893950"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="276893950"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="786966451"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Feb 2022 07:56:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0EDBEAB1; Thu, 24 Feb 2022 17:56:35 +0200 (EET)
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
Subject: [PATCHv4 17/30] x86/tdx: Add port I/O emulation
Date:   Thu, 24 Feb 2022 18:56:17 +0300
Message-Id: <20220224155630.52734-18-kirill.shutemov@linux.intel.com>
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

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/core.c |  7 +++++-
 arch/x86/coco/tdx.c  | 54 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

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
index 15519e498679..2e342760b1d2 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -19,6 +19,12 @@
 #define EPT_READ	0
 #define EPT_WRITE	1
 
+/* See Exit Qualification for I/O Instructions in VMX documentation */
+#define VE_IS_IO_IN(e)		((e) & BIT(3))
+#define VE_GET_IO_SIZE(e)	(((e) & GENMASK(2, 0)) + 1)
+#define VE_GET_PORT_NUM(e)	((e) >> 16)
+#define VE_IS_IO_STRING(e)	((e) & BIT(4))
+
 static struct {
 	unsigned int gpa_width;
 	unsigned long attributes;
@@ -292,6 +298,52 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	return true;
 }
 
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
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_IO_INSTRUCTION,
+	};
+	int size, port;
+	u64 mask;
+	bool in, ret;
+
+	if (VE_IS_IO_STRING(exit_qual))
+		return false;
+
+	in   = VE_IS_IO_IN(exit_qual);
+	size = VE_GET_IO_SIZE(exit_qual);
+	port = VE_GET_PORT_NUM(exit_qual);
+	mask = GENMASK(BITS_PER_BYTE * size, 0);
+
+	args.r12 = size;
+	args.r13 = !in;
+	args.r14 = port;
+	args.r15 = in ? 0 : regs->ax;
+
+	/*
+	 * Emulate the I/O read/write via hypercall. More info about
+	 * ABI can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.IO>".
+	 */
+	ret = !__tdx_hypercall(&args, in ? TDX_HCALL_HAS_OUTPUT : 0);
+	if (!ret || !in)
+		return ret;
+
+	regs->ax &= ~mask;
+	regs->ax |= ret ? args.r11 & mask : UINT_MAX;
+
+	return ret;
+}
+
 void tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -347,6 +399,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
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

