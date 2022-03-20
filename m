Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB14E1DF7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbiCTV06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiCTV04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:26:56 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE8522D0;
        Sun, 20 Mar 2022 14:25:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6F937E0087;
        Sun, 20 Mar 2022 14:25:02 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MjgHkYr9dlxI; Sun, 20 Mar 2022 14:25:01 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] power: supply: max17042_battery: read battery properties from device tree
Date:   Sun, 20 Mar 2022 22:24:57 +0100
Message-ID: <3482664.QJadu78ljV@pliszka>
In-Reply-To: <354ec362-0883-ccfe-9e19-7897318e5e08@kernel.org>
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm> <20220318001048.20922-5-sebastian.krzyszkowiak@puri.sm> <354ec362-0883-ccfe-9e19-7897318e5e08@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1953021.CQOukoFCf9"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1953021.CQOukoFCf9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Date: Sun, 20 Mar 2022 22:24:57 +0100
Message-ID: <3482664.QJadu78ljV@pliszka>
In-Reply-To: <354ec362-0883-ccfe-9e19-7897318e5e08@kernel.org>

On pi=C4=85tek, 18 marca 2022 09:40:36 CET Krzysztof Kozlowski wrote:
> On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
> > So far configuring the gauge was only possible using platform data,
> > with no way to provide the configuration on device tree-based platforms.
> >=20
> > Change that by looking up the configuration values from monitored-batte=
ry
> > property. This is especially useful on models implementing ModelGauge m5
> > EZ
> > algorithm, such as MAX17055, as all the required configuration can be
> > derived from a "simple-battery" DT node there.
> >=20
> > In order to be able to access power supply framework in get_of_pdata,
> > move devm_power_supply_register earlier in max17042_probe.
> >=20
> > Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> > ---
> >=20
> >  drivers/power/supply/max17042_battery.c | 50 +++++++++++++++++++------
> >  include/linux/power/max17042_battery.h  |  1 +
> >  2 files changed, 40 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/max17042_battery.c
> > b/drivers/power/supply/max17042_battery.c index
> > c39250349a1d..4c33565802d5 100644
> > --- a/drivers/power/supply/max17042_battery.c
> > +++ b/drivers/power/supply/max17042_battery.c
> > @@ -937,7 +937,9 @@ max17042_get_of_pdata(struct max17042_chip *chip)
> >=20
> >  	struct device *dev =3D &chip->client->dev;
> >  	struct device_node *np =3D dev->of_node;
> >  	u32 prop;
> >=20
> > +	u64 data64;
> >=20
> >  	struct max17042_platform_data *pdata;
> >=20
> > +	struct power_supply_battery_info *info;
> >=20
> >  	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> >  	if (!pdata)
> >=20
> > @@ -961,6 +963,32 @@ max17042_get_of_pdata(struct max17042_chip *chip)
> >=20
> >  	if (of_property_read_s32(np, "maxim,over-volt", &pdata->vmax))
> >  =09
> >  		pdata->vmax =3D INT_MAX;
> >=20
> > +	if (pdata->enable_current_sense &&
> > +	    power_supply_get_battery_info(chip->battery, &info) =3D=3D 0) {
> > +		pdata->config_data =3D devm_kzalloc(dev, sizeof(*pdata-
>config_data),
> > GFP_KERNEL); +		if (!pdata->config_data)
> > +			return NULL;
> > +
> > +		if (info->charge_full_design_uah !=3D -EINVAL) {
> > +			data64 =3D (u64)info->charge_full_design_uah *=20
pdata->r_sns;
> > +			do_div(data64, MAX17042_CAPACITY_LSB);
> > +			pdata->config_data->design_cap =3D (u16)data64;
> > +			pdata->enable_por_init =3D true;
> > +		}
> > +		if (info->charge_term_current_ua !=3D -EINVAL) {
> > +			data64 =3D (u64)info->charge_term_current_ua *=20
pdata->r_sns;
> > +			do_div(data64, MAX17042_CURRENT_LSB);
> > +			pdata->config_data->ichgt_term =3D (u16)data64;
> > +			pdata->enable_por_init =3D true;
> > +		}
> > +		if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055) {
> > +			if (info->voltage_max_design_uv > 4250000) {
> > +				pdata->config_data->model_cfg =3D=20
MAX17055_MODELCFG_VCHG_BIT;
> > +				pdata->enable_por_init =3D true;
> > +			}
> > +		}
> > +	}
> > +
> >=20
> >  	return pdata;
> > =20
> >  }
> >  #endif
> >=20
> > @@ -1092,16 +1120,23 @@ static int max17042_probe(struct i2c_client
> > *client,>=20
> >  		return -EINVAL;
> >  =09
> >  	}
> >=20
> > +	i2c_set_clientdata(client, chip);
> > +	psy_cfg.drv_data =3D chip;
> > +	psy_cfg.of_node =3D dev->of_node;
> > +
> > +	chip->battery =3D devm_power_supply_register(&client->dev,=20
max17042_desc,
> > +						  =20
&psy_cfg);
> > +	if (IS_ERR(chip->battery)) {
> > +		dev_err(&client->dev, "failed: power supply=20
register\n");
> > +		return PTR_ERR(chip->battery);
> > +	}
>=20
> I don't think it is correct. You register power supply, thus making it
> available for system, before configuring most of the data. For short
> time the chip might report to the system bogus results and events.
>=20
> Instead I think you should split it into two parts - init which happens
> before registering power supply and after.

Simply splitting initialization into two parts won't really help. If you se=
t=20
capacity, current, Vchg and refresh the model after registering power suppl=
y,=20
you will still end up having a short time window with bogus results. Lookin=
g=20
at other drivers, they seem to deal with it in the same way - they register=
=20
the power supply early, before the driver can fully configure the device.

To actually fix the problem with bogus data on init, it seems like we would=
=20
either need some support from the power supply framework to notify it when =
can=20
it actually start expecting correct data, or have a way to access the batte=
ry=20
information without having to register power supply beforehand.

Since power_supply_get_battery_info doesn't actually seem to depend on=20
power_supply device at all - it uses psy->dev for devm functions and psy-
>of_node to read the data from - I wonder if it could be split into a funct=
ion=20
that only takes an of_node?

Cheers,
Sebastian
--nextPart1953021.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIt2frgBqEUNYNmF86PI1zzvbw/8FAmI3m6kACgkQ6PI1zzvb
w//V/RAA0a1votOuBG3+GSYf/qmf1Ayu015g/TYOxVR5jAdSALo71RgwYpf8kv8L
Kyp62170emlKkw5uX2P//jzNjlQfoARp1cM+d3fWJRaF3qOx5ehqw8VhiJ/pL8P3
SWubQM9QvyXdFBbpt9rMMU3oJPkWPASV24jpam+s+xd1vPvkzq3iXWTC6NZwkiwW
hAznWGmrtdDo/RCXn2ZM5Eeb6RBmO+Xe8zV9W1LCUIUZHvieYncNQLH9oN2lgNy2
1Duovvk/6CCZm5nuzSg+LiukwbvgG/uTu6MjTI2V3bU3FfhgzoeE9+XjYrwNOblU
VvSTs/TqZIbge+sUrtoRnafF4+nwsVMiHhNhIaBSKg9HYIIlnwbt0JfRTwZst0Pg
jnecxKV/08883byE6/u4f95/s1J9KCvdTQvLUib1sqXR4La58rJJ3ObJOMIFgWFD
bXSP7oTdpgDWC/rAk6BqpzCS/9+6OjRwrv1ozgsEkoyRpFSoZdjGYaUF1MolrSSz
NtDVu5ekpT7j1/sjdwP2mU6Zz6qWQG1KNBZ92VaRFN5zHQMfAOZ3O3YblDUjoqml
pH+1f806SqBNmS+H8KBaQrLdNBsER9CtE2fQ+dQ1TfQ4jVXkzfHY9MOxJjDidk3d
agKrlSX7vx48shXuFPIqzvhVUy2tVsEAEXvSB3HqL4mYrkUUdGg=
=LBbt
-----END PGP SIGNATURE-----

--nextPart1953021.CQOukoFCf9--



