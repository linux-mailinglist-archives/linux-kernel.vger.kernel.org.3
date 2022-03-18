Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76794DDCF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiCRPda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiCRPcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:32:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CD21760C8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617459; x=1679153459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aja104HIf6wRILxqTg0MXkoRQclPoguBXAUavtna1c8=;
  b=E2FOpuVtRqzYo/34LI35AtnzoGEnKmb6ikCjSHRhqZOciVtvQ/pMf3Gz
   ldCjyJCU3ApaSVfpqEVDgEuUbsIZg1GzTbkXYxL2CZ9GH31oT482Vgp47
   S9tFOuL0TLmg2QGF7Zs9ZOO5vJxWX0UFQwmc4iUBFziHNQpVgYqfKdnST
   jfoEWZGhSY+tu9LlxPqCtaoOgs1j3KQqiw0yIvuW+qQhUy+Q0eJfyPYZ2
   PXAC+wS08CNjb+jPgCnaQtvWn0E4lkAoAS/xmspXK1VTPfq/8n/ixZ7B8
   dx+QPBQpOVWtP0n/NSXgCiDVKLc+kaa/bNMh89eBHQS56nMaEDnvgVLdw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="255982620"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="255982620"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="513919405"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2022 08:30:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CB7CC8E4; Fri, 18 Mar 2022 17:30:50 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv7 22/30] x86/boot: Set CR0.NE early and keep it set during the boot
Date:   Fri, 18 Mar 2022 18:30:40 +0300
Message-Id: <20220318153048.51177-23-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX guest requires CR0.NE to be set. Clearing the bit triggers #GP(0).

If CR0.NE is 0, the MS-DOS compatibility mode for handling floating-point
exceptions is selected. In this mode, the software exception handler for
floating-point exceptions is invoked externally using the processor’s
FERR#, INTR, and IGNNE# pins.

Using FERR# and IGNNE# to handle floating-point exception is deprecated.
CR0.NE=0 also limits newer processors to operate with one logical
processor active.

Kernel uses CR0_STATE constant to initialize CR0. It has NE bit set.
But during early boot kernel has more ad-hoc approach to setting bit
in the register. During some of this ad-hoc manipulation, CR0.NE is
cleared. This causes a #GP in TDX guests and makes it die in early boot.

Make CR0 initialization consistent, deriving the initial value of CR0
from CR0_STATE. Since CR0_STATE always has CR0.NE=1, this ensures that
CR0.NE is never 0 and avoids the #GP.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/boot/compressed/head_64.S   | 7 ++++---
 arch/x86/realmode/rm/trampoline_64.S | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fd9441f40457..d0c3d33f3542 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -289,7 +289,7 @@ SYM_FUNC_START(startup_32)
 	pushl	%eax
 
 	/* Enter paged protected Mode, activating Long Mode */
-	movl	$(X86_CR0_PG | X86_CR0_PE), %eax /* Enable Paging and Protected mode */
+	movl	$CR0_STATE, %eax
 	movl	%eax, %cr0
 
 	/* Jump from 32bit compatibility mode into 64bit mode. */
@@ -662,8 +662,9 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushl	$__KERNEL_CS
 	pushl	%eax
 
-	/* Enable paging again */
-	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
+	/* Enable paging again. */
+	movl	%cr0, %eax
+	btsl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 
 	lret
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index ae112a91592f..d380f2d1fd23 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -70,7 +70,7 @@ SYM_CODE_START(trampoline_start)
 	movw	$__KERNEL_DS, %dx	# Data segment descriptor
 
 	# Enable protected mode
-	movl	$X86_CR0_PE, %eax	# protected mode (PE) bit
+	movl	$(CR0_STATE & ~X86_CR0_PG), %eax
 	movl	%eax, %cr0		# into protected mode
 
 	# flush prefetch and jump to startup_32
@@ -148,8 +148,8 @@ SYM_CODE_START(startup_32)
 	movl	$MSR_EFER, %ecx
 	wrmsr
 
-	# Enable paging and in turn activate Long Mode
-	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_PE), %eax
+	# Enable paging and in turn activate Long Mode.
+	movl	$CR0_STATE, %eax
 	movl	%eax, %cr0
 
 	/*
@@ -169,7 +169,7 @@ SYM_CODE_START(pa_trampoline_compat)
 	movl	$rm_stack_end, %esp
 	movw	$__KERNEL_DS, %dx
 
-	movl	$X86_CR0_PE, %eax
+	movl	$(CR0_STATE & ~X86_CR0_PG), %eax
 	movl	%eax, %cr0
 	ljmpl   $__KERNEL32_CS, $pa_startup_32
 SYM_CODE_END(pa_trampoline_compat)
-- 
2.34.1

