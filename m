Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED4481AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbhL3Ii1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhL3Ii0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:38:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC07DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 00:38:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2qx2-0008SW-Vl; Thu, 30 Dec 2021 09:38:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2qx0-007S9d-5b; Thu, 30 Dec 2021 09:38:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2qwz-0004Fr-3F; Thu, 30 Dec 2021 09:38:17 +0100
Date:   Thu, 30 Dec 2021 09:38:13 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <20211230083813.ucalnkvmct7uc2rm@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <20211229154441.38045-14-u.kleine-koenig@pengutronix.de>
 <20211229170612.1dffa818@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="25ghiofyk574a42m"
Content-Disposition: inline
In-Reply-To: <20211229170612.1dffa818@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--25ghiofyk574a42m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Wed, Dec 29, 2021 at 05:06:12PM +0000, Jonathan Cameron wrote:
> On Wed, 29 Dec 2021 16:44:31 +0100
> Uwe Kleine-K=F6nig         <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > The current implementation gets device lifetime tracking wrong. The
> > problem is that allocation of struct counter_device is controlled by the
> > individual drivers but this structure contains a struct device that
> > might have to live longer than a driver is bound. As a result a command
> > sequence like:
> >=20
> > 	{ sleep 5; echo bang; } > /dev/counter0 &
> > 	sleep 1;
> > 	echo 40000000.timer:counter > /sys/bus/platform/drivers/stm32-timer-co=
unter/unbind
> >=20
> > can keep a reference to the struct device and unbinding results in
> > freeing the memory occupied by this device resulting in an oops.
> >=20
> > This commit provides two new functions (plus some helpers):
> >  - counter_alloc() to allocate a struct counter_device that is
> >    automatically freed once the embedded struct device is released
> >  - counter_add() to register such a device.
> >=20
> > Note that this commit doesn't fix any issues, all drivers have to be
> > converted to these new functions to correct the lifetime problems.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Basically fine - a few trivial comments inline that I'm not that fussed
> about whether you take notice of or not. As such
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.

> I'd have liked to have seen a change log here. Quite a few comments on th=
is
> one and not all had 'obvious' resolutions.

yeah, should have been a bit less lazy and comment a bit more than the
range diff in the cover letter.

To catch up:

 - privdata is now cache line aligned
 - consistent bracing for oneline if blocks
 - fixed the warning by the 0day bot which explained that only one
   device can be bound
 - reordered the body of counter_add() to better match
   counter_register()
 - Add an EXPORT_SYMBOL_GPL(counter_put);
 - Drop one pair of get_device/put_device
 - kernel doc for devm_counter_a{lloc,dd}

> >  drivers/counter/counter-core.c | 168 ++++++++++++++++++++++++++++++++-
> >  include/linux/counter.h        |  15 +++
> >  2 files changed, 181 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-c=
ore.c
> > index 00c41f28c101..b3fa15bbcbdb 100644
> > --- a/drivers/counter/counter-core.c
> > +++ b/drivers/counter/counter-core.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/kdev_t.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <linux/wait.h>
> > =20
> > @@ -24,6 +25,16 @@
> >  /* Provides a unique ID for each counter device */
> >  static DEFINE_IDA(counter_ida);
> > =20
> > +struct counter_device_allochelper {
> > +	struct counter_device counter;
> > +
> > +	/*
> > +	 * This is cache line aligned to ensure private data behaves like if =
it
> > +	 * were kmalloced separately.
> > +	 */
> > +	unsigned long privdata[] ____cacheline_aligned;
>=20
> Change log for the patch would have made it easier to see you decided
> to make this change after the discussion in v2.

Yeah, this was a wim of the moment after I saw that this usually only
results in a 32 byte alignment.

> > +};
> > +
>=20
> ...
>=20
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
> > +	int err;
> > +
> > +	ch =3D kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
> > +	if (!ch) {
> > +		err =3D -ENOMEM;
> > +		goto err_alloc_ch;
>=20
> Slight preference for a direct return here even though it means
> replicating the ERR_PTR() statement.  Makes for one less error
> path where a reviewer has to go see what is being done.

I'll consider it if it comes to a v4.

> > +	}
> > +
> > +	counter =3D &ch->counter;
> > +	dev =3D &counter->dev;
> > +
> > +	/* Acquire unique ID */
> > +	err =3D ida_alloc(&counter_ida, GFP_KERNEL);
> > +	if (err < 0)
> > +		goto err_ida_alloc;
> > +	dev->id =3D err;
> > +
> > +	mutex_init(&counter->ops_exist_lock);
> > +	dev->type =3D &counter_device_type;
> > +	dev->bus =3D &counter_bus_type;
> > +	dev->devt =3D MKDEV(MAJOR(counter_devt), dev->id);
> > +
> > +	err =3D counter_chrdev_add(counter);
> > +	if (err < 0)
> > +		goto err_chrdev_add;
> > +
> > +	device_initialize(dev);
> > +
> > +	return counter;
> > +
> > +err_chrdev_add:
>
> Nitpick: Unusual spacing (to my eye anyway). I wouldn't expect to see a b=
lank line after a label
> as the label indentation makes a visual separation anyway.

I know this is unusual, but I like this approach. The error label is
named after what failed (instead of the more usual what has to be undone
first) and then it's grouped to the matching undo-function.

See
https://lore.kernel.org/linux-pwm/20201106093435.4mlr6ujivvkzkd5z@pengutron=
ix.de
for a more verbose reasoning (which however failed to convince my fellow
pwm maintainers :-\).

> > +   ida_free(&counter_ida, dev->id);
> > +err_ida_alloc:
> > +
> > +   kfree(ch);
> > +err_alloc_ch:
> > +
> > +   return ERR_PTR(err);
> > +}

Best regards and thanks for your feedback,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--25ghiofyk574a42m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHNb/IACgkQwfwUeK3K
7AnBDgf/RJzJcZOFgNO45cWb2wOSAS8Z0vwcKQzTsGJ9zi2Z6sY81Ffed44AeEQc
OzUzAFT1Rmn/WsXOOgDM8BY6EviZNYuXcLpQQoQXmlmlucDRsLzulj0jh9cOuJds
bKj5CF6aGsBY67XrrmrAuK7RJ3T6zMpkOtc/VD6Ylb9StbO+yAlUTSgBv20q1fx5
enqcSIkelWXW+QFfw/dqeB+3D2z83bSt/IQvnuARvzJcnkvggPK3OdIkco/aPgx9
ZTApBHopuC9fc/WgtpTgoOTLCpXphEm2f5/+xCMttK4XENcgzokTe9T2rMKyxLe1
rO5A9sLyiRjmv8S2pcK6SOXxXLHjQA==
=eYfM
-----END PGP SIGNATURE-----

--25ghiofyk574a42m--
