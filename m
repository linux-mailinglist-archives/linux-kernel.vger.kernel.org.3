Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4964D5352
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245572AbiCJVAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbiCJVA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:00:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4FEDBD28;
        Thu, 10 Mar 2022 12:59:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FC7BB82849;
        Thu, 10 Mar 2022 20:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87145C340E8;
        Thu, 10 Mar 2022 20:59:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ME2n1YTL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646945958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ftjEjnH/rbsDeyFCjGVbhkWso1sbRUDgVGsJ454ha4=;
        b=ME2n1YTLI1bjpJA3U9PsygwL2CYiWoB3BQ2ERoyg6APueWHj2gUBEcML3CGeE//KWas3hi
        3jEEbISTG7AchhdPtPS5I/TiIOpfTsmHZfRyeRsJhmj7uYgPgS8x6vopOS+AsyrC0yudqK
        zxfauqOQfPeASZl8ycSJDKJUT6mCZ4E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 09fcd7fd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Mar 2022 20:59:18 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2dc28791ecbso72596157b3.4;
        Thu, 10 Mar 2022 12:59:17 -0800 (PST)
X-Gm-Message-State: AOAM5300vOhWmMe9IdxXQBizfIleaZHVw2tt6zu2CzZQeNkBNzwWByvm
        r6KCVodXSDPlULc6NpTg/zndRGsJ/ru7EwkTj54=
X-Google-Smtp-Source: ABdhPJw66GRc0k7x4PF+JjD6fyFCOyICz/HdgthgklVUv0i5hNJJrN1nqT5VBWrbVNOehwtXSZxd43NAzcsVcZrHx/I=
X-Received: by 2002:a81:10c5:0:b0:2dc:4b7:d487 with SMTP id
 188-20020a8110c5000000b002dc04b7d487mr5640201ywq.396.1646945956540; Thu, 10
 Mar 2022 12:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20220309152653.1244096-1-Jason@zx2c4.com> <20220309191850.1508953-1-Jason@zx2c4.com>
 <YimFHeXgw9jfevWq@sol.localdomain>
In-Reply-To: <YimFHeXgw9jfevWq@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Mar 2022 13:59:05 -0700
X-Gmail-Original-Message-ID: <CAHmME9ohyKKX4Qg_dyGq36MxFkhBoVQYYgs8uUoCfBkJNqfX7Q@mail.gmail.com>
Message-ID: <CAHmME9ohyKKX4Qg_dyGq36MxFkhBoVQYYgs8uUoCfBkJNqfX7Q@mail.gmail.com>
Subject: Re: [PATCH v2] random: reseed more often immediately after booting
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

On Wed, Mar 9, 2022 at 9:57 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > not more than once per 5 minutes.
>
> Break up the above into multiple paragraphs?

Will do.

>
> > +/*
> > + * Return whether the crng seed is considered to be sufficiently
> > + * old that a reseeding might be attempted. This is the case 5,
> > + * 10, 20, 40, 80, and 160 seconds after boot, and after if the
> > + * last reseeding was CRNG_RESEED_INTERVAL ago.
> > + */
> > +static bool crng_has_old_seed(void)
> > +{
> > +     static unsigned int next_init_secs = 5;
> > +
> > +     if (unlikely(next_init_secs < CRNG_RESEED_INTERVAL / HZ)) {
>
> The read of 'next_init_secs' needs READ_ONCE(), since it can be written to
> concurrently.

Thanks, will fix.

> However, one thing that seems a bit odd is that this method can result in two
> reseeds with very little time in between.  For example, if no one is using the
> RNG from second 40-78, but then it is used in seconds 79-80, then it will be
> reseeded at both seconds 79 and 80 if there is entropy available.

I've been sort of going back and forth on this. I think the idea is
that there are two relative time measurements. The ordinary one we use
is time since last reseeding. But at boot, we're trying to account for
the fact that entropy is coming in relative to the init process of the
system, which means we need it to be relative to boot time rather than
relative to the last reseeding. As you point out, this is a little
wonky with how things are now, because we only ever reseed on usage.
To get closer to what I have in mind, we could reseed in a timer, so
that it hits it exactly on the 5,10,20,40,etc dot. But that seems a
bit cumbersome and maybe unnecessary. The effect of the behavior of
this v1 you pointed out is:

- We might reseed at 79, and then fail to reseed at 80. Consequence:
we lose 1 second of entropy that could have made it for that try.
- We might reseed at 79, and then also reseed at 80 too. Consequence:
that's a fairly quick refresh, but on the other hand, we're still
requiring 256 bit credits, so maybe not so bad, and if we've got so
much entropy coming in during that small period of time, maybe it
really isn't a concern.

So I'm not sure either of these cases really matter that much.

> Perhaps the condition should still be:
>
>         time_after(jiffies, READ_ONCE(base_crng.birth) + interval);
>
> ... as it is in the non-early case, but where 'interval' is a function of
> 'uptime' rather than always CRNG_RESEED_INTERVAL?  Maybe something like:
>
>         interval = CRNG_RESEED_INTERVAL;
>         if (uptime < 2 * CRNG_RESEED_INTERVAL / HZ)
>                 interval = max(5, uptime / 2) * HZ;

I'd experimented with things like that, for example making it exponential:

  static bool early_boot = true;
  unsigned long interval = CRNG_RESEED_INTERVAL;

  if (unlikely(READ_ONCE(early_boot))) {
    unsigned int uptime = min_t(u64, INT_MAX, ktime_get_seconds());
    if (uptime >= CRNG_RESEED_INTERVAL / HZ)
      WRITE_ONCE(early_boot, false);
    else
      interval = (5U << fls(uptime / 5)) * HZ;
  }
  return time_after(jiffies, READ_ONCE(base_crng.birth) + interval);

But the whole thing of combining relative-to-last-reseed with
relative-to-boottime seems really strange. I'm not quite sure what
that's supposed to represent, whereas what I have in v1 is
"exponentially increasing intervals from boottime" which is fairly
easy to understand.

Jason
