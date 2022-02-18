Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743AA4BBE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbiBRRRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:17:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiBRRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FEB4C7B8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7w3RXLuzWGltZbaYTUWA7I7TvOp+RfdoruP5pKrdz1w=; b=vaMIZgDwHRHMapswO/J59nq07y
        O3ma7hHuDRXucTWI5zp/ZexsH8KqztN1hNY2IwjBQ4OALGPk/2BEHA1DnTGiic3y8iajyQ29E/wJa
        YzFFf7Ff1Rtj8ViN2LzBbIlVamwfpaUy1kFErA3ttVDqp1TtDAm4AhGx1hfBLbvRQcpphPJGg0ppN
        HVsuXk2cAh2eBPpWDPT7rYhzX0+acH+lDveLy0uznNoG1cygLAZM6zPfi+icWPIcBDoaeN7jyKe4H
        cFG33CUYUZ7Y7bGbWC8DNw2H2okz/9Xv0R0wZm7wsl5SLzJze+0KltyOc+5FulkhaKHXH9eHYLc6Z
        Z6RH8dJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00Gl8f-As; Fri, 18 Feb 2022 17:14:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFA23300C68;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2465D20693BBB; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.101676056@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 09/29] x86/ibt,paravirt: Sprinkle ENDBR
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S                 |    1 +
 arch/x86/include/asm/paravirt.h           |    1 +
 arch/x86/include/asm/qspinlock_paravirt.h |    3 +++
 arch/x86/kernel/kvm.c                     |    3 ++-
 arch/x86/kernel/paravirt.c                |    2 ++
 5 files changed, 9 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -636,6 +636,7 @@ SYM_INNER_LABEL(restore_regs_and_return_
 
 SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
 	UNWIND_HINT_IRET_REGS entry=0
+	ENDBR // paravirt_iret
 	/*
 	 * Are we returning to a stack segment from the LDT?  Note: in
 	 * 64-bit mode SS:RSP on the exception stack is always valid.
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -666,6 +666,7 @@ bool __raw_callee_save___native_vcpu_is_
 	    ".globl " PV_THUNK_NAME(func) ";"				\
 	    ".type " PV_THUNK_NAME(func) ", @function;"			\
 	    PV_THUNK_NAME(func) ":"					\
+	    ASM_ENDBR							\
 	    FRAME_BEGIN							\
 	    PV_SAVE_ALL_CALLER_REGS					\
 	    "call " #func ";"						\
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_QSPINLOCK_PARAVIRT_H
 #define __ASM_QSPINLOCK_PARAVIRT_H
 
+#include <asm/ibt.h>
+
 /*
  * For x86-64, PV_CALLEE_SAVE_REGS_THUNK() saves and restores 8 64-bit
  * registers. For i386, however, only 1 32-bit register needs to be saved
@@ -39,6 +41,7 @@ asm    (".pushsection .text;"
 	".type " PV_UNLOCK ", @function;"
 	".align 4,0x90;"
 	PV_UNLOCK ": "
+	ASM_ENDBR
 	FRAME_BEGIN
 	"push  %rdx;"
 	"mov   $0x1,%eax;"
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1024,10 +1024,11 @@ asm(
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
 "__raw_callee_save___kvm_vcpu_is_preempted:"
+ASM_ENDBR
 "movq	__per_cpu_offset(,%rdi,8), %rax;"
 "cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
 "setne	%al;"
-"ret;"
+ASM_RET
 ".size __raw_callee_save___kvm_vcpu_is_preempted, .-__raw_callee_save___kvm_vcpu_is_preempted;"
 ".popsection");
 
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -41,6 +41,7 @@ extern void _paravirt_nop(void);
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global _paravirt_nop\n"
      "_paravirt_nop:\n\t"
+     ASM_ENDBR
      ASM_RET
      ".size _paravirt_nop, . - _paravirt_nop\n\t"
      ".type _paravirt_nop, @function\n\t"
@@ -50,6 +51,7 @@ asm (".pushsection .entry.text, \"ax\"\n
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global paravirt_ret0\n"
      "paravirt_ret0:\n\t"
+     ASM_ENDBR
      "xor %" _ASM_AX ", %" _ASM_AX ";\n\t"
      ASM_RET
      ".size paravirt_ret0, . - paravirt_ret0\n\t"


