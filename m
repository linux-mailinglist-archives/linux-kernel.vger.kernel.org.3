Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AAD5996CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347434AbiHSIIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347470AbiHSIHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:07:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97FFE68D7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:07:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOx2m-00031g-JK; Fri, 19 Aug 2022 10:07:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOx2k-000g0P-Gz; Fri, 19 Aug 2022 10:07:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOx2j-00Chb8-U1; Fri, 19 Aug 2022 10:07:49 +0200
Date:   Fri, 19 Aug 2022 10:07:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com
Subject: Re: [PATCH v2] pwm: Fixes dpm_run_callback() error in
 pwm_apply_state()
Message-ID: <20220819080748.c2qprsddcvjb7vkx@pengutronix.de>
References: <CGME20220819044619epcas5p27ba774aacaa5d2a0056bba376b9dae54@epcas5p2.samsung.com>
 <20220819043459.32584-1-m.shams@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ufd7wqzuulu3quu"
Content-Disposition: inline
In-Reply-To: <20220819043459.32584-1-m.shams@samsung.com>
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


--2ufd7wqzuulu3quu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 19, 2022 at 10:04:59AM +0530, Tamseel Shams wrote:
> Return invalid argument error from pwm_apply_state()
> call when 'period is not set' or 'duty_cycle is greater
> than period' only when PWM is enabled, so as to fix the
> dpm_run_callback() error seen on exynos SoC during
> Suspend
>=20
> There may be situation when PWM is exported using sysfs,
> but at that point period is not set for PWM. At this
> point if we do suspend, then during pwm_apply_state
> function call from pwm_class_suspend, it checks whether
> period is set or not. It is not set now, so it returns
> an invalid argument error which issues dpm_run_callback()
> error
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>

I still consider this a band aid and I think there is need for prudence
here. Did you verify that all lowlevel drivers handle a state that is
now allowed in a sane way? If you did, you missed at least
pwm-bcm2835.c, I guess there are more but I stopped checking.

So while this change might make sense in the future, I think it's wrong
to do it now.

I stand to the request to find out why pwm->state is strange. Maybe you
just have to fix your .get_state() callback.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2ufd7wqzuulu3quu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL/RNEACgkQwfwUeK3K
7AmK1wf/VNuYaNLZvpltnb55FdNVkUyi3cKwn6hMcycHd15o0ZIWFiBX+eI1+XKS
gLEi6ax4G2UvPUwtedAt9Syumibd2Fcm6Sf8P3u/IBT9haqwOmNGrAUbHqXobSh5
Wd5rMyYIRL7lY5GYx4Cx6NWrjAxWqdc6RwtfudEbjYdYCNQ5RfDHTAWo18aKd3N+
+fEKVG2LSK1L0rpo1b5F2UZNk/oIELCEO8Ua3aBsMsrVEOYQoX1BH7JChGAy7zSi
9oMh5gbdCn8LNxiBk7FaWwh0RqjSWTR94MzWlgO8FcfKARU3ALbO+joQkObyK5Du
DjrgdxNAPUUUE5eP51EwOac1ZdY8ow==
=GZXz
-----END PGP SIGNATURE-----

--2ufd7wqzuulu3quu--
