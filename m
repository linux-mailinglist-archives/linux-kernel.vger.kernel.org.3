Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BDA516E01
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384438AbiEBKSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiEBKSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:18:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD39A23C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:15:11 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nlT50-00066e-Rq; Mon, 02 May 2022 12:14:58 +0200
Message-ID: <5e93e411e1100c5d8292327b9aea560bfcbda7d1.camel@pengutronix.de>
Subject: Re: [PATCH v1 4/4] arm64: dts: imx8mm.dtsi: Add resets for dispmix
 power domain.
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Viraj Shah <viraj.shah@linutronix.de>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 May 2022 12:14:57 +0200
In-Reply-To: <20220502100233.6023-5-viraj.shah@linutronix.de>
References: <20220502100233.6023-1-viraj.shah@linutronix.de>
         <20220502100233.6023-5-viraj.shah@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
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

Am Montag, dem 02.05.2022 um 12:02 +0200 schrieb Viraj Shah:
> The resets are controlled from src. From reference manual page
> 959, display controller needs DISP_RESET bit to be set to reset
> dispmix.
> 
This reset is driven by the GPC hardware logic. Only if you are 100%
sure that this is not the case should a reset be added to the DT, as
handling it both from the GPC HW sequencing and software has proven to
be problematic and result in sporadic hangs.

Regards,
Lucas

> Signed-off-by: Viraj Shah <viraj.shah@linutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 1ee05677c2dd..11a6cae5bb99 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -734,6 +734,7 @@
>  						assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
>  									 <&clk IMX8MM_SYS_PLL1_800M>;
>  						assigned-clock-rates = <500000000>, <200000000>;
> +						resets = <&src IMX8MQ_RESET_DISP_RESET>;
>  					};
>  
>  					pgc_mipi: power-domain@11 {


