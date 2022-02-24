Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413FD4C2F48
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiBXPUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiBXPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65691617D2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0vNiWWliHftrrrDMpbQA2ahn+ZapY3hO8BL9QfndM2A=; b=RCg+wXOEzBgB0NhuHzKBvcEe7N
        QA59pWsz7ze0+wAwnYCcju9lWAPHXc3+qYvad6JEtTRt1V/PjlmfEYXb0HWB9IH9kbCPwhD6JaPBr
        AKG59EVbaoX5WaFctYEww/1d85aVrArlSuEuj8itH6C+p5D5XQ2KfNFVYdr+PQc0Pkci1PlAKqIPM
        l1nZ/IQami2WyZAxJd8e/I7WznUhNrei6iiSWfRsfzn84Blq/uwSL9lsgcg4fPvcWMloiWefTXQjg
        cuWvVGnb2g01s0q4fNaP/YxFIDNMvXBu6ihQZRbNQbBn+CtOAJh1Br4VB9Mcai7BoOq83lvXipWXr
        2bgSasQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-004s2C-Rn; Thu, 24 Feb 2022 15:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4578630288B;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7DF6E2B354797; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151323.421937384@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 24/39] x86/text-patching: Make text_gen_insn() IBT aware
References: <20220224145138.952963315@infradead.org>
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

Make sure we don't generate direct JMP/CALL instructions to an ENDBR
instruction (which might be poison).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <asm/ptrace.h>
+#include <asm/ibt.h>
 
 struct paravirt_patch_site;
 #ifdef CONFIG_PARAVIRT
@@ -101,13 +102,26 @@ void *text_gen_insn(u8 opcode, const voi
 	static union text_poke_insn insn; /* per instance */
 	int size = text_opcode_size(opcode);
 
+	/*
+	 * Hide the addresses to avoid the compiler folding in constants when
+	 * referencing code, these can mess up annotations like
+	 * ANNOTATE_NOENDBR.
+	 */
+	OPTIMIZER_HIDE_VAR(addr);
+	OPTIMIZER_HIDE_VAR(dest);
+
+#ifdef CONFIG_X86_KERNEL_IBT
+	if (is_endbr(*(u32 *)dest))
+		dest += 4;
+#endif
+
 	insn.opcode = opcode;
 
 	if (size > 1) {
 		insn.disp = (long)dest - (long)(addr + size);
 		if (size == 2) {
 			/*
-			 * Ensure that for JMP9 the displacement
+			 * Ensure that for JMP8 the displacement
 			 * actually fits the signed byte.
 			 */
 			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));


