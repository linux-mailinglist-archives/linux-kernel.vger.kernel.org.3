Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183FF46692B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376395AbhLBRew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376359AbhLBRen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AADEC0613ED;
        Thu,  2 Dec 2021 09:31:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 166081F469C4
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638466277; bh=xfPaEkyWPuZigLwuT2Vxs/NNQF1i5jWjPiABdDVK4os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AT17cv7vtGXTwf/s5899/I7VUDRxLqCJxolPVE+Qqdu/nnaTrDWWY0DsgbN25atLq
         hbQ0WIZN4ryihFtqXLVhdmMpiAsXHIt6D2112KlxrzbeN73C87i3FO/fFuBGo2wvtD
         LFk6P9cg+rRPduzbDAIuPzrCcp3Tvps6Pmu7lDP9eBF1CweAkHLzfvZ+yHVoO4suJY
         2uLynDai45O5TSmbnzqGrTrCRHw+9xUEIPDZZH3GLrZpeQ7bCmioTTtco2Q9OpOohX
         doVYbl85HnhX26DxE9qjBv6eTSyiN2gILLFTrjl25jG4q13AOroe//kEgaIdvDG4LU
         1HHF0mibKSqEw==
Received: by earth.universe (Postfix, from userid 1000)
        id DF82F3C0CA8; Thu,  2 Dec 2021 18:31:14 +0100 (CET)
Date:   Thu, 2 Dec 2021 18:31:14 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: Re: [PATCH v2] power: bq25890: add POWER_SUPPLY_PROP_TEMP
Message-ID: <20211202173114.mldcwy6aydccp54n@earth.universe>
References: <20211118161845.98767-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5pwtuxgxpu5szigg"
Content-Disposition: inline
In-Reply-To: <20211118161845.98767-1-angus@akkea.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5pwtuxgxpu5szigg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 18, 2021 at 08:18:45AM -0800, Angus Ainslie wrote:
> Add the POWER_SUPPLY_PROP_TEMP and a NTC 10K percent VREGN to degrees LUT.
>=20
> Make sure that a conversion is forced when the power supply is offline so
> the temperature is valid.
>=20
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 37 +++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 945c3257ca93..0260c6efdcb2 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -266,6 +266,7 @@ enum bq25890_table_ids {
>  	/* lookup tables */
>  	TBL_TREG,
>  	TBL_BOOSTI,
> +	TBL_TSPCT,
>  };
> =20
>  /* Thermal Regulation Threshold lookup table, in degrees Celsius */
> @@ -280,6 +281,28 @@ static const u32 bq25890_boosti_tbl[] =3D {
> =20
>  #define BQ25890_BOOSTI_TBL_SIZE		ARRAY_SIZE(bq25890_boosti_tbl)
> =20
> +/* NTC 10K temperature lookup table in tenths of a degree */
> +static const u32 bq25890_tspct_tbl[] =3D {
> +	850, 840, 830, 820, 810, 800, 790, 780,
> +	770, 760, 750, 740, 730, 720, 710, 700,
> +	690, 685, 680, 675, 670, 660, 650, 645,
> +	640, 630, 620, 615, 610, 600, 590, 585,
> +	580, 570, 565, 560, 550, 540, 535, 530,
> +	520, 515, 510, 500, 495, 490, 480, 475,
> +	470, 460, 455, 450, 440, 435, 430, 425,
> +	420, 410, 405, 400, 390, 385, 380, 370,
> +	365, 360, 355, 350, 340, 335, 330, 320,
> +	310, 305, 300, 290, 285, 280, 275, 270,
> +	260, 250, 245, 240, 230, 225, 220, 210,
> +	205, 200, 190, 180, 175, 170, 160, 150,
> +	145, 140, 130, 120, 115, 110, 100, 90,
> +	80, 70, 60, 50, 40, 30, 20, 10,
> +	0, -10, -20, -30, -40, -60, -70, -80,
> +	-90, -10, -120, -140, -150, -170, -190, -210,
> +};
> +
> +#define BQ25890_TSPCT_TBL_SIZE		ARRAY_SIZE(bq25890_tspct_tbl)
> +
>  struct bq25890_range {
>  	u32 min;
>  	u32 max;
> @@ -308,7 +331,8 @@ static const union {
> =20
>  	/* lookup tables */
>  	[TBL_TREG] =3D	{ .lt =3D {bq25890_treg_tbl, BQ25890_TREG_TBL_SIZE} },
> -	[TBL_BOOSTI] =3D	{ .lt =3D {bq25890_boosti_tbl, BQ25890_BOOSTI_TBL_SIZE=
} }
> +	[TBL_BOOSTI] =3D	{ .lt =3D {bq25890_boosti_tbl, BQ25890_BOOSTI_TBL_SIZE=
} },
> +	[TBL_TSPCT] =3D	{ .lt =3D {bq25890_tspct_tbl, BQ25890_TSPCT_TBL_SIZE} }
>  };
> =20
>  static int bq25890_field_read(struct bq25890_device *bq,
> @@ -388,6 +412,7 @@ static bool bq25890_is_adc_property(enum power_supply=
_property psp)
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +	case POWER_SUPPLY_PROP_TEMP:
>  		return true;
> =20
>  	default:
> @@ -528,6 +553,15 @@ static int bq25890_power_supply_get_property(struct =
power_supply *psy,
>  		val->intval =3D ret * -50000;
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D bq25890_field_read(bq, F_TSPCT);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* convert TS percentage into rough temperature */
> +		val->intval =3D bq25890_find_val(ret, TBL_TSPCT);
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -713,6 +747,7 @@ static const enum power_supply_property bq25890_power=
_supply_props[] =3D {
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
>  };
> =20
>  static char *bq25890_charger_supplied_to[] =3D {
> --=20
> 2.25.1
>=20

--5pwtuxgxpu5szigg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGpAuIACgkQ2O7X88g7
+poNsA/9HW/NKIUNKi4lPbuPSpeJsCO16z0gtfe9/fqT3hQqGdwirvqO0V/dmRA+
83O9/F3U7f6YsDrAUutbOFRGXuqOsO+LyYbUEf9/MfVG3h6ZZ7nm4OW6M0OrP+IB
IOr1Ek0avtHJlOtgntzpraDPMkY6Ehb4gbduDgtRrrCr88PQAcrvUdJMA279O+b6
Kx7ChQDWpRp8rXxnh71liMb41XAwGmDEFX7uCnDgSt6YVMDVxkIbfhU20As+nb6Z
uGos+kQVDslpKB6X2XrfpNfHcYqKTCRAWhFFJHEuL5O+LcPmgwbIGWWcNHkZvFUj
JfJx11BWvceOT6llOgYJSLhiYORIiErlpjfNBasRySuzX9YeZRwdByAWdH1cezdP
Zh5xycSAaGbX/lfBwPKBlY3xFLbyPo7eNWIhjpfakDza1r+zSWkG/MoVwdkwppEt
T7VUp9WM0XrZDUlUknkEY+GB+IFnttlqNbkEtMToIO78KU39AeG4ixB8CXWnd8fo
C3V19t0COxE/8uO15gSOs7s+vTtOEh/VZ5YSiL+bye/sHl89h2E/Cv6tw8lZt3G0
xpjHxq3A+vQQI6p4xFdZutKyW6c90UKHqngH+GUY5UdhZPDzu4fmIWhCQmvG21OP
EVmDW5iG0dh7yYi5imsIlccMJZIBY21zkzWP8t7cJ6dIFixzqbU=
=GSX/
-----END PGP SIGNATURE-----

--5pwtuxgxpu5szigg--
