Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC9473DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhLNHcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:32:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52240 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhLNHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:32:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6E41B817E5;
        Tue, 14 Dec 2021 07:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24F2C34604;
        Tue, 14 Dec 2021 07:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639467170;
        bh=pQyER7T0WE9UAG/q7rCKCBxfJ83RpRjTruPbnXb4S2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvZWbf0Pd6n2qGVpw/t67mZ2xxyyuwwWXPaxYslEC+UGwI8HUbVgeDbt/Ahq14TQ6
         dXgM+VIvuVJ6fMSgP54TPGx8x0CO/JTIRME4ps1G5/eWwO7THxQhs945KiUw+sa6fw
         V3VZUMjdFHbuCPl5fuaeuv/JVNEGxW9EDibkYhJcw6IogtjY0484RPve1NH+lygGdC
         dBm5RKiGOx92jlNpHyKeYkkKs8ZoKh9feos7RoKK9VDwkMqZTpPhGbXFqpAqETDYeC
         v613iLUMBvAM4aqsBsxINIFKuBaGlw8I51wG0hjyVvAOgEXtJcHTLlNgqnhm5RuJiW
         b1Cox3miF2A4w==
Date:   Tue, 14 Dec 2021 13:02:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: phy-can-transceiver: Add support for setting mux
Message-ID: <YbhInhyZH9d0HGGf@matsya>
References: <20211202131002.12217-1-a-govindraju@ti.com>
 <20211202131002.12217-3-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202131002.12217-3-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-21, 18:40, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceiver,
> muxes might need to be set. Therefore, add support for setting the mux by
> reading the mux-states property from the device tree node.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/phy/Kconfig               |  1 +
>  drivers/phy/phy-can-transceiver.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 82b63e60c5a2..300b0f2b5f84 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -64,6 +64,7 @@ config USB_LGM_PHY
>  config PHY_CAN_TRANSCEIVER
>  	tristate "CAN transceiver PHY"
>  	select GENERIC_PHY
> +	select MULTIPLEXER
>  	help
>  	  This option enables support for CAN transceivers as a PHY. This
>  	  driver provides function for putting the transceivers in various
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index 6f3fe37dee0e..cb91d0e94da7 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -10,6 +10,7 @@
>  #include<linux/module.h>
>  #include<linux/gpio.h>
>  #include<linux/gpio/consumer.h>
> +#include <linux/mux/consumer.h>
>  
>  struct can_transceiver_data {
>  	u32 flags;
> @@ -21,13 +22,22 @@ struct can_transceiver_phy {
>  	struct phy *generic_phy;
>  	struct gpio_desc *standby_gpio;
>  	struct gpio_desc *enable_gpio;
> +	struct mux_state *mux_state;
>  };
>  
>  /* Power on function */
>  static int can_transceiver_phy_power_on(struct phy *phy)
>  {
> +	int ret;
>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);

reverse christmas tree notation is typically use, so new addition at the
end here please

>  
> +	if (can_transceiver_phy->mux_state) {
> +		ret = mux_state_select(can_transceiver_phy->mux_state);
> +		if (ret) {
> +			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
> +			return ret;
> +		}
> +	}
>  	if (can_transceiver_phy->standby_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
>  	if (can_transceiver_phy->enable_gpio)
> @@ -45,6 +55,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
>  	if (can_transceiver_phy->enable_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
> +	if (can_transceiver_phy->mux_state)
> +		mux_state_deselect(can_transceiver_phy->mux_state);
>  
>  	return 0;
>  }
> @@ -95,6 +107,16 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata = match->data;
>  
> +	if (of_property_read_bool(dev->of_node, "mux-states")) {
> +		struct mux_state *mux_state;
> +
> +		mux_state = devm_mux_state_get(dev, NULL);
> +		if (IS_ERR(mux_state))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(mux_state),
> +					     "failed to get mux\n");
> +		can_transceiver_phy->mux_state = mux_state;
> +	}
> +
>  	phy = devm_phy_create(dev, dev->of_node,
>  			      &can_transceiver_phy_ops);
>  	if (IS_ERR(phy)) {
> -- 
> 2.17.1

-- 
~Vinod
