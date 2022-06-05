Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9299F53DD00
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351231AbiFEQ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243238AbiFEQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:27:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A42BCA5;
        Sun,  5 Jun 2022 09:27:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a10so3940470wmj.5;
        Sun, 05 Jun 2022 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BlhDqnXIWmz99mOmaitwKvZoXf00bis6sm2lmF5SdE0=;
        b=mV9dqH2HnBmPIO1d5I4EKXR8iPDfSXlcAvbfJljUN3vbziKUintaochodqEZVkB4Xj
         AJ2PxMd2+h7Yzr6hT6yfbKL0vq7x5MF8VYjlz4ugAh9S48aOV7K5zrnHYMrVJnKTngSm
         VURI5b2HlrgCziXUFK8h9F13e6jzQiJZEyqur3x6C8fLsd2oPwzEtotCIniPDWFPnuP+
         ixsuLzAy8+5N3Gf2vs78cdMVSEF0Uasi6P7VPjIlgtYhI5+jgALwlIgdjeXwJtDz8Mzf
         sL4R98ifWXgZAXb3dcx6tSPJvPvXxPNMOIk7IANBzClStx/THKXPJ3SklvDg6nBzDkee
         Nclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BlhDqnXIWmz99mOmaitwKvZoXf00bis6sm2lmF5SdE0=;
        b=4C+5HDLu2E2WEtXExTAJ2wiqB7h+/ZrvNtcUdfgu68ToaLU3BScdakfOWWXCd61/vz
         8g7R5hcxPyYIis5HNuMCRC1m3TSHIVPSNZr/u9X3SqDiOZ0382XVPt97phRj4CkE8ptw
         HxW4PDSY8WQYzItSrVc18FUGXBhG5QKmod92rhKcvWenCNG3KSNXEhk/MjRaj8CtpXiS
         +h30CghWSr7Ltlp02rRLSudy925usY4+c1b69uWDT2tON4NcofgDc0kRoGF2yPrpUCJ8
         bNHU6yp2Up6BBsUZt3HvkK5BYiGx8rkdm0xhlj51lbMKThtePZmk9PdTNi6A+UrGS1G6
         E8HA==
X-Gm-Message-State: AOAM533NmT7WNSGC1cvqo1xWt9sF50W7Mg1acwT8QvGse+kQnK10cJTv
        cJXb40U7ck2UAUdDDQr4aZs=
X-Google-Smtp-Source: ABdhPJwITz7ZAWATmsKnFtjy9MAofwUv8X6uuBWL4APFcRGthr9LBgQNsnsaE0oRuFfQQvwgashNAQ==
X-Received: by 2002:a05:600c:4f90:b0:394:970a:71bd with SMTP id n16-20020a05600c4f9000b00394970a71bdmr18960996wmq.158.1654446443345;
        Sun, 05 Jun 2022 09:27:23 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n3-20020a1c2703000000b0039c4b518df4sm3130796wmn.5.2022.06.05.09.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:27:22 -0700 (PDT)
Date:   Sun, 5 Jun 2022 18:27:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com
Subject: Re: [GIT PULL] hte: New subsystem for v5.19-rc1
Message-ID: <YpzZaJtgXbY0W4Ji@orome>
References: <20220603113908.78777-1-thierry.reding@gmail.com>
 <CAHk-=wiVxF5VLFSuet3OrC7u1Gfb-ZyMs4W-KXAc42rXPRWmhA@mail.gmail.com>
 <CACRpkda0KiyjV27WEP_MYpvWXyG787L9PJZaP_hnXh_DFpSj5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EFh38D72SJj7BkNR"
