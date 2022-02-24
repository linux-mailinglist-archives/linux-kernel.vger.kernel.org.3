Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760FB4C308B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiBXP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiBXP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D90064F8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718199; x=1677254199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jw3+L9J/up2HJodxYOGI6M1WsdFVeMG1Qu1QbhliuCY=;
  b=FGn/A5xCIu/UUyUNhFrVoNn0IzfZOtINmkEfeyOCPQaylKncRE+jT2S9
   bDAw8MgjyNB3Y4WhWv0py9wJVBFdczMiORbDGvOZQ/B5PsAOaOSBpnHnu
   GDCuLr64Nr38zBTrc1VtDV0ntIv0FmE6GttOpJGBxY2V4slW6YDYq/Alb
   V9xuiyFCamHe8fQ/2vwpAs/sJZpKQ0OnJ2CCuCNQFz/OhMvRNO8nw/CKZ
   xgcpeNjMPfkBjWYr2UjUlRf76gMGuCmj1B2lVD6v2uGdlU+EATXG7wMqu
   Qv+qryYoX95A1FTZFcPHFef8VEF5TFvjyvHNNzIOQq8DCTBp9SLf6kzbi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252186792"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252186792"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:56:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="684315492"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 07:56:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 637F8B1F; Thu, 24 Feb 2022 17:56:35 +0200 (EET)
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
Subject: [PATCHv4 23/30] x86/boot: Avoid #VE during boot for TDX platforms
Date:   Thu, 24 Feb 2022 18:56:23 +0300
Message-Id: <20220224155630.52734-24-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

There are a few MSRs and control register bits that the kernel
normally needs to modify during boot. But, TDX disallows
modification of these registers to help provide consistent security
guarantees. Fortunately, TDX ensures that these are all in the correct
state before the kernel loads, which means the kernel does not need to
modify them.

The conditions to avoid are:

 * Any writes to the EFER MSR
 * Clearing CR3.MCE

This theoretically makes the guest boot more fragile. If, for instance,
EFER was set up incorrectly and a WRMSR was performed, it will trigger
early exception panic or a triple fault, if it's before early
exceptions are set up. However, this is likely to trip up the guest
BIOS long before control reaches the kernel. In any case, these kinds
of problems are unlikely to occur in production environments, and
developers have good debug tools to fix them quickly.

Change the common boot code to work on TDX and non-TDX systems.
This should have no functional effect on non-TDX systems.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/boot/compressed/head_64.S   | 20 ++++++++++++++++++--
 arch/x86/boot/compressed/pgtable.h   |  2 +-
 arch/x86/kernel/head_64.S            | 28 ++++++++++++++++++++++++++--
 arch/x86/realmode/rm/trampoline_64.S | 13 ++++++++++++-
 5 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d2f45e58e846..98efb35ed7b1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -886,6 +886,7 @@ config INTEL_TDX_GUEST
 	depends on X86_X2APIC
 	select ARCH_HAS_CC_PLATFORM
 	select DYNAMIC_PHYSICAL_MASK
+	select X86_MCE
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d0c3d33f3542..6d903b2fc544 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -643,12 +643,28 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	$MSR_EFER, %ecx
 	rdmsr
 	btsl	$_EFER_LME, %eax
+	/* Avoid writing EFER if no change was made (for TDX guest) */
+	jc	1f
 	wrmsr
-	popl	%edx
+1:	popl	%edx
 	popl	%ecx
 
+#ifdef CONFIG_X86_MCE
+	/*
+	 * Preserve CR4.MCE if the kernel will enable #MC support.
+	 * Clearing MCE may fault in some environments (that also force #MC
+	 * support). Any machine check that occurs before #MC support is fully
+	 * configured will crash the system regardless of the CR4.MCE value set
+	 * here.
+	 */
+	movl	%cr4, %eax
+	andl	$X86_CR4_MCE, %eax
+#else
+	movl	$0, %eax
+#endif
+
 	/* Enable PAE and LA57 (if required) paging modes */
-	movl	$X86_CR4_PAE, %eax
+	orl	$X86_CR4_PAE, %eax
 	testl	%edx, %edx
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 6ff7e81b5628..cc9b2529a086 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,7 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0x70
+#define TRAMPOLINE_32BIT_CODE_SIZE	0x80
 
 #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 9c63fc5988cd..184b7468ea76 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -140,8 +140,22 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	addq	$(init_top_pgt - __START_KERNEL_map), %rax
 1:
 
+#ifdef CONFIG_X86_MCE
+	/*
+	 * Preserve CR4.MCE if the kernel will enable #MC support.
+	 * Clearing MCE may fault in some environments (that also force #MC
+	 * support). Any machine check that occurs before #MC support is fully
+	 * configured will crash the system regardless of the CR4.MCE value set
+	 * here.
+	 */
+	movq	%cr4, %rcx
+	andl	$X86_CR4_MCE, %ecx
+#else
+	movl	$0, %ecx
+#endif
+
 	/* Enable PAE mode, PGE and LA57 */
-	movl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
+	orl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
 	testl	$1, __pgtable_l5_enabled(%rip)
 	jz	1f
@@ -246,13 +260,23 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Setup EFER (Extended Feature Enable Register) */
 	movl	$MSR_EFER, %ecx
 	rdmsr
+	/*
+	 * Preserve current value of EFER for comparison and to skip
+	 * EFER writes if no change was made (for TDX guest)
+	 */
+	movl    %eax, %edx
 	btsl	$_EFER_SCE, %eax	/* Enable System Call */
 	btl	$20,%edi		/* No Execute supported? */
 	jnc     1f
 	btsl	$_EFER_NX, %eax
 	btsq	$_PAGE_BIT_NX,early_pmd_flags(%rip)
-1:	wrmsr				/* Make changes effective */
 
+	/* Avoid writing EFER if no change was made (for TDX guest) */
+1:	cmpl	%edx, %eax
+	je	1f
+	xor	%edx, %edx
+	wrmsr				/* Make changes effective */
+1:
 	/* Setup cr0 */
 	movl	$CR0_STATE, %eax
 	/* Make changes effective */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index d380f2d1fd23..e38d61d6562e 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -143,11 +143,22 @@ SYM_CODE_START(startup_32)
 	movl	%eax, %cr3
 
 	# Set up EFER
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	/*
+	 * Skip writing to EFER if the register already has desired
+	 * value (to avoid #VE for the TDX guest).
+	 */
+	cmp	pa_tr_efer, %eax
+	jne	.Lwrite_efer
+	cmp	pa_tr_efer + 4, %edx
+	je	.Ldone_efer
+.Lwrite_efer:
 	movl	pa_tr_efer, %eax
 	movl	pa_tr_efer + 4, %edx
-	movl	$MSR_EFER, %ecx
 	wrmsr
 
+.Ldone_efer:
 	# Enable paging and in turn activate Long Mode.
 	movl	$CR0_STATE, %eax
 	movl	%eax, %cr0
-- 
2.34.1

