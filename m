Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBD5188CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiECPmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbiECPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:42:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394FC30F6B;
        Tue,  3 May 2022 08:38:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 119161F44292
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651592335;
        bh=MG/038EvUZE8OAe8PfPgJ4hV92WF62tq8yJ1yvMIAH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2E/EID3YLQS4QEm0CqTTREs2LcqC6vMk/tRLnBpZSilG46WeQqdcVLyQ6UCel5kB
         DPcO7OpCdAhu//eBvIlpAn2po4JMXvqYJ6A12XNlAP4/f/AIy6SBVKq9cCzKadvjHs
         tUt/jdbDMgbODaA1wcDVjLJISFWEayQrZc0mvkBXb6vO/HL33MuZ5KqqOrolyQldEn
         MWY2jIMBaTvJL+9e/Uyo//D0DEBRL9uIseFnnVjsLstl/x7hWhhjznnm9P/Y3SEF+d
         yHufZ3wOnSgr9FIVmtWAGXzoOmxQUOCK+KzO3mxWJ0bUybZgXPeiJUkW/ysl0i/qTn
         9lZgVz44g8Xkw==
Received: by mercury (Postfix, from userid 1000)
        id 1717F1060430; Tue,  3 May 2022 17:38:53 +0200 (CEST)
Date:   Tue, 3 May 2022 17:38:53 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     pali@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] power: supply: bq27xxx: expose battery data when
 CI=1
Message-ID: <20220503153853.k6aysmjep6r7yazu@mercury.elektranox.org>
References: <20220420123059.1206443-1-absicsz@gmail.com>
 <20220420123059.1206443-2-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ccpdmm7sz72bxqom"
Content-Disposition: inline
In-Reply-To: <20220420123059.1206443-2-absicsz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ccpdmm7sz72bxqom
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 20, 2022 at 02:30:59PM +0200, Sicelo A. Mhlongo wrote:
> When the Capacity Inaccurate flag is set, the chip still provides data
> about the battery, albeit inaccurate. Instead of discarding capacity
> values for CI=3D1, expose the stale data and use the
> POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED property to indicate that the
> values should be used with care.
>=20
> Reviewed-by: Pali Roh=E1r <pali@kernel.org>
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c | 59 ++++++++++++--------------
>  1 file changed, 27 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 72e727cd31e8..9adc7f43bbfd 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1572,14 +1572,6 @@ static int bq27xxx_battery_read_charge(struct bq27=
xxx_device_info *di, u8 reg)
>   */
>  static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *d=
i)
>  {
> -	int flags;
> -
> -	if (di->opts & BQ27XXX_O_ZERO) {
> -		flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
> -		if (flags >=3D 0 && (flags & BQ27000_FLAG_CI))
> -			return -ENODATA;
> -	}
> -
>  	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);
>  }
> =20
> @@ -1742,6 +1734,18 @@ static bool bq27xxx_battery_dead(struct bq27xxx_de=
vice_info *di, u16 flags)
>  		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
>  }
> =20
> +/*
> + * Returns true if reported battery capacity is inaccurate
> + */
> +static bool bq27xxx_battery_capacity_inaccurate(struct bq27xxx_device_in=
fo *di,
> +						 u16 flags)
> +{
> +	if (di->opts & BQ27XXX_O_HAS_CI)
> +		return (flags & BQ27000_FLAG_CI);
> +	else
> +		return false;
> +}
> +
>  static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>  {
>  	/* Unlikely but important to return first */
> @@ -1751,6 +1755,8 @@ static int bq27xxx_battery_read_health(struct bq27x=
xx_device_info *di)
>  		return POWER_SUPPLY_HEALTH_COLD;
>  	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
>  		return POWER_SUPPLY_HEALTH_DEAD;
> +	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, di->cache.flags)))
> +		return POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
> =20
>  	return POWER_SUPPLY_HEALTH_GOOD;
>  }
> @@ -1766,30 +1772,19 @@ void bq27xxx_battery_update(struct bq27xxx_device=
_info *di)
>  		cache.flags =3D -1; /* read error */
>  	if (cache.flags >=3D 0) {
>  		cache.temperature =3D bq27xxx_battery_read_temperature(di);
> -		if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
> -			dev_info_once(di->dev, "battery is not calibrated! ignoring capacity =
values\n");
> -			cache.capacity =3D -ENODATA;
> -			cache.energy =3D -ENODATA;
> -			cache.time_to_empty =3D -ENODATA;
> -			cache.time_to_empty_avg =3D -ENODATA;
> -			cache.time_to_full =3D -ENODATA;
> -			cache.charge_full =3D -ENODATA;
> -			cache.health =3D -ENODATA;
> -		} else {
> -			if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_REG_ADDR)
> -				cache.time_to_empty =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TT=
E);
> -			if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID_REG_ADDR)
> -				cache.time_to_empty_avg =3D bq27xxx_battery_read_time(di, BQ27XXX_RE=
G_TTECP);
> -			if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_ADDR)
> -				cache.time_to_full =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF=
);
> -
> -			cache.charge_full =3D bq27xxx_battery_read_fcc(di);
> -			cache.capacity =3D bq27xxx_battery_read_soc(di);
> -			if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
> -				cache.energy =3D bq27xxx_battery_read_energy(di);
> -			di->cache.flags =3D cache.flags;
> -			cache.health =3D bq27xxx_battery_read_health(di);
> -		}
> +		if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_REG_ADDR)
> +			cache.time_to_empty =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE=
);
> +		if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID_REG_ADDR)
> +			cache.time_to_empty_avg =3D bq27xxx_battery_read_time(di, BQ27XXX_REG=
_TTECP);
> +		if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_ADDR)
> +			cache.time_to_full =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
> +
> +		cache.charge_full =3D bq27xxx_battery_read_fcc(di);
> +		cache.capacity =3D bq27xxx_battery_read_soc(di);
> +		if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
> +			cache.energy =3D bq27xxx_battery_read_energy(di);
> +		di->cache.flags =3D cache.flags;
> +		cache.health =3D bq27xxx_battery_read_health(di);
>  		if (di->regs[BQ27XXX_REG_CYCT] !=3D INVALID_REG_ADDR)
>  			cache.cycle_count =3D bq27xxx_battery_read_cyct(di);
> =20
> --=20
> 2.35.2
>=20

