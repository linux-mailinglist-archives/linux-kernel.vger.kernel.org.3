Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED25AC4D7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiIDOpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIDOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9027D2FFD3;
        Sun,  4 Sep 2022 07:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24C9660F9E;
        Sun,  4 Sep 2022 14:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96037C433D6;
        Sun,  4 Sep 2022 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662302745;
        bh=lRnCSu1PcWRi1dcwd3ZSbkYCjHJYOQ7jhl/iMlUpALI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDQQJkIEw9Ne28COBtbnCJVSxB2/WS/tiPua3lQ97NQ2GDC6/njoTDxDozzF05SxW
         gtf6nC7ZTCOEsKChsHqmacSQ6e+i1rMoQtFBnKeICfohnOSNSQl68mym0XfoOVMvf8
         NiteCsplLZm5VRif9Nz6hnaBe5IHPI7Qthd+/wGzB4tS1zA2tDj+BG3OjF5liZ+8oz
         HnRmNvg4uvG+fVYDXVWhNFuc0FDtsqo2QXZXHfJ6n0559ATh5gtbg2ljubMxgJb2iu
         WqFy8mgtYNkh5sw2J3MIYEKVoSnQ/Jbrzhccxg0x4airiDWbUd9lVEsG8ZetwvMuhw
         2Cs8PuMhiYdGA==
Date:   Sun, 4 Sep 2022 20:15:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     jckuo@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        balbi@kernel.org, gregkh@linuxfoundation.org, bhsieh@nvidia.com,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] phy: tegra: xusb: add utmi pad power on/down ops
Message-ID: <YxS6FBeyS1Cs7xhI@matsya>
References: <20220816082353.13390-1-jilin@nvidia.com>
 <20220816082353.13390-2-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816082353.13390-2-jilin@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-08-22, 16:23, Jim Lin wrote:
> Add utmi_pad_power_on/down ops for each SOC instead of exporting
> tegra_phy_xusb_utmi_pad_power_on/down directly for Tegra186 chip.

Can you please help me understand why do we need to utmi power_on/down
exported and cant be handled thry phy-ops..

> 
> Signed-off-by: BH Hsieh <bhsieh@nvidia.com>
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: update copyright year 
> 
>  drivers/phy/tegra/xusb-tegra186.c | 19 ++++++++++++-------
>  drivers/phy/tegra/xusb.c          | 22 +++++++++++++++++++++-
>  drivers/phy/tegra/xusb.h          |  4 +++-
>  include/linux/phy/tegra/xusb.h    |  4 +++-
>  4 files changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
> index ae3915ed9fef..5abdf81aa143 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2016-2020, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2016-2022, NVIDIA CORPORATION.  All rights reserved.
>   */
>  
>  #include <linux/delay.h>
> @@ -638,7 +638,7 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
>  	mutex_unlock(&padctl->lock);
>  }
>  
> -static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
> +static void tegra186_utmi_pad_power_on(struct phy *phy)
>  {
>  	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>  	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
> @@ -656,6 +656,8 @@ static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
>  		return;
>  	}
>  
> +	dev_dbg(dev, "power on UTMI pad %u\n", index);
> +
>  	tegra186_utmi_bias_pad_power_on(padctl);
>  
>  	udelay(2);
> @@ -669,7 +671,7 @@ static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
>  	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>  }
>  
> -static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
> +static void tegra186_utmi_pad_power_down(struct phy *phy)
>  {
>  	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>  	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
> @@ -679,6 +681,8 @@ static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
>  	if (!phy)
>  		return;
>  
> +	dev_dbg(padctl->dev, "power down UTMI pad %u\n", index);
> +
>  	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>  	value |= USB2_OTG_PD;
>  	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> @@ -849,15 +853,14 @@ static int tegra186_utmi_phy_power_on(struct phy *phy)
>  	value |= RPD_CTRL(priv->calib.rpd_ctrl);
>  	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>  
> -	/* TODO: pad power saving */
> -	tegra_phy_xusb_utmi_pad_power_on(phy);
> +	tegra186_utmi_pad_power_on(phy);
> +
>  	return 0;
>  }
>  
>  static int tegra186_utmi_phy_power_off(struct phy *phy)
>  {
> -	/* TODO: pad power saving */
> -	tegra_phy_xusb_utmi_pad_power_down(phy);
> +	tegra186_utmi_pad_power_down(phy);
>  
>  	return 0;
>  }
> @@ -1486,6 +1489,8 @@ static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
>  	.suspend_noirq = tegra186_xusb_padctl_suspend_noirq,
>  	.resume_noirq = tegra186_xusb_padctl_resume_noirq,
>  	.vbus_override = tegra186_xusb_padctl_vbus_override,
> +	.utmi_pad_power_on = tegra186_utmi_pad_power_on,
> +	.utmi_pad_power_down = tegra186_utmi_pad_power_down,
>  };
>  
>  #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 963de5913e50..49873718d54a 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2014-2020, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2014-2022, NVIDIA CORPORATION.  All rights reserved.
>   */
>  
>  #include <linux/delay.h>
> @@ -1458,6 +1458,26 @@ int tegra_phy_xusb_utmi_port_reset(struct phy *phy)
>  }
>  EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_port_reset);
>  
> +void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
> +{
> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
> +
> +	if (padctl->soc->ops->utmi_pad_power_on)
> +		padctl->soc->ops->utmi_pad_power_on(phy);
> +}
> +EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_pad_power_on);
> +
> +void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
> +{
> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
> +
> +	if (padctl->soc->ops->utmi_pad_power_down)
> +		padctl->soc->ops->utmi_pad_power_down(phy);
> +}
> +EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_pad_power_down);
> +
>  int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
>  				    unsigned int port)
>  {
> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
> index 034f7a2c28d6..8cfbbdbd6e0c 100644
> --- a/drivers/phy/tegra/xusb.h
> +++ b/drivers/phy/tegra/xusb.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2014-2020, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2014-2022, NVIDIA CORPORATION.  All rights reserved.
>   * Copyright (c) 2015, Google Inc.
>   */
>  
> @@ -412,6 +412,8 @@ struct tegra_xusb_padctl_ops {
>  				    unsigned int index, bool enable);
>  	int (*vbus_override)(struct tegra_xusb_padctl *padctl, bool set);
>  	int (*utmi_port_reset)(struct phy *phy);
> +	void (*utmi_pad_power_on)(struct phy *phy);
> +	void (*utmi_pad_power_down)(struct phy *phy);
>  };
>  
>  struct tegra_xusb_padctl_soc {
> diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
> index 3a35e74cdc61..70998e6dd6fd 100644
> --- a/include/linux/phy/tegra/xusb.h
> +++ b/include/linux/phy/tegra/xusb.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2016-2020, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2016-2022, NVIDIA CORPORATION.  All rights reserved.
>   */
>  
>  #ifndef PHY_TEGRA_XUSB_H
> @@ -21,6 +21,8 @@ int tegra_xusb_padctl_usb3_set_lfps_detect(struct tegra_xusb_padctl *padctl,
>  					   unsigned int port, bool enable);
>  int tegra_xusb_padctl_set_vbus_override(struct tegra_xusb_padctl *padctl,
>  					bool val);
> +void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy);
> +void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy);
>  int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
>  int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
>  					 unsigned int port);
> -- 
> 2.17.1

-- 
~Vinod
