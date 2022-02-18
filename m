Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC04BBD5F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiBRQTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:19:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbiBRQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:56 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885283969B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201046; x=1676737046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hz/kh0uvaCIxwsvfeV4VXQp/Vpt7YUdFG5ImQMhC4rQ=;
  b=PGJ+XaNv+fYDZnz2bYEu8QkDArB89IhQMMfUYDO19QzJDg4cr2y6bXgj
   ttyZPGZ0mdFrfV6KtyA5u38eHjk+ixFvKnsuulSXUiYn+lUiE8LyqZOSF
   mTlvsoXMjN5FhIW3/vrKAA8vX2DrBvFIh78oVRrKXm7mSNAkqt3dRFybc
   ffbImfvKoh/4xcLd3cACHfrEysK5YFq/TPpdk2VYSw1ER1VnqDE97BQvH
   553JqT42bJ6v2XQY+0ONxpkwObdGYAsUdqB1qULolrT/sPoEZRWKCAJIC
   pCdF+DIEbVR0gdSqrDwq0sKcNXjJ1kCSqUiT7FB+2evL3umnWs9bUe2vg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="311897901"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="311897901"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="775328282"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 18 Feb 2022 08:17:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E123CAFD; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 18/32] x86/tdx: Add port I/O emulation
Date:   Fri, 18 Feb 2022 19:17:04 +0300
Message-Id: <20220218161718.67148-19-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx.c           | 54 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cc_platform.c |  7 ++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 74ab7c5a767d..e3693d0494a7 100644
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
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index dba713c444ab..55128de5e27c 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -18,7 +18,12 @@ static enum cc_vendor cc_vendor;
 
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
-- 
2.34.1

