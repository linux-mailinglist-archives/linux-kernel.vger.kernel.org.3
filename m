Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC6B4BBD57
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiBRQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:19:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbiBRQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:18:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFFF3A5F1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201065; x=1676737065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XeiDSHDhSk1ZAnWl9C35VO6F89iKjoQMuwzkA1dSo5A=;
  b=ec/x21q49yR3xXkV1rg+h7mSQbDHlXh3ZTDnWULLt4M7FJ0x9NZw59bc
   6m3SwFiYbCTkseE1yTX8Roz/nhwR3WF0aNpJaxkLV0+AnLsBVf0BcpRwL
   QV9pULGkexFE9riqt1ZH7ofV0QwOEBX3aW3v+W1ECTk2ZXABnsLMR3AFL
   eJEa+uMMTm1PC3pk0ht89ySNMxQi/Gj44XvcWxDsbWDV2P7MF74ekIMa3
   p1dlUiA/eKiOwqR/lr46y61w9g89OgrbqiOv2kwC5yyhiDSuVpjSCaN6c
   Yic2421eBG63NbhiTJzQ0MZLk8W3vUWt8hsDSYRZMKAyjOkcAPJe6rlWn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="275753730"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="275753730"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="605590602"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Feb 2022 08:17:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2F36CD50; Fri, 18 Feb 2022 18:17:23 +0200 (EET)
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
Subject: [PATCHv3 23/32] x86/boot: Set CR0.NE early and keep it set during the boot
Date:   Fri, 18 Feb 2022 19:17:09 +0300
Message-Id: <20220218161718.67148-24-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
in the register.

Make CR0 initialization consistent, deriving the initial value of CR0
from CR0_STATE.

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
2.34.1

