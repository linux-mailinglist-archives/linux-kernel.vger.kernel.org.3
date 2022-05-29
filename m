Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05073536FE2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiE2GL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiE2GL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:11:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85CDCD
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:11:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvC93-0005yj-Rj; Sun, 29 May 2022 08:11:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvC91-005CYc-6N; Sun, 29 May 2022 08:11:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvC8z-00Cp2h-74; Sun, 29 May 2022 08:11:17 +0200
Date:   Sun, 29 May 2022 08:11:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Input: adp5588-keys - switch to using managed
 resources
Message-ID: <20220529061115.ew52jiknnebaofwd@pengutronix.de>
References: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
 <20220528045631.289821-3-dmitry.torokhov@gmail.com>
 <20220528193755.lncxrpgmyiy4hprm@pengutronix.de>
 <YpMC/90883D286nG@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="frimy6xcganxv6jb"
Content-Disposition: inline
In-Reply-To: <YpMC/90883D286nG@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--frimy6xcganxv6jb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 28, 2022 at 10:22:07PM -0700, Dmitry Torokhov wrote:
> On Sat, May 28, 2022 at 09:37:55PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, May 27, 2022 at 09:56:30PM -0700, Dmitry Torokhov wrote:
> > > This simplifies error handling in probe() and reduces amount of expli=
cit
> > > code in remove().
> > >=20
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/input/keyboard/adp5588-keys.c | 111 +++++++++++-------------=
--
> > >  1 file changed, 45 insertions(+), 66 deletions(-)
> > >=20
> > > diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/ke=
yboard/adp5588-keys.c
> > > index ac21873ba1d7..df84a2998ed2 100644
> > > --- a/drivers/input/keyboard/adp5588-keys.c
> > > +++ b/drivers/input/keyboard/adp5588-keys.c
> > > @@ -182,6 +182,21 @@ static int adp5588_build_gpiomap(struct adp5588_=
kpad *kpad,
> > >  	return n_unused;
> > >  }
> > > =20
> > > +static void adp5588_gpio_do_teardown(void *_kpad)
> > > +{
> > > +	struct adp5588_kpad *kpad =3D _kpad;
> > > +	struct device *dev =3D &kpad->client->dev;
> > > +	const struct adp5588_kpad_platform_data *pdata =3D dev_get_platdata=
(dev);
> > > +	const struct adp5588_gpio_platform_data *gpio_data =3D pdata->gpio_=
data;
> > > +	int error;
> > > +
> > > +	error =3D gpio_data->teardown(kpad->client,
> > > +				    kpad->gc.base, kpad->gc.ngpio,
> > > +				    gpio_data->context);
> > > +	if (error)
> > > +		dev_warn(&kpad->client->dev, "teardown failed %d\n", error);
> > > +}
> >=20
> > I think the more sensible approach is to drop support for setup and
> > teardown. Maybe even rip all usage of adp5588_gpio_platform_data.
>=20
> That will come with the transition to device tree/device properties. For
> now wanted to keep existing functionality intact.

That's up to you. I wouldn't spend an effort to clean up a feature that
is about to be removed.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--frimy6xcganxv6jb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKTDn8ACgkQwfwUeK3K
7AnSsAf+Li4Te/1P7RLCFRukMaq/G/Nk0rAzAumXFSuwji793S+4vSZ9eyZ7Pnhe
CJ/acu83ObTmrSgzZb4qLLdBRqKZnNOKzL8794Lhcqec8mp1nxAZEMTWu06s1m9U
6Qp6Cs/oVkT9s4VK/enKhF45+mWFnFnKTGlYnOYXmrxNQBtbWODVtqfTvPkQX7Cb
PfE2Hf1kswfBmdpBeH98FuhL7KcITV12qibOwPbacvMCNNkPoIV4C/QlVTAiZ2fM
1ee15bDGhupbbrNvggB7p/lWI/HzJ5GTDLGLwB0PqKWGt1I0KqMcPntehSsl2TGm
lbs1ykRMB892fVxkKQY6drmRKEi/nQ==
=2t1U
-----END PGP SIGNATURE-----

--frimy6xcganxv6jb--
