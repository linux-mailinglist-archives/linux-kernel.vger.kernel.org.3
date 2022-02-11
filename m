Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3AE4B2D24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiBKSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:50:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiBKSu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:50:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9FC57;
        Fri, 11 Feb 2022 10:50:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 817AB1F471E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644605425;
        bh=z5Y7H7AbhHGrr2+6Fd/VUKLNGY2yIpGwppm+Gh8m0BY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTLAmGBNezkyowIHaR9JgbiqZSun9A6ZGgrwcEVqzHUL8SOGdJFb0FcHq4qH8oPse
         0B4buTpJFCSlI63wWoYLGe9DrDtvUTKwVhZtVYMx6v/8dTTVJ9hQZWlIBDDJCPr7wM
         2O9ehu0ed8pXeF4VpuV/xQxfujgHo/atldc3PuHPsPrUc7j3QTYqesAeX6AkV4vt5A
         eqSnObTxDAb0firFJJr/3BYx/qvM2Fvv/UHoI5Kp0C2/lDf0RWrQBBrs0fj8yap/D5
         5doJOI6mjk5x5Kle17DPrMs5t0PMxiyu76Ph6jdsU4WN+M0ntWHnMFvIA8gavPafos
         tZoo9yJB0Vrkg==
Received: by mercury (Postfix, from userid 1000)
        id 4E7541060908; Fri, 11 Feb 2022 19:50:23 +0100 (CET)
Date:   Fri, 11 Feb 2022 19:50:23 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Simplify memory allocation
Message-ID: <20220211185023.rlfriafztikcqdmq@mercury.elektranox.org>
References: <c09fc0b84cb046ad31bc1da67607bf0e9fa07085.1644079229.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gxjcjuzgqukouwgs"
Content-Disposition: inline
In-Reply-To: <c09fc0b84cb046ad31bc1da67607bf0e9fa07085.1644079229.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gxjcjuzgqukouwgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 05, 2022 at 05:40:57PM +0100, Christophe JAILLET wrote:
> Use devm_bitmap_zalloc() instead of hand writing it.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_hwmon.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index bffe6d84c429..a48aa4afb828 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -324,11 +324,6 @@ static const struct hwmon_chip_info power_supply_hwm=
on_chip_info =3D {
>  	.info =3D power_supply_hwmon_info,
>  };
> =20
> -static void power_supply_hwmon_bitmap_free(void *data)
> -{
> -	bitmap_free(data);
> -}
> -
>  int power_supply_add_hwmon_sysfs(struct power_supply *psy)
>  {
>  	const struct power_supply_desc *desc =3D psy->desc;
> @@ -349,18 +344,14 @@ int power_supply_add_hwmon_sysfs(struct power_suppl=
y *psy)
>  	}
> =20
>  	psyhw->psy =3D psy;
> -	psyhw->props =3D bitmap_zalloc(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG + 1,
> -				     GFP_KERNEL);
> +	psyhw->props =3D devm_bitmap_zalloc(dev,
> +					  POWER_SUPPLY_PROP_TIME_TO_FULL_AVG + 1,
> +					  GFP_KERNEL);
>  	if (!psyhw->props) {
>  		ret =3D -ENOMEM;
>  		goto error;
>  	}
> =20
> -	ret =3D devm_add_action_or_reset(dev, power_supply_hwmon_bitmap_free,
> -			      psyhw->props);
> -	if (ret)
> -		goto error;
> -
>  	for (i =3D 0; i < desc->num_properties; i++) {
>  		const enum power_supply_property prop =3D desc->properties[i];
> =20
> --=20
> 2.32.0
>=20

--gxjcjuzgqukouwgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGr+4ACgkQ2O7X88g7
+pqD/hAAlTOwH+tao52Dgjz43ftnSbyspe5+PUkdr/Ut4g0aHSozl/Ae7oZmTan8
5374ui7A9HiRr1JLxME/4FPAi2zoXZTwZoUZcdOY3OgWnyOyNEwJ7QZsAv69Ga2D
ejSEUyAYSvImrfBssXK/WX6mlBnUsS7UVe5SnQPQR/EPBaKqX7W8ojZD78JgmHuV
ucAfIOzM2I9nM6rqcHAlHu17ZKp5EbAlE+xcOSwBHq/Kq25p1RX5Bu7XxBO0FFhw
sbvInVBjMtdhV6L4+qASIp1ieE/GAsHS8WUFDX7dWKPMyuTW8zKVRg4p2Pt0XvYH
ngRWxju2W35CX/PZeBPn0fbpjhErGPR3OjpwCYBrUi4QH2brwvoFl58J3G4VgFe8
B7Br4kQ4SKc/k2S9vco9614pOxrjrebYiLAn9MZHjefaz/QyN2V343ACiJ/79mX+
iJl1StiOfPWs6vt+DW69w8fxDgzddAx7dKsQDowVdILH6VL4pBzuHMqNojiY6q+9
N2gp/TJ5NhYysLsQlKOsjR1p/O+LGLqiIZCTrbjM2Gv0xIEoAddtpZUbz1Eoru6y
IM5HYEqE/wNs9om1UpdGwqCjmA963VQQjhoY5Ls0Jx/5sGVDT/bpPftW+fax/ADx
9uNyp5KQBZo0zce0MSkFvBx0ME44BGb3ZVuTjIWkMo1QrDGLaNE=
=wwTK
-----END PGP SIGNATURE-----

--gxjcjuzgqukouwgs--
