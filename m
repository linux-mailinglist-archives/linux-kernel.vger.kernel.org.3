Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067B24745E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhLNPE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:04:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:28585 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235219AbhLNPDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225852744"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="225852744"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="519249961"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2021 07:03:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DA49BCC1; Tue, 14 Dec 2021 17:03:09 +0200 (EET)
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
Subject: [PATCH 15/26] x86/boot: Avoid #VE during boot for TDX platforms
Date:   Tue, 14 Dec 2021 18:02:53 +0300
Message-Id: <20211214150304.62613-16-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 * Clearing CR0.NE
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
 arch/x86/boot/compressed/head_64.S   | 25 +++++++++++++++++++++----
 arch/x86/boot/compressed/pgtable.h   |  2 +-
 arch/x86/kernel/head_64.S            | 24 ++++++++++++++++++++++--
 arch/x86/realmode/rm/trampoline_64.S | 27 +++++++++++++++++++++++----
 5 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8e781f166030..fc4771a07fc0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -878,6 +878,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	select ARCH_HAS_CC_PLATFORM
+	select X86_MCE
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 572c535cf45b..dbbfafba553f 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -643,12 +643,25 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	$MSR_EFER, %ecx
 	rdmsr
 	btsl	$_EFER_LME, %eax
+	/* Avoid writing EFER if no change was made (for TDX guest) */
+	jc	1f
 	wrmsr
-	popl	%edx
+1:	popl	%edx
 	popl	%ecx
 
 	/* Enable PAE and LA57 (if required) paging modes */
-	movl	$X86_CR4_PAE, %eax
+	movl	%cr4, %eax
+
+#ifdef CONFIG_X86_MCE
+	/*
+	 * Preserve CR4.MCE if the kernel will enable #MC support.  Clearing
+	 * MCE may fault in some environments (that also force #MC support).
+	 * Any machine check that occurs before #MC support is fully configured
+	 * will crash the system regardless of the CR4.MCE value set here.
+	 */
+	andl	$X86_CR4_MCE, %eax
+#endif
+	orl	$X86_CR4_PAE, %eax
 	testl	%edx, %edx
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
@@ -662,8 +675,12 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushl	$__KERNEL_CS
 	pushl	%eax
 
-	/* Enable paging again */
-	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
+	/*
+	 * Enable paging again.  Keep CR0.NE set, FERR# is no longer used
+	 * to handle x87 FPU errors and clearing NE may fault in some
+	 * environments.
+	 */
+	movl	$(X86_CR0_PG | X86_CR0_NE | X86_CR0_PE), %eax
 	movl	%eax, %cr0
 
 	lret
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
index d8b3ebd2bb85..f503e97945d3 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -141,7 +141,17 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 1:
 
 	/* Enable PAE mode, PGE and LA57 */
-	movl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
+	movq	%cr4, %rcx
+#ifdef CONFIG_X86_MCE
+	/*
+	 * Preserve CR4.MCE if the kernel will enable #MC support.  Clearing
+	 * MCE may fault in some environments (that also force #MC support).
+	 * Any machine check that occurs before #MC support is fully configured
+	 * will crash the system regardless of the CR4.MCE value set here.
+	 */
+	andl	$X86_CR4_MCE, %ecx
+#endif
+	orl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
 	testl	$1, __pgtable_l5_enabled(%rip)
 	jz	1f
@@ -229,13 +239,23 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
index ae112a91592f..170f248d5769 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -143,13 +143,28 @@ SYM_CODE_START(startup_32)
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
 
-	# Enable paging and in turn activate Long Mode
-	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_PE), %eax
+.Ldone_efer:
+	/*
+	 * Enable paging and in turn activate Long Mode. Keep CR0.NE set, FERR#
+	 * is no longer used to handle x87 FPU errors and clearing NE may fault
+	 * in some environments.
+	 */
+	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_NE | X86_CR0_PE), %eax
 	movl	%eax, %cr0
 
 	/*
@@ -169,7 +184,11 @@ SYM_CODE_START(pa_trampoline_compat)
 	movl	$rm_stack_end, %esp
 	movw	$__KERNEL_DS, %dx
 
-	movl	$X86_CR0_PE, %eax
+	/*
+	 * Keep CR0.NE set, FERR# is no longer used to handle x87 FPU errors
+	 * and clearing NE may fault in some environments.
+	 */
+	movl	$(X86_CR0_NE | X86_CR0_PE), %eax
 	movl	%eax, %cr0
 	ljmpl   $__KERNEL32_CS, $pa_startup_32
 SYM_CODE_END(pa_trampoline_compat)
-- 
2.32.0

