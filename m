Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8F24E3879
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiCVFdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiCVFdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:33:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B25381;
        Mon, 21 Mar 2022 22:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1EE7B81B87;
        Tue, 22 Mar 2022 05:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAEFC340EC;
        Tue, 22 Mar 2022 05:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647927102;
        bh=S9IobCk2/SCUxMjhrXXqR93XhKqnu26qc3N4ltVvvR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dZ631HINBxUbJBtm1PoeSI+QIhyE67UmFHGhDNIFKBnRUXqxap8EQa3cEzRAT4dy4
         zzIb1x4Aot4BfF+a5L9Lrq7JRK0rfjlztcarqmFrwhvPc4G7S3T3AamX7scHq/3d2u
         HawIzWz2EFVrh7SrZsNd2EH+nseru+R8rR6oooEa/yUzOiGpt4rfPV2eynh5MDBlYQ
         lXSJzL7RKasm9PqW6anjXReLsPrJ3iTURw4IEMWYZA5fZt5/uCIKvS9O/kJfv5pyOy
         cHTTBwbadm0svfYtNcCquc6UfXmlTTmsM75YTGmYtkGzUYqUJckEFNNGtNEUVUp9aw
         vzXRbtCHt76UQ==
Date:   Tue, 22 Mar 2022 14:31:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhiramat@kernel.org, rostedt@goodmis.org, ast@kernel.org,
        hjl.tools@gmail.com, rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-Id: <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
In-Reply-To: <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 17:48:54 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Mar 21, 2022 at 02:04:05PM +0100, Peter Zijlstra wrote:
> > On Mon, Mar 21, 2022 at 01:55:49PM +0100, Peter Zijlstra wrote:
> > > On Mon, Mar 21, 2022 at 02:03:27PM +1100, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > After merging the tip tree, today's linux-next build (x864 allmodconfig)
> > > > produced these new warnings:
> > > > 
> > > > vmlinux.o: warning: objtool: arch_rethook_prepare()+0x55: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > vmlinux.o: warning: objtool: arch_rethook_trampoline_callback()+0x3e: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x93e: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x5f2: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x4a7: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x81: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x90: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x8c: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x9b: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > 
> > > Hurmph, lemme go figure out where that code comes from, I've not seen
> > > those.
> > 
> > Ahh, something tracing. I'll go do some patches on top of it.
> 
> The below gets rid of the objtool warnings.

Yes, I confirmed that.

> 
> But I still think it's fairly terrible to get a (flawed) carbon copy of
> the kretprobe code.

Indeed. I would like to replace the trampoline code of kretprobe with
rethook, eventually. There is no reason why we keep the clone.
(But I need more arch maintainers help for that, there are too many
 archs implemented kretprobes)

> Also, I think both should fix regs->ss.

I'm not sure this part. Since the return trampoline should run in the same
context of the called function, isn't ss same there too?

Thank you,

> 
> ---
> diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
> index f0f2f0608282..227a1890a984 100644
> --- a/arch/x86/kernel/rethook.c
> +++ b/arch/x86/kernel/rethook.c
> @@ -20,6 +20,7 @@ asm(
>  	".type arch_rethook_trampoline, @function\n"
>  	"arch_rethook_trampoline:\n"
>  #ifdef CONFIG_X86_64
> +	ANNOTATE_NOENDBR
>  	/* Push a fake return address to tell the unwinder it's a kretprobe. */
>  	"	pushq $arch_rethook_trampoline\n"
>  	UNWIND_HINT_FUNC
> @@ -48,7 +49,7 @@ asm(
>  	"	addl $4, %esp\n"
>  	"	popfl\n"
>  #endif
> -	"	ret\n"
> +	ASM_RET
>  	".size arch_rethook_trampoline, .-arch_rethook_trampoline\n"
>  );
>  NOKPROBE_SYMBOL(arch_rethook_trampoline);


-- 
Masami Hiramatsu <mhiramat@kernel.org>
