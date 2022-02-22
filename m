Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470CE4BF8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiBVNDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiBVNDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:03:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296AB18B7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:03:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A045061224
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04069C340E8;
        Tue, 22 Feb 2022 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645534992;
        bh=NJzVi4dp7hoMBL65wpjlSNlNzLbWfvKToWjwhfHZgO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJa/yankX4xE/Z3caVkIMJRaJ/yfMfV1aN02H1ES5XGWEQCc/aGSMlgihPlr/mcHv
         +AoTmzaKe+zVbuc+vlgCK132XdTh20eKFV8oCQ/Y/P+xUqyj2ZK2zgG3U3UjBkgn3E
         tGP3XggDq92UcOsR1RXG/ydHeXRi6VwS4aff0tyOI1UYJ14ObNZT3lSMzKiQ6Hhnck
         9GhYfR1AnsZIuR5GuvBcQ/0hSEWkNM9rHm/p+nL3n6/spo8YdLGi6H5wr2QQCk6hhJ
         pv9SYanL+jcLXx23Vo0A219ofnNVkSssUcjGO5404l6sLXRDZvyryH9oTgV/+erkXS
         8ZFEh8V3foGxw==
Date:   Tue, 22 Feb 2022 18:33:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        a-govindraju@ti.com, r-ravikumar@ti.com
Subject: Re: [PATCH 2/4] phy: cadence-torrent: Prepare driver for multilink
 DP support
Message-ID: <YhTfDBFKT89lv6MF@matsya>
References: <20220127142958.23465-1-sjakhade@cadence.com>
 <20220127142958.23465-3-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127142958.23465-3-sjakhade@cadence.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-22, 15:29, Swapnil Jakhade wrote:
