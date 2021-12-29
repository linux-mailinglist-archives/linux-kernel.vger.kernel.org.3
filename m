Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA14814BF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhL2PrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbhL2PrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:47:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E98C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:47:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2bAV-0008LJ-G1; Wed, 29 Dec 2021 16:47:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2bAV-007KIk-2W; Wed, 29 Dec 2021 16:47:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2bAU-0001EE-67; Wed, 29 Dec 2021 16:47:10 +0100
Date:   Wed, 29 Dec 2021 16:47:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <20211229154707.hlmf5azc63hzdfd5@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
 <20211228180017.37c2703d@jic23-huawei>
 <1d3c1df9-42b8-e451-f622-32d8c1e6d1b5@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dw7yj4rm5wxybk7e"
Content-Disposition: inline
In-Reply-To: <1d3c1df9-42b8-e451-f622-32d8c1e6d1b5@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dw7yj4rm5wxybk7e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 29, 2021 at 03:49:29PM +0200, Jarkko Nikula wrote:
> On 12/28/21 20:00, Jonathan Cameron wrote:
> > On Mon, 27 Dec 2021 10:45:16 +0100
> > Uwe Kleine-K=F6nig         <u.kleine-koenig@pengutronix.de> wrote:
> > > +	if (err < 0)
> > > +		goto err_chrdev_add;
> > > +
> > > +	device_initialize(dev);
> > > +	/* Configure device structure for Counter */
> > > +	dev->type =3D &counter_device_type;
> > > +	dev->bus =3D &counter_bus_type;
> > > +	dev->devt =3D MKDEV(MAJOR(counter_devt), id);
> >=20
> > As 0-day pointed out id not initialized.
> >=20
> This was the reason why second counter instance initialization failed for=
 me
> when testing the patch 17. I fixed it locally by changing the line a few
> rows above the MKDEV():
>=20
> -	dev->id =3D err;
> +	dev->id =3D id =3D err;

Instead I dropped id for v3. I failed to check this mailthread again
before sending it out. So I missed your feedback. I will go through it
again and comment later.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dw7yj4rm5wxybk7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHMgvgACgkQwfwUeK3K
7AmXCAf+KnF1zl1IJybEDHcaQ1jKTFYZELGukiDDi+3mWsaTLzTa4AMXocctcg1b
SgvDXuniLp/ZBqutfZbYvceNVxJs+fg+qjcf2ZkM/3EceCkl7IZA+5SC6FZHeN48
ODUHyJMVfv+hByDhYwIYlYbBnroZNCCsS7lNicWn48VNcj2asUgbxO9c8Sfl2MmO
71dotVhYwc2KYyz+gMAbuLA8hLgBIcW6QXXw5PpCjJx0cP1VjotgGyEamp01IMDu
FFOhDKFG31oI3dSoXBNsH+OtBo0OxyYJLgVLqt9JLcoT7dZguDzpAwYqoq1U8YQB
BJ9Z8b1bwGGrJQV2SJwkbBFfZvK9Qg==
=koAV
-----END PGP SIGNATURE-----

--dw7yj4rm5wxybk7e--
