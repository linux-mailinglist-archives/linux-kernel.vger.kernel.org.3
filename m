Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090D148C5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiALOPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:15:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48160 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354039AbiALOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:15:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 744B4615A3;
        Wed, 12 Jan 2022 14:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E64C36B01;
        Wed, 12 Jan 2022 14:15:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k/fuybhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641996897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q0bG03tyBiW+TFtys/zYaZD8KtKEQEo+RRgWwpyCios=;
        b=k/fuybhK99zjwRcCn6Jq1ZGyKdmRD9QiyrcE4qDzQbSx1K2//VT4GsAz/lFF57ubfryesb
        s3zFQCTbxxNEVrhtiFjiQWv+hlXuJxwRlyHTJUSvjOMxw+rUizRCBHBb/+CCu6/s3j+B1N
        l8PDjDkOITbYvvP0W2XHGWa/MbP2LNo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f36a452d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 14:14:57 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id d7so6747496ybo.5;
        Wed, 12 Jan 2022 06:14:57 -0800 (PST)
X-Gm-Message-State: AOAM531WFOULZKue4ZV61OCYWgoGLeVouJmWPmbx1oNdoYr6Z/8j5/VN
        KfFw8e1bjr20XWDHgdV3soKovUfh64CE7KX1I7M=
X-Google-Smtp-Source: ABdhPJxWEk/fjWwRjUrzUZ/0PUBN7H4kioCkdryNaHm58QCv9stZMl0MeZMtfhzENU/cQxohaQZyBINgvceqWHuYB0w=
X-Received: by 2002:a25:a0c4:: with SMTP id i4mr13145078ybm.457.1641996896142;
 Wed, 12 Jan 2022 06:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
 <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
 <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
 <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
 <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com> <CAMj1kXEgE-3Pnnak-RZAPch=ma399Ki4jrMb8j32x2AFyZZALA@mail.gmail.com>
In-Reply-To: <CAMj1kXEgE-3Pnnak-RZAPch=ma399Ki4jrMb8j32x2AFyZZALA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jan 2022 15:14:45 +0100
X-Gmail-Original-Message-ID: <CAHmME9oTsOZCJoPUT=LwUuwWHbAa_N1MRoGjTYY5Poj4tr0+Zg@mail.gmail.com>
Message-ID: <CAHmME9oTsOZCJoPUT=LwUuwWHbAa_N1MRoGjTYY5Poj4tr0+Zg@mail.gmail.com>
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

On Wed, Jan 12, 2022 at 3:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 12 Jan 2022 at 15:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Wed, Jan 12, 2022 at 3:08 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 12 Jan 2022 at 15:08, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > On Wed, Jan 12, 2022 at 3:06 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Wed, 12 Jan 2022 at 15:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > > >
> > > > > > This commit also needs this snippet:
> > > > > >
> > > > >
> > > > > Why?
> > > >
> > > > So that the menu of crypto library options is inside of the library
> > > > menu. Otherwise this will appear inside of the _root_ menu, which
> > > > isn't what we want.
> > >
> > > Why not? I think that's fine.
> >
> > It's really not appropriate there. Look:
> >
> > - Justin vanilla: https://i.imgur.com/14UBpML.png
> > - Justin + Jason: https://i.imgur.com/lDfZnma.png
> >
> > We really don't want another top level menu. We're not that important.
> > Rather, crypto libraries are but one ordinary subset of ordinary
> > libraries, just like how the build system does it too.
>
> I disagree. The root menu is a jumble of things already, and having
> this one at the root is really not a problem.

Should CRC routines also go into a submenu and be put at the root?
What about other library functions? Library functions belong in the
library submenu. We don't need our own top level submenu for this. The
whole point of lib/crypto/ is that they're just boring library
functions. Libraries! So, part of the libraries menu.
