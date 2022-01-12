Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2AC48C68D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354345AbiALOxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiALOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:53:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F74C06173F;
        Wed, 12 Jan 2022 06:53:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9B45618D6;
        Wed, 12 Jan 2022 14:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21DFC36AE5;
        Wed, 12 Jan 2022 14:53:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DnJhczWU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641999220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OvxDuX4+u+Vf1kkrJDUSgv4TPdU3VRNAUcdKXCwTT5c=;
        b=DnJhczWUUvD9OTeps1orXgX12AsBGp8v848iAIhv/ZzalybRxXv6B+W0wFW1EvIgePDNd5
        5BFnz3pj0i7cmnVA5+7UVWIR4xX5E+ZaRghwy95P6vsOX/GiJjrV8wcSWThUm5LkEcga/3
        KA8n/vlCNHW0k1FN13d0g11tFVP9uA0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7ed3ec98 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 14:53:39 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id p187so7236263ybc.0;
        Wed, 12 Jan 2022 06:53:39 -0800 (PST)
X-Gm-Message-State: AOAM530cwaiY/Rbwpt1gU6ucBwwoq3ocSJthWHQg+t5VUXMcHKC3NbcJ
        fn5DfLy0z28eXBLPJAigsyOauF839wpQ0U+JXmE=
X-Google-Smtp-Source: ABdhPJwAh0eq22/F6YHBPJWD2phZRQHNCdVF9y2Jwg0IP/3UBPQfmh3lcD/TeR7RGNFppvZBiNntC9otajWWGkEMDrY=
X-Received: by 2002:a25:854f:: with SMTP id f15mr3731ybn.121.1641999218396;
 Wed, 12 Jan 2022 06:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
 <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
 <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
 <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
 <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com>
 <CAMj1kXEgE-3Pnnak-RZAPch=ma399Ki4jrMb8j32x2AFyZZALA@mail.gmail.com>
 <CAHmME9oTsOZCJoPUT=LwUuwWHbAa_N1MRoGjTYY5Poj4tr0+Zg@mail.gmail.com>
 <CAMj1kXFSN0yJzmgDKp1bmF7wgaAwJba+FteStJEKH7HDBSP5kQ@mail.gmail.com>
 <CAHmME9qcjHq6M+sOOxCT4xte5AcZRoHjcMQfod3Zc1=FJsq8BQ@mail.gmail.com> <CAMj1kXGp8bkxc0XpAR=DJJhsRNeoJb2wtEwmdRH4eh35KHNk8Q@mail.gmail.com>
In-Reply-To: <CAMj1kXGp8bkxc0XpAR=DJJhsRNeoJb2wtEwmdRH4eh35KHNk8Q@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jan 2022 15:53:27 +0100
X-Gmail-Original-Message-ID: <CAHmME9oxy-P8hq=85hOGSOena3kxpTAOHoXto7s4tnDUkXvYPg@mail.gmail.com>
Message-ID: <CAHmME9oxy-P8hq=85hOGSOena3kxpTAOHoXto7s4tnDUkXvYPg@mail.gmail.com>
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

On Wed, Jan 12, 2022 at 3:50 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Sure, but none of this is relevant for the short term fix that we need
> to get in asap. There are lots of future changes we can philosophize
> about, but those discussions should take place on the linux-crypto
> list after the merge window closes.

I think of adding things to the root menu as a regression. I'd like to
avoid an additional regression in fixing this.

> > > and given that this
> > > patch is presumably going to be sent as an early fix on top of your
> > > rng branch, it is better not to touch anything under crypto/ unless
> > > you are 100% certain it is not going to conflict with Herbert's tree.
> >
> > Oh, I was thinking Herbert would take this since he hasn't sent a pull
> > yet? Otherwise, sure, I can do it.
> >
>
> How could he? This patch does not apply to his cryptodev tree, which
> won't receive backmerges from mainline until the next cycle.

Oh, okay then. I'll take it. In which case, I really don't want to be
the one responsible for mucking up the root menu with something nobody
cares about (crypto library submenu). I'll fix up the menu location
thing locally then and send a v3 here.

Jason
