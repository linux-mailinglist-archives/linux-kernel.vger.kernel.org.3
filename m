Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9484E2E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349940AbiCUQuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiCUQuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:50:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126433F8B8;
        Mon, 21 Mar 2022 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ih87pxrMStIDzG7/g9OQRTfoGLyCU+nQ0PiHF7wFn0A=; b=HJ/hN+5QK8oYBuY1Z9W28lDnKg
        olkRPbqOfh2FJ8j+4p6hcV1SosrRTM05tsif0RFsSb5NSBG1uP+58Bi9MxWkLagezuuICP7iHoVjP
        NCj0siBk9j5UjNlPv/sjxPJPP/o+oUJy60xbw0SLkOkd2p6M8vNsa1Q5p+vmFbTEz4lW1dvH8IL/Q
        mGMcCRXOv6d5+9ZnwVEFn4OVF78XnsNG8bK2QsnoEdWU5hVuRlkaJvW3UHuPHGxR5peoh1ZkJ/xiG
        6lYyUg+wceOawcNe7/baY7n7dpT5fiC3dM9nygDasdXYZmk4o/bpHTOvTB9oGhPjDCGZ453G2GgaP
        x/7qmKqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWLDD-003BEn-Bs; Mon, 21 Mar 2022 16:48:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF2FA30031D;
        Mon, 21 Mar 2022 17:48:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B00B22DB9484B; Mon, 21 Mar 2022 17:48:54 +0100 (CET)
Date:   Mon, 21 Mar 2022 17:48:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhiramat@kernel.org, rostedt@goodmis.org, ast@kernel.org,
        hjl.tools@gmail.com, rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:04:05PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 21, 2022 at 01:55:49PM +0100, Peter Zijlstra wrote:
> > On Mon, Mar 21, 2022 at 02:03:27PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the tip tree, today's linux-next build (x864 allmodconfig)
> > > produced these new warnings:
> > > 
> > > vmlinux.o: warning: objtool: arch_rethook_prepare()+0x55: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > vmlinux.o: warning: objtool: arch_rethook_trampoline_callback()+0x3e: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > vmlinux.o: warning: objtool: unwind_next_frame()+0x93e: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > vmlinux.o: warning: objtool: unwind_next_frame()+0x5f2: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > vmlinux.o: warning: objtool: unwind_next_frame()+0x4a7: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x81: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x90: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x8c: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x9b: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > 
> > Hurmph, lemme go figure out where that code comes from, I've not seen
> > those.
> 
> Ahh, something tracing. I'll go do some patches on top of it.

The below gets rid of the objtool warnings.

But I still think it's fairly terrible to get a (flawed) carbon copy of
the kretprobe code. Also, I think both should fix regs->ss.

---
diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
index f0f2f0608282..227a1890a984 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -20,6 +20,7 @@ asm(
 	".type arch_rethook_trampoline, @function\n"
 	"arch_rethook_trampoline:\n"
 #ifdef CONFIG_X86_64
+	ANNOTATE_NOENDBR
 	/* Push a fake return address to tell the unwinder it's a kretprobe. */
 	"	pushq $arch_rethook_trampoline\n"
 	UNWIND_HINT_FUNC
@@ -48,7 +49,7 @@ asm(
 	"	addl $4, %esp\n"
 	"	popfl\n"
 #endif
-	"	ret\n"
+	ASM_RET
 	".size arch_rethook_trampoline, .-arch_rethook_trampoline\n"
 );
 NOKPROBE_SYMBOL(arch_rethook_trampoline);
