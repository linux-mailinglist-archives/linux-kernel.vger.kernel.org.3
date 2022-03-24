Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108FA4E67A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352221AbiCXRWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344397AbiCXRWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:22:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20267986F6;
        Thu, 24 Mar 2022 10:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA30619AC;
        Thu, 24 Mar 2022 17:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B782C340EC;
        Thu, 24 Mar 2022 17:20:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jIWOtICf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648142442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xB6PKulHp1/cEWNkjE3fDsI4g/vmyOx8TKxWNMPVing=;
        b=jIWOtICfivw//orbUKop1uPxm/X9yEN5M12kFp6+SL+mY9RcEN7uXVzjiutiLabpgi0H9R
        suATOPU2xZBBNI9oTbDCSWUwYPkIycAInnkrD4jlGzMxDiLe3KCkyyTpiXO6Vd1SLEKcgC
        ipwAXnIwhRuLdMhxRft45gNkRv13qHE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7c58b031 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Mar 2022 17:20:41 +0000 (UTC)
Date:   Thu, 24 Mar 2022 11:20:40 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Message-ID: <YjyoaEZLb+GzxJFT@zx2c4.com>
References: <20220322191436.110963-1-Jason@zx2c4.com>
 <1648009787.fah6dos6ya.none@localhost>
 <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
 <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com>
 <1648138746.2zrnsqdlu7.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1648138746.2zrnsqdlu7.none@localhost>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Thu, Mar 24, 2022 at 10:29 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> Excerpts from Jason A. Donenfeld's message of March 23, 2022 11:18 pm:
> > Hi all,
> >
> > [...]
> >
> > In light of that conclusion, I'm going to work with every userspace
> > downstream I can find to help them fix their file-based seeding, if it
> > has bugs. I've started talking with the buildroot folks, and then I'll
> > speak with the OpenRC people (being a Gentoo dev, that should be easy
> > going). Systemd does the right thing already.
> >
> > I wrote a little utility for potential inclusion in
> > busybox/util-linux/whatever when it matures beyond its current age of
> > being half hour old:
> > - https://git.zx2c4.com/seedrng/about/
> > - https://git.zx2c4.com/seedrng/tree/seedrng.c
> > So I'll see what the buildroot people think of this and take it from there.
> >
> > The plus side of doing all this is that, if the efforts pan out, it
> > means there'll actually be proper seeding on devices that don't
> > currently do that, which then might lead to a better ecosystem and
> > less boot time blocking and all that jazz.
> >
> > Jason
> >
>
> The issue, in systemd developers' opinion, is that counting seed file
> towards entropy initialization potentially causes repeated RNG output if
> a system is cloned without resetting the seed file. This is discussed at
> length in https://github.com/systemd/systemd/pull/4513. A few years ago,
> I wrote most of a program to check machine ID, disk ID, DMI ID, and some
> other things in order to avoid this issue. Since then, systemd decided
> to store the random seed in EFI variables, I assume on the basis that
> machine cloning typically does not clone the EFI variables? In my
> opinion, since the same argument applies to machine ID, ssh keys, and
> any other persistent cryptographic (or even non-cryptographic) material,
> this falls outside the scope of random seeding and into a general
> machine cloning "sysprep"-like utility.

systemd's seed utility will credit a seed file if the seed file was
generated properly (e.g. after the RNG was initialized). For that they
use the user.random-seed-creditable xattr, which is a reasonable way of
deciding. If that attribute is present, it's credited; if it's not, it's
not. Here's their source:

        /* If we got this random seed data from getrandom() the data is suitable for crediting
         * entropy later on. Let's keep that in mind by setting an extended attribute. on the file */
        if (getrandom_worked)
                if (fsetxattr(seed_fd, "user.random-seed-creditable", "1", 1, 0) < 0)
                        log_full_errno(ERRNO_IS_NOT_SUPPORTED(errno) ? LOG_DEBUG : LOG_WARNING, errno,
                                      "Failed to mark seed file as creditable, ignoring: %m");

Since my seedrng.c is designed for more minimal systems (running
buildroot or openrc or whatever), which might not have xattrs available,
it distinguishes just based on the filename:

	if (new_seed_creditable && rename(NON_CREDITABLE_SEED, CREDITABLE_SEED) < 0) {
		fprintf(stderr, "ERROR: Unable to make new seed creditable: %s\n", strerror(errno));
		program_ret |= 1 << 6;
	}

It's no surprise that these are very similar; I've read systemd's
seeding logic and contributed a fix to it.

By the way, if you think something is different or wrong or whatever in
seedrng.c, please feel free to send me a patch for it. It already
received its first contribution this morning (from the buildroot
maintainer). Hopefully the code will reach a good settling point soon,
and then various projects that want it can just copy and paste it
verbatim into their environment, and tweak idiomatic things as needed.

Jason