--ccpdmm7sz72bxqom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJxTIwACgkQ2O7X88g7
+ppi1Q//WiA3zQ3zhED88ZZqdDzq0vK2xJW9igdt/wdh/bG4Dib/pDcJnN9a4OAu
gmVsHAmDRhwMjzleiwcRTlf8aPm/l4uLE1M7c74UEwR1KfzdZ21QOuX7KHN5OOfS
8dreBd/HddVQEufjvG7SeVCmMtstYSzMuyAL1CB5YQWubW5gXOa2Gp1+dcXjOSBi
ilqA5E/uon4hEDNn+TMpmQ47D3nwthS02WsazciknAIlcIw4CwF1BjhV71Nk1ODS
TpIVbQ2NfahfU6D8WpUQ68+D8pcR05GZOWOP5t7HmoGYkGJwwwoJyy53DgpVd/6L
/oc+kDdaDOVZj7epHUoZgRIZr4p0S/Yd+GE966I6O1vVkMzRq8aiVSOjYQ1+1bA9
v+qSnzh0nbhpnyqKdHbaLlwUBTkK9/1xJtp5ZgHKKItjAgPkvWbNEcHO9W0ECjWI
iMorr50bX/yqz1ttekUt6B2p5EVvsoH+AHyKbXCqYtTEMTKIYV9/0MO7Y5KqstaW
RduqTMO/LjuAbAFnsvwSAvplE216w3vmUsTDlIBIH4N5fIZp9qngoV+Pob7wXu0u
yR22vAjS+0X3WqvALiAZNt8iO0yqYC6x6ji86b1GulJVW8vzfNZns0jXXPT/p3ZO
rCQ2kqpN4Vxa6D1KtJs7xS2ESi4lmRvoqbWX6ijg4us0+/uNSaE=
=RqE+
-----END PGP SIGNATURE-----

--ccpdmm7sz72bxqom--
