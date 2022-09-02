Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DA35AB391
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiIBOaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbiIBO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661661581A5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HFxAeBcqZzx1YzuFlftNJ033Kmjw/OvruEBmGEN0HcI=; b=Oa2G8BWpsj8uyUvV/CiV/15FjQ
        zBV1SPgVZMnFaVxUQAk2DiFZ9ufbK1BwWqBqPlrWUycI2Yqb9YKqzp7IFt6XwL1Y3OoXTvxu+qKyw
        IfNRfNkoV6aUlNObp0nWvVmhqRfHjWOSyAfP4w8GQD48MOTmIC6G4I4m1W/e9k8X8M9pyw+5qx1SC
        iXz8vQ8Gr7yDtHvO/tX24vPqmP3FtnY/hCmzwibMcEiK5h/HQa1GQKsFB6YLlzaZQpiIizC1yyY9S
        ISkdlV7cwegy1viTXnndnRbeieBDIz0+AszkSG1fGr2J1AkkBEgnJ4D9uOscrJE2Ya3lVqJpfE6k5
        Zl3hCOHA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77L-008g7z-JF; Fri, 02 Sep 2022 13:53:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0ABC6301482;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4D3E32B1A6BE6; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130947.502476538@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 11/59] x86/paravirt: Properly align PV functions
References: <20220902130625.217071627@infradead.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

Ensure inline asm functions are consistently aligned with compiler
generated and SYM_FUNC_START*() functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h           |    1 +
 arch/x86/include/asm/qspinlock_paravirt.h |    2 +-
 arch/x86/kernel/kvm.c                     |    1 +
 arch/x86/kernel/paravirt.c                |    2 ++
 4 files changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -665,6 +665,7 @@ bool __raw_callee_save___native_vcpu_is_
 	asm(".pushsection " section ", \"ax\";"				\
 	    ".globl " PV_THUNK_NAME(func) ";"				\
 	    ".type " PV_THUNK_NAME(func) ", @function;"			\
+	    ASM_FUNC_ALIGN						\
 	    PV_THUNK_NAME(func) ":"					\
 	    ASM_ENDBR							\
 	    FRAME_BEGIN							\
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -39,7 +39,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_sp
 asm    (".pushsection .text;"
 	".globl " PV_UNLOCK ";"
 	".type " PV_UNLOCK ", @function;"
-	".align 4,0x90;"
+	ASM_FUNC_ALIGN
 	PV_UNLOCK ": "
 	ASM_ENDBR
 	FRAME_BEGIN
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -802,6 +802,7 @@ asm(
 ".pushsection .text;"
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
+ASM_FUNC_ALIGN
 "__raw_callee_save___kvm_vcpu_is_preempted:"
 ASM_ENDBR
 "movq	__per_cpu_offset(,%rdi,8), %rax;"
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -40,6 +40,7 @@
 extern void _paravirt_nop(void);
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global _paravirt_nop\n"
+     ASM_FUNC_ALIGN
      "_paravirt_nop:\n\t"
      ASM_ENDBR
      ASM_RET
@@ -50,6 +51,7 @@ asm (".pushsection .entry.text, \"ax\"\n
 /* stub always returning 0. */
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global paravirt_ret0\n"
+     ASM_FUNC_ALIGN
      "paravirt_ret0:\n\t"
      ASM_ENDBR
      "xor %" _ASM_AX ", %" _ASM_AX ";\n\t"


