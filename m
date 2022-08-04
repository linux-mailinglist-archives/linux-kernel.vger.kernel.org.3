Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD81589EA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbiHDP1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbiHDP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:27:02 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E89921245
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:27:01 -0700 (PDT)
Received: from linux.gnuweeb.org (linux.gnuweeb.org [172.17.0.3])
        by gnuweeb.org (Postfix) with ESMTPSA id C9CF980824;
        Thu,  4 Aug 2022 15:26:59 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1659626819;
        bh=68rTIH0eFDH22btA2mHFxCrk2JgnI4c4cR1MRsdEsU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtU+5uYzKOlNEpC6LGb5WB9y5VJJUXGx0gJpj5T0GY+VZDtYWWe5fRmGBOolQ9A4i
         ae1aeGEpRVUU4Qq2EXmXti5q3NDiV5olFKigV8GbS6a1Ec1dw2Gk3fqzIkuXr2n6lY
         Qhu4UnjRMJMbC+flplg8Y9ryGNTd1XImI+oslXB5DD6FhqT0c+mfLf6Qwdl/M/EZ72
         qvcPcDVKdi5/DgXU+ddR3tCIKt6QsNeMRvAgDt6/cOZ/LHPDu71E5HBTbzGA++pdc1
         3VDU7hrxNw1CWg/Zo8jUCrV/e6j1eK2FB9Yj+oS4Y1A2LavjgVHrMBJhPeGwTcDIRE
         Y1ZxJkxntuLJQ==
From:   Kanna Scarlet <knscarlet@gnuweeb.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Kanna Scarlet <knscarlet@gnuweeb.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Roth <michael.roth@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
Date:   Thu,  4 Aug 2022 15:26:55 +0000
Message-Id: <20220804152656.8840-2-knscarlet@gnuweeb.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804152656.8840-1-knscarlet@gnuweeb.org>
References: <20220804152656.8840-1-knscarlet@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change mov $0, %reg with xor %reg, %reg because xor %reg, %reg is
smaller so it is good to save space

asm:
ba 00 00 00 00  movl   $0x0,%edx
31 d2           xorl   %edx,%edx

Suggested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Kanna Scarlet <knscarlet@gnuweeb.org>
---
 arch/x86/boot/compressed/head_64.S     | 2 +-
 arch/x86/boot/compressed/mem_encrypt.S | 2 +-
 arch/x86/kernel/ftrace_32.S            | 4 ++--
 arch/x86/kernel/head_64.S              | 2 +-
 arch/x86/math-emu/div_Xsig.S           | 2 +-
 arch/x86/math-emu/reg_u_sub.S          | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d33f060900d2..39442e7f5993 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -666,7 +666,7 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%cr4, %eax
 	andl	$X86_CR4_MCE, %eax
 #else
-	movl	$0, %eax
+	xorl	%eax, %eax
 #endif
 
 	/* Enable PAE and LA57 (if required) paging modes */
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index a73e4d783cae..d1e4d3aa8395 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -111,7 +111,7 @@ SYM_CODE_START(startup32_vc_handler)
 	cmpl	$0x72, 16(%esp)
 	jne	.Lfail
 
-	movl	$0, %eax		# Request CPUID[fn].EAX
+	xorl	%eax, %eax		# Request CPUID[fn].EAX
 	movl	%ebx, %edx		# CPUID fn
 	call	sev_es_req_cpuid	# Call helper
 	testl	%eax, %eax		# Check return code
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index a0ed0e4a2c0c..cff7decb58be 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -171,7 +171,7 @@ SYM_CODE_START(ftrace_graph_caller)
 	movl	3*4(%esp), %eax
 	/* Even with frame pointers, fentry doesn't have one here */
 	lea	4*4(%esp), %edx
-	movl	$0, %ecx
+	xorl	%ecx, %ecx
 	subl	$MCOUNT_INSN_SIZE, %eax
 	call	prepare_ftrace_return
 	popl	%edx
@@ -184,7 +184,7 @@ SYM_CODE_END(ftrace_graph_caller)
 return_to_handler:
 	pushl	%eax
 	pushl	%edx
-	movl	$0, %eax
+	xorl	%eax, %eax
 	call	ftrace_return_to_handler
 	movl	%eax, %ecx
 	popl	%edx
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d860d437631b..eeb06047e30a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -184,7 +184,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	%cr4, %rcx
 	andl	$X86_CR4_MCE, %ecx
 #else
-	movl	$0, %ecx
+	xorl	%ecx, %ecx
 #endif
 
 	/* Enable PAE mode, PGE and LA57 */
diff --git a/arch/x86/math-emu/div_Xsig.S b/arch/x86/math-emu/div_Xsig.S
index 8c270ab415be..5767b4d23954 100644
--- a/arch/x86/math-emu/div_Xsig.S
+++ b/arch/x86/math-emu/div_Xsig.S
@@ -122,7 +122,7 @@ SYM_FUNC_START(div_Xsig)
 	movl	XsigLL(%esi),%eax
 	rcrl	%eax
 	movl	%eax,FPU_accum_1
-	movl	$0,%eax
+	xorl	%eax,%eax
 	rcrl	%eax
 	movl	%eax,FPU_accum_0
 
diff --git a/arch/x86/math-emu/reg_u_sub.S b/arch/x86/math-emu/reg_u_sub.S
index 4c900c29e4ff..130b49fa1ca2 100644
--- a/arch/x86/math-emu/reg_u_sub.S
+++ b/arch/x86/math-emu/reg_u_sub.S
@@ -212,7 +212,7 @@ L_must_be_zero:
 L_shift_32:
 	movl	%ebx,%eax
 	movl	%edx,%ebx
-	movl	$0,%edx
+	xorl	%edx,%edx
 	subw	$32,EXP(%edi)	/* Can get underflow here */
 
 /* We need to shift left by 1 - 31 bits */
-- 
Kanna Scarlet

