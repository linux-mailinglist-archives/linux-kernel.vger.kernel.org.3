Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB34CBCBD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiCCLe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCCLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8126B1795D5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=V8QY1pYX+d9tDtpObRzYPlZyD2xDu/v2HceiF0ugrr8=; b=KA/2SeNQs47JfyE0qpVc/NsHiJ
        b6Wh2NTQFhej7KXbLa/YGgr3XmutUkyyIkh3zITHAhfNqVpVxEaBpwB16F1WugzKjj50CmKDF30gK
        JF1ZhcP6S0U2JTXLiQf1DeVUKIxPHtGpS5huCIsclZKjfyGeMakPSxbOeW0cGe64oCzS9F8wwtqVO
        XQDm+Stgwp2S03ZLWvlvzZa2jLzWfvk2N315NtUNQkKZW2sc1tF+C9YDvOV3+rZrzq5JCe/I+kXCN
        hB0UsSYL00pKuuezg90n/rowIAAIpG/EA8dqYQ/VSs4cFHHI5kDGzH5yUOwJTOjHFKzcL4rihwQM0
        RCySp1BQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeg-00BaGm-Cz; Thu, 03 Mar 2022 11:29:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDD62300C24;
        Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2F336300198FF; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112825.374987328@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 07/39] x86/ibt,paravirt: Use text_gen_insn() for paravirt_patch()
References: <20220303112321.422525803@infradead.org>
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

Less duplication is more better.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |   20 ++++++++++++++------
 arch/x86/kernel/paravirt.c           |   23 +++--------------------
 2 files changed, 17 insertions(+), 26 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -96,32 +96,40 @@ union text_poke_insn {
 };
 
 static __always_inline
-void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
+void __text_gen_insn(void *buf, u8 opcode, const void *addr, const void *dest, int size)
 {
-	static union text_poke_insn insn; /* per instance */
-	int size = text_opcode_size(opcode);
+	union text_poke_insn *insn = buf;
+
+	BUG_ON(size < text_opcode_size(opcode));
 
 	/*
 	 * Hide the addresses to avoid the compiler folding in constants when
 	 * referencing code, these can mess up annotations like
 	 * ANNOTATE_NOENDBR.
 	 */
+	OPTIMIZER_HIDE_VAR(insn);
 	OPTIMIZER_HIDE_VAR(addr);
 	OPTIMIZER_HIDE_VAR(dest);
 
-	insn.opcode = opcode;
+	insn->opcode = opcode;
 
 	if (size > 1) {
-		insn.disp = (long)dest - (long)(addr + size);
+		insn->disp = (long)dest - (long)(addr + size);
 		if (size == 2) {
 			/*
 			 * Ensure that for JMP8 the displacement
 			 * actually fits the signed byte.
 			 */
-			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
+			BUG_ON((insn->disp >> 31) != (insn->disp >> 7));
 		}
 	}
+}
 
+static __always_inline
+void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
+{
+	static union text_poke_insn insn; /* per instance */
+	__text_gen_insn(&insn, opcode, addr, dest, text_opcode_size(opcode));
 	return &insn.text;
 }
 
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -69,29 +69,12 @@ noinstr void paravirt_BUG(void)
 	BUG();
 }
 
-struct branch {
-	unsigned char opcode;
-	u32 delta;
-} __attribute__((packed));
-
 static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 				    unsigned long addr, unsigned len)
 {
-	const int call_len = 5;
-	struct branch *b = insn_buff;
-	unsigned long delta = (unsigned long)target - (addr+call_len);
-
-	if (len < call_len) {
-		pr_warn("paravirt: Failed to patch indirect CALL at %ps\n", (void *)addr);
-		/* Kernel might not be viable if patching fails, bail out: */
-		BUG_ON(1);
-	}
-
-	b->opcode = 0xe8; /* call */
-	b->delta = delta;
-	BUILD_BUG_ON(sizeof(*b) != call_len);
-
-	return call_len;
+	__text_gen_insn(insn_buff, CALL_INSN_OPCODE,
+			(void *)addr, target, CALL_INSN_SIZE);
+	return CALL_INSN_SIZE;
 }
 
 #ifdef CONFIG_PARAVIRT_XXL


