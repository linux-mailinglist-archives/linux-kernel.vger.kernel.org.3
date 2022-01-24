Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02E24978BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 06:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiAXFy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 00:54:58 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54278 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230091AbiAXFy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 00:54:56 -0500
X-UUID: 400d38c62b894874a61a68fd3ac278ee-20220124
X-UUID: 400d38c62b894874a61a68fd3ac278ee-20220124
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 260584055; Mon, 24 Jan 2022 13:54:52 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 24 Jan 2022 13:54:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Jan
 2022 13:54:50 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Jan 2022 13:54:49 +0800
Message-ID: <5b8f822da1dbb7e0d204d6eeccd9cd80b3ef004c.camel@mediatek.com>
Subject: Re: [PATCH V2 2/3] dt-bindings: spi: Convert spi-mt65xx to
 json-schema
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Mon, 24 Jan 2022 13:54:49 +0800
In-Reply-To: <YetWXSzugRwKb+xA@robh.at.kernel.org>
References: <20220112103609.17421-1-leilk.liu@mediatek.com>
         <20220112103609.17421-3-leilk.liu@mediatek.com>
         <YetWXSzugRwKb+xA@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-21 at 18:57 -0600, Rob Herring wrote:
> On Wed, Jan 12, 2022 at 06:36:08PM +0800, Leilk Liu wrote:
> > Convert Mediatek ARM SOC's SPI Master controller binding
> > to json-schema format.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  .../bindings/spi/mediatek,spi-mt65xx.yaml     | 99
> > +++++++++++++++++++
> >  .../devicetree/bindings/spi/spi-mt65xx.txt    | 68 -------------
> >  2 files changed, 99 insertions(+), 68 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/spi/spi-
> > mt65xx.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > new file mode 100644
> > index 000000000000..71f0cf6e5d70
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/mediatek,spi-mt65xx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SPI Bus controller for MediaTek ARM SoCs
> > +
> > +maintainers:
> > +  - Leilk Liu <leilk.liu@mediatek.com>
> > +
> > +allOf:
> > +  - $ref: /spi/spi-controller.yaml#
> 
> /schemas/spi/spi-controller.yaml#
> 
OK, I'll fix it.

> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt7629-spi
> > +          - const: mediatek,mt7622-spi
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt8516-spi
> > +          - const: mediatek,mt2712-spi
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt6779-spi
> > +              - mediatek,mt8192-spi
> > +              - mediatek,mt8195-spi
> > +          - const: mediatek,mt6765-spi
> > +      - const: mediatek,mt2701-spi
> > +      - const: mediatek,mt2712-spi
> > +      - const: mediatek,mt6589-spi
> > +      - const: mediatek,mt6765-spi
> > +      - const: mediatek,mt6893-spi
> > +      - const: mediatek,mt7622-spi
> > +      - const: mediatek,mt8135-spi
> > +      - const: mediatek,mt8173-spi
> > +      - const: mediatek,mt8183-spi
> 
> All these can be 1 enum.
> 
OK, I'll fix it.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: clock used for the parent clock
> > +      - description: clock used for the muxes clock
> > +      - description: clock used for the clock gate
> > +
> > +  clock-names:
> > +    items:
> > +      - const: parent-clk
> > +      - const: sel-clk
> > +      - const: spi-clk
> > +
> > +  mediatek,pad-select:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    maxItems: 4
> > +    items:
> > +      enum: [0, 1, 2, 3]
> > +    description:
> > +      specify which pins group(ck/mi/mo/cs) spi controller used.
> > +      This is an array.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8173-clk.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spi@1100a000 {
> > +      compatible = "mediatek,mt8173-spi";
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      reg = <0x1100a000 0x1000>;
> > +      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
> > +      clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
> > +               <&topckgen CLK_TOP_SPI_SEL>,
> > +               <&pericfg CLK_PERI_SPI0>;
> > +      clock-names = "parent-clk", "sel-clk", "spi-clk";
> > +      cs-gpios = <&pio 105 GPIO_ACTIVE_LOW>, <&pio 72
> > GPIO_ACTIVE_LOW>;
> > +      mediatek,pad-select = <1>, <0>;
> > +    };

