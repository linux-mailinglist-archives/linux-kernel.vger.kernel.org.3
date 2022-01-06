Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05F6486696
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbiAFPO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240346AbiAFPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:14:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AF2C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 07:14:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n5UT6-0006jK-MO; Thu, 06 Jan 2022 16:14:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n5UT6-008oNH-6w; Thu, 06 Jan 2022 16:14:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n5UT5-0005yt-63; Thu, 06 Jan 2022 16:14:19 +0100
Date:   Thu, 6 Jan 2022 16:13:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 00/23] counter: cleanups and device lifetime fixes
Message-ID: <20220106151355.d4ogjpo3y5qnkrgs@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <YdWOkn2Gtd7FSYmR@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jxec66yc4jlaswjp"
Content-Disposition: inline
In-Reply-To: <YdWOkn2Gtd7FSYmR@shinobu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jxec66yc4jlaswjp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 05, 2022 at 09:26:58PM +0900, William Breathitt Gray wrote:
> On Wed, Dec 29, 2021 at 04:44:18PM +0100, Uwe Kleine-K=F6nig wrote:
> >  - I think intel-qep.c makes the counter unfunctional in
> >    intel_qep_remove before the counter is unregistered.
>=20
> Hello Uwe,
>=20
> Would you elaborate some more on this? I think intel_qep_remove() is
> only called after the counter is unregistered because the struct
> counter_device parent is set to &pci->dev in intel_qep_probe(). Am I
> misunderstanding the removal path?

If the counter device is unbound (e.g. via sysfs), the following calls
are made:

	intel_qep_remove() (stopping the hardware?)
	devm_counter_release (devm callback of devm_counter_register or ..._add)
	then the release callbacks of the earlier devm functions

My concern is, that in the timeslot between intel_qep_remove() and
devm_counter_release() the device looks like a functional device and
might be queried/reconfigured/... while the hardware is already dead.

It's probably not a big issue (unless for example reading the counter
this race window makes the hardware hang?), but it's at least ugly.
Maybe the worst effect is that a counter value is missed (which is OK at
unregister time). Still it would be nicer to first take down the counter
device and only then stop the hardware.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jxec66yc4jlaswjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHXByoACgkQwfwUeK3K
7AlBJgf+Nbzmm7XXPcWM7auKes2hySGGhU5UfmlLbmulrmatVNuSO4r+4ucNP7Mk
ffadE0d0xjCEw0e83P1Oae89yVEVCjRElgJWgqUMTKHDnL30agDSdP5NaHfOt8kB
UjNBA91Yb1ksnhMkZTai8D8rLgqkrnqHU+ehr+V1p5PRL9IwSeQYUobRADJxGaqG
Rd/iyKeeZA+ZLu4DCsOWY9wAuxrJXM91mKyMlkv+/MFbi3k3ljYppm4ndpfJbqU6
dMTsIRa1dHVdLbh0CgXnBq/oI1qJIXPf2TcC9v5VGnEE50yI894djMAqtdQJpP20
KOhu/emXrsuMxQGCCvdxk/mIlJur0Q==
=4L9X
-----END PGP SIGNATURE-----

--jxec66yc4jlaswjp--
