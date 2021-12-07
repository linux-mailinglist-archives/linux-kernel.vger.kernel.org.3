Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2253E46B750
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhLGJiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbhLGJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:38:06 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE2C0611F7;
        Tue,  7 Dec 2021 01:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pouzREswlR8li/pK7iHt7FL48EntonyRD78cYY8XFO4=; b=FAKI+lzH9+BsA5g3k5n3Ig/boR
        euWO3M0j1Wtsb/EDaFBy6jAT9Xp8bI7qs3dsFhDvAfJ29fRO3t/nocMaB0x9ioI/rtffjnK+dIlOm
        0edQrMwQmhhnrS4iiQHopaHSZJ4HPQWr8S45/lLn22s6IAT/aGgn1EI11hh6YRd2z7H6DqzbPnkaA
        59XgSfWFlgMs9C4HgNxXx7wPvpd7Cjd1D4dbH8k0Pv6g4VIz390X8rWsTYMO/7SDwBqL6veyc2UGS
        oxnFgHfa/6EK//YnZShQvnXt9kqwcGkfFHAB44GB9RYCQuM10273XJVGW4nmFgdjMCR/r8rUZpGzj
        uUhoXkaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muWrn-002jho-Rk; Tue, 07 Dec 2021 09:34:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 322493002DB;
        Tue,  7 Dec 2021 10:34:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB4DD201D2FE9; Tue,  7 Dec 2021 10:34:30 +0100 (CET)
Date:   Tue, 7 Dec 2021 10:34:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <Ya8qptlJ4yLVUSBi@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk>
 <202112061247.C5CD07E3C@keescook>
 <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
 <202112061455.F23512C3CB@keescook>
 <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:13:00PM -0800, Linus Torvalds wrote:

> Fix it to not unnecessarily use expensive compare-and-exchange loops,
> when you can safely just race a bit, safe in the knowledge that you're
> not going to race 2**31 times.
> 
> IOW, I think that "try_get_page()" function is basically the *much*
> superior version of what is currently a broken "refcount_inc()".
> 
> And yes, it does warn about that overflow case that you claim only
> refcount_t does. And does so without the broken semantics that
> refcount h as.

I think you should perhaps look at the current code again. Those cmpxchg
loops are gone. The only cmpxchg loop that's still there is for
add_not_zero(), and that is the exact same loop we have for
atomic_inc_not_zero(v) := atomic_add_unless(v,1,0) :=
atomic_fetch_add_unless(v,1,0) != 0.

The rest is exactly that LOCK XADD and assume you don't race 2^31 bits
worth.

Now, it could be GCC generates atrociously bad code simply because it
doesn't know it can use the flags from the XADD in which case we can
look at doing an arch asm implementation.

