Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69644700CC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbhLJMlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbhLJMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:41:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F95C0617A2;
        Fri, 10 Dec 2021 04:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=upZrkzNRX4XwrRuwRkvlfne+DDf3aGO8UN9C87AyJrw=; b=AMUb+1e88kQ2/eFpzwALfCt98m
        Fr8Y6upZSgYpSJT5Daumr8MEkczw0xGhK10Qsx9iP949U0MC3xRS+btFouA2AvKmPq1iRakx/vGMB
        XMeI1Uta4T2/cLThA0U6H9Iv805FdebVCDM1tqrl65n4HXoWA9hu5cE4SgfJ24Gr2T5s8t19F8XW2
        KN9uwTQPjS604+QUbdLIImF0QM17RNykDaUdxKAq1+moHgGRBW75Pbm0c2lZ5NZhgCT2vwKtiI3o0
        /jZM4pJQBfWam57JJvZ04genUd4X2BBH8qQaCrnLAXcGjwR8QAlNrmeQIeNojwQjbZE6P+kFwwomv
        BwbR3scg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvfA8-00AJyT-RP; Fri, 10 Dec 2021 12:38:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5431D3001C0;
        Fri, 10 Dec 2021 13:38:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 118E92B3C36BD; Fri, 10 Dec 2021 13:38:07 +0100 (CET)
Date:   Fri, 10 Dec 2021 13:38:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <YbNKLwMm+hv14WZs@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
 <20211207202831.GA18361@worktop.programming.kicks-ass.net>
 <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com>
 <YbDmWFM5Kh1J2YqS@hirez.programming.kicks-ass.net>
 <CAHk-=wiFLbv2M9gRkh6_Zkwiza17QP0gJLAL7AgDqDArGBGpSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFLbv2M9gRkh6_Zkwiza17QP0gJLAL7AgDqDArGBGpSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:00:04AM -0800, Linus Torvalds wrote:

