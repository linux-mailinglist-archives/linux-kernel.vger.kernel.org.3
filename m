Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B544D1C89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348575AbiCHP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348059AbiCHP4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:08 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CC44F9DF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ubKvPzHSTf9I/HpHJnBuEu/vAwkkIzBDgMQoNkBO5jQ=; b=FWSdbCa8xbz8sUYZECPMakE7Nr
        xGTIqCIqLoebYe9lX3NwzdDVMfLfZ99vZg6nWh7Z80p+qUd1X24VoYqoT9DmBmbcVq94HuIDyquAw
        v3XOPwFduaPRtGyHGlaTuUo5uzoVfgJaZLzUq8bzUz0MGBGgSvwSafmwFWihAuah6Deh1uK0mSpOo
        Rc9o9Wh0Br8VK7F7fPWF4bPHF2hkwV0pBxqLKsOXfpJeJsBm+ITsiGFJ+oCyyBak5EnzIGpQPHveu
        /VugHYAPVQV6+u94XAiode46fgu9Fn8zZnuloSBdekqRO+82Mr4fu+yxO/gAWunWj7mAqnTNG1tIt
        oTJRWjUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GUib-Q3; Tue, 08 Mar 2022 15:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 436C7302D49;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 70EC82B561933; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.700456643@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 26/45] x86/alternative: Simplify int3_selftest_ip
References: <20220308153011.021123062@infradead.org>
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


