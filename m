Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802E448100D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 06:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhL2F2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 00:28:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41750 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhL2F2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 00:28:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0786B8181C;
        Wed, 29 Dec 2021 05:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3CCC36AE7;
        Wed, 29 Dec 2021 05:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640755679;
        bh=D8UC/WuYu98B/RLFM1J0yyYy2lUGB7H6vTP5iD9lt3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJgPdcOmgQDFD7aS3OhoiGWmIHNBm41eOO0LYC6lmEbWEtpd4U7O6tKkDKDwVx8oJ
         68eSy/5dbD7PgBlKazPHKDjYTeay6ZSASytXSuhEulFslIad9QJ/9PoxUhurIoiL+w
         16f1Zctn1v8/YpHZekgAVk+PpSNwlrgWF2cEjJKfhW4+XVzUCr0vLx4BfmjwXetiQd
         h/OyJmdCRwTF6R6k+gI3pKpf9NR0ekLb0PB5K6jSRJves9gZUty1d7Q5FFk2Xj1jtu
         6gVdiwupNZpSKcwM1DYXNN/FpPs6RSMj+5l8soouaYL9OvU/myc8vZchbdgDtzC2o3
         L6Dwkn4rlbX2Q==
Date:   Wed, 29 Dec 2021 10:57:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/8] phy: qcom-qmp: Register typec mux and orientation
 switch
Message-ID: <Ycvx2qOlPsVIjkHq@matsya>
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
 <20211228052116.1748443-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228052116.1748443-3-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-12-21, 21:21, Bjorn Andersson wrote:
> The QMP PHY handles muxing of USB vs DisplayPort, as well as orientation
> switching of the SuperSpeed lanes. So register typec handlers for the
> two types.
> 
> The TypeC mux allows switching between four lanes of DisplayPort and a
> mixed USB+DP combination. This makes it possible to reach resolutions
> that requires 4 lanes.
> 
> The TypeC switch allows switching the SuperSpeed pins and have been
> tested with both 2 and 4 lane DisplayPort.
> 
> It's possible that in the USB mode the DP_MODE should be disabled, but
> this is left untouched.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> My suggestion is that if/once this patch is deemed acceptable the PHY
> maintainers could create a immutable branch/tag which can be merged into the
> PHY tree as well as the USB tree.
> 
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 176 +++++++++++++++++++++++++---
>  1 file changed, 158 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 7bea6a60dc54..8d8139df9d8e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -19,6 +19,8 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> +#include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_mux.h>
>  
>  #include <dt-bindings/phy/phy.h>
>  
> @@ -3017,6 +3019,9 @@ struct qmp_phy_dp_clks {
>   * @phy_mutex: mutex lock for PHY common block initialization
>   * @init_count: phy common block initialization count
>   * @ufs_reset: optional UFS PHY reset handle
> + * @sw: typec switch for receiving orientation changes
> + * @mux: typec mux for DP muxing
> + * @orientation: carries current CC orientation
>   */
>  struct qcom_qmp {
>  	struct device *dev;
> @@ -3032,6 +3037,10 @@ struct qcom_qmp {
>  	int init_count;
>  
>  	struct reset_control *ufs_reset;
> +
> +	struct typec_switch *sw;
> +	struct typec_mux *mux;
> +	enum typec_orientation orientation;
>  };
>  
>  static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_phy *qphy);
> @@ -4378,30 +4387,23 @@ static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_phy *qphy)
>  
>  static bool qcom_qmp_phy_configure_dp_mode(struct qmp_phy *qphy)
>  {
> +	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
> +	bool reverse = qphy->qmp->orientation == TYPEC_ORIENTATION_REVERSE;
>  	u32 val;
> -	bool reverse = false;
>  
>  	val = DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
>  	      DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN;
>  
> -	/*
> -	 * TODO: Assume orientation is CC1 for now and two lanes, need to
> -	 * use type-c connector to understand orientation and lanes.
> -	 *
> -	 * Otherwise val changes to be like below if this code understood
> -	 * the orientation of the type-c cable.
> -	 *
> -	 * if (lane_cnt == 4 || orientation == ORIENTATION_CC2)
> -	 *	val |= DP_PHY_PD_CTL_LANE_0_1_PWRDN;
> -	 * if (lane_cnt == 4 || orientation == ORIENTATION_CC1)
> -	 *	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
> -	 * if (orientation == ORIENTATION_CC2)
> -	 *	writel(0x4c, qphy->pcs + QSERDES_V3_DP_PHY_MODE);
> -	 */
> -	val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
> +	if (dp_opts->lanes == 4 || reverse)
> +		val |= DP_PHY_PD_CTL_LANE_0_1_PWRDN;
> +	if (dp_opts->lanes == 4 || !reverse)
> +		val |= DP_PHY_PD_CTL_LANE_2_3_PWRDN;
>  	writel(val, qphy->pcs + QSERDES_DP_PHY_PD_CTL);
>  
> -	writel(0x5c, qphy->pcs + QSERDES_DP_PHY_MODE);
> +	if (reverse)
> +		writel(0x4c, qphy->pcs + QSERDES_DP_PHY_MODE);
> +	else
> +		writel(0x5c, qphy->pcs + QSERDES_DP_PHY_MODE);
>  
>  	return reverse;
>  }
> @@ -5809,6 +5811,123 @@ static const struct dev_pm_ops qcom_qmp_phy_pm_ops = {
>  			   qcom_qmp_phy_runtime_resume, NULL)
>  };
>  
> +#if IS_ENABLED(CONFIG_TYPEC)
> +static int qcom_qmp_phy_typec_switch_set(struct typec_switch *sw,
> +		enum typec_orientation orientation)

