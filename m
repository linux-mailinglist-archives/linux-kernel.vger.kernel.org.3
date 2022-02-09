Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED94AE5DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbiBIAWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiBIAWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:22:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B244C06173B;
        Tue,  8 Feb 2022 16:21:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F3CB81DE5;
        Wed,  9 Feb 2022 00:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98217C340E9;
        Wed,  9 Feb 2022 00:21:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="p/hetZUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644366114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQ6XCjuca0gHb7IBipxgluRZP1vfq7sfS5zZ7CqHC/s=;
        b=p/hetZUsL9e76SV3kMlSI2VpzN0erhuP92iqR9yXPnrvx2x0RG7JrIX1Rs6gkbcYJiqlAM
        8gF0fjyMmI7+c6CGSB/l808Kgo41F4GiIQAfI9gGf7dkIxBEJTxb5CSxFluv2TvnA7Sur9
        IMevYjvhDYjl48EYIglQlny2LDnRlGE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 18372bd8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 00:21:54 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id 192so1294115ybd.10;
        Tue, 08 Feb 2022 16:21:53 -0800 (PST)
X-Gm-Message-State: AOAM5324ggbddFFZa8irGOdWmMyZRZgRYWmR4/yY2revh6uBSYq0YHHz
        ztkw9ItN0OEUmo9CD0V8nDw22rTdfyRAYBvFA9o=
X-Google-Smtp-Source: ABdhPJzraCsmgLP4WkQbzGDkTSOQxlGEk2SgcBEXq47jtgUlBENHIhD13qTDRNWnUM4VrzVTpg4amIwIRIGnyJoPcFU=
X-Received: by 2002:a25:42:: with SMTP id 63mr5594754yba.245.1644366112938;
 Tue, 08 Feb 2022 16:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20220208155335.378318-1-Jason@zx2c4.com> <20220208155335.378318-7-Jason@zx2c4.com>
 <YgL/JN+ObjfhEedk@sol.localdomain>
In-Reply-To: <YgL/JN+ObjfhEedk@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Feb 2022 01:21:42 +0100
X-Gmail-Original-Message-ID: <CAHmME9qd0WPqyOqwcsRX+bZzimMj1ZvCGKskGca7Z_Fi9QCYow@mail.gmail.com>
Message-ID: <CAHmME9qd0WPqyOqwcsRX+bZzimMj1ZvCGKskGca7Z_Fi9QCYow@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] random: use simpler fast key erasure flow on
 per-cpu keys
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

Hey Eric,

Thanks a bunch for the review.

On Wed, Feb 9, 2022 at 12:39 AM Eric Biggers <ebiggers@kernel.org> wrote:
> Previously, the extracted entropy was being XOR'ed into the ChaCha key.  Now the
> key is just being overwritten.  This is the approach we should be aiming for,
> but I'm concerned about the fact that add_interrupt_randomness() still sometimes
> adds entropy to the ChaCha key directly without mixing it into the entropy pool.
> That happens via crng_fast_load() when crng_init == 0.  This new approach will
> destroy any entropy that was present in the key only.
>
> The right fix, IMO, would be to always send entropy through the entropy pool.
> Until that is done, though, I'm not sure it's a good idea to overwrite the key
> like this.

I agree with this in principle, and I've been trying to think of a
good way to do it, but it's a bit hard to do, because of the workqueue
deferred dumping. I'll try to see if I can figure out something there.
In practice, it's not _such_ a big deal, as it's "only" 64 credit-bits
of entropy we're talking about. A sort of hacky but maybe a
satisfactory solution would be to hash the base_crng key into the
pool, once, just at the transition point. I'll think a bit more on it.

>
> Unrelated: this function could use some comments that explain what is going on.

Will do.

>
> > +/*
> > + * The general form here is based on a "fast key erasure RNG" from:
> > + * https://blog.cr.yp.to/20170723-random.html
> > + */
> > +static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
> > +                               u32 chacha_state[CHACHA_STATE_WORDS],
> > +                               u8 random_data[32], size_t random_data_len)
>
> Given that random_data is variable-length it should be a 'u8 *'.

I'll do that and mention the size aspect in the comment on top.

>
> Also, the above comment could use some more explanation.  I.e. what does this
> function actually *do*.  (I understand it, but a comment will really help any
> future readers...)

Will do.

>
> > + /*
> > + * This function returns a ChaCha block that you may use for generating
>
> ChaCha state, not ChaCha block.

Thanks.

>
> > + * random data. It also returns up to 32 bytes on its own of random data
> > + * that may be used.
> > +*/
> > +static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
> > +                         u8 random_data[32], size_t random_data_len)
>
> Likewise, it's weird having random_data be declared as length 32 when it's
> actually variable-length.

Will fix.

> > +     /* For the fast path, we check this unlocked first. */
> > +     if (unlikely(!crng_ready())) {
> > +             bool not_ready;
> > +
> > +             spin_lock_irqsave(&base_crng.lock, flags);
> > +             /* Now that we're locked, re-check. */
> > +             not_ready = !crng_ready();
> > +             if (not_ready)
> > +                     crng_fast_key_erasure(base_crng.key, chacha_state,
> > +                                           random_data, random_data_len);
> > +             spin_unlock_irqrestore(&base_crng.lock, flags);
> > +             if (!not_ready)
> > +                     return;
> > +     }
>
> Isn't the '!not_ready' check above backwards?  And in case case, doubly-inverted
> logic like that should be avoided.

You're right; it's all screwed up. I'll call it "ready" like it should
be and fix the logic on that last if statement. Thank you for pointing
this one out.

>
> And again, a few more comments please :-)

I'll pepper it up.

>
> >  struct batched_entropy {
> >       union {
> > -             u64 entropy_u64[CHACHA_BLOCK_SIZE / sizeof(u64)];
> > -             u32 entropy_u32[CHACHA_BLOCK_SIZE / sizeof(u32)];
> > +             u64 entropy_u64[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u64))];
> > +             u32 entropy_u32[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u32))];
> >       };
>
> The above numbers could use an explanation.

It's 32 bytes from fast key erasure + one full chacha block. I'll
leave a big comment there explaining this.

> There's also a comment at the top of the file that still claims that
> get_random_int() et al. don't implement backtracking protection.  That needs to
> be updated.

Will do. Saw this too after submitting.

Thanks again for your review!

Jason
