Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED548126E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbhL2MHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbhL2MHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:07:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CDAC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 04:07:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2Xjt-0000Lq-6h; Wed, 29 Dec 2021 13:07:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2Xjr-007ISc-4i; Wed, 29 Dec 2021 13:07:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2Xjq-00064p-8Z; Wed, 29 Dec 2021 13:07:26 +0100
Date:   Wed, 29 Dec 2021 13:07:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <20211229120723.y5dlbmbvmg4ogq26@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
 <20211228180017.37c2703d@jic23-huawei>
 <20211229112732.23aefj6hcv7ymija@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5w552i7ktf2x4f4g"
Content-Disposition: inline
In-Reply-To: <20211229112732.23aefj6hcv7ymija@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5w552i7ktf2x4f4g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Dec 29, 2021 at 12:27:32PM +0100, Uwe Kleine-K=F6nig wrote:
> > Personal inclination here would be to keep the elements in here
> > in the same order as in counter_register() where it doesn't matter
> > in the interests of slightly easier comparison of the code.
>=20
> I reordered a bit because counter_register fails to undo ida_alloc() in
> the error path. However I might have missed that some initialisation has
> to be done before calling counter_chrdev_add().

Another issue in counter_register() is: If counter_sysfs_add() fails,
put_device() is called which eventually calls counter_device_release()
-> counter_chrdev_remove() -> kfifo_free(). I think it's not a real
problem, but it's ugly because because counter_chrdev_add()
-> kfifo_alloc() wasn't called yet.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5w552i7ktf2x4f4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHMT3gACgkQwfwUeK3K
7AkvxQf+NQEyz2nLrMETgnBViWuwOhqLb643u36Y1JbzUczPWJkBeiy7k2wKXfjL
cIdvNq7zcSEvqWtjI+U2xaf5LDBWF5S9fFu1XyanTISj1wNao1MVSciQ0FCafSsq
/BtyYrasVbAfJdkqgoOMR071yfzkuck7bgl13m7ZaixOtagWjGn086bVIfTwKuSo
eMZJ7ORej4gDX2DjvIHp2Xqw/YSL0B3kFhpwrT2P/HMMJPNDEMCB9gmKRptD0Vtr
Vf1Mjt1p8Z8xkHNxAowwT44TCC8kJ0TDwRhQSrAqcud7TlBRvJe0x0K0CViB3+YB
HJDT21XMEf8a+OzyxbzZaA4gNVJpMQ==
=Vedz
-----END PGP SIGNATURE-----

--5w552i7ktf2x4f4g--
