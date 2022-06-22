Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847DD554711
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiFVIQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiFVIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:16:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B95437BEE;
        Wed, 22 Jun 2022 01:16:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 77E09DD;
        Wed, 22 Jun 2022 10:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655885791;
        bh=o/8M/AtaamVFopYKkMx1sa2lwn1VegUHtyrRHa/IWOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9p11OcIJcNLYNiqzb68LXCP4ckIJUTeYL2Hz0AunxMz/b6+gIdEmgsVqTLwr3SqB
         74cPcYzcz5qfiVawhNkcdu9KOcWH/LYlYfgBuB4KKXIBz6KdiOfrYyj3ap2zBlsmgT
         bvruwAu6UchrpT21oEhASXuEtpTef/ywJVZg6Fz4=
Date:   Wed, 22 Jun 2022 11:16:15 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rahul T R <r-ravikumar@ti.com>
Cc:     linux-phy@lists.infradead.org, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        p.yadav@ti.com, tomi.valkeinen@ideasonboard.com,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        sjakhade@cadence.com, mparab@cadence.com,
        devicetree@vger.kernel.org, vigneshr@ti.com, lee.jones@linaro.org
Subject: Re: [PATCH v2 2/3] phy: cdns-dphy: Add band config for dphy tx
Message-ID: <YrLPz8OTaMImArC4@pendragon.ideasonboard.com>
References: <20220622075340.16915-1-r-ravikumar@ti.com>
 <20220622075340.16915-3-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622075340.16915-3-r-ravikumar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

Thank you for the patch.

On Wed, Jun 22, 2022 at 01:23:39PM +0530, Rahul T R wrote:
> Add support for band ctrl config for dphy tx.
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  drivers/phy/cadence/cdns-dphy.c | 52 ++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> index ba042e39cfaf..ddfa524d8ce7 100644
> --- a/drivers/phy/cadence/cdns-dphy.c
> +++ b/drivers/phy/cadence/cdns-dphy.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>

Nitpicking, bitfield goes before bitops :-)

>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -45,6 +46,10 @@
>  #define DPHY_CMN_OPDIV_FROM_REG		BIT(6)
>  #define DPHY_CMN_OPDIV(x)		((x) << 7)
>  
> +#define DPHY_BAND_CFG			DPHY_PCS(0x0)
> +#define DPHY_BAND_CFG_LEFT_BAND		GENMASK(4, 0)
> +#define DPHY_BAND_CFG_RIGHT_BAND	GENMASK(9, 5)
> +
>  #define DPHY_PSM_CFG			DPHY_PCS(0x4)
>  #define DPHY_PSM_CFG_FROM_REG		BIT(0)
>  #define DPHY_PSM_CLK_DIV(x)		((x) << 1)
> @@ -92,6 +97,22 @@ struct cdns_dphy {
>  	struct phy *phy;
>  };
>  
> +struct cdns_dphy_band {
> +	unsigned int min_rate;
> +	unsigned int max_rate;
> +};
> +
> +/* Order of bands is important since the index is the band number. */
> +static struct cdns_dphy_band tx_bands[] = {

static const

> +	{80, 100}, {100, 120}, {120, 160}, {160, 200}, {200, 240},
> +	{240, 320}, {320, 390}, {390, 450}, {450, 510}, {510, 560},
> +	{560, 640}, {640, 690}, {690, 770}, {770, 870}, {870, 950},
> +	{950, 1000}, {1000, 1200}, {1200, 1400}, {1400, 1600}, {1600, 1800},
> +	{1800, 2000}, {2000, 2200}, {2200, 2500}

The max_rate value of band N is always equal to the min_rate value of
band N+1. Could we store one only ?

> +};
> +
> +static int num_tx_bands = ARRAY_SIZE(tx_bands);

You can use ARRAY_SIZE(tx_bands) directly below and drop this.

> +
>  static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
>  				     struct cdns_dphy_cfg *cfg,
>  				     struct phy_configure_opts_mipi_dphy *opts,
> @@ -232,6 +253,26 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
>  	return 0;
>  }
>  
> +static int cdns_dphy_tx_get_band_ctrl(unsigned long hs_clk_rate)
> +{
> +	unsigned int rate;
> +	int i;
> +
> +	rate = hs_clk_rate / 1000000UL;
> +
> +	if (rate < tx_bands[0].min_rate || rate >= tx_bands[num_tx_bands - 1].max_rate)
> +		return -EOPNOTSUPP;
> +
> +	for (i = 0; i < num_tx_bands; i++) {
> +		if (rate >= tx_bands[i].min_rate && rate < tx_bands[i].max_rate)
> +			return i;
> +	}
> +
> +	/* Unreachable. */
> +	WARN(1, "Reached unreachable code.");

I'd drop the WARN() if it's really unreachable.

> +	return -EINVAL;
> +}
> +
>  static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
>  			      union phy_configure_opts *opts)
>  {
> @@ -247,7 +288,8 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
>  {
>  	struct cdns_dphy *dphy = phy_get_drvdata(phy);
>  	struct cdns_dphy_cfg cfg = { 0 };
> -	int ret;
> +	int ret, band_ctrl;
> +	unsigned int reg;
>  
>  	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
>  	if (ret)
> @@ -276,6 +318,14 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
>  	 */
>  	cdns_dphy_set_pll_cfg(dphy, &cfg);
>  
> +	band_ctrl = cdns_dphy_tx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
> +	if (band_ctrl < 0)
> +		return band_ctrl;
> +
> +	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
> +	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
> +	writel(reg, dphy->regs + DPHY_BAND_CFG);
> +
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
