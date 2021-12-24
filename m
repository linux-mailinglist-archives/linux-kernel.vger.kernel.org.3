Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6996247EDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352306AbhLXJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:42:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56246 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241614AbhLXJmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:42:31 -0500
X-UUID: 6bdba6bd9965437d9f088d8dafb4cdaa-20211224
X-UUID: 6bdba6bd9965437d9f088d8dafb4cdaa-20211224
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2018012810; Fri, 24 Dec 2021 17:42:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Dec 2021 17:42:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Dec 2021 17:42:25 +0800
Message-ID: <60ecf997de03e7426e0e54fc3eb937f95902419c.camel@mediatek.com>
Subject: Re: [PATCH v16 6/7] arm64: dts: mt8192: add svs device information
From:   Roger Lu <roger.lu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 24 Dec 2021 17:42:25 +0800
In-Reply-To: <855e004b-b128-70f7-b1d2-9fe957c94e08@somainline.org>
References: <20210428065440.3704-1-roger.lu@mediatek.com>
         <20210428065440.3704-7-roger.lu@mediatek.com>
         <855e004b-b128-70f7-b1d2-9fe957c94e08@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Sorry for the late reply.

On Wed, 2021-10-20 at 17:16 +0200, AngeloGioacchino Del Regno wrote:
> Il 28/04/21 08:54, Roger Lu ha scritto:
> > add compitable/reg/irq/clock/efuse/reset setting in svs node
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 34 ++++++++++++++++++++++++
> >   1 file changed, 34 insertions(+)
> > 
> 
> Hello Roger,
> thanks for this series! However, there is an issue with this patch:
> 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > index fe24cc66ff7a..e9816a56d87b 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > @@ -270,6 +270,14 @@
> >   			compatible = "mediatek,mt8192-infracfg", "syscon";
> >   			reg = <0 0x10001000 0 0x1000>;
> >   			#clock-cells = <1>;
> > +
> > +			infracfg_rst: reset-controller {
> > +				compatible = "mediatek,infra-reset", "ti,syscon-
> > reset";
> > +				#reset-cells = <1>;
> > +				ti,reset-bits = <
> > +					0x150 5 0x154 5 0 0     (ASSERT_SET |
> > DEASSERT_SET | STATUS_NONE) /* 0: svs */
> 
> You are using macros here, which are defined in dt-bindings/reset/ti-syscon.h
> hovever, you are not including this header in this devicetree, so it's not
> compiling.
> 
> Please fix it.

Sure, I'll fix it. Thanks for the heads-up.

> 
> > +				>;
> > +			};
> >   		};
> >   
> >   		pericfg: syscon@10003000 {
> > @@ -564,6 +572,20 @@
> >   			status = "disabled";
> >   		};
> >   
> > +		svs: svs@1100b000 {
> > +			compatible = "mediatek,mt8192-svs";
> > +			reg = <0 0x1100b000 0 0x1000>;
> > +			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			clocks = <&infracfg CLK_INFRA_THERM>;
> > +			clock-names = "main";
> > +			nvmem-cells = <&svs_calibration>,
> > +				      <&lvts_e_data1>;
> > +			nvmem-cell-names = "svs-calibration-data",
> > +					   "t-calibration-data";
> > +			resets = <&infracfg_rst 0>;
> > +			reset-names = "svs_rst";
> > +		};
> > +
> >   		spi1: spi@11010000 {
> >   			compatible = "mediatek,mt8192-spi",
> >   				     "mediatek,mt6765-spi";
> > @@ -681,6 +703,18 @@
> >   			#clock-cells = <1>;
> >   		};
> >   
> > +		efuse: efuse@11c10000 {
> > +			compatible = "mediatek,efuse";
> > +			reg = <0 0x11c10000 0 0x1000>;
> > +
> 
> arch/arm64/boot/dts/mediatek/mt8192.dtsi:510.5-24: Warning (reg_format): 
> /soc/efuse@11c10000/data1:reg: property has invalid length (8 bytes) 
> (#address-cells == 2, #size-cells == 1)
> 
> arch/arm64/boot/dts/mediatek/mt8192.dtsi:513.5-24: Warning (reg_format): 
> /soc/efuse@11c10000/calib@580:reg: property has invalid length (8 bytes) 
> (#address-cells == 2, #size-cells == 1)
> 
> 
> In short, you should add here:
> 			#address-cells = <1>;
> 			#size-cells = <1>;

Thanks for the example code and I will add them in the latest patch.

> 
> > +			lvts_e_data1: data1 {
> > +				reg = <0x1C0 0x58>;
> > +			};
> > +			svs_calibration: calib@580 {
> > +				reg = <0x580 0x68>;
> > +			};
> > +		};
> > +
> >   		i2c3: i2c3@11cb0000 {
> >   			compatible = "mediatek,mt8192-i2c";
> >   			reg = <0 0x11cb0000 0 0x1000>,
> > 
> 
> Regards,
> - Angelo

