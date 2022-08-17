Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B94596846
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiHQEnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiHQEnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:43:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730FE30543
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:43:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOAtx-0006b6-U7; Wed, 17 Aug 2022 06:43:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOAtu-000FNH-Bx; Wed, 17 Aug 2022 06:43:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOAtt-00CFLx-NH; Wed, 17 Aug 2022 06:43:29 +0200
Date:   Wed, 17 Aug 2022 06:43:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: build failure after merge of the input tree
Message-ID: <20220817044326.nipebrbed4uct5or@pengutronix.de>
References: <20220817100007.2827652a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ws6dzw3nxvyrp6ex"
Content-Disposition: inline
In-Reply-To: <20220817100007.2827652a@canb.auug.org.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ws6dzw3nxvyrp6ex
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Aug 17, 2022 at 10:00:07AM +1000, Stephen Rothwell wrote:
> After merging the input tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/input/misc/ibm-panel.c:195:19: error: initialization of 'void (*)=
(struct i2c_client *)' from incompatible pointer type 'int (*)(struct i2c_c=
lient *)' [-Werror=3Dincompatible-pointer-types]
>   195 |         .remove =3D ibm_panel_remove,
>       |                   ^~~~~~~~~~~~~~~~
> drivers/input/misc/ibm-panel.c:195:19: note: (near initialization for 'ib=
m_panel_driver.remove')
>=20
> Caused by commit
>=20
>   95331e91e9da ("Input: Add IBM Operation Panel driver")
>=20
> interacting with commit
>=20
>   ed5c2f5fd10d ("i2c: Make remove callback return void")
>=20
> from v6.0-rc1.

I was a bit irritated by the "from v6.0-rc1" part and I feared that I
missed a driver in the conversion of the remove callback. But both
commits happen after v6.0-rc1, so everything is fine and as expected.

> I have applied the following merge fix patch for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 17 Aug 2022 09:54:11 +1000
> Subject: [PATCH] Input: fix up for "i2c: Make remove callback return void"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/input/misc/ibm-panel.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/input/misc/ibm-panel.c b/drivers/input/misc/ibm-pane=
l.c
> index 54c657cd7809..094bcdb568f1 100644
> --- a/drivers/input/misc/ibm-panel.c
> +++ b/drivers/input/misc/ibm-panel.c
> @@ -174,11 +174,9 @@ static int ibm_panel_probe(struct i2c_client *client,
>  	return 0;
>  }
> =20
> -static int ibm_panel_remove(struct i2c_client *client)
> +static void ibm_panel_remove(struct i2c_client *client)
>  {
>  	i2c_slave_unregister(client);
> -
> -	return 0;
>  }

That looks right. Wolfram created a tag for the conversion that can be
pulled into the input tree at

	https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/make_rem=
ove_callback_void-immutable

=2E

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ws6dzw3nxvyrp6ex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL8cesACgkQwfwUeK3K
7Alg/Qf8CXpTnbNaoHvh7pyaVr1dQrT5A8rB1GPVJPMVBcfabr+KTZucy57jO4mH
f8P6WPIfDRiOJoxxnUY02twzQMnfRZ80luW9mXQbdKbEQOAJHgKRDhDT2iMvMxOk
T/ea+By0p9Mum8tLibb52M9kSpemX/+FSoqqJujs+H95hcJIZpt4+24sarLLbeTM
nSwoZdDcJ3sgoc0famGlBufnkPsm2e/dtliWRmSeBh3Mp5yRsI1T1011d2hbluEk
00uHo0QRiTxFG07oYcyd2GK54xl63q6e42KT26VJK8fVZecUkQtrESv1YcHcsFUE
Dem5TGef60twPl2DBoqCu7MZ0zHEkA==
=XAdE
-----END PGP SIGNATURE-----

--ws6dzw3nxvyrp6ex--
