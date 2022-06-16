Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097D854E7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378256AbiFPQps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378230AbiFPQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:45:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8A403F8;
        Thu, 16 Jun 2022 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rdCg6im4FTYRC+krLkTNcrz9yXNDSAEOLtpVfWokJzk=; b=lIYqkylRNsFWHYC10t48L3rTzz
        yBq8yCuNVVYqjoqPFXIS46lBCHD2NlAezsgABwyHdfMw66+kZP182Ua/ep6vVGNTs4F4CopCrFbEw
        BWwqJURZ+2cthMYSs2sTja5FH6wt9G7AD7XNbVJa6piDo9PI9RUuHDlswpJ0uDp36s2PxE+EBlFod
        Ea/aw52v+C5EArkPseYDvvLUiGIaKYuhrvSLyidul12C5DII7ZZBPjIYY8bncKLacdtXhZJCZgYw4
        YkddyDxUs+Bv8mvNdNch9eNcVV46iAs17/v9EfjT1Whiyq+JdK1E62ph6AEv4FwDeksedEJK6XfI+
        e6jnqHCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1sba-0025gl-SZ; Thu, 16 Jun 2022 16:44:26 +0000
Date:   Thu, 16 Jun 2022 17:44:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
Message-ID: <Yqtd6hTS52mbb9+q@casper.infradead.org>
References: <20220616143617.449094-1-Jason@zx2c4.com>
 <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com>
 <YqtKjAZRPBVjlE8S@casper.infradead.org>
 <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 08:59:51AM -0700, Linus Torvalds wrote:
> On Thu, Jun 16, 2022 at 8:21 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I don't know why people call uintptr_t a "userspace type".  It's a type
> > invented by C99 that is an integer type large enough to hold a pointer.
> > Which is exactly what we want here.
> 
> On the other hand, "unsigned long" has existed since the first version
> of C, and is an integer type large enough to hold a pointer.
> 
> Which is exactly what we want here, and what we use everywhere else too.
> 
> The whole "uintptr_t handles the historical odd cases with pointers
> that are smaller than a 'long'" is entirely irrelevant, since those
> odd cases are just not a factor.

I don't care about the odd historical cases either.

> And the "pointers are _larger_ than a 'long'" case is similarly
> irrelevant, since we very much want to use arithmetic on these things,
> and they are 'long' later. They aren't used as pointers, they are used
> as integer indexes into the virtual address space that we do odd
> operations on.
> 
> Honestly, even if you believe in the 128-bit pointer thing, changing
> one cast in one random place to be different from everything else is
> *not* productive. We're never going to do some "let's slowly migrate
> from one to the other".
> 
> And honestly, we're never going to do that using "uintptr_t" anyway,
> since it would be based on a kernel config variable and be a very
> specific type, and would need to be type-safe for any sane conversion.
> 
> IOW, in a hypothetical word where the address size is larger than the
> word-size, it would have to be something like out "pte_t", which is
> basically wrapped in a struct so that C implicit type conversion
> doesn't bite you in the arse.

I don't want to support an address space larger than word size.  I can't
imagine any CPU vendor saying "So we have these larger registers that
you can only use for pointers and then these smaller registers that you
can use for data".  We haven't had A/D register splits since the m68k.
Perhaps I haven't talked to enough crazy CPU people.  But if anyone does
propose something that bad, we should laugh at them.

So how do you think we should solve the 128-bit-word-size problem?
Leave int at 32-bit, promote long to 128-bit and get the compiler to
add __int64 to give us a 64-bit type?

> We use the user-space types in a few places, and they have caused
> problems, but at least they are really traditional and the compiler
> actually enforces them for some really standard functions. I'm looking
> at 'size_t' in particular, which caused problems exactly because it's
> a type that is strictly speaking not under our control.
> 
> 'size_t' is actually a great example of why 'uintptr_t' is a horrid
> thing. It's effectively a integer type that is large enough to hold a
> pointer difference. On unsegmented architectures, that ends up being a
> type large enough to hold a pointer.

The only reason I like size_t is that it's good _documentation_.
It says "This integer is a byte count of something that's in memory".
As opposed to being a count of sectors, blocks, pages, pointers or
turtles.

As an example:
extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
                           unsigned int, unsigned int);

What the hell are those two ints?  Based on experience, they're probably
offset & length, but who even knows what order they're in.

> And does it sound familiar how on some architectures it's "unsigned
> int", and on others it is "unsigned long"? It's very annoying, and
> it's been annoying over the years. The latest annoyance was literally
> less than a week ago in 1c27f1fc1549 ("iov_iter: fix build issue due
> to possible type mis-match").

Yes, ARM is just crazy here.  We should get the compiler people to give
us an option to make size_t unsigned long.  Like we have -mcmodel=kernel
on x86.

