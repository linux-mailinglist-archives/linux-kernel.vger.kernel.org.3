Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2DF4F87F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiDGTVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiDGTVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294DF24B5E6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D3261E7D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 19:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48C0C385A4;
        Thu,  7 Apr 2022 19:18:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k4XsnA+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649359133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LvRg8QvRqTRh8F7j8GGUwv+9IhojgbYYxehzvAeGlys=;
        b=k4XsnA+H+a4mJMya60eY3DV7FP66iCZ3YPZu1J28bML9g1mMLhBP4oWqbzjnoC0StVCxwK
        ZuF71B0TlHC/IiKYw3uGHn+pLy1YLsfGlHLVpOw5Z2/8w+/XD0q9XX4C1EfQVPPdgYAqFU
        466cIJRoHMmEevhECzTtk7Z5pEIMM1A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3d4980b5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 7 Apr 2022 19:18:52 +0000 (UTC)
Date:   Thu, 7 Apr 2022 21:18:47 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jannh@google.com
Subject: Re: [GIT PULL] random number generator fixes for 5.18-rc2
Message-ID: <Yk85F0sKwTkOVqgI@zx2c4.com>
References: <20220407132839.496822-1-Jason@zx2c4.com>
 <CAHk-=wjrx=xHFfyNt6bU3=xTkdxr3QwuPA-_A0-HKZmoZwWeiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjrx=xHFfyNt6bU3=xTkdxr3QwuPA-_A0-HKZmoZwWeiw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

On Thu, Apr 07, 2022 at 06:34:21AM -1000, Linus Torvalds wrote:
> On Thu, Apr 7, 2022 at 3:29 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > - In order to be more like other devices (e.g. /dev/zero) and to mitigate the
> >   impact of fixing the above bug, which has been around forever (users have
> >   never really needed to check the return value of read() for medium-sized
> >   reads and so perhaps many didn't), we now move signal checking to the bottom
> >   part of the loop, and do so every PAGE_SIZE-bytes.
> 
> Ugh. After fixing a bug where the signal pending state isn't checked
> enough, you then go to extra effort to not do it too much.
> 
> The whole historical "give at least 256 bytes without even checking
> for signal_pending" is also cryptographically entirely bogus, since we
> only actually have CHACHA_BLOCK_SIZE worth of random state
> 
> So if some program doesn't check for short reads, the difference
> between one chacha block and 256 bytes (or PAGE_SIZE like you changed
> it to) really *really* doesn't matter, the rest is going to be purely
> filler anyway. Nice good filler, but still..

Well, cryptographically I don't know if there's actually too much to say
here. Maybe back when we tried with /dev/random to only give out as many
bits to userspace as we'd "gathered" from the environment, and we had
some logic to always leave at least N bytes in the "pool", this made
sense within that deranged scheme. But nowadays we're only ever
expanding a 256-bit key to practically limitless lengths, bringing in
new entropy once every 5 minutes. So I don't think the "give at least N
bytes without checking for signal_pending" is so much related to
cryptographic goals.

Rather, I understood the rationale to be more so related to ease of use
of the interface, so that users could write code like:

    if (getrandom(buf, 256, 0) < 0)
        abort();

And part of why people wanted this was so that they could polyfill
OpenBSD's getentropy() with:

    #define getentropy(buf, len) ((len > 256 || getrandom(buf, len, 0)) ? -1 : 0)

But then glibc added it as a proper function anyway. Of course, checking
the getrandom() return value and incrementally filling a buffer is well
within the domain of things that userspace wrappers tend to do. But
nonetheless, this is what was done, so here we are.

Anyway, the more alarming thing to me when thinking about Jann's patch
was that I've seen code before doing read(urandom, buf, 512) or similar
without checking the return value adequately. That's obviously a bug in
the code, and a rookie one at that. But because of the TIF_NEED_RESCHED
dependency that Jann fixed, nobody actually ever encountered real
consequences of that buggy code. Try out the test program in the commit
message of e3c1c4fd9e6 to see what I mean; it always is megabytes long.

Then I noticed that /dev/zero was only checking every PAGE_SIZE bytes
and figured that doing the same for /dev/urandom would be a good
compromise between the two extremes of fixing Jann's bug with total
purism and refusing to fix Jann's bug in order to cater to obviously
broken code. Rather, it's the middle ground, where nothing changes for
<= 4096 byte reads, which covers the majority of reads out there, and I
would assume nearly all of reads where the return value isn't checked.

Also, that function is just calling chacha20_block() in a loop, which
itself is a lot faster than many other syscalls that are doing all sorts
of more complex things or prodding at atomics or whatever else, so from
a latency perspective, checking for signals every PAGE_SIZE bytes seems
well within bounds too.

I'd understand if you'd prefer to go with the purism route, where we say
buggy code be damned, and check for signals every 64 bytes (the chacha
block size) instead of PAGE_SIZE bytes. But maybe the above is actually
a decent way of minimizing userspace breakage while making the interface
consistent with /dev/zero?

> Also, if you hit a EFAULT, you should still return the partial result
> you got before to be consistent with what we normally do in these
> kinds of situations.

Oh good point. Indeed all other interfaces behave like this. It's hard
to imagine any real code being bit by that changing to be more
consistent. I'll write up a patch for it.

Jason
