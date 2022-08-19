Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143D8599DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349396AbiHSOrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349128AbiHSOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:47:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC547ED03A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:47:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oP3HC-0003wt-2B; Fri, 19 Aug 2022 16:47:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oP3H9-000jRx-Q8; Fri, 19 Aug 2022 16:47:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oP3H9-00Ckm6-4a; Fri, 19 Aug 2022 16:47:07 +0200
Date:   Fri, 19 Aug 2022 16:44:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] pwm: Add support for the MSTAR MSC313 PWM
Message-ID: <20220819144453.4pegktwwargunlzl@pengutronix.de>
References: <20220615070813.7720-1-romain.perier@gmail.com>
 <20220615070813.7720-3-romain.perier@gmail.com>
 <20220619213520.qonqdv4e7zkvpeo7@pengutronix.de>
 <CABgxDo+_uZyO2vV4QxmVLTo2ohpAxzC89jcGJ3oksT6XxEBCmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gulr5uxr5zgvdp56"
Content-Disposition: inline
In-Reply-To: <CABgxDo+_uZyO2vV4QxmVLTo2ohpAxzC89jcGJ3oksT6XxEBCmA@mail.gmail.com>
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


--gulr5uxr5zgvdp56
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Romain,

On Fri, Aug 19, 2022 at 03:12:56PM +0200, Romain Perier wrote:
> Le dim. 19 juin 2022 =E0 23:35, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> a =E9crit :
> > > +static void msc313e_pwm_writecounter(struct regmap_field *low, struc=
t regmap_field *high, u32 value)
> > > +{
> > > +     regmap_field_write(low, value);
> > > +     regmap_field_write(high, value >> 16);
> >
> > Is this racy? E.g. if the hw is running and the low register overflows
> > before the high register is updated?
> >
>=20
> Ack, I am re-working most of the stuff you noticed. The problem with
> this IP blocks (and others...) is we have close registers
> but we only need to write or read 16 bits in each of these (it is
> mainly reverse engineered from vendor source or runtime most of the
> time) . You cannot really do a single read (except by doing an obscur
> thing via readq ? ...)

This is fine, but pleast document that in a comment.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gulr5uxr5zgvdp56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL/oeIACgkQwfwUeK3K
7AnLfAf/Q730KOcWvic9TGtU5LYxv/PYwKyDY+F+78jFpI+Q15r9ECURWXCeXVx8
Qr5883rCMEpqlcwUvP30Gosy0oFVvhAsZMg/Jq/BOQMJMyFwb8L7Dxw814dIeqdq
7K6BLh3PP9AjkqCH1d8l2PxsPmmovPASki2/olFnHrN/MQdzgN+bAow52Ua1Rj4k
7xdu3AQlhQf4O3ohpshUFxoxi+9lS9tcD+QSOxHoG5cXyQgC0UxMhhxEyu0ojiGJ
klX5Qw4oRmRm35cfupZhfitj00+RbF/VLeMY0sLqyYIKoGJbr+y5PEH4XSP4wmAS
MeyGeP0/BKsW8Awe3iK9F6urs60esA==
=+A3G
-----END PGP SIGNATURE-----

--gulr5uxr5zgvdp56--
