Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AABD47B059
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhLTPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:32:00 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:48173 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbhLTPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:31:36 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 780D9240014;
        Mon, 20 Dec 2021 15:31:33 +0000 (UTC)
Date:   Mon, 20 Dec 2021 16:31:32 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v6 1/4] phy: cadence: Add Cadence D-PHY Rx driver
Message-ID: <YcCh1PU+Tc1+pzEL@aptenodytes>
References: <20211214180703.3268-1-p.yadav@ti.com>
 <20211214180703.3268-2-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4h0HZ6Zr1Kjo6M2j"
Content-Disposition: inline
In-Reply-To: <20211214180703.3268-2-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4h0HZ6Zr1Kjo6M2j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pratyush,

On Tue 14 Dec 21, 23:37, Pratyush Yadav wrote:
> The Cadence D-PHY can be configured in Tx (DSI) mode or Rx (CSI) mode.
> Both modes have a different programming sequence and share little among
> them. In addition, a PHY configured in Tx mode cannot be used in Rx mode
> and vice versa. For this reason, create a separate driver for the Rx
> mode to make it easier to read and maintain.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>=20
> ---
>=20
> Changes in v6:
> - Move to a separate driver.
>=20
> Changes in v5:
> - Use the new cdns_dphy_info to specify PHY ops.
> - Re-order include in alphabetical order.
> - Make bands const.
> - Drop num_bands.
> - Make i, lanes unsigned.
> - Drop the maximum check in cdns_dphy_rx_get_band_ctrl(). Let the loop
>   complete and return -EOPNOTSUPP when we reach the end.
> - Drop the "rate < bands[i].min_rate" check since the bands are in
>   ascending order.
> - Move data_lane_ctrl to start of function and make it static const.
>=20
> Changes in v4:
> - Drop the submode parts. Use a different compatible for the Rx ops.
> - Make bands and num_bands static.
>=20
> Changes in v3:
> - Use a table to select the band.
> - Use a table to poll the data lane ready bits.
> - Multiply the DPHY HS clock rate by 2 to get the bit rate since the
>   clock is DDR.
>=20
>  drivers/phy/cadence/Kconfig        |   8 +
>  drivers/phy/cadence/Makefile       |   1 +
>  drivers/phy/cadence/cdns-dphy-rx.c | 250 +++++++++++++++++++++++++++++
>  3 files changed, 259 insertions(+)
>  create mode 100644 drivers/phy/cadence/cdns-dphy-rx.c
>=20
> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> index a62910ff5591..1adde2d99ae7 100644
> --- a/drivers/phy/cadence/Kconfig
> +++ b/drivers/phy/cadence/Kconfig
> @@ -22,6 +22,14 @@ config PHY_CADENCE_DPHY
>  	  system. If M is selected, the module will be called
>  	  cdns-dphy.
> =20
> +config PHY_CADENCE_DPHY_RX
> +	tristate "Cadence D-PHY Rx Support"
> +	depends on HAS_IOMEM && OF
> +	select GENERIC_PHY
> +	select GENERIC_PHY_MIPI_DPHY
> +	help
> +	  Support for Cadence D-PHY in Rx configuration.
> +
>  config PHY_CADENCE_SIERRA
>  	tristate "Cadence Sierra PHY Driver"
>  	depends on OF && HAS_IOMEM && RESET_CONTROLLER
> diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
> index 26e16bd34efe..e17f035ddece 100644
> --- a/drivers/phy/cadence/Makefile
> +++ b/drivers/phy/cadence/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_PHY_CADENCE_TORRENT)	+=3D phy-cadence-torrent.o
>  obj-$(CONFIG_PHY_CADENCE_DPHY)	+=3D cdns-dphy.o
> +obj-$(CONFIG_PHY_CADENCE_DPHY_RX)	+=3D cdns-dphy-rx.o
>  obj-$(CONFIG_PHY_CADENCE_SIERRA)	+=3D phy-cadence-sierra.o
>  obj-$(CONFIG_PHY_CADENCE_SALVO)	+=3D phy-cadence-salvo.o
> diff --git a/drivers/phy/cadence/cdns-dphy-rx.c b/drivers/phy/cadence/cdn=
s-dphy-rx.c
> new file mode 100644
> index 000000000000..fb75e645e662
> --- /dev/null
> +++ b/drivers/phy/cadence/cdns-dphy-rx.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.co=
m/
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/phy-mipi-dphy.h>
> +#include <linux/platform_device.h>
> +
> +#define DPHY_PMA_CMN(reg)		(reg)
> +#define DPHY_PCS(reg)			(0xb00 + (reg))
> +#define DPHY_ISO(reg)			(0xc00 + (reg))
> +
> +#define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
> +#define DPHY_CMN_RX_MODE_EN		BIT(10)
> +#define DPHY_CMN_RX_BANDGAP_TIMER_MASK	GENMASK(8, 1)
> +#define DPHY_CMN_SSM_EN			BIT(0)
> +
> +#define DPHY_CMN_RX_BANDGAP_TIMER	0x14
> +
> +#define DPHY_BAND_CFG			DPHY_PCS(0x0)
> +#define DPHY_BAND_CFG_RIGHT_BAND	GENMASK(9, 5)
> +#define DPHY_BAND_CFG_LEFT_BAND		GENMASK(4, 0)
> +
> +#define DPHY_POWER_ISLAND_EN_DATA	DPHY_PCS(0x8)
> +#define DPHY_POWER_ISLAND_EN_DATA_VAL	0xaaaaaaaa
> +
> +#define DPHY_POWER_ISLAND_EN_CLK	DPHY_PCS(0xc)
> +#define DPHY_POWER_ISLAND_EN_CLK_VAL	0xaa
> +
> +#define DPHY_ISO_CL_CTRL_L		DPHY_ISO(0x10)
> +#define DPHY_ISO_DL_CTRL_L0		DPHY_ISO(0x14)
> +#define DPHY_ISO_DL_CTRL_L1		DPHY_ISO(0x20)
> +#define DPHY_ISO_DL_CTRL_L2		DPHY_ISO(0x30)
> +#define DPHY_ISO_DL_CTRL_L3		DPHY_ISO(0x3c)
> +
> +#define DPHY_ISO_LANE_READY_BIT		0
> +#define DPHY_ISO_LANE_READY_TIMEOUT_MS	100UL
> +
> +#define DPHY_LANES_MIN			1
> +#define DPHY_LANES_MAX			4
> +
> +struct cdns_dphy_rx {
> +	void __iomem *regs;
> +	struct device *dev;
> +	struct phy *phy;
> +};
> +
> +struct cdns_dphy_rx_band {
> +	/* Rates are in Mbps. */
> +	unsigned int min_rate;
> +	unsigned int max_rate;
> +};
> +
> +/* Order of bands is important since the index is the band number. */
> +static const struct cdns_dphy_rx_band bands[] =3D {
> +	{80, 100}, {100, 120}, {120, 160}, {160, 200}, {200, 240},
> +	{240, 280}, {280, 320}, {320, 360}, {360, 400}, {400, 480},
> +	{480, 560}, {560, 640}, {640, 720}, {720, 800}, {800, 880},
> +	{880, 1040}, {1040, 1200}, {1200, 1350}, {1350, 1500}, {1500, 1750},
> +	{1750, 2000}, {2000, 2250}, {2250, 2500}

Cosmetic suggestion: add whitespaces after { and before }.

> +};
> +
> +static int cdns_dphy_rx_power_on(struct phy *phy)
> +{
> +	struct cdns_dphy_rx *dphy =3D phy_get_drvdata(phy);
> +
> +	/* Start RX state machine. */
> +	writel(DPHY_CMN_SSM_EN | DPHY_CMN_RX_MODE_EN |
> +	       FIELD_PREP(DPHY_CMN_RX_BANDGAP_TIMER_MASK,
> +			  DPHY_CMN_RX_BANDGAP_TIMER),
> +	       dphy->regs + DPHY_CMN_SSM);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_power_off(struct phy *phy)
> +{
> +	struct cdns_dphy_rx *dphy =3D phy_get_drvdata(phy);
> +
> +	writel(0, dphy->regs + DPHY_CMN_SSM);
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_get_band_ctrl(unsigned long hs_clk_rate)
> +{
> +	unsigned int rate, i;
> +
> +	rate =3D hs_clk_rate / 1000000UL;
> +	/* Since CSI-2 clock is DDR, the bit rate is twice the clock rate. */
> +	rate *=3D 2;
> +
> +	if (rate < bands[0].min_rate)
> +		return -EOPNOTSUPP;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(bands); i++) {
> +		if (rate < bands[i].max_rate)
> +			return i;
> +	}

Comstic: you don't need the wrapping { and } here.

> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int cdns_dphy_rx_wait_for_bit(void __iomem *addr, unsigned int bi=
t)

You can probably inline this one.

> +{
> +	u32 val;
> +
> +	return readl_relaxed_poll_timeout(addr, val, val & BIT(bit), 10,
> +					  DPHY_ISO_LANE_READY_TIMEOUT_MS * 1000);
> +}
> +
> +static int cdns_dphy_rx_wait_lane_ready(struct cdns_dphy_rx *dphy,
> +					unsigned int lanes)
> +{
> +	static const u32 data_lane_ctrl[] =3D {DPHY_ISO_DL_CTRL_L0,
> +					     DPHY_ISO_DL_CTRL_L1,
> +					     DPHY_ISO_DL_CTRL_L2,
> +					     DPHY_ISO_DL_CTRL_L3};
> +	void __iomem *reg =3D dphy->regs;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Data lanes. Minimum one lane is mandatory. */
> +	if (lanes < DPHY_LANES_MIN || lanes > DPHY_LANES_MAX)
> +		return -EINVAL;
> +
> +	/* Clock lane */
> +	ret =3D cdns_dphy_rx_wait_for_bit(reg + DPHY_ISO_CL_CTRL_L,
> +					DPHY_ISO_LANE_READY_BIT);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < lanes; i++) {
> +		ret =3D cdns_dphy_rx_wait_for_bit(reg + data_lane_ctrl[i],
> +						DPHY_ISO_LANE_READY_BIT);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_configure(struct phy *phy,
> +				  union phy_configure_opts *opts)
> +{
> +	struct cdns_dphy_rx *dphy =3D phy_get_drvdata(phy);
> +	unsigned int reg;
> +	int band_ctrl, ret;
> +
> +	band_ctrl =3D cdns_dphy_rx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
> +	if (band_ctrl < 0)
> +		return band_ctrl;
> +
> +	reg =3D FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
> +	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
> +	writel(reg, dphy->regs + DPHY_BAND_CFG);
> +
> +	/*
> +	 * Set the required power island phase 2 time. This is mandated by DPHY
> +	 * specs.
> +	 */
> +	reg =3D DPHY_POWER_ISLAND_EN_DATA_VAL;
> +	writel(reg, dphy->regs + DPHY_POWER_ISLAND_EN_DATA);
> +	reg =3D DPHY_POWER_ISLAND_EN_CLK_VAL;
> +	writel(reg, dphy->regs + DPHY_POWER_ISLAND_EN_CLK);
> +
> +	ret =3D cdns_dphy_rx_wait_lane_ready(dphy, opts->mipi_dphy.lanes);
> +	if (ret) {
> +		dev_err(dphy->dev, "DPHY wait for lane ready timeout\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_dphy_rx_validate(struct phy *phy, enum phy_mode mode,
> +				 int submode, union phy_configure_opts *opts)
> +{
> +	int ret;
> +
> +	if (mode !=3D PHY_MODE_MIPI_DPHY)
> +		return -EINVAL;
> +
> +	ret =3D cdns_dphy_rx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_mipi_dphy_config_validate(&opts->mipi_dphy);
> +}
> +
> +static const struct phy_ops cdns_dphy_rx_ops =3D {
> +	.power_on =3D cdns_dphy_rx_power_on,
> +	.power_off =3D cdns_dphy_rx_power_off,
> +	.configure =3D cdns_dphy_rx_configure,
> +	.validate =3D cdns_dphy_rx_validate,
> +};
> +
> +static int cdns_dphy_rx_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct phy_provider *provider;
> +	struct cdns_dphy_rx *dphy;
> +
> +	dphy =3D devm_kzalloc(dev, sizeof(*dphy), GFP_KERNEL);
> +	if (!dphy)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, dphy);

It looks like you're never getting the dphy pointer from dev so this seems =
a bit
pointless.

> +	dphy->dev =3D dev;
> +
> +	dphy->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dphy->regs))
> +		return PTR_ERR(dphy->regs);
> +
> +	dphy->phy =3D devm_phy_create(dev, NULL, &cdns_dphy_rx_ops);
> +	if (IS_ERR(dphy->phy)) {
> +		dev_err(dev, "Failed to create PHY: %d\n", PTR_ERR(dphy->phy));
> +		return PTR_ERR(dphy->phy);
> +	}
> +
> +	phy_set_drvdata(dphy->phy, dphy);
> +	provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);

You might want to print an error message if it failed to register.

> +
> +	return PTR_ERR_OR_ZERO(provider);
> +}
> +
> +static const struct of_device_id cdns_dphy_rx_of_match[] =3D {
> +	{ .compatible =3D "cdns,dphy-rx" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, cdns_dphy_rx_of_match);
> +
> +static struct platform_driver cdns_dphy_rx_platform_driver =3D {
> +	.probe		=3D cdns_dphy_rx_probe,
> +	.driver		=3D {
> +		.name		=3D "cdns-mipi-dphy-rx",
> +		.of_match_table	=3D cdns_dphy_rx_of_match,
> +	},
> +};
> +module_platform_driver(cdns_dphy_rx_platform_driver);
> +
> +MODULE_AUTHOR("Pratyush Yadav <p.yadav@ti.com>");
> +MODULE_DESCRIPTION("Cadence D-PHY Rx Driver");
> +MODULE_LICENSE("GPL v2");

Otherwise this looks good to me!

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--4h0HZ6Zr1Kjo6M2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmHAodQACgkQ3cLmz3+f
v9HmxQf/VeHHhcqtjJHpGGlGHc5Sj3gndLwFNRxc6wcDmUgVMKal7/z2w+OZF8DW
8HoaqbPe5iMaZ4+M8WG69lx81MHSArMXpExXEIdSqSFYs1JQNKNplmiBcjjvZFxX
uJQilAczmdlHkc+WmsaaKoy4YLL/vIUS2ev9/ckntS+xeAF+qNUZbsepjaAqCSyH
qoRn9dmgyjGf+QIV14/+G+QSHlEY3fv04eoGH2MeOcqNMMFKSHyIjMy5nwK6Zfjv
ijUad8AO0wNcU/hOh5CRD2o1HP42IKjmeOqSaRVbJ1Duq6H1Z3w/xzIRU41W99aM
nUc+VVnwOjK0sORcf5I5ltFe4v2JFQ==
=LnRz
-----END PGP SIGNATURE-----

--4h0HZ6Zr1Kjo6M2j--
