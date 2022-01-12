Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B9348C5AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354012AbiALONm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:13:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33680 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354001AbiALONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:13:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A60A1B81EF9;
        Wed, 12 Jan 2022 14:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FA9C36AEB;
        Wed, 12 Jan 2022 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641996802;
        bh=5JHtTD0+GU4gLjkgA+JwgQ5sOiBtIl1aQCtAZIdQblk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gkexck+fM6W35/NWJYNxq4RmrR8Z6g/EBNNVqkQpwVTXReirOgRVQTSVo9Z12mdHX
         k+c4BUTawDJV1T5KjxKI+MmaEa7G/Q9+DTXbpWHzTuEAENInaFavOU1XTrTvIjp/bu
         QSOwOhy/o68eu2MVf1VhQZAK14vi07TD4OQBAMZt1qMoGAg2Bq/exNYMwPHzT6LQlP
         Kfc847VUKlpo5gFqI9a1EjBIstVafMKOEGMhyLeXUBj8AfZek+wXhsylQ4VkBoT269
         iYG5AiuBcRw9eS3es8i6wB1IBDMuWGosamyzIP1zP6zrO6rr7TxUavsYxrCwWBfpO8
         itIFOYtHatdDA==
Received: by mail-wr1-f50.google.com with SMTP id l25so4424865wrb.13;
        Wed, 12 Jan 2022 06:13:22 -0800 (PST)
X-Gm-Message-State: AOAM533hyIbImJFDsOM+TwhqvX/fZ7yUhagh7jj5VDEg9LbiTHrAjkda
        fJhRsOhZsYiKmAWM2Fvn2hx1QWUhKsFCHxg3krU=
X-Google-Smtp-Source: ABdhPJxFpW72y0ahbskV/7mJQw6O+qadUeEgXZUNqaTKGjsy98Z5C82x7s/ZPRn5ltWrWfcZELCXMjG3fkKf24GapuY=
X-Received: by 2002:a05:6000:154c:: with SMTP id 12mr8164552wry.447.1641996800726;
 Wed, 12 Jan 2022 06:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
 <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
 <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
 <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com> <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com>
In-Reply-To: <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Jan 2022 15:13:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEgE-3Pnnak-RZAPch=ma399Ki4jrMb8j32x2AFyZZALA@mail.gmail.com>
Message-ID: <CAMj1kXEgE-3Pnnak-RZAPch=ma399Ki4jrMb8j32x2AFyZZALA@mail.gmail.com>
Subject: Re: [PATCH v2] lib/crypto: add prompts back to crypto libraries
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jmforbes@linuxtx.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 15:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Jan 12, 2022 at 3:08 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 12 Jan 2022 at 15:08, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > On Wed, Jan 12, 2022 at 3:06 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 12 Jan 2022 at 15:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > >
> > > > > This commit also needs this snippet:
> > > > >
> > > >
> > > > Why?
> > >
> > > So that the menu of crypto library options is inside of the library
> > > menu. Otherwise this will appear inside of the _root_ menu, which
> > > isn't what we want.
> >
> > Why not? I think that's fine.
>
> It's really not appropriate there. Look:
>
> - Justin vanilla: https://i.imgur.com/14UBpML.png
> - Justin + Jason: https://i.imgur.com/lDfZnma.png
>
> We really don't want another top level menu. We're not that important.
> Rather, crypto libraries are but one ordinary subset of ordinary
> libraries, just like how the build system does it too.

I disagree. The root menu is a jumble of things already, and having
this one at the root is really not a problem.
