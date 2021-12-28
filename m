Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD514808C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 12:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhL1LWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 06:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhL1LWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 06:22:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC22C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 03:22:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2AZ0-0002Aq-Sh; Tue, 28 Dec 2021 12:22:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2AYz-0076Xf-SB; Tue, 28 Dec 2021 12:22:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2AYy-000344-AD; Tue, 28 Dec 2021 12:22:40 +0100
Date:   Tue, 28 Dec 2021 12:22:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <20211228112237.5tinwznxtaufl2eb@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
 <2053a9ea-a647-89f4-497c-1141ac3e0fa7@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ka5odb7mipqo6zs"
Content-Disposition: inline
In-Reply-To: <2053a9ea-a647-89f4-497c-1141ac3e0fa7@metafoo.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2ka5odb7mipqo6zs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 27, 2021 at 01:16:56PM +0100, Lars-Peter Clausen wrote:
> On 12/27/21 10:45 AM, Uwe Kleine-K=F6nig wrote:
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
> >   - counter_alloc() to allocate a struct counter_device that is
> >     automatically freed once the embedded struct device is released
> >   - counter_add() to register such a device.
> >=20
> > Note that this commit doesn't fix any issues, all drivers have to be
> > converted to these new functions to correct the lifetime problems.
> Nice work!

\o/

> > [...]
> > @@ -24,6 +25,11 @@
> >   /* Provides a unique ID for each counter device */
> >   static DEFINE_IDA(counter_ida);
> > +struct counter_device_allochelper {
> > +	struct counter_device counter;
> > +	unsigned long privdata[];
>=20
> The normal k*alloc functions guarantee that the allocation is cacheline
> aligned. Without that for example the ____cacheline_aligned attribute will
> not work correctly. And while it is unlikely that a counter driver will n=
eed
> for example DMA memory I think it is still good practice to guarantee this
> here to avoid bad surprises. There are two ways of doing this.

Yeah, I thought to add more alignment once the need arises. My
preference would be to got for the ____cacheline_aligned approach.

> > [...]
> > +struct counter_device *counter_alloc(size_t sizeof_priv)
> I'd add a parent parameter here since with the devm_ variant we have to p=
ass
> it anyway and this allows to slightly reduce the boilerplate code in the
> driver where the parent field of the counter has to be initialized.

I don't feel strong here, can do that.

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
> There is a inconsistency whether braces are used for single statement `if=
`s
> in this patch.

Oh, indeed.

> > +	dev->id =3D err;
> > +
> > +	err =3D counter_chrdev_add(counter);
> > +	if (err < 0)
> > +		goto err_chrdev_add;
> > +
> > +	device_initialize(dev);
> > +	/* Configure device structure for Counter */
> > +	dev->type =3D &counter_device_type;
> > +	dev->bus =3D &counter_bus_type;
> > +	dev->devt =3D MKDEV(MAJOR(counter_devt), id);
> > +
> > +	mutex_init(&counter->ops_exist_lock);
> > +
> > +	return counter;
> > +
> > +err_chrdev_add:
> > +
> > +	ida_free(&counter_ida, dev->id);
> > +err_ida_alloc:
> > +
> > +	kfree(ch);
> > +err_alloc_ch:
> > +
> > +	return ERR_PTR(err);
> > +}
> > +EXPORT_SYMBOL_GPL(counter_alloc);
> > +
> > +void counter_put(struct counter_device *counter)
> > +{
> > +	put_device(&counter->dev);
> > +}
> > +
> > +/**
> > + * counter_add - complete registration of a counter
> > + * @counter: the counter to add
> > + *
> > + * This is part two of counter registration.
> > + *
> > + * If this succeeds, call counter_unregister() to get rid of the count=
er_device again.
> > + */
> > +int counter_add(struct counter_device *counter)
> > +{
> > +	int err;
> > +	struct device *dev =3D &counter->dev;
> > +
> > +	get_device(&counter->dev);
>=20
> This get_device() is not needed. device_add() will also add a reference, =
so
> you increment the reference count by 2 when calling counter_add().
>=20
> It is only needed to balance the put_device() in counter_unregister(). I'd
> add a `counter->legacy_device` around that put_device() and then remove it
> in the last patch.

Ah indeed. I added that to balance the call of put_device() by devm_counter=
_alloc()'s
release function (devm_counter_put()). But on a quick check you're
right. I will think about it a bit more and test.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2ka5odb7mipqo6zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHK83oACgkQwfwUeK3K
7AkcGwf/ZcK6TYGqTAecs3h7cl04VmVZMhveDpedmVU+887CKf14x+C6753sRjme
klRIrow4C9CYJznnYfnkXc0Uuf21WT6glrBM/3zoc2Mwzyu7phrveudtQCTvzU27
qIgE5iMAeKrAmzynaSCMPRDrGOsuwQ3cK0v4RQdQOXd1B1Y+PRjZHHZOEdKwebfp
pErqItG1fXM1qdSkOJLJaDyyiXPNF6nnRUui1fUPyrqat55e1PSM80QOC3N5CUc/
j36YVELUHgIWHHfZkR1DKCaW02r8X4suHtOm+7AW3T1GWXH+Z+tJk9pDLOI7OFIU
I2UEB25bm3RpbFqFYUi2FgJaFDDBqg==
=ERGt
-----END PGP SIGNATURE-----

--2ka5odb7mipqo6zs--
