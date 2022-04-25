Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6450E44C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbiDYP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiDYP0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:26:09 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5B3E1245;
        Mon, 25 Apr 2022 08:23:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 88251DF69E;
        Mon, 25 Apr 2022 08:22:34 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ykxmL21nwvSi; Mon, 25 Apr 2022 08:22:33 -0700 (PDT)
Message-ID: <d6c5c5663f8ae904d409240063295cf516e17dd1.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1650900153; bh=PoAhs4rC8s2VNE3r6xYLUglE7+vVgjEdcfrBZL7HIYw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TwWQx10+OrU5+LF4ic3BCkWUrj/bBD5KMY098Yi8iUApqrklehSe05vVv8EPRVqUb
         RWUi3fVqmTLK9uO7dolTzkIjwbG6BY4TCw7U0y/nzutY6qdNqZ+LK+qS5xZnCEkJEL
         AefHq+1F6sbK5QHuHFKO3j4SgtDT2hD6HNDFjIwUmdL29WqGUcKVF3OQtCIYWBxmKT
         +q4h9vT0Eay/TRIzdS6xvcFgzoN3UNppXHLBC/YZnD7gH0dxOsXVS6bPM/L1UMG6Jx
         yZonZuU3caMCSVPm+4QLnTH7SpYampk4ZgzpjFalBtPyZiB5K9+LtRJfKH/wtdDw9o
         QJHtNAjnwXevA==
Subject: Re: [PATCH V4 07/11] arm64: dts: imx8mq: Enable both G1 and G2
 VPU's with vpu-blk-ctrl
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Adam Ford <aford173@gmail.com>, linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
        kernel test robot <lkp@intel.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Date:   Mon, 25 Apr 2022 17:22:24 +0200
In-Reply-To: <20220125171129.472775-8-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com>
         <20220125171129.472775-8-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 25.01.2022 um 11:11 -0600 schrieb Adam Ford:
> With the Hantro G1 and G2 now setup to run independently, update
> the device tree to allow both to operate.  This requires the
> vpu-blk-ctrl node to be configured.  Since vpu-blk-ctrl needs
> certain clock enabled to handle the gating of the G1 and G2
> fuses, the clock-parents and clock-rates for the various VPU's
> to be moved into the pgc_vpu because they cannot get re-parented
> once enabled, and the pgc_vpu is the highest in the chain.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 2df2510d0118..549b2440f55d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -737,7 +737,21 @@ pgc_gpu: power-domain@5 {
>                                         pgc_vpu: power-domain@6 {
>                                                 #power-domain-cells =
> <0>;
>                                                 reg =
> <IMX8M_POWER_DOMAIN_VPU>;
> -                                               clocks = <&clk
> IMX8MQ_CLK_VPU_DEC_ROOT>;
> +                                               clocks = <&clk
> IMX8MQ_CLK_VPU_DEC_ROOT>,
> +                                                        <&clk
> IMX8MQ_CLK_VPU_G1_ROOT>,
> +                                                        <&clk
> IMX8MQ_CLK_VPU_G2_ROOT>;
> +                                               assigned-clocks =
> <&clk IMX8MQ_CLK_VPU_G1>,
> +                                                                
> <&clk IMX8MQ_CLK_VPU_G2>,
> +                                                                
> <&clk IMX8MQ_CLK_VPU_BUS>,
> +                                                                
> <&clk IMX8MQ_VPU_PLL_BYPASS>;
> +                                               assigned-clock-
> parents = <&clk IMX8MQ_VPU_PLL_OUT>,
> +                                                                    
>     <&clk IMX8MQ_VPU_PLL_OUT>,
> +                                                                    
>     <&clk IMX8MQ_SYS1_PLL_800M>,
> +                                                                    
>     <&clk IMX8MQ_VPU_PLL>;
> +                                               assigned-clock-rates
> = <600000000>,
> +                                                                    
>   <600000000>,
> +                                                                    
>   <800000000>,
> +                                                                    
>   <0>;
>                                         };
>  
>                                         pgc_disp: power-domain@7 {
> @@ -1457,30 +1471,31 @@ usb3_phy1: usb-phy@382f0040 {
>                         status = "disabled";
>                 };
>  
> -               vpu: video-codec@38300000 {
> -                       compatible = "nxp,imx8mq-vpu";
> -                       reg = <0x38300000 0x10000>,
> -                             <0x38310000 0x10000>,
> -                             <0x38320000 0x10000>;
> -                       reg-names = "g1", "g2", "ctrl";
> -                       interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "g1", "g2";
> +               vpu_g1: video-codec@38300000 {
> +                       compatible = "nxp,imx8mq-vpu-g1";
> +                       reg = <0x38300000 0x10000>;
> +                       interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>;
> +                       power-domains = <&vpu_blk_ctrl
> IMX8MQ_VPUBLK_PD_G1>;
> +               };
> +
> +               vpu_g2: video-codec@38310000 {
> +                       compatible = "nxp,imx8mq-vpu-g2";
> +                       reg = <0x38310000 0x10000>;
> +                       interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> +                       power-domains = <&vpu_blk_ctrl
> IMX8MQ_VPUBLK_PD_G2>;
> +               };
> +
> +               vpu_blk_ctrl: blk-ctrl@38320000 {
> +                       compatible = "fsl,imx8mq-vpu-blk-ctrl";
> +                       reg = <0x38320000 0x100>;
> +                       power-domains = <&pgc_vpu>, <&pgc_vpu>,
> <&pgc_vpu>;
> +                       power-domain-names = "bus", "g1", "g2";
>                         clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
> -                                <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
> -                                <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
> -                       clock-names = "g1", "g2", "bus";
> -                       assigned-clocks = <&clk IMX8MQ_CLK_VPU_G1>,
> -                                         <&clk IMX8MQ_CLK_VPU_G2>,
> -                                         <&clk IMX8MQ_CLK_VPU_BUS>,
> -                                         <&clk
> IMX8MQ_VPU_PLL_BYPASS>;
> -                       assigned-clock-parents = <&clk
> IMX8MQ_VPU_PLL_OUT>,
> -                                                <&clk
> IMX8MQ_VPU_PLL_OUT>,
> -                                                <&clk
> IMX8MQ_SYS1_PLL_800M>,
> -                                                <&clk
> IMX8MQ_VPU_PLL>;
> -                       assigned-clock-rates = <600000000>,
> <600000000>,
> -                                              <800000000>, <0>;
> -                       power-domains = <&pgc_vpu>;
> +                                <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> +                       clock-names = "g1", "g2";
> +                       #power-domain-cells = <1>;
>                 };
>  
>                 pcie0: pcie@33800000 {

With this update, when testing suspend to ram on imx8mq, I get:

buck4: failed to disable: -ETIMEDOUT

where buck4 is power-supply of pgc_vpu. And thus the transition to
suspend (and resuming) fails.

Have you tested system suspend after the imx8m-blk-ctrl update on
imx8mq?

thank you,

                                 martin

