Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF65957D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiHPKQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiHPKP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:15:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204FFC8769;
        Tue, 16 Aug 2022 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UAD+grFnjI9uAdJ1lqhJq8c5aRgDgFp1jWwEAfLYx08=; b=RbSMU36jpIPB1+vgUGgLo+IV+U
        jgbksXnJtZe3CNEEJBVyLU0HJ0j0+1EDSRJyGvsURo/tdcrSQVkmgtEyd72tDcrnxVZHK3/xBsJnp
        AMtahZ4MRibWoizJWoakO7y72Ye300qV70TLR972VaAra/HK43dJO9ohKb3SM/YRM2hTbd099AxK7
        zYTk4ZOFpqRz8NJPjCIQw3fiXkiG0K8hnjwCawWPhmM4MhG1C3yYk9L/HYCho8v3sS9VGiofBPYDz
        +HHeAUWGGQf08Oo6e3qJ6auN+JJMjxIuUlE4o8YcGeGVal416KseT3v/PSA9vI8CbEuvh2Nmt5j1Z
        i7nigeAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNrWs-002tnu-Lt; Tue, 16 Aug 2022 08:02:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1164B980264; Tue, 16 Aug 2022 10:02:25 +0200 (CEST)
Date:   Tue, 16 Aug 2022 10:02:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: Simplify load_unaligned_zeropad() (was Re: [GIT PULL] Ceph
 updates for 5.20-rc1)
Message-ID: <YvtPEA/9GV7GthZJ@worktop.programming.kicks-ass.net>
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
 <Yvny9L3tw1EolqQ4@worktop.programming.kicks-ass.net>
 <CAHk-=whnEN3Apb5gRXSZK7BM+MOby9VCZe3sDcW34Zme_wk3uA@mail.gmail.com>
 <Yvqn8BqE7FdB6Ccd@worktop.programming.kicks-ass.net>
 <CAHk-=wj6QaNkoNPA0jrW8F_=RNNb1jCsFF2QngNEQb_C=wMDPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6QaNkoNPA0jrW8F_=RNNb1jCsFF2QngNEQb_C=wMDPQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 03:49:44PM -0700, Linus Torvalds wrote:
> On Mon, Aug 15, 2022 at 1:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > I'm not at all suggesting we do this; but it might be
> > insn_get_addr_ref() does what is needed.
> 
> .. you didn't suggest it at all, but I started doing it anyway.

> So since I was tricked into writing this patch, and it's even tested
> (the second attachment has a truly stupid patch with my test-case), I
> think it's worth doing.

Haha, couldn't help yourself eh ;-)

> Comments? I left your "Acked-by" from the previous version of this
> thing, so holler now if you think this got too ugly in the meantime..

That's quite allright, a few nits below, but overall I like it. And yes
it's a bit over the top, but it's important to have fun..

> diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
> index 503622627400..b53f1919710b 100644
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -64,4 +64,6 @@
>  #define	EX_TYPE_UCOPY_LEN4		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(4))
>  #define	EX_TYPE_UCOPY_LEN8		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(8))
>  
> +#define EX_TYPE_ZEROPAD			20 /* load ax from dx zero-padded */

This comment is now woefully incorrect.

> +
>  #endif
> diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
> index 8338b0432b50..46b4f1f7f354 100644
> --- a/arch/x86/include/asm/word-at-a-time.h
> +++ b/arch/x86/include/asm/word-at-a-time.h
> @@ -77,58 +77,18 @@ static inline unsigned long find_zero(unsigned long mask)
>   * and the next page not being mapped, take the exception and
>   * return zeroes in the non-existing part.
>   */
>  static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>  	unsigned long ret;
>  
> +	asm volatile(
>  		"1:	mov %[mem], %[ret]\n"
>  		"2:\n"
> +		_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_ZEROPAD)
> +		: [ret] "=r" (ret)
>  		: [mem] "m" (*(unsigned long *)addr));

That looks delightfully simple :-)

>  
>  	return ret;
>  }
>  
>  #endif /* _ASM_WORD_AT_A_TIME_H */
> diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> index 331310c29349..60814e110a54 100644
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -41,6 +41,59 @@ static bool ex_handler_default(const struct exception_table_entry *e,
>  	return true;
>  }
>  
> +/*
> + * This is the *very* rare case where we do a "load_unaligned_zeropad()"
> + * and it's a page crosser into a non-existent page.
> + *
> + * This happens when we optimistically load a pathname a word-at-a-time
> + * and the name is less than the full word and the  next page is not
> + * mapped. Typically that only happens for CONFIG_DEBUG_PAGEALLOC.
> + *
> + * NOTE! The faulting address is always a 'mov mem,reg' type instruction
> + * of size 'long', and the exception fixup must always point to right
> + * after the instruction.
> + */
> +static bool ex_handler_zeropad(const struct exception_table_entry *e,
> +			       struct pt_regs *regs,
> +			       unsigned long fault_addr)
> +{
> +	struct insn insn;
> +	const unsigned long mask = sizeof(long) - 1;
> +	unsigned long offset, addr, next_ip, len;
> +	unsigned long *reg;
> +
> +	next_ip = ex_fixup_addr(e);
> +	len = next_ip - regs->ip;
> +	if (len > MAX_INSN_SIZE)
> +		return false;
> +
> +	if (insn_decode(&insn, (void *) regs->ip, len, INSN_MODE_KERN))
> +		return false;

We have insn_decode_kernel() for exactly this (very) common case.

	if (insn_decode_kernel(&insn, (void *)regs->ip))
		return false;

> +	if (insn.length != len)
> +		return false;
> +
> +	if (insn.opcode.bytes[0] != 0x8b)
> +		return false;

I was wondering if we want something like MOV_INSN_OPCODE for 0x8b to
enhance readability, otoh it's currently 0x8b all over the place, so
whatever. At some point you gotta have the insn tables with you anyway.

> +	if (insn.opnd_bytes != sizeof(long))
> +		return false;
> +
> +	addr = (unsigned long) insn_get_addr_ref(&insn, regs);
> +	if (addr == ~0ul)
> +		return false;
> +
> +	offset = addr & mask;
> +	addr = addr & ~mask;
> +	if (fault_addr != addr + sizeof(long))
> +		return false;
> +
> +	reg = insn_get_modrm_reg_ptr(&insn, regs);
> +	if (!reg)
> +		return false;
> +
> +	*reg = *(unsigned long *)addr >> (offset * 8);
> +	return ex_handler_default(e, regs);
> +}

Yep, that all looks about right.

> +
>  static bool ex_handler_fault(const struct exception_table_entry *fixup,
>  			     struct pt_regs *regs, int trapnr)
>  {
> @@ -217,6 +270,8 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
>  		return ex_handler_sgx(e, regs, trapnr);
>  	case EX_TYPE_UCOPY_LEN:
>  		return ex_handler_ucopy_len(e, regs, trapnr, reg, imm);
> +	case EX_TYPE_ZEROPAD:
> +		return ex_handler_zeropad(e, regs, fault_addr);
>  	}
>  	BUG();
>  }
