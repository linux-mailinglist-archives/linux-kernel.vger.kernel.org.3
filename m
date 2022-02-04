Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484024A99E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358143AbiBDNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiBDNYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:24:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A1C061714;
        Fri,  4 Feb 2022 05:24:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1560DB83705;
        Fri,  4 Feb 2022 13:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7805CC340E9;
        Fri,  4 Feb 2022 13:24:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CSA8JdcH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643981060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=18izhwgSNhCPvyg6R5IhffaHNCE+hzAno0/hb73Eee0=;
        b=CSA8JdcH18KNJb9DKxFgcBmsgXJ4ANNwgxcWk9ZHymdk46lnsGnOdfKE0XJ2Cr7uUJ2/uM
        UTDmVN63zEqN3YUcAowvmnfFIKJr45EYZRF39jxaP+NPjqVwz4iYH3iYnBjTvcS4Fdqp0Q
        S1+wwH+WYNsqaw1CYuFVtOVS5Z0iL2I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 69ff4d38 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 4 Feb 2022 13:24:20 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id w81so18525262ybg.12;
        Fri, 04 Feb 2022 05:24:19 -0800 (PST)
X-Gm-Message-State: AOAM530BwA7aH9TSkzqFW7Otzd96C0rqfjGPwUqm9QZXzQr4EeF9OG//
        ZnL/0PqG+EzNG7RVah27lfxXmxFXUMb60CZwzyQ=
X-Google-Smtp-Source: ABdhPJyIf87wBrPj2nnbx3qf/Yj71uWjDvePfiO222pOACGb+CApXxPfXVbzRX3d8i5ggYasfZSglR1RKR0BYd10HTQ=
X-Received: by 2002:a05:6902:726:: with SMTP id l6mr2859746ybt.115.1643981058597;
 Fri, 04 Feb 2022 05:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20220201161342.154666-1-Jason@zx2c4.com> <YfznyWaVCz3Yl1ma@sol.localdomain>
In-Reply-To: <YfznyWaVCz3Yl1ma@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Feb 2022 14:24:07 +0100
X-Gmail-Original-Message-ID: <CAHmME9ppY5QY7QCXK1HapEUY9nOn3VSJgvddypmMj_CVfycPeQ@mail.gmail.com>
Message-ID: <CAHmME9ppY5QY7QCXK1HapEUY9nOn3VSJgvddypmMj_CVfycPeQ@mail.gmail.com>
Subject: Re: [PATCH] random: use computational hash for entropy extraction
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Thanks for your comments.

On Fri, Feb 4, 2022 at 9:46 AM Eric Biggers <ebiggers@kernel.org> wrote:
> What this patch does makes sense, but I'm having a hard time seeing how it maps
> to the paper cited above.  Your code seems to be treating BLAKE2s as an
> arbitrary-length PRF, but "Construction 8" in section B.1 of the paper is
> working with the raw compression function of a hash function.  Can you clarify?

When academics say "based on Merkle-Damgard", they just mean iterative
hashing. In this case, we have:

    refresh_F(s, x) = F(s, x), where s is the hash state, and x is a new input.

Every time new inputs are refreshed into it, they're compressed
together with the prior. In other words, "what a hash function does"
that broadly uses the Merkle-Damgard model, which BLAKE2s does. Modern
real hash functions also have a bit of extra book keeping - things
like finalization to prevent length extension and such - but these are
still considered MD-based hash functions. We're not going to excavate
the raw BLAKE2s compression function. In particular, I like that we
don't need to do anything funky and can just use something off the
shelf

Actually, though, I should have cited sections 5.1 and 6.4 (fixed now
for v2), which show a model of a next function for a full PRNG rather
than just a finalize for an extractor, which might pique your
interest, as it shows the instantiation of the new state (with F(s,
0)).

With regards to PRF vs a key-less hash function: for BLAKE2s, the
former reduces to the latter, in the sense that keyed BLAKE2s is the
same as ordinary BLAKE2s, except the first thing hashed in is the key
followed by 32 zero bytes (and the IV has a single bit change for
domain separation). We would be totally fine omitting those zeros --
from an entropy perspective they're obviously not adding anything --
but the fact that BLAKE2s is specified like this I think will make the
modeling a bit cleaner and easier. Practically speaking, it doesn't
really matter at all. About the most you could say is that we could
probably be *less* careful and do slightly *less* hashing and still
have a very good construction, but that I'd like to do a bit more.

>
> > -/*
> > - * Originally, we used a primitive polynomial of degree .poolwords
> > - * over GF(2).  The taps for various sizes are defined below.  They
> > - * were chosen to be evenly spaced except for the last tap, which is 1
> > - * to get the twisting happening as fast as possible.
> > - *
>
> The "Theory of operation" comment at the top of the file needs to be updated
> too.

Thanks, I just got rid of that quite outdated section and other things
that reference the old LFSR approach for v2.

There are so many other issues with the documentation comments in
random.c too, that I think I'll also work on a general documentation
cleanup patch at some point down the road. It still documents the old
/dev/random behavior, suggests that RDRAND is faster than ChaCha20,
forgets about getrandom(), and so on and so forth.

> In the above comment, 'key' should be 'seed'.
> Likewise above.

Caught this too right after sending. Fixed now for v2.

Regards,
Jason
