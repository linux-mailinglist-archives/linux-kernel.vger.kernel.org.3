Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652984808AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 12:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhL1LG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 06:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhL1LG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 06:06:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6080AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 03:06:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2AJE-00012s-8H; Tue, 28 Dec 2021 12:06:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2AJD-00768q-U7; Tue, 28 Dec 2021 12:06:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2AJC-00023U-Ui; Tue, 28 Dec 2021 12:06:22 +0100
Date:   Tue, 28 Dec 2021 12:06:20 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 15/23] counter: 104-quad-8: Convert to new counter
 registration
Message-ID: <20211228110620.ix6ytcwvijtcyknx@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-16-u.kleine-koenig@pengutronix.de>
 <406d627c-5eb3-b052-6d91-e37933584ed1@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ijj47sjw3b4p4phw"
Content-Disposition: inline
In-Reply-To: <406d627c-5eb3-b052-6d91-e37933584ed1@metafoo.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ijj47sjw3b4p4phw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 01:19:25PM +0100, Lars-Peter Clausen wrote:
> On 12/27/21 10:45 AM, Uwe Kleine-K=F6nig wrote:
> > [...]
> > -	return devm_counter_register(dev, &priv->counter);
> > +	err =3D devm_counter_add(dev, counter);
> > +	if (err < 0)
> > +		return dev_err_probe(dev, err, "Failed to add counter\n");
> I wonder if we should put that dev_err_probe into the devm_counter_add si=
nce
> every driver wants to have it anyway.

Personally I'm not a big fan of API functions that emit an error
message. Usually the consumer knows best if a certain failing function
call is worth an error message. Look at platform_get_irq() that some
time ago got a dev_err call. The result was to introduce a
silent variant (platform_get_irq_optional()) because emitting an error
message isn't the right thing in all cases.

Also the API function probably won't call
device_set_deferred_probe_reason() and so the consumer has to care for
that anyhow (or not which makes -EPROBE_DEFER problems harder to debug).

Furthermore the consumer can emit in some cases a better error message
than the core. (Well, this doesn't apply here, but in the example of
platform_get_irq() the driver knows the irq's purpose and can call it
"TX irq" in the error message which the irq core cannot.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ijj47sjw3b4p4phw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHK76gACgkQwfwUeK3K
7AkfKAf/SsycJVBFMdkN9iVoAhttZlDwcJ/4RqRTfd4oBsaFqYJoqR/p51HZkHJ9
n0fTx940wEdIpNvT4Ot3wLaNdTT03krMPD6xQxd0IpLjXHn8mv0gqShI9ea9P8Jm
Rk4VjIk3FWGN1Dh6AJSOvjQzrSsfcislsM4pBomz9ppI4g7KIE26Zts1FzrHVbeu
A4JoMqqBXpNtV6RRgod/G44SVz9WCz/V4djtycoTEMnyk1nCXbQVrS0xIgiNWTQ0
nRUlPxzXEljSbgT86vjRlHzZdk3e1IOGGO34ydnvftDZzMbHnZYOPdNJGiiyAqgL
7NrPrdSzurGs4Vg8T6i3lvzp1SG7Tg==
=5fdN
-----END PGP SIGNATURE-----

--ijj47sjw3b4p4phw--
