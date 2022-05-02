Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A907C516DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384430AbiEBKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384418AbiEBKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:15:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA31A832
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:11:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nlT1e-0005h4-1P; Mon, 02 May 2022 12:11:30 +0200
Message-ID: <3679d0b1171a9c097e496cb325c8898d6c6e5902.camel@pengutronix.de>
Subject: Re: [PATCH v1 1/4] soc: imx8mm: gpcv2: Power sequence for DISP
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Viraj Shah <viraj.shah@linutronix.de>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 May 2022 12:11:28 +0200
In-Reply-To: <20220502100233.6023-2-viraj.shah@linutronix.de>
References: <20220502100233.6023-1-viraj.shah@linutronix.de>
         <20220502100233.6023-2-viraj.shah@linutronix.de>
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

Hi Viraj,

Am Montag, dem 02.05.2022 um 12:02 +0200 schrieb Viraj Shah:
> As per the imx8mm reference manual, read bit 25(GPC_DISPMIX_
> PWRDNACKN) of the power handshake register and wait for ack during
> power on/off.
> 
> Signed-off-by: Viraj Shah <viraj.shah@linutronix.de>
> ---
>  drivers/soc/imx/gpcv2.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 3cb123016b3e..8ee70c30964f 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -254,11 +254,24 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>  		/*
>  		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
>  		 * for PUP_REQ/PDN_REQ bit to be cleared
> +		 *
> +		 * As per "5.2.9.5 Example Code 5" in i.MX-8MMini-yhsc.pdf
> +		 * Display power on section checks for bit 25 of
> +		 * Power handshake register to be cleared.
>  		 */
> -		ret = regmap_read_poll_timeout(domain->regmap,
> -					       GPC_PU_PGC_SW_PUP_REQ, reg_val,
> -					       !(reg_val & domain->bits.pxx),
> -					       0, USEC_PER_MSEC);
> +		if (domain->bits.pxx == IMX8MM_DISPMIX_SW_Pxx_REQ) {
> +			regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
> +				   BIT(7), BIT(7));
> +			ret = regmap_read_poll_timeout(domain->regmap,
> +						GPC_PU_PWRHSK, reg_val,
> +						!(reg_val & IMX8MM_DISPMIX_HSK_PWRDNACKN),
> +						0, USEC_PER_MSEC);
> +		} else
> +			ret = regmap_read_poll_timeout(domain->regmap,
> +						GPC_PU_PGC_SW_PUP_REQ, reg_val,
> +						!(reg_val & domain->bits.pxx),
> +						0, USEC_PER_MSEC);
> +
The driver already handles the PWRHSK bits at the appropriate places.
Please do not hack in random sequences from the reference manual for
specific domains. Also you can not wait for the handshake ack in the
power up sequence, as the blk-ctrl driver only enables the ADB clock,
_after_ the GPC power domain has been powered up, so there is no way
for it to so the handshake here. See the comments in the blk-ctrl
driver.

Regards,
Lucas

>  		if (ret) {
>  			dev_err(domain->dev, "failed to command PGC\n");
>  			goto out_clk_disable;
> @@ -355,11 +368,24 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
>  		/*
>  		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
>  		 * for PUP_REQ/PDN_REQ bit to be cleared
> +		 *
> +		 * As per "5.2.9.5 Example Code 5" in i.MX-8MMini-yhsc.pdf
> +		 * Display power on section checks for bit 25 of
> +		 * Power handshake register to be set.
>  		 */
> -		ret = regmap_read_poll_timeout(domain->regmap,
> +		if (domain->bits.pxx == IMX8MM_DISPMIX_SW_Pxx_REQ) {
> +			regmap_clear_bits(domain->regmap, GPC_PU_PWRHSK,
> +				   BIT(7));
> +			ret = regmap_read_poll_timeout(domain->regmap,
> +						GPC_PU_PWRHSK, reg_val,
> +						!(reg_val & IMX8MM_DISPMIX_HSK_PWRDNACKN),
> +						0, USEC_PER_MSEC);
> +		} else {
> +			ret = regmap_read_poll_timeout(domain->regmap,
>  					       GPC_PU_PGC_SW_PDN_REQ, reg_val,
>  					       !(reg_val & domain->bits.pxx),
>  					       0, USEC_PER_MSEC);
> +		}
>  		if (ret) {
>  			dev_err(domain->dev, "failed to command PGC\n");
>  			goto out_clk_disable;


