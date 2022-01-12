Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473C648C64A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354230AbiALOmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:42:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46008 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354194AbiALOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:42:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D26B4B81F1F;
        Wed, 12 Jan 2022 14:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6962FC36AEB;
        Wed, 12 Jan 2022 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641998522;
        bh=FEYYprchIn+N4qMgcCz80rBdbVrEt3C0GdAqwsGHyTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SOxnZ0P5aR5KcwcuZ7wxxB9qePQBkBmb3zvd9uN/uO5axrSEk+lJQgBswvKHox1V9
         WQvnfys8ns6a8lwvEHUJ3rAEEtjoHw9A0IATzzB4BegoW0vk4VPXXroT4FldLwkAIT
         Wv7/fUsGNXfhREhuyu/fC7zH/eG5bCISCOqdyFYU4SNohUZKUFDNsdQoh84j9g05Ju
         n1fW12KsUHQ/Np234rO6uqdmiVezKVaDT6FV5GS7EUikgfNLn3jD8+f6QLMbKuQb3X
         qw8tMeu0DdGGnHFSlLPhnDzEEIRLDukU9b7ZmeguAjUYuilnoLXZKG45Sxj3L/N5ZR
         hQFCGBrOkspzg==
Received: by mail-wm1-f44.google.com with SMTP id c66so1755275wma.5;
        Wed, 12 Jan 2022 06:42:02 -0800 (PST)
X-Gm-Message-State: AOAM533HKjrOYD0w3Uzs3cN56YFxKjiufvuG1dPhHNpybWULLw8e2i//
        LD8dPILSAIuNZQPaB6TYa2fto9fzkBODfXVQhRc=
X-Google-Smtp-Source: ABdhPJxOzkLLpG5Q+FYKsKmeg/adDYG4FJgp4xJgd/0c2dGLrx9OqWRsc4GecW+vCwjk2e5PXb34DGs+NxIZoI+0YMs=
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr7039981wmq.25.1641998520795;
 Wed, 12 Jan 2022 06:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
 <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
 <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
 <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
 <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com>
 <CAMj1kXEgE-3Pnnak-RZAPch=ma399Ki4jrMb8j32x2AFyZZALA@mail.gmail.com> <CAHmME9oTsOZCJoPUT=LwUuwWHbAa_N1MRoGjTYY5Poj4tr0+Zg@mail.gmail.com>
In-Reply-To: <CAHmME9oTsOZCJoPUT=LwUuwWHbAa_N1MRoGjTYY5Poj4tr0+Zg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Jan 2022 15:41:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFSN0yJzmgDKp1bmF7wgaAwJba+FteStJEKH7HDBSP5kQ@mail.gmail.com>
Message-ID: <CAMj1kXFSN0yJzmgDKp1bmF7wgaAwJba+FteStJEKH7HDBSP5kQ@mail.gmail.com>
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

On Wed, 12 Jan 2022 at 15:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Jan 12, 2022 at 3:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 12 Jan 2022 at 15:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > On Wed, Jan 12, 2022 at 3:08 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 12 Jan 2022 at 15:08, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > >
> > > > > On Wed, Jan 12, 2022 at 3:06 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, 12 Jan 2022 at 15:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > > > >
> > > > > > > This commit also needs this snippet:
> > > > > > >
> > > > > >
> > > > > > Why?
> > > > >
> > > > > So that the menu of crypto library options is inside of the library
> > > > > menu. Otherwise this will appear inside of the _root_ menu, which
> > > > > isn't what we want.
> > > >
> > > > Why not? I think that's fine.
> > >
> > > It's really not appropriate there. Look:
> > >
> > > - Justin vanilla: https://i.imgur.com/14UBpML.png
> > > - Justin + Jason: https://i.imgur.com/lDfZnma.png
> > >
> > > We really don't want another top level menu. We're not that important.
> > > Rather, crypto libraries are but one ordinary subset of ordinary
> > > libraries, just like how the build system does it too.
> >
> > I disagree. The root menu is a jumble of things already, and having
> > this one at the root is really not a problem.
>
> Should CRC routines also go into a submenu and be put at the root?
> What about other library functions? Library functions belong in the
> library submenu. We don't need our own top level submenu for this. The
> whole point of lib/crypto/ is that they're just boring library
> functions. Libraries! So, part of the libraries menu.

Shouting it doesn't make it true.

Nobody cares about what the root menu looks like, and given that this
patch is presumably going to be sent as an early fix on top of your
rng branch, it is better not to touch anything under crypto/ unless
you are 100% certain it is not going to conflict with Herbert's tree.
