Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905684C2AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiBXLYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiBXLY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:24:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5C11A2770;
        Thu, 24 Feb 2022 03:23:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 97A8B1F44FB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645701836;
        bh=HKEFix4GkDiBE7vMgSvlI5wTNNue/Pp34ssWEuhzbVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mB/Xanm/ej3+lCb0QZDl2BMFwaZjR+Oer4hMI1uEsj7V/MgRI9TE12pfcfcysVytH
         h0bz9LWkw0Kv040t9l2PS3TxWKt7j4a0MXpoGRt4QDP4UTTAavry0fTJwCzUUPkoIs
         QTMSLAA9S9/gLvsH4qW0kAypzwpCpYwT9IkY8cYK04IAGubNWT780VAA9xnE1hRYAh
         B8Ef66ikxzJ5K1Shaqxwt4dcVgwlqcWRpllhn7HzxyYNKqKfIV4aOWrYgm2vx4tK6T
         AX6OCGF5r4CZF1nggtg7BsfcjEExIkWC0AS0nUDZKCnWIahVY5rOqJFL3lRVzga8rH
         yKckX5SwPE6fA==
Received: by mercury (Postfix, from userid 1000)
        id 7F242106049B; Thu, 24 Feb 2022 12:23:54 +0100 (CET)
Date:   Thu, 24 Feb 2022 12:23:54 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: max8997_charger: Use
 devm_work_autocancel()
Message-ID: <20220224112354.stx4ssnd2b3gpuvp@mercury.elektranox.org>
References: <1404087e1f99dfb5e5d59ee29f477a2f2d960bb8.1644751133.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rv545c23ig3nqa6d"
Content-Disposition: inline
In-Reply-To: <1404087e1f99dfb5e5d59ee29f477a2f2d960bb8.1644751133.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rv545c23ig3nqa6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 13, 2022 at 12:19:31PM +0100, Christophe JAILLET wrote:
> Use devm_work_autocancel() instead of hand writing it.
> It saves a few lines of code.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max8997_charger.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/suppl=
y/max8997_charger.c
> index 25207fe2aa68..127c73b0b3bd 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -14,6 +14,7 @@
>  #include <linux/mfd/max8997.h>
>  #include <linux/mfd/max8997-private.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/devm-helpers.h>
> =20
>  /* MAX8997_REG_STATUS4 */
>  #define DCINOK_SHIFT		1
> @@ -94,13 +95,6 @@ static int max8997_battery_get_property(struct power_s=
upply *psy,
>  	return 0;
>  }
> =20
> -static void max8997_battery_extcon_evt_stop_work(void *data)
> -{
> -	struct charger_data *charger =3D data;
> -
> -	cancel_work_sync(&charger->extcon_work);
> -}
> -
>  static void max8997_battery_extcon_evt_worker(struct work_struct *work)
>  {
>  	struct charger_data *charger =3D
> @@ -255,8 +249,8 @@ static int max8997_battery_probe(struct platform_devi=
ce *pdev)
>  	}
> =20
>  	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
> -		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
> -		ret =3D devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_wo=
rk, charger);
> +		ret =3D devm_work_autocancel(&pdev->dev, &charger->extcon_work,
> +					   max8997_battery_extcon_evt_worker);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to add extcon evt stop action: %d\n", ret=
);
>  			return ret;
> --=20
> 2.32.0
>=20

--rv545c23ig3nqa6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIXasoACgkQ2O7X88g7
+popUw//YTAwx8lGhfWzQqgzs3B1XI1qUi5taMfkMQXbR/+eGytRwt/tyJ6XUzc5
9twn3U6Zq6HIMkoQiYrUAf/7UpRZh1OxKjykPCOSHadyEf+Yx5MuMkOz9uEAu5zA
1jC3IKFLKYhm/y7RAI0sE+9oXKoRy1ccVMkcZY9/I/fUhHKX2oAH0r0SHdbkSN6k
qD1MiWYsJBET6glVkDp3WAJ18Qfd9pU8pH1/qv4HhvAbR2n05uQ9uQVicnh3T8F9
hAKufjoGdaK1Lf3r3mDJtxVvYHLrlzjhrwVh9IS6ShaZDatdnfNj/bpsR3XGrRsM
Ldkqk83/v+x07TqWZp43LyPFagmBeMa49Bd9xc4KQqDJZgieuhzf8BoxF+IIozXg
Mi5vCyfpTwNcAUCQ749j2HOWOWzNiMPjt1WKnoG9Pq0s7Wg6SS61fhA68emQkG+0
fpuImVjv8ensqOVt21rQFq9fnugOodlXnTxGMUSXMf/cbGdc9Yd8835C0zbj+U0X
Ou8Qc6zwQpbvPupJW2OLhhvdfhxam0EzlBtYDLmrDc5uNSmLEmdeA35DkpmLSQMT
CjNDlntoWevhK/wRFx3h0stStLxzLqW2PJ9rKAayxRK2p1dx/TBTO5It/yyeCctz
9A1rt7dzWpCBrtw95ONG5BFAFk3fivipGV7A2Tu6Rcr+g7ERAT4=
=wUFD
-----END PGP SIGNATURE-----

--rv545c23ig3nqa6d--
