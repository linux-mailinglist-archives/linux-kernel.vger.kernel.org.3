Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E934CA826
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiCBObG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243049AbiCBO3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:29:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F753E32
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231304; x=1677767304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WS5Q7BgxLXBWcRJDdCeKCSCtFtPpW1Fk6DSiIbIbKOQ=;
  b=J8TQG4hzSmfGb3p3tBk/FD42ONKUFGd9eMNSw/mDvmU/xObcNPV6LvBv
   qNSevglbJ8Y3VyHibL8Cj/kVRQGT45aWC28d/r1yhrAEJEGBv175qsvEt
   FeItCd+w0Cx5I9OEkuNwZqEGAdcGqJv2TODIDLEb2R8x8E0TBuDiMmhjq
   VEGo47d2vRI9Pjj1TMMIpC5huiZ+RvdVYDi8CKFq70eOEmj6bi0VIjtBC
   s0LWbsmDPJAx2idKQ83YGS2pMnQ+FdqTj/WJEB0kfqc+EpBGVZCw87pwO
   OPORXh3hAx10rG/f9ZAMCVGtwnrCwW6xl5sdKeRnivI9dJVKYervW37ej
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233376491"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="233376491"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="639791193"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2022 06:28:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B7AB84DA; Wed,  2 Mar 2022 16:28:12 +0200 (EET)
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv5 18/30] x86/tdx: Port I/O: add early boot support
Date:   Wed,  2 Mar 2022 17:27:54 +0300
Message-Id: <20220302142806.51844-19-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
normal exception failures). At runtime I/O-related #VE exceptions (along
with other types) handled by virt_exception_kernel().

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/coco/tdx.c        | 16 ++++++++++++++++
 arch/x86/include/asm/tdx.h |  4 ++++
 arch/x86/kernel/head64.c   |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 1f58375f61df..391a05c7b1da 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -389,6 +389,22 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
 		return handle_out(regs, size, port);
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
index 10f39bec7c7d..c20062698198 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -64,11 +64,15 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
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

