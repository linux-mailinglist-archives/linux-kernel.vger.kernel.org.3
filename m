Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605175543F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352855AbiFVHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352481AbiFVHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:24:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A4436E1F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:24:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1o3uj8-0006a9-Lb; Wed, 22 Jun 2022 09:24:38 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1o3uj5-00005j-TU; Wed, 22 Jun 2022 09:24:35 +0200
Date:   Wed, 22 Jun 2022 09:24:35 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        hvilleneuve@dimonoff.com, l.stach@pengutronix.de,
        abbaraju.manojsai@amarulasolutions.com, jagan@amarulasolutions.com,
        matteo.lisi@engicam.com, tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
Message-ID: <20220622072435.GT1615@pengutronix.de>
References: <20220622062027.994614-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622062027.994614-1-peng.fan@oss.nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Saravana Kannan <saravanak@google.com>, the author of 71066545b48e4

On Wed, Jun 22, 2022 at 02:20:27PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Commit 71066545b48e4("driver core: Set fw_devlink.strict=1 by default")
> default set fw_devlink to true. This has a side effect to i.MX uart
> console. The sdma will make the i.MX8MP uart driver defer probe for some
> time (~10s with i.MX8MP-EVK board) until sdma ready, because sdma is a
> supplier with property dmas set in device tree node.

I just tested this on an i.MX6 board and observed the same behaviour.
The same will happen on any other i.MX board as well. This will also
likely happen on any other SoC on which the UART driver uses dmaengine.

> 
> Since this uart is for console, we need log printed out as soon as
> possible, so remove the dmas property for the uart console node.

Fixing this at board level is not really an option because that means
fixing each and every, at least i.MX board in the tree. Furthermore
this would mean to bring the deleted property back in and to remove
another dmas property should a user want to switch to another console
port.

For what it's worth: NACK for 71066545b48e4.

Sascha

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  The upper set fw_devlink.strict=1 patch is in linux-next tree.
> 
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts                  | 2 ++
>  arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts | 2 ++
>  arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts  | 2 ++
>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts        | 2 ++
>  4 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index fb11c03bc8b1..3fdb38bc0069 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -359,6 +359,8 @@ &uart2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart2>;
>  	status = "okay";
> +	/delete-property/ dmas;
> +	/delete-property/ dma-names;
>  };
>  
>  &usb3_phy1 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> index dd703b6a5e17..fb2b44e94482 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> @@ -69,6 +69,8 @@ &uart2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart2>;
>  	status = "okay";
> +	/delete-property/ dmas;
> +	/delete-property/ dma-names;
>  };
>  
>  &usb3_phy0 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> index 6aa720bafe28..68a478151292 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> @@ -99,6 +99,8 @@ &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
>  	status = "okay";
> +	/delete-property/ dmas;
> +	/delete-property/ dma-names;
>  };
>  
>  /* SD-Card */
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> index 521215520a0f..f90c1ac2791c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> @@ -554,6 +554,8 @@ &uart2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart2>;
>  	status = "okay";
> +	/delete-property/ dmas;
> +	/delete-property/ dma-names;
>  };
>  
>  &uart4 {
> -- 
> 2.25.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