> This patch prepares driver for multilink DP support as well as for
> multiprotocol PHY configurations involving DP as one of the required
> protocols. This needs changes in functions configuring default single
> link DP with master lane 0 to support non-zero master lane values and
> associated PLL configurations.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 315 ++++++++++++----------
>  1 file changed, 177 insertions(+), 138 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 0e2839a6c65d..72adc3a27367 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -69,16 +69,11 @@
>   */
>  #define PHY_AUX_CTRL			0x04
>  #define PHY_RESET			0x20
> -#define PMA_TX_ELEC_IDLE_MASK		0xF0U
>  #define PMA_TX_ELEC_IDLE_SHIFT		4
> -#define PHY_L00_RESET_N_MASK		0x01U
>  #define PHY_PMA_XCVR_PLLCLK_EN		0x24
>  #define PHY_PMA_XCVR_PLLCLK_EN_ACK	0x28
>  #define PHY_PMA_XCVR_POWER_STATE_REQ	0x2c
> -#define PHY_POWER_STATE_LN_0	0x0000
> -#define PHY_POWER_STATE_LN_1	0x0008
> -#define PHY_POWER_STATE_LN_2	0x0010
> -#define PHY_POWER_STATE_LN_3	0x0018
> +#define PHY_POWER_STATE_LN(ln)		((ln) * 8)
>  #define PMA_XCVR_POWER_STATE_REQ_LN_MASK	0x3FU
>  #define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
>  #define PHY_PMA_CMN_READY		0x34
> @@ -1010,43 +1005,37 @@ static int cdns_torrent_dp_get_pll(struct cdns_torrent_phy *cdns_phy,
>   * Enable or disable PLL for selected lanes.
>   */
>  static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
> +				      struct cdns_torrent_inst *inst,
>  				      struct phy_configure_opts_dp *dp,
>  				      bool enable)
>  {
> -	u32 rd_val;
> -	u32 ret;
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
> +	u32 rd_val, i, pll_ack_val;
> +	int ret;
>  
>  	/*
>  	 * Used to determine, which bits to check for or enable in
>  	 * PHY_PMA_XCVR_PLLCLK_EN register.
>  	 */
> -	u32 pll_bits;
> +	u32 pll_bits = 0;
>  	/* Used to enable or disable lanes. */
>  	u32 pll_val;
> +	u32 clane = 0;

clane is zero!

>  
> -	/* Select values of registers and mask, depending on enabled lane
> -	 * count.
> -	 */
> -	switch (dp->lanes) {
> -	/* lane 0 */
> -	case (1):
> -		pll_bits = 0x00000001;
> -		break;
> -	/* lanes 0-1 */
> -	case (2):
> -		pll_bits = 0x00000003;
> -		break;
> -	/* lanes 0-3, all */
> -	default:
> -		pll_bits = 0x0000000F;
> -		break;
> -	}
> +	/* Select values of registers and mask, depending on enabled lane count. */
> +	pll_val = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
>  
> -	if (enable)
> -		pll_val = pll_bits;
> -	else
> -		pll_val = 0x00000000;
> +	if (enable) {
> +		for (i = 0; i < dp->lanes; i++)
> +			pll_bits |= (0x01U << (clane + i));

so why clane here?
and sound like you may want to use set_bit for all the lanes?

> +		pll_val |= pll_bits;
> +		pll_ack_val = pll_bits;
> +	} else {
> +		for (i = 0; i < inst->num_lanes; i++)
> +			pll_bits |= (0x01U << (clane + i));
> +		pll_val &= (~pll_bits);
> +		pll_ack_val = 0;
> +	}
>  
>  	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
>  
> @@ -1054,23 +1043,26 @@ static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
>  	ret = regmap_read_poll_timeout(regmap,
>  				       PHY_PMA_XCVR_PLLCLK_EN_ACK,
>  				       rd_val,
> -				       (rd_val & pll_bits) == pll_val,
> +				       (rd_val & pll_bits) == pll_ack_val,
>  				       0, POLL_TIMEOUT_US);
>  	ndelay(100);
>  	return ret;
>  }
>  
>  static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
> +					   struct cdns_torrent_inst *inst,
>  					   u32 num_lanes,
>  					   enum phy_powerstate powerstate)
>  {
>  	/* Register value for power state for a single byte. */
>  	u32 value_part;
> -	u32 value;
> -	u32 mask;
> +	u32 value = 0;
> +	u32 mask = 0;
>  	u32 read_val;
> -	u32 ret;
> +	int ret;
> +	u32 i;
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
> +	u32 clane = 0;
>  
>  	switch (powerstate) {
>  	case (POWERSTATE_A0):
> @@ -1085,29 +1077,11 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
>  		break;
>  	}
>  
> -	/* Select values of registers and mask, depending on enabled
> -	 * lane count.
> -	 */
> -	switch (num_lanes) {
> -	/* lane 0 */
> -	case (1):
> -		value = value_part;
> -		mask = 0x0000003FU;
> -		break;
> -	/* lanes 0-1 */
> -	case (2):
> -		value = (value_part
> -			 | (value_part << 8));
> -		mask = 0x00003F3FU;
> -		break;
> -	/* lanes 0-3, all */
> -	default:
> -		value = (value_part
> -			 | (value_part << 8)
> -			 | (value_part << 16)
> -			 | (value_part << 24));
> -		mask = 0x3F3F3F3FU;
> -		break;
> +	/* Select values of registers and mask, depending on enabled lane count. */
> +
> +	for (i = 0; i < num_lanes; i++) {
> +		value |= (value_part << PHY_POWER_STATE_LN(clane + i));
> +		mask |= (PMA_XCVR_POWER_STATE_REQ_LN_MASK << PHY_POWER_STATE_LN(clane + i));
>  	}
>  
>  	/* Set power state A<n>. */
> @@ -1122,18 +1096,20 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
>  	return ret;
>  }
>  
> -static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
> +static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
> +			       struct cdns_torrent_inst *inst, u32 num_lanes)
>  {
>  	unsigned int read_val;
>  	int ret;
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
> +	u32 clane = 0;
>  
>  	/*
>  	 * waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
>  	 * master lane
>  	 */
>  	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_PLLCLK_EN_ACK,
> -				       read_val, read_val & 1,
> +				       read_val, (read_val & (1 << clane)),

again clane seems to be always 0

>  				       0, POLL_TIMEOUT_US);
>  	if (ret == -ETIMEDOUT) {
>  		dev_err(cdns_phy->dev,
> @@ -1143,12 +1119,12 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
>  
>  	ndelay(100);
>  
> -	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
> +	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, num_lanes,
>  					      POWERSTATE_A2);
>  	if (ret)
>  		return ret;
>  
> -	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
> +	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, num_lanes,
>  					      POWERSTATE_A0);
>  
>  	return ret;
> @@ -1172,6 +1148,7 @@ static int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
>  }
>  
>  static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
> +					 struct cdns_torrent_inst *inst,
>  					 u32 rate, u32 num_lanes)
>  {
>  	unsigned int clk_sel_val = 0;
> @@ -1204,14 +1181,17 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
>  		break;
>  	}
>  
> -	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
> -			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
> -	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
> -			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
> +	if (cdns_phy->dp_pll & DP_PLL0)
> +		cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
> +				       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
> +
> +	if (cdns_phy->dp_pll & DP_PLL1)
> +		cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
> +				       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
>  
>  	/* PMA lane configuration to deal with multi-link operation */
>  	for (i = 0; i < num_lanes; i++)
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[i],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + i],
>  				       XCVR_DIAG_HSCLK_DIV, hsclk_div_val);
>  }
>  
> @@ -1220,23 +1200,44 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
>   * set and PLL disable request was processed.
>   */
>  static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
> +					  struct cdns_torrent_inst *inst,
>  					  struct phy_configure_opts_dp *dp)
>  {
> -	u32 read_val, ret;
> +	u32 read_val, field_val;
> +	int ret;
>  
> -	/* Disable the cmn_pll0_en before re-programming the new data rate. */
> -	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
> +	/*
> +	 * Disable the associated PLL (cmn_pll0_en or cmn_pll1_en) before
> +	 * re-programming the new data rate.
> +	 */
> +	ret = regmap_field_read(cdns_phy->phy_pma_pll_raw_ctrl, &field_val);
> +	if (ret)
> +		return ret;
> +	field_val &= ~(cdns_phy->dp_pll);
> +	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, field_val);
>  
>  	/*
>  	 * Wait for PLL ready de-assertion.
>  	 * For PLL0 - PHY_PMA_CMN_CTRL2[2] == 1
> +	 * For PLL1 - PHY_PMA_CMN_CTRL2[3] == 1
>  	 */
> -	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> -					     read_val,
> -					     ((read_val >> 2) & 0x01) != 0,
> -					     0, POLL_TIMEOUT_US);
> -	if (ret)
> -		return ret;
> +	if (cdns_phy->dp_pll & DP_PLL0) {
> +		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> +						     read_val,
> +						     ((read_val >> 2) & 0x01) != 0,
> +						     0, POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if ((cdns_phy->dp_pll & DP_PLL1) && cdns_phy->nsubnodes != 1) {
> +		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> +						     read_val,
> +						     ((read_val >> 3) & 0x01) != 0,
> +						     0, POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +	}
>  	ndelay(200);
>  
>  	/* DP Rate Change - VCO Output settings. */
> @@ -1250,19 +1251,35 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
>  		/* PMA common configuration 100MHz */
>  		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy, dp->link_rate, dp->ssc);
>  
> -	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
> +	cdns_torrent_dp_pma_cmn_rate(cdns_phy, inst, dp->link_rate, dp->lanes);
>  
> -	/* Enable the cmn_pll0_en. */
> -	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x3);
> +	/* Enable the associated PLL (cmn_pll0_en or cmn_pll1_en) */
> +	ret = regmap_field_read(cdns_phy->phy_pma_pll_raw_ctrl, &field_val);
> +	if (ret)
> +		return ret;
> +	field_val |= cdns_phy->dp_pll;
> +	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, field_val);
>  
>  	/*
>  	 * Wait for PLL ready assertion.
>  	 * For PLL0 - PHY_PMA_CMN_CTRL2[0] == 1
> +	 * For PLL1 - PHY_PMA_CMN_CTRL2[1] == 1
>  	 */
> -	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> -					     read_val,
> -					     (read_val & 0x01) != 0,
> -					     0, POLL_TIMEOUT_US);
> +	if (cdns_phy->dp_pll & DP_PLL0) {
> +		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> +						     read_val,
> +						     (read_val & 0x01) != 0,
> +						     0, POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if ((cdns_phy->dp_pll & DP_PLL1) && cdns_phy->nsubnodes != 1)
> +		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
> +						     read_val,
> +						     ((read_val >> 1) & 0x01) != 0,
> +						     0, POLL_TIMEOUT_US);
> +
>  	return ret;
>  }
>  
> @@ -1330,6 +1347,7 @@ static int cdns_torrent_dp_verify_config(struct cdns_torrent_inst *inst,
>  
>  /* Set power state A0 and PLL clock enable to 0 on enabled lanes. */
>  static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
> +				       struct cdns_torrent_inst *inst,
>  				       u32 num_lanes)
>  {
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
> @@ -1337,27 +1355,13 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
>  					     PHY_PMA_XCVR_POWER_STATE_REQ);
>  	u32 pll_clk_en = cdns_torrent_dp_read(regmap,
>  					      PHY_PMA_XCVR_PLLCLK_EN);
> +	u32 i;
>  
> -	/* Lane 0 is always enabled. */
> -	pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
> -		       PHY_POWER_STATE_LN_0);
> -	pll_clk_en &= ~0x01U;
> +	for (i = 0; i < num_lanes; i++) {
> +		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK
> +			     << PHY_POWER_STATE_LN(inst->mlane + i));
>  
> -	if (num_lanes > 1) {
> -		/* lane 1 */
> -		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
> -			       PHY_POWER_STATE_LN_1);
> -		pll_clk_en &= ~(0x01U << 1);
> -	}
> -
> -	if (num_lanes > 2) {
> -		/* lanes 2 and 3 */
> -		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
> -			       PHY_POWER_STATE_LN_2);
> -		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
> -			       PHY_POWER_STATE_LN_3);
> -		pll_clk_en &= ~(0x01U << 2);
> -		pll_clk_en &= ~(0x01U << 3);
> +		pll_clk_en &= ~(0x01U << (inst->mlane + i));
>  	}
>  
>  	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
> @@ -1366,36 +1370,57 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
>  
>  /* Configure lane count as required. */
>  static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
> +				     struct cdns_torrent_inst *inst,
>  				     struct phy_configure_opts_dp *dp)
>  {
> -	u32 value;
> -	u32 ret;
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
>  	u8 lane_mask = (1 << dp->lanes) - 1;
> +	u8 pma_tx_elec_idle_mask = 0;
> +	u32 value, i;
> +	int ret;
> +	u32 clane = inst->mlane;
> +
> +	lane_mask <<= clane;
>  
>  	value = cdns_torrent_dp_read(regmap, PHY_RESET);
>  	/* clear pma_tx_elec_idle_ln_* bits. */
> -	value &= ~PMA_TX_ELEC_IDLE_MASK;
> +	pma_tx_elec_idle_mask = ((1 << inst->num_lanes) - 1) << clane;
> +
> +	pma_tx_elec_idle_mask <<= PMA_TX_ELEC_IDLE_SHIFT;
> +
> +	value &= ~pma_tx_elec_idle_mask;
> +
>  	/* Assert pma_tx_elec_idle_ln_* for disabled lanes. */
>  	value |= ((~lane_mask) << PMA_TX_ELEC_IDLE_SHIFT) &
> -		 PMA_TX_ELEC_IDLE_MASK;
> +		 pma_tx_elec_idle_mask;
> +
>  	cdns_torrent_dp_write(regmap, PHY_RESET, value);
>  
> -	/* reset the link by asserting phy_l00_reset_n low */
> +	/* reset the link by asserting master lane phy_l0*_reset_n low */
>  	cdns_torrent_dp_write(regmap, PHY_RESET,
> -			      value & (~PHY_L00_RESET_N_MASK));
> +			      value & (~(1 << clane)));
>  
>  	/*
> -	 * Assert lane reset on unused lanes and lane 0 so they remain in reset
> +	 * Assert lane reset on unused lanes and master lane so they remain in reset
>  	 * and powered down when re-enabling the link
>  	 */
> -	value = (value & 0x0000FFF0) | (0x0000000E & lane_mask);
> +	for (i = 0; i < inst->num_lanes; i++)
> +		value &= (~(1 << (clane + i)));
> +
> +	for (i = 1; i < inst->num_lanes; i++)
> +		value |= ((1 << (clane + i)) & lane_mask);
> +
>  	cdns_torrent_dp_write(regmap, PHY_RESET, value);
>  
> -	cdns_torrent_dp_set_a0_pll(cdns_phy, dp->lanes);
> +	cdns_torrent_dp_set_a0_pll(cdns_phy, inst, dp->lanes);
>  
>  	/* release phy_l0*_reset_n based on used laneCount */
> -	value = (value & 0x0000FFF0) | (0x0000000F & lane_mask);
> +	for (i = 0; i < inst->num_lanes; i++)
> +		value &= (~(1 << (clane + i)));
> +
> +	for (i = 0; i < inst->num_lanes; i++)
> +		value |= ((1 << (clane + i)) & lane_mask);
> +
>  	cdns_torrent_dp_write(regmap, PHY_RESET, value);
>  
>  	/* Wait, until PHY gets ready after releasing PHY reset signal. */
> @@ -1406,41 +1431,44 @@ static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
>  	ndelay(100);
>  
>  	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
> -	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
> +	value = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
> +	value |= (1 << clane);
> +	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, value);
>  
> -	ret = cdns_torrent_dp_run(cdns_phy, dp->lanes);
> +	ret = cdns_torrent_dp_run(cdns_phy, inst, dp->lanes);
>  
>  	return ret;
>  }
>  
>  /* Configure link rate as required. */
>  static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
> +				    struct cdns_torrent_inst *inst,
>  				    struct phy_configure_opts_dp *dp)
>  {
> -	u32 ret;
> +	int ret;
>  
> -	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
> +	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
>  					      POWERSTATE_A3);
>  	if (ret)
>  		return ret;
> -	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, false);
> +	ret = cdns_torrent_dp_set_pll_en(cdns_phy, inst, dp, false);
>  	if (ret)
>  		return ret;
>  	ndelay(200);
>  
> -	ret = cdns_torrent_dp_configure_rate(cdns_phy, dp);
> +	ret = cdns_torrent_dp_configure_rate(cdns_phy, inst, dp);
>  	if (ret)
>  		return ret;
>  	ndelay(200);
>  
> -	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, true);
> +	ret = cdns_torrent_dp_set_pll_en(cdns_phy, inst, dp, true);
>  	if (ret)
>  		return ret;
> -	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
> +	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
>  					      POWERSTATE_A2);
>  	if (ret)
>  		return ret;
> -	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
> +	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
>  					      POWERSTATE_A0);
>  	if (ret)
>  		return ret;
> @@ -1451,44 +1479,45 @@ static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
>  
>  /* Configure voltage swing and pre-emphasis for all enabled lanes. */
>  static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
> +					 struct cdns_torrent_inst *inst,
>  					 struct phy_configure_opts_dp *dp)
>  {
>  	u8 lane;
>  	u16 val;
>  
>  	for (lane = 0; lane < dp->lanes; lane++) {
> -		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
> +		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  					    TX_DIAG_ACYA);
>  		/*
>  		 * Write 1 to register bit TX_DIAG_ACYA[0] to freeze the
>  		 * current state of the analog TX driver.
>  		 */
>  		val |= TX_DIAG_ACYA_HBDC_MASK;
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       TX_DIAG_ACYA, val);
>  
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       TX_TXCC_CTRL, 0x08A4);
>  		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].diag_tx_drv;
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       DRV_DIAG_TX_DRV, val);
>  		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].mgnfs_mult;
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       TX_TXCC_MGNFS_MULT_000,
>  				       val);
>  		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].cpost_mult;
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       TX_TXCC_CPOST_MULT_00,
>  				       val);
>  
> -		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
> +		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  					    TX_DIAG_ACYA);
>  		/*
>  		 * Write 0 to register bit TX_DIAG_ACYA[0] to allow the state of
>  		 * analog TX driver to reflect the new programmed one.
>  		 */
>  		val &= ~TX_DIAG_ACYA_HBDC_MASK;
> -		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
> +		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
>  				       TX_DIAG_ACYA, val);
>  	}
>  };
> @@ -1507,7 +1536,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
>  	}
>  
>  	if (opts->dp.set_lanes) {
> -		ret = cdns_torrent_dp_set_lanes(cdns_phy, &opts->dp);
> +		ret = cdns_torrent_dp_set_lanes(cdns_phy, inst, &opts->dp);
>  		if (ret) {
>  			dev_err(&phy->dev, "cdns_torrent_dp_set_lanes failed\n");
>  			return ret;
> @@ -1515,7 +1544,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
>  	}
>  
>  	if (opts->dp.set_rate) {
> -		ret = cdns_torrent_dp_set_rate(cdns_phy, &opts->dp);
> +		ret = cdns_torrent_dp_set_rate(cdns_phy, inst, &opts->dp);
>  		if (ret) {
>  			dev_err(&phy->dev, "cdns_torrent_dp_set_rate failed\n");
>  			return ret;
> @@ -1523,7 +1552,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
>  	}
>  
>  	if (opts->dp.set_voltages)
> -		cdns_torrent_dp_set_voltages(cdns_phy, &opts->dp);
> +		cdns_torrent_dp_set_voltages(cdns_phy, inst, &opts->dp);
>  
>  	return ret;
>  }
> @@ -1591,6 +1620,8 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
>  {
>  	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
>  	unsigned char lane_bits;
> +	u32 val;
> +	u32 clane = 0;
>  
>  	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
>  
> @@ -1598,18 +1629,24 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
>  	 * Set lines power state to A0
>  	 * Set lines pll clk enable to 0
>  	 */
> -	cdns_torrent_dp_set_a0_pll(cdns_phy, inst->num_lanes);
> +	cdns_torrent_dp_set_a0_pll(cdns_phy, inst, inst->num_lanes);
>  
>  	/*
>  	 * release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
>  	 * used lanes
>  	 */
>  	lane_bits = (1 << inst->num_lanes) - 1;
> -	cdns_torrent_dp_write(regmap, PHY_RESET,
> -			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
> +	lane_bits <<= clane;
> +
> +	val = cdns_torrent_dp_read(regmap, PHY_RESET);
> +	val |= (0xF & lane_bits);
> +	val &= ~(lane_bits << 4);
> +	cdns_torrent_dp_write(regmap, PHY_RESET, val);
>  
>  	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
> -	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
> +	val = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
> +	val |= (1 << clane);
> +	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, val);
>  
>  	/*
>  	 * PHY PMA registers configuration functions
> @@ -1628,7 +1665,7 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
>  						       cdns_phy->max_bit_rate,
>  						       false);
>  
> -	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
> +	cdns_torrent_dp_pma_cmn_rate(cdns_phy, inst, cdns_phy->max_bit_rate,
>  				     inst->num_lanes);
>  
>  	/* take out of reset */
> @@ -1641,13 +1678,15 @@ static int cdns_torrent_dp_start(struct cdns_torrent_phy *cdns_phy,
>  {
>  	int ret;
>  
> -	cdns_torrent_phy_on(phy);
> +	ret = cdns_torrent_phy_on(phy);
> +	if (ret)
> +		return ret;
>  
>  	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
>  	if (ret)
>  		return ret;
>  
> -	ret = cdns_torrent_dp_run(cdns_phy, inst->num_lanes);
> +	ret = cdns_torrent_dp_run(cdns_phy, inst, inst->num_lanes);
>  
>  	return ret;
>  }
> -- 
> 2.34.1

-- 
~Vinod
