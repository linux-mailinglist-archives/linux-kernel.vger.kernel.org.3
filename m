Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2346DB74
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhLHSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLHSru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:47:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A5AC061746;
        Wed,  8 Dec 2021 10:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DF+dconE3SyxHkFOPtT8h4ddd65yeGgzGwY/+sd6zHo=; b=O4zmVoNULTBNMMa4iBzZfgvruC
        wHQF/J+G5kwKPYQJ7TEp/0kvtekcho+V9vDT7Jy0sMp2EBcFXjo+60FF0P6YpcK2Xxb7B1mYPfEfP
        uxfVfxu3lxAkqgRPWqkePYWViDIxlDtGIR5TCvAd4IZ0ENouisSiI1f7ehO/1EwJdyvykkNo26z9/
        ZbxES3f/RGMYlykHOiL7Y06QoPN2B8E/LMNh+hIN/3hdwKk1liejyt75jEt37qdKPb24xlk4UjY6d
        GJ3KsD9X0RfEc/+nivYMJExAs17FSRLZYVeXhPn9Wj6IinYJ4YimxTPyTY1tyoLeOWsphFOxqRLKz
        +y7puJXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv1vK-000ECB-It; Wed, 08 Dec 2021 18:44:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 277CC9811F7; Wed,  8 Dec 2021 19:44:16 +0100 (CET)
Date:   Wed, 8 Dec 2021 19:44:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <20211208184416.GY16608@worktop.programming.kicks-ass.net>
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
> On Wed, Dec 8, 2021 at 9:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > IOW, the effective range becomes: [1..INT_MIN], which is a bit
> > counter-intuitive, but then so is most of this stuff.
> 
> I'd suggest not codifying it too strictly, because the exact range at
> the upper end might depend on what is convenient for an architecture
> to do.
> 
> For x86, 'xadd' has odd semantics in that the flags register is about
> the *new* state, but the returned value is about the *old* state.

From testing xadd had different flags from add; I've not yet looked at
the SDM to see what it said on the matter.

> That means that on x86, some things are cheaper to test based on the
> pre-inc/dec values, and other things are cheaper to test based on the
> post-inc/dec ones.
> 
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

Yeah; I don't have it all in-cache either; I'll go through it tomorrow
or something to see what I can make of it.

Meanwhile I did send out what I had.
