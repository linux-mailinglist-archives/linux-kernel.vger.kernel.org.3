Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2DC4BB388
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiBRHsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:48:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiBRHsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:48:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3A5193DE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 23:48:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKxzw-0000Iy-26; Fri, 18 Feb 2022 08:48:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKxzv-00HL0L-H7; Fri, 18 Feb 2022 08:48:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nKxzu-003vof-22; Fri, 18 Feb 2022 08:48:10 +0100
Date:   Fri, 18 Feb 2022 08:47:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] counter: Stop using dev_get_drvdata() to get the counter
 device
Message-ID: <20220218074751.3xjsxwy7s63jshwv@pengutronix.de>
References: <YfzPcyusGwAOkys6@shinobu>
 <20220204082556.370348-1-u.kleine-koenig@pengutronix.de>
 <YgHKekl9rJ2jH5j4@shinobu>
 <b9099ac3-a5fa-1aba-92a3-05a7212525ab@linux.intel.com>
 <20220217160308.oo3fmghapnvmummz@pengutronix.de>
 <Yg7de1ZlUJoNGYNa@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gk6av76w7atazn34"
Content-Disposition: inline
In-Reply-To: <Yg7de1ZlUJoNGYNa@shinobu>
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


--gk6av76w7atazn34
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Feb 18, 2022 at 08:42:51AM +0900, William Breathitt Gray wrote:
> On Thu, Feb 17, 2022 at 05:03:08PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Feb 17, 2022 at 04:48:50PM +0200, Jarkko Nikula wrote:
> > > On 2/8/22 03:42, William Breathitt Gray wrote:
> > > > On Fri, Feb 04, 2022 at 09:25:56AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > > dev_get_drvdata() returns NULL since commit b56346ddbd82 ("counte=
r: Use
> > > > > container_of instead of drvdata to track counter_device") which w=
rongly
> > > > > claimed there were no users of drvdata. Convert to container_of()=
 to
> > > > > fix a null pointer dereference.
> > > > >=20
> > > > > Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > > Fixes: b56346ddbd82 ("counter: Use container_of instead of drvdat=
a to track counter_device")
> > > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > >=20
> > > > I'll pick this up and apply it to my tree.
> > >
> > > Perhaps late but I hit this same issue, patch here fixes it and I wan=
ted to
> > > confirm it.
> > >=20
> > > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> >=20
> > I wonder if this patch is scheduled for 5.17. Currently it's not even in
> > next ... :-\
>=20
> I've got it in my tree. I'm sending a pull request for the Counter
> patches for 5.17 next week, so they should all be merged after that.

That's good. Still I think you could make live easier for your users to
find fixes if your tree was included in next. And in MAINTAINERS.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gk6av76w7atazn34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIPTyQACgkQwfwUeK3K
7AkP9gf/S6BMwB67/1roz71SeE8tT9n/ekVqdJlZwHY39kowGvEe9yhKjiDb6qqQ
25OVlDPItAE91aBCgcwRsuouDm7NFUJrATH0jrLEU+4PxR22NIkiLcfyHPHNTac/
dlZYjooIj+QGCPuZgwa0VGhG7b/O0pGV1z6UQrp7ujkBHTZ2VaPOkdpnX8QVMtLa
pM4YKvDZUfxqT7YEhUQNqfl7RJM24cpBrnVvnFUGak0quLGiN6Os/bc+ldKKmdpT
jZr8GvA08EHO6XMg+RW01Zd1JX02MnspiQlpRxPRz1iMc4BNZ4AOYBLsqNovcXb+
oagqCoL0D80XZMk4XRROHPQuqUP9Iw==
=JzKJ
-----END PGP SIGNATURE-----

--gk6av76w7atazn34--
