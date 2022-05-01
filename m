Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F1A516433
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbiEALfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbiEALfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:35:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA9DE97;
        Sun,  1 May 2022 04:31:32 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nl7nP-0005rq-Um; Sun, 01 May 2022 13:31:23 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] arm64: dts: rockchip: add Pine64 Quartz64-B device tree
Date:   Sun, 01 May 2022 13:31:23 +0200
Message-ID: <3428030.iIbC2pHGDl@diego>
In-Reply-To: <46548c93-4e6d-858c-8b79-03be9326c92a@gmail.com>
References: <20220429115252.2360496-1-pgwipeout@gmail.com> <20220429115252.2360496-6-pgwipeout@gmail.com> <46548c93-4e6d-858c-8b79-03be9326c92a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 1. Mai 2022, 09:06:33 CEST schrieb Johan Jonker:
> 
> On 4/29/22 13:52, Peter Geis wrote:
> > Add a device tree for the Pine64 Quartz64 Model B single board computer.
> > This board ouputs debug on uart2 and supports the following components:
> > Gigabit Ethernet
> > USB2 x2 (one port otg capable)
> > USB3
> > PCIe/SATA M2
> > HDMI
> > DSI (RPi compatible pinout)
> > CSI (RPi compatible pinout)
> > A/B/G/N WiFi
> > Bluetooth
> > SDMMC
> > eMMC
> > SPI Flash
> > PI-40 compatible pin header
> > 
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 615 ++++++++++++++++++
> >  2 files changed, 616 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index 4ae9f35434b8..252ee47b8a1d 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -59,5 +59,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> > new file mode 100644
> > index 000000000000..184ab7e1d178
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> > @@ -0,0 +1,615 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include "rk3566.dtsi"
> > +
> > +/ {
> > +	model = "Pine64 RK3566 Quartz64-B Board";
> > +	compatible = "pine64,quartz64-b", "rockchip,rk3566";
> > +
> 
> [..]
> 
> > +
> > +&mdio1 {
> 
> > +	rgmii_phy1: ethernet-phy@0 {
> > +		compatible = "ethernet-phy-ieee802.3-c22";
> > +		reg = <0x1>;
> 
> Hi,
> 
> The reg value doesn't match the node name.
> Other 2 boards use "reg = <0>" with label "rgmii_phy1".
> Could you check?

I do have an older Quartz-B in my boardfarm and in that older
devicetree the phy-reg also is "0" instead of the "1" used here.

Is that a hardware-change?

Thanks
Heiko


