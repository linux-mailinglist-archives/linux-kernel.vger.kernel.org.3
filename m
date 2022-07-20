Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7987F57B0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiGTGGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbiGTGGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:06:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E026872B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:06:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oE2qu-00026Y-C6; Wed, 20 Jul 2022 08:06:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oE2qt-0023uC-Gn; Wed, 20 Jul 2022 08:06:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oE2qs-006JuG-Fl; Wed, 20 Jul 2022 08:06:30 +0200
Date:   Wed, 20 Jul 2022 08:06:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pm_runtime_resume_and_get in .remove callbacks
Message-ID: <20220720060627.r7ifcxu6uopgsasw@pengutronix.de>
References: <20220713084739.j4cqab6rfz22nlko@pengutronix.de>
 <CAJZ5v0h4qQoo5uVBLtSFhdVBpD1tpd-SmVzV1dE0+VZMrr-eTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7bjlrlae5aaqwhvp"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h4qQoo5uVBLtSFhdVBpD1tpd-SmVzV1dE0+VZMrr-eTA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7bjlrlae5aaqwhvp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rafael,

On Wed, Jul 13, 2022 at 07:47:39PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 13, 2022 at 10:47 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > there is a big bunch of kernel drivers (here:
> > drivers/i2c/busses/i2c-sprd.c) that have a remove callback that looks as
> > follows:
> >
> >         static int sprd_i2c_remove(struct platform_device *pdev)
> >         {
> >                 struct sprd_i2c *i2c_dev =3D platform_get_drvdata(pdev);
> >                 int ret;
> >
> >                 ret =3D pm_runtime_resume_and_get(i2c_dev->dev);
> >                 if (ret < 0)
> >                         return ret;
> >
> >                 i2c_del_adapter(&i2c_dev->adap);
> >                 clk_disable_unprepare(i2c_dev->clk);
> >
> >                 pm_runtime_put_noidle(i2c_dev->dev);
> >                 pm_runtime_disable(i2c_dev->dev);
> >
> >                 return 0;
> >         }
> >
> > If pm_runtime_resume_and_get fails, the i2c adapter isn't removed, but
> > as the memory backing i2c_dev goes away---it was allocated using
> > devm_kzalloc in .probe()---the next i2c action will probably access
> > freed memory.
> >
> > I'm not familiar enough with pm-runtime stuff, but wonder what
> > can/should be done about that. The obvious (to me) candidates are:
> >
> >  - log an error if pm_runtime_resume_and_get() fails, but continue to
> >    clean up
> >  - don't check the return value at all
> >
> > What do you think?
>=20
> (1) Use pm_runtime_get_sync() instead of pm_runtime_resume_and_get()
> and don't check its return value,
>=20
> or if that is not viable, because something really can run if and only
> if the device is operational,
>=20
> (2) do something like
>=20
> ret =3D pm_runtime_resume_and_get(i2c_dev->dev);
> i2c_del_adapter(&i2c_dev->adap);
> if (ret >=3D 0)
>         clk_disable_unprepare(i2c_dev->clk);
>=20
> pm_runtime_put_noidle(i2c_dev->dev);
> pm_runtime_disable(i2c_dev->dev);

Why would you not disable the clk if the resume failed?

Is it an option to not call one of the resume variants at all and only
call pm_runtime_disable()?

Thanks for your input,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7bjlrlae5aaqwhvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLXm2AACgkQwfwUeK3K
7AnUVwf+NJQmrHAC8PO84y3YoH+UcogkLEtujYKH3Szi7UVwc62Vh/Yh3PaBQBDQ
tanx/cr/pzEbdyXfa5KWFgy+Vwrv3YUzyxsUC51q6CToxsfLgz4Flqc6RG/6WYrv
QOqtGRmXNqVD+gks9ySlKyecLAoFOyPVOJMARgaxTGBjgOZFIDgrAujm7fVwqvNw
yKJ2x3c7JEFJV3qFRlHy5C5de/YjKpvUBJdXSeGSfs6in7tLCMIOzDcGsxgPwqic
NM3V5C6sh9eek/Oq4G1R6n7ld0qz5rr3vPy+6cYGpBdSHb1TSw44HAhb/pVPR1CD
fvbwJSBm3s+sLHj7lZnEW2NK3F0oJQ==
=IbjU
-----END PGP SIGNATURE-----

--7bjlrlae5aaqwhvp--
