Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370605305F6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351297AbiEVUtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242511AbiEVUth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:49:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F352A26B;
        Sun, 22 May 2022 13:49:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c19so9377631lfv.5;
        Sun, 22 May 2022 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/O11HhPBoNweXXd7JMltDDwduZUfH8myCWo19DY/IP4=;
        b=LlDmvR59s5rhzELEtv9RjIx24yW/3o8NMRn/wMwDpt1GOVL6xwSVSLsRuX8Huuof7G
         e1R1Ie9xpSekwLismWS3RXbOnm9m2BSgsh85tC0tvfoelO7VYSg1m0+XgQLn8+a/a+VK
         VBK5Go+CgcIo0fB+HQtllsjaX52t8gNp68WRs/eIIS3hvn/Qjs/XUyK6UtA/BxHugRBd
         MkbbSsHVjBm/Rig7JOHwC6pdm+Ga2jtO7FoskEXuX1ojDIJ/u/7UgToa4cn2sbUryE//
         +jBqMmRSjF+2IfyVjiXAbsmM2n9gt5bizjemgkyRZ+KgCZhJb0BYZh3MNz3Bg7kiMSrq
         ELwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/O11HhPBoNweXXd7JMltDDwduZUfH8myCWo19DY/IP4=;
        b=chO0+Coblv//n2OgOpFCmSsqI/vwkrEx7ZCh1Sq+5MJC5KDMXJ3g5aCQmGNPc/0AKl
         y4I/RIO+BnmW6i4zJgdvXdjyTZ1k26KwQTDM0pLB7rLBNe7RRvfAlrhlcYH35j8WB8+z
         9quw3+WGMSiVJguCvUZXgBt2SFEjZMrPNJzE3UYrLqzvHd7GC6Rer2lo3mqzjXGehFT2
         SXQWj46QJa3iZFmavnVvjo1DNH9m1yVa4Ao9F/GNpjii3z8EtCncUK3sQVfn2P5I4VFe
         Kvrtw850rf8KPm73ChEOVKoUe4scO87JYfZBJFW5VF4uCD4xgbdHfuTerwD6TQj+dQrA
         8tJA==
X-Gm-Message-State: AOAM533MSxkWRlEcvfTTWTiL7seeuWNxLbmmG6ojDTucohITjEA10xMj
        VX4g1rCkSRUmnp3ElReuzL8=
X-Google-Smtp-Source: ABdhPJwZTo+UXrEnFscHzAb6JIlWOmhqGeMcmdfjg4rXLWWgfEAEWHYFslLmM4KnWIpqESyO8g/JTw==
X-Received: by 2002:a19:5e16:0:b0:478:6d8e:ced2 with SMTP id s22-20020a195e16000000b004786d8eced2mr2261372lfb.152.1653252574153;
        Sun, 22 May 2022 13:49:34 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id q23-20020a19a417000000b00477c1172063sm1594576lfc.165.2022.05.22.13.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 13:49:33 -0700 (PDT)
Date:   Sun, 22 May 2022 23:49:31 +0300
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
Subject: Re: [PATCH v3 20/23] dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA
 controller DT schema
Message-ID: <20220522204931.rcgqyyctxivyfmv7@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-21-Sergey.Semin@baikalelectronics.ru>
 <20220517201332.GB1462130-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517201332.GB1462130-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 03:13:32PM -0500, Rob Herring wrote:
