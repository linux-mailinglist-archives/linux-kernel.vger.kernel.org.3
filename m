Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476D74804BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 22:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhL0VKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 16:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhL0VKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 16:10:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84127C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:10:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1xFj-0004dr-1z; Mon, 27 Dec 2021 22:09:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1xFg-007021-CP; Mon, 27 Dec 2021 22:09:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1xFf-0008NN-Ct; Mon, 27 Dec 2021 22:09:51 +0100
Date:   Mon, 27 Dec 2021 22:09:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH v2 16/23] counter: interrupt-cnt: Convert to new counter
 registration
Message-ID: <20211227210951.imixgc6nob52cjwz@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-17-u.kleine-koenig@pengutronix.de>
 <YcmcdftX3YO06nD1@kroah.com>
 <7e3a4a67-4e97-8660-9437-0250588d5e5e@metafoo.de>
 <YcmkwaeHBy9Jca+2@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5wxpvuwoxkqljgx6"
Content-Disposition: inline
In-Reply-To: <YcmkwaeHBy9Jca+2@kroah.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5wxpvuwoxkqljgx6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 12:34:25PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 27, 2021 at 12:21:14PM +0100, Lars-Peter Clausen wrote:
> > On 12/27/21 11:59 AM, Greg Kroah-Hartman wrote:
> > > On Mon, Dec 27, 2021 at 10:45:19AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > This fixes device lifetime issues where it was possible to free a l=
ive
> > > > struct device.
> > > >=20
> > > > Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >   drivers/counter/interrupt-cnt.c | 28 ++++++++++++++++------------
> > > >   1 file changed, 16 insertions(+), 12 deletions(-)
> > > >=20
> > > > diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/inte=
rrupt-cnt.c
> > > > index 4bf706ef46e2..9e99702470c2 100644
> > > > --- a/drivers/counter/interrupt-cnt.c
> > > > +++ b/drivers/counter/interrupt-cnt.c
> > > > @@ -16,7 +16,6 @@
> > > >   struct interrupt_cnt_priv {
> > > >   	atomic_t count;
> > > > -	struct counter_device counter;
> > > >   	struct gpio_desc *gpio;
> > > >   	int irq;
> > > >   	bool enabled;
> > > > @@ -148,12 +147,14 @@ static const struct counter_ops interrupt_cnt=
_ops =3D {
> > > >   static int interrupt_cnt_probe(struct platform_device *pdev)
> > > >   {
> > > >   	struct device *dev =3D &pdev->dev;
> > > > +	struct counter_device *counter;
> > > >   	struct interrupt_cnt_priv *priv;
> > > >   	int ret;
> > > > -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > > -	if (!priv)
> > > > +	counter =3D devm_counter_alloc(dev, sizeof(*priv));
> > > I just picked one of these patches at random, nothing specific about
> > > this driver...
> > >=20
> > > You can not have a 'struct device' in memory allocated by devm_*()
> > > functions for the obvious reason that now that memory is being
> > > controlled by a reference count that is OUTSIDE of the structure itse=
lf.
> > >=20
> > > So while your goal might be good here, this is not the correct soluti=
on
> > > at all, sorry.
> >=20
> > Before this patch the memory for the struct device was devm_kzalloc'ed.
> > Which as you point out is a bug.
> >=20
> > After this patch the memory is reference counted and will be freed when=
 the
> > last reference is dropped, in the release callback of the struct device.

@Lars, thanks for arguing for my case.
=20
> > The alloc function is still a devm_ function, but on 'free' it will only
> > drop the reference to the struct device that it holds. This is a very c=
ommon
> > pattern that is used by basically any driver subsystem in the kernel.
>=20
> Then it is not a real devm_() call, let's not call it that please as it
> is obviously very confusing :)

It's only confusing if you consider the m in devm to stand for "malloc",
but it's for "managed". I agree to Lars that it's a sane approach.

> Just call it counter_alloc(), or , counter_create(), or something a bit
> more in line with the rest of all driver subsystems.

There is a counter_alloc() and in contrast to devm_counter_alloc() the
caller has to care about dropping the reference to it by hand.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5wxpvuwoxkqljgx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHKK5oACgkQwfwUeK3K
7Anjcwf/cRBZeFz8Tg6Ygo1UL0DrWsOinhlupYoWb6NbZHZBwvg7Oub67Afon7no
Ipcr5nZtrHvl5Sfog2MonAFFsYE2FiF11J6z22pElBdmPS21Al7vG3NSy3FSEmPD
ye7S8dvtguFaFWe4FiK4Cg6G/vj9jJbIbrYgburSDSAalaSD7SWdU9SaduzjFucE
5exJpOXUuBegfqGItcK7e+Lovw0nD5BtLYcQFzc7NwAL/UTiVWzQrfogdswhKVJO
v/i0LUz3Kwc15GGhrechLBgfhIQqIUqqKLlihMwirey+W0qaSItI/mxySOEhHhzH
wnEo4CdXjcJETBNqnoju9W8ZIKJCeA==
=6Owp
-----END PGP SIGNATURE-----

--5wxpvuwoxkqljgx6--
