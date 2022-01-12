Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AE948C5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbiALOIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:08:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45396 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243264AbiALOIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:08:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9056F61373;
        Wed, 12 Jan 2022 14:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03330C36AEB;
        Wed, 12 Jan 2022 14:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641996532;
        bh=L59hnBLTd7Qc8iduqTG/Xrpv6X8OxinHTwzxZHDWqsE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NzFJQhLVMt3K+c4F2yHGdWR7Mvp9zkKJ2SPZL2kBLxzRF78nzqp9mpNWJbWP2ZoG7
         ye6mF6vJ4jUl72DWQccE0Es/INJmChAyb2psQvcGb4Wilpg0vI9ouoCW7mbklmwpbe
         LKjywulHVhjLmogx2TJ00nen2OspEuKhMKUBvXvrU2cLT+d7+iq1chYC4C3cmd+FW3
         5iQY8ajigwUmKBGFYE1futJqjT2ZN43Puiil9rV2pltlHAJMVlANO9nJ3c859pWtN1
         N9r0qQAXGzi4DEuVVA0Pm8OmLKYABX1/q3ReL762uIgPjY4S29Bg8yIaYSnUurhZIm
         BP2mMbQyc2BlA==
Received: by mail-wr1-f45.google.com with SMTP id x4so4451532wru.7;
        Wed, 12 Jan 2022 06:08:51 -0800 (PST)
X-Gm-Message-State: AOAM531CMegE8W2E13Rs86b6c5ObSC43RjPxfp34fRVJF433pHVu5YGM
        ND6M9ldsku3gv/JKPu+sYUqFDDe+oaQfhKOptPE=
X-Google-Smtp-Source: ABdhPJxdEagc78d8cgyI9JjotY9ppyN1y1Y8HlchZtsV3ldBsvdzxM0qF8hX3TUCJ/xYyj+8kC5ebxqvd7NGDtHetVU=
X-Received: by 2002:a5d:4087:: with SMTP id o7mr8255665wrp.189.1641996530412;
 Wed, 12 Jan 2022 06:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
 <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com> <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
In-Reply-To: <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Jan 2022 15:08:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
Message-ID: <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
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

On Wed, 12 Jan 2022 at 15:08, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Jan 12, 2022 at 3:06 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 12 Jan 2022 at 15:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > This commit also needs this snippet:
> > >
> >
> > Why?
>
> So that the menu of crypto library options is inside of the library
> menu. Otherwise this will appear inside of the _root_ menu, which
> isn't what we want.

Why not? I think that's fine.