pls align to preceding open brace (here and other places)

> +{
> +	struct qcom_qmp *qmp = typec_switch_get_drvdata(sw);
> +	void __iomem *dp_com = qmp->dp_com;
> +
> +	qmp->orientation = orientation;
> +
> +	if (orientation == TYPEC_ORIENTATION_REVERSE)
> +		qphy_setbits(dp_com, QPHY_V3_DP_COM_TYPEC_CTRL, 0x01);
> +	else
> +		qphy_clrbits(dp_com, QPHY_V3_DP_COM_TYPEC_CTRL, 0x01);
> +
> +	return 0;
> +}
> +
> +static int qcom_qmp_phy_typec_mux_set(struct typec_mux *mux,
> +				      struct typec_mux_state *state)
> +{
> +	struct qcom_qmp *qmp = typec_mux_get_drvdata(mux);
> +	void __iomem *dp_com = qmp->dp_com;
> +	bool dp_mode;
> +	bool usb_mode;
> +
> +	switch (state->mode) {
> +	case TYPEC_STATE_SAFE:
> +	case TYPEC_STATE_USB:
> +		/*
> +		 * TODO: Figure out if we should clear DP_MODE when we enter a
> +		 * USB-only state.
> +		 */
> +		dp_mode = true;

should this be false for these states?

> +		usb_mode = true;
> +		break;
> +	case TYPEC_DP_STATE_A:
> +	case TYPEC_DP_STATE_C:
> +	case TYPEC_DP_STATE_E:
> +		dp_mode = true;
> +		usb_mode = false;
> +		break;
> +	case TYPEC_DP_STATE_B:
> +	case TYPEC_DP_STATE_D:
> +	case TYPEC_DP_STATE_F:
> +		dp_mode = true;
> +		usb_mode = true;
> +		break;
> +	}

looks like dp_mode is true always. And only for DP state A C E, usb_mode
is false...

> +
> +	qphy_setbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +		     SW_DPPHY_RESET_MUX | SW_USB3PHY_RESET_MUX);
> +	if (dp_mode)
> +		qphy_setbits(dp_com, QPHY_V3_DP_COM_PHY_MODE_CTRL, DP_MODE);
> +	else
> +		qphy_clrbits(dp_com, QPHY_V3_DP_COM_PHY_MODE_CTRL, DP_MODE);
> +
> +	if (usb_mode)
> +		qphy_setbits(dp_com, QPHY_V3_DP_COM_PHY_MODE_CTRL, USB3_MODE);
> +	else
> +		qphy_clrbits(dp_com, QPHY_V3_DP_COM_PHY_MODE_CTRL, USB3_MODE);
> +
> +	qphy_setbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
> +	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
> +	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
> +
> +	return 0;
> +}
> +
> +static int qcom_qmp_phy_typec_register(struct qcom_qmp *qmp,
> +				       const struct qmp_phy_cfg *cfg)
> +{
> +	struct typec_switch_desc sw_desc = {};
> +	struct typec_mux_desc mux_desc = {};
> +	struct device *dev = qmp->dev;
> +
> +	if (!cfg->has_phy_dp_com_ctrl)
> +		return 0;
> +
> +	sw_desc.drvdata = qmp;
> +	sw_desc.fwnode = dev->fwnode;
> +	sw_desc.set = qcom_qmp_phy_typec_switch_set;
> +	qmp->sw = typec_switch_register(dev, &sw_desc);
> +	if (IS_ERR(qmp->sw)) {
> +		dev_err(dev, "Error registering typec switch: %pe\n", qmp->sw);
> +		return PTR_ERR(qmp->sw);
> +	}
> +
> +	mux_desc.drvdata = qmp;
> +	mux_desc.fwnode = dev->fwnode;
> +	mux_desc.set = qcom_qmp_phy_typec_mux_set;
> +	qmp->mux = typec_mux_register(dev, &mux_desc);
> +	if (IS_ERR(qmp->mux)) {
> +		dev_err(dev, "Error registering typec mux: %pe\n", qmp->mux);
> +		typec_switch_unregister(qmp->sw);
> +		return PTR_ERR(qmp->mux);
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_qmp_phy_typec_unregister(struct qcom_qmp *qmp)
> +{
> +	typec_mux_unregister(qmp->mux);
> +	typec_switch_unregister(qmp->sw);
> +}
> +#else

empty line here pls

> +static int qcom_qmp_phy_typec_register(struct qcom_qmp *qmp,
> +				       const struct qmp_phy_cfg *cfg)
> +{
> +	return 0;
> +}
> +
> +static void qcom_qmp_phy_typec_unregister(struct qcom_qmp *qmp)
> +{
> +}
> +#endif
> +
>  static int qcom_qmp_phy_probe(struct platform_device *pdev)
>  {
>  	struct qcom_qmp *qmp;
> @@ -5891,7 +6010,15 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	num = of_get_available_child_count(dev->of_node);
> +	ret = qcom_qmp_phy_typec_register(qmp, cfg);
> +	if (ret)
> +		return ret;
> +
> +	num = 0;
> +	for_each_available_child_of_node(dev->of_node, child) {
> +		if (!of_node_name_eq(child, "port"))
> +			num++;
> +	}
>  	/* do we have a rogue child node ? */
>  	if (num > expected_phys)
>  		return -EINVAL;
> @@ -5918,6 +6045,9 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
>  			serdes = usb_serdes;
>  		}
>  
> +		if (of_node_name_eq(child, "port"))
> +			continue;
> +
>  		/* Create per-lane phy */
>  		ret = qcom_qmp_phy_create(dev, child, id, serdes, cfg);
>  		if (ret) {
> @@ -5962,8 +6092,18 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_qmp_phy_remove(struct platform_device *pdev)
> +{
> +	struct qcom_qmp *qmp = platform_get_drvdata(pdev);
> +
> +	qcom_qmp_phy_typec_unregister(qmp);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver qcom_qmp_phy_driver = {
>  	.probe		= qcom_qmp_phy_probe,
> +	.remove		= qcom_qmp_phy_remove,
>  	.driver = {
>  		.name	= "qcom-qmp-phy",
>  		.pm	= &qcom_qmp_phy_pm_ops,
> -- 
> 2.33.1

-- 
~Vinod
