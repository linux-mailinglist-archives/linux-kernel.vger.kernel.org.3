Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786E95AB397
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiIBObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiIBO1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF351581A1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=XjJyb073rhc42xRL7dMw1nuC9q0N0CTNdvFDeYOzjH4=; b=Al7+F+8giCc+wzNvsIE7TAcHm+
        N3VfIsBwm/q1stVott7n0MUB0ToZ8uFv6envqWIbZdiD3conDrv8oSzRIGx06XMiWyD08rEoRLZhr
        94n+G80urfoLVIizijUp5nNI2MHNhNhN7RrEAV80wO996Rbt6zqr8LyjwyeyHowg5pjkq2QjuctFe
        IqYwH2BDAtatU1u9R2L7zJqQvDAXogJsQtFR3BKvR9CSZwlaxxUkvQkQZTOg/ZFEuICnLprMEjXTF
        y8fzL2y/k2bHTrV3rc+TOXTz9vhfiRcaO7Or26SdOqHaxmPbmbtguL0jTwv8uWyc+/qwwo9wctAGy
        rabrNfRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77P-008g8i-6k; Fri, 02 Sep 2022 13:54:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49155302E13;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CCEB92B8EFB64; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130952.269277054@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:22 +0200
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
Subject: [PATCH v2 57/59] x86/ftrace: Rebalance RSB
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

From: Peter Zijlstra (Intel) <peterz@infradead.org>

ftrace_regs_caller() uses a PUSH;RET pattern to tail-call into a
direct-call function, this unbalances the RSB, fix that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace_64.S |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -271,6 +271,17 @@ SYM_INNER_LABEL(ftrace_regs_caller_end,
 	/* Restore flags */
 	popfq
 	UNWIND_HINT_FUNC
+
+	/*
+	 * The above left an extra return value on the stack; effectively
+	 * doing a tail-call without using a register. This PUSH;RET
+	 * pattern unbalances the RSB, inject a pointless CALL to rebalance.
+	 */
+	ANNOTATE_INTRA_FUNCTION_CALL
+	CALL .Ldo_rebalance
+	int3
+.Ldo_rebalance:
+	add $8, %rsp
 	RET
 
 SYM_FUNC_END(ftrace_regs_caller)


