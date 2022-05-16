Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF852848C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiEPMuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243500AbiEPMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:49:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8239697
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:49:20 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nqa9y-0007e3-D2; Mon, 16 May 2022 14:49:14 +0200
Message-ID: <86815346-209e-304e-3565-b4160afa48e8@pengutronix.de>
Date:   Mon, 16 May 2022 14:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 02/17] Revert "ARM: dts: imx6qdl-apalis: Avoid
 underscore in node name"
Content-Language: en-US
To:     Max Krummenacher <max.oss.09@gmail.com>,
        max.krummenacher@toradex.com
Cc:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220516115846.58328-1-max.oss.09@gmail.com>
 <20220516115846.58328-3-max.oss.09@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220516115846.58328-3-max.oss.09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.22 13:58, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The STMPE MFD device binding requires the child node to have a fixed
> name, i.e. with '_', not '-'. Otherwise the stmpe_adc, stmpe_touchscreen
> drivers will not be probed.

IMO, the Linux driver should be fixed and the requirement to use a fixed
node name be dropped from the binding. The driver itself already probes
by compatible, the node name seems only to be used by the MFD driver to
detect which functions to enable. It could do the same by checking for
compatibles. Otherwise you invite a game of cat and mouse, where in
future, this is changed back again reintroducing the regression..
 
> Fixes: 56086b5e804f ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Anyway, as a fix, this looks ok for now:

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Cheers,
Ahmad

> ---
> 
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index bd763bae596b..da919d0544a8 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -315,7 +315,7 @@
>  		/* ADC conversion time: 80 clocks */
>  		st,sample-time = <4>;
>  
> -		stmpe_touchscreen: stmpe-touchscreen {
> +		stmpe_touchscreen: stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
> @@ -332,7 +332,7 @@
>  			st,touch-det-delay = <5>;
>  		};
>  
> -		stmpe_adc: stmpe-adc {
> +		stmpe_adc: stmpe_adc {
>  			compatible = "st,stmpe-adc";
>  			/* forbid to use ADC channels 3-0 (touch) */
>  			st,norequest-mask = <0x0F>;


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
