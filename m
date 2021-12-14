Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659574745D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhLNPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:03:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:58261 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235154AbhLNPDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302372466"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="302372466"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="682087190"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2021 07:03:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B031DA14; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
Subject: [PATCH 12/26] x86/tdx: Early boot handling of port I/O
Date:   Tue, 14 Dec 2021 18:02:50 +0300
Message-Id: <20211214150304.62613-13-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

TDX guests cannot do port I/O directly. The TDX module triggers a #VE
exception to let the guest kernel emulate port I/O, by converting them
into TDCALLs to call the host.

But before IDT handlers are set up, port I/O cannot be emulated using
normal kernel #VE handlers. To support the #VE-based emulation during
this boot window, add a minimal early #VE handler support in early
exception handlers. This is similar to what AMD SEV does. This is
mainly to support earlyprintk's serial driver, as well as potentially
the VGA driver (although it is expected not to be used).

The early handler only supports I/O-related #VE exceptions. Unhandled or
failed exceptions will be handled via early_fixup_exceptions() (like
normal exception failures).

This early handler enables the use of normal in*/out* macros without
patching them for every driver. Since there is no expectation that
early port I/O is performance-critical, the #VE emulation cost is worth
the simplicity benefit of not patching the port I/O usage in early
code. There are also no concerns with nesting, since there should be
no NMIs or interrupts this early.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/tdx.h |  4 ++++
 arch/x86/kernel/head64.c   |  3 +++
 arch/x86/kernel/tdx.c      | 17 +++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 3be9d0e9f7a0..d2ffc9a6ba53 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -74,12 +74,16 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
 void tdx_guest_idle(void);
 
+bool tdx_early_handle_ve(struct pt_regs *regs);
+
 #else
 
 static inline void tdx_early_init(void) { };
 static inline bool is_tdx_guest(void) { return false; }
 static inline void tdx_guest_idle(void) { };
 
+static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 66deb2611dc5..d42996a28722 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -415,6 +415,9 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 	    trapnr == X86_TRAP_VC && handle_vc_boot_ghcb(regs))
 		return;
 
+	if (trapnr == X86_TRAP_VE && tdx_early_handle_ve(regs))
+		return;
+
 	early_fixup_exception(regs, trapnr);
 }
 
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 00bf02bc9838..82e848006e3e 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -304,6 +304,23 @@ static bool tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
 	return !ret;
 }
 
+/*
+ * Early #VE exception handler. Only handles a subset of port I/O.
+ * Intended only for earlyprintk. If failed, return false.
+ */
+__init bool tdx_early_handle_ve(struct pt_regs *regs)
+{
+	struct ve_info ve;
+
+	if (tdx_get_ve_info(&ve))
+		return false;
+
+	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
+		return false;
+
+	return tdx_handle_io(regs, ve.exit_qual);
+}
+
 bool tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
-- 
2.32.0