> It's also why for "page->_mapcount" we have the "free" value being -1,
> not 0, and the refcount is "off by one". It makes the special cases of
> "increment from zero" and "decrement to zero" be very easy and
> straightforward to test for.
> 
> That might be an option for an "atomic_ref" type - with our existing
> "page_mapcount()" code being the thing we'd convert first, and make be
> the example for it.
> 
> I think it should also make the error cases be very easy to check for
> without extra tests. If you make "decrement from zero" be the "ok, now
> it's free", then that shows in the carry flag. But otherwise, if SF or
> OF is set, it's an error.  That means we can use the regular atomics
> and flags (although not "dec" and "inc", since we'd care about CF).
> 
> So on x86, I think "atomic_dec_ref()" could be
> 
>         lock subl $1,ptr
>         jc now_its_free
>         jl this_is_an_error
> 
> if we end up having that "off by one" model.
> 
> And importantly, "atomic_inc_ref()" would be just
> 
>         lock incl ptr
>         jle this_is_an_error
> 
> and this avoids us having to have the value in a register and test it
> separately.
> 
> So your suggestion is _close_, but note how you can't do the "inc_ofl"
> without that "off-by-one" model.
> 
> And again - I might have gotten the exact flag test instructions
> wrong. That's what you get for not actually doing serious assembly
> language for a couple of decades.


add(         -3):       CF=0 PF=0 AF=0 ZF=0 SF=1 ... OF=0       | sub(         -3):     CF=0 PF=1 AF=0 ZF=0 SF=1 ... OF=0
add(         -2):       CF=0 PF=1 AF=0 ZF=0 SF=1 ... OF=0       | sub(         -2):     CF=0 PF=0 AF=0 ZF=0 SF=1 ... OF=0
add(         -1):       CF=1 PF=1 AF=1 ZF=1 SF=0 ... OF=0       | sub(         -1):     CF=0 PF=0 AF=0 ZF=0 SF=1 ... OF=0
add(          0):       CF=0 PF=0 AF=0 ZF=0 SF=0 ... OF=0       | sub(          0):     CF=1 PF=1 AF=1 ZF=0 SF=1 ... OF=0
add(          1):       CF=0 PF=0 AF=0 ZF=0 SF=0 ... OF=0       | sub(          1):     CF=0 PF=1 AF=0 ZF=1 SF=0 ... OF=0
add(          2):       CF=0 PF=1 AF=0 ZF=0 SF=0 ... OF=0       | sub(          2):     CF=0 PF=0 AF=0 ZF=0 SF=0 ... OF=0
add(          3):       CF=0 PF=0 AF=0 ZF=0 SF=0 ... OF=0       | sub(          3):     CF=0 PF=0 AF=0 ZF=0 SF=0 ... OF=0
               :                                                |               :
add( 2147483645):       CF=0 PF=0 AF=0 ZF=0 SF=0 ... OF=0       | sub( 2147483645):     CF=0 PF=1 AF=0 ZF=0 SF=0 ... OF=0
add( 2147483646):       CF=0 PF=1 AF=0 ZF=0 SF=0 ... OF=0       | sub( 2147483646):     CF=0 PF=0 AF=0 ZF=0 SF=0 ... OF=0
add( 2147483647):       CF=0 PF=1 AF=1 ZF=0 SF=1 ... OF=1       | sub( 2147483647):     CF=0 PF=0 AF=0 ZF=0 SF=0 ... OF=0
add(-2147483648):       CF=0 PF=0 AF=0 ZF=0 SF=1 ... OF=0       | sub(-2147483648):     CF=0 PF=1 AF=1 ZF=0 SF=0 ... OF=1
add(-2147483647):       CF=0 PF=0 AF=0 ZF=0 SF=1 ... OF=0       | sub(-2147483647):     CF=0 PF=1 AF=0 ZF=0 SF=1 ... OF=0
add(-2147483646):       CF=0 PF=1 AF=0 ZF=0 SF=1 ... OF=0       | sub(-2147483646):     CF=0 PF=0 AF=0 ZF=0 SF=1 ... OF=0
add(-2147483645):       CF=0 PF=0 AF=0 ZF=0 SF=1 ... OF=0       | sub(-2147483645):     CF=0 PF=0 AF=0 ZF=0 SF=1 ... OF=0

So:

e := z
l := s!=o

inc()						inc()
	lock inc %[var]                     		mov       $-1, %[reg]
	jle	error-zero-or-negative          	lock xadd %[reg], %[var]
                                                	test      %[reg], %[reg]
                                                	jle	  error-zero-or-negative
                                                
dec()                                           dec()
	lock sub $1, %[var]                     	lock dec %[var]
	jc	error-to-zero                   	jle	error-zero-or-negative
	jl	error-from-negative             
                                                
dec_and_test()                                  dec_and_test()
	lock sub $1, %[var]                     	lock dec %[var]
	jc	do-free                         	jl	error-from-negative
	jl	error-from-negative             	je	do-free


Should work I suppose, and gives [-1, INT_MIN] as operating range. It
adds a single branch instruction (which should be default predicted
not-taken due to being a forward jump IIRC) but makes inc a lot smaller.


Except I've no sane idea how to make it work with the rest of
refcount_t. The best I can seem to come up with is something like:

#define ATOMIC_OFL_OFFSET	1

static inline int refcount_read(const refcount_t *r)
{
	return atomic_read(&r->refs) + ATOMIC_OFL_OFFSET;
}

static inline void refcount_set(refcount_t *r, int n)
{
	atomic_set(&r->refs, n - ATOMIC_OFL_OFFSET);
}

static inline __must_check bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
{
	int old = atomic_read(&r->refs);

	do {
		if (old == -ATOMIC_OFL)
			break;
	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));

	old += ATOMIC_OFL_OFFSET;

	if (oldp)
		*oldp = old;

	if (unlikely(old < 0 || (i > 1 && old + i < 0)))
		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);

	return old;
}

static inline void __refcount_add(int i, refcount_t *, int *oldp)
{
	int old = atomic_fetch_add_relaxed(i, &r->refs) + ATOMIC_OFL_OFFSET;

	if (oldp)
		*oldp = old;

	if (unlikely(!old))
		refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
	if (unlikely(old < 0 || old + i < 0)
		refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
}

And have the generic code have: ATOMIC_OFL_OFFSET == 0.

Do we *really* want to do that ?

With the above, __refcount_add_not_zero(), for the common case of: @i=1,
@oldp=NULL we get:

    a8f7:       41 8b 04 24             mov    (%r12),%eax
    a8fb:       83 f8 ff                cmp    $0xffffffff,%eax
    a8fe:       74 1a                   je     a91a <ring_buffer_get+0x3a>
    a900:       8d 50 01                lea    0x1(%rax),%edx
    a903:       f0 41 0f b1 14 24       lock cmpxchg %edx,(%r12)
    a909:       75 f0                   jne    a8fb <ring_buffer_get+0x1b>
    a90b:       85 d2                   test   %edx,%edx
    a90d:       78 19                   js     a928 <ring_buffer_get+0x48>

Which is actually really nice because i == ATOMIC_OFL_OFFSET.

Anybody? For now I think I'll drop the documentation patch and do this
scheme as the last patch in the series for v2.

Also, Mark suggested I rename the new primitives to:
atomic_*_overflow().
