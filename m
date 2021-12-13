Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45079472AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhLMLEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:04:34 -0500
Received: from foss.arm.com ([217.140.110.172]:51676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232342AbhLMLEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:04:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECCD06D;
        Mon, 13 Dec 2021 03:04:31 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E43B3F793;
        Mon, 13 Dec 2021 03:04:30 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:04:27 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 5/9] atomic,x86: Implement
 atomic_dec_and_test_overflow()
Message-ID: <Ybcou19VF7Vf0kP0@FVFF77S0Q05N>
References: <20211210161618.645249719@infradead.org>
 <20211210162313.599116743@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210162313.599116743@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:16:23PM +0100, Peter Zijlstra wrote:
> Provide a better implementation of atomic_{dec,dec_and_test}_overflow() by
> making use of the atomic-op condition codes.
> 
> This further improves the fast path code:
> 
>     a980:       b8 ff ff ff ff          mov    $0xffffffff,%eax
>     a985:       f0 0f c1 07             lock xadd %eax,(%rdi)
>     a989:       83 e8 01                sub    $0x1,%eax
>     a98c:       78 20                   js     a9ae <ring_buffer_put+0x2e>
>     a98e:       74 01                   je     a991 <ring_buffer_put+0x11>
>     a990:       c3                      ret
> 
> to:
> 
>     a950:       f0 ff 0f                lock decl (%rdi)
>     a953:       7c 20                   jl     a975 <ring_buffer_put+0x25>
>     a955:       74 01                   je     a958 <ring_buffer_put+0x8>
>     a957:       c3                      ret

As a heads-up, for arm64 we probably won't need to roll our own since the LSE
atomics don't have flag-setting versions, and the compiler-generated
comparisons and conditional branches can be better optimized per caller.

Otherwise, I'm going to ignore this patch since I'm not qualified to review x86
asm. :)

Mark.

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/atomic.h |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> --- a/arch/x86/include/asm/atomic.h
> +++ b/arch/x86/include/asm/atomic.h
> @@ -263,6 +263,29 @@ static __always_inline int arch_atomic_f
>  }
>  #define arch_atomic_fetch_xor arch_atomic_fetch_xor
>  
> +#define arch_atomic_dec_overflow(_v, _label)				\
> +	asm_volatile_goto(LOCK_PREFIX "decl %[var]\n\t"			\
> +			  "jle %l1"					\
> +			  : : [var] "m" ((_v)->counter)			\
> +			  : "memory"					\
> +			  : _label)
> +
> +#define arch_atomic_dec_and_test_overflow(_v, _label)			\
> +({									\
> +	__label__ __zero;						\
> +	__label__ __out;						\
> +	bool __ret = false;						\
> +	asm_volatile_goto(LOCK_PREFIX "decl %[var]\n\t"			\
> +			  "jl %l2\n\t"					\
> +			  "je %l[__zero]"				\
> +			  : : [var] "m" ((_v)->counter)			\
> +			  : "memory"					\
> +			  : __zero, _label);				\
> +	goto __out;							\
> +__zero:	__ret = true;							\
> +__out:	__ret;								\
> +})
> +
>  #ifdef CONFIG_X86_32
>  # include <asm/atomic64_32.h>
>  #else
> 
> 
