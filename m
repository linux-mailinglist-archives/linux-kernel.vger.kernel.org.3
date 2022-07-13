Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB9573175
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiGMIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiGMIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:47:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06FBCAF32
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:47:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBY24-0005VK-2O; Wed, 13 Jul 2022 10:47:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBY23-000fwn-C7; Wed, 13 Jul 2022 10:47:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBY22-004tkv-Pc; Wed, 13 Jul 2022 10:47:42 +0200
Date:   Wed, 13 Jul 2022 10:47:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: pm_runtime_resume_and_get in .remove callbacks
Message-ID: <20220713084739.j4cqab6rfz22nlko@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sljz5pfr44yhpo7a"
Content-Disposition: inline
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


--sljz5pfr44yhpo7a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

there is a big bunch of kernel drivers (here:
drivers/i2c/busses/i2c-sprd.c) that have a remove callback that looks as
follows:

	static int sprd_i2c_remove(struct platform_device *pdev)
	{
		struct sprd_i2c *i2c_dev =3D platform_get_drvdata(pdev);
		int ret;

		ret =3D pm_runtime_resume_and_get(i2c_dev->dev);
		if (ret < 0)
			return ret;

		i2c_del_adapter(&i2c_dev->adap);
		clk_disable_unprepare(i2c_dev->clk);

		pm_runtime_put_noidle(i2c_dev->dev);
		pm_runtime_disable(i2c_dev->dev);

		return 0;
	}

If pm_runtime_resume_and_get fails, the i2c adapter isn't removed, but
as the memory backing i2c_dev goes away---it was allocated using
devm_kzalloc in .probe()---the next i2c action will probably access
freed memory.

I'm not familiar enough with pm-runtime stuff, but wonder what
can/should be done about that. The obvious (to me) candidates are:

 - log an error if pm_runtime_resume_and_get() fails, but continue to
   clean up
 - don't check the return value at all

What do you think?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sljz5pfr44yhpo7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLOhqkACgkQwfwUeK3K
7AmBHgf9FxMDSG2bONpQJNckJV1EyE8zqwOj8gHt7bZBKlSakCbbiSvXBnDX3InL
au2oWAXwuXzdtwH1XmzUhTi5SGaGMWBlHbb491ul++FV2OAaok68mLb35MJ2UMWL
mPk7lU7HHRwQEEnRzhvPuD43b7sPhR95KaJiDMLnCmSwxZdv0mCg9V+A+/0uedy3
EmB5w3BwRwCIHdoQbCT8J7SxccaKxxt6hQIX5rzTjaXgDUL9mxLLb1J86l4J2c1u
tk6EEs+yxZHYVPKaB7cXEx4PfjuKrOfeYaoNK/BsF+ND7ngqiab1Gi9tStHhe7D+
ZEulW9z7Yi/Vn4xLroUohv7V5s+r/A==
=jlTd
-----END PGP SIGNATURE-----

--sljz5pfr44yhpo7a--
