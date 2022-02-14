Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF564B52C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354921AbiBNOHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:07:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354900AbiBNOGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:06:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF009A1AE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:06:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJc04-0008CA-9v; Mon, 14 Feb 2022 15:06:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJc01-00GZ3m-7U; Mon, 14 Feb 2022 15:06:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJbzz-0038PK-5F; Mon, 14 Feb 2022 15:06:39 +0100
Date:   Mon, 14 Feb 2022 15:06:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mfd: stmfx: Improve error message triggered by regulator
 fault in .remove()
Message-ID: <20220214140639.jmdldyne6ffq4dlq@pengutronix.de>
References: <20220207081709.27288-1-u.kleine-koenig@pengutronix.de>
 <YgpdPTDurgsvR9mk@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s563op37ko4b4dy6"
Content-Disposition: inline
In-Reply-To: <YgpdPTDurgsvR9mk@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s563op37ko4b4dy6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 01:46:37PM +0000, Lee Jones wrote:
> On Mon, 07 Feb 2022, Uwe Kleine-K=F6nig wrote:
>=20
> > Returning a non-zero value in an i2c remove callback results in the i2c
> > core emitting a very generic error message ("remove failed (-ESOMETHING=
),
> > will be ignored") and as the message indicates not further error handli=
ng
> > is done.
> >=20
> > Instead emit a more specific error message and then return zero in
> > .remove().
> >=20
> > The long-term goal is to make the i2c remove prototype return void, mak=
ing
> > all implementations return 0 is preparatory work for this change.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/mfd/stmfx.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
> > index e095a3930142..16631c675f2f 100644
> > --- a/drivers/mfd/stmfx.c
> > +++ b/drivers/mfd/stmfx.c
> > @@ -392,17 +392,21 @@ static int stmfx_chip_init(struct i2c_client *cli=
ent)
> >  	return ret;
> >  }
> > =20
> > -static int stmfx_chip_exit(struct i2c_client *client)
> > +static void stmfx_chip_exit(struct i2c_client *client)
> >  {
> >  	struct stmfx *stmfx =3D i2c_get_clientdata(client);
> > =20
> >  	regmap_write(stmfx->map, STMFX_REG_IRQ_SRC_EN, 0);
> >  	regmap_write(stmfx->map, STMFX_REG_SYS_CTRL, 0);
> > =20
> > -	if (stmfx->vdd)
> > -		return regulator_disable(stmfx->vdd);
> > +	if (stmfx->vdd) {
> > +		int ret =3D regulator_disable(stmfx->vdd);
> > =20
> > -	return 0;
> > +		if (ret)
>=20
> Nit: Premise of the patch is fine, but please can you use the standard
> function call, check the return value format please.  Something about
> this is triggering my OCD! :)
>=20
>      	int ret;
>=20
> 	ret =3D regulator_disable(stmfx->vdd);
> 	if (ret)
> 		do_thing();

Not sure I understand you correctly. Do you want just:

 	regmap_write(stmfx->map, STMFX_REG_SYS_CTRL, 0);
=20
 	if (stmfx->vdd) {
-		int ret =3D regulator_disable(stmfx->vdd);
+		int ret;
+
+		ret =3D regulator_disable(stmfx->vdd);
 		if (ret)
 ...

squashed into the patch?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s563op37ko4b4dy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIKYesACgkQwfwUeK3K
7Am/agf+Ox1j1cOxSuGwS+XoEjW3j9S/sI2S+1HQq/TZ5DMu7yrdIcQm+m157Xeh
SXiqNFcmVbXHvSU+r8gQtq1nInt6JFwjpFLdt+K/aUPPOZUsxug+3CgL+zTTnhm+
qBVhvWTGQoZ3tkxz4Ja4oSACEiYOHiM2NhQe3GVAFXNas6jwvZGDf6wBcwLhvQhK
am4yU8fWiiV/Wa5m1OGRB+ELOBaooi4hagB0WZVviHo1LFhQXu+o/q8gV1X7xdAN
f/4+8al/jfZJp5dkJGbj0fWPncQ7T0dZYtYvdSDAc6sapNWYlF9l0saS+r8iZbfb
AGWtHFSKo8ukP4MdGWnoZaIaDWlrEA==
=RA9W
-----END PGP SIGNATURE-----

--s563op37ko4b4dy6--
