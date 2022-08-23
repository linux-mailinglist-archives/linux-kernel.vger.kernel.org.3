Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6F59ECB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiHWTqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiHWTqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:13 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65FDC12F6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:49:06 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oQYxM-0006cy-NL; Tue, 23 Aug 2022 20:48:56 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: rockchip-inno-usb2: Return zero after otg sync
Date:   Tue, 23 Aug 2022 20:48:55 +0200
Message-ID: <2872516.OBFZWjSADL@diego>
In-Reply-To: <20220823144728.47068-1-pgwipeout@gmail.com>
References: <20220823144728.47068-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 23. August 2022, 16:47:28 CEST schrieb Peter Geis:
> The otg sync state patch reuses the ret variable, but fails to set it to
> zero after use. This leads to a situation when the otg port is in
> peripheral mode where the otg phy aborts halfway through setup.  It also
> fails to account for a failure to register the extcon notifier. Fix this
> by using our own variable and skipping otg sync in case of failure.
> 
> Fixes: 8dc60f8da22f ("phy: rockchip-inno-usb2: Sync initial otg state")
> 
> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> Reported-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 0b1e9337ee8e..d579a22c61df 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1124,7 +1124,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>  					  struct rockchip_usb2phy_port *rport,
>  					  struct device_node *child_np)
>  {
> -	int ret;
> +	int ret, id;
>  
>  	rport->port_id = USB2PHY_PORT_OTG;
>  	rport->port_cfg = &rphy->phy_cfg->port_cfgs[USB2PHY_PORT_OTG];
> @@ -1164,11 +1164,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>  					EXTCON_USB_HOST, &rport->event_nb);
>  		if (ret)
>  			dev_err(rphy->dev, "register USB HOST notifier failed\n");
> +			goto out;
>  
>  		if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {
>  			/* do initial sync of usb state */
> -			ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
> -			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
> +			id = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
> +			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !id);
>  		}
>  	}
>  
> 




