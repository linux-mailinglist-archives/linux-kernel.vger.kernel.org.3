Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1049054563C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbiFIVLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFIVLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:11:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BADA98A7;
        Thu,  9 Jun 2022 14:11:31 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3979C6601691;
        Thu,  9 Jun 2022 22:11:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654809090;
        bh=iY1VOb8E7ORtMRxrDinmF/E6sgbCA/dJexyuWmvK1RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzP/fO8oIXMEYqXKiplucB6uiQkn1eGzzGp/tx8gcV7vHFyWorq81T03efRINtqqt
         G9/+/de/c9YXnS0buenLItjewKvA61lpEzS4CSE/6wWvq4DZ9wn0bMmNZQuvgvbUSE
         m7x0hzrxUqXuPlL0fUVsV3jy2pvPisiglo5J8Rw2XU9hySs0pBrzJQGnT7ZRMgX/0N
         I06mjR5tE73dXYVh7NF/i8eqNaWIeWJhs4/X2OrbDKwL+w2Hidc6aYapMIUftqptwo
         fHquF9xiwYvUGprAX6wH+y7Qoj6A5nPaLS72e0zacpxY3eumEF/fr0ueRnJX7gL4Z1
         3gBCeXC3zYWLw==
Received: by mercury (Postfix, from userid 1000)
        id 4F9AC10605B9; Thu,  9 Jun 2022 23:11:28 +0200 (CEST)
Date:   Thu, 9 Jun 2022 23:11:28 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 15/17] power: axp20x_battery: Add constant charge
 current table
