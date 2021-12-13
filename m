Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6DC472933
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhLMKSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:18:47 -0500
Received: from foss.arm.com ([217.140.110.172]:48786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240693AbhLMKPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:15:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF050D6E;
        Mon, 13 Dec 2021 02:06:05 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FF623F793;
        Mon, 13 Dec 2021 02:06:04 -0800 (PST)
Date:   Mon, 13 Dec 2021 10:06:01 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 3/9] atomic: Introduce
 atomic_{inc,dec,dec_and_test}_overflow()
Message-ID: <YbcbCQ/ySN8ZpTWR@FVFF77S0Q05N>
References: <20211210161618.645249719@infradead.org>
 <20211210162313.464256797@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210162313.464256797@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:16:21PM +0100, Peter Zijlstra wrote:
> In order to facilitate architecture support for refcount_t, introduce
> a number of new atomic primitives that have a uaccess style exception
> for overflow.
> 
> Notably:
> 
>   atomic_inc_overflow(v, Label):
> 
> 	increment and goto Label when the old value of v is zero or
> 	negative.
> 
>   atomic_dec_overflow(v, Label):
> 
> 	decrement and goto Label when the new value of v is zero or
> 	negative
> 
>   atomic_dec_and_test_overflow(v, Label):
> 
> 	decrement and return true when the result is zero and goto
> 	Label when the new value of v is negative

Maybe it's worth adding these as comments in the fallback, which we have for a
few existing functions, e.g.

| /**
|  * arch_${atomic}_add_negative - add and test if negative
|  * @i: integer value to add 
|  * @v: pointer of type ${atomic}_t
|  *
|  * Atomically adds @i to @v and returns true
|  * if the result is negative, or false when
|  * result is greater than or equal to zero.
|  */
| static __always_inline bool
| arch_${atomic}_add_negative(${int} i, ${atomic}_t *v) 
| {
|         return arch_${atomic}_add_return(i, v) < 0;
| }

Not a big deal either way.

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/atomic/atomic-arch-fallback.h    |   64 ++++++++++++++++++++++++
>  include/linux/atomic/atomic-instrumented.h     |   65 ++++++++++++++++++++++++-
>  include/linux/atomic/atomic-long.h             |   32 +++++++++++-
>  scripts/atomic/atomics.tbl                     |    3 +
>  scripts/atomic/fallbacks/dec_and_test_overflow |   12 ++++
>  scripts/atomic/fallbacks/dec_overflow          |    8 +++
>  scripts/atomic/fallbacks/inc_overflow          |    8 +++
>  7 files changed, 189 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -1250,6 +1250,37 @@ arch_atomic_dec_if_positive(atomic_t *v)
>  #define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
>  #endif
>  
> +#ifndef arch_atomic_inc_overflow
> +#define arch_atomic_inc_overflow(_v, _label)				\
> +do {									\
> +	int __old = arch_atomic_fetch_inc(_v);			\
> +	if (unlikely(__old <= 0))					\
> +		goto _label;						\
> +} while (0)
> +#endif
> +
> +#ifndef arch_atomic_dec_overflow
> +#define arch_atomic_dec_overflow(_v, _label)				\
> +do {									\
> +	int __new = arch_atomic_dec_return(_v);			\
> +	if (unlikely(__new <= 0))					\
> +		goto _label;						\
> +} while (0)
> +#endif
> +
> +#ifndef arch_atomic_dec_and_test_overflow
> +#define arch_atomic_dec_and_test_overflow(_v, _label)		\
> +({									\
> +	bool __ret = false;						\
> +	int __new = arch_atomic_dec_return(_v);			\
> +	if (unlikely(__new < 0))					\
> +		goto _label;						\
> +	if (unlikely(__new == 0))					\
> +		__ret = true;						\
> +	__ret;								\
> +})
> +#endif

I had wanted to move at least part of this to a function to ensure
single-evaluation and avoid accidental symbol aliasing, but (as we discussed
over IRC) I couldn't find any good way to do so, and given this is sufficiently
specialise I think we should be ok with this as-is. It's certainly no worse
than the existing stuff for xchg/cmpxchg.

With that in mind, these (and the other variants, and the underlying fallback
templates) all look good to me.

