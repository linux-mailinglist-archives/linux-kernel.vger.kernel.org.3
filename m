Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28E46D93D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhLHRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhLHRLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:11:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D46C061746;
        Wed,  8 Dec 2021 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T1bNpG+EBOuRlHH8vImEKgCRxGudYeuCoNpTVnj0b+c=; b=VQLqA4SbOYcUyV3Ay2a3uirOb+
        zPz16CQN+Ni4oG3lBL9zWnoct6F6pLblHGiRJ04BQeKAjAAsjTg6uENPONkuYEMSYbRj2h+O6wqXq
        WOM0HWJWqoLiwuRxD6QiwL8NKwS6XiQVycxNwtcP6vwe5nDXelhkuOpl/StENXkPUiU6T5asw6Bdh
        IAfj7yNOVAbm9ONZrCWATl3IJ9QhMK4Iez17APXSiwnodzb9q1e06nhabTjH7k+6Wz8j0daKoz6cR
        wvMYtzmGhfJSvxcFLW3LgddO03Szgxfa51bEka8oejnpOBtvToJiYTDoEQgOFCVOpyVZZ4rVwOn6L
        4+x1+REQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv0Po-008blB-SJ; Wed, 08 Dec 2021 17:07:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64A7D3000E6;
        Wed,  8 Dec 2021 18:07:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B091264EB862; Wed,  8 Dec 2021 18:07:36 +0100 (CET)
Date:   Wed, 8 Dec 2021 18:07:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <YbDmWFM5Kh1J2YqS@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
 <20211207202831.GA18361@worktop.programming.kicks-ass.net>
 <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:23:02PM -0800, Linus Torvalds wrote:
> On Tue, Dec 7, 2021 at 12:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Argh.. __atomic_add_fetch() != __atomic_fetch_add(); much confusion for
> > GCC having both. With the right primitive it becomes:
> >
> >         movl    $1, %eax
> >         lock xaddl      %eax, (%rdi)
> >         testl   %eax, %eax
> >         je      .L5
> >         js      .L6
> >
> > Which makes a whole lot more sense.
> 
> Note that the above misses the case where the old value was MAX_INT
> and the result now became negative.
> 
> That isn't a _problem_, of course. I think it's fine. But if you cared
> about it, you'd have to do something like

Hm....

> But if you don't care about the MAX_INT overflow and make the overflow
> boundary be the next increment, then just make it be one error case:
> 
> >         movl    $1, %eax
> >         lock xaddl      %eax, (%rdi)
> >         testl   %eax, %eax
> >         jle      .L5
> 
> and then (if you absolutely have to distinguish them) you can test eax
> again in the slow path.

Suppose:

  inc(): overflow when old value is negative or zero
  dec(): overflow when new value is negative or zero

That gives:

  inc(INT_MAX) is allowed
  dec(INT_MIN) is allowed

IOW, the effective range becomes: [1..INT_MIN], which is a bit
counter-intuitive, but then so is most of this stuff.

Therefore can write this like:

#define atomic_inc_ofl(v, label)
do {
	int old = atomic_fetch_inc(v);
	if (unlikely(old <= 0))
		goto label;
} while (0)

#define atomic_dec_ofl(v, label)
do {
	int new = atomic_dec_return(v);
	if (unlikely(new <= 0))
		goto label;
} while (0)

#define atomic_dec_and_test_ofl(v, label)
({
	bool ret = false;
	int new = atomic_dec_return(&r->refs);
	if (unlikely(new < 0))
		goto label;
	if (unlikely(new == 0)
		ret = true;
	ret;
})

For a consistent set of primitives, right?

Which already gives better code-gen than we have today.

But that then also means we can write dec_ofl as:

	lock decl %[var]
	jle %l1

and dec_and_test_ofl() like:

	lock decl %[var]
	jl %l2
	je %l[__zero]

Lemme finisht the patches and send that out after dinner.
