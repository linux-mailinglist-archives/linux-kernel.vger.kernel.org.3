Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E5A472A42
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhLMKfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:35:47 -0500
Received: from foss.arm.com ([217.140.110.172]:51020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241974AbhLMKfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:35:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8C111FB;
        Mon, 13 Dec 2021 02:35:04 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42F4B3F793;
        Mon, 13 Dec 2021 02:35:03 -0800 (PST)
Date:   Mon, 13 Dec 2021 10:35:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 4/9] refcount: Use atomic_*_overflow()
Message-ID: <Ybch1AKtthvI7Obm@FVFF77S0Q05N>
References: <20211210161618.645249719@infradead.org>
 <20211210162313.534215085@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210162313.534215085@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:16:22PM +0100, Peter Zijlstra wrote:
> Use the shiny new atomic_*_overflow() functions in order to have better
> code-gen.
> 
> Strictly speaking, these ops operate on [0, INT_MIN] rather than
> [0, INT_MAX] but this is harmless. At worst another op finds the
> refcount is negative and goes saturate, which is always a possibility
> anyway.
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

With GCC 11.1.0 (and my LSE cleanup), arm64 gets similar:

    40e8:       52800024        mov     w4, #0x1                        // #1
    ...
    4118:       b8e40001        ldaddal w4, w1, [x0]
    411c:       7100003f        cmp     w1, #0x0
    4120:       5400018d        b.le    4150 <alloc_perf_context+0xdc>

> without sacrificing on functionality; the only thing that suffers is
> the reported error condition, which might now 'spuriously' report
> 'saturated' instead of 'inc-from-zero'.

Hmm... maybe it's worth a message to cover both cases, since:

	"refcount_t: saturated; leaking memory"

... may not look as severe an issue as:

	"refcount_t: addition on 0; use-after-free"

Perhaps just:

	"refcount_t: leaking memory or use-after-free"

... and don't bother with the racy read when reporting?


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

Likewise (with my LSE cleanup) for arm64:

    c3ac:       12800001        mov     w1, #0xffffffff                 // #-1
    c3b0:       b8e10001        ldaddal w1, w1, [x0]
    c3b4:       51000421        sub     w1, w1, #0x1
    c3b8:       7100003f        cmp     w1, #0x0
    c3bc:       5400012b        b.lt    c3e0 <ring_buffer_put+0x4c>  // b.tstop
    c3c0:       540001a0        b.eq    c3f4 <ring_buffer_put+0x60>  // b.none

AFAICT the compiler *should* be able to use a single `MOVS` in place of that
`SUB; CMP`, and I think that's either a missed optimization or an artifact of
something in my LSE patches.

> XXX atomic_dec_and_test_overflow() is strictly stronger ordered than
> refcount_dec_and_test() is defined -- Power and Arrghh64 ?

I'll leave the ordering to Will.

As this stands (or with the warning rewrite):

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/refcount.h |   17 +++++++++++++----
>  lib/refcount.c           |    5 +++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -264,7 +264,10 @@ static inline void __refcount_inc(refcou
>   */
>  static inline void refcount_inc(refcount_t *r)
>  {
> -	__refcount_inc(r, NULL);
> +	atomic_inc_overflow(&r->refs, Eoverflow);
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
> +	return atomic_dec_and_test_overflow(&r->refs, Eoverflow);
> +Eoverflow:
> +	refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
> +	return false;
>  }
>  
>  static inline void __refcount_dec(refcount_t *r, int *oldp)
> @@ -340,7 +346,7 @@ static inline void __refcount_dec(refcou
>  	if (oldp)
>  		*oldp = old;
>  
> -	if (unlikely(old <= 1))
> +	if (unlikely(old - 1 <= 0))
>  		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
>  }
>  
> @@ -356,7 +362,10 @@ static inline void __refcount_dec(refcou
>   */
>  static inline void refcount_dec(refcount_t *r)
>  {
> -	__refcount_dec(r, NULL);
> +	atomic_dec_overflow(&r->refs, Eoverflow);
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
