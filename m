Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4744B2E56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353051AbiBKUTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:19:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiBKUTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:19:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8B1CF9;
        Fri, 11 Feb 2022 12:19:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9C92B1F47311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644610750;
        bh=EzaDXvqdw0zFvLGugqrrMbUDVyUEyIv5cYRWfdMfW0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHAu+XxKXjrxfTS2QKS4rXQ9FEVCvXv5/zeErfUvt9BZV8O2quH2XsQ5VkqrQNHKC
         gYdhT98yLK5UQ0KPC3486MLGz5vFv11gn74UI4BuQYdESycVrvz6ox/LUIaLa0umrO
         e0JxXg+p9HvZIpom5gCWGAuFG96C19DHSV8uafdWtLI0VUkyB2FOf8HI3fJk9N4V4K
         vI6YH2RldYy5BYfQ8b+CleNkPVk3QRVhcP8ExqU9VclIOZhhrvF2WvjQHveNL/6fRs
         v+uXPk6L/D+d3CM0yg+WceAtDTIshaySCD9jBjVHvFU41GNXo9HbrN7oiq2jCSCos4
         3XwvLCSikVjWw==
Received: by mercury (Postfix, from userid 1000)
        id D73381060908; Fri, 11 Feb 2022 21:19:07 +0100 (CET)
Date:   Fri, 11 Feb 2022 21:19:07 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: ltc2941: clean up error messages
Message-ID: <20220211201907.w6r33usasb2r2khm@mercury.elektranox.org>
References: <680a4c737950f59e787f64887402e3ae247e89dd.1641868274.git.mirq-linux@rere.qmqm.pl>
 <3eede91c6484c6626f2a727bf1837ee93939155a.1641868274.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dmvodvu6yemwylcn"
