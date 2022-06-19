Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0856C550C3B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiFSQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiFSQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:56:22 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968D29594;
        Sun, 19 Jun 2022 09:56:20 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4046D1C0B8F; Sun, 19 Jun 2022 18:56:19 +0200 (CEST)
Date:   Sun, 19 Jun 2022 18:56:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Message-ID: <20220619165615.GB3362@bug>
References: <20220322191436.110963-1-Jason@zx2c4.com>
 <YjzMPymC3uXQUTrq@gmail.com>
 <CAHmME9p7k2Z2f3aYctHxV9oNwe_GKd62Sghh9Ck1-nRyPaEypA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9p7k2Z2f3aYctHxV9oNwe_GKd62Sghh9Ck1-nRyPaEypA@mail.gmail.com>
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
> > On Tue, Mar 22, 2022 at 01:14:36PM -0600, Jason A. Donenfeld wrote:
> >> For as far back as I can tell, writing to /dev/urandom or /dev/random
> >> will put entropy into the pool, but won't immediately use it, and won't
> >> credit it either.
> >
> > Did you check kernels v4.7 and earlier?  It looks like this actually changed
> > in
> > v4.8 when the ChaCha20 CRNG was introduced.  v4.7 would mix the data written
> > to
> > /dev/{u,}random into {non,}blocking_pool, which would immediately be
> > reflected
> > in reads from /dev/{u,}random, sys_getrandom(), and get_random_bytes().
> > Writes
> > to /dev/{u,}random didn't affect the input_pool, which was separate.
> 
> Oh, I suppose you might be right, actually, that v4.7 and below would
> hash the non blocking pool, and let /dev/urandom write directly into
> it, as something distinct from the input pool. This changed with v4.8,
> 6 years ago, and now there are no LTS kernels that old, with most
> small devices even having vendor kernels v4.9+. v4.8 apparently did

We are still maintaining 4.4 for -cip project, and people running android probably still 
maintain that, too.

> this while fixing a more extreme vulnerability of allowing unprivileged users to 
> bruteforce input bytes (in addition to allowing unbounded unprivileged lock contention). 

I assume this got fixed during the 4.4-stable series?

Best regards,
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