Content-Disposition: inline
In-Reply-To: <CACRpkda0KiyjV27WEP_MYpvWXyG787L9PJZaP_hnXh_DFpSj5Q@mail.gmail.com>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EFh38D72SJj7BkNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 04, 2022 at 10:11:17AM +0200, Linus Walleij wrote:
> On Sat, Jun 4, 2022 at 6:38 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Fri, Jun 3, 2022 at 4:39 AM Thierry Reding <thierry.reding@gmail.com=
> wrote:
> > >
> > > Note that this currently supports only one provider, but there seems =
to
> > > be enough interest in this functionality and we expect to see more
> > > drivers added once this is merged.
> >
> > So the "one provider" worries me, but the part that really doesn't
> > make me all warm and fuzzy is how this came in at the end of the merge
> > window.
>=20
> Another provider did come up, and were requested (by me) to work with
> Dipen on the subsystem in august last year, that was the Intel PMC in the
> Elkhart and Tiger Lake platforms and forward:
> https://patchwork.ozlabs.org/project/linux-gpio/cover/20210824164801.2889=
6-1-lakshmi.sowjanya.d@intel.com/#2766453
>=20
> [I added the other Intel people on that submission to CC]
>=20
> Intel wanted to put this into the GPIO subsystem and what I saw as mainta=
iner
> was that this is a general problem and general purpose (binary) I/O just =
isn't
> going to be the only thing they timestamp. Other events will be for IIO a=
nd
> hwmon or whatever. They have been
> requested to contribute to Dipens work the recent 9 months ... so... well=
 I
> understand people can get other priorities and stuff.
>=20
> Dipen did the right thing and created a separate subsystem that is a prov=
ider
> to GPIO and can be a provider to things like IIO as well, which is what
> it needs to be because for things like sensor fusion and industrial contr=
ol
> systems in general precise timestamps are
> of uttermost importance. And IIO handle a lot of sensors.
>=20
> > The DT bindings got the comment "why call it 'hardware timestamp'"
> > when no other case seems sane.
>=20
> Intel is talking about "input timestamping", admittedly it is done in har=
dware
> but the point is to timestamp input I/O events.
>=20
> > So the DT bindings got renamed. So now part of the code calls it "hte"
> > (which nobody understands outside of the hte community that is
> > apparently one single device: Tegra) and part of the code calls it
> > "timestamp".
>=20
> HTE is "hardware timestamping engine", we have hwmon, hwspinlock,
> hwtracing so maybe hwstamping would be a more natural name then?

Another alternative would be just drivers/timestamp since pretty much
anything in drivers/ is for "hw".

Thierry

--EFh38D72SJj7BkNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKc2WgACgkQ3SOs138+
s6FILQ//bhu038q6SHXjBrxVGvixZRnnAgI4bdwZ/iOBzpfXqnFFaXePFtz2DnXG
MhVKixiQnNN9t+bevpQZ+MZbJ/NBs6BaWv224S9qjGFPXPZEKwJSCaT7XoldRFxN
Tbk4b27Igpe1gPSd+ApBhM6je7gQf0xNFPr73HdrzUqUO17I68reSDLA2BwUpHjP
I9YopQ6ZfPF7ZxAMZ39TiMhIcrH+dzP+r9yy5PZX1gdVoXjM+0Bfc3eGvCTnY8FL
ZoEnKYBu9Ztibr13DsOXV41Pckzxo6XJh46NZD7BRQmPVTbH+QvBSY2ggYocjGe8
Eo6Y8wm9EoznjmIsp93YbZsv77FXd6DmW8nZKgle3YnDCvWaIS+7h7Mx1Yx4oGIk
DrTLwVMk2ls9n1Len8xXhXOf2cXKDiNmUnpE2QWm57KMpQT/MLht4aUcptYYV/Sc
WEoJZZ0gnnzp1LS9xOAXnSqnA36PGtWHXqbX6qJLPep1n8Dxm6ODWuDXY/f0TM/h
4OgpZWwPpKau1AO2dIGMrQreu57eFttnS2/zXVyPWO7fHCxkbSg4PqEpM2Ajg7JQ
A9PqLmxjQpUPvMx6+ra1VZgHhBya8vZ6bcZKbVepbtx9/msJiB1CYJOo6preY7qK
W7Y+UkO16AfIEyR4csivfr1Kwb0ftaVaVeoK3lptbmrW1AqMxmQ=
=Jzkq
-----END PGP SIGNATURE-----

--EFh38D72SJj7BkNR--
