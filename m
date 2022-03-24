Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A2E4E5D79
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 04:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347943AbiCXDUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 23:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244337AbiCXDUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 23:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3555DFCB;
        Wed, 23 Mar 2022 20:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7FEA6199C;
        Thu, 24 Mar 2022 03:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F408BC340E9;
        Thu, 24 Mar 2022 03:18:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GLvc05F/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648091909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aEOduEdFqKFMsa9nTvbpRapPlloyfuvJVgMDVaG/kLk=;
        b=GLvc05F/ZBFHwRQoMoOJCs6oatQ73VJN9ev+Gl4S0u4drEeyAo50IQndQTv0n/37WzAoxI
        Jr/9Gk9q73hjAKXycqTBurBsapuNvWr3Rw3CD/sGVs3KO46n/5OnC9D4gP9h/ag03/O6Xc
        3n/jr0dET87Aw2YPNdPQcKiUsxR5Q1k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fc86e14f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Mar 2022 03:18:28 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id f38so6247787ybi.3;
        Wed, 23 Mar 2022 20:18:28 -0700 (PDT)
X-Gm-Message-State: AOAM5338wvh+XSteC7liNIrnmEXtdyDhPE8Q6NIHn0oMDo9otX4ihqNL
        xIbU/tlezO6erN98xui0YyYAdvcf8ongkMSBX9c=
X-Google-Smtp-Source: ABdhPJxxixvasKF5K+F4iJp7DM3PyC2Qdmh51RlYyfsnm4HKDWCuCjmR8heKzY7GsSAZI+e4HnmwS2ez/CC3rZNar8A=
X-Received: by 2002:a25:b905:0:b0:61e:23e4:949f with SMTP id
 x5-20020a25b905000000b0061e23e4949fmr2995975ybj.373.1648091907198; Wed, 23
 Mar 2022 20:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220322191436.110963-1-Jason@zx2c4.com> <1648009787.fah6dos6ya.none@localhost>
 <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
In-Reply-To: <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 23 Mar 2022 21:18:16 -0600
X-Gmail-Original-Message-ID: <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com>
Message-ID: <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast init
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Mar 22, 2022 at 10:47 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Very much so, thanks again. What I take away from your results is:
>
> - RNDADDTOENTCNT is in active use in a safe way. Sure, RNDADDENTROPY
> is still much better, but RNDADDTOENTCNT isn't entirely broken in the
> above configurations either.
> - This patch would make RNDADDTOENTCNT unsafe for some of the above
> configurations in a way that it currently isn't unsafe.
> - Plenty of things are seeding the RNG correctly, and buildroot's
> shell script is just "doing it wrong".
>
> On that last point, I should reiterate that buildroot's shell script
> still isn't actually initializing the RNG, despite what it says in its
> echo; there's never been a way to initialize the RNG from a shell
> script, without calling out to various special purpose ioctl-aware
> binaries.

Based on this, the fact that shell scripts cannot seed the RNG anyway,
and due to the hazards in trying to retrofit some heuristics onto an
interface that was never designed to work like this, I'm convinced at
this point that the right course of action here is to leave this
alone. There's no combination of /dev/urandom write hacks/heuristics
that do the right thing without creating some big problem elsewhere.
It just does not have the right semantics for it, and changing the
existing semantics will break existing users.

In light of that conclusion, I'm going to work with every userspace
downstream I can find to help them fix their file-based seeding, if it
has bugs. I've started talking with the buildroot folks, and then I'll
speak with the OpenRC people (being a Gentoo dev, that should be easy
going). Systemd does the right thing already.

I wrote a little utility for potential inclusion in
busybox/util-linux/whatever when it matures beyond its current age of
being half hour old:
- https://git.zx2c4.com/seedrng/about/
- https://git.zx2c4.com/seedrng/tree/seedrng.c
So I'll see what the buildroot people think of this and take it from there.

The plus side of doing all this is that, if the efforts pan out, it
means there'll actually be proper seeding on devices that don't
currently do that, which then might lead to a better ecosystem and
less boot time blocking and all that jazz.

Jason
