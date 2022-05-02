Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2297B516DF8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384376AbiEBKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384505AbiEBKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:16:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C9C1A041
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:12:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nlT2W-0005kl-ND; Mon, 02 May 2022 12:12:24 +0200
Message-ID: <c9cfecf9cf6d75a2fb70fafa5e82baee414c6496.camel@pengutronix.de>
Subject: Re: [PATCH v1 2/4] soc: imx: imx8m-blk-ctrl: Display Power ON
 sequence
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Viraj Shah <viraj.shah@linutronix.de>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 May 2022 12:12:22 +0200
In-Reply-To: <20220502100233.6023-3-viraj.shah@linutronix.de>
References: <20220502100233.6023-1-viraj.shah@linutronix.de>
         <20220502100233.6023-3-viraj.shah@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 02.05.2022 um 12:02 +0200 schrieb Viraj Shah:
> Enable the dispmix software clock and release the resets
> as shown in the 5.2.9.5 section of reference manual.
> 
> Signed-off-by: Viraj Shah <viraj.shah@linutronix.de>
> ---
>  drivers/soc/imx/imx8m-blk-ctrl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index 122f9c884b38..ca63fd30e70a 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -99,7 +99,10 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  		dev_err(bc->dev, "failed to enable clocks\n");
>  		goto bus_put;
>  	}
> -	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +	/* As per section 5.2.9.5 of reference manual imx-8MMini-yhsc.pdf,
> +	 * enable dispmix sft clock to power on the display
> +	 */
> +	regmap_write(bc->regmap, BLK_CLK_EN, 0x1FFF);

Nack. The only clock that needs to be handled here is the ADB clock for
the handshake. All other clocks are enabled by the virtual power
domains provided by this blk-ctrl driver when the peripheral power up.

Regards,
Lucas

>  
>  	/* power up upstream GPC domain */
>  	ret = pm_runtime_get_sync(domain->power_dev);
> @@ -112,7 +115,7 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  	udelay(5);
>  
>  	/* release reset */
> -	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
> +	regmap_write(bc->regmap, BLK_SFT_RSTN, 0x7F);
>  	if (data->mipi_phy_rst_mask)
>  		regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
>  