> On Thu, May 12, 2022 at 02:18:07AM +0300, Serge Semin wrote:
> > Baikal-T1 AHCI controller is based on the DWC AHCI SATA IP-core v4.10a
> > with the next specific settings: two SATA ports, cascaded CSR access based
> > on two clock domains (APB and AXI), selectable source of the reference
> > clock (though stable work is currently available from the external source
> > only), two reset lanes for the application and SATA ports domains. Other
> > than that the device is fully compatible with the generic DWC AHCI SATA
> > bindings.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v2:
> > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > - Drop macro usage from the example node.
> > ---
> >  .../bindings/ata/baikal,bt1-ahci.yaml         | 127 ++++++++++++++++++
> >  1 file changed, 127 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > new file mode 100644
> > index 000000000000..7c2eae75434f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > @@ -0,0 +1,127 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ata/baikal,bt1-ahci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Baikal-T1 SoC AHCI SATA controller
> > +
> > +maintainers:
> > +  - Serge Semin <fancer.lancer@gmail.com>
> > +
> > +description: |
> > +  AHCI SATA controller embedded into the Baikal-T1 SoC is based on the
> > +  DWC AHCI SATA v4.10a IP-core.
> > +
> > +allOf:
> > +  - $ref: snps,dwc-ahci.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    contains:
> > +      const: baikal,bt1-ahci
> > +
> > +  clocks:
> > +    items:
> > +      - description: Peripheral APB bus clock source
> > +      - description: Application AXI BIU clock
> > +      - description: Internal SATA Ports reference clock
> > +      - description: External SATA Ports reference clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pclk
> > +      - const: aclk
> > +      - const: ref_int
> > +      - const: ref_ext
> > +
> > +  resets:
> > +    items:
> > +      - description: Application AXI BIU domain reset
> > +      - description: SATA Ports clock domain reset
> > +
> > +  reset-names:
> > +    items:
> > +      - const: arst
> > +      - const: ref
> > +
> > +  baikal,bt1-syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle reference to the CCU system controller. It is required to
> > +      switch between internal and external SATA reference clock sources.
> 

> Seems like the CCU system ctrlr should be a clock provider that provides 
> 'ref' clock and then assigned-clocks can be used to pick internal vs. 
> external ref.

By assigned-clocks do you mean using the "assigned-clock-parents"
property? Does it mean creating additional clocks exported from the
CCU controller, which could have got one of the two parental clocks?

> 
> > +
> > +  ports-implemented:
> > +    maximum: 0x3
> > +
> > +patternProperties:
> > +  "^sata-port@[0-9a-e]$":
> > +    type: object
> 
>        unevaluatedProperties: false
> 

> and then a $ref to a sata-port schema.

Can I set additional sata-port properties constraints afterwards? Like
I've done for the reg, snps,tx-ts-max and snps,rx-ts-max properties
here?

> 
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 1
> > +
> > +      snps,tx-ts-max:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Due to having AXI3 bus interface utilized the maximum Tx DMA
> > +          transaction size can't exceed 16 beats (AxLEN[3:0]).
> > +        minimum: 1
> > +        maximum: 16
> > +
> > +      snps,rx-ts-max:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Due to having AXI3 bus interface utilized the maximum Rx DMA
> > +          transaction size can't exceed 16 beats (AxLEN[3:0]).
> 

> That's not a per port limitation (even though it's a per port register)? 
> I think this should be implied by the compatible string.

The snps,{rx,tx}-ts-max property is a per-port property. I'd better
explicitly set the property limitation here rather than having the
value implicitly clamped by hardware especially seeing the limitation
is set by the formulae
(CC_MSTR_BURST_LEN * M_HDATA_WIDTH/32)) / (M_HDATA_WIDTH/32),
which consists of the IP-core synthesized parameters.

> 
> Really, firmware should configure this IMO.

We don't have comprehensive firmware setting these and generic HBA parameters.
In our case dtb is the main platform firmware.

-Sergey

> 
> > +        minimum: 1
> > +        maximum: 16
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +  - baikal,bt1-syscon
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    sata@1f050000 {
> > +      compatible = "baikal,bt1-ahci", "snps,dwc-ahci";
> > +      reg = <0x1f050000 0x2000>;
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      interrupts = <0 64 4>;
> > +
> > +      clocks = <&ccu_sys 1>, <&ccu_axi 2>, <&ccu_sys 0>, <&clk_sata>;
> > +      clock-names = "pclk", "aclk", "ref_int", "ref_ext";
> > +
> > +      resets = <&ccu_axi 2>, <&ccu_sys 0>;
> > +      reset-names = "arst", "ref";
> > +
> > +      baikal,bt1-syscon = <&syscon>;
> > +
> > +      ports-implemented = <0x3>;
> > +
> > +      sata-port@0 {
> > +        reg = <0>;
> > +
> > +        snps,tx-ts-max = <4>;
> > +        snps,rx-ts-max = <4>;
> > +      };
> > +
> > +      sata-port@1 {
> > +        reg = <1>;
> > +
> > +        snps,tx-ts-max = <4>;
> > +        snps,rx-ts-max = <4>;
> > +      };
> > +    };
> > +...
> > -- 
> > 2.35.1
> > 
> > 
