Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2468148C672
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354283AbiALOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:50:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49840 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbiALOuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:50:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABBF3B81F46;
        Wed, 12 Jan 2022 14:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D08C36AEF;
        Wed, 12 Jan 2022 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641999001;
        bh=IQnTEWWPj/T6G7CafhN3yxIczQw5jaOpanOpbhcfynI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=daCuMezYE1O4Z0Mu4w9f5bt8xt93rbC4AmBfk51x5I73eC6wpA9gojEotjFT/pSiu
         ZKXjJhJOoXLAXYw29UICNrDgHeDGNGNwdbnd27g/S/HRw2il/DkVdMo7sSrm9LgEtO
         0jPtqJRROZFLjnAXi6Srrq5jX4xQxji5V7uj3tJljPn/UcpoWX/ZXVnGf8iSbdtLAB
         QHcefq6eyms+bKbmraVgYy03E21oRvVi97KYuNapBx/KJsoSxaEwmCRt4RlOU1a1nJ
         t/Nrwp88QbvmcT88Aq2gt4Lu/4D2ROpqshOQATWVjiXSY65wFjZQvb5IFJW6vSqcyr
         xGPk7SzmlKyOg==
Received: by mail-wm1-f54.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so3605718wmo.5;
        Wed, 12 Jan 2022 06:50:01 -0800 (PST)
X-Gm-Message-State: AOAM533eG838W4wUVtQNvpsGBI8vB+X9/YSyY2BGqLD7FnRE2stChmXz
        cjvGTzQG8Gj26uUZ8nY+RiG/mhpZ0uL/+kaWUXI=
X-Google-Smtp-Source: ABdhPJy2OkE8s7vrbX7qNwL9Me4Gj5tUrZqLLRbHBRR6eseY6i1g35qBWExkWnVX9hxHQ0BwFmG6dL4y1VSYest3k20=
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr7068642wmq.25.1641998999585;
 Wed, 12 Jan 2022 06:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
 <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
 <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
 <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
 <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com>
 <CAMj1kXEgE-3Pnnak-RZAPch=ma399Ki4jrMb8j32x2AFyZZALA@mail.gmail.com>
 <CAHmME9oTsOZCJoPUT=LwUuwWHbAa_N1MRoGjTYY5Poj4tr0+Zg@mail.gmail.com>
 <CAMj1kXFSN0yJzmgDKp1bmF7wgaAwJba+FteStJEKH7HDBSP5kQ@mail.gmail.com> <CAHmME9qcjHq6M+sOOxCT4xte5AcZRoHjcMQfod3Zc1=FJsq8BQ@mail.gmail.com>
In-Reply-To: <CAHmME9qcjHq6M+sOOxCT4xte5AcZRoHjcMQfod3Zc1=FJsq8BQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Jan 2022 15:49:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGp8bkxc0XpAR=DJJhsRNeoJb2wtEwmdRH4eh35KHNk8Q@mail.gmail.com>
Message-ID: <CAMj1kXGp8bkxc0XpAR=DJJhsRNeoJb2wtEwmdRH4eh35KHNk8Q@mail.gmail.com>
Subject: Re: [PATCH v2] lib/crypto: add prompts back to crypto libraries
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 15:44, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Jan 12, 2022 at 3:42 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 12 Jan 2022 at 15:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > On Wed, Jan 12, 2022 at 3:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 12 Jan 2022 at 15:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > >
> > > > > On Wed, Jan 12, 2022 at 3:08 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, 12 Jan 2022 at 15:08, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jan 12, 2022 at 3:06 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, 12 Jan 2022 at 15:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > > > > > >
> > > > > > > > > This commit also needs this snippet:
> > > > > > > > >
> > > > > > > >
> > > > > > > > Why?
> > > > > > >
> > > > > > > So that the menu of crypto library options is inside of the library
> > > > > > > menu. Otherwise this will appear inside of the _root_ menu, which
> > > > > > > isn't what we want.
> > > > > >
> > > > > > Why not? I think that's fine.
> > > > >
> > > > > It's really not appropriate there. Look:
> > > > >
> > > > > - Justin vanilla: https://i.imgur.com/14UBpML.png
> > > > > - Justin + Jason: https://i.imgur.com/lDfZnma.png
> > > > >
> > > > > We really don't want another top level menu. We're not that important.
> > > > > Rather, crypto libraries are but one ordinary subset of ordinary
> > > > > libraries, just like how the build system does it too.
> > > >
> > > > I disagree. The root menu is a jumble of things already, and having
> > > > this one at the root is really not a problem.
> > >
> > > Should CRC routines also go into a submenu and be put at the root?
> > > What about other library functions? Library functions belong in the
> > > library submenu. We don't need our own top level submenu for this. The
> > > whole point of lib/crypto/ is that they're just boring library
> > > functions. Libraries! So, part of the libraries menu.
> >
> > Shouting it doesn't make it true.
>
> I'm not shouting. I respectfully disagree with your perspective. I
> think the comparison to CRC routines is an apt one, still unaddressed.
>

Sure, but none of this is relevant for the short term fix that we need
to get in asap. There are lots of future changes we can philosophize
about, but those discussions should take place on the linux-crypto
list after the merge window closes.

> > Nobody cares about what the root menu looks like
>
> I certainly do.
>

Fair enough. But on many architectures, it looks absolutely horrid,
and I rarely see fixes sent for it.

> > and given that this
> > patch is presumably going to be sent as an early fix on top of your
> > rng branch, it is better not to touch anything under crypto/ unless
> > you are 100% certain it is not going to conflict with Herbert's tree.
>
> Oh, I was thinking Herbert would take this since he hasn't sent a pull
> yet? Otherwise, sure, I can do it.
>

How could he? This patch does not apply to his cryptodev tree, which
won't receive backmerges from mainline until the next cycle.
