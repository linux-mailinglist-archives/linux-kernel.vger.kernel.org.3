Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69FC49CF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiAZQGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:06:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41918 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbiAZQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:06:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB9DB6198D;
        Wed, 26 Jan 2022 16:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78E3C340E3;
        Wed, 26 Jan 2022 16:06:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qcfx9C2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643213175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jmse18xcLhz3SCOMgvJU4F5qqQvTw8luGTUoUmHjGcI=;
        b=Qcfx9C2MeBbs1ALfSZQWchlnLgN6+0V9o36Go9hB0hud3LSBkld3SdIkpP0qPtvqs5AKct
        CIClV1Fn7z1mTapfL6fm2oG+3obgPNfyUbQNty+7Epzf/qdh05yvO1+GBMwVfCrb5J8oUD
        nRDWF8JfAL64kJSBV3LlBrbzb6GAZFQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e5af9bf0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 26 Jan 2022 16:06:14 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id p5so101060ybd.13;
        Wed, 26 Jan 2022 08:06:14 -0800 (PST)
X-Gm-Message-State: AOAM532pPOIt0dxVu1zq7iJ4DZm1AAaAdceC8c2CnNVOgmq1HPmGtGcT
        b2s5TSccoZ/q5VB6LYCyolVuYw4h6D/vB05zu4g=
X-Google-Smtp-Source: ABdhPJxz/i/g3wR2x3AgUNVGqW0cVEBKEphs3Qy+Orkeeuhs9ANKTPTnbVTPetntoMwMkGruzFyXWdKY5sO99mNs/Pc=
X-Received: by 2002:a25:244b:: with SMTP id k72mr39212179ybk.638.1643213174162;
 Wed, 26 Jan 2022 08:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20220125201457.77292-1-linux@dominikbrodowski.net>
In-Reply-To: <20220125201457.77292-1-linux@dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Jan 2022 17:06:02 +0100
X-Gmail-Original-Message-ID: <CAHmME9r9G5p+E3-kG5eKvr-DYNSkS7E9PNCsjQFNFSuH_FRnWQ@mail.gmail.com>
Message-ID: <CAHmME9r9G5p+E3-kG5eKvr-DYNSkS7E9PNCsjQFNFSuH_FRnWQ@mail.gmail.com>
Subject: Re: [PATCH] random: continually use hwgenerator randomness
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

On Tue, Jan 25, 2022 at 9:19 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> The rngd kernel thread may sleep indefinitely if the entropy count is
> kept above random_write_wakeup_bits by other entropy sources. To make
> best use of multiple sources of randomness, mix entropy from hardware
> RNGs into the pool at least once within CRNG_RESEED_INTERVAL.

Thanks for this patch. It exposes the result of an interesting set of
changes that have occurred over time.

When does POOL_ENTROPY_BITS() decrease? There are two direct mutators:

- Calls to account(> 0, ..)
- RNDCLEARPOOL/RNDZAPENTCNT (though this fails to do the
wake_up_interruptible/kill_fasync dance that account() does. bug?)

The latter is a userspace decision. The former has one callsite:
extract_entropy(.., > 0, ..).

The underscore-less extract_entropy function in turn has one caller:
crng_reseed(.., true). This in turn gets called from three places:

- From credit_entropy_bits, once, when the entropy pool initializes
for the first time.
- From extract_crng after 5 minutes or after crng_global_init_time is set.
- From RNDRESEEDCRNG (which is also the only non-init mutator of
crng_global_init_time).

The first is an init time thing, so not really relevant. The middle is
already at our 5 minute interval. And the last is a userspace
decision.

Therefore, with the code as it currently exists, if there are no calls
to the ioctls, that wait will unblock a minimum of every 5 minutes
times random_write_wakeup_bits / 256 rounded up, and assuming a low no
new entropy from interrupts or elsewhere (unlikely), so in the best
case, that seems like 20 minutes? And if you want to make it happen
more than every 20 minutes, you must call call RNDCLEARPOOL followed
by a RNDRESEEDCRNG (due to the maybe-bug I mentioned earlier), or call
RNDRESEEDCRNG a bunch in a loop from userspace.

That certainly seems pretty weird and not nearly as automatic as it
ought to be. Even though we don't _need_ more hw-backed entropy once
the RNG is up, I don't see it as a bad thing to periodically stir some
in. In fact, it's probably a reasonable thing to do.

I mentioned at the beginning that this is an interesting thing
resulting from changes over time. Specifically, the reason we're in
this situation is because /dev/random no longer debits from the
entropy pool (aside from the 5 minute interval calls to
extract_entropy). And thank goodness for that. But some of the
assumptions made in that era of random.c might be a little out of date
now.

So on first analysis of this, I think your patch is correct and I'll
apply it. However, I'd like to wait a little bit to give others a
chance to chime in, particularly those who maintain the actual
hw-random driver (which is separate from random.c) and might have a
better picture of potential hardware constraints or something along
those lines.

Regards,
Jason
