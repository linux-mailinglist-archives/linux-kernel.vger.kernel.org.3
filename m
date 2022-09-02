Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19535AB3AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiIBOc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbiIBO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:28:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB85321E0E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=iyMt99aEuDsmq01H4vnoTwNVsujF1AlFYZo6vxM6wm8=; b=LOWPcYwarw+3cR9biYHzY8+3n9
        kDt4l2BqObOIEE42ww5YWvoAHWXnVNiHZcyH8tX4otV6HVDEDUNy80sNYb3YhMAAJH5wJnxuaMmyO
        Ya98irsbhLBT/Q1eEk/1hH3Z50RVLK/H9qn0fvAf+cQSMpx/QPWWJeNkx+f6oNhBehouVd1LE56/4
        ru+bSagREjMxpOwgT/nlrLmRd4Y1TCd4GaFeny9yPBThpMtBW7SLFlCgF9ighH1i+KRyGi4HnBary
        7Wf1FWBqpCKKwT3KNF8a7S0OKLD7pLOc99kfPGcqxULEEb3wBchmpebiZufEuTpiZOi4eIjZTLvBF
        C0E4qUyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77K-008g7o-Ua; Fri, 02 Sep 2022 13:53:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00EC5300779;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 432242B1A6BC9; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130947.295146217@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:34 +0200
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
Subject: [PATCH v2 09/59] x86/asm: Ensure proper function alignment
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

With the compiler now aligning functions to 16 bytes, make sure the
assmbler does the same. Change the SYM_FUNC_START*() variants to have
matching alignment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/linkage.h |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -12,13 +12,20 @@
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #endif /* CONFIG_X86_32 */
 
-#ifdef __ASSEMBLY__
+#if CONFIG_FUNCTION_ALIGNMENT == 8
+#define __ALIGN			.p2align 3, 0x90;
+#elif CONFIG_FUNCTION_ALIGNMENT == 16
+#define __ALIGN			.p2align 4, 0x90;
+#else
+# error Unsupported function alignment
+#endif
 
-#if CONFIG_FUNCTION_ALIGNMENT == 16
-#define __ALIGN			.p2align 4, 0x90
 #define __ALIGN_STR		__stringify(__ALIGN)
-#define FUNCTION_ALIGNMENT	16
-#endif
+#define ASM_FUNC_ALIGN		__ALIGN_STR
+#define __FUNC_ALIGN		__ALIGN
+#define SYM_F_ALIGN		__FUNC_ALIGN
+
+#ifdef __ASSEMBLY__
 
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
@@ -46,7 +53,7 @@
 
 /* SYM_FUNC_START -- use for global functions */
 #define SYM_FUNC_START(name)				\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
@@ -56,7 +63,7 @@
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #define SYM_FUNC_START_LOCAL(name)			\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
+	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
@@ -66,7 +73,7 @@
 
 /* SYM_FUNC_START_WEAK -- use for weak functions */
 #define SYM_FUNC_START_WEAK(name)			\
-	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
+	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */


