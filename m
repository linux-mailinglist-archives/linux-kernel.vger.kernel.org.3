Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E910B543022
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiFHMUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiFHMUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:20:10 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4130169702;
        Wed,  8 Jun 2022 05:20:07 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nyufE-0006gv-Ao; Wed, 08 Jun 2022 14:19:56 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        linux-rockchip@lists.infradead.org,
        Sjoerd Simons <sjoerd@collabora.com>
Cc:     kernel@collabora.com, Akash Gajjar <akash@openedev.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rock-pi-s add more peripherals
Date:   Wed, 08 Jun 2022 14:19:55 +0200
Message-ID: <2759751.88bMQJbFj6@diego>
In-Reply-To: <3576f2af98a0d9e7128568777d85af3bfbab801d.camel@collabora.com>
References: <20220606082629.79682-1-sjoerd@collabora.com> <4731d47f-ef02-d512-c599-274f8208f845@wolfvision.net> <3576f2af98a0d9e7128568777d85af3bfbab801d.camel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. Juni 2022, 14:07:33 CEST schrieb Sjoerd Simons:
> Hey Michael,
> 
> On Mon, 2022-06-06 at 14:00 +0200, Michael Riesch wrote:
> > 
> > > +       aliases {
> > > +               ethernet0 = &gmac;
> > > +               mmc0 = &emmc;
> > > +               mmc1 = &sdmmc;
> > 
> > Sure? emmc is at address ff49000 which is larger than sdmmc's address
> > ff480000. I believe the aliases should be sorted w.r.t. addresses.
> 
> Do you have a reference about this sorting requirement? 

I do believe we used that mmcx -> *mmc-device sorted by address
when the aliases still were in the main soc dtsi. Simply because one
couldn't really know what was available on a specific board
(no emmc for example).

I guess now on a per-board level we could actually do that more relaxed
and let that be the decision of the board submitter ;-) .

Heiko

> Also do you mean that mmc0 should be &sdmmc *or* that the aliases
> should have mmc1 listed first.
> 
> For reference the reason is that mmc0 is emmc is because it seems more
> logical to have the builtin devices come first (e.g. as mmcblk0) 
> 
> 
> > Best regards,
> > Michael
> > 
> > > +       };
> > > +
> > >         chosen {
> > >                 stdout-path = "serial0:1500000n8";
> > >         };
> > > @@ -132,6 +138,15 @@ &emmc {
> > >         status = "okay";
> > >  };
> > >  
> > > +&gmac {
> > > +       clock_in_out = "output";
> > > +       phy-supply = <&vcc_io>;
> > > +       snps,reset-gpio = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> > > +       snps,reset-active-low;
> > > +       snps,reset-delays-us = <0 50000 50000>;
> > > +       status = "okay";
> > > +};
> > > +
> > >  &i2c1 {
> > >         status = "okay";
> > >  };
> > > @@ -195,10 +210,47 @@ &sdmmc {
> > >         status = "okay";
> > >  };
> > >  
> > > +&u2phy {
> > > +       status = "okay";
> > > +
> > > +       u2phy_host: host-port {
> > > +               phy-supply = <&vcc5v0_otg>;
> > > +               status = "okay";
> > > +       };
> > > +
> > > +       u2phy_otg: otg-port {
> > > +               phy-supply = <&vcc5v0_otg>;
> > > +               status = "okay";
> > > +       };
> > > +};
> > > +
> > >  &uart0 {
> > >         status = "okay";
> > >  };
> > >  
> > >  &uart4 {
> > >         status = "okay";
> > > +
> > > +       bluetooth {
> > > +               compatible = "realtek,rtl8723bs-bt";
> > > +               device-wake-gpios = <&gpio4 RK_PB3
> > > GPIO_ACTIVE_HIGH>;
> > > +               host-wake-gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
> > > +       };
> > > +};
> > > +
> > > +&usb_host_ehci {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&usb_host_ohci {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&usb20_otg {
> > > +       dr_mode = "peripheral";
> > > +       status = "okay";
> > > +};
> > > +
> > > +&wdt {
> > > +       status = "okay";
> > >  };
> 
> 