Message-ID: <20220609211128.5knoptfwhongwrtq@mercury.elektranox.org>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-16-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wgi7s7aty2en3a44"
Content-Disposition: inline
In-Reply-To: <20220607155324.118102-16-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wgi7s7aty2en3a44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 07, 2022 at 04:53:22PM +0100, Aidan MacDonald wrote:
> Add a table-based lookup method for constant charge current,
> which is necessary when the setting cannot be represented as
> a linear range.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/power/supply/axp20x_battery.c | 53 +++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 9106077c0dbb..87fb958f2224 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -61,6 +61,7 @@ struct axp20x_batt_ps;
>  struct axp_data {
>  	int	ccc_scale;
>  	int	ccc_offset;
> +	const int *ccc_table;

Please document the struct; especially the fact that ccc_table must
have a size of AXP20X_CHRG_CTRL1_TGT_CURR + 1.

-- Sebastian

>  	bool	has_fg_valid;
>  	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
>  	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
> @@ -176,7 +177,10 @@ static int axp20x_get_constant_charge_current(struct=
 axp20x_batt_ps *axp,
> =20
>  	*val &=3D AXP20X_CHRG_CTRL1_TGT_CURR;
> =20
> -	*val =3D *val * axp->data->ccc_scale + axp->data->ccc_offset;
> +	if (axp->data->ccc_table)
> +		*val =3D axp->data->ccc_table[*val];
> +	else
> +		*val =3D *val * axp->data->ccc_scale + axp->data->ccc_offset;
> =20
>  	return 0;
>  }
> @@ -389,16 +393,36 @@ static int axp20x_battery_set_max_voltage(struct ax=
p20x_batt_ps *axp20x_batt,
>  				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
>  }
> =20
> +static int axp20x_get_constant_charge_current_sel(struct axp20x_batt_ps =
*axp_batt,
> +						  int charge_current)
> +{
> +	int i;
> +
> +	if (axp_batt->data->ccc_table) {
> +		for (i =3D AXP20X_CHRG_CTRL1_TGT_CURR; i >=3D 0; --i) {
> +			if (axp_batt->data->ccc_table[i] <=3D charge_current)
> +				return i;
> +		}
> +
> +		return -EINVAL;
> +	}
> +
> +	i =3D (charge_current - axp_batt->data->ccc_offset) / axp_batt->data->c=
cc_scale;
> +
> +	if (i > AXP20X_CHRG_CTRL1_TGT_CURR || i < 0)
> +		return -EINVAL;
> +
> +	return i;
> +}
> +
>  static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp=
_batt,
>  					      int charge_current)
>  {
>  	if (charge_current > axp_batt->max_ccc)
>  		return -EINVAL;
> =20
> -	charge_current =3D (charge_current - axp_batt->data->ccc_offset) /
> -		axp_batt->data->ccc_scale;
> -
> -	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
> +	charge_current =3D axp20x_get_constant_charge_current_sel(axp_batt, cha=
rge_current);
> +	if (charge_current < 0)
>  		return -EINVAL;
> =20
>  	return regmap_update_bits(axp_batt->regmap, AXP20X_CHRG_CTRL1,
> @@ -410,14 +434,14 @@ static int axp20x_set_max_constant_charge_current(s=
truct axp20x_batt_ps *axp,
>  {
>  	bool lower_max =3D false;
> =20
> -	charge_current =3D (charge_current - axp->data->ccc_offset) /
> -		axp->data->ccc_scale;
> -
> -	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
> +	charge_current =3D axp20x_get_constant_charge_current_sel(axp, charge_c=
urrent);
> +	if (charge_current < 0)
>  		return -EINVAL;
> =20
> -	charge_current =3D charge_current * axp->data->ccc_scale +
> -		axp->data->ccc_offset;
> +	if (axp->data->ccc_table)
> +		charge_current =3D axp->data->ccc_table[charge_current];
> +	else
> +		charge_current =3D charge_current * axp->data->ccc_scale + axp->data->=
ccc_offset;
> =20
>  	if (charge_current > axp->max_ccc)
>  		dev_warn(axp->dev,
> @@ -629,7 +653,12 @@ static int axp20x_power_probe(struct platform_device=
 *pdev)
>  								   ccc)) {
>  			dev_err(&pdev->dev,
>  				"couldn't set constant charge current from DT: fallback to minimum v=
alue\n");
> -			ccc =3D 300000;
> +
> +			if (axp20x_batt->data->ccc_table)
> +				ccc =3D axp20x_batt->data->ccc_table[0];
> +			else
> +				ccc =3D axp20x_batt->data->ccc_offset;
> +
>  			axp20x_batt->max_ccc =3D ccc;
>  			axp20x_set_constant_charge_current(axp20x_batt, ccc);
>  		}
> --=20
> 2.35.1
>=20

--wgi7s7aty2en3a44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiYfkACgkQ2O7X88g7
+prwxQ/8DagaunLieops/FmoebSFQ9BtG0QCsmUttUvd1T0PRRJWfsLuCq7OTXUC
nE6bK0SWz5H7FeK0VB8G5bNMqC4YOSFSPEQk2b/zQMxaKrCXjQfJ97esiK4bkVoB
oXmlvCfst5OBvDJi7AgqJ2i2XaA7KQ6RorH0tZVAmVLK3VDmrVS+H89oaY/oLHGy
+e7iSdIB67088tqNGlU4Xb0ME2EbkDTTgee45l3FhYsmMFwq7cAZBr3Y2L4k/sWA
plRhvdYFkyZnhWU4jAc9EbXv4TvcVNDgCI8/hHmd7uB5+/ERbPUC8anOEueDdo7p
t8cl9E+sC8dICVq/THCnSuvfVb4dMNt3V8tpTXZBeDnNRdHOroZGf7zSkAUiOw3y
nYH8BHURDUowqHy20t8J+USRIY5bsOrPm4ZCLsAb6W35NRt6OLr1tKxHpWJQIuyd
0kPNC5n3qnRYW59ieqfM62fwwrzFxYifsd/5zmCRE6+qCH7d0ZudJodgm7Wttx8s
2+nYii+6osTNIydJ6YywhPZdDKeuSML32rWURDBYLqGYlMdesZz8e7DNnJnzOqN0
2ATxmMdBJNIltNyrH6XN14RbNvW8AVRv1q5YwsmSMY0KH+AWXK4sLdZT5YqRhi3x
ICWkKVzM1MXS0h5Ib33I+yfcQ0zpEocZhaASeAHCJ1mHr23bOwo=
=k7ui
-----END PGP SIGNATURE-----

--wgi7s7aty2en3a44--
