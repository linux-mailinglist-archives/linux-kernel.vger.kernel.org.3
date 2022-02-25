Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8329D4C4B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243423AbiBYQ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbiBYQ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:59:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA2E1A7DBA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:59:02 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nNdvk-0004kZ-Pg; Fri, 25 Feb 2022 17:58:56 +0100
Message-ID: <919a0564850fbf4768e9d98c9beba60cc736077b.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Fix IMX8MN_DISPBLK_PD_ISI hang
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 25 Feb 2022 17:58:55 +0100
In-Reply-To: <20220225161741.395505-1-aford173@gmail.com>
References: <20220225161741.395505-1-aford173@gmail.com>
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

Am Freitag, dem 25.02.2022 um 10:17 -0600 schrieb Adam Ford:
> When attempting to communicate with the ISI, the system hangs.
> Through trial and error, it appears removing the two root clocks
> fixes the issues.  Since IMX8MN_DISPBLK_PD_ISI enables the
> pgc_dispmix, and pgc_dispmix enables those same root clocks, it should be
> safe.
> 
This doesn't look right. Why would this make a difference?

The only difference is that those clocks may be disabled at the end of
the power-up routine when they are assigned to the blk-ctrl domain. If
ISI communication hangs while those clocks are disabled, then that is
more of a hint for a missing clock enable on the ISI driver side than
an issue on the blk-ctrl side.

Regards,
Lucas

> Fixes: 7f511d514e8c ("soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index 122f9c884b38..cacf379aef80 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -574,9 +574,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[]
>  	},
>  	[IMX8MN_DISPBLK_PD_ISI] = {
>  		.name = "dispblk-isi",
> -		.clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
> -						"disp_apb_root"},
> -		.num_clks = 4,
> +		.clk_names = (const char *[]){ "disp_axi", "disp_apb" },
> +		.num_clks = 2,
>  		.gpc_name = "isi",
>  		.rst_mask = BIT(6) | BIT(7),
>  		.clk_mask = BIT(6) | BIT(7),


