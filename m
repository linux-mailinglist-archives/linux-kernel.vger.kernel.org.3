Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEA550E72B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244091AbiDYR2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbiDYR1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B840E74
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:24:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nj2RK-0007xm-MT; Mon, 25 Apr 2022 19:23:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nj2RJ-005BoB-Kh; Mon, 25 Apr 2022 19:23:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nj2RH-005ZQu-FS; Mon, 25 Apr 2022 19:23:55 +0200
Date:   Mon, 25 Apr 2022 19:23:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Yihao Han <hanyihao@vivo.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH] macintosh: macio_asic: fix resource_size.cocci warnings
Message-ID: <20220425172350.fggwi7a76v5d6cbh@pengutronix.de>
References: <20220414140304.82751-1-hanyihao@vivo.com>
 <87zgkd8vnb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y36m4bm5lfadd555"
Content-Disposition: inline
In-Reply-To: <87zgkd8vnb.fsf@mpe.ellerman.id.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y36m4bm5lfadd555
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Fri, Apr 22, 2022 at 04:44:24PM +1000, Michael Ellerman wrote:
> Yihao Han <hanyihao@vivo.com> writes:
> > -		if (index =3D=3D 0 && (res->end - res->start) > 0xfff)
> > +		if (index =3D=3D 0 && (resource_size(res)) > 0xfff)
> >  			res->end =3D res->start + 0xfff;
> > -		if (index =3D=3D 1 && (res->end - res->start) > 0xff)
> > +		if (index =3D=3D 1 && (resource_size(res)) > 0xff)
>=20
> Are you sure the conversion is correct? It's not exactly equivalent:
>=20
> static inline resource_size_t resource_size(const struct resource *res)
> {
> 	return res->end - res->start + 1;
> }

Indeed. I pointed out this issue in the v2 that already hit my inbox.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y36m4bm5lfadd555
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJm2SMACgkQwfwUeK3K
7AmYawf/QfGR/l+1FYITPyljtHxUcmS2QItRhRWCUUYh3GfjAbISpfA4QpCoQ+FV
WrQ8w0FW6XEbi5mXqI71rsL6jLQjRB9dheQYapd7JXuL1Q8Vtzr0UaOBmksGWKLH
RCAOvlqfTBMMcR17vsYoo1DQlrE0721MAilie6JcbCBzmV376tRsox+p2Bcuc0Xo
19T9Od9nMz79J6wBsOXccAwqc9UUlaxAfth2nxJyQbTtn1OBLtEztz8nf3+Y9VGo
CIj/3UBriHrGFUH/LVtFuAZwncErTxwUk6wcesgNUJNNSUJylLTfRarjZ+cHXlZr
Zu/WQOBr2X9h7xo73uriTK9lfqIw4Q==
=zCfi
-----END PGP SIGNATURE-----

--y36m4bm5lfadd555--
