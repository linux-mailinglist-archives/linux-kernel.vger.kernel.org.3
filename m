Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BA746E8F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbhLINVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:21:16 -0500
Received: from foss.arm.com ([217.140.110.172]:56716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233355AbhLINVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:21:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D345811B3;
        Thu,  9 Dec 2021 05:17:37 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.64.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DD8E3F5A1;
        Thu,  9 Dec 2021 05:17:36 -0800 (PST)
Date:   Thu, 9 Dec 2021 13:17:33 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC][PATCH 2/5] refcount: Use atomic_*_ofl()
Message-ID: <YbIB7aJU5ngCcaNj@FVFF77S0Q05N>
References: <20211208183655.251963904@infradead.org>
 <20211208183906.468934357@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208183906.468934357@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 07:36:57PM +0100, Peter Zijlstra wrote:
> Use the shiny new atomic_*_ofl() functions in order to have better
> code-gen.
> 
> Notably refcount_inc() case no longer distinguishes between
> inc-from-zero and inc-negative in the fast path, this improves
> code-gen:
> 
>     4b88:       b8 01 00 00 00          mov    $0x1,%eax
>     4b8d:       f0 0f c1 43 28          lock xadd %eax,0x28(%rbx)
>     4b92:       85 c0                   test   %eax,%eax
>     4b94:       74 1b                   je     4bb1 <alloc_perf_context+0xf1>
>     4b96:       8d 50 01                lea    0x1(%rax),%edx
>     4b99:       09 c2                   or     %eax,%edx
>     4b9b:       78 20                   js     4bbd <alloc_perf_context+0xfd>
> 
> to:
> 
>     4768:       b8 01 00 00 00          mov    $0x1,%eax
>     476d:       f0 0f c1 43 28          lock xadd %eax,0x28(%rbx)
>     4772:       85 c0                   test   %eax,%eax
>     4774:       7e 14                   jle    478a <alloc_perf_context+0xea>

For comparison, I generated the same for arm64 below with kernel.org crosstool
GCC 11.1.0 and defconfig.

For arm64 there's an existing sub-optimiality for inc/dec where the register
for `1` or `-1` gets generated with a `MOV;MOV` chain or `MOV;NEG` chain rather
than a single `MOV` in either case. I think taht's due to the way we build
LSE/LL-SC variants of add() and build a common inc() atop, and the compiler
just loses the opportunity to constant-fold. I'll take a look at how to make
that neater.

Regardless, the code goes from:

    51f4:       52800024        mov     w4, #0x1                        // #1
    ...
    5224:       2a0403e1        mov     w1, w4
    5228:       b8210001        ldadd   w1, w1, [x0]
    522c:       34000261        cbz     w1, 5278 <alloc_perf_context+0xf8>
    5230:       11000422        add     w2, w1, #0x1
    5234:       2a010041        orr     w1, w2, w1
    5238:       37f80181        tbnz    w1, #31, 5268 <alloc_perf_context+0xe8>

to:

    40e8:       52800024        mov     w4, #0x1                        // #1
    ...
    4118:       2a0403e1        mov     w1, w4
    411c:       b8e10001        ldaddal w1, w1, [x0]
    4120:       7100003f        cmp     w1, #0x0
    4124:       5400018d        b.le    4154 <alloc_perf_context+0xe0>

> without sacrificing on functionality; the only thing that suffers is
> the reported error condition, which might now 'spuriously' report
> 'saturated' instead of 'inc-from-zero'.
> 
> refcount_dec_and_test() is also improved:
> 
>     aa40:       b8 ff ff ff ff          mov    $0xffffffff,%eax
>     aa45:       f0 0f c1 07             lock xadd %eax,(%rdi)
>     aa49:       83 f8 01                cmp    $0x1,%eax
>     aa4c:       74 05                   je     aa53 <ring_buffer_put+0x13>
>     aa4e:       85 c0                   test   %eax,%eax
>     aa50:       7e 1e                   jle    aa70 <ring_buffer_put+0x30>
>     aa52:       c3                      ret
> 
> to:
> 
>     a980:       b8 ff ff ff ff          mov    $0xffffffff,%eax
>     a985:       f0 0f c1 07             lock xadd %eax,(%rdi)
>     a989:       83 e8 01                sub    $0x1,%eax
>     a98c:       78 20                   js     a9ae <ring_buffer_put+0x2e>
>     a98e:       74 01                   je     a991 <ring_buffer_put+0x11>
>     a990:       c3                      ret

