Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9074BA553
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbiBQQDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:03:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiBQQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:03:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643A29C122
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:03:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKjFO-0008RC-Gu; Thu, 17 Feb 2022 17:03:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKjFO-00HCWI-57; Thu, 17 Feb 2022 17:03:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKjFM-003nMo-OE; Thu, 17 Feb 2022 17:03:08 +0100
Date:   Thu, 17 Feb 2022 17:03:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] counter: Stop using dev_get_drvdata() to get the counter
 device
Message-ID: <20220217160308.oo3fmghapnvmummz@pengutronix.de>
References: <YfzPcyusGwAOkys6@shinobu>
 <20220204082556.370348-1-u.kleine-koenig@pengutronix.de>
 <YgHKekl9rJ2jH5j4@shinobu>
 <b9099ac3-a5fa-1aba-92a3-05a7212525ab@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cacwzyoxhhr5s3za"
Content-Disposition: inline
In-Reply-To: <b9099ac3-a5fa-1aba-92a3-05a7212525ab@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cacwzyoxhhr5s3za
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 17, 2022 at 04:48:50PM +0200, Jarkko Nikula wrote:
> On 2/8/22 03:42, William Breathitt Gray wrote:
> > On Fri, Feb 04, 2022 at 09:25:56AM +0100, Uwe Kleine-K=F6nig wrote:
> > > dev_get_drvdata() returns NULL since commit b56346ddbd82 ("counter: U=
se
> > > container_of instead of drvdata to track counter_device") which wrong=
ly
> > > claimed there were no users of drvdata. Convert to container_of() to
> > > fix a null pointer dereference.
> > >=20
> > > Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > Fixes: b56346ddbd82 ("counter: Use container_of instead of drvdata to=
 track counter_device")
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > I'll pick this up and apply it to my tree.
>
> Perhaps late but I hit this same issue, patch here fixes it and I wanted =
to
> confirm it.
>=20
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

I wonder if this patch is scheduled for 5.17. Currently it's not even in
next ... :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cacwzyoxhhr5s3za
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIOcbgACgkQwfwUeK3K
7Al9DAf7BmCzN8GCJhWm+Pi2Leg79PGR5DyEoO8tk/Rkx072lzLH0PRMR19XpnYi
CHZDqP330L3y1rcIFL1PEqBd2n8G+FMgiMhfOQiQTjbip2x16VnlUYK6FZOHyv4O
p5t3Xuh7Yz5O6+K8VZwwC3sUxQAMfY1gV915/O6EeSx3PqrE3cK4fS6wv8AX1CgF
/XZf5n9WVWfnC6/du0y6E5qRFtWkThhDG9tZsOn9zuXQBjlxZuNvE3vg0zDQT4b1
S3LIkURZ2zgPxt0sNsebxU3IPxzm/XxDIk2T14telroXIwC/ysS6TvwLh3/fRCjD
JoYIEBvfUZonts9RowE6eP69A+lVRw==
=H9LW
-----END PGP SIGNATURE-----

--cacwzyoxhhr5s3za--
