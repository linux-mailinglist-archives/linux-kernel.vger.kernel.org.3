Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BCF52369B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbiEKPCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245501AbiEKPBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:01:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04F3191E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:01:20 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 459B46DD;
        Wed, 11 May 2022 17:01:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1652281278;
        bh=bVcJtp0XYB8s5syvPckxTbg4rgf7boXFqjdL9plxvuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHHV+CAwEwehLeLC1DPRLFfME9j77NYuJZ9dSJIpAz4z24dHvZC2Yoxzr73hkVUbP
         zZTcWwauUkOg+X3vwIYGFx7xmSnYLlr0BeTaXgPnz0fIgQNFSORjR3PZ2L6C3/y5QY
         mjYSgl7TfV5U1emCDlS554DUqlJTP3YJB0JuP1ls=
Date:   Wed, 11 May 2022 18:01:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jayshri Pawar <jpawar@cadence.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@linux.ie,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        sjakhade@cadence.com, nm@ti.com, yogeshs@ti.com, kishon@ti.com
Subject: Re: [PATCH] drm/bridge: cdns-dsi: Add support for pre_enable and
 post_enable control functions.
Message-ID: <YnvPuD3rgzCVTNxx@pendragon.ideasonboard.com>
References: <20220411140606.15654-1-jpawar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220411140606.15654-1-jpawar@cadence.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayshri,

Thank you for the patch.

On Mon, Apr 11, 2022 at 04:06:06PM +0200, Jayshri Pawar wrote:
> From: jpawar <jpawar@cadence.com>
> 
> Add support for pre_enable and post_enable drm bridge control functions.
> Making sure that host to be prepared before panel is powered up,
> for the panels like TC358762.
> 
> Signed-off-by: jpawar <jpawar@cadence.com>
> ---
>  drivers/gpu/drm/bridge/cdns-dsi.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> index 829e1a144656..20bece84ff8c 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -462,6 +462,7 @@ struct cdns_dsi {
>  	struct reset_control *dsi_p_rst;
>  	struct clk *dsi_sys_clk;
>  	bool link_initialized;
> +	bool phy_initialized;
>  	struct phy *dphy;
>  };
>  
> @@ -711,11 +712,21 @@ static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
>  	pm_runtime_put(dsi->base.dev);
>  }
>  
> +static void cdns_dsi_bridge_post_disable(struct drm_bridge *bridge)
> +{
> +	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
> +	struct cdns_dsi *dsi = input_to_dsi(input);
> +
> +	pm_runtime_put(dsi->base.dev);
> +}
> +
>  static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
>  {
>  	struct cdns_dsi_output *output = &dsi->output;
>  	u32 status;
>  
> +	if (dsi->phy_initialized)
> +		return;
>  	/*
>  	 * Power all internal DPHY blocks down and maintain their reset line
>  	 * asserted before changing the DPHY config.
> @@ -739,6 +750,7 @@ static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
>  	writel(DPHY_CMN_PSO | DPHY_ALL_D_PDN | DPHY_C_PDN | DPHY_CMN_PDN |
>  	       DPHY_D_RSTB(output->dev->lanes) | DPHY_C_RSTB,
>  	       dsi->regs + MCTL_DPHY_CFG0);
> +	dsi->phy_initialized = true;
>  }
>  
>  static void cdns_dsi_init_link(struct cdns_dsi *dsi)
> @@ -914,11 +926,25 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
>  	writel(tmp, dsi->regs + MCTL_MAIN_EN);
>  }
>  
> +static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> +{
> +	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
> +	struct cdns_dsi *dsi = input_to_dsi(input);
> +
> +	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))

This should use pm_runtime_resume_and_get(), otherwise you need to call
pm_runtime_put_noidle() on failure.

> +		return;
> +
> +	cdns_dsi_init_link(dsi);
> +	cdns_dsi_hs_init(dsi);
> +}
> +
>  static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {
>  	.attach = cdns_dsi_bridge_attach,
>  	.mode_valid = cdns_dsi_bridge_mode_valid,
>  	.disable = cdns_dsi_bridge_disable,
> +	.pre_enable = cdns_dsi_bridge_pre_enable,
>  	.enable = cdns_dsi_bridge_enable,
> +	.post_disable = cdns_dsi_bridge_post_disable,
>  };
>  
>  static int cdns_dsi_attach(struct mipi_dsi_host *host,

-- 
Regards,

Laurent Pinchart
