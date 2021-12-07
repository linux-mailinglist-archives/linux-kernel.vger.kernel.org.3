Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB146BFA2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbhLGPmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbhLGPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:42:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E98C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 07:38:40 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mucXu-0004Ow-J8; Tue, 07 Dec 2021 16:38:22 +0100
Message-ID: <dbe7f7e488d92364ac2573175b0a262477a4d69a.camel@pengutronix.de>
Subject: Re: [RFC V2 3/6] dt-bindings: media: nxp,imx8mq-vpu: Update the
 bindings for G2 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Rob Herring <robh@kernel.org>, Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, cphealy@gmail.com,
        benjamin.gaignard@collabora.com, hverkuil@xs4all.nl,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Date:   Tue, 07 Dec 2021 16:38:19 +0100
In-Reply-To: <Ya96O6VXuIDdcM8p@robh.at.kernel.org>
References: <20211207015446.1250854-1-aford173@gmail.com>
         <20211207015446.1250854-4-aford173@gmail.com>
         <Ya96O6VXuIDdcM8p@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Am Dienstag, dem 07.12.2021 um 09:14 -0600 schrieb Rob Herring:
> On Mon, Dec 06, 2021 at 07:54:42PM -0600, Adam Ford wrote:
> > From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > 
> > Introducing the G2 hevc video decoder requires modifications of the bindings to allow
> > one node per VPU.
> 
> Why? It looks like the G2 part was already described. If you are 
> changing this because you want 2 drivers for G1 and G2, then NAK. DT 
> nodes and drivers don't have to be 1:1. This change is breaking 
> compatibility.

We can keep the compatibility by just keeping the code in the VPU
driver to handle the G1 block as-is. The VPU block on the imx8mq is
really three peripherals: the control block working together with the
power domain controller to provide clocks and resets and the G1 and G2
VPU cores.

> 
> > 
> > VPUs share one hardware control block which is provided as a phandle on
> > a syscon.
> 
> That's not really ideal. Is this really a separate block?
> 
This part of the commit message is not accurate anymore. The control
block is in fact so separate from the VPU that we even added a new
driver to handle those control blocks: the imx8m blk-ctrl driver. The
VPU driver doesn't need handle this control block anymore, it's now
handled via the power-domain abstraction.

Regards,
Lucas

> > Each node has now one reg and one interrupt.
> > Add a compatible for G2 hardware block: nxp,imx8mq-vpu-g2.
> > 
> > To be compatible with older DT the driver is still capable to use the 'ctrl'
> > reg-name even if it is deprecated now.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > 
> > diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> > index 762be3f96ce9..eaeba4ce262a 100644
> > --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> > +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> > @@ -15,37 +15,36 @@ description:
> >  
> >  properties:
> >    compatible:
> > -    const: nxp,imx8mq-vpu
> > +    oneOf:
> > +      - const: nxp,imx8mq-vpu-g1
> > +      - const: nxp,imx8mq-vpu-g2
> >  
> >    reg:
> > -    maxItems: 3
> > -
> > -  reg-names:
> > -    items:
> > -      - const: g1
> > -      - const: g2
> > -      - const: ctrl
> > +    maxItems: 1
> >  
> >    interrupts:
> > -    maxItems: 2
> > +    maxItems: 1
> >  
> >    interrupt-names:
> > -    items:
> > +    oneOf:
> >        - const: g1
> >        - const: g2
> >  
> >    clocks:
> > -    maxItems: 3
> > +    maxItems: 1
> >  
> >    clock-names:
> > -    items:
> > +    oneOf:
> >        - const: g1
> >        - const: g2
> > -      - const: bus
> >  
> >    power-domains:
> >      maxItems: 1
> >  
> > +  nxp,imx8m-vpu-ctrl:
> > +    description: Specifies a phandle to syscon VPU hardware control block
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> 
> This is optional?
> 
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -60,20 +59,27 @@ additionalProperties: false
> >  examples:
> >    - |
> >          #include <dt-bindings/clock/imx8mq-clock.h>
> > +        #include <dt-bindings/power/imx8mq-power.h>
> >          #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  
> > -        vpu: video-codec@38300000 {
> > +        vpu_g1: video-codec@38300000 {
> >                  compatible = "nxp,imx8mq-vpu";
> > -                reg = <0x38300000 0x10000>,
> > -                      <0x38310000 0x10000>,
> > -                      <0x38320000 0x10000>;
> > -                reg-names = "g1", "g2", "ctrl";
> > -                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > -                             <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > -                interrupt-names = "g1", "g2";
> > -                clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
> > -                         <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
> > -                         <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
> > -                clock-names = "g1", "g2", "bus";
> > -                power-domains = <&pgc_vpu>;
> > +                reg = <0x38300000 0x10000>;
> > +                reg-names "g1";
> > +                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +                interrupt-names = "g1";
> > +                clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> > +                clock-names = "g1";
> > +                power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G1>;
> > +        };
> > +
> > +        vpu_g2: video-codec@38310000 {
> > +                compatible = "nxp,imx8mq-vpu-g2";
> > +                reg = <0x38300000 0x10000>;
> > +                reg-names "g2";
> > +                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > +                interrupt-names = "g2";
> > +                clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> > +                clock-names = "g2";
> > +                power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
> >          };
> > -- 
> > 2.32.0
> > 
> > 


