Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC4550C25
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiFSQoZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Jun 2022 12:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFSQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:44:23 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE91D113;
        Sun, 19 Jun 2022 09:44:21 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E38071C0B8F; Sun, 19 Jun 2022 18:44:19 +0200 (CEST)
Date:   Sun, 19 Jun 2022 18:44:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Message-ID: <20220619164416.GA3362@bug>
References: <20220322191436.110963-1-Jason@zx2c4.com>
 <1648009787.fah6dos6ya.none@localhost>
 <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
 <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Very much so, thanks again. What I take away from your results is:
> >
> > - RNDADDTOENTCNT is in active use in a safe way. Sure, RNDADDENTROPY
> > is still much better, but RNDADDTOENTCNT isn't entirely broken in the
> > above configurations either.
> > - This patch would make RNDADDTOENTCNT unsafe for some of the above
> > configurations in a way that it currently isn't unsafe.
> > - Plenty of things are seeding the RNG correctly, and buildroot's
> > shell script is just "doing it wrong".
> >
> > On that last point, I should reiterate that buildroot's shell script
> > still isn't actually initializing the RNG, despite what it says in its
> > echo; there's never been a way to initialize the RNG from a shell
> > script, without calling out to various special purpose ioctl-aware
> > binaries.
> 
> Based on this, the fact that shell scripts cannot seed the RNG anyway,
> and due to the hazards in trying to retrofit some heuristics onto an
> interface that was never designed to work like this, I'm convinced at
> this point that the right course of action here is to leave this
> alone. There's no combination of /dev/urandom write hacks/heuristics
> that do the right thing without creating some big problem elsewhere.
> It just does not have the right semantics for it, and changing the
> existing semantics will break existing users.
> 
> In light of that conclusion, I'm going to work with every userspace
> downstream I can find to help them fix their file-based seeding, if it
> has bugs. I've started talking with the buildroot folks, and then I'll
> speak with the OpenRC people (being a Gentoo dev, that should be easy
> going). Systemd does the right thing already.
> 
> I wrote a little utility for potential inclusion in
> busybox/util-linux/whatever when it matures beyond its current age of
> being half hour old:
> - https://git.zx2c4.com/seedrng/about/
> - https://git.zx2c4.com/seedrng/tree/seedrng.c
> So I'll see what the buildroot people think of this and take it from there.

You could put it into the kernel into tools/ directory...

Best regards,
									Pavel
