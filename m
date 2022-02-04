Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227D74A94B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353827AbiBDHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiBDHnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:43:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5DEC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:43:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFtFp-00068W-DP; Fri, 04 Feb 2022 08:43:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFtFp-00ERAQ-DO; Fri, 04 Feb 2022 08:43:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFtFn-006URY-UU; Fri, 04 Feb 2022 08:43:35 +0100
Date:   Fri, 4 Feb 2022 08:43:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: Set counter device name
Message-ID: <20220204074333.mug7nlfer4pyp7go@pengutronix.de>
References: <20220203073459.90093-1-vilhelm.gray@gmail.com>
 <20220203090053.oki5ts4c2gdpi2c6@pengutronix.de>
 <YfzKnWJTwiWgOofi@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rm4wd4thl5yhwceb"
Content-Disposition: inline
In-Reply-To: <YfzKnWJTwiWgOofi@shinobu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rm4wd4thl5yhwceb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 04, 2022 at 03:41:33PM +0900, William Breathitt Gray wrote:
> On Thu, Feb 03, 2022 at 10:00:53AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Feb 03, 2022 at 04:34:59PM +0900, William Breathitt Gray wrote:
> > > Naming the counter device provides a convenient way to identify it in
> > > devres_log events and similar situations. This patch names the counter
> > > device by combining the prefix "counter" with the counter device's
> > > unique ID.
> > >=20
> > > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > ---
> > >  drivers/counter/counter-core.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter=
-core.c
> > > index 7e0957eea094..2ebd9adf0bd2 100644
> > > --- a/drivers/counter/counter-core.c
> > > +++ b/drivers/counter/counter-core.c
> > > @@ -22,6 +22,8 @@
> > >  #include "counter-chrdev.h"
> > >  #include "counter-sysfs.h"
> > > =20
> > > +#define COUNTER_NAME	"counter"
> > > +
> > >  /* Provides a unique ID for each counter device */
> > >  static DEFINE_IDA(counter_ida);
> > > =20
> > > @@ -104,6 +106,10 @@ struct counter_device *counter_alloc(size_t size=
of_priv)
> > >  		goto err_ida_alloc;
> > >  	dev->id =3D err;
> > > =20
> > > +	err =3D dev_set_name(dev, COUNTER_NAME "%d", dev->id);
> > > +	if (err)
> > > +		goto err_dev_set_name;
> > > +
> > >  	mutex_init(&counter->ops_exist_lock);
> > >  	dev->type =3D &counter_device_type;
> > >  	dev->bus =3D &counter_bus_type;
> > > @@ -119,6 +125,9 @@ struct counter_device *counter_alloc(size_t sizeo=
f_priv)
> > > =20
> > >  err_chrdev_add:
> > > =20
> > > +	kfree(dev_name(dev));
> > > +err_dev_set_name:
> > > +
> >=20
> > I think this is wrong as kobject_cleanup frees the name.
>=20
> This is true once the device is initialized by device_initialize() but
> that won't happen until after counter_chrdev_add() is called; if
> counter_chrdev_add() fails, we need to free this memory lest it leak
> when we return the error code.

Ah I see. Still I would consider it a layer violation to have to know
this has to be freed (also about kfree vs. kfree_const). I suggest to
move setting the name after the call to device_initialize(). Then the
device core cares for that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rm4wd4thl5yhwceb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmH82SIACgkQwfwUeK3K
7AlQDwf/fbdIp7OOhzbweqrAuLmNFuy3vumVU44qwuaz+fQcSyTvRbXtFl6Zxnd0
eTCmTCr8lt09Z4xBSQL/vqSqZgJ2xoRdv2EuY8lLb51YjIYNdPngkFaVaPpDXTyu
SebuMUsnvo4qmZQX+SvWzfF0i8ZZ7oyI9NYCJ4gYrKuLh/OxiwEIPMxuExyehpJO
rfYaXeeNORGoFt1I3JnWZFdiOQCmPsEMSM/Dp9Lje/XuO5x0E0v569zeRaSdhgRK
rC+CYLsPmeN1d/g0njsdVHw6lHBemmIqvQ4ew6W7AIJYxXcb9q+xPzfrbW06GLHE
K0iQMq+DXJyr8ktaLjg50NpcBfzhbA==
=zP1I
-----END PGP SIGNATURE-----

--rm4wd4thl5yhwceb--
