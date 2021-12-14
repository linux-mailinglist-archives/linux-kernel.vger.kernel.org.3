Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC194745D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhLNPDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:03:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:25418 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235159AbhLNPDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263135014"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="263135014"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="754837224"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2021 07:03:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 01939D2E; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
Subject: [PATCH 17/26] x86/tdx: Get page shared bit info from the TDX Module
Date:   Tue, 14 Dec 2021 18:02:55 +0300
Message-Id: <20211214150304.62613-18-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
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
Module).

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
index 82e848006e3e..b55bc1879d1e 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -11,6 +11,7 @@
 #include <asm/insn-eval.h>
 
 /* TDX Module Call Leaf IDs */
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
@@ -45,6 +52,28 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
 	return out->r10;
 }
 
+static void tdx_get_info(void)
+{
+	struct tdx_module_output out;
+	u64 ret;
+
+	/*
+	 * TDINFO TDX Module call is used to get the TD execution environment
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
 static __cpuidle u64 _tdx_halt(const bool irq_disabled, const bool do_sti)
 {
 	/*
@@ -448,5 +477,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	tdx_get_info();
+
 	pr_info("Guest detected\n");
 }
-- 
2.32.0

