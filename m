Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972174AF011
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiBILsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBILsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:48:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C6C1038C8;
        Wed,  9 Feb 2022 02:38:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C595761205;
        Wed,  9 Feb 2022 10:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7835C340E7;
        Wed,  9 Feb 2022 10:38:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XEkhL1UG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644403091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNhEbwGWC/mqUNptZLwKJp9/NabsVn6ehupuR4igobw=;
        b=XEkhL1UGq72ur1WmpdnRBDO19CzU5Raj7BUOe0VaM5cEzVkR+rX3+29sJ1UcBFWJomzmDt
        46iNMQn8dHbNYUloPOkMIRO6gbYJ5U0vCZRtHabjxYT9RGg7zultcCrsCrt+P5XaW4djZ+
        jcaR8lH7Qrx96npddDwewN6I3P/Wz5Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 27f40851 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 10:38:11 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id j2so4769301ybu.0;
        Wed, 09 Feb 2022 02:38:10 -0800 (PST)
X-Gm-Message-State: AOAM531HapcBqo41fq31+310QwayLUE6wpnt8LQCbVKSKH8xkBBUDwaB
        5OmlpEQjv2jLo9BHXWPJ9NpX9edaQ9q2eaZ/8GE=
X-Google-Smtp-Source: ABdhPJy2e8566gu6GFhAYHthDZz8h5Fo4Ng1GEYVLUIY3j6LpLCxMYO3HruhvsCwbPw9MiM/D1e5E7OFOCO2vRnkRZU=
X-Received: by 2002:a25:5c3:: with SMTP id 186mr1486739ybf.255.1644403089696;
 Wed, 09 Feb 2022 02:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20220209011919.493762-1-Jason@zx2c4.com> <20220209011919.493762-5-Jason@zx2c4.com>
 <YgN57QP5xH9ebrH/@owl.dominikbrodowski.net>
In-Reply-To: <YgN57QP5xH9ebrH/@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Feb 2022 11:37:59 +0100
X-Gmail-Original-Message-ID: <CAHmME9p1+R1ByXAdm7aNcD0BTvhUuiDVGFaExgXyJ1qhkW266A@mail.gmail.com>
Message-ID: <CAHmME9p1+R1ByXAdm7aNcD0BTvhUuiDVGFaExgXyJ1qhkW266A@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] random: ensure early RDSEED goes through mixer on init
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Biggers <ebiggers@google.com>
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

On Wed, Feb 9, 2022 at 9:31 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Am Wed, Feb 09, 2022 at 02:19:14AM +0100 schrieb Jason A. Donenfeld:
> > Continuing the reasoning of "random: use RDSEED instead of RDRAND in
> > entropy extraction" from this series, at init time we also don't want to
> > be xoring RDSEED directly into the crng. Instead it's safer to put it
> > into our entropy collector and then re-extract it, so that it goes
> > through a hash function with preimage resistance.
>
> Any reason why you re-order
>
> > +     mix_pool_bytes(utsname(), sizeof(*(utsname())));
> >       mix_pool_bytes(&now, sizeof(now));

My "vim fingers" did that as a matter of habit. But it's actually
maybe worse this way, in a very subtle way that really doesn't really
matter. The RDSEED bytes should be hashed in first, not last, so that
we don't need to rely on the hash function's collision protection. In
general crypto hygiene, HASH(secret||thing) is sometimes preferable to
HASH(thing||secret). I'll fix that up and mention it in the commit
message. Thanks for noticing it.

>
> ? It shouldn't matter, but it's an additional change I see no rationale for.
>
> Also, AFAICS, we now only call rdseed 8 times (to mix into the input pool
> directly and to update the primary pool indirectly) instead of 8 times (for
> the input pool) and 12 times (for initializing the primary pool). That's
> still 64 bytes, and we use that to seed 48 bytes, we're still on the safe
> side. So feel free to add my

And later in this patchset, this is reduced to a 32 byte extraction
(which is the size of our pool, which is what we were aiming for).
Compressing an entire 64 byte blake block of rdseed down to 32 bytes
puts us in a very good position.

Jason
