Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DDA58ADC2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbiHEP4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241466AbiHEPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:55:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E3F62D1
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:55:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oJzfP-00026g-Om; Fri, 05 Aug 2022 17:55:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oJzfL-001vCS-6j; Fri, 05 Aug 2022 17:55:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oJzfM-009klO-RL; Fri, 05 Aug 2022 17:55:12 +0200
Date:   Fri, 5 Aug 2022 17:55:09 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com
Subject: Re: [PATCH] pwm: removes period check from pwm_apply_state()
Message-ID: <20220805155509.edqwxcvyoqfic4pn@pengutronix.de>
References: <CGME20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea@epcas5p2.samsung.com>
 <20220805101125.47955-1-m.shams@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xs6xr6e4bpqmmt22"
Content-Disposition: inline
In-Reply-To: <20220805101125.47955-1-m.shams@samsung.com>
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


--xs6xr6e4bpqmmt22
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Aug 05, 2022 at 03:41:25PM +0530, Tamseel Shams wrote:
> There may be situation when PWM is exported using sysfs,
> but at that point PWM period is not set. At this situation
> if we issue a system suspend, it calls pwm_class_suspend
> which in turn calls pwm_apply_state, where PWM period value is
> checked which returns an invalid argument error casuing Kernel
> to panic. So, check for PWM period value is removed so as to
> fix the kernel panic observed during suspend.

This looks and sounds wrong. One thing I would accept is:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0e042410f6b9..075bbcdad6c1 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -557,8 +557,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struc=
t pwm_state *state)
 	 */
 	might_sleep();
=20
-	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	if (!pwm || !state || state->enabled && (!state->period ||
+	    state->duty_cycle > state->period))
 		return -EINVAL;
=20
 	chip =3D pwm->chip;

That is, don't refuse calling pwm_apply_state() for state->period =3D 0
and even state->duty_cycle > state->period if the PWM is not enabled.

But anyhow, even without that the kernel should not panic. So I ask you
to research and provide some more info about the problem. (Which
hardware does it affect? Where does it panic? ...)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xs6xr6e4bpqmmt22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLtPVsACgkQwfwUeK3K
7AkyeggAlIF4i7X3hL+F6WL3ld2fObx/1FvrgJASGSAoNdEVn0srMhrNEhjZrugG
Bdy3IESIAp86OHLfMwyAbF+w1Ww/mXcTq8Me3BrRN5cN2D4mtm0J4Pm4q3A2K85x
JdTfOiUV6exqQZScwhvSym3YMPwZO2sRc2gY2idBZhO4PRrdpE/aiifN0IdGKIQx
kEA7TEQfPm2/ZQR0nHpIGte2TLX8YzyHkdeRbmmV3+JNO/ywi+YwXM+aA79g1qVL
MGCsBDB6HjCu4RMpCpIZbGTuy9Xv7zFomVdvSMd8xF5vB5Y63JxsW0/JGZ1eP7VJ
bNo40HqSbGyEDCgwAipnhdUV+mVW1g==
=56AU
-----END PGP SIGNATURE-----

--xs6xr6e4bpqmmt22--
