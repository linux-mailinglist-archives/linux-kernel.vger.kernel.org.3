Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247B0521E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbiEJPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345769AbiEJPak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:30:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEE0E8B;
        Tue, 10 May 2022 08:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA57CB81D2E;
        Tue, 10 May 2022 15:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB09EC385A6;
        Tue, 10 May 2022 15:21:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oSz0v5jD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652196116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQUkGCxXuyYdfB8EFts+R/cnSrZv1NNEb17EWkTxpE0=;
        b=oSz0v5jDiso+8LQSOyfVPpH0gl/qQ2kBl3bRjz9RkAqImxsVIL172g2Y2cT+ytv5RZdZC4
        Vct5QvyVIxRfWBmhLOm36xiAe5bECP92C8+C3ZFHolt8F3u7t/9qXKJINSelQQotw7XmqT
        Zmq4auWd/ClKcPYJdQ6xClHUWJ5Xsow=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a0f2cae3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 10 May 2022 15:21:55 +0000 (UTC)
Date:   Tue, 10 May 2022 17:21:47 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Yevgeniy Dodis <dodis@cs.nyu.edu>
Cc:     tytso <tytso@mit.edu>, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Noah Stephens-Dawidowitz <noahsd@gmail.com>,
        Stefano Tessaro <tessaro@cs.washington.edu>,
        torvalds@linux-foundation.org, "D. J. Bernstein" <djb@cr.yp.to>,
        jeanphilippe.aumasson@gmail.com, jann@thejh.net,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        Peter Schwabe <peter@cryptojedi.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: is "premature next" a real world rng concern, or just an
 academic exercise?
Message-ID: <YnqDC25iR8mcL3XB@zx2c4.com>
References: <YmlMGx6+uigkGiZ0@zx2c4.com>
 <Ym3ZM1P+uYYABtRm@mit.edu>
 <Ym5sICj5iBMn2w/E@zx2c4.com>
 <CAMvzKsiA52Si=PzOJXYwGSA1WUz-1S0A8cpgRJWDzpMkfFbX+Q@mail.gmail.com>
 <CAMvzKsiMY_+8HZqeFqD3tR65a3-JB0LG=+0jBBy1zF4GanrsGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMvzKsiMY_+8HZqeFqD3tR65a3-JB0LG=+0jBBy1zF4GanrsGA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yevgeniy,

Thanks for your email. Replies to parts are inline below:

On Mon, May 9, 2022 at 11:15 AM Yevgeniy Dodis <dodis@cs.nyu.edu> wrote:
> 2) As Jason says, there are two distinct attack vectors needed to make the premature next attack.
> A) compromising the state
> B) (nearly) continuously observing RNG outputs
>
> I agree with Jason's point that finding places where
> -- A)+B) is possible, but
> --- A)+A) is not possible,
> is tricky.

That's a useful way of describing the problem.

> Although Nadya kind of indicated a place like that. VM1 and VM2 start
> with the same RNG state (for whatever reason). VM1 is insecure, so can
> leak the state via A). VM2 is more secure, but obviously allows for B)
> through system interface. This does not seem so hypothetical for me,
> especially in light of my mega-point 1) above -- almost any real-world
> RNG attack is hard.

Right, VMs are super problematic, but for that, there's now this
"vmgenid" driver, where the hypervisor actually gives a 128-bit seed to
guests when they're resumed, so that we can immediately reseed, which
should pretty comprehensively handle that situation.

> Protection against A) is trickier. But my read of Jason's email is
> that all his criticism comes exactly from this point.  If your system
> allows for state compromise, you have bigger problems than the
> premature next, etc. But let's ask ourselves the question. Are we
> ready to design RNGs without recovery from state compromise? I believe
> nobody on this list would be comfortable saying "yes". Because this
> would mean we don;t need to accumulate entropy beyond system start-up.
> Once we reach the point of good initial state, and state compromise is
> not an issue, just use straight ChaCha or whatever other stream
> cipher.
>
> The point is, despite all arguments Jason puts, we all would feel
> extremely uncomfortable/uneasy to let continuous entropy accumulation
> go, right?

I went through the same thought experiment. If we're not considering
premature next, maybe we shouldn't consider compromises _in general_, in
which case we'd just seed once at boot and then never again. But as you
rightfully point out, nobody here is okay with such a thing. The reason
you've provided for that feeling is that A) without B) is still
something important to defend against. But there's another more basic
reason, which is that we really can't be certain exactly /when/ we've
gathered enough entropy that the RNG is initialized. Sure, we try to
estimate that using some pretty questionable algorithms, so that
getrandom() can "unblock" at some point when the RNG has been deemed to
be sufficiently initialized. But that is a guess at best, and the most
we can say is that *eventually* it becomes initialized, but we never
really know when that is, given that we can't even begin to accurately
model all of the machines Linux runs on. So since we can't actually
determine when we've initialized, for that reason alone our only choice
is to keep gathering new entropy and reseeding periodically (or
continuously, as Nadia recommends).

> This means we all hopefully agree that we need protection against A) and B) individually.
>
> 3) Now comes the question. If we want to design a sound RNG using tools of modern cryptography, and we allow
> the attacker an individual capability to enforce A) or B) individually, are we comfortable with the design where we:
> * offer protection against A)
> * offer protection against B)
> * do NOT offer protection against A)+B), because we think it's too expensive given A)+B) is so rare?

There's an additional point to consider here, which I took to be Nadia's
main idea: any kind of protection against A)+B) will hinder protection
against A) individually. All current solutions to A)+B) involve some
form of buffering / delaying of using new entropy sources, because
they're sent to different pools, or are simply not used until a certain
threshold, etc. Meanwhile, better protection against A) individually
involves making use of new entropy as soon as possible, to reduce the
duration of time in which the RNG is compromised and doing dangerous
things. Since we can't actually know when a compromise is over or when
enough new entropy has been collected, the best we can do is "as soon as
possible", which means any form of a delay is contrary to that goal.

So it's not just that A)+B) is both an unlikely attack vector and has
solutions that involve undue implementation complexity, but also that
A)+B) solutions weaken solutions to the heavier problem of A)
individually.

> I do not have a convincing answer to this question, but it is at least
> not obvious to me. On a good note, one worry we might have is how to
> even have a definition protecting A), protecting B), but not
> protecting A)+B).  Fortunately, our papers resolve this question
> (although there are still theoretical annoyances which I do not want
> to get into in this email). So, at least from this perspective, we are
> good. We have a definition with exactly these (suboptimal) properties.

I actually would be interested to see how you have this defined. It
seems like from a formal perspective, this issue with being "eventually
seeded" naturally leads itself to Fortuna-like designs, where the whole
design is structured around eventually meeting the desired security
properties. But on the other hand a A) without B) design would suggest
some notion of being properly seeded at some point in time, and when
that is seems hard to define. So anyway I'm curious to learn how you've
organized this. 

Regards,
Jason
