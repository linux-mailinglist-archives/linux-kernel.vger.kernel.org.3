Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AA64B29DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350515AbiBKQNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:13:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbiBKQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:13:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534DDB70
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644596010; x=1676132010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VNewZQWxg7843LgS1I5+OZq1SFHHVX2AbG4mTSf5AaA=;
  b=MZKgZso1C5/ktag4khg0dMiFURN3t5DfzYjhcfrHkBLthnOkUe0640jq
   4/DBcOO+M4lEn6JaYOOPZaSeKeuaFLTmVIDeoY4hdwzvRpHg72y5sQQOw
   hql1o1Ybs1Cgw5RsZfOdFI2nBo9MmocmZrnBQQY3pEgRWeXu+rkJe6F2V
   28wpf2LYwEr5gOT44UBOiNBLf1fD0XBVqyfZf9kkfQ1FpjSsVUW+bTguL
   S173t4TRhV5qoxSs7itA+5AFTpGDOfzusNB2udbpzX3qbYLynEyji1Ydg
   ps+64IEyp9XyHIhNlQOlqhVFAZOmXtJhDIBa+YQ1ypM24uiEF1QLUbbQD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="229723376"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="229723376"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:13:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="483479421"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2022 08:13:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E1C1193; Fri, 11 Feb 2022 18:13:38 +0200 (EET)
Date:   Fri, 11 Feb 2022 19:13:38 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 18/29] x86/boot: Avoid #VE during boot for TDX platforms
Message-ID: <20220211161338.uxjgib6psbpjw6t6@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-19-kirill.shutemov@linux.intel.com>
 <87sft2w2ul.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sft2w2ul.ffs@tglx>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 01:04:34AM +0100, Thomas Gleixner wrote:
> > +	orl	$X86_CR4_PAE, %eax
> >  	testl	%edx, %edx
> >  	jz	1f
> >  	orl	$X86_CR4_LA57, %eax
> > @@ -662,8 +675,12 @@ SYM_CODE_START(trampoline_32bit_src)
> >  	pushl	$__KERNEL_CS
> >  	pushl	%eax
> >  
> > -	/* Enable paging again */
> > -	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
> > +	/*
> > +	 * Enable paging again.  Keep CR0.NE set, FERR# is no longer used
> > +	 * to handle x87 FPU errors and clearing NE may fault in some
> > +	 * environments.
> 
> FERR# is no longer used is really not informative here. The point is
> that any x86 CPU which is supported by the kernel requires CR0_NE to be
> set. This code was wrong from the very beginning because 64bit CPUs
> never supported #FERR. The reason why it exists is Copy&Pasta without
> brain applied and the sad fact that the hardware does not enforce it in
> native mode for whatever reason. So this want's to be a seperate patch
> with a coherent comment and changelong.

What about the patch below?

Instead of adding CR0.NE there I used CR0_STATE instead or keep existing
value, only modifing required bit.

I'm not familiar with float-point execption handling. I tried to read up
on that in attempt to make coherent commit message. Please correct me if I
wrote something wrong.

---------------------------------8<----------------------------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 11 Feb 2022 14:25:10 +0300
Subject: [PATCH] x86/boot: Set CR0.NE early and keep it set during the boot
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TDX guest requires CR0.NE to be set. Clearing the bit triggers #GP(0).

If CR0.NE is 0, the MS-DOS compatibility mode for handling floating-point
exceptions is selected. In this mode, the software exception handler for
floating-point exceptions is invoked externally using the processor’s
FERR#, INTR, and IGNNE# pins.

Using FERR# and IGNNE# to handle floating-point exception is deprecated.
CR0.NE=0 also limits newer processors to operate with one logical
processor active.

Kernel uses CR0_STATE constant to initialize CR0. It has NE bit set.
But during early boot has more ad-hoc approach to setting bit in the
register.

Make CR0 initialization consistent, deriving the initial from CR0_STATE.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
 Kirill A. Shutemov
