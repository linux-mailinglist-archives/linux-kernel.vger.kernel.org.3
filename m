Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA447DEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbhLWFgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346414AbhLWFgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:36:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8CEC061401;
        Wed, 22 Dec 2021 21:36:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 659DAB81EA5;
        Thu, 23 Dec 2021 05:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8B5C36AE5;
        Thu, 23 Dec 2021 05:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640237794;
        bh=+RESyguACPEDh1QytdBXRrgftqqCYuF45pA3Mr9Wjxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+B4fqLuFIRpKY4PBoPuzC9E+gil3cRxeN4MSMcE0Hppy+Zt6KIU44I12ZCBLPdlf
         i3ElEdyK2+UclrKL2BtzQnoJ95nhXnzOz7gbgwTNHTjlj0laLTa7M9ifI6dZQ6vL7G
         U78XZLkeyxkxIgzm1w4vFb5cuuvXuOCmKFiScF5iabrOZwUPS3vIrkHSAIN59O9rls
         kg9/qaWTB+SKOg1Z5ddg38N7xijd10OTJyKPazAoxX4HmTOaveA5TJbOalaAy3eQLG
         I8ZGZJZVSOa21DrWdbz9SbNWzlxRX6d4syPwv8LT1SXlrE8Nf4qEbTk6uWRvnt4Jgj
         fHR/7xxRU7z4w==
Date:   Thu, 23 Dec 2021 11:06:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v6 1/4] phy: cadence: Add Cadence D-PHY Rx driver
Message-ID: <YcQK3WVEo6FyEtVa@matsya>
References: <20211214180703.3268-1-p.yadav@ti.com>
 <20211214180703.3268-2-p.yadav@ti.com>
 <YcCh1PU+Tc1+pzEL@aptenodytes>
 <20211222184545.atci25onvpw6f2ed@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222184545.atci25onvpw6f2ed@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-21, 00:15, Pratyush Yadav wrote:
