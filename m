Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD8A480893
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhL1K4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhL1K4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:56:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCD3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:56:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2A9c-0000Pd-2N; Tue, 28 Dec 2021 11:56:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2A9Z-00767t-I2; Tue, 28 Dec 2021 11:56:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2A9Y-0001YW-Fb; Tue, 28 Dec 2021 11:56:24 +0100
Date:   Tue, 28 Dec 2021 11:56:21 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Raymond Tan <raymond.tan@intel.com>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 17/23] counter: intel-qep: Convert to new counter
 registration
Message-ID: <20211228105621.3mfrvwlkj4n5qhar@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-18-u.kleine-koenig@pengutronix.de>
 <162c710f-4fa2-1cb4-e332-83e33e510e42@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s76ubklshzglq5px"
Content-Disposition: inline
In-Reply-To: <162c710f-4fa2-1cb4-e332-83e33e510e42@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s76ubklshzglq5px
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 05:02:39PM +0200, Jarkko Nikula wrote:
> On 12/27/21 11:45, Uwe Kleine-K=F6nig wrote:
> > This fixes device lifetime issues where it was possible to free a live
> > struct device.
> >=20
> > Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder=
 Peripheral")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >   drivers/counter/intel-qep.c | 28 ++++++++++++++++------------
> >   1 file changed, 16 insertions(+), 12 deletions(-)
> >=20
> Should the Fixes tag rather be b6c50affda59 ("counter: Add character devi=
ce
> interface") instead of when each drivers were introduced? I mean was it
> possible to hit the issue before /dev/counter was introduced?

I'm not sure if there is an issue before this, but it was already wrong
before for sure. Maybe it's possible to hold a reference somehow via
sysfs?

The thought that made me tag the individual driver commits was: With the
approach used to fix the issue all drivers need to be modified and an
unconverted driver doesn't benefit from the availability of
counter_alloc() / counter_add() if it isn't used. So all trees that
include b711f687a1c1 but not "counter: intel-qep: Convert to new counter
registration" are broken (more or less exploitable). So I think the
added Fixes line is the right choice.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s76ubklshzglq5px
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHK7VEACgkQwfwUeK3K
7Am7uwgAijWYzC6uycCmk8uRZHAtDVQbiHIogJeBYPl41chd2R6+cJga7T+eyEiT
W0hBfnyroNAoVM4nEJd883goCMMDEzGOfLYJEJ/QiYrDbYJBbI+rV0WyJhtutICb
huLc7WrhLNNCAIOJMAT/ApHiCjB6+PRGKs+YBKRgnv3FSYUKttnEnnWpmfV0iJ7r
Mr2osLj4Sc3ijVu/Tiyg5wrHZT1Vtyfhlk8A/kiQYtNPCBDiNWVWrfb/zrbKfkSS
k2T+1I8OXwuhS7TD89YEic8wfGlAka9akvfbOUPLGs0L7zdJG5mnNMbrYQkieVXg
mPI0b0ZzaKxoai7H4jQbB+rBP4+qLQ==
=qwU+
-----END PGP SIGNATURE-----

--s76ubklshzglq5px--
