Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80891478599
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhLQHfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:35:25 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39778 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233685AbhLQHfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:35:24 -0500
X-UUID: 3189f281b0fd48c79882c807775da72b-20211217
X-UUID: 3189f281b0fd48c79882c807775da72b-20211217
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1784386112; Fri, 17 Dec 2021 15:35:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Dec 2021 15:35:20 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Dec 2021 15:35:19 +0800
Message-ID: <dc7a1e56248fa58f184568e1ce4504a9233209e2.camel@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: mediatek: mt8195: add clock property
 to sound node
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jiaxin.yu@mediatek.com>, <shumingf@realtek.com>
Date:   Fri, 17 Dec 2021 15:35:20 +0800
In-Reply-To: <YbuOQOH3esG1pFQU@robh.at.kernel.org>
References: <20211215065835.3074-1-trevor.wu@mediatek.com>
         <20211215065835.3074-2-trevor.wu@mediatek.com>
         <YbuOQOH3esG1pFQU@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-16 at 13:06 -0600, Rob Herring wrote:
> On Wed, Dec 15, 2021 at 02:58:35PM +0800, Trevor Wu wrote:
> > clocks and clock-names are added to provide MCLK phandle for sound
> > card.
> > 
> > Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> > ---
> >  .../bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml  | 12
> > ++++++++++++
> >  .../bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml  | 12
> > ++++++++++++
> >  2 files changed, 24 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-
> > rt1011-rt5682.yaml
> > b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-
> > rt5682.yaml
> > index cf6ad7933e23..b57c856d0cf3 100644
> > --- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-
> > rt5682.yaml
> > +++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-
> > rt5682.yaml
> > @@ -32,11 +32,21 @@ properties:
> >      $ref: "/schemas/types.yaml#/definitions/phandle"
> >      description: The phandle of MT8195 HDMI codec node.
> >  
> > +  clocks:
> > +    items:
> > +      - description: phandle and clock specifier for codec MCLK.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: i2so1_mclk
> > +
> >  additionalProperties: false
> >  
> >  required:
> >    - compatible
> >    - mediatek,platform
> > +  - clocks
> > +  - clock-names
> >  
> >  examples:
> >    - |
> > @@ -44,6 +54,8 @@ examples:
> >      sound: mt8195-sound {
> >          compatible = "mediatek,mt8195_mt6359_rt1011_rt5682";
> >          mediatek,platform = <&afe>;
> > +        clocks = <&topckgen 235>; //CLK_TOP_APLL12_DIV2
> > +        clock-names = "i2so1_mclk";
> >          pinctrl-names = "default";
> >          pinctrl-0 = <&aud_pins_default>;
> >      };
> > diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-
> > rt1019-rt5682.yaml
> > b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-
> > rt5682.yaml
> > index 8f177e02ad35..e4720f76f66b 100644
> > --- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-
> > rt5682.yaml
> > +++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-
> > rt5682.yaml
> > @@ -42,11 +42,21 @@ properties:
> >        A list of the desired dai-links in the sound card. Each
> > entry is a
> >        name defined in the machine driver.
> >  
> > +  clocks:
> > +    items:
> > +      - description: phandle and clock specifier for codec MCLK.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: i2so1_mclk
> > +
> >  additionalProperties: false
> >  
> >  required:
> >    - compatible
> >    - mediatek,platform
> > +  - clocks
> > +  - clock-names
> >  
> >  examples:
> >    - |
> > @@ -54,6 +64,8 @@ examples:
> >      sound: mt8195-sound {
> >          compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
> >          mediatek,platform = <&afe>;
> > +        clocks = <&topckgen 235>; //CLK_TOP_APLL12_DIV2
> > +        clock-names = "i2so1_mclk";
> 
> Being a virtual node, how does it have clocks? This belongs in the
> h/w device that consumes the clock.

Hi Rob,

I also found the same usages in some bindings from nvidia, like[1].

Based on my understanding, it seems not to be recommended now and 
clocks should only be used for a real hw node, is it correct?

If yes, I will try other way to get the clock I need in alsa machine
driver.

[1] 
https://elixir.bootlin.com/linux/v5.16-rc5/source/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt

Thanks,
Trevor

> >          pinctrl-0 = <&aud_pins_default>;
> >      };
> > -- 
> > 2.18.0
> > 
> > 

