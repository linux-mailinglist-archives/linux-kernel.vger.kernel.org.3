Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44B51D77B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiEFMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346892AbiEFMYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:24:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A319037
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kaeXHTlBLQAhPCB6iMNkuNFdoTXdzZuQlnpU3vtN0B0=; b=PBmIkye0sibEqqknlw+lBtAKDK
        OaOOxWyY3ZctRkD87lnTTAIWsWtBBAk9Ta/IheXHz+itLLaNZF486PqyzT1eJl5gdaMUBb/NxDdRc
        PYRMSJ1kGiMhIo5vSwm+mg7ZtfxjVvODwyZD4uBukjGsT58jwc5CPw066qtpUfom2IAEya+P84jPA
        O+NE1lj24EObHyL6+SZBJl0xi3xVNVA1K1lL6NfkjNEYofZ2HVoOUEmfPHygYgV5JVoEBZ57+mZBs
        2DUQdiQ3JqUuNnuFpRIhuBZHYQeZy3Fl21mVBrHbmmwrGGRpJy30t8W1/Wv/8CTxVO6/IcXpl6Aj8
        15fmv6LQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmwwU-000vKt-Au; Fri, 06 May 2022 12:20:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 183E23007C6;
        Fri,  6 May 2022 14:20:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EF7DF2026BB43; Fri,  6 May 2022 14:20:15 +0200 (CEST)
Message-ID: <20220506121631.365070674@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 06 May 2022 14:14:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com
Subject: [PATCH 4/6] x86/entry: Remove skip_r11rcx
References: <20220506121431.563656641@infradead.org>
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

Yes, r11 and rcx have been restored previously, but since we're
popping them anyway (into rsi) might as well pop them into their own
regs -- setting them to the value they already are.

Less magical code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/calling.h  |   10 +---------
 arch/x86/entry/entry_64.S |    3 +--
 2 files changed, 2 insertions(+), 11 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -120,27 +120,19 @@ For 32-bit we have the following convent
 	CLEAR_REGS
 .endm
 
-.macro POP_REGS pop_rdi=1 skip_r11rcx=0
+.macro POP_REGS pop_rdi=1
 	popq %r15
 	popq %r14
 	popq %r13
 	popq %r12
 	popq %rbp
 	popq %rbx
-	.if \skip_r11rcx
-	popq %rsi
-	.else
 	popq %r11
-	.endif
 	popq %r10
 	popq %r9
 	popq %r8
 	popq %rax
-	.if \skip_r11rcx
-	popq %rsi
-	.else
 	popq %rcx
-	.endif
 	popq %rdx
 	popq %rsi
 	.if \pop_rdi
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -191,8 +191,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_h
 	 * perf profiles. Nothing jumps here.
 	 */
 syscall_return_via_sysret:
-	/* rcx and r11 are already restored (see code above) */
-	POP_REGS pop_rdi=0 skip_r11rcx=1
+	POP_REGS pop_rdi=0
 
 	/*
 	 * Now all regs are restored except RSP and RDI.