With or without the comments as above:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> +
>  #ifdef CONFIG_GENERIC_ATOMIC64
>  #include <asm-generic/atomic64.h>
>  #endif
> @@ -2357,5 +2388,36 @@ arch_atomic64_dec_if_positive(atomic64_t
>  #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
>  #endif
>  
> +#ifndef arch_atomic64_inc_overflow
> +#define arch_atomic64_inc_overflow(_v, _label)				\
> +do {									\
> +	s64 __old = arch_atomic64_fetch_inc(_v);			\
> +	if (unlikely(__old <= 0))					\
> +		goto _label;						\
> +} while (0)
> +#endif
> +
> +#ifndef arch_atomic64_dec_overflow
> +#define arch_atomic64_dec_overflow(_v, _label)				\
> +do {									\
> +	s64 __new = arch_atomic64_dec_return(_v);			\
> +	if (unlikely(__new <= 0))					\
> +		goto _label;						\
> +} while (0)
> +#endif
> +
> +#ifndef arch_atomic64_dec_and_test_overflow
> +#define arch_atomic64_dec_and_test_overflow(_v, _label)		\
> +({									\
> +	bool __ret = false;						\
> +	s64 __new = arch_atomic64_dec_return(_v);			\
> +	if (unlikely(__new < 0))					\
> +		goto _label;						\
> +	if (unlikely(__new == 0))					\
> +		__ret = true;						\
> +	__ret;								\
> +})
> +#endif
> +
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
> +// e4c677b23b3fd5e8dc4bce9d6c055103666cfc4a
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -599,6 +599,27 @@ atomic_dec_if_positive(atomic_t *v)
>  	return arch_atomic_dec_if_positive(v);
>  }
>  
> +#define atomic_inc_overflow(v, L) \
> +({ \
> +	typeof(v) __ai_v = (v); \
> +	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
> +	arch_atomic_inc_overflow(__ai_v, L); \
> +})
> +
> +#define atomic_dec_overflow(v, L) \
> +({ \
> +	typeof(v) __ai_v = (v); \
> +	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
> +	arch_atomic_dec_overflow(__ai_v, L); \
> +})
> +
> +#define atomic_dec_and_test_overflow(v, L) \
> +({ \
> +	typeof(v) __ai_v = (v); \
> +	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
> +	arch_atomic_dec_and_test_overflow(__ai_v, L); \
> +})
> +
>  static __always_inline s64
>  atomic64_read(const atomic64_t *v)
>  {
> @@ -1177,6 +1198,27 @@ atomic64_dec_if_positive(atomic64_t *v)
>  	return arch_atomic64_dec_if_positive(v);
>  }
>  
> +#define atomic64_inc_overflow(v, L) \
> +({ \
> +	typeof(v) __ai_v = (v); \
> +	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
> +	arch_atomic64_inc_overflow(__ai_v, L); \
> +})
> +
> +#define atomic64_dec_overflow(v, L) \
> +({ \
> +	typeof(v) __ai_v = (v); \
> +	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
> +	arch_atomic64_dec_overflow(__ai_v, L); \
> +})
> +
> +#define atomic64_dec_and_test_overflow(v, L) \
> +({ \
> +	typeof(v) __ai_v = (v); \
> +	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
> +	arch_atomic64_dec_and_test_overflow(__ai_v, L); \
> +})
> +
>  static __always_inline long
>  atomic_long_read(const atomic_long_t *v)
>  {
> @@ -1755,6 +1797,27 @@ atomic_long_dec_if_positive(atomic_long_
>  	return arch_atomic_long_dec_if_positive(v);
>  }
>  
> +#define atomic_long_inc_overflow(v, L) \
> +({ \
> +	typeof(v) __ai_v = (v); \
> +	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
> +	arch_atomic_long_inc_overflow(__ai_v, L); \
> +})
> +
> +#define atomic_long_dec_overflow(v, L) \
> +({ \
> +	typeof(v) __ai_v = (v); \
> +	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
> +	arch_atomic_long_dec_overflow(__ai_v, L); \
> +})
> +
> +#define atomic_long_dec_and_test_overflow(v, L) \
> +({ \
> +	typeof(v) __ai_v = (v); \
> +	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
> +	arch_atomic_long_dec_and_test_overflow(__ai_v, L); \
> +})
> +
>  #define xchg(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> @@ -1912,4 +1975,4 @@ atomic_long_dec_if_positive(atomic_long_
>  
>  
>  #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
> -// 66cdf9a0e0a995cba29c61baf018f7ef35974ae5
> +// 702806891ef1d01d76767c55088264ab6a1ef77d
> --- a/include/linux/atomic/atomic-long.h
> +++ b/include/linux/atomic/atomic-long.h
> @@ -515,6 +515,21 @@ arch_atomic_long_dec_if_positive(atomic_
>  	return arch_atomic64_dec_if_positive(v);
>  }
>  
> +#define arch_atomic_long_inc_overflow(v, L) \
> +({ \
> +	arch_atomic64_inc_overflow((v), L) \
> +})
> +
> +#define arch_atomic_long_dec_overflow(v, L) \
> +({ \
> +	arch_atomic64_dec_overflow((v), L) \
> +})
> +
> +#define arch_atomic_long_dec_and_test_overflow(v, L) \
> +({ \
> +	arch_atomic64_dec_and_test_overflow((v), L) \
> +})
> +
>  #else /* CONFIG_64BIT */
>  
>  static __always_inline long
> @@ -1009,6 +1024,21 @@ arch_atomic_long_dec_if_positive(atomic_
>  	return arch_atomic_dec_if_positive(v);
>  }
>  
> +#define arch_atomic_long_inc_overflow(v, L) \
> +({ \
> +	arch_atomic_inc_overflow((v), L) \
> +})
> +
> +#define arch_atomic_long_dec_overflow(v, L) \
> +({ \
> +	arch_atomic_dec_overflow((v), L) \
> +})
> +
> +#define arch_atomic_long_dec_and_test_overflow(v, L) \
> +({ \
> +	arch_atomic_dec_and_test_overflow((v), L) \
> +})
> +
>  #endif /* CONFIG_64BIT */
>  #endif /* _LINUX_ATOMIC_LONG_H */
> -// e8f0e08ff072b74d180eabe2ad001282b38c2c88
> +// 487bc4fea91f23f2a4b42af7d5b49ef9172ae792
> --- a/scripts/atomic/atomics.tbl
> +++ b/scripts/atomic/atomics.tbl
> @@ -44,3 +44,6 @@ inc_not_zero		b	v
>  inc_unless_negative	b	v
>  dec_unless_positive	b	v
>  dec_if_positive		i	v
> +inc_overflow			n	v	L
> +dec_overflow			n	v	L
> +dec_and_test_overflow	m	v	L
> --- /dev/null
> +++ b/scripts/atomic/fallbacks/dec_and_test_overflow
> @@ -0,0 +1,12 @@
> +cat << EOF
> +#define arch_${atomic}_dec_and_test_overflow(_v, _label)		\\
> +({									\\
> +	bool __ret = false;						\\
> +	${int} __new = arch_${atomic}_dec_return(_v);			\\
> +	if (unlikely(__new < 0))					\\
> +		goto _label;						\\
> +	if (unlikely(__new == 0))					\\
> +		__ret = true;						\\
> +	__ret;								\\
> +})
> +EOF
> --- /dev/null
> +++ b/scripts/atomic/fallbacks/dec_overflow
> @@ -0,0 +1,8 @@
> +cat << EOF
> +#define arch_${atomic}_dec_overflow(_v, _label)				\\
> +do {									\\
> +	${int} __new = arch_${atomic}_dec_return(_v);			\\
> +	if (unlikely(__new <= 0))					\\
> +		goto _label;						\\
> +} while (0)
> +EOF
> --- /dev/null
> +++ b/scripts/atomic/fallbacks/inc_overflow
> @@ -0,0 +1,8 @@
> +cat << EOF
> +#define arch_${atomic}_inc_overflow(_v, _label)				\\
> +do {									\\
> +	${int} __old = arch_${atomic}_fetch_inc(_v);			\\
> +	if (unlikely(__old <= 0))					\\
> +		goto _label;						\\
> +} while (0)
> +EOF
> 
> 
