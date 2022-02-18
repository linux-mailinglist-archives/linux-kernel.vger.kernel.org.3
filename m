Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AA24BBE30
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiBRRQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:16:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiBRRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00944D9FF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OS+OXrxkCjB0CbzDPGpVL+JNryaY3jwFx8CPkYYuhvk=; b=OgokgflfjPq3B2GQr3adelV6Va
        c0csuH3VvpGe9CAfpu86GiPNp7oOrM6MbbNun5IyOb6sooXlmWPOt5s2HGDEAIPHqWGFXdwb72OKI
        gQWF6uVyk1yTv72n/DyaBlHlCMj18OLJdIgJhhSuqQoMOKxy9qhp6rVwMH+itN9s0/iOu1Y7IY37h
        CtmqaJTDRvzT2j1cXl0cJgdIc4zjL9MT+7bWUURsZrcGXWJbIVO9gnGp1617I4Awr+QWI35re/6Er
        3bp2UN405FfuM4JmcGb2Xz62GG0nOBIhNUsYy1PRdz7IJHlpdtVBi0+4pxVSoMf7Fw/NOkmD5UZuy
        r8wzzBXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00AsBf-JB; Fri, 18 Feb 2022 17:14:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF654301A96;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 520B929A07E01; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.696743603@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 19/29] x86/ibt,xen: Annotate away warnings
References: <20220218164902.008644515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xen_iret ENDBR is needed for pre-alternative code calling the
pv_ops using indirect calls.

The rest look like hypervisor entry points which will be IRET like
transfers and as such don't need ENDBR.

The hypercall page comes from the hypervisor, there might or might not
be ENDBR there, not our problem.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |    1 +
 arch/x86/kernel/head_64.S |    1 +
 arch/x86/xen/xen-asm.S    |    8 ++++++++
 arch/x86/xen/xen-head.S   |    5 +++--
 4 files changed, 13 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -818,6 +818,7 @@ SYM_CODE_END(exc_xen_hypervisor_callback
  */
 SYM_CODE_START(xen_failsafe_callback)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	movl	%ds, %ecx
 	cmpw	%cx, 0x10(%rsp)
 	jne	1f
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -392,6 +392,7 @@ SYM_CODE_START(early_idt_handler_array)
 	.endr
 	UNWIND_HINT_IRET_REGS offset=16 entry=0
 SYM_CODE_END(early_idt_handler_array)
+	ANNOTATE_NOENDBR // early_idt_handler_array[NUM_EXCEPTION_VECTORS]
 
 SYM_CODE_START_LOCAL(early_idt_handler_common)
 	/*
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -122,6 +122,7 @@ SYM_FUNC_END(xen_read_cr2_direct);
 .macro xen_pv_trap name
 SYM_CODE_START(xen_\name)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	pop %rcx
 	pop %r11
 	jmp  \name
@@ -162,6 +163,7 @@ SYM_CODE_START(xen_early_idt_handler_arr
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	pop %rcx
 	pop %r11
 	jmp early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE
@@ -169,6 +171,7 @@ SYM_CODE_START(xen_early_idt_handler_arr
 	.fill xen_early_idt_handler_array + i*XEN_EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
 SYM_CODE_END(xen_early_idt_handler_array)
+	ANNOTATE_NOENDBR
 	__FINIT
 
 hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
@@ -189,6 +192,7 @@ hypercall_iret = hypercall_page + __HYPE
  */
 SYM_CODE_START(xen_iret)
 	UNWIND_HINT_EMPTY
+	ENDBR
 	pushq $0
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
@@ -230,6 +234,7 @@ SYM_CODE_END(xenpv_restore_regs_and_retu
 /* Normal 64-bit system call target */
 SYM_CODE_START(xen_syscall_target)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	popq %rcx
 	popq %r11
 
@@ -249,6 +254,7 @@ SYM_CODE_END(xen_syscall_target)
 /* 32-bit compat syscall target */
 SYM_CODE_START(xen_syscall32_target)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	popq %rcx
 	popq %r11
 
@@ -266,6 +272,7 @@ SYM_CODE_END(xen_syscall32_target)
 /* 32-bit compat sysenter target */
 SYM_CODE_START(xen_sysenter_target)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	/*
 	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
 	 * that we don't need to guard against single step exceptions here.
@@ -289,6 +296,7 @@ SYM_CODE_END(xen_sysenter_target)
 SYM_CODE_START(xen_syscall32_target)
 SYM_CODE_START(xen_sysenter_target)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
 	pushq $0
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -25,8 +25,8 @@
 SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)
 		UNWIND_HINT_FUNC
-		.skip 31, 0x90
-		RET
+		ANNOTATE_NOENDBR
+		.skip 32, 0xcc
 	.endr
 
 #define HYPERCALL(n) \
@@ -74,6 +74,7 @@ SYM_CODE_END(startup_xen)
 .pushsection .text
 SYM_CODE_START(asm_cpu_bringup_and_idle)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 
 	call cpu_bringup_and_idle
 SYM_CODE_END(asm_cpu_bringup_and_idle)


