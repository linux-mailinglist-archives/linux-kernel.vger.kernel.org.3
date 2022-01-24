Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E44982EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243355AbiAXPDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:63896 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239091AbiAXPC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036547; x=1674572547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c1HfnQEB9O1TcYNGiH9nKcRDKpMRlZ4Nz2csO46l184=;
  b=CT5e2TETwZqPFUnSVgESHjkDAtpWBZMp8SHiw/0jzKp4lWGQJgl97nTV
   92yOgIp4GXoFPUB25uLjp242JI4kk63FijOsDq9Z1znv9nYtctBP3qVfo
   URcGBMsauSlSbdtF1yAvJ2IpzyMDYSPALeWiCSjxqOE0mV3mYCakkVsl1
   DCEd3oPLXirOBQ72aUwo99hAWaaJsyD8AE1vrlkqx4kbQU/yN2Qww5Lri
   yWtWxwmMfJBcTbHLpkm0xXnGuGVQvCGddRE78a85zIsIJQE00ZRT5SgCa
   C+Dc39Xn2r9MXxhGHMj8UyxWzMTiwX4rNVG6jviATWvh6PuCzeW1kTDPs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226734684"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226734684"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476743304"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2022 07:02:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id F19C69F0; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
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
Subject: [PATCHv2 13/29] x86/tdx: Add port I/O emulation
Date:   Mon, 24 Jan 2022 18:01:59 +0300
Message-Id: <20220124150215.36893-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/x86/kernel/cc_platform.c |  3 +++
 arch/x86/kernel/tdx.c         | 48 +++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index c72b3919bca9..8da246ab4339 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -17,6 +17,9 @@
 
 static bool intel_cc_platform_has(enum cc_attr attr)
 {
+	if (attr == CC_ATTR_GUEST_UNROLL_STRING_IO)
+		return true;
+
 	return false;
 }
 
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 8e630eeb765d..e73af22a4c11 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -13,6 +13,12 @@
 /* TDX module Call Leaf IDs */
 #define TDX_GET_VEINFO			3
 
+/* See Exit Qualification for I/O Instructions in VMX documentation */
+#define VE_IS_IO_IN(exit_qual)		(((exit_qual) & 8) ? 1 : 0)
+#define VE_GET_IO_SIZE(exit_qual)	(((exit_qual) & 7) + 1)
+#define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
+#define VE_IS_IO_STRING(exit_qual)	((exit_qual) & 16 ? 1 : 0)
+
 static bool tdx_guest_detected __ro_after_init;
 
 /*
@@ -257,6 +263,45 @@ static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	return insn.length;
 }
 
+/*
+ * Emulate I/O using hypercall.
+ *
+ * Assumes the IO instruction was using ax, which is enforced
+ * by the standard io.h macros.
+ *
+ * Return True on success or False on failure.
+ */
+static bool tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
+{
+	struct tdx_hypercall_output out;
+	int size, port, ret;
+	u64 mask;
+	bool in;
+
+	if (VE_IS_IO_STRING(exit_qual))
+		return false;
+
+	in   = VE_IS_IO_IN(exit_qual);
+	size = VE_GET_IO_SIZE(exit_qual);
+	port = VE_GET_PORT_NUM(exit_qual);
+	mask = GENMASK(BITS_PER_BYTE * size, 0);
+
+	/*
+	 * Emulate the I/O read/write via hypercall. More info about
+	 * ABI can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI) sec titled "TDG.VP.VMCALL<Instruction.IO>".
+	 */
+	ret = _tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, !in, port,
+			     in ? 0 : regs->ax, &out);
+	if (!in)
+		return !ret;
+
+	regs->ax &= ~mask;
+	regs->ax |= ret ? UINT_MAX : out.r11 & mask;
+
+	return !ret;
+}
+
 bool tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -333,6 +378,9 @@ static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 		if (!ret)
 			pr_warn_once("MMIO failed\n");
 		break;
+	case EXIT_REASON_IO_INSTRUCTION:
+		ret = tdx_handle_io(regs, ve->exit_qual);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		break;
-- 
2.34.1

