Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8183E4BFA75
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiBVOLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiBVOLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:11:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6625615F62B;
        Tue, 22 Feb 2022 06:10:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDFA961490;
        Tue, 22 Feb 2022 14:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1E6C340F0;
        Tue, 22 Feb 2022 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645539039;
        bh=mIAp2LLc6xWWL3o5yI6XQYBeO/1InohcDH9qSKGds5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFi8tmZzVKR2gc3QK92t/eb+wmnLiB8Qndgqvdauqi4eJC/OHPNC1Xq2vrU9BeEkZ
         3hJRL3L31SG2jTX2iMvPmXamNTgKfWA2pThCQLMa8YQZVxivopvD/1aG1xA80lkJeo
         uP4LSbGhrzSDSDAtV56A8t4SKpdYZYrnC8+7tPZ35KL9YldUcaL+j1Lez1r08II4Xg
         37Ebr+zyzI/uR3WtG8DoW/8DzIDek0afFEQx1mu6EqU1Vbdi1MJxU2/LjfIhLByggX
         I0xe57F1Anf5BDNS1iEnLXW2tvHCNHszmyQvdz59Gv2dlPpzlzqzpnvaEAFEfTbzEd
         EBnTZSB6Nh6fA==
Date:   Tue, 22 Feb 2022 19:40:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v9 1/4] phy: cadence: Add Cadence D-PHY Rx driver
Message-ID: <YhTu2ixdWBKU1Y8y@matsya>
References: <20220131173314.2073641-1-p.yadav@ti.com>
 <20220131173314.2073641-2-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131173314.2073641-2-p.yadav@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-22, 23:03, Pratyush Yadav wrote:
> The Cadence D-PHY can be configured in Tx (DSI) mode or Rx (CSI) mode.
> Both modes have a different programming sequence and share little among
> them. In addition, a PHY configured in Tx mode cannot be used in Rx mode
> and vice versa. For this reason, create a separate driver for the Rx
> mode to make it easier to read and maintain.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> 
> Changes in v9:
> - Use %ld instead of %d for printing PTR_ERR().
> 
> Changes in v8:
> - Move lanes check to start of configure sequence.
> - Change MODULE_LICENSE() to "GPL".
> - Add Laurent's R-by.
> 
> Changes in v7:
> - Add spaces after { and before } in the bands table.
> - Drop the wrapping around the for loop on cdns_dphy_rx_get_band_ctrl().
> - Make cdns_dphy_rx_wait_for_bit() inline.
> - Print an error message if registering PHY provider fails.
> 
> Changes in v6:
> - Move to a separate driver.
> 
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
> 
> Changes in v4:
> - Drop the submode parts. Use a different compatible for the Rx ops.
> - Make bands and num_bands static.
> 
> Changes in v3:
> - Use a table to select the band.
> - Use a table to poll the data lane ready bits.
> - Multiply the DPHY HS clock rate by 2 to get the bit rate since the
>   clock is DDR.
> 
>  drivers/phy/cadence/Kconfig        |   8 +
>  drivers/phy/cadence/Makefile       |   1 +
>  drivers/phy/cadence/cdns-dphy-rx.c | 255 +++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+)
>  create mode 100644 drivers/phy/cadence/cdns-dphy-rx.c
> 
> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> index a62910ff5591..1adde2d99ae7 100644
> --- a/drivers/phy/cadence/Kconfig
> +++ b/drivers/phy/cadence/Kconfig
> @@ -22,6 +22,14 @@ config PHY_CADENCE_DPHY
>  	  system. If M is selected, the module will be called
>  	  cdns-dphy.
>  
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
>  obj-$(CONFIG_PHY_CADENCE_TORRENT)	+= phy-cadence-torrent.o
>  obj-$(CONFIG_PHY_CADENCE_DPHY)	+= cdns-dphy.o
> +obj-$(CONFIG_PHY_CADENCE_DPHY_RX)	+= cdns-dphy-rx.o
>  obj-$(CONFIG_PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
>  obj-$(CONFIG_PHY_CADENCE_SALVO)	+= phy-cadence-salvo.o
> diff --git a/drivers/phy/cadence/cdns-dphy-rx.c b/drivers/phy/cadence/cdns-dphy-rx.c
> new file mode 100644
> index 000000000000..c9bb8c7f16f6
> --- /dev/null
> +++ b/drivers/phy/cadence/cdns-dphy-rx.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0+

GPL v2 and more...

> +/*
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/

this should say 2022 as well

> +MODULE_AUTHOR("Pratyush Yadav <p.yadav@ti.com>");
> +MODULE_DESCRIPTION("Cadence D-PHY Rx Driver");
> +MODULE_LICENSE("GPL");

This means GPL v2 only and does not match SPDX tag, pls update

-- 
~Vinod
