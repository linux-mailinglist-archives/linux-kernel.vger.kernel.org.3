Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A91F48C5A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353956AbiALOIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:08:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45092 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353925AbiALOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:08:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A146136C;
        Wed, 12 Jan 2022 14:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BB2C36AE5;
        Wed, 12 Jan 2022 14:08:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ofmv0Gl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641996487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1SBAQbIS+MkEhG/Zk8+PAlOkBpmNXZZczD/OOiYK3Q=;
        b=ofmv0Gl8BJEEY8jkVfszB1NXdvS569UODqNm/5KssnkRypTkb8hIe+s1KogKj6zug4G7w7
        BEbpTmG/53coSqKfxZSGK+DDq5sTtqGUPQz+q824AY+tszuvZn2j6uakUKMSWdhvWAzUv0
        casbD9C5DZuWSuTWWhbL5WGJ3AX6Da8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 296927be (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 14:08:07 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id g81so6629675ybg.10;
        Wed, 12 Jan 2022 06:08:06 -0800 (PST)
X-Gm-Message-State: AOAM5326yPksHYuU+rygAKGATgOz976RUlkZlpm10czSB9f6fpJ+ZLQH
        r5PbmKHxsS25U1vc0lTs7V7xAEQ+gg2k6+s0CZc=
X-Google-Smtp-Source: ABdhPJw0DTh1gnxGW2hunILj23hYJidWEZYiGn+LeKetQoiOWBNcWcQz/+IzZMh93JVZ3BY1ivAFfw1jWvi3nCbitpU=
X-Received: by 2002:a25:8c4:: with SMTP id 187mr12312578ybi.245.1641996485764;
 Wed, 12 Jan 2022 06:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com> <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jan 2022 15:07:55 +0100
X-Gmail-Original-Message-ID: <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
Message-ID: <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
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

On Wed, Jan 12, 2022 at 3:06 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 12 Jan 2022 at 15:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > This commit also needs this snippet:
> >
>
> Why?

So that the menu of crypto library options is inside of the library
menu. Otherwise this will appear inside of the _root_ menu, which
isn't what we want.
