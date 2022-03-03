Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB14CBCA3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiCCLdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiCCLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE66417CC6B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ubKvPzHSTf9I/HpHJnBuEu/vAwkkIzBDgMQoNkBO5jQ=; b=Cpd4Z+fBvh/XBPp/d+iv0sACfG
        +bIeBLbVSZwAomx/06nH8vMFm+Mnv8BsoRH+eL8sRmKCo3ksG5ra2NwU6HM4Vz9C1xgf1NZW/5TqJ
        tcYpQeA47rw3gBJ7nV/wLqtz9yYHUCGfXwZkaW/4soRK/QdjFkiXcNa0CusZFxHcGc9vGU6rNgHSB
        +kGVgCEgdG1z8zb2nAgrtiviwaal1J4GsyXQ0l12Wu5txqg+sG71njgThs3dSIUYonuoAybj7HdXp
        TlsRdITTfH/2XzY82wEEMcj/pp2+T8pvVKtonRVj2QIdVZu8obFQutIFztVsdfMCUPMfl7LuDewKI
        QvMEiCuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeh-00BaH3-G3; Thu, 03 Mar 2022 11:30:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05D33302AD4;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 72F2130126648; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112826.360149715@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 23/39] x86/alternative: Simplify int3_selftest_ip
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

Similar to ibt_selftest_ip, apply the same pattern.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -719,7 +719,7 @@ asm (
 "	.popsection\n"
 );
 
-extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
+extern void int3_selftest_ip(void); /* defined in asm below */
 
 static int __init
 int3_exception_notify(struct notifier_block *self, unsigned long val, void *data)
@@ -733,7 +733,7 @@ int3_exception_notify(struct notifier_bl
 	if (val != DIE_INT3)
 		return NOTIFY_DONE;
 
-	if (regs->ip - INT3_INSN_SIZE != int3_selftest_ip)
+	if (regs->ip - INT3_INSN_SIZE != (unsigned long)&int3_selftest_ip)
 		return NOTIFY_DONE;
 
 	int3_emulate_call(regs, (unsigned long)&int3_magic);
@@ -757,14 +757,7 @@ static void __init int3_selftest(void)
 	 * then trigger the INT3, padded with NOPs to match a CALL instruction
 	 * length.
 	 */
-	asm volatile ("1: int3; nop; nop; nop; nop\n\t"
-		      ".pushsection .init.data,\"aw\"\n\t"
-		      ".align " __ASM_SEL(4, 8) "\n\t"
-		      ".type int3_selftest_ip, @object\n\t"
-		      ".size int3_selftest_ip, " __ASM_SEL(4, 8) "\n\t"
-		      "int3_selftest_ip:\n\t"
-		      __ASM_SEL(.long, .quad) " 1b\n\t"
-		      ".popsection\n\t"
+	asm volatile ("int3_selftest_ip: int3; nop; nop; nop; nop\n\t"
 		      : ASM_CALL_CONSTRAINT
 		      : __ASM_SEL_RAW(a, D) (&val)
 		      : "memory");


