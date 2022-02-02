Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557AF4A72EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbiBBOXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:23:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57702 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344876AbiBBOXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:23:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3BFEB830FB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 14:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D83C340F1;
        Wed,  2 Feb 2022 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643811816;
        bh=yRW7aX34kBy09ULJ1/57Oop+qYUD05uihoxV2PwjzCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJ/wiMlq782maSD9+LqnMN/rpqkmPd0iECS++9E1GVo/w6cswSDacj9WjYmdJoj9f
         naI5Q2e0GvQCODbf4m+Yf1f1nspMYX5MXt660E0uV8ZlWPEMrRV/hqTatCIn7eJs5Y
         P3MvZN/7HIiU+arYvoC6p0G2jGxOkOzWBVXIgclIy0jCfCb9gi2+lqUXEdfbnroKAW
         MfqQCpxl8VJntCR4M5jlUyjkJweyiBS7ifw4mHvaA/U7wC5gjxFUFtpZShImrdWxy/
         gEcWa8qvsKE10HLFEPXFWjY/A/P4aQDgXlBEfHCx/7CwcMuxFLSMf5wRX5+QOUCxTg
         JXkjce8FG0zFA==
Date:   Wed, 2 Feb 2022 19:53:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: cadence: Sierra: Add support for skipping
 configuration
Message-ID: <YfqT444YoGBIturt@matsya>
References: <20220128072642.29188-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128072642.29188-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-22, 12:56, Aswath Govindraju wrote:
> In some cases, a single SerDes instance can be shared between two different
> processors, each using a separate link. In these cases, the SerDes
> configuration is done in an earlier boot stage. Therefore, add support to
> skip reconfiguring, if it is was already configured beforehand.

This fails to apply, pls rebase and resend

> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Changes since v1:
> - Removed redundant braces
> - Corrected the logic for skipping multilink configuration
> - Corrected the order in failure path
> 
>  drivers/phy/cadence/phy-cadence-sierra.c | 82 ++++++++++++++++--------
>  1 file changed, 57 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
> index e265647e29a2..6b917f7bddbe 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -370,6 +370,7 @@ struct cdns_sierra_phy {
>  	int nsubnodes;
>  	u32 num_lanes;
>  	bool autoconf;
> +	int already_configured;
>  	struct clk_onecell_data clk_data;
>  	struct clk *output_clks[CDNS_SIERRA_OUTPUT_CLOCKS];
>  };
> @@ -517,7 +518,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
>  	int i, j;
>  
>  	/* Initialise the PHY registers, unless auto configured */
> -	if (phy->autoconf || phy->nsubnodes > 1)
> +	if (phy->autoconf || phy->already_configured || phy->nsubnodes > 1)
>  		return 0;
>  
>  	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
> @@ -646,6 +647,18 @@ static const struct phy_ops ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static int cdns_sierra_noop_phy_on(struct phy *gphy)
> +{
> +	usleep_range(5000, 10000);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops noop_ops = {
> +	.power_on	= cdns_sierra_noop_phy_on,
> +	.owner		= THIS_MODULE,
> +};
> +
>  static u8 cdns_sierra_pll_mux_get_parent(struct clk_hw *hw)
>  {
>  	struct cdns_sierra_pll_mux *mux = to_cdns_sierra_pll_mux(hw);
> @@ -1118,13 +1131,6 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
>  	struct clk *clk;
>  	int ret;
>  
> -	clk = devm_clk_get_optional(dev, "phy_clk");
> -	if (IS_ERR(clk)) {
> -		dev_err(dev, "failed to get clock phy_clk\n");
> -		return PTR_ERR(clk);
> -	}
> -	sp->input_clks[PHY_CLK] = clk;
> -
>  	clk = devm_clk_get_optional(dev, "cmn_refclk_dig_div");
>  	if (IS_ERR(clk)) {
>  		dev_err(dev, "cmn_refclk_dig_div clock not found\n");
> @@ -1160,17 +1166,33 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
>  	return 0;
>  }
>  
> -static int cdns_sierra_phy_enable_clocks(struct cdns_sierra_phy *sp)
> +static int cdns_sierra_phy_clk(struct cdns_sierra_phy *sp)
>  {
> +	struct device *dev = sp->dev;
> +	struct clk *clk;
>  	int ret;
>  
> +	clk = devm_clk_get_optional(dev, "phy_clk");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "failed to get clock phy_clk\n");
> +		return PTR_ERR(clk);
> +	}
> +	sp->input_clks[PHY_CLK] = clk;
> +
>  	ret = clk_prepare_enable(sp->input_clks[PHY_CLK]);
>  	if (ret)
>  		return ret;
>  
> +	return 0;
> +}
> +
> +static int cdns_sierra_phy_enable_clocks(struct cdns_sierra_phy *sp)
> +{
> +	int ret;
> +
>  	ret = clk_prepare_enable(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
>  	if (ret)
> -		goto err_pll_cmnlc;
> +		return ret;
>  
>  	ret = clk_prepare_enable(sp->output_clks[CDNS_SIERRA_PLL_CMNLC1]);
>  	if (ret)
> @@ -1181,9 +1203,6 @@ static int cdns_sierra_phy_enable_clocks(struct cdns_sierra_phy *sp)
>  err_pll_cmnlc1:
>  	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
>  
> -err_pll_cmnlc:
> -	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
> -
>  	return ret;
>  }
>  
> @@ -1191,7 +1210,8 @@ static void cdns_sierra_phy_disable_clocks(struct cdns_sierra_phy *sp)
>  {
>  	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC1]);
>  	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
> -	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
> +	if (!sp->already_configured)
> +		clk_disable_unprepare(sp->input_clks[PHY_CLK]);
>  }
>  
>  static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
> @@ -1382,22 +1402,30 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = cdns_sierra_phy_get_resets(sp, dev);
> -	if (ret)
> -		goto unregister_clk;
> -
>  	ret = cdns_sierra_phy_enable_clocks(sp);
>  	if (ret)
>  		goto unregister_clk;
>  
> -	/* Enable APB */
> -	reset_control_deassert(sp->apb_rst);
> +	regmap_field_read(sp->pma_cmn_ready, &sp->already_configured);
> +
> +	if (!sp->already_configured) {
> +		ret = cdns_sierra_phy_clk(sp);
> +		if (ret)
> +			goto clk_disable;
> +
> +		ret = cdns_sierra_phy_get_resets(sp, dev);
> +		if (ret)
> +			goto clk_disable;
> +
> +		/* Enable APB */
> +		reset_control_deassert(sp->apb_rst);
> +	}
>  
>  	/* Check that PHY is present */
>  	regmap_field_read(sp->macro_id_type, &id_value);
>  	if  (sp->init_data->id_value != id_value) {
>  		ret = -EINVAL;
> -		goto clk_disable;
> +		goto ctrl_assert;
>  	}
>  
>  	sp->autoconf = of_property_read_bool(dn, "cdns,autoconf");
> @@ -1433,8 +1461,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>  
>  		sp->num_lanes += sp->phys[node].num_lanes;
>  
> -		gphy = devm_phy_create(dev, child, &ops);
> -
> +		if (!sp->already_configured)
> +			gphy = devm_phy_create(dev, child, &ops);
> +		else
> +			gphy = devm_phy_create(dev, child, &noop_ops);
>  		if (IS_ERR(gphy)) {
>  			ret = PTR_ERR(gphy);
>  			of_node_put(child);
> @@ -1455,7 +1485,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>  	}
>  
>  	/* If more than one subnode, configure the PHY as multilink */
> -	if (!sp->autoconf && sp->nsubnodes > 1) {
> +	if (!sp->already_configured && !sp->autoconf && sp->nsubnodes > 1) {
>  		ret = cdns_sierra_phy_configure_multilink(sp);
>  		if (ret)
>  			goto put_control;
> @@ -1473,9 +1503,11 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>  put_control:
>  	while (--node >= 0)
>  		reset_control_put(sp->phys[node].lnk_rst);
> +ctrl_assert:
> +	if (!sp->already_configured)
> +		reset_control_assert(sp->apb_rst);
>  clk_disable:
>  	cdns_sierra_phy_disable_clocks(sp);
> -	reset_control_assert(sp->apb_rst);
>  unregister_clk:
>  	cdns_sierra_clk_unregister(sp);
>  	return ret;
> -- 
> 2.17.1

-- 
~Vinod