> On 20/12/21 04:31PM, Paul Kocialkowski wrote:
> > Hi Pratyush,
> > 
> > On Tue 14 Dec 21, 23:37, Pratyush Yadav wrote:
> > > The Cadence D-PHY can be configured in Tx (DSI) mode or Rx (CSI) mode.
> > > Both modes have a different programming sequence and share little among
> > > them. In addition, a PHY configured in Tx mode cannot be used in Rx mode
> > > and vice versa. For this reason, create a separate driver for the Rx
> > > mode to make it easier to read and maintain.
> > > 
> > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > 
> > > ---
> > > 
> > > Changes in v6:
> > > - Move to a separate driver.
> > > 
> > > Changes in v5:
> > > - Use the new cdns_dphy_info to specify PHY ops.
> > > - Re-order include in alphabetical order.
> > > - Make bands const.
> > > - Drop num_bands.
> > > - Make i, lanes unsigned.
> > > - Drop the maximum check in cdns_dphy_rx_get_band_ctrl(). Let the loop
> > >   complete and return -EOPNOTSUPP when we reach the end.
> > > - Drop the "rate < bands[i].min_rate" check since the bands are in
> > >   ascending order.
> > > - Move data_lane_ctrl to start of function and make it static const.
> > > 
> > > Changes in v4:
> > > - Drop the submode parts. Use a different compatible for the Rx ops.
> > > - Make bands and num_bands static.
> > > 
> > > Changes in v3:
> > > - Use a table to select the band.
> > > - Use a table to poll the data lane ready bits.
> > > - Multiply the DPHY HS clock rate by 2 to get the bit rate since the
> > >   clock is DDR.
> > > 
> > >  drivers/phy/cadence/Kconfig        |   8 +
> > >  drivers/phy/cadence/Makefile       |   1 +
> > >  drivers/phy/cadence/cdns-dphy-rx.c | 250 +++++++++++++++++++++++++++++
> > >  3 files changed, 259 insertions(+)
> > >  create mode 100644 drivers/phy/cadence/cdns-dphy-rx.c
> > > 
> > > diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> > > index a62910ff5591..1adde2d99ae7 100644
> > > --- a/drivers/phy/cadence/Kconfig
> > > +++ b/drivers/phy/cadence/Kconfig
> > > @@ -22,6 +22,14 @@ config PHY_CADENCE_DPHY
> > >  	  system. If M is selected, the module will be called
> > >  	  cdns-dphy.
> > >  
> > > +config PHY_CADENCE_DPHY_RX
> > > +	tristate "Cadence D-PHY Rx Support"
> > > +	depends on HAS_IOMEM && OF
> > > +	select GENERIC_PHY
> > > +	select GENERIC_PHY_MIPI_DPHY
> > > +	help
> > > +	  Support for Cadence D-PHY in Rx configuration.
> > > +
> > >  config PHY_CADENCE_SIERRA
> > >  	tristate "Cadence Sierra PHY Driver"
> > >  	depends on OF && HAS_IOMEM && RESET_CONTROLLER
> > > diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
> > > index 26e16bd34efe..e17f035ddece 100644
> > > --- a/drivers/phy/cadence/Makefile
> > > +++ b/drivers/phy/cadence/Makefile
> > > @@ -1,5 +1,6 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  obj-$(CONFIG_PHY_CADENCE_TORRENT)	+= phy-cadence-torrent.o
> > >  obj-$(CONFIG_PHY_CADENCE_DPHY)	+= cdns-dphy.o
> > > +obj-$(CONFIG_PHY_CADENCE_DPHY_RX)	+= cdns-dphy-rx.o
> > >  obj-$(CONFIG_PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
> > >  obj-$(CONFIG_PHY_CADENCE_SALVO)	+= phy-cadence-salvo.o
> > > diff --git a/drivers/phy/cadence/cdns-dphy-rx.c b/drivers/phy/cadence/cdns-dphy-rx.c
> > > new file mode 100644
> > > index 000000000000..fb75e645e662
> > > --- /dev/null
> > > +++ b/drivers/phy/cadence/cdns-dphy-rx.c
> > > @@ -0,0 +1,250 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/module.h>
> > > +#include <linux/phy/phy.h>
> > > +#include <linux/phy/phy-mipi-dphy.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#define DPHY_PMA_CMN(reg)		(reg)
> > > +#define DPHY_PCS(reg)			(0xb00 + (reg))
> > > +#define DPHY_ISO(reg)			(0xc00 + (reg))
> > > +
> > > +#define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
> > > +#define DPHY_CMN_RX_MODE_EN		BIT(10)
> > > +#define DPHY_CMN_RX_BANDGAP_TIMER_MASK	GENMASK(8, 1)
> > > +#define DPHY_CMN_SSM_EN			BIT(0)
> > > +
> > > +#define DPHY_CMN_RX_BANDGAP_TIMER	0x14
> > > +
> > > +#define DPHY_BAND_CFG			DPHY_PCS(0x0)
> > > +#define DPHY_BAND_CFG_RIGHT_BAND	GENMASK(9, 5)
> > > +#define DPHY_BAND_CFG_LEFT_BAND		GENMASK(4, 0)
> > > +
> > > +#define DPHY_POWER_ISLAND_EN_DATA	DPHY_PCS(0x8)
> > > +#define DPHY_POWER_ISLAND_EN_DATA_VAL	0xaaaaaaaa
> > > +
> > > +#define DPHY_POWER_ISLAND_EN_CLK	DPHY_PCS(0xc)
> > > +#define DPHY_POWER_ISLAND_EN_CLK_VAL	0xaa
> > > +
> > > +#define DPHY_ISO_CL_CTRL_L		DPHY_ISO(0x10)
> > > +#define DPHY_ISO_DL_CTRL_L0		DPHY_ISO(0x14)
> > > +#define DPHY_ISO_DL_CTRL_L1		DPHY_ISO(0x20)
> > > +#define DPHY_ISO_DL_CTRL_L2		DPHY_ISO(0x30)
> > > +#define DPHY_ISO_DL_CTRL_L3		DPHY_ISO(0x3c)
> > > +
> > > +#define DPHY_ISO_LANE_READY_BIT		0
> > > +#define DPHY_ISO_LANE_READY_TIMEOUT_MS	100UL
> > > +
> > > +#define DPHY_LANES_MIN			1
> > > +#define DPHY_LANES_MAX			4
> > > +
> > > +struct cdns_dphy_rx {
> > > +	void __iomem *regs;
> > > +	struct device *dev;
> > > +	struct phy *phy;
> > > +};
> > > +
> > > +struct cdns_dphy_rx_band {
> > > +	/* Rates are in Mbps. */
> > > +	unsigned int min_rate;
> > > +	unsigned int max_rate;
> > > +};
> > > +
> > > +/* Order of bands is important since the index is the band number. */
> > > +static const struct cdns_dphy_rx_band bands[] = {
> > > +	{80, 100}, {100, 120}, {120, 160}, {160, 200}, {200, 240},
> > > +	{240, 280}, {280, 320}, {320, 360}, {360, 400}, {400, 480},
> > > +	{480, 560}, {560, 640}, {640, 720}, {720, 800}, {800, 880},
> > > +	{880, 1040}, {1040, 1200}, {1200, 1350}, {1350, 1500}, {1500, 1750},
> > > +	{1750, 2000}, {2000, 2250}, {2250, 2500}
> > 
> > Cosmetic suggestion: add whitespaces after { and before }.
> 
> I think it would just add noise. I would like to keep it compact.

No, it makes it look lot more neater and is usually the convention
followed in kernel

-- 
~Vinod
