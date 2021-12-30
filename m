Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88677481966
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhL3EnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhL3EnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:43:21 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A3C061574;
        Wed, 29 Dec 2021 20:43:21 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 80E232A5;
        Thu, 30 Dec 2021 05:43:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640839399;
        bh=DmHO+h9mJ2dJG6j/F2oIihCMxLi9bE+uijkdatGdISE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHNGsDa/KAgbDDj5WMDc+G09/Yk2qortD0wfcIOpGyYHuu2UUEV+QjlHQCSEAG12F
         72guB7LhFaYelRATX6RtbPrCAXZGrXwDQmK1mwcAqTXBFQARmXyCi1VQSPlIYKLAlQ
         58GeHpix51yt+blHwNuhcKhOFHL1nn4eqXycWN+0=
Date:   Thu, 30 Dec 2021 06:43:17 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 04/14] media: cadence: csi2rx: Add external DPHY
 support
Message-ID: <Yc045RRqhDQK2dsW@pendragon.ideasonboard.com>
References: <20211223191615.17803-1-p.yadav@ti.com>
 <20211223191615.17803-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223191615.17803-5-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 12:46:05AM +0530, Pratyush Yadav wrote:
> Some platforms like TI's J721E can have the CSI2RX paired with an
> external DPHY. Add support to enable and configure the DPHY using the
> generic PHY framework.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v5:
> - Only error out when phy_pm_runtime_get_sync() returns a negative
>   value. A positive value can be returned if the phy was already
>   resumed.
> - Do not query the source subdev for format. Use the newly added
>   internal format instead.
> 
> Changes in v4:
> - Drop the call to set PHY submode. It is now being done via compatible
>   on the DPHY side.
> 
> Changes in v3:
> - Use v4l2_get_link_freq() to calculate pixel clock.
> 
> Changes in v2:
> - Use phy_pm_runtime_get_sync() and phy_pm_runtime_put() before making
>   calls to set PHY mode, etc. to make sure it is ready.
> 
>  drivers/media/platform/cadence/cdns-csi2rx.c | 98 ++++++++++++++++++--
>  1 file changed, 88 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 4a2a5a9d019b..afd4a0da8235 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -30,6 +30,12 @@
>  #define CSI2RX_STATIC_CFG_DLANE_MAP(llane, plane)	((plane) << (16 + (llane) * 4))
>  #define CSI2RX_STATIC_CFG_LANES_MASK			GENMASK(11, 8)
>  
> +#define CSI2RX_DPHY_LANE_CTRL_REG		0x40
> +#define CSI2RX_DPHY_CL_RST			BIT(16)
> +#define CSI2RX_DPHY_DL_RST(i)			BIT((i) + 12)
> +#define CSI2RX_DPHY_CL_EN			BIT(4)
> +#define CSI2RX_DPHY_DL_EN(i)			BIT(i)
> +
>  #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
>  
>  #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
> @@ -137,6 +143,57 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
>  	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
>  }
>  
> +static int csi2rx_configure_external_dphy(struct csi2rx_priv *csi2rx)
> +{
> +	union phy_configure_opts opts = { };
> +	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
> +	const struct csi2rx_fmt *fmt;
> +	s64 pixel_clock;
> +	int ret;
> +	u8 bpp;
> +	bool got_pm = true;
> +
> +	fmt = csi2rx_get_fmt_by_code(csi2rx->fmt.code);
> +	bpp = fmt->bpp;
> +
> +	/*
> +	 * Do not divide by the number of lanes here. That will be done by
> +	 * phy_mipi_dphy_get_default_config().
> +	 */
> +	pixel_clock = v4l2_get_link_freq(csi2rx->source_subdev->ctrl_handler,
> +					 1, 2);
> +	if (pixel_clock < 0)
> +		return pixel_clock;
> +
> +	ret = phy_mipi_dphy_get_default_config(pixel_clock, bpp,

You could use fmt->bpp here and drop the bpp variable.

> +					       csi2rx->num_lanes, cfg);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_pm_runtime_get_sync(csi2rx->dphy);
> +	if (ret == -ENOTSUPP)
> +		got_pm = false;

phy_pm_runtime_put() returns -ENOTSUPP when runtime PM isn't enabled,
without calling pm_runtime_put(). I think you could write here

	ret = phy_pm_runtime_get_sync(csi2rx->dphy);
	if (ret < 0 && ret != -ENOTSUPP)
		return ret;

then drop the got_pm variable, and call phy_pm_runtime_put()
unconditionally below.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	else if (ret < 0)
> +		return ret;
> +
> +	ret = phy_power_on(csi2rx->dphy);
> +	if (ret)
> +		goto out;
> +
> +	ret = phy_configure(csi2rx->dphy, &opts);
> +	if (ret) {
> +		/* Can't do anything if it fails. Ignore the return value. */
> +		phy_power_off(csi2rx->dphy);
> +		goto out;
> +	}
> +
> +out:
> +	if (got_pm)
> +		phy_pm_runtime_put(csi2rx->dphy);
> +
> +	return ret;
> +}
> +
>  static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  {
>  	unsigned int i;
> @@ -175,6 +232,17 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  	if (ret)
>  		goto err_disable_pclk;
>  
> +	/* Enable DPHY clk and data lanes. */
> +	if (csi2rx->dphy) {
> +		reg = CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
> +		for (i = 0; i < csi2rx->num_lanes; i++) {
> +			reg |= CSI2RX_DPHY_DL_EN(csi2rx->lanes[i] - 1);
> +			reg |= CSI2RX_DPHY_DL_RST(csi2rx->lanes[i] - 1);
> +		}
> +
> +		writel(reg, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> +	}
> +
>  	/*
>  	 * Create a static mapping between the CSI virtual channels
>  	 * and the output stream.
> @@ -205,10 +273,21 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  	if (ret)
>  		goto err_disable_pixclk;
>  
> +	if (csi2rx->dphy) {
> +		ret = csi2rx_configure_external_dphy(csi2rx);
> +		if (ret) {
> +			dev_err(csi2rx->dev,
> +				"Failed to configure external DPHY: %d\n", ret);
> +			goto err_disable_sysclk;
> +		}
> +	}
> +
>  	clk_disable_unprepare(csi2rx->p_clk);
>  
>  	return 0;
>  
> +err_disable_sysclk:
> +	clk_disable_unprepare(csi2rx->sys_clk);
>  err_disable_pixclk:
>  	for (; i > 0; i--)
>  		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
> @@ -236,6 +315,13 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
>  
>  	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
>  		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
> +
> +	if (csi2rx->dphy) {
> +		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> +
> +		if (phy_power_off(csi2rx->dphy))
> +			dev_warn(csi2rx->dev, "Couldn't power off DPHY\n");
> +	}
>  }
>  
>  static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
> @@ -438,15 +524,6 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  		return PTR_ERR(csi2rx->dphy);
>  	}
>  
> -	/*
> -	 * FIXME: Once we'll have external D-PHY support, the check
> -	 * will need to be removed.
> -	 */
> -	if (csi2rx->dphy) {
> -		dev_err(&pdev->dev, "External D-PHY not supported yet\n");
> -		return -EINVAL;
> -	}
> -
>  	ret = clk_prepare_enable(csi2rx->p_clk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Couldn't prepare and enable P clock\n");
> @@ -476,7 +553,7 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  	 * FIXME: Once we'll have internal D-PHY support, the check
>  	 * will need to be removed.
>  	 */
> -	if (csi2rx->has_internal_dphy) {
> +	if (!csi2rx->dphy && csi2rx->has_internal_dphy) {
>  		dev_err(&pdev->dev, "Internal D-PHY not supported yet\n");
>  		return -EINVAL;
>  	}
> @@ -601,6 +678,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev,
>  		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
>  		 csi2rx->num_lanes, csi2rx->max_lanes, csi2rx->max_streams,
> +		 csi2rx->dphy ? "external" :
>  		 csi2rx->has_internal_dphy ? "internal" : "no");
>  
>  	return 0;

-- 
Regards,

Laurent Pinchart
