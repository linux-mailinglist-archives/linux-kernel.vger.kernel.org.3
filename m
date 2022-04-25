Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7903950E484
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbiDYPi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242842AbiDYPiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:38:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D986D45519
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:35:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nj0jW-0001it-Ip; Mon, 25 Apr 2022 17:34:38 +0200
Message-ID: <4b958892ba788a0e9e73a9135c305aacbe33294d.camel@pengutronix.de>
Subject: Re: [PATCH V4 07/11] arm64: dts: imx8mq: Enable both G1 and G2
 VPU's with vpu-blk-ctrl
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Adam Ford <aford173@gmail.com>, linux-media@vger.kernel.org
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
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Date:   Mon, 25 Apr 2022 17:34:34 +0200
In-Reply-To: <d6c5c5663f8ae904d409240063295cf516e17dd1.camel@puri.sm>
References: <20220125171129.472775-1-aford173@gmail.com>
         <20220125171129.472775-8-aford173@gmail.com>
         <d6c5c5663f8ae904d409240063295cf516e17dd1.camel@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Am Montag, dem 25.04.2022 um 17:22 +0200 schrieb Martin Kepplinger:
> Am Dienstag, dem 25.01.2022 um 11:11 -0600 schrieb Adam Ford:
> > With the Hantro G1 and G2 now setup to run independently, update
> > the device tree to allow both to operate.  This requires the
> > vpu-blk-ctrl node to be configured.  Since vpu-blk-ctrl needs
> > certain clock enabled to handle the gating of the G1 and G2
> > fuses, the clock-parents and clock-rates for the various VPU's
> > to be moved into the pgc_vpu because they cannot get re-parented
> > once enabled, and the pgc_vpu is the highest in the chain.
> > 
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 2df2510d0118..549b2440f55d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -737,7 +737,21 @@ pgc_gpu: power-domain@5 {
> >                                         pgc_vpu: power-domain@6 {
> >                                                 #power-domain-cells =
> > <0>;
> >                                                 reg =
> > <IMX8M_POWER_DOMAIN_VPU>;
> > -                                               clocks = <&clk
> > IMX8MQ_CLK_VPU_DEC_ROOT>;
> > +                                               clocks = <&clk
> > IMX8MQ_CLK_VPU_DEC_ROOT>,
> > +                                                        <&clk
> > IMX8MQ_CLK_VPU_G1_ROOT>,
> > +                                                        <&clk
> > IMX8MQ_CLK_VPU_G2_ROOT>;
> > +                                               assigned-clocks =
> > <&clk IMX8MQ_CLK_VPU_G1>,
> > +                                                                
> > <&clk IMX8MQ_CLK_VPU_G2>,
> > +                                                                
> > <&clk IMX8MQ_CLK_VPU_BUS>,
> > +                                                                
> > <&clk IMX8MQ_VPU_PLL_BYPASS>;
> > +                                               assigned-clock-
> > parents = <&clk IMX8MQ_VPU_PLL_OUT>,
> > +                                                                    
> >     <&clk IMX8MQ_VPU_PLL_OUT>,
> > +                                                                    
> >     <&clk IMX8MQ_SYS1_PLL_800M>,
> > +                                                                    
> >     <&clk IMX8MQ_VPU_PLL>;
> > +                                               assigned-clock-rates
> > = <600000000>,
> > +                                                                    
> >   <600000000>,
> > +                                                                    
> >   <800000000>,
> > +                                                                    
> >   <0>;
> >                                         };
> >  
> >                                         pgc_disp: power-domain@7 {
> > @@ -1457,30 +1471,31 @@ usb3_phy1: usb-phy@382f0040 {
> >                         status = "disabled";
> >                 };
> >  
> > -               vpu: video-codec@38300000 {
> > -                       compatible = "nxp,imx8mq-vpu";
> > -                       reg = <0x38300000 0x10000>,
> > -                             <0x38310000 0x10000>,
> > -                             <0x38320000 0x10000>;
> > -                       reg-names = "g1", "g2", "ctrl";
> > -                       interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > -                                    <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > -                       interrupt-names = "g1", "g2";
> > +               vpu_g1: video-codec@38300000 {
> > +                       compatible = "nxp,imx8mq-vpu-g1";
> > +                       reg = <0x38300000 0x10000>;
> > +                       interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>;
> > +                       power-domains = <&vpu_blk_ctrl
> > IMX8MQ_VPUBLK_PD_G1>;
> > +               };
> > +
> > +               vpu_g2: video-codec@38310000 {
> > +                       compatible = "nxp,imx8mq-vpu-g2";
> > +                       reg = <0x38310000 0x10000>;
> > +                       interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> > +                       power-domains = <&vpu_blk_ctrl
> > IMX8MQ_VPUBLK_PD_G2>;
> > +               };
> > +
> > +               vpu_blk_ctrl: blk-ctrl@38320000 {
> > +                       compatible = "fsl,imx8mq-vpu-blk-ctrl";
> > +                       reg = <0x38320000 0x100>;
> > +                       power-domains = <&pgc_vpu>, <&pgc_vpu>,
> > <&pgc_vpu>;
> > +                       power-domain-names = "bus", "g1", "g2";
> >                         clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
> > -                                <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
> > -                                <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
> > -                       clock-names = "g1", "g2", "bus";
> > -                       assigned-clocks = <&clk IMX8MQ_CLK_VPU_G1>,
> > -                                         <&clk IMX8MQ_CLK_VPU_G2>,
> > -                                         <&clk IMX8MQ_CLK_VPU_BUS>,
> > -                                         <&clk
> > IMX8MQ_VPU_PLL_BYPASS>;
> > -                       assigned-clock-parents = <&clk
> > IMX8MQ_VPU_PLL_OUT>,
> > -                                                <&clk
> > IMX8MQ_VPU_PLL_OUT>,
> > -                                                <&clk
> > IMX8MQ_SYS1_PLL_800M>,
> > -                                                <&clk
> > IMX8MQ_VPU_PLL>;
> > -                       assigned-clock-rates = <600000000>,
> > <600000000>,
> > -                                              <800000000>, <0>;
> > -                       power-domains = <&pgc_vpu>;
> > +                                <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> > +                       clock-names = "g1", "g2";
> > +                       #power-domain-cells = <1>;
> >                 };
> >  
> >                 pcie0: pcie@33800000 {
> 
> With this update, when testing suspend to ram on imx8mq, I get:
> 
> buck4: failed to disable: -ETIMEDOUT
> 
> where buck4 is power-supply of pgc_vpu. And thus the transition to
> suspend (and resuming) fails.
> 
> Have you tested system suspend after the imx8m-blk-ctrl update on
> imx8mq?

I haven't tested system suspend, don't know if anyone else did. However
I guess that this is just uncovering a preexisting issue in the system
suspend sequencing, which you would also hit if the video decoders were
active at system suspend time.

My guess is that the regulator disable fails, due to the power domains
being disabled quite late in the suspend sequence, where i2c
communication with the PMIC is no longer possible due to i2c being
suspended already or something like that. Maybe you can dig in a bit on
the actual sequence on your system and we can see how we can rework
things to suspend the power domains at a time where communication with
the PMIC is still possible?

Regards,
Lucas

