Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F80652727A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiENPI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiENPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:08:50 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A117DD124
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 08:08:48 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so14088601fac.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 08:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3l4q2q02VvUiyAjWSh2iv5jBAb8f6QMvDpQ/onPSsnU=;
        b=PXfnYa+abyHmqJE3TFUogDVjB2jLEDTim/Kthdx8ODhyvA7XJLnO0SNplHy15zJO91
         VNjeUpM4qUFjXv6KtpsCx5pxwwFvJRJ1M3iru1/vCw8xKm2BD3Gm6Rl39Khy2VuvYGVX
         /V07tYguL4neaxmA84FnH+Olh4XezOYoo6C5Td62gcylqo2gBEKzm9PztiwB4BOJ2Zac
         yWSfs2vTNtyQZCGCcJd5lSlxFf6h1T9R90ZqnkGn2B8NBdBQQiSnNz14P2ROi220Pg/2
         Oale1lFhtlvQsy6C/mQDHcCr7ViMMvzMfhYku5wvEqmxQSzYX6n9j8YRIYIT+RKLzsOg
         9eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3l4q2q02VvUiyAjWSh2iv5jBAb8f6QMvDpQ/onPSsnU=;
        b=smjrW/dvoe76OmQ11V4LZ7ifAMR3xd16UO9+5zIpYgUz6akEp1ceUYh84auziVsi2N
         dO/tEDLbegYvs3KGXbf1iPSaCIBM8ujgGziSJIheNi2+biGGmDdh57PD1yWkgy9nnE9E
         8Pb805WfSHIVDRCYn6eBGvfY0ggw4b4grJ8dIIjKnfiE10yQXjc8DZPnHYZ6uW6yGYJy
         cqyeJUWAM7aZSvcTRuT6ODxapfq1eYDP4J1t9OYcJTQu4YH5iRN38DxxZQ0xV8dYGBnb
         sWRB5ZqsjgUqg7vmedcSfxdeZfiSr4FGMc2gLBk1D5Vm4vzo7ClkLqrsVgqfXkZSRQ3V
         ++HA==
X-Gm-Message-State: AOAM531PKe08J1uQbUCGoc7BKtCsZOwRnO4/7Krf2O60oxtaqf48GPwo
        9c8QzLIlDgbWY3oUDQubl4YzgQ==
X-Google-Smtp-Source: ABdhPJxU2F4bNg0zTUf/eRy2luv29t06NdR4DaYsjCysmW25BJOFupL4oYF61wqNtJtvWyO5d+2WOA==
X-Received: by 2002:a05:6870:8315:b0:e9:c1a:a1e0 with SMTP id p21-20020a056870831500b000e90c1aa1e0mr5012381oae.153.1652540927884;
        Sat, 14 May 2022 08:08:47 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b7-20020acab207000000b0032647f4e437sm2124356oif.45.2022.05.14.08.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 08:08:47 -0700 (PDT)
Date:   Sat, 14 May 2022 11:08:45 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        schnelle@linux.ibm.com, David Laight <David.Laight@aculab.com>,
        macro@orcam.me.uk, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/8] Utilize iomap interface for PC104 and friends
Message-ID: <Yn/F/Vkw71SkwvUf@fedora>
References: <cover.1652201921.git.william.gray@linaro.org>
 <CAMRc=McAe28ZwcGknzrju-PQTEZ7x2XAfoRyfLFMWpgGB8DVLw@mail.gmail.com>
 <20220514151859.692928dc@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cTS5poGdsNBi/7Lv"
Content-Disposition: inline
In-Reply-To: <20220514151859.692928dc@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cTS5poGdsNBi/7Lv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 14, 2022 at 03:18:59PM +0100, Jonathan Cameron wrote:
> On Sat, 14 May 2022 14:57:49 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>=20
> > On Tue, May 10, 2022 at 7:31 PM William Breathitt Gray
> > <william.gray@linaro.org> wrote:
> > >
> > > PC104 cards and similar devices do not need to access I/O ports direc=
tly
> > > via inb()/outb() and can instead use the more typical I/O memory
> > > ioread8()/iowrite8() accessor calls by first calling ioport_map(). Th=
is
> > > patchset converts the relevant PC104/ISA card drivers to do such. With
> > > these drivers now utilizing I/O memory accessor calls, work can be do=
ne
> > > to consolidate some similar devices (e.g. 104-idio-16, pci-idio-16,
> > > etc.) into a unified driver in a future patchset.
> > >
> > > This patchset spawned from a suggestion made in another thread titled
> > > "gpio: add HAS_IOPORT dependencies":
> > > https://lore.kernel.org/all/c3a3cdd99d4645e2bbbe082808cbb2a5@AcuMS.ac=
ulab.com/
> > >
> > > William Breathitt Gray (8):
> > >   counter: 104-quad-8: Utilize iomap interface
> > >   gpio: 104-dio-48e: Utilize iomap interface
> > >   gpio: 104-idi-48: Utilize iomap interface
> > >   gpio: 104-idio-16: Utilize iomap interface
> > >   gpio: gpio-mm: Utilize iomap interface
> > >   gpio: ws16c48: Utilize iomap interface
> > >   iio: adc: stx104: Utilize iomap interface
> > >   iio: dac: cio-dac: Utilize iomap interface
> > >
> > >  drivers/counter/104-quad-8.c    | 169 +++++++++++++++++-------------=
--
> > >  drivers/gpio/gpio-104-dio-48e.c |  63 ++++++------
> > >  drivers/gpio/gpio-104-idi-48.c  |  27 ++---
> > >  drivers/gpio/gpio-104-idio-16.c |  33 ++++---
> > >  drivers/gpio/gpio-gpio-mm.c     |  43 ++++----
> > >  drivers/gpio/gpio-ws16c48.c     |  65 ++++++------
> > >  drivers/iio/adc/stx104.c        |  56 ++++++-----
> > >  drivers/iio/dac/cio-dac.c       |  14 +--
> > >  8 files changed, 248 insertions(+), 222 deletions(-)
> > >
> > >
> > > base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
> > > --
> > > 2.35.3
> > > =20
> >=20
> > I don't see any dependencies so applied the GPIO part.
> Likewise, I've applied the IIO ones. Initially pushed out as testing
> to see if 0-day finds any issues. Given timing, we may well be looking
> at next merge window now though.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Bart

Thanks, I'll pick up the remaining Counter patch in my tree. I'm going
to leave it in the tree as well until the next merge window to give some
time for others to test before it's released.

William Breathitt Gray

--cTS5poGdsNBi/7Lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYn/F/QAKCRC1SFbKvhIj
K+hIAQDX/KBCR35eXzjWw9+4KmBr0YvXcb3ffifoWo9QIQSRdAD/YoGZmxFxqXn0
gszENmpOSWkKXhea1XtUA1w/z4vFMw8=
=C6UG
-----END PGP SIGNATURE-----

--cTS5poGdsNBi/7Lv--
