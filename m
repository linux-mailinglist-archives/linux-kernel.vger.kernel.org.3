Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA4257B79C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiGTNjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiGTNjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:39:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B4E5143E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:39:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oE9ul-0005RO-Eq; Wed, 20 Jul 2022 15:38:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oE9uk-0027sz-N5; Wed, 20 Jul 2022 15:38:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oE9uj-006O5X-MV; Wed, 20 Jul 2022 15:38:57 +0200
Date:   Wed, 20 Jul 2022 15:38:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pm_runtime_resume_and_get in .remove callbacks
Message-ID: <20220720133854.7ybmq3rl3gt6dl7x@pengutronix.de>
References: <20220713084739.j4cqab6rfz22nlko@pengutronix.de>
 <CAJZ5v0h4qQoo5uVBLtSFhdVBpD1tpd-SmVzV1dE0+VZMrr-eTA@mail.gmail.com>
 <20220720060627.r7ifcxu6uopgsasw@pengutronix.de>
 <CAJZ5v0gxg+igNpfe1_xyPS=L8jzgS0v7dzCPcZUueRtF68oQSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rg2d6okifd3ot2kp"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gxg+igNpfe1_xyPS=L8jzgS0v7dzCPcZUueRtF68oQSA@mail.gmail.com>
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


--rg2d6okifd3ot2kp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rafael,

On Wed, Jul 20, 2022 at 12:19:09PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 20, 2022 at 8:06 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Jul 13, 2022 at 07:47:39PM +0200, Rafael J. Wysocki wrote:
> > > (1) Use pm_runtime_get_sync() instead of pm_runtime_resume_and_get()
> > > and don't check its return value,
> > >
> > > or if that is not viable, because something really can run if and only
> > > if the device is operational,
> > >
> > > (2) do something like
> > >
> > > ret =3D pm_runtime_resume_and_get(i2c_dev->dev);
> > > i2c_del_adapter(&i2c_dev->adap);
> > > if (ret >=3D 0)
> > >         clk_disable_unprepare(i2c_dev->clk);
> > >
> > > pm_runtime_put_noidle(i2c_dev->dev);
> > > pm_runtime_disable(i2c_dev->dev);
> >
> > Why would you not disable the clk if the resume failed?
>=20
> I thought that it might lead to problems if the device that failed to
> resume was expected to be accessible.
>=20
> If that's not the case, you can simply do (1).
>=20
> > Is it an option to not call one of the resume variants at all and only
> > call pm_runtime_disable()?
>=20
> That depends on whether or not you need to manipulate the hardware in
> the del/disable part.  If you need to access it there, it is better to
> resume I think.  Otherwise, you don't have to do anything, but then
> the next probe needs to be prepared for finding the device in the
> suspended state.

OK, thanks for your time. I think I understood it good enough to tackle
some of the problems I identified.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rg2d6okifd3ot2kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLYBWsACgkQwfwUeK3K
7AkJqgf/d8iG7DeL8qMqdBsRPbcy+1kdhYI5kjwmCULKwp7Xv7VRdbfz+VifmiWv
a5JBx7gkLPCIja0YmXDEKuefCodgGmkmVb04AnjO6zlQqUDn5VaTC9PI46UXVuKG
f4n4pbQx0FlFZvoICW9RbYwdggF/wljD6w73Xt20cuKEUVL8a+Kwg4CCSlyeFywp
TCSJpAq1Yo5R7H0ZPlDo8R9jXcKCi1UG/HxB8c9n2DjNQXi9b7Cacr74wdrpH2ps
y7NRyw2sqN+nxvgnpdvZiUZASaPUK+GLgZyATPo6J5j94HNrpASp4vU2+giiIlAe
2B6n3c7mP4SlgNWdIvaNiLntyAsh3A==
=sAWo
-----END PGP SIGNATURE-----

--rg2d6okifd3ot2kp--
