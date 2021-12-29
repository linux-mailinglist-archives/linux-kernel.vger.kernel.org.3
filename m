Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0FA481202
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbhL2L1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhL2L1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:27:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BB6C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 03:27:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2X7L-0006Td-3v; Wed, 29 Dec 2021 12:27:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2X7I-007I1h-C3; Wed, 29 Dec 2021 12:27:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2X7H-00046F-GX; Wed, 29 Dec 2021 12:27:35 +0100
Date:   Wed, 29 Dec 2021 12:27:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <20211229112732.23aefj6hcv7ymija@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
 <20211228180017.37c2703d@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hbkknuagzjmivh5a"
Content-Disposition: inline
In-Reply-To: <20211228180017.37c2703d@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hbkknuagzjmivh5a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Dec 28, 2021 at 06:00:17PM +0000, Jonathan Cameron wrote:
> On Mon, 27 Dec 2021 10:45:16 +0100
> Uwe Kleine-K=F6nig         <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > +struct counter_device_allochelper {
> > +	struct counter_device counter;
> > +	unsigned long privdata[];
> Nice to keep this opaque. We danced around how to do this in IIO for
> a while and never got to a solution we all liked.  Slight disadvantage
> is this might matter in hot paths where the compiler doesn't have visibil=
ity
> to know it can very cheaply access the privdata.
>=20
> I guess that can be looked at if anyone ever measures it as an important
> element (they probably never will!)

*nod*

> > +};
> > +
> >  static void counter_device_release(struct device *dev)
> >  {
> >  	struct counter_device *const counter =3D
> > @@ -31,6 +37,9 @@ static void counter_device_release(struct device *dev)
> > =20
> >  	counter_chrdev_remove(counter);
> >  	ida_free(&counter_ida, dev->id);
> > +
> > +	if (!counter->legacy_device)
> > +		kfree(container_of(counter, struct counter_device_allochelper, count=
er));
> >  }
> > =20
> >  static struct device_type counter_device_type =3D {
> > @@ -53,7 +62,14 @@ static dev_t counter_devt;
> >   */
> >  void *counter_priv(const struct counter_device *const counter)
> >  {
> > -	return counter->priv;
> > +	if (counter->legacy_device) {
> > +		return counter->priv;
> > +	} else {
> > +		struct counter_device_allochelper *ch =3D
> > +			container_of(counter, struct counter_device_allochelper, counter);
> > +
> > +		return &ch->privdata;
> > +	}
> >  }
> >  EXPORT_SYMBOL_GPL(counter_priv);
> > =20
> > @@ -74,6 +90,8 @@ int counter_register(struct counter_device *const cou=
nter)
> >  	int id;
> >  	int err;
> > =20
> > +	counter->legacy_device =3D true;
> > +
> >  	/* Acquire unique ID */
> >  	id =3D ida_alloc(&counter_ida, GFP_KERNEL);
> >  	if (id < 0)
> > @@ -114,6 +132,100 @@ int counter_register(struct counter_device *const=
 counter)
> >  }
> >  EXPORT_SYMBOL_GPL(counter_register);
> > =20
> > +/**
> > + * counter_alloc - allocate a counter_device
> > + * @sizeof_priv: size of the driver private data
> > + *
> > + * This is part one of counter registration. The structure is allocated
> > + * dynamically to ensure the right lifetime for the embedded struct de=
vice.
> > + *
> > + * If this succeeds, call counter_put() to get rid of the counter_devi=
ce again.
> > + */
> > +struct counter_device *counter_alloc(size_t sizeof_priv)
> > +{
> > +	struct counter_device_allochelper *ch;
> > +	struct counter_device *counter;
> > +	struct device *dev;
> > +	int id, err;
> > +
> > +	ch =3D kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
> > +	if (!ch) {
> > +		err =3D -ENOMEM;
> > +		goto err_alloc_ch;
> > +	}
> > +
> > +	counter =3D &ch->counter;
> > +	dev =3D &counter->dev;
> > +
> > +	/* Acquire unique ID */
> > +	err =3D ida_alloc(&counter_ida, GFP_KERNEL);
> > +	if (err < 0) {
> > +		goto err_ida_alloc;
> > +	}
> > +	dev->id =3D err;
> > +
> > +	err =3D counter_chrdev_add(counter);
>=20
> Should think about renaming  counter_chrdev_add() given it
> does init and allocation stuff but no adding.

This is orthogonal to this series though. So I won't address this in the
context of the lifetime fixes here.

> Personal inclination here would be to keep the elements in here
> in the same order as in counter_register() where it doesn't matter
> in the interests of slightly easier comparison of the code.

I reordered a bit because counter_register fails to undo ida_alloc() in
the error path. However I might have missed that some initialisation has
to be done before calling counter_chrdev_add().

Will check in detail for v3.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hbkknuagzjmivh5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHMRiEACgkQwfwUeK3K
7AmXowf9GfmFn9HCNMLoAmzhetNnjW2owBbthUqTxffUzcAIEBNYQqO62X5deaUg
FnaRHzSEZOOJb0lZoiaTDZ7M+tTpsuK0A62nqXpVE2CBpvq2NWVh9n2KlIOFKTeB
UCiTd/5nbldHCgKHTZQVYRux4PVm8r17PTqDcX12HGYtvPi+DEQXhPSOPArFxWY4
ic++NLuoQ0Ms39X24CUHkrReuuBePA6hUdU2DEDOt1D9aIoDpwtvuo9IXS7M5aN+
WfzqL/bE/F3jvWZahkKwL1ZNE5/Zu4wEfajTpmmMfyo4whdE3P7nJp7sE+xtAe30
g5O3rJfqiZ89eF5dbJBcZHHmZeB0FA==
=Qsv1
-----END PGP SIGNATURE-----

--hbkknuagzjmivh5a--
