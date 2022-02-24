Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892D34C2A46
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiBXLEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiBXLEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:04:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A5E28F969;
        Thu, 24 Feb 2022 03:03:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 13AEA1F44F7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645700632;
        bh=eCTSv5BV5ipLg86oOdHOCpWchkUEyhC8YqpSWag+BAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ellF26qw+4KiXii+/s5ZbTo2Dt6R8/WwjHqY/kgg/z1r1oTrMn1MM6JaD0lqxS6Fb
         j5BQ0bEkhZLWxAgJfvBMP90wKfkf+3SUeuJo26NzcKFojtMSdsKCxJtDEIToPEot87
         jDaOQ+jXm6eX3VNDGIjvQaIkvjep/U0rSwuIRNoNdeO+libXMZWHbtHjxHNP4VC2Vw
         lrZjvZGkPbCzMH8yuGTOdr9Wzrn66ELFjLT/I946ep4GU64AC+uiDCR1hIIOjkUggy
         lJu1nx5tR2ZDXIewFiuPTtNwysEwMDL6OtgsaF4NoUTZm+3hFG5VDU0P1Re2ntNPq7
         ymYEmDoeGrTsg==
Received: by mercury (Postfix, from userid 1000)
        id 5D21B106049B; Thu, 24 Feb 2022 12:03:49 +0100 (CET)
Date:   Thu, 24 Feb 2022 12:03:49 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2] power: supply: max17042_battery: Use
 devm_work_autocancel()
Message-ID: <20220224110349.4fs3rxsqsaq23t45@mercury.elektranox.org>
References: <670ea51361f96035f49852c617325af10ffa07ea.1645205558.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xrh67l7owdyevwhn"
Content-Disposition: inline
In-Reply-To: <670ea51361f96035f49852c617325af10ffa07ea.1645205558.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xrh67l7owdyevwhn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 18, 2022 at 06:37:37PM +0100, Christophe JAILLET wrote:
> Use devm_work_autocancel() instead of hand-writing it.
> This saves a few lines of code.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Thanks, queued.

-- Sebastian

> V2: s/devm_delayed_work_autocancel/devm_work_autocancel/
>=20
>  drivers/power/supply/max17042_battery.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 87128cf0d577..ab031bbfbe78 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -9,6 +9,7 @@
>  // This driver is based on max17040_battery.c
> =20
>  #include <linux/acpi.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> @@ -1030,13 +1031,6 @@ static const struct power_supply_desc max17042_no_=
current_sense_psy_desc =3D {
>  	.num_properties	=3D ARRAY_SIZE(max17042_battery_props) - 2,
>  };
> =20
> -static void max17042_stop_work(void *data)
> -{
> -	struct max17042_chip *chip =3D data;
> -
> -	cancel_work_sync(&chip->work);
> -}
> -
>  static int max17042_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -1142,8 +1136,8 @@ static int max17042_probe(struct i2c_client *client,
> =20
>  	regmap_read(chip->regmap, MAX17042_STATUS, &val);
>  	if (val & STATUS_POR_BIT) {
> -		INIT_WORK(&chip->work, max17042_init_worker);
> -		ret =3D devm_add_action(&client->dev, max17042_stop_work, chip);
> +		ret =3D devm_work_autocancel(&client->dev, &chip->work,
> +					   max17042_init_worker);
>  		if (ret)
>  			return ret;
>  		schedule_work(&chip->work);
> --=20
> 2.32.0
>=20

--xrh67l7owdyevwhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIXZhUACgkQ2O7X88g7
+poKdQ/+Kort2KqVLw/IK46tM6TwFOUr5ihtA6ddQJ4tYsiMXHOT5LZVBXFUowGT
OEd61nM//q2zIUCNol4iad82OokxXb0u41yApL1U+rc2rL8YT0LiNI1fVM0xT5VB
Wbyg5Ysn3A7V5jgbMYDPoDUeSqxDpYqdCrMkThZwTpTQ+SeVCEATdBGUib0h4PuR
rrLdfOY79SpJUge6tIkofvc6FJzoL5j9rFQ8SPMVDmM6w1FfpqDMWla7eohYvJe2
69idN8ipO3t2cZPCaXS4KdvJkfSydtsafbgXdkmAuhW4/oRbvKYKusfOeDQPi9i8
xXf/xVNYWVy2WGr0OuxAz2XwFvD+v5GNE7MeBMD+D2j4S4FvS+uHpF3FLpPGoGdy
gHSJrHOaPtzEVXWAwwzGGaYBEyAMP8Ow6E7kHgHLmnpkOEcwHpbG/SLlt2VRHy3x
534FpAY59HfMMmWenTNrcvi3xyZTszb1YXMb7X+UpVbHpxbIOA6k+V15HalrAYlO
LOQP/RB8Pr0/KLN1/Td5R9LGWAuW6CYl2At2VVA63WWZH36E3mX63HHC+y6/Q99g
pQCajlTq1LU7BSlToziPHrrcR2gqfEzVwvugntcgt7AoFc/Ve6yJAQFoLH+hEKMm
cSCXgp1iCMwSIHUdxJ0e2kN+Y5s3rjPh2wZvDD+O3RnFvKbS0IE=
=v6Zy
-----END PGP SIGNATURE-----

--xrh67l7owdyevwhn--
