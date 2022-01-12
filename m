Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7484248C5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353978AbiALOMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:12:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46762 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240903AbiALOMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:12:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 248FA61418;
        Wed, 12 Jan 2022 14:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EEFC36AE5;
        Wed, 12 Jan 2022 14:12:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kGJCcfNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641996724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5iEXEf8PyUCfT9M9lR8Qsk1uwGUNeD6KQ5WGKb7/cNY=;
        b=kGJCcfNQdjDljSe3ukspkq2R3TMPrznYPXA11zUhh7kvdKMTTV2AIOlRVxJwDP0fWaJr/t
        oEBzMxZ5GOjDAGREI+A4xvS1vO3hPM876sni2SYPW6We5PoI1LRP7citC5N1S2ueDBxevv
        2k50RteoI0UKmBnqadR1NJY46vqmbRM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d30c0345 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 14:12:04 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id g14so6687433ybs.8;
        Wed, 12 Jan 2022 06:12:04 -0800 (PST)
X-Gm-Message-State: AOAM532G+V/ikstmWhMgQOA0PkTHufBSUrH7BzhxaLy5qZTE0Ktcquoa
        popbnocIe6EplQAJ07bTF15Q9kE9C6hUkbJc4EM=
X-Google-Smtp-Source: ABdhPJyquyLzk2KEj+MGoCu75Hs8YOcrD/E01yS9R1ppemjl9hhyNjNW0ktlQZUDPjqgh1E4OyshssG+9CD2rJ0bpys=
X-Received: by 2002:a25:a0c4:: with SMTP id i4mr13126966ybm.457.1641996722846;
 Wed, 12 Jan 2022 06:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
 <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
 <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com> <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
In-Reply-To: <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jan 2022 15:11:52 +0100
X-Gmail-Original-Message-ID: <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com>
Message-ID: <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com>
Subject: Re: [PATCH v2] lib/crypto: add prompts back to crypto libraries
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Wed, Jan 12, 2022 at 3:08 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 12 Jan 2022 at 15:08, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Wed, Jan 12, 2022 at 3:06 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 12 Jan 2022 at 15:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > This commit also needs this snippet:
> > > >
> > >
> > > Why?
> >
> > So that the menu of crypto library options is inside of the library
> > menu. Otherwise this will appear inside of the _root_ menu, which
> > isn't what we want.
>
> Why not? I think that's fine.

It's really not appropriate there. Look:

- Justin vanilla: https://i.imgur.com/14UBpML.png
- Justin + Jason: https://i.imgur.com/lDfZnma.png

We really don't want another top level menu. We're not that important.
Rather, crypto libraries are but one ordinary subset of ordinary
libraries, just like how the build system does it too.
