Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF451D777
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391725AbiEFMYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245206AbiEFMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:24:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0816819014
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NeC5H0rz9asrZvu7kWFKnF+DNDGoTKQiNQyQqLZ88kE=; b=bT7MjXuYOKdTaZqJctCZbop1t7
        Kxt5XTYPlSW/SzilHn56R67CWxptEEWq6aGznBUHXDdZIcFqoUEZd+jU7iit9cTlUPtc5ECRcUcNl
        gsPwT0bhS/9oEAcCI+ruCUPIjyqi8kZjoPg6eU8QDim23XVkp+XhrMvI5W3OcMIbibyBaK8+CIPG4
        2iZUeyeMEMSRRrYvjSxQ1Sv+WbDREg0SS5GnUq5z5TwZ27G2lHEEyagwv99iwP5OHBUo82XC/Hdu5
        UFFguw8pCzfQ6HuQsOaZazxkD8VmHgrx8wmHeYga6p7P5hT3v+1kNfD8KZU9/ALwB977Vhi8qJ6K2
        DXw2OCXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmwwU-00BfTZ-Ab; Fri, 06 May 2022 12:20:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EBD7300483;
        Fri,  6 May 2022 14:20:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E650320279CCF; Fri,  6 May 2022 14:20:15 +0200 (CEST)
Message-ID: <20220506121631.221072885@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 06 May 2022 14:14:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 2/6] x86/entry: Simplify entry_INT80_compat()
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

From: Linus Torvalds <torvalds@linux-foundation.org>

Instead of playing silly games with rdi, use rax for simpler and more
consistent code.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[peterz: Changelog and fix off-by-one in offsets]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/entry/entry_64_compat.S |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -362,26 +362,25 @@ SYM_CODE_START(entry_INT80_compat)
 
 	/* switch to thread stack expects orig_ax and rdi to be pushed */
 	pushq	%rax			/* pt_regs->orig_ax */
-	pushq	%rdi			/* pt_regs->di */
 
 	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
 	/* In the Xen PV case we already run on the thread stack. */
 	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
 
-	movq	%rsp, %rdi
+	movq	%rsp, %rax
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
-	pushq	6*8(%rdi)		/* regs->ss */
-	pushq	5*8(%rdi)		/* regs->rsp */
-	pushq	4*8(%rdi)		/* regs->eflags */
-	pushq	3*8(%rdi)		/* regs->cs */
-	pushq	2*8(%rdi)		/* regs->ip */
-	pushq	1*8(%rdi)		/* regs->orig_ax */
-	pushq	(%rdi)			/* pt_regs->di */
+	pushq	5*8(%rax)		/* regs->ss */
+	pushq	4*8(%rax)		/* regs->rsp */
+	pushq	3*8(%rax)		/* regs->eflags */
+	pushq	2*8(%rax)		/* regs->cs */
+	pushq	1*8(%rax)		/* regs->ip */
+	pushq	0*8(%rax)		/* regs->orig_ax */
 .Lint80_keep_stack:
 
+	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
 	xorl	%esi, %esi		/* nospec   si */
 	pushq	%rdx			/* pt_regs->dx */


