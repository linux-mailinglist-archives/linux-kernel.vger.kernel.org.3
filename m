Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C6F482E62
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 07:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiACGIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 01:08:22 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55772 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229505AbiACGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 01:08:21 -0500
X-UUID: edc9f4d61a9f42cdac6351498b7ee7fe-20220103
X-UUID: edc9f4d61a9f42cdac6351498b7ee7fe-20220103
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2050952494; Mon, 03 Jan 2022 14:08:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Jan 2022 14:08:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Jan 2022 14:08:15 +0800
Message-ID: <63e17e727d8290a5ebd8c4c5cd8f2383fc1164cc.camel@mediatek.com>
Subject: Re: [PATCH v16 2/7] arm64: dts: mt8183: add svs device information
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
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
Date:   Mon, 3 Jan 2022 14:08:15 +0800
In-Reply-To: <20cf2c1e-d55b-5780-8c6e-4d8beaca5a65@gmail.com>
References: <20210428065440.3704-1-roger.lu@mediatek.com>
         <20210428065440.3704-3-roger.lu@mediatek.com>
         <20cf2c1e-d55b-5780-8c6e-4d8beaca5a65@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, 2021-12-30 at 13:54 +0100, Matthias Brugger wrote:
> 
> On 28/04/2021 08:54, Roger Lu wrote:
> > add compitable/reg/irq/clock/efuse setting in svs node
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 80519a145f13..441d617ece43 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -657,6 +657,18 @@
> >   			status = "disabled";
> >   		};
> >   
> > +		svs: svs@1100b000 {
> > +			compatible = "mediatek,mt8183-svs";
> > +			reg = <0 0x1100b000 0 0x1000>;
> > +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&infracfg CLK_INFRA_THERM>;
> > +			clock-names = "main";
> > +			nvmem-cells = <&svs_calibration>,
> > +				      <&thermal_calibration>;
> > +			nvmem-cell-names = "svs-calibration-data",
> > +					   "t-calibration-data";
> > +		};
> > +
> >   		pwm0: pwm@1100e000 {
> >   			compatible = "mediatek,mt8183-disp-pwm";
> >   			reg = <0 0x1100e000 0 0x1000>;
> > @@ -941,9 +953,15 @@
> >   			reg = <0 0x11f10000 0 0x1000>;
> >   			#address-cells = <1>;
> >   			#size-cells = <1>;
> 
> Please add a new line between the different calibartion data, to improve 
> readability.

No problem and thanks for the review.

> Regards,
> Matthias
> 
> > +			thermal_calibration: calib@180 {
> > +				reg = <0x180 0xc>;
> > +			};
> >   			mipi_tx_calibration: calib@190 {
> >   				reg = <0x190 0xc>;
> >   			};
> > +			svs_calibration: calib@580 {
> > +				reg = <0x580 0x64>;
> > +			};
> >   		};
> >   
> >   		u3phy: usb-phy@11f40000 {
> > 

