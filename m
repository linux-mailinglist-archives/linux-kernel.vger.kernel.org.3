Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8025AB3A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiIBOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiIBO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:28:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8BF220F3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0/PtPljRLva+i3OXSAsXYK2WvcvC4WWFyxPXVnV3iEE=; b=pnyIvBO9gt2Cr7Gu3Ph5LKtXQr
        gB0a/lpgcjFvHHcHu0180MITGJ40/OKa2Y81oTS3UxhmtSxVciqbdemjiKdJkb42VapXhxi2BkxqO
        aNYhIF2kX1HpzWrHJdHJ1byeFfhE1KZPCZpM6FbPjNbkSjiaP0UgrewZ1LLjyLwKXcUS5zF+ZWC03
        iiLLx978NrsWqR9RIJXEtz2r7ZsWjRHUISEufrAKaPNvdipf/wEE0ZLDXPlWzv89fjLEmgNG++Ils
        uE5y+SG+pOYQ0V9fsOxuy4+eS1XEPjYQxm+dpfZXYZeQ+Z7I6ZNJyeSpNWCZ32DSQIF+iQ1TOB8NE
        Lto8eggw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77O-008g8d-4m; Fri, 02 Sep 2022 13:54:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C92F302D43;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3E8D72B8EF7FF; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130950.618320501@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:06 +0200
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
Subject: [PATCH v2 41/59] x86/alternatives: Provide text_poke_copy_locked()
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

The upcoming call thunk patching must hold text_mutex and needs access to
text_poke_copy(), which takes text_mutex.

Provide a _locked postfixed variant to expose the inner workings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |    1 
 arch/x86/kernel/alternative.c        |   37 ++++++++++++++++++++---------------
 2 files changed, 23 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -45,6 +45,7 @@ extern void *text_poke(void *addr, const
 extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
+extern void *text_poke_copy_locked(void *addr, const void *opcode, size_t len, bool core_ok);
 extern void *text_poke_set(void *addr, int c, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1227,27 +1227,15 @@ void *text_poke_kgdb(void *addr, const v
 	return __text_poke(text_poke_memcpy, addr, opcode, len);
 }
 
-/**
- * text_poke_copy - Copy instructions into (an unused part of) RX memory
- * @addr: address to modify
- * @opcode: source of the copy
- * @len: length to copy, could be more than 2x PAGE_SIZE
- *
- * Not safe against concurrent execution; useful for JITs to dump
- * new code blocks into unused regions of RX memory. Can be used in
- * conjunction with synchronize_rcu_tasks() to wait for existing
- * execution to quiesce after having made sure no existing functions
- * pointers are live.
- */
-void *text_poke_copy(void *addr, const void *opcode, size_t len)
+void *text_poke_copy_locked(void *addr, const void *opcode, size_t len,
+			    bool core_ok)
 {
 	unsigned long start = (unsigned long)addr;
 	size_t patched = 0;
 
-	if (WARN_ON_ONCE(core_kernel_text(start)))
+	if (WARN_ON_ONCE(!core_ok && core_kernel_text(start)))
 		return NULL;
 
-	mutex_lock(&text_mutex);
 	while (patched < len) {
 		unsigned long ptr = start + patched;
 		size_t s;
@@ -1257,6 +1245,25 @@ void *text_poke_copy(void *addr, const v
 		__text_poke(text_poke_memcpy, (void *)ptr, opcode + patched, s);
 		patched += s;
 	}
+	return addr;
+}
+
+/**
+ * text_poke_copy - Copy instructions into (an unused part of) RX memory
+ * @addr: address to modify
+ * @opcode: source of the copy
+ * @len: length to copy, could be more than 2x PAGE_SIZE
+ *
+ * Not safe against concurrent execution; useful for JITs to dump
+ * new code blocks into unused regions of RX memory. Can be used in
+ * conjunction with synchronize_rcu_tasks() to wait for existing
+ * execution to quiesce after having made sure no existing functions
+ * pointers are live.
+ */
+void *text_poke_copy(void *addr, const void *opcode, size_t len)
+{
+	mutex_lock(&text_mutex);
+	addr = text_poke_copy_locked(addr, opcode, len, false);
 	mutex_unlock(&text_mutex);
 	return addr;
 }


