Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546D24978BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 06:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiAXFyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 00:54:06 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52882 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230091AbiAXFyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 00:54:04 -0500
X-UUID: b5ff8953b84541e8925667c9a742ef53-20220124
X-UUID: b5ff8953b84541e8925667c9a742ef53-20220124
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1566526862; Mon, 24 Jan 2022 13:54:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Jan 2022 13:54:01 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Jan 2022 13:54:00 +0800
Message-ID: <284792c07f1adcd2ceeab287c6f38c35ee689c0a.camel@mediatek.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: spi: Convert spi-slave-mt27xx to
 json-schema
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Mon, 24 Jan 2022 13:54:00 +0800
In-Reply-To: <YetVd7IR7FDt+nz3@robh.at.kernel.org>
References: <20220112103609.17421-1-leilk.liu@mediatek.com>
         <20220112103609.17421-2-leilk.liu@mediatek.com>
         <YetVd7IR7FDt+nz3@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-21 at 18:53 -0600, Rob Herring wrote:
> On Wed, Jan 12, 2022 at 06:36:07PM +0800, Leilk Liu wrote:
> > Convert Mediatek ARM SOC's SPI Slave controller binding
> > to json-schema format.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  .../spi/mediatek,spi-slave-mt27xx.yaml        | 73
> > +++++++++++++++++++
> >  .../bindings/spi/spi-slave-mt27xx.txt         | 33 ---------
> >  2 files changed, 73 insertions(+), 33 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/spi/mediatek,spi-slave-
> > mt27xx.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/spi/spi-
> > slave-mt27xx.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > slave-mt27xx.yaml
> > b/Documentation/devicetree/bindings/spi/mediatek,spi-slave-
> > mt27xx.yaml
> > new file mode 100644
> > index 000000000000..3364fff08cca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-slave-
> > mt27xx.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > http://devicetree.org/schemas/spi/mediatek,spi-slave-mt27xx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SPI Slave controller for MediaTek ARM SoCs
> > +
> > +maintainers:
> > +  - Leilk Liu <leilk.liu@mediatek.com>
> > +
> > +allOf:
> > +  - $ref: /spi/spi-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt2712-spi-slave
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt8195-spi-slave
> 
> Just:
> 
>        enum:
>          - mediatek,mt2712-spi-slave
>          - mediatek,mt8195-spi-slave
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
> > +      - description: clock used for the clock gate
> 
> Just 'maxItems: 1'
> 
OK, I'll fix it.

> > +
> > +  clock-names:
> > +    items:
> > +      - const: spi
> > +
> > +  assigned-clocks:
> > +    maxItems: 1
> > +    description: |
> > +      The mux clock for the given platform.
> > +
> > +  assigned-clock-parents:
> > +    maxItems: 1
> > +    description: |
> > +      The parent of mux clock for the given platform.
> 
> You can drop assigned-clocks. They are always allowed on nodes with 
> 'clocks'.
> 
OK, I'll fix it.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt2712-clk.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spi@10013000 {
> > +      compatible = "mediatek,mt2712-spi-slave";
> > +      reg = <0x10013000 0x100>;
> > +      interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
> > +      clocks = <&infracfg CLK_INFRA_AO_SPI1>;
> > +      clock-names = "spi";
> > +      assigned-clocks = <&topckgen CLK_TOP_SPISLV_SEL>;
> > +      assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
> > +    };

