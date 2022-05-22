Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D695530507
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349982AbiEVRvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiEVRvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 13:51:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E37911C07;
        Sun, 22 May 2022 10:51:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id br17so9733728lfb.2;
        Sun, 22 May 2022 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ITTsNLYfRm3KBt/z3QePjNE967lZd3UdYSvgr4oZIgk=;
        b=jT8OCq42U7t0kYjcsgJ1iVUdq1f6bqIKSC2+UJaLeUoC5EhtdwIMSGBhMmcOReznl6
         ANktiiIk8gUiQuxANjjE8FyNzuTAnmrCEkS1Ye/awjIPYUF8bEFMhKYmrLg79DryDxPq
         Nzm7wnYoqNDpGYvcko2HmCfPGzjM8vXVEnZw1aMY0oJv8YWoiPuOgg/KFgnNKVT6Rq+j
         LthxBv4QHLbCR3UOi+s/SyRdD+ipGzvGqjNqUaqDn2tpG+VmgwgAPCAD7VloG4pdQ9TX
         +cf3iQz+HWvTz5VY982HfBYaEOJe48ewr46GNc5xMH4ac7vbZRfcTL8A3Y0ubwIQLbSJ
         mX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ITTsNLYfRm3KBt/z3QePjNE967lZd3UdYSvgr4oZIgk=;
        b=KtBGeW3TIWjMb+Z/XZHMXY1S/rKkDunVQ6RgXb1ApX6pxlxBQJP2rNo8FD3U/9WTUA
         FNi/TUIsdTSJOj54FSWbaTTGLvZmIycrTu5OTB7uG7EqWKNzVCxhtorVyY3UYy981ItR
         t7Vswjxpy2Ha4a94zcF+xmC6Voy1ybd9UjGF0JTG+v8oGaN+KyFwgYXEcUXkHiXYAgr9
         finEWBDpnXX1djgyjvBz9MllnxcqP5qpEjYzK5aVxquFgN51hmsbRxlhaARLer0vMLHg
         BZ8tUuAddrHPRsnGCK8C16bSP8ffROBJgXSxwTrJqOSFLZdyYb/AUME+W1XTpYdce9hA
         KtzA==
X-Gm-Message-State: AOAM532KrrwAwy8v10lsCMQNIzYMXNJJ2zhHZMPgNZldDjY7jeRG9MeU
        siMN7g1Bvo2MZOZNZtrQoEU=
X-Google-Smtp-Source: ABdhPJxIuUWtDG0S9xd99Aftxb7pXt18anJCBliDo1+pwZF4kFDE5QWGzyzw8gVU2dRO1+9PCcM6NA==
X-Received: by 2002:a05:6512:3052:b0:477:bf98:60fd with SMTP id b18-20020a056512305200b00477bf9860fdmr14006318lfb.451.1653241872848;
        Sun, 22 May 2022 10:51:12 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id a1-20020ac25e61000000b0047255d21149sm1537986lfr.120.2022.05.22.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 10:51:12 -0700 (PDT)
Date:   Sun, 22 May 2022 20:51:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 18/23] dt-bindings: ata: ahci: Add DWC AHCI SATA
 controller DT schema
Message-ID: <20220522175110.bqj7i2zpgcunyx6f@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-19-Sergey.Semin@baikalelectronics.ru>
 <20220517200411.GA1462130-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517200411.GA1462130-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 03:04:11PM -0500, Rob Herring wrote:
> On Thu, May 12, 2022 at 02:18:05AM +0300, Serge Semin wrote:
> > Synopsys AHCI SATA controller is mainly compatible with the generic AHCI
> > SATA controller except a few peculiarities and the platform environment
> > requirements. In particular it can have one or two reference clocks to
> > feed up its AXI/AHB interface and SATA PHYs domain and at least one reset
> > control for the application clock domain. In addition to that the DMA
> > interface of each port can be tuned up to work with the predefined maximum
> > data chunk size. Note unlike generic AHCI controller DWC AHCI can't have
> > more than 8 ports. All of that is reflected in the new DWC AHCI SATA
> > device DT binding.
> > 
> > Note the DWC AHCI SATA controller DT-schema has been created in a way so
> > to be reused for the vendor-specific DT-schemas (see for example the
> > "snps,dwc-ahci" compatible string binding). One of which we are about to
> > introduce.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v2:
> > - Replace min/max constraints of the snps,{tx,rx}-ts-max property with
> >   enum [ 1, 2, 4, ..., 1024 ]. (@Rob)
> > ---
> >  .../bindings/ata/ahci-platform.yaml           |   8 --
> >  .../bindings/ata/snps,dwc-ahci.yaml           | 123 ++++++++++++++++++
> >  2 files changed, 123 insertions(+), 8 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > index 6cad7e86f3bb..4b65966ec23b 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > @@ -30,8 +30,6 @@ select:
> >            - marvell,armada-3700-ahci
> >            - marvell,armada-8k-ahci
> >            - marvell,berlin2q-ahci
> > -          - snps,dwc-ahci
> > -          - snps,spear-ahci
> >    required:
> >      - compatible
> >  
> > @@ -48,17 +46,11 @@ properties:
> >                - marvell,berlin2-ahci
> >                - marvell,berlin2q-ahci
> >            - const: generic-ahci
> > -      - items:
> > -          - enum:
> > -              - rockchip,rk3568-dwc-ahci
> > -          - const: snps,dwc-ahci
> >        - enum:
> >            - cavium,octeon-7130-ahci
> >            - hisilicon,hisi-ahci
> >            - ibm,476gtr-ahci
> >            - marvell,armada-3700-ahci
> > -          - snps,dwc-ahci
> > -          - snps,spear-ahci
> >  
> >    reg:
> >      minItems: 1
> > diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > new file mode 100644
> > index 000000000000..a13fd77a451f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > @@ -0,0 +1,123 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ata/snps,dwc-ahci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Synopsys DWC AHCI SATA controller
> > +
> > +maintainers:
> > +  - Serge Semin <fancer.lancer@gmail.com>
> > +
> > +description:
> > +  This document defines device tree bindings for the Synopsys DWC
> > +  implementation of the AHCI SATA controller.
> > +
> > +allOf:
> > +  - $ref: ahci-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: Synopsys AHCI SATA-compatible devices
> > +        contains:
> > +          const: snps,dwc-ahci
> > +      - description: SPEAr1340 AHCI SATA device
> > +        const: snps,spear-ahci
> > +      - description: Rockhip RK3568 ahci controller
> > +        const: rockchip,rk3568-dwc-ahci
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +      Basic DWC AHCI SATA clock sources like application AXI/AHB BIU clock
> > +      and embedded PHYs reference clock together with vendor-specific set
> > +      of clocks.
> > +    minItems: 1
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    contains:
> > +      anyOf:
> > +        - description: Application AXI/AHB BIU clock source
> > +          enum:
> > +            - aclk
> > +            - sata
> > +        - description: SATA Ports reference clock
> > +          enum:
> > +            - ref
> > +            - sata_ref
> > +
> > +  resets:
> > +    description:
> > +      At least basic core and application clock domains reset is normally
> > +      supported by the DWC AHCI SATA controller. Some platform specific
> > +      clocks can be also specified though.
> > +
> > +  reset-names:
> > +    contains:
> > +      description: Core and application clock domains reset control
> > +      const: arst
> > +
> > +patternProperties:
> > +  "^sata-port@[0-9a-e]$":
> > +    type: object
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 7
> > +
> > +      snps,tx-ts-max:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: Maximal size of Tx DMA transactions in FIFO words
> > +        enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024 ]
> > +
> > +      snps,rx-ts-max:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: Maximal size of Rx DMA transactions in FIFO words
> > +        enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024 ]
> > +
> > +      additionalProperties: true
> 

> You just defined a DT property called 'additionalProperties'. For this 
> reason, I prefer placing additionalProperties above 'properties'.

Right. Thanks

> 
> As mentioned the way 'sata-port' schemas are done here doesn't work.

Please, turn your attention to the emailing thread where you mentioned it:
"[PATCH v3 02/23] dt-bindings: ata: ahci-platform: Detach common AHCI bindings"
https://lore.kernel.org/linux-ide/20220511231810.4928-3-Sergey.Semin@baikalelectronics.ru/
Before I get to the series re-development I need your confirmation
whether what I understand regarding your suggestion was right.

-Sergey

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    sata@122f0000 {
> > +      compatible = "snps,dwc-ahci";
> > +      reg = <0x122F0000 0x1ff>;
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +      clocks = <&clock1>, <&clock2>;
> > +      clock-names = "aclk", "ref";
> > +
> > +      phys = <&sata_phy>;
> > +      phy-names = "sata-phy";
> > +
> > +      ports-implemented = <0x1>;
> > +
> > +      sata-port@0 {
> > +        reg = <0>;
> > +
> > +        hba-fbscp;
> > +        snps,tx-ts-max = <512>;
> > +        snps,rx-ts-max = <512>;
> > +      };
> > +    };
> > +...
> > -- 
> > 2.35.1
> > 
> > 
