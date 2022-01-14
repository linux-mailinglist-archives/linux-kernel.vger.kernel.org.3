Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8647148F232
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiANV6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiANV6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:58:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FD0C061574;
        Fri, 14 Jan 2022 13:58:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A13D4B825F5;
        Fri, 14 Jan 2022 21:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB69C36AE5;
        Fri, 14 Jan 2022 21:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642197495;
        bh=Jr2Ws/7KkYBcH0vohjYnfd7dG+f39RHSmRkVh2v3P7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEaY6vYuBVWQqB25SsYheOYw6RMoQv9SkZdketD5hGkYl2XfRkvBMGqwYx2qIYXNQ
         sX9Bf7yLoFo0rLIxgw2E5KscruN2r4JzkyuWJaiIB/57nnR7vIfOAcd4YtYQjWrWut
         OW78h2w411h8aK3n6rd8kU500lVFgEThfIZucnkTEpgimTirE5IfYkCUlI8SAV8t5A
         JDtFWvOEpVEj7TVI1z1aKD5nD07NTodcRjHD4jI2/6n4dolHTLQ4yfcuF4upda3Atv
         nOAqdVEptZ/xd9zRfmlhMVls+2PitALnp61iDJERXNjSKn7HnL1MEgVp3ekaqqgT74
         b/2aEkakjWNbA==
Date:   Fri, 14 Jan 2022 14:58:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile &
 __COUNTER__
Message-ID: <YeHx8qaHiJie3xdL@archlinux-ax161>
References: <20220114010526.1776605-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114010526.1776605-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 05:05:26PM -0800, Nick Desaulniers wrote:
> commit dcce50e6cc4d ("compiler.h: Fix annotation macro misplacement with Clang")
> mentions:
> 
> > 'volatile' is ignored for some reason and Clang feels free to move the
> > reachable() annotation away from its intended location.

Perhaps it is worth mentioning in the next paragraph that this does not
contradict GCC's own documentation that you link to below, which
mentions that asm volatile statements can be reordered.

"Note that the compiler can move even volatile asm instructions relative
to other code, including across jump instructions."

No strong opinion though.

> Indeed, volatile is not a compiler barrier. Particularly once `-march=`
> flags are used under certain configs, LLVM's machine-scheduler can be
> observed moving instructions across the asm statement meant to point to
> known reachable or unreachable code, as reported by 0day bot.
> 
> Prefer a memory clobber which is a compiler barrier that prevents these
> re-orderings and remove the volatile qualifier.
> 
> Looking closer, the use of __COUNTER__ seems to have been used to
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

This resolves the original spew of warnings and does not regress a
couple of other configurations that I tested.

Tested-by: Nathan Chancellor <nathan@kernel.org>

Not sure I am qualified enough to give a reviewed-by.

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
> +	     ".pushsection .discard.reachable\n\t"	\
> +	     ".long .Lreachable%= - .\n\t"		\
> +	     ".popsection\n\t" ::: "memory");		\
>  })
> -#define annotate_reachable() __annotate_reachable(__COUNTER__)
>  
> -#define __annotate_unreachable(c) ({					\
> -	asm volatile(__stringify_label(c) ":\n\t"			\
> -		     ".pushsection .discard.unreachable\n\t"		\
> -		     ".long " __stringify_label(c) "b - .\n\t"		\
> -		     ".popsection\n\t" : : "i" (c));			\
> +#define annotate_unreachable() ({			\
> +	asm (".Lunreachable%=:\n\t"			\
> +	     ".pushsection .discard.unreachable\n\t"	\
> +	     ".long .Lunreachable%= - .\n\t"		\
> +	     ".popsection\n\t" ::: "memory");		\
>  })
> -#define annotate_unreachable() __annotate_unreachable(__COUNTER__)
>  
>  #define ASM_UNREACHABLE							\
>  	"999:\n\t"							\
> diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
> index 24359b4a9605..0dae9c08764f 100644
> --- a/include/linux/instrumentation.h
> +++ b/include/linux/instrumentation.h
> @@ -4,16 +4,13 @@
>  
>  #if defined(CONFIG_DEBUG_ENTRY) && defined(CONFIG_STACK_VALIDATION)
>  
> -#include <linux/stringify.h>
> -
>  /* Begin/end of an instrumentation safe region */
> -#define __instrumentation_begin(c) ({					\
> -	asm volatile(__stringify(c) ": nop\n\t"				\
> -		     ".pushsection .discard.instr_begin\n\t"		\
> -		     ".long " __stringify(c) "b - .\n\t"		\
> -		     ".popsection\n\t" : : "i" (c));			\
> +#define instrumentation_begin() ({			\
> +	asm (".Linstbegin%=: nop\n\t"			\
> +	     ".pushsection .discard.instr_begin\n\t"	\
> +	     ".long .Linstbegin%= - .\n\t"		\
> +	     ".popsection\n\t" ::: "memory");		\
>  })
> -#define instrumentation_begin() __instrumentation_begin(__COUNTER__)
>  
>  /*
>   * Because instrumentation_{begin,end}() can nest, objtool validation considers
> @@ -46,13 +43,12 @@
>   * To avoid this, have _end() be a NOP instruction, this ensures it will be
>   * part of the condition block and does not escape.
>   */
> -#define __instrumentation_end(c) ({					\
> -	asm volatile(__stringify(c) ": nop\n\t"				\
> -		     ".pushsection .discard.instr_end\n\t"		\
> -		     ".long " __stringify(c) "b - .\n\t"		\
> -		     ".popsection\n\t" : : "i" (c));			\
> +#define instrumentation_end() ({			\
> +	asm (".Linstend%=: nop\n\t"			\
> +	     ".pushsection .discard.instr_end\n\t"	\
> +	     ".long .Linstend%= - .\n\t"		\
> +	     ".popsection\n\t" ::: "memory");		\
>  })
> -#define instrumentation_end() __instrumentation_end(__COUNTER__)
>  #else
>  # define instrumentation_begin()	do { } while(0)
>  # define instrumentation_end()		do { } while(0)
> 
> base-commit: dcce50e6cc4d86a63dc0a9a6ee7d4f948ccd53a1
> -- 
> 2.34.1.703.g22d0c6ccf7-goog
> 
