Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B79D469A77
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbhLFPIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346313AbhLFPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:06:17 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F0DC0698E1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:02:47 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso13978726ota.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jffNvrh7KQsV2nR/TwXkXfJqfnZhPwCdmIY7tlegLXQ=;
        b=lqaAsIV/0K44MV7AaYubisMSw+XsLTslk45oy1fg99IDA3L2jpOJ7SX6SHQ49Ift+b
         /szlOsgVjf41hObQH1YGQyJR+7omrLeGLNhfYsz9TbWnnODO9m+QO0Ofg6CLNwyHJ5Ty
         jBNup7fggUqDEGWgvH4FoWHkFT70ML7iOnwJgWuB5HDSI40CDhJDBXejJdPpmU4uWB8B
         B18CnYjz7MRLYZzz0udeB1Q8JyC5uNy1e2d3mnrJR42L0eMVYdMopD8wKsfSkSJQGJ0+
         Y/cK6x/6XoK3UBpzJAzJ998VjhcwwwmZJWiJ8SGWI+5pDKpoBaNnsQBwRZFzE7cO/wsj
         xd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jffNvrh7KQsV2nR/TwXkXfJqfnZhPwCdmIY7tlegLXQ=;
        b=G2LNs/O9Vjw97nBWkEnleFx4KuXfxM+TWXvFNucL+2Tb6aDBL/AgCmVckQQXOTllCw
         amB3C5LNbw27eSCiTP/5P3F9hMMst58DpYyj/RJOwFXYT4pQRNCagwZk0g2Lseo2lBP8
         21KpaWPNOsmo2329TpXflkWx9UP49UEQy59JndWaTCIhxD72aoBxnJI5UrawT6qgILK1
         70NW66GyVhuTZzqLWli+TtSoJh/S7mBJk6JplLedcWUIsjrQXqEeLuP8wVabWGCIOSXv
         QO5ELwEZ2/EqpXZA4k+uIi/Mf6NDHPqcJXYt0Rl5plJa03t4H3kpcTK9SkXfqd0rlZIW
         AUJQ==
X-Gm-Message-State: AOAM530rCE8tWcBLafuxI4hzteqVd2X0tJpWp1elOoeo9sWJiJRFFCEt
        BojakABfjMTEgxj9QIZzJmj17g==
X-Google-Smtp-Source: ABdhPJyLHuBI7aVghHaBJpmi/eC8baOPqavY3ZKjA4TBh5PttyLk/PEdK3VnsjTr9BuxL0i+MZbl9w==
X-Received: by 2002:a05:6830:453:: with SMTP id d19mr30242988otc.72.1638802966195;
        Mon, 06 Dec 2021 07:02:46 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c9sm2264926oog.43.2021.12.06.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:02:45 -0800 (PST)
Date:   Mon, 6 Dec 2021 07:04:12 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v3 1/4] media: camss: csiphy: Move to hardcode CSI Clock
 Lane number
Message-ID: <Ya4mbMinkgDkjj+H@ripper>
References: <20211118124819.1902427-1-robert.foss@linaro.org>
 <20211118124819.1902427-2-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118124819.1902427-2-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18 Nov 04:48 PST 2021, Robert Foss wrote:

