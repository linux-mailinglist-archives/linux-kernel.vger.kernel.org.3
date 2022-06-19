Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A29550CEB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 22:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiFSU2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 16:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiFSU2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 16:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3512EBCD
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 178676125A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26C6C34114;
        Sun, 19 Jun 2022 20:28:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TH5l+MkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655670525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7PYO00C+1JkaHcYEiI/jG7ily4GQbBM3X0Vy7ByCGE=;
        b=TH5l+MkOJB8wY+l6NMhetBq7/0XmEinaJeFWXU//Mxxo7ZLLpNx1xVNCWQiNfQSRB6TXnN
        Rju4kGHm0WoopYdHz5R5xsJJmVFYZdD51S2XlfZ3CDFQwiLHhdy7x40bHuVTJGLAk/BK4A
        CT9tzYdprZ98MzqTsagXj7yigT3irTg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ce6664b4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 19 Jun 2022 20:28:44 +0000 (UTC)
Date:   Sun, 19 Jun 2022 22:28:42 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for 5.19-rc3
Message-ID: <Yq+G+o1QQt75pwx/@zx2c4.com>
References: <165564429738.1413209.17302088152547038708.tglx@xen13>
 <165564429887.1413209.8729918730024457105.tglx@xen13>
 <CAHk-=wgfrUdWBXA-Jx7ZC1x3wwsomou0L6niGgpRS2Hd5rQxyg@mail.gmail.com>
 <Yq9Q84H6HIfkJpoR@zx2c4.com>
 <CAHk-=whTg=MCBYCO_+KQ10qKYhZXKXQ=mdgLc=e2gxHwDwRBxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whTg=MCBYCO_+KQ10qKYhZXKXQ=mdgLc=e2gxHwDwRBxQ@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

On Sun, Jun 19, 2022 at 03:05:23PM -0500, Linus Torvalds wrote:
> On Sun, Jun 19, 2022 at 11:38 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > This was initially my concern too, which I expressed to Sebastian, but
> > he made the point that this area here is rather "special". Actually,
> > randomness isn't really required here.
> 
> That wasn't really my point.
> 
> My point was that there are a lot of uses of prandom_u32() and friends
> in random places. Just grepping for it, there's lots of different
> drivers that use it. Who knows what locking they have.
> 
> Clearly nobody *thought* about it. This one issue is purely about RT
> correctness, but how about all the uses that just want a pseudo-random
> number and may have performance issues, or may be calling things so
> much that a lock is just bad.
> 
> The thing is, that prandom code used to be FAST. Not just "no locks",

In my benchmarks, get_random_u32() is on par with the old prandom_u32()
now. And a large part of that is that get_random_u32() is almost always
lockless. Every once in a while it needs to refill its buffer, so it
uses get_random_bytes(). And guess what? That too is almost always
lockless. But every once in a while -- on the order of once a minute --
get_random_byes() takes an extremely short spinlock that just does one
block of chacha. And that's only if get_random_u32()'s buffer being
empty is the thing to trigger the reseeding there. So taken together,
this means there's a very short spinlock once per minute, and only if
the stars align. That means performance and lock contention here is
really not an issue.

That's not to say we couldn't optimize the whole thing even further. I
think we probably can, should it become necessary or desirable or even
simply a fun thing to do. But hard as I tried, I couldn't find anywhere
that this was a problem from a performance perspective. And in some real
world cases (e.g. network stack), the performance was a little better.

So far, the one category of gotchas are when this is used from inside of
a raw spinlock, because that makes RT upset. I've seen two cases of
this, both of which were trivial to resolve. If it balloons into lots of
cases, or if multiple hard to address categories emerge, then maybe
we'll need to look at it differently. But for now this seems like a very
manageable problem.

Jason
