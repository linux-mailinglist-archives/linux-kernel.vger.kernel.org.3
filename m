Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96D748C5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354056AbiALOVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242457AbiALOVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:21:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB11C06173F;
        Wed, 12 Jan 2022 06:21:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACFFF616D7;
        Wed, 12 Jan 2022 14:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6698C36AEC;
        Wed, 12 Jan 2022 14:21:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bfLbbHNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641997261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S++CHjPnmj13xcyW+yG6vfaZJ23Y5c8pQWNSstvjWzU=;
        b=bfLbbHNqWevpKeE/A3I7hbUUMYqxqCJwkqknU7locWlkCBYeZUOabT6wCBE9yVLlMwby7v
        vOcHrPFTkYQevJoy33eURx1h/qwtz9vAWQH+BNEtogKJjMw+KBT1njVhZEJoVzKtOIj94K
        okZ8U90knigowm5TP6h6jz+QIFVBh7g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 85583dfe (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 14:21:01 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id n68so6795011ybg.6;
        Wed, 12 Jan 2022 06:21:00 -0800 (PST)
X-Gm-Message-State: AOAM530LIJxIVi5xcYP0dbq7XQm5rBUQ0LG6+jyxa13umMbmO/oo9nQd
        +SVy7XiemE74ZI7nCEFEv5ytV9Iuz1RDF7hnRyw=
X-Google-Smtp-Source: ABdhPJyn/sChzA4pBzamc6twWYxbAD8Zxg/Xv3l/iU2Xh5j8OpmRcDjqz7SgHLehX0Lulyr9zg5hdKmfh5vlFa/IbNU=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr13322228ybe.32.1641997259604;
 Wed, 12 Jan 2022 06:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
 <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
 <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
 <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
 <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com>
 <CAMj1kXEgE-3Pnnak-RZAPch=ma399Ki4jrMb8j32x2AFyZZALA@mail.gmail.com>
 <CAHmME9oTsOZCJoPUT=LwUuwWHbAa_N1MRoGjTYY5Poj4tr0+Zg@mail.gmail.com> <CAFxkdAo0MbdmNQmChuDNEJN6DMN5-_fsph8QeU4dY2CuwgRzaw@mail.gmail.com>
In-Reply-To: <CAFxkdAo0MbdmNQmChuDNEJN6DMN5-_fsph8QeU4dY2CuwgRzaw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jan 2022 15:20:48 +0100
X-Gmail-Original-Message-ID: <CAHmME9qQSWEaT++f-v5RcZXbz31TtZTa1Kt5Kee0C0a=-S+jaw@mail.gmail.com>
Message-ID: <CAHmME9qQSWEaT++f-v5RcZXbz31TtZTa1Kt5Kee0C0a=-S+jaw@mail.gmail.com>
Subject: Re: [PATCH v2] lib/crypto: add prompts back to crypto libraries
To:     Justin Forbes <jmforbes@linuxtx.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 3:19 PM Justin Forbes <jmforbes@linuxtx.org> wrote:
>
> On Wed, Jan 12, 2022 at 8:15 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
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
> Specifically in this menu, users were expecting to see it in the
> Cryptographic API menu.  I think having it in the main menu just below
> this entry is much more appropriate than being buried under another
> menu.  Particularly if the goal is to get rid of the menu again all
> together once we can audit the full set of deps on crypto libraries.

The thing is, even once we get rid of the labels, part of detangling
everything is going to involve moving the sourcing of those symbols
into lib/Kconfig anyway. No use delaying the inevitable.
