Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100F647BF08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhLULgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhLULgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:36:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF983C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:36:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzdRH-0001PR-5j; Tue, 21 Dec 2021 12:36:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzdRF-005o83-Gu; Tue, 21 Dec 2021 12:36:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzdRD-00072F-O5; Tue, 21 Dec 2021 12:36:11 +0100
Date:   Tue, 21 Dec 2021 12:35:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/8] counter: Remove struct counter_device::priv
Message-ID: <20211221113542.rl4aburbzzrgs3km@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
 <dadb79b2-ac21-1899-48b9-1c6723afb1b4@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apqkyk5gu62tvk7i"
Content-Disposition: inline
In-Reply-To: <dadb79b2-ac21-1899-48b9-1c6723afb1b4@metafoo.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--apqkyk5gu62tvk7i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lars,

On Tue, Dec 21, 2021 at 12:12:12PM +0100, Lars-Peter Clausen wrote:
> On 12/21/21 11:45 AM, Uwe Kleine-K=F6nig wrote:
> > similar to patch
> > https://lore.kernel.org/r/4bde7cbd9e43a5909208102094444219d3154466.1640=
072891.git.vilhelm.gray@gmail.com
> > the usage of struct counter_device::priv can be replaced by
> > container_of which improves type safety and code size.
> >=20
> > This series depends on above patch, converts the remaining drivers and
> > finally drops struct counter_device::priv.
>=20
> Not sure if this is such a good idea. struct counter_device should not be
> embedded in the drivers state struct in the first place.

Just to mention it: My patch series didn't change this, this was already
broken before.

> struct counter_device contains a struct device, which is a reference coun=
ted
> object. But by embedding it in the driver state struct the life time of b=
oth
> the struct counter_device and and struct device are bound to the life time
> of the driver state struct.
>=20
> Which means the struct device memory can get freed before the last refere=
nce
> is dropped, which leads to a use-after-free and undefined behavior.

Well, the driver struct is allocated using devm_kzalloc for all drivers.
So I think it's not *very* urgent to fix. Still you're right, this
should be addressed.
=20
> The framework should be changed to rather then embedding the struct
> counter_device in the state struct to just have a pointer to it. With the
> struct counter_device having its own allocation that will be freed when t=
he
> last reference to the struct device is dropped.

My favourite would be to implement a counter_device_alloc /
counter_device_add approach, similar to what spi_alloc_controller and
alloc_etherdev do. The downside is that this isn't typesafe either :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--apqkyk5gu62tvk7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBvAsACgkQwfwUeK3K
7AkKxwf/eZMlm5W7BNNqhbv4to+2ASYVEhk+7+b6u4plF+l3ew+B0i0uhOD7DQnP
N520u6PRwJgIgIwVA12ciu6ohLlr7ObF2tkmcIZ2wka5HvY9xoWeR77cHmAtrS6e
oziMIs2//n85stSzMskek5imJo0Ow9eLT3Ee+fJxadHns8pe0SxmPsZnYGvkNot4
c0pLfLx4rEwZ6HDPCT/DvRCmRKFs0MEv9sTEYZV4x+EBMDmYfzSI8A+kxZe6mEKJ
NIwRhObAX0t7NzsMF8+HjIIPCxwX/vsE1aXpIbQezpEzUCsJ1IORbGziByuceBAt
G1O0rlMD5vtRt3Ey7EUFYY3XRaufJg==
=4FJC
-----END PGP SIGNATURE-----

--apqkyk5gu62tvk7i--
