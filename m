Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9541489656
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbiAJK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:28:44 -0500
Received: from foss.arm.com ([217.140.110.172]:59558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242027AbiAJK23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:28:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FED8ED1;
        Mon, 10 Jan 2022 02:28:28 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FD4F3F5A1;
        Mon, 10 Jan 2022 02:28:26 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:27:59 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64: atomics: Dereference matching size
Message-ID: <YdwKLwvDRfc59c8U@FVFF77S0Q05N>
References: <20220107232746.1540130-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107232746.1540130-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Fri, Jan 07, 2022 at 03:27:46PM -0800, Kees Cook wrote:
> When building with -Warray-bounds (which is desired to be enabled
> globally), the following warning is generated:
> 
> In file included from ./arch/arm64/include/asm/lse.h:16,
>                  from ./arch/arm64/include/asm/cmpxchg.h:14,
>                  from ./arch/arm64/include/asm/atomic.h:16,
>                  from ./include/linux/atomic.h:7,
>                  from ./include/asm-generic/bitops/atomic.h:5,
>                  from ./arch/arm64/include/asm/bitops.h:25,
>                  from ./include/linux/bitops.h:33,
>                  from ./include/linux/kernel.h:22,
>                  from kernel/printk/printk.c:22:
> ./arch/arm64/include/asm/atomic_lse.h:247:9: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
>   247 |         asm volatile(                                                   \
>       |         ^~~
> ./arch/arm64/include/asm/atomic_lse.h:266:1: note: in expansion of macro '__CMPXCHG_CASE'
>   266 | __CMPXCHG_CASE(w,  , acq_, 32,  a, "memory")
>       | ^~~~~~~~~~~~~~
> kernel/printk/printk.c:3606:17: note: while referencing 'printk_cpulock_owner'
>  3606 | static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
>       |                 ^~~~~~~~~~~~~~~~~~~~
> 
> This is due to the compiler seeing an unsigned long * cast against
> something (atomic_t) that is int sized. Replace the cast with the
> matching size cast. This results in no change in binary output.

Just to check, I assume both GCC and Clang are happy with this applied?

I recall that (historically at least) clang would warn about size mismatches
for inline assembly and would sometimes require more care. I don't see anythign
for which that would matter, but I just want to check.

> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/include/asm/atomic_lse.h | 2 +-
>  arch/arm64/include/asm/cmpxchg.h    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index d955ade5df7c..5d460f6b7675 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -249,7 +249,7 @@ __lse__cmpxchg_case_##name##sz(volatile void *ptr,			\
>  	"	mov	%" #w "[tmp], %" #w "[old]\n"			\
>  	"	cas" #mb #sfx "\t%" #w "[tmp], %" #w "[new], %[v]\n"	\
>  	"	mov	%" #w "[ret], %" #w "[tmp]"			\
> -	: [ret] "+r" (x0), [v] "+Q" (*(unsigned long *)ptr),		\
> +	: [ret] "+r" (x0), [v] "+Q" (*(u##sz *)ptr),			\
>  	  [tmp] "=&r" (tmp)						\
>  	: [old] "r" (x1), [new] "r" (x2)				\
>  	: cl);								\

It might be worth nothing that __ll_sc__cmpxchg_case_##name##sz already uses
the same constraint:

	[v] "+Q" (*(u##sz *)ptr

... since that explains why we only need to update the LSE form and not the
LL/SC form, and indicates that this is unlikely to be problematic.

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index f9bef42c1411..497acf134d99 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -243,7 +243,7 @@ static inline void __cmpwait_case_##sz(volatile void *ptr,		\
>  	"	cbnz	%" #w "[tmp], 1f\n"				\
>  	"	wfe\n"							\
>  	"1:"								\
> -	: [tmp] "=&r" (tmp), [v] "+Q" (*(unsigned long *)ptr)		\
> +	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
>  	: [val] "r" (val));						\
>  }
>  
> -- 
> 2.30.2
> 
