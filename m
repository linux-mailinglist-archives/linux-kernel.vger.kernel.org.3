Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FE94B2F51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353641AbiBKVWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:22:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiBKVW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:22:29 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A91C58;
        Fri, 11 Feb 2022 13:22:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B2E641F47259
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644614545;
        bh=zhg73elmp3Pg0ZGoz1DplMfXiUlKZD0Q3+Xrt5B4Q2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeZw64PpaViLKnSKitd09j+YH41U5fmebt5bmeiFualIPAfsuiD6Y7yHnTVr9SrCN
         687ios2fcmNMTLNWfCJZFHIKcYT4jzrfKHPJIh0y2ceopeenYpPzx5N00vmUfXB5uf
         JkEd1NGHxAyLQ6oFHYonclWvOAOqZqvBVNK+bJTvO2pwqGqgfqW7+XFMJPMwxfVl7T
         xLHBkhBo63CCHBQM3rb5/ENXPG/G3LNDq5kZkr392ucIn7XfdsQeIGFHcSCJG+q58Z
         4mMPKO9knwDEP+qpXEvGaT8arB6hDdRl086Rtq+XFjxMrqKgAyfokNrSUhoWWIrkCD
         B5GCPA70Os6/w==
Received: by mercury (Postfix, from userid 1000)
        id C25B31060908; Fri, 11 Feb 2022 22:22:18 +0100 (CET)
Date:   Fri, 11 Feb 2022 22:22:18 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH 3/3] power: supply: Add a driver for Injoinic power bank
 ICs
Message-ID: <20220211212218.j5r75tyvhirxis4z@mercury.elektranox.org>
References: <20220129222424.45707-1-samuel@sholland.org>
 <20220129222424.45707-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w46czuuerlup3l7h"
Content-Disposition: inline
In-Reply-To: <20220129222424.45707-3-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w46czuuerlup3l7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 29, 2022 at 04:24:24PM -0600, Samuel Holland wrote:
> This driver supports several chip variants which all share the same I2C
> register interface. Since the chip will turn off and become inaccessible
> under conditions outside of software control (e.g. upon button press or
> input voltage removal), some special handling is needed to delay the
> initialization of the IC until it is accessible.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---

Thanks, driver looks mostly good to me. Just two things:

> [...]
> +static const struct power_supply_desc ip5xxx_charger_desc =3D {
> +	.name			=3D "ip5xxx-charger",
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,

POWER_SUPPLY_TYPE_BATTERY is the wrong type for a charger.
Considering the chips want 5V on the input side as far as
I could see, a sensible type is POWER_SUPPLY_TYPE_USB.

> +	.properties		=3D ip5xxx_charger_properties,
> +	.num_properties		=3D ARRAY_SIZE(ip5xxx_charger_properties),
> +	.get_property		=3D ip5xxx_charger_get_property,
> +	.set_property		=3D ip5xxx_charger_set_property,
> +	.property_is_writeable	=3D ip5xxx_charger_property_is_writeable,
> +};
> +
> +static const struct regmap_config ip5xxx_regmap_config =3D {
> +	.reg_bits		=3D 8,
> +	.val_bits		=3D 8,
> +	.max_register		=3D IP5XXX_BATOCV_DAT1,
> +};
> +
> +static int ip5xxx_power_probe(struct i2c_client *client)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct device *dev =3D &client->dev;
> +	struct power_supply *psy;
> +	struct ip5xxx *ip5xxx;
> +
> +	ip5xxx =3D devm_kzalloc(dev, sizeof(*ip5xxx), GFP_KERNEL);

if (!ip5xxx)
    return -ENOMEM;

-- Sebastian

> +	ip5xxx->regmap =3D devm_regmap_init_i2c(client, &ip5xxx_regmap_config);
> +	if (IS_ERR(ip5xxx->regmap))
> +		return PTR_ERR(ip5xxx->regmap);
> +
> +	psy_cfg.of_node =3D dev->of_node;
> +	psy_cfg.drv_data =3D ip5xxx;
> +
> +	psy =3D devm_power_supply_register(dev, &ip5xxx_charger_desc, &psy_cfg);
> +	if (IS_ERR(psy))
> +		return PTR_ERR(psy);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ip5xxx_power_of_match[] =3D {
> +	{ .compatible =3D "injoinic,ip5108" },
> +	{ .compatible =3D "injoinic,ip5109" },
> +	{ .compatible =3D "injoinic,ip5207" },
> +	{ .compatible =3D "injoinic,ip5209" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ip5xxx_power_of_match);
> +
> +static struct i2c_driver ip5xxx_power_driver =3D {
> +	.probe_new	=3D ip5xxx_power_probe,
> +	.driver		=3D {
> +		.name		=3D "ip5xxx-power",
> +		.of_match_table	=3D ip5xxx_power_of_match,
> +	}
> +};
> +module_i2c_driver(ip5xxx_power_driver);
> +
> +MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
> +MODULE_DESCRIPTION("Injoinic IP5xxx power bank IC driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.33.1
>=20

--w46czuuerlup3l7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIG04cACgkQ2O7X88g7
+pqADRAAmfJr6KcMlU8rm9eRkm1y4LoGuphofrElvMTTkElfRIHFHzXgOTqV6tlw
KcHvGJhpPM7OoC9k5mq8o5DV6hFGxEuVGfE7AHVzT/gcW3rzLaCjpS30JvMw9tZC
OuowvrxMfVU1qBXE4gHSUYopsj2E4nlTqAs503jRRbYIPyYPocroaTQ2nf9zK2X/
RG1y1bRZT/rO0PmjkNXtLvwMgdUoT4Ay2N/DJwuHzd7AIElzTkKF2QGnrm/a3w+e
G3yMLRI7pDSfXW+jdG5l53fgqwsRmMoSnRW0MRdSNgebm9jZoul7qxyoGg/ebBbw
loz2iNS0lKr9sOxVf9Qh6xp7vyj9sC1af+4EcduO/6aThcIB3k+/YAiTwqeaSti2
tjw5G23w8/OrTjNYG/XwE2hwNXbg4e5pLLGe0qvUsFQEpzfmJ7i5Of+0o5rcZUvH
gI7zohIr3YB8ZmQtDeU8RVukCwzNqJs6S6x6PuEzvxdItg3jR9SD5ruRoDolydy+
RVWV5BR8iKuP+r9iFV/lypy5NNt0wtL/tz83tPYPsNv30jHukQ4vI2k+eXnUzL4P
xWRa5+y+mXMFGuGlLSURYEy5PJgba1lgXhGV/pPu1vkftGoxUkEGuEDyD1HgRkRR
U5wk6VedSCBAsY/M174Kc1rHO81dgfhNv/BxAZWQLTfQFrm+Kf8=
=Gyx3
-----END PGP SIGNATURE-----

--w46czuuerlup3l7h--
