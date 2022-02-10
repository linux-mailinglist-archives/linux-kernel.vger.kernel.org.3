Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D394B0A51
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiBJKJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:09:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiBJKJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:09:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED2FD6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:09:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nI6OZ-0001lk-IQ; Thu, 10 Feb 2022 11:09:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nI6OX-00FgT6-PY; Thu, 10 Feb 2022 11:09:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nI6OW-00EN0I-8N; Thu, 10 Feb 2022 11:09:44 +0100
Date:   Thu, 10 Feb 2022 11:09:44 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Qing Wang <wangqing@vivo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: use div64_u64() instead of do_div()
Message-ID: <20220210100944.ebkiezfablofqitj@pengutronix.de>
References: <1644395998-4397-1-git-send-email-wangqing@vivo.com>
 <20220209152609.gqeivcehkuzgz3sk@pengutronix.de>
 <9273cd6497354dd882faf55b194ff590@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y2i7qhj2ao7l5u5v"
Content-Disposition: inline
In-Reply-To: <9273cd6497354dd882faf55b194ff590@AcuMS.aculab.com>
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


--y2i7qhj2ao7l5u5v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 10, 2022 at 09:48:44AM +0000, David Laight wrote:
> From: Uwe Kleine-K=F6nig
> > Sent: 09 February 2022 15:26
> ...
> > > -	do_div(cycles, period_ns);
> > > +	div64_u64(cycles, period_ns);
> >=20
> > This is wrong, div64_u64() has a different calling convention than do_d=
iv().
> >=20
> > The issue however is real. Please add
>=20
> Not really although I can't see a check I'd assume that period_ns
> is expected to be much less than a second - so well under 32 bits
> There is certainly a general expectation that multiplying by
> other 'largish' values won't exceed 64 bits.

I'd consider such expectations a bug and hope to catch this type of
problem for new drivers. However I'm not surprised if you can point out
several such problems in the code base. Please fix at will :-)

> Plausible the pwm 'period' should actually be a u32.
> But then care would be needed to ensure the multiplies have
> 64bit results.

There are definitely consumers expecting to be able to set bigger
periods, see a9d887dc1c60ed67f2271d66560cdcf864c4a578.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y2i7qhj2ao7l5u5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIE5GQACgkQwfwUeK3K
7Al9NwgAk6OM7KdG3nsMvl8IKkiFnZyxKG7EO70mqkeXD387kU+iOvf+UpAEaMGx
itlqP/2akcfuwSvHAajqDH6LS2HLp7FRlcllYjlIXjuB1ZTBwtMjY3v1fL20mpfq
cr6nn6yYIZ3To+OUgxcBz/QORIh2E+HO6r4OxnVjd1Ov/+7ah/nTBeFk4Utrpnw9
yCIqEtgB7fUPqDOJI2v4KgQrxXgiOhJ9ZHP2SdpNdZ0Gm+TiGve49wP1Zy5Soghz
HO8GvcU9JqgOCoI7Pxxv69CcZyttAf8YuGY3+8kubIcJbaOwDtmSxSpnTsYZtnwL
KdeaNeTXYKzwGN+yoCOCDl7HLwwjFQ==
=J/um
-----END PGP SIGNATURE-----

--y2i7qhj2ao7l5u5v--
