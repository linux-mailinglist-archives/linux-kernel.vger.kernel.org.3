Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D311148FD33
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiAPNdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:33:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51252 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233233AbiAPNdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:33:02 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D2FC1EC0411;
        Sun, 16 Jan 2022 14:32:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642339976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPDfWSRyaloa+IRn4zTc2dCskgupJxpADilswV96HZA=;
        b=AbXRzCUuKObTzJZIbpjg9rFqfDxrral+P7YYbs3UDxIUgA6u7MPIBYdVinp2b+AGB6cU4E
        amv8LgzKghgkG5aBjXP6XYl1/QAmVORv69B5quD++6x25XhAd0cY5nQ0YH2CDPGG6PxkYj
        BsPcpSSjj/DlltwyOSmocVAEDBL13RI=
Date:   Sun, 16 Jan 2022 14:32:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile &
 __COUNTER__
Message-ID: <YeQei0xNzMq7bFdg@zn.tnic>
References: <20220114010526.1776605-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114010526.1776605-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

thanks for taking the time.

Here are a bunch of nitpicks:

On Thu, Jan 13, 2022 at 05:05:26PM -0800, Nick Desaulniers wrote:
> Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile &  __COUNTER__

You probably wanna formulate that subject a little less cryptic and more
to the point what the patch does:

objtool: Use a memory clobber to prevent reachability annotations from getting merged

or so.

> commit dcce50e6cc4d ("compiler.h: Fix annotation macro misplacement with Clang")
> mentions:
> 
> > 'volatile' is ignored for some reason and Clang feels free to move the
> > reachable() annotation away from its intended location.
> 
> Indeed, volatile is not a compiler barrier. Particularly once `-march=`
> flags are used under certain configs, LLVM's machine-scheduler can be
> observed moving instructions across the asm statement meant to point to
> known reachable or unreachable code, as reported by 0day bot.
> 
> Prefer a memory clobber which is a compiler barrier that prevents these
> re-orderings and remove the volatile qualifier.

Yah, Nathan's note about talking about gcc reordering volatile inline
asms might make sense here as, apparently, that could have failed on gcc
too but it didn't for whatever reason and the most important thing is
that the memory clobber will prevent such reordering.

> Looking closer, the use of __COUNTER__ seems to have been used to

"... it seems, __COUNTER__ has been used... " or so. Simpler.

> prevent de-duplication of these asm statements. The GCC manual mentions:
> 
> > Under certain circumstances, GCC may duplicate (or remove duplicates
> > of) your assembly code when optimizing. This can lead to unexpected
> > duplicate symbol errors during compilation if your asm code defines
> > symbols or labels. Using ‘%=’ (see AssemblerTemplate) may help resolve
> > this problem.
> >
> > ‘%=’ Outputs a number that is unique to each instance of the asm
> > statement in the entire compilation. This option is useful when
> > creating local labels and referring to them multiple times in a single
> > template that generates multiple assembler instructions.
> 
> commit 3d1e236022cc ("objtool: Prevent GCC from merging annotate_unreachable()")
> 
> Mentions that
> 
> > The inline asm ‘%=’ token could be used for that, but unfortunately
> > older versions of GCC don't support it.
> 
> From testing all versions of GCC available on godbolt.org, GCC 4.1+
> seems to support 4.1. Since the minimum supported version of GCC at the

You mean "seems to support %=." here perhaps?

> moment is GCC 5.1, it sounds like this is no longer a concern.
> 
> Prefer the %= assembler template to having to stringify __COUNTER__.
> 
> This commit is effectively a revert of the following commits:
> commit dcce50e6cc4d ("compiler.h: Fix annotation macro misplacement with Clang")
> commit f1069a8756b9 ("compiler.h: Avoid using inline asm operand modifiers")
> commit c199f64ff93c ("instrumentation.h: Avoid using inline asm operand modifiers")
> commit d0c2e691d1cb ("objtool: Add a comment for the unreachable annotation macros")
> commit ec1e1b610917 ("objtool: Prevent GCC from merging annotate_unreachable(), take 2")
> commit 3d1e236022cc ("objtool: Prevent GCC from merging annotate_unreachable()")
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1566
> Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
> Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#AssemblerTemplate
> Link: https://lore.kernel.org/llvm/202112080834.XFYU8b5Q-lkp@intel.com/
> Link: https://lore.kernel.org/llvm/202111300857.IyINAyJk-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Debugged-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I very much definitely appreciate the extensive and comprehensive
writeup - thanks for taking the time!

> ---
>  include/linux/compiler.h        | 31 +++++++++++--------------------
>  include/linux/instrumentation.h | 24 ++++++++++--------------
>  2 files changed, 21 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 429dcebe2b99..3ac21b888d20 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -108,30 +108,21 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  # define barrier_before_unreachable() do { } while (0)
>  #endif
>  
> -/* Unreachable code */
> +/* These macros help objtool understand GCC code flow for unreachable code. */
>  #ifdef CONFIG_STACK_VALIDATION
> -/*
> - * These macros help objtool understand GCC code flow for unreachable code.
> - * The __COUNTER__ based labels are a hack to make each instance of the macros
> - * unique, to convince GCC not to merge duplicate inline asm statements.
> - */
> -#define __stringify_label(n) #n
> -
> -#define __annotate_reachable(c) ({					\
> -	asm volatile(__stringify_label(c) ":\n\t"			\
> -		     ".pushsection .discard.reachable\n\t"		\
> -		     ".long " __stringify_label(c) "b - .\n\t"		\
> -		     ".popsection\n\t" : : "i" (c));			\
> +#define annotate_reachable() ({			\
> +	asm (".Lreachable%=:\n\t"			\
	   ^

	   no need for that space.


> +	     ".pushsection .discard.reachable\n\t"	\
> +	     ".long .Lreachable%= - .\n\t"		\
> +	     ".popsection\n\t" ::: "memory");		\

Btw, you don't need the "\t" on the last lines of the macros here. The
asm output has a stray tab this way.

As to the change itself, before it would look like this:

# arch/x86/kernel/reboot.c:130: 	unreachable();
# 130 "arch/x86/kernel/reboot.c" 1
	333:
	.pushsection .discard.unreachable
	.long 333b - .
	.popsection
	


and after

# arch/x86/kernel/reboot.c:130: 	unreachable();
# 130 "arch/x86/kernel/reboot.c" 1
	.Lunreachable44:
	.pushsection .discard.unreachable
	.long .Lunreachable44 - .
	.popsection


so I like the local label and how it is more readable this way.

So, provided the memory clobber works (I wonder here if Josh has some
concrete failing cases which could be tested with your version) and
after the nitpicks have been addressed

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
