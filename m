Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA18454FDEC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiFQTuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbiFQTuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:50:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C475424F14;
        Fri, 17 Jun 2022 12:49:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e4so5787973ljl.1;
        Fri, 17 Jun 2022 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8cF0jLiNO24HEVg/eFcBOsZzwy8p5T1qe7dG9jJuCeU=;
        b=oLc+30L51GLtSNIwz+1aokX4ZwOHGvE+O16kPLkMj5PUbVBSi7EvcKrJb6ItQmfBb/
         zBn6fZT5O1gCOydciraB78awv0VhxOESGD90P0pth8ZcHX9PGjhbF3NnAOtZWXlxybek
         NgnSy7+RA9anwFCM8TFP6olGzDfyDA0C3SlFDTYgaXvKyVnEXko4tRZQtvKwrCGjdcpM
         PxxUN/qp9lZrZQFTRh72WcE7mFjhizyCg7ZRn0wEgl56Kg4EXcyjosqele9RpeTjUfsv
         hn0+Ff5cxS5ZFhOL7GRgdh5puGAq8LT9EI/unobQXouMn941gxyDjeosdxDhkC04Dfp/
         oboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8cF0jLiNO24HEVg/eFcBOsZzwy8p5T1qe7dG9jJuCeU=;
        b=321cimFble3dKNa7V4yd4djrvJPCwvSXcNMXh7FI8HnSIeNLkQZzXZCB7dl5RTgJiv
         iIFvftvuVM4tpN0yNvM5HcNosTn9iRVw/ZKlZ/i6qGhuAEhpsh3XdxnoKJip46DO4TSZ
         03SxvCrYxQrEL+48avvcV7puGqcns1VuVbpnvQmBcVzhmw4MKzbwgz1cgjybDrCdKKsX
         NdPYx/5GWhCUitYox7/GmjkOzRa12P8LuiDM1yDZB+OE/MrVQPllwF9xxXkjfVbu4Itm
         l44oLvRagw7rOVmYh3HuY6tYLGy+6/Tuq+CUnDJPYqLP+lYzFhAT5XQqmq3hjnPUS6vY
         Gi/g==
X-Gm-Message-State: AJIora+CTw2VRNiFV2q1fi0Jgd6lRbakygb5o6DjxayW5T0HnXSzbemA
        Uq88eeNseO9fmSsWlfqe8FMOn6xLPXBxoVe5
X-Google-Smtp-Source: AGRyM1tp6GDDUHFzOGPeMoJTIZSKkijB5O140rIglUlzjD7ZnfA6zsAAcu3uJfe2hEZg0MSCd1pQvg==
X-Received: by 2002:a2e:881a:0:b0:255:7c2c:46d8 with SMTP id x26-20020a2e881a000000b002557c2c46d8mr5818333ljh.364.1655495397133;
        Fri, 17 Jun 2022 12:49:57 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id u17-20020ac25bd1000000b004791c4858e0sm739976lfn.114.2022.06.17.12.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 12:49:56 -0700 (PDT)
Date:   Fri, 17 Jun 2022 22:49:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 20/23] dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA
 controller DT schema
Message-ID: <20220617194954.ayoqkla3ww3hf2qy@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-21-Sergey.Semin@baikalelectronics.ru>
 <20220614222922.GB2830345-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614222922.GB2830345-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 04:29:22PM -0600, Rob Herring wrote:
> On Fri, Jun 10, 2022 at 11:17:58AM +0300, Serge Semin wrote:
> > Baikal-T1 AHCI controller is based on the DWC AHCI SATA IP-core v4.10a
> > with the next specific settings: two SATA ports, cascaded CSR access based
> > on two clock domains (APB and AXI), selectable source of the reference
> > clock (though stable work is currently available from the external source
> > only), two reset lanes for the application and SATA ports domains. Other
> > than that the device is fully compatible with the generic DWC AHCI SATA
> > bindings.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > 
> > ---
> > 
> > Changelog v2:
> > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > - Drop macro usage from the example node.
> > 
> > Changelog v4:
> > - Use the DWC AHCI port properties definition from the DWC AHCI SATA
> >   common schema. (@Rob)
> > - Drop Baikal-T1 syscon reference and implement the clock signal
> >   source in the framework of the clock controller. (@Rob)
> > ---
> >  .../bindings/ata/baikal,bt1-ahci.yaml         | 116 ++++++++++++++++++
> >  1 file changed, 116 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > new file mode 100644
> > index 000000000000..d5fbd7d561d8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > @@ -0,0 +1,116 @@
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
> > +      - description: SATA Ports reference clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pclk
> > +      - const: aclk
> > +      - const: ref
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
> > +  ports-implemented:
> > +    maximum: 0x3
> > +
> > +patternProperties:
> > +  "^sata-port@[0-9a-e]$":
> > +    $ref: /schemas/ata/snps,dwc-ahci.yaml#/$defs/dwc-ahci-port
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
> > +        enum: [ 1, 2, 4, 8, 16 ]
> > +
> > +      snps,rx-ts-max:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Due to having AXI3 bus interface utilized the maximum Rx DMA
> > +          transaction size can't exceed 16 beats (AxLEN[3:0]).
> > +        enum: [ 1, 2, 4, 8, 16 ]
> > +
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    sata@1f050000 {
> > +      compatible = "baikal,bt1-ahci", "snps,dwc-ahci";
> 

> Just drop 'snps,dwc-ahci'. The generic IP block fallbacks have proven to 
> be useless.

Please see my answer to your comment to the patch
[PATCH v4 17/23] dt-bindings: ata: ahci: Add DWC AHCI SATA controller DT schema
in this series here:
https://lore.kernel.org/linux-ide/20220617193744.av27axznbogademt@mobilestation/
Let's settle the fallback usage in general otherwise I'll keep
submitting patches with such functionality and will always be getting
your notes in that regard.)

-Sergey


> 
> > +      reg = <0x1f050000 0x2000>;
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      interrupts = <0 64 4>;
> > +
> > +      clocks = <&ccu_sys 1>, <&ccu_axi 2>, <&sata_ref_clk>;
> > +      clock-names = "pclk", "aclk", "ref";
> > +
> > +      resets = <&ccu_axi 2>, <&ccu_sys 0>;
> > +      reset-names = "arst", "ref";
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
