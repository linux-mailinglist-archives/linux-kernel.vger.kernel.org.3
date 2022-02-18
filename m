Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF14BBD4A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiBRQTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:19:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiBRQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008413A5E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201047; x=1676737047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C/Kr5OtLyLFJ8JIEjNyBn5AW++nQARb4Poi2KZHPrbc=;
  b=DCSQRPyolIoJMHOxx9IIBD1kdWDgZU1CmbZFNum895//uBKeKGxunvsT
   waj0Ktn18X2jRef1y3aiYEeT/76abaBc0COepu79FaBBVoggNAK3xzrPv
   tKwB5hzcLg6Hvn8RkksGSO4j1uKoicguLZpk3uCGCKgsYRyrXWP367gtX
   ID5AZb8M34anoUxesDyeBzOAH3BGgum0adYE8+pMnfCetnlz9dva6fIpA
   AEV/A+L+eM9u8juf4s6TKjDbka+EqSu3w+gx2o3YTP6ot8po0vRZRXadq
   WgPLmbPk9eVvNMLzM1t1Y/1wq56xK1XMy4V4McSMO5+dnpicIO3HZ6lIq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238559747"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238559747"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="546333157"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2022 08:17:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EBEF2B2F; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
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
Subject: [PATCHv3 19/32] x86/tdx: Handle early boot port I/O
Date:   Fri, 18 Feb 2022 19:17:05 +0300
Message-Id: <20220218161718.67148-20-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

TDX guests cannot do port I/O directly. The TDX module triggers a #VE
exception to let the guest kernel emulate port I/O by converting them
into TDCALLs to call the host.

But before IDT handlers are set up, port I/O cannot be emulated using
normal kernel #VE handlers. To support the #VE-based emulation during
this boot window, add a minimal early #VE handler support in early
exception handlers. This is similar to what AMD SEV does. This is
mainly to support earlyprintk's serial driver, as well as potentially
the VGA driver.

The early handler only supports I/O-related #VE exceptions. Unhandled or
failed exceptions will be handled via early_fixup_exceptions() (like
normal exception failures).

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/coco/tdx.c        | 16 ++++++++++++++++
 arch/x86/include/asm/tdx.h |  4 ++++
 arch/x86/kernel/head64.c   |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index e3693d0494a7..d23d389124a1 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -344,6 +344,22 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
 	return ret;
 }
 
+/*
+ * Early #VE exception handler. Only handles a subset of port I/O.
+ * Intended only for earlyprintk. If failed, return false.
+ */
+__init bool tdx_early_handle_ve(struct pt_regs *regs)
+{
+	struct ve_info ve;
+
+	tdx_get_ve_info(&ve);
+
+	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
+		return false;
+
+	return handle_io(regs, ve.exit_qual);
+}
+
 void tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 54803cb6ccf5..ba0f8c2b185c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -56,11 +56,15 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
 void tdx_safe_halt(void);
 
+bool tdx_early_handle_ve(struct pt_regs *regs);
+
 #else
 
 static inline void tdx_early_init(void) { };
 static inline void tdx_safe_halt(void) { };
 
+static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 6dff50c3edd6..ecbf50e5b8e0 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -417,6 +417,9 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 	    trapnr == X86_TRAP_VC && handle_vc_boot_ghcb(regs))
 		return;
 
+	if (trapnr == X86_TRAP_VE && tdx_early_handle_ve(regs))
+		return;
+
 	early_fixup_exception(regs, trapnr);
 }
 
-- 
2.34.1

