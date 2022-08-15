Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B041592A50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiHOHSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbiHOHSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:18:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F6E13E;
        Mon, 15 Aug 2022 00:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ggLuCCEIZCQBMm3JJ00RdHuIzYdliX5B+acRAFSYzU4=; b=i0DBUnLKNQHl45XvRIOcVVjinw
        gJqenW+eJc2MYNljGVLcpE+MiyoDWd3apK4Ds1Opaf9Vc62oNXIwNHxkW+Oj5FCQHjFLZB1YcJClX
        d6qB+nzOPjK02+rr2ELZTy+zgavn86kJxAEJTLFRi0lWYW2UvbueT9/Bloh6h7Mw17zd21IQZtmes
        rs2I+nItWpttdhfGKRnkHvfdymCU32p1v6/SCT3eobzAHGx/duGoI/htUPDNa334H1kfSl9TJXtFh
        Ds+gp10B9nG/di5b7g+9Cpyh9Hh2pp2qqmvM81YCe6/UNOnuV0IoD2VVMDJ3AGPPrP+lNhzfSOEpk
        s+iS2R7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNULW-002bnN-GQ; Mon, 15 Aug 2022 07:17:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDAEB980264; Mon, 15 Aug 2022 09:17:08 +0200 (CEST)
Date:   Mon, 15 Aug 2022 09:17:08 +0200
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
Message-ID: <Yvny9L3tw1EolqQ4@worktop.programming.kicks-ass.net>
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 02:14:08PM -0700, Linus Torvalds wrote:

> PeterZ - you've touched both the load_unaligned_zeropad() and the
> exception code last, so let's run this past you, but this really does
> seem to not only fix the code generation issue in fs/dcache.s, it just
> looks simpler too. Comments?

Ha, freshly back from vacation and I barely know what a computer is :-)

>  arch/x86/include/asm/extable_fixup_types.h |  2 ++
>  arch/x86/include/asm/word-at-a-time.h      | 50 +++---------------------------
>  arch/x86/mm/extable.c                      | 30 ++++++++++++++++++
>  3 files changed, 37 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
> index 503622627400..b53f1919710b 100644
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -64,4 +64,6 @@
>  #define	EX_TYPE_UCOPY_LEN4		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(4))
>  #define	EX_TYPE_UCOPY_LEN8		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(8))

(weird tab stuff there, but that's for another day I suppose)

> +#define EX_TYPE_ZEROPAD			20 /* load ax from dx zero-padded */
> +
>  #endif
> diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
> index 8338b0432b50..4893f1b30dd6 100644
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
> +		"1:	mov (%[addr]), %[ret]\n"
>  		"2:\n"
> +		_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_ZEROPAD)
> +		: [ret] "=a" (ret)
> +		: [addr] "d" (addr));
>  
>  	return ret;
>  }
>  
>  #endif /* _ASM_WORD_AT_A_TIME_H */
> diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> index 331310c29349..58c79077a496 100644
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -41,6 +41,34 @@ static bool ex_handler_default(const struct exception_table_entry *e,
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
> + * NOTE! The load is always of the form "mov (%edx),%eax" to make the
> + * fixup simple.

So obviously we could use _ASM_EXTABLE_TYPE_REG together with something
like: "mov (%[reg]), %[reg]" to not depend on these fixed registers, but
yeah, that doesn't seem needed. Code-gen is fine as is.

> + */
> +static bool ex_handler_zeropad(const struct exception_table_entry *e,
> +			       struct pt_regs *regs,
> +			       unsigned long fault_addr)
> +{
> +	const unsigned long mask = sizeof(long) - 1;
> +	unsigned long offset, addr;
> +
> +	offset = regs->dx & mask;
> +	addr = regs->dx & ~mask;
> +	if (fault_addr != addr + sizeof(long))
> +		return false;
> +
> +	regs->ax = *(unsigned long *)addr >> (offset * 8);


> +	regs->ip = ex_fixup_addr(e);
> +	return true;

I think the convention here is to do:

	return ex_handler_default(e, regs);

instead, that ensures there a bit of common post code.

> +}
> +
>  static bool ex_handler_fault(const struct exception_table_entry *fixup,
>  			     struct pt_regs *regs, int trapnr)
>  {

But yeah, looks good to me.
