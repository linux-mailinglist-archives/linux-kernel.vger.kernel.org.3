Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F1155C70E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiF0LnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbiF0LlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:41:13 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC7CE0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:35:50 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id be10so12414771oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IcWIfXiFNBAIIf3VuJJVlmluTZvQnqEwTI6tiVGeHOM=;
        b=Ub56wbC9WV2M3ddHHUM7xeZonJ7VAeF0LDiy7Z4RsU+TjJycea+AOZ05VOTl4RaS+p
         G2XeklteMZpiwaZltwcVORjxcyAlvE8Qo84HdDxwx6n3SHQMlyHOz16XpxkbjxUAyHmf
         zZLeVDYyVhR7C0AIRbMnEiSIdVeRiOoauNqrkXbvNj4KDhYHi2j+OR9+FTKXzRzN7zxA
         JSMdnVub+yQPmkQNzpLNr3pc3JVoF5gQRiyCOnVVrlBWCP1ARy/kiaKGm5NBdvqMy3N5
         S3S3a0EfrJhTZdrgEcqlITyHJ09J1ZR0nt5zlx2DiX6YTxhZ3NkVUPyH3yi24UyCUw1H
         SvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcWIfXiFNBAIIf3VuJJVlmluTZvQnqEwTI6tiVGeHOM=;
        b=Eb6kWgCPV8WzoUycZwiHs19wwL0fxgka0koF6CLx+XduC6OIb8UGYTKGQ0QFcsyplN
         SFOmWqDusDHqU713CGv1OyBeTniii8m6YrA0+xCU3EKz0nnOnpb+3kXvx3U0A38nz3If
         kDL8pquSnyO/haoPxCeCpM1RsCngsvSF9eJkcHk+rrCEj8idbRdWo2kBBPPnFyDqDmRy
         N4gYrvKP2g9xjK6yik0n8zX+69xT+UOtgUB6ftmtzpyz4TmHKKqRq3AIwcf18vWBAjp0
         daEp8ysXMaST2UjouEYb36YP/TqGb5z7mQOjx5z25nQ2hwLkYGK5yHJgSpxxf2Uxfu76
         NxhA==
X-Gm-Message-State: AJIora8erBTMii5BH7uCvYd+xAc0QI0Bk+3/P12Gk86A05fZlkriQBi3
        T2r40pC/lsA5/I3ovpVtKiXuFQGxOULcRA==
X-Google-Smtp-Source: AGRyM1t9MaBMPNc0jNqrU6OWbaNrNp/+ZUE6wvY5inuaYW54e1wCVapZxo6fkOhveZqJLD+BI9khbw==
X-Received: by 2002:a05:6808:16a7:b0:2f9:39c4:c597 with SMTP id bb39-20020a05680816a700b002f939c4c597mr7685474oib.101.1656329749912;
        Mon, 27 Jun 2022 04:35:49 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r10-20020a056808210a00b00325cda1ff8esm5157405oiw.13.2022.06.27.04.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:35:49 -0700 (PDT)
Date:   Mon, 27 Jun 2022 07:35:47 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] gpio: Implement and utilize register structures for
 ISA drivers
Message-ID: <YrmWEwlxyJzj2zmZ@fedora>
References: <cover.1654525394.git.william.gray@linaro.org>
 <CAMRc=MfoMjFV8EsDeXuHEFjOS2m7r4fW7BqETCDrcjTHVgzDbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcqNbohE9h+Wv+21"
Content-Disposition: inline
In-Reply-To: <CAMRc=MfoMjFV8EsDeXuHEFjOS2m7r4fW7BqETCDrcjTHVgzDbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcqNbohE9h+Wv+21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2022 at 04:39:41PM +0200, Bartosz Golaszewski wrote:
> On Mon, Jun 6, 2022 at 4:36 PM William Breathitt Gray
> <william.gray@linaro.org> wrote:
> >
> > The PC104/ISA drivers were updated to use I/O memory accessor calls such
> > as ioread8()/iowrite8() in a previous patch series [1]. This
> > patchset is a continuation of the effort to improve the code readability
> > and reduce magic numbers by implementing and utilizing named register
> > data structures.
> >
> > One of the benefits is that we can now observe more easily similarities
> > in devices that share similar interfaces; such as the i8255 interfaces
> > used by the 104-DIO-48E, 104-IDI-48, and GPIO-MM drivers -- as well as
> > the similar interface used by the 104-IDIO-16 and PCI-IDIO-16 drivers. I
> > hope to consolidate some of these code blocks in future patchsets.
> >
> > [1] https://lore.kernel.org/all/cover.1652201921.git.william.gray@linar=
o.org/
> >
> > William Breathitt Gray (5):
> >   gpio: 104-dio-48e: Implement and utilize register structures
> >   gpio: 104-idi-48: Implement and utilize register structures
> >   gpio: 104-idio-16: Implement and utilize register structures
> >   gpio: gpio-mm: Implement and utilize register structures
> >   gpio: ws16c48: Implement and utilize register structures
> >
> >  drivers/gpio/gpio-104-dio-48e.c | 157 +++++++++++++++++++++-----------
> >  drivers/gpio/gpio-104-idi-48.c  | 128 +++++++++++++-------------
> >  drivers/gpio/gpio-104-idio-16.c |  58 ++++++++----
> >  drivers/gpio/gpio-gpio-mm.c     | 116 ++++++++++++++---------
> >  drivers/gpio/gpio-ws16c48.c     | 119 +++++++++++++++++-------
> >  5 files changed, 366 insertions(+), 212 deletions(-)
> >
> >
> > base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> > --
> > 2.36.1
> >
>=20
> Hi William,
>=20
> Unlike the previous patches which were relatively simple, these seem
> like there's a lot of space for breakage (even though they're
> attempting to do a good thing). Have you tested the code on real
> hardware?
>=20
> Bart

I have a tester testing the changes for to the 104-IDIO-16 and GPIO-MM
GPIO drivers on real hardware. I don't have access to the other three
devices so I've only compile tested and loaded them in a VM to verify;
I'll send out a request to ACCESIO and WinSystems to see if they have
engineers willing to test these changes for their respective devices.

I've also refactored the code in this patch series to simplify the
changes in these patches. It should make the changes much easier to
review so I'll release it in a v2 submission once the series is ready.

William Breathitt Gray

--qcqNbohE9h+Wv+21
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYrmWEwAKCRC1SFbKvhIj
K571AP9BVDOeWF1ppEOM7vd/GiJ31qRTdxMzoLs15UZZ0AixOwD/bJ8wxcF6ARpp
BTlCqZ06OCVeHW2v3UAaoTe2Z7eATQo=
=tR33
-----END PGP SIGNATURE-----

--qcqNbohE9h+Wv+21--