Content-Disposition: inline
In-Reply-To: <3eede91c6484c6626f2a727bf1837ee93939155a.1641868274.git.mirq-linux@rere.qmqm.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dmvodvu6yemwylcn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 11, 2022 at 03:32:41AM +0100, Micha=C5=82 Miros=C5=82aw wrote:
> Replace dev_err() with dev_err_probe() in probe() and extend register
> access failure messages. dev_err()s in _reset() are removed as they
> are redundant: register access wrappers already log the error.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ltc2941-battery-gauge.c | 53 ++++++++------------
>  1 file changed, 20 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c
> index c0cbf4cd59ee..657305214d68 100644
> --- a/drivers/power/supply/ltc2941-battery-gauge.c
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> @@ -112,7 +112,8 @@ static int ltc294x_read_regs(struct i2c_client *clien=
t,
> =20
>  	ret =3D i2c_transfer(client->adapter, &msgs[0], 2);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "ltc2941 read_reg failed!\n");
> +		dev_err(&client->dev, "ltc2941 read_reg(0x%x[%d]) failed: %pe\n",
> +			reg, num_regs, ERR_PTR(ret));
>  		return ret;
>  	}
> =20
> @@ -130,7 +131,8 @@ static int ltc294x_write_regs(struct i2c_client *clie=
nt,
> =20
>  	ret =3D i2c_smbus_write_i2c_block_data(client, reg_start, num_regs, buf=
);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "ltc2941 write_reg failed!\n");
> +		dev_err(&client->dev, "ltc2941 write_reg(0x%x[%d]) failed: %pe\n",
> +			reg, num_regs, ERR_PTR(ret));
>  		return ret;
>  	}
> =20
> @@ -148,11 +150,8 @@ static int ltc294x_reset(const struct ltc294x_info *=
info, int prescaler_exp)
> =20
>  	/* Read status and control registers */
>  	ret =3D ltc294x_read_regs(info->client, LTC294X_REG_CONTROL, &value, 1);
> -	if (ret < 0) {
> -		dev_err(&info->client->dev,
> -			"Could not read registers from device\n");
> -		goto error_exit;
> -	}
> +	if (ret < 0)
> +		return ret;
> =20
>  	control =3D LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |
>  				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;
> @@ -172,17 +171,11 @@ static int ltc294x_reset(const struct ltc294x_info =
*info, int prescaler_exp)
>  	if (value !=3D control) {
>  		ret =3D ltc294x_write_regs(info->client,
>  			LTC294X_REG_CONTROL, &control, 1);
> -		if (ret < 0) {
> -			dev_err(&info->client->dev,
> -				"Could not write register\n");
> -			goto error_exit;
> -		}
> +		if (ret < 0)
> +			return ret;
>  	}
> =20
>  	return 0;
> -
> -error_exit:
> -	return ret;
>  }
> =20
>  static int ltc294x_read_charge_register(const struct ltc294x_info *info,
> @@ -472,11 +465,9 @@ static int ltc294x_i2c_probe(struct i2c_client *clie=
nt,
>  	/* r_sense can be negative, when sense+ is connected to the battery
>  	 * instead of the sense-. This results in reversed measurements. */
>  	ret =3D of_property_read_u32(np, "lltc,resistor-sense", &r_sense);
> -	if (ret < 0) {
> -		dev_err(&client->dev,
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
>  			"Could not find lltc,resistor-sense in devicetree\n");
> -		return ret;
> -	}
>  	info->r_sense =3D r_sense;
> =20
>  	ret =3D of_property_read_u32(np, "lltc,prescaler-exponent",
> @@ -502,11 +493,9 @@ static int ltc294x_i2c_probe(struct i2c_client *clie=
nt,
>  	/* Read status register to check for LTC2942 */
>  	if (info->id =3D=3D LTC2941_ID || info->id =3D=3D LTC2942_ID) {
>  		ret =3D ltc294x_read_regs(client, LTC294X_REG_STATUS, &status, 1);
> -		if (ret < 0) {
> -			dev_err(&client->dev,
> +		if (ret < 0)
> +			return dev_err_probe(&client->dev, ret,
>  				"Could not read status register\n");
> -			return ret;
> -		}
>  		if (status & LTC2941_REG_STATUS_CHIP_ID)
>  			info->id =3D LTC2941_ID;
>  		else
> @@ -545,19 +534,17 @@ static int ltc294x_i2c_probe(struct i2c_client *cli=
ent,
>  		return ret;
> =20
>  	ret =3D ltc294x_reset(info, prescaler_exp);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Communication with chip failed\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +			"Communication with chip failed\n");
> =20
>  	info->supply =3D devm_power_supply_register(&client->dev,
>  						  &info->supply_desc, &psy_cfg);
> -	if (IS_ERR(info->supply)) {
> -		dev_err(&client->dev, "failed to register ltc2941\n");
> -		return PTR_ERR(info->supply);
> -	} else {
> -		schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
> -	}
> +	if (IS_ERR(info->supply))
> +		return dev_err_probe(&client->dev, PTR_ERR(info->supply),
> +			"failed to register ltc2941\n");
> +
> +	schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
> =20
>  	return 0;
>  }
> --=20
> 2.30.2
>=20

--dmvodvu6yemwylcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGxLsACgkQ2O7X88g7
+poQ8g/7Bo8XzL0g0Hxe0ZdqrD3SA1X+DOpzXD/y5h4JADfwQq+MK52lv7ZmWij7
wqD+9/l0N+MJYjtQo9bk5nrKtur1C6sN+zgPaWDBj3XoYw0bROPJe9QO8yQghan/
iegn8GBoRnrErpP+aShg1EEKGs3e/7X+H6C7V5n809uYFZhIKVcnsVNqhLoFDhVV
JEBWll2Luvz+AEBD8z117In1ouhXPOpSib+t344DSKgYXT6+YAX8SIfooSFtEmyw
VwFBnm8c9y0z7ONBWXmocQCc0vC9R81GWqsU2Lrk0j5cQUv43n2723iBsa1Wh0xt
RWlO1GKxvuGUmKNi5N1MSXPXNoyJnUL2/dURan3+Fxuo51dibo8XIDV3dvZFTxU8
Oon5iCpiC2Lsrw3oUqg66RhGqQmVdwnxcnKlhseo6jaK2mtP/CU7j/jDPSu48TMe
hqyVX7HSgSMDg3mdfV7Arfd3H8NP+D8rN3UpWknrhYe7VsmShdPJVRxQHMtBgBRv
gcBDAee1a3e1m7K/PJHqHEvYEnnmWyT4t31Tpdqhin+QAP3fNmZPkYdr2CfvFEL4
0qbsIRxqO3l+iXiMQk0VhtR93I0ZaBk7Zo8REJe4+Lk/Zn7FcnEvvp/FUMYd2Eb0
wOYZI51sTabom88Mp4siOHwcbtas0W52uOXuDP9m2Jsg3wBHxZQ=
=LjCT
-----END PGP SIGNATURE-----

--dmvodvu6yemwylcn--
