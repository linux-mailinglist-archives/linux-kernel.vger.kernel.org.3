Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4A4C3087
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiBXP61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiBXP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A2722BD2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718201; x=1677254201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SwPKQO76m89JoirDvi2nnnrqzpm+q2wRGmsqNDkdK+4=;
  b=WAKMSrUhdXMwnmQuxKHDNT9Pok13nObHvgDoQml9W+2Cf0RJBWRNPFx7
   opd4m2kXhDmGi79ttJ0nwRaMccFPDgyT9rq0+BK+VC1nRMjWyGRGCNU6A
   VinLkOV6MbDZi9nma6s/M8JXJJpWDEgRn77qqjbbMtCJLPKxIiWZ3U+G4
   FEPmy2EK+kJTyT69XK90/3RZsLKnZhq/GiGP+yN38xrIxeK/BYuOcyJQv
   zhndTWjI/xuufq9z5kAD0QUFwly2rWKiN8BA33mELuRaFYMNMXq6itL26
   iCXe+n5gJoFkl3DT3UwP82bpqOct5G0hbQ81aj6XCVSe1ouC17rHx6+mz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232241507"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="232241507"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:56:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="707500703"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 24 Feb 2022 07:56:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1D16CABE; Thu, 24 Feb 2022 17:56:35 +0200 (EET)
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
Subject: [PATCHv4 18/30] x86/tdx: Handle early boot port I/O
Date:   Thu, 24 Feb 2022 18:56:18 +0300
Message-Id: <20220224155630.52734-19-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 2e342760b1d2..0d2a4c947a6c 100644
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

