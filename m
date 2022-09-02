Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41F75AB3AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiIBOdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiIBO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:28:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3295115712
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KqaDozNK5h/Os0p9USJOHPsjw+JZHJxcCJnx+VmNqrU=; b=Jy3Utsp5uuyNaCGPnPEy/dqGuA
        PV0cwwIU05WOMxlcE6wY99LUbZtN5FAnx85xzdMUFQA8NQJWpTxj6WGFaMMYleA+sM0Sg2gjuNzvL
        CiSFytTxlMQTnOAnlSjoMECb5BStw8uXLLkOuWMm+6tAJReD2yOxhFt9fiULdy+NuUL/6FKKgd7Ys
        KeqSaDjhyW+i+p+nP5yxayS2necTt3nDyKWGb2yNjNERHdGNcd/A80OMVd6+vD2L2HDHWMA1Y54sP
        JBtIE/dDpNtQIJWJRD84veIHKwgeVtGWBCU2iwh3QTOxBNY6CHSPQcVEA+t+Z4geY9WyxNMqwyeY1
        yNSAZK0A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-008g8M-WC; Fri, 02 Sep 2022 13:53:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34DD9302911;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1E0DE2B8EF7FB; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130950.205726504@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:02 +0200
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
Subject: [PATCH v2 37/59] x86/putuser: Provide room for padding
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

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/putuser.S |   62 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 13 deletions(-)

--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -47,8 +47,6 @@ SYM_FUNC_START(__put_user_1)
 	LOAD_TASK_SIZE_MINUS_N(0)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
-SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
-	ENDBR
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -56,54 +54,87 @@ SYM_INNER_LABEL(__put_user_nocheck_1, SY
 	RET
 SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
+
+SYM_FUNC_START(__put_user_nocheck_1)
+	ENDBR
+	ASM_STAC
+2:	movb %al,(%_ASM_CX)
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_1)
 EXPORT_SYMBOL(__put_user_nocheck_1)
 
 SYM_FUNC_START(__put_user_2)
 	LOAD_TASK_SIZE_MINUS_N(1)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
-SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
-	ENDBR
 	ASM_STAC
-2:	movw %ax,(%_ASM_CX)
+3:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
 	ASM_CLAC
 	RET
 SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
+
+SYM_FUNC_START(__put_user_nocheck_2)
+	ENDBR
+	ASM_STAC
+4:	movw %ax,(%_ASM_CX)
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_2)
 EXPORT_SYMBOL(__put_user_nocheck_2)
 
 SYM_FUNC_START(__put_user_4)
 	LOAD_TASK_SIZE_MINUS_N(3)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
-SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
-	ENDBR
 	ASM_STAC
-3:	movl %eax,(%_ASM_CX)
+5:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
 	ASM_CLAC
 	RET
 SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
+
+SYM_FUNC_START(__put_user_nocheck_4)
+	ENDBR
+	ASM_STAC
+6:	movl %eax,(%_ASM_CX)
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_4)
 EXPORT_SYMBOL(__put_user_nocheck_4)
 
 SYM_FUNC_START(__put_user_8)
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
-SYM_INNER_LABEL(__put_user_nocheck_8, SYM_L_GLOBAL)
-	ENDBR
 	ASM_STAC
-4:	mov %_ASM_AX,(%_ASM_CX)
+7:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
-5:	movl %edx,4(%_ASM_CX)
+8:	movl %edx,4(%_ASM_CX)
 #endif
 	xor %ecx,%ecx
 	ASM_CLAC
 	RET
 SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
+
+SYM_FUNC_START(__put_user_nocheck_8)
+	ENDBR
+	ASM_STAC
+9:	mov %_ASM_AX,(%_ASM_CX)
+#ifdef CONFIG_X86_32
+10:	movl %edx,4(%_ASM_CX)
+#endif
+	xor %ecx,%ecx
+	ASM_CLAC
+	RET
+SYM_FUNC_END(__put_user_nocheck_8)
 EXPORT_SYMBOL(__put_user_nocheck_8)
 
 SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
@@ -117,6 +148,11 @@ SYM_CODE_END(.Lbad_put_user_clac)
 	_ASM_EXTABLE_UA(2b, .Lbad_put_user_clac)
 	_ASM_EXTABLE_UA(3b, .Lbad_put_user_clac)
 	_ASM_EXTABLE_UA(4b, .Lbad_put_user_clac)
-#ifdef CONFIG_X86_32
 	_ASM_EXTABLE_UA(5b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(6b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(7b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(9b, .Lbad_put_user_clac)
+#ifdef CONFIG_X86_32
+	_ASM_EXTABLE_UA(8b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(10b, .Lbad_put_user_clac)
 #endif