For arm64 (with your fixlet applied) that goes from:

    c42c:       52800021        mov     w1, #0x1                        // #1
    c430:       4b0103e1        neg     w1, w1
    c434:       b8610001        ldaddl  w1, w1, [x0]
    c438:       7100043f        cmp     w1, #0x1
    c43c:       54000140        b.eq    c464 <ring_buffer_put+0x50>  // b.none
    c440:       7100003f        cmp     w1, #0x0
    c444:       5400028d        b.le    c494 <ring_buffer_put+0x80>

to:

    c3dc:       52800021        mov     w1, #0x1                        // #1
    c3e0:       4b0103e1        neg     w1, w1
    c3e4:       b8e10002        ldaddal w1, w2, [x0]
    c3e8:       0b020021        add     w1, w1, w2
    c3ec:       7100003f        cmp     w1, #0x0
    c3f0:       5400012b        b.lt    c414 <ring_buffer_put+0x50>  // b.tstop
    c3f4:       540001a0        b.eq    c428 <ring_buffer_put+0x64>  // b.none

I think the add here is due to  the change in your fixlet:

-       if (unlikely(old <= 1))                                                                                                                                                                             
+       if (unlikely(old - 1 <= 0)) 

> XXX atomic_dec_and_test_ofl() is strictly stronger ordered than
> refcount_dec_and_test() is defined -- Power and Arrghh64 ?

I'll leave the ordering to Will.

Thanks,
Mark.

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/refcount.h |   15 ++++++++++++---
>  lib/refcount.c           |    5 +++++
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -264,7 +264,10 @@ static inline void __refcount_inc(refcou
>   */
>  static inline void refcount_inc(refcount_t *r)
>  {
> -	__refcount_inc(r, NULL);
> +	atomic_inc_ofl(&r->refs, Eoverflow);
> +	return;
> +Eoverflow:
> +	refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
>  }
>  
>  static inline __must_check bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
> @@ -330,7 +333,10 @@ static inline __must_check bool __refcou
>   */
>  static inline __must_check bool refcount_dec_and_test(refcount_t *r)
>  {
> -	return __refcount_dec_and_test(r, NULL);
> +	return atomic_dec_and_test_ofl(&r->refs, Eoverflow);
> +Eoverflow:
> +	refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
> +	return false;
>  }
>  
>  static inline void __refcount_dec(refcount_t *r, int *oldp)
> @@ -356,7 +362,10 @@ static inline void __refcount_dec(refcou
>   */
>  static inline void refcount_dec(refcount_t *r)
>  {
> -	__refcount_dec(r, NULL);
> +	atomic_dec_ofl(&r->refs, Eoverflow);
> +	return;
> +Eoverflow:
> +	refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
>  }
>  
>  extern __must_check bool refcount_dec_if_one(refcount_t *r);
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -12,8 +12,13 @@
>  
>  void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
>  {
> +	int old = refcount_read(r);
>  	refcount_set(r, REFCOUNT_SATURATED);
>  
> +	/* racy; who cares */
> +	if (old == 1 && t == REFCOUNT_ADD_OVF)
> +		t = REFCOUNT_ADD_UAF;
> +
>  	switch (t) {
>  	case REFCOUNT_ADD_NOT_ZERO_OVF:
>  		REFCOUNT_WARN("saturated; leaking memory");
> 
> 
