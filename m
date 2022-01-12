Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC948C656
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354234AbiALOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbiALOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:44:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4FC06173F;
        Wed, 12 Jan 2022 06:44:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 486E6B81F1A;
        Wed, 12 Jan 2022 14:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6CCC36AEB;
        Wed, 12 Jan 2022 14:44:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GkaMMKTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641998677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXV/axjwX5FUovf02ypwHqsrpqjCvYH1CxskvWmTeNQ=;
        b=GkaMMKTMPWBCYwW7Tn9myvspr/g9Frxmtuumqgq85W6TRteXdG7WjFtAObxz5GY2oJq+tL
        hWgQ9VNUaOx38l95jijpKIhc+i/x41elM4S77G8+x/ry35SptQ+tlU179KoFQcJExzkLhU
        dVFlvx+WqT3GU/gVz3Yg0siPtqjgYBA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4fbe9360 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 14:44:37 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id h14so6941189ybe.12;
        Wed, 12 Jan 2022 06:44:36 -0800 (PST)
X-Gm-Message-State: AOAM532lO6Q8tEHtIfQeuVcPtTbooYyMPGl87071oZtQwM7gXZ5zRMmX
        c0hMCYjrwolWcE4AuzVVd/oJTc6JD5GpAUYrMNY=
X-Google-Smtp-Source: ABdhPJywVIrLkb4/m1TSdxctzhJhqAd4fykL3p9P7V0t7ryMwoWNbSTC1FNZYgyl4UT2kyVvLBpPJWH3YF0gOQsPvN8=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr14483ybe.32.1641998675780;
 Wed, 12 Jan 2022 06:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
 <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
 <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
 <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
 <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com>
 <CAMj1kXEgE-3Pnnak-RZAPch=ma399Ki4jrMb8j32x2AFyZZALA@mail.gmail.com>
 <CAHmME9oTsOZCJoPUT=LwUuwWHbAa_N1MRoGjTYY5Poj4tr0+Zg@mail.gmail.com> <CAMj1kXFSN0yJzmgDKp1bmF7wgaAwJba+FteStJEKH7HDBSP5kQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFSN0yJzmgDKp1bmF7wgaAwJba+FteStJEKH7HDBSP5kQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jan 2022 15:44:24 +0100
X-Gmail-Original-Message-ID: <CAHmME9qcjHq6M+sOOxCT4xte5AcZRoHjcMQfod3Zc1=FJsq8BQ@mail.gmail.com>
Message-ID: <CAHmME9qcjHq6M+sOOxCT4xte5AcZRoHjcMQfod3Zc1=FJsq8BQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/crypto: add prompts back to crypto libraries
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Wed, Jan 12, 2022 at 3:42 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 12 Jan 2022 at 15:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Wed, Jan 12, 2022 at 3:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 12 Jan 2022 at 15:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > On Wed, Jan 12, 2022 at 3:08 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Wed, 12 Jan 2022 at 15:08, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > > >
> > > > > > On Wed, Jan 12, 2022 at 3:06 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > >
> > > > > > > On Wed, 12 Jan 2022 at 15:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > > > > >
> > > > > > > > This commit also needs this snippet:
> > > > > > > >
> > > > > > >
> > > > > > > Why?
> > > > > >
> > > > > > So that the menu of crypto library options is inside of the library
> > > > > > menu. Otherwise this will appear inside of the _root_ menu, which
> > > > > > isn't what we want.
> > > > >
> > > > > Why not? I think that's fine.
> > > >
> > > > It's really not appropriate there. Look:
> > > >
> > > > - Justin vanilla: https://i.imgur.com/14UBpML.png
> > > > - Justin + Jason: https://i.imgur.com/lDfZnma.png
> > > >
> > > > We really don't want another top level menu. We're not that important.
> > > > Rather, crypto libraries are but one ordinary subset of ordinary
> > > > libraries, just like how the build system does it too.
> > >
> > > I disagree. The root menu is a jumble of things already, and having
> > > this one at the root is really not a problem.
> >
> > Should CRC routines also go into a submenu and be put at the root?
> > What about other library functions? Library functions belong in the
> > library submenu. We don't need our own top level submenu for this. The
> > whole point of lib/crypto/ is that they're just boring library
> > functions. Libraries! So, part of the libraries menu.
>
> Shouting it doesn't make it true.

I'm not shouting. I respectfully disagree with your perspective. I
think the comparison to CRC routines is an apt one, still unaddressed.

> Nobody cares about what the root menu looks like

I certainly do.

> and given that this
> patch is presumably going to be sent as an early fix on top of your
> rng branch, it is better not to touch anything under crypto/ unless
> you are 100% certain it is not going to conflict with Herbert's tree.

Oh, I was thinking Herbert would take this since he hasn't sent a pull
yet? Otherwise, sure, I can do it.

Jason
