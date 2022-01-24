Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6904982FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiAXPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:23292 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243112AbiAXPCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036562; x=1674572562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJwVQAG7o45vV5vgUUxYVws+NoT7gBA+wwZMCRe/ZT4=;
  b=gnJvZYPc03glISxxTUPeF8nM9j+KAPaNhyeP4sqklcbjQdQT2EC2eBFH
   F+Yj5Vb18WxNR9vs8K5pqXd4dfghRrE+H/vciVVpUvUxfPgGDhoke176c
   AGW1CKE+ByMq4oW5oM1ZGs8OYa/+rpidhiUDGKexleddZcVmY4FqRxZh6
   Y/pNuiVNK8KQTBSDdfpSOGv+ilxrQxqr1MRTbevi5bM2nZVOJAbA4EhxV
   bnOoTIqmMmrMdKy7kWAUA2c0eZNM6F70hYuI/H6jiMS8/NxVLNCIJYqyv
   IY1hQ3AseG3AiAjbFhKcznld9mcx77/Z74rfwJMSfsvU2MusUsEs0Pk3Z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306776624"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306776624"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="580395682"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2022 07:02:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 47F0EC62; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
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
Subject: [PATCHv2 20/29] x86/tdx: Get page shared bit info from the TDX module
Date:   Mon, 24 Jan 2022 18:02:06 +0300
Message-Id: <20220124150215.36893-21-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel TDX doesn't allow VMM to access guest private memory. Any memory
that is required for communication with the VMM must be shared
explicitly by setting a bit in the page table entry. Details about
which bit in the page table entry to be used to indicate shared/private
state can be determined by using the TDINFO TDCALL (call to TDX
module).

Fetch and save the guest TD execution environment information at
initialization time. The next patch will use the information.

More details about the TDINFO TDCALL can be found in
Guest-Host-Communication Interface (GHCI) for Intel Trust Domain
Extensions (Intel TDX) specification, sec titled "TDCALL[TDINFO]".

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index a4e696f12666..b27c4261bfd2 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -11,6 +11,7 @@
 #include <asm/insn-eval.h>
 
 /* TDX module Call Leaf IDs */
+#define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
 
 /* See Exit Qualification for I/O Instructions in VMX documentation */
@@ -19,6 +20,12 @@
 #define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
 #define VE_IS_IO_STRING(exit_qual)	((exit_qual) & 16 ? 1 : 0)
 
+/* Guest TD execution environment information */
+static struct {
+	unsigned int gpa_width;
+	unsigned long attributes;
+} td_info __ro_after_init;
+
 static bool tdx_guest_detected __ro_after_init;
 
 /*
@@ -59,6 +66,28 @@ long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
 #endif
 
+static void tdx_get_info(void)
+{
+	struct tdx_module_output out;
+	u64 ret;
+
+	/*
+	 * TDINFO TDX module call is used to get the TD execution environment
+	 * information like GPA width, number of available vcpus, debug mode
+	 * information, etc. More details about the ABI can be found in TDX
+	 * Guest-Host-Communication Interface (GHCI), sec 2.4.2 TDCALL
+	 * [TDG.VP.INFO].
+	 */
+	ret = __tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out);
+
+	/* Non zero return value indicates buggy TDX module, so panic */
+	if (ret)
+		panic("TDINFO TDCALL failed (Buggy TDX module!)\n");
+
+	td_info.gpa_width = out.rcx & GENMASK(5, 0);
+	td_info.attributes = out.rdx;
+}
+
 static u64 __cpuidle _tdx_halt(const bool irq_disabled, const bool do_sti)
 {
 	/*
@@ -455,5 +484,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	tdx_get_info();
+
 	pr_info("Guest detected\n");
 }
-- 
2.34.1