> QCOM ISPs do not support having a programmable CSI Clock Lane number.
> 
> In order to accurately reflect this, the different CSIPHY HW versions
> need to have their own register layer for computing lane masks.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../qcom/camss/camss-csiphy-2ph-1-0.c         | 19 +++++++++++++++--
>  .../qcom/camss/camss-csiphy-3ph-1-0.c         | 17 ++++++++++++++-
>  .../media/platform/qcom/camss/camss-csiphy.c  | 21 +------------------
>  .../media/platform/qcom/camss/camss-csiphy.h  |  7 +++++++
>  4 files changed, 41 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
> index 30b454c369ab..cd4a8c369234 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
> @@ -16,6 +16,7 @@
>  
>  #define CAMSS_CSI_PHY_LNn_CFG2(n)		(0x004 + 0x40 * (n))
>  #define CAMSS_CSI_PHY_LNn_CFG3(n)		(0x008 + 0x40 * (n))
> +#define		CAMSS_CSI_PHY_LN_CLK		1
>  #define CAMSS_CSI_PHY_GLBL_RESET		0x140
>  #define CAMSS_CSI_PHY_GLBL_PWR_CFG		0x144
>  #define CAMSS_CSI_PHY_GLBL_IRQ_CMD		0x164
> @@ -26,6 +27,19 @@
>  #define CAMSS_CSI_PHY_GLBL_T_INIT_CFG0		0x1ec
>  #define CAMSS_CSI_PHY_T_WAKEUP_CFG0		0x1f4
>  
> +static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
> +{
> +	u8 lane_mask;
> +	int i;
> +
> +	lane_mask = 1 << CAMSS_CSI_PHY_LN_CLK;
> +
> +	for (i = 0; i < lane_cfg->num_data; i++)
> +		lane_mask |= 1 << lane_cfg->data[i].pos;
> +
> +	return lane_mask;
> +}
> +
>  static void csiphy_hw_version_read(struct csiphy_device *csiphy,
>  				   struct device *dev)
>  {
> @@ -105,7 +119,7 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
>  
>  	for (i = 0; i <= c->num_data; i++) {
>  		if (i == c->num_data)
> -			l = c->clk.pos;
> +			l = CAMSS_CSI_PHY_LN_CLK;
>  		else
>  			l = c->data[i].pos;
>  
> @@ -129,7 +143,7 @@ static void csiphy_lanes_disable(struct csiphy_device *csiphy,
>  
>  	for (i = 0; i <= c->num_data; i++) {
>  		if (i == c->num_data)
> -			l = c->clk.pos;
> +			l = CAMSS_CSI_PHY_LN_CLK;
>  		else
>  			l = c->data[i].pos;
>  
> @@ -167,6 +181,7 @@ static irqreturn_t csiphy_isr(int irq, void *dev)
>  }
>  
>  const struct csiphy_hw_ops csiphy_ops_2ph_1_0 = {
> +	.get_lane_mask = csiphy_get_lane_mask,
>  	.hw_version_read = csiphy_hw_version_read,
>  	.reset = csiphy_reset,
>  	.lanes_enable = csiphy_lanes_enable,
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index e318c822ab04..cde6b3a10b9e 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -43,6 +43,7 @@
>  #define CSIPHY_3PH_LNn_CSI_LANE_CTRL15_SWI_SOT_SYMBOL	0xb8
>  
>  #define CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(n)	(0x800 + 0x4 * (n))
> +#define CSIPHY_3PH_CMN_CSI_COMMON_CTRL5_CLK_ENABLE	BIT(7)
>  #define CSIPHY_3PH_CMN_CSI_COMMON_CTRL6_COMMON_PWRDN_B	BIT(0)
>  #define CSIPHY_3PH_CMN_CSI_COMMON_CTRL6_SHOW_REV_ID	BIT(1)
>  #define CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(n)	(0x8b0 + 0x4 * (n))
> @@ -320,6 +321,19 @@ static void csiphy_gen2_config_lanes(struct csiphy_device *csiphy,
>  	}
>  }
>  
> +static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
> +{
> +	u8 lane_mask;
> +	int i;
> +
> +	lane_mask = CSIPHY_3PH_CMN_CSI_COMMON_CTRL5_CLK_ENABLE;
> +
> +	for (i = 0; i < lane_cfg->num_data; i++)
> +		lane_mask |= 1 << lane_cfg->data[i].pos;
> +
> +	return lane_mask;
> +}
> +
>  static void csiphy_lanes_enable(struct csiphy_device *csiphy,
>  				struct csiphy_config *cfg,
>  				s64 link_freq, u8 lane_mask)
> @@ -331,7 +345,7 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
>  
>  	settle_cnt = csiphy_settle_cnt_calc(link_freq, csiphy->timer_clk_rate);
>  
> -	val = BIT(c->clk.pos);
> +	val = CSIPHY_3PH_CMN_CSI_COMMON_CTRL5_CLK_ENABLE;
>  	for (i = 0; i < c->num_data; i++)
>  		val |= BIT(c->data[i].pos * 2);
>  
> @@ -397,6 +411,7 @@ static void csiphy_lanes_disable(struct csiphy_device *csiphy,
>  }
>  
>  const struct csiphy_hw_ops csiphy_ops_3ph_1_0 = {
> +	.get_lane_mask = csiphy_get_lane_mask,
>  	.hw_version_read = csiphy_hw_version_read,
>  	.reset = csiphy_reset,
>  	.lanes_enable = csiphy_lanes_enable,
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index 24eec16197e7..ac7e96e6b7cd 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -229,25 +229,6 @@ static int csiphy_set_power(struct v4l2_subdev *sd, int on)
>  	return 0;
>  }
>  
> -/*
> - * csiphy_get_lane_mask - Calculate CSI2 lane mask configuration parameter
> - * @lane_cfg - CSI2 lane configuration
> - *
> - * Return lane mask
> - */
> -static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
> -{
> -	u8 lane_mask;
> -	int i;
> -
> -	lane_mask = 1 << lane_cfg->clk.pos;
> -
> -	for (i = 0; i < lane_cfg->num_data; i++)
> -		lane_mask |= 1 << lane_cfg->data[i].pos;
> -
> -	return lane_mask;
> -}
> -
>  /*
>   * csiphy_stream_on - Enable streaming on CSIPHY module
>   * @csiphy: CSIPHY device
> @@ -261,7 +242,7 @@ static int csiphy_stream_on(struct csiphy_device *csiphy)
>  {
>  	struct csiphy_config *cfg = &csiphy->cfg;
>  	s64 link_freq;
> -	u8 lane_mask = csiphy_get_lane_mask(&cfg->csi2->lane_cfg);
> +	u8 lane_mask = csiphy->ops->get_lane_mask(&cfg->csi2->lane_cfg);
>  	u8 bpp = csiphy_get_bpp(csiphy->formats, csiphy->nformats,
>  				csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
>  	u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
> index d71b8bc6ec00..1c14947f92d3 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.h
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
> @@ -45,6 +45,13 @@ struct csiphy_config {
>  struct csiphy_device;
>  
>  struct csiphy_hw_ops {
> +	/*
> +	 * csiphy_get_lane_mask - Calculate CSI2 lane mask configuration parameter
> +	 * @lane_cfg - CSI2 lane configuration
> +	 *
> +	 * Return lane mask
> +	 */
> +	u8 (*get_lane_mask)(struct csiphy_lanes_cfg *lane_cfg);
>  	void (*hw_version_read)(struct csiphy_device *csiphy,
>  				struct device *dev);
>  	void (*reset)(struct csiphy_device *csiphy);
> -- 
> 2.32.0
> 
