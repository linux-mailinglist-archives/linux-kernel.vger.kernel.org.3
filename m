Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992464FC55A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349754AbiDKUCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243241AbiDKUCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:02:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE535FB2;
        Mon, 11 Apr 2022 13:00:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h14so23441675lfl.2;
        Mon, 11 Apr 2022 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZezkdIQoJxr3FUS6ZgUv1QgR6XVz7LoPRwJNYEn+SLo=;
        b=pHx1HShz+YL7+SrcmJDf7CmYoeDStArvZ1drztzWQGn0c1RI1cwYuLv3RWkJ3JARi0
         wsoQQ3NOcyj4IJavheL7QKNX1huqRFIuDW/HaG8h/577m3fVcItja/urS+Jj7o26eQlb
         YeDvp9eZ7lLdBT4zuLrS6CbjDU4R/qbhZ7FipUWFVlJa9AyOK9GuFdr8iFfxbGdV4jPM
         443q0RMxMNuIQ/c2a3pA8JgChF6J3uY4kzFFrQhykf2ZTGgCwgBQuVUjiLBHognFj0kC
         gbnv5jMdNkNOxx0XQODG2qFlQ9haoRKK4cgR33f415UV7xUXO7fE/bdx6X8snlG5wUx0
         fmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZezkdIQoJxr3FUS6ZgUv1QgR6XVz7LoPRwJNYEn+SLo=;
        b=iT5t7Wvgvw+SpWATUO4qRBxrkk+RbBTiPS90xAaCuDxRF5VS/YaovIaBEQ8P/KB+o8
         AuFiYdQILyZKBFpxTQ+QU25qp9ImFXpAa3dKXeB1Snain/MLQyGWMANT8fNQPIrzH9kf
         384HR3LFfLFV6YoHwfaQW8PWiAMpAEUAKQ/KFJTkRlT52LLYW990Btc2fFn6/XAADF+k
         5Y2tMhv0MU0oM/4LjgaWX0Qa//eAiBtueuQAi0t/vUA3HQXdxHVhmVfRxrNCUA1MEddc
         cWl2MzKtyIYtL96jFZ6a1qj/kWpcZoRd/lwq2Ao2aBeQw8AOrOiTEP6H14LGctowF2aq
         O7AA==
X-Gm-Message-State: AOAM532mIx4A+vw3z4ciUfFymoBK9pF5bP1ViZp02ha7xFP6H2wqhOS5
        z8saQxAv3vXet8hqQs5q9XI=
X-Google-Smtp-Source: ABdhPJxc9aEhflRAiUvc4xI3UADaDqAjKt7Bdkh6zvVnf3elCeWkg6x7xB2Uul+fg3SaEQlEzsB9Gg==
X-Received: by 2002:a05:6512:68e:b0:44a:6594:3b9e with SMTP id t14-20020a056512068e00b0044a65943b9emr22350771lfe.623.1649707230072;
        Mon, 11 Apr 2022 13:00:30 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id k7-20020a056512330700b0046b8e44be22sm942955lfe.83.2022.04.11.13.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:00:29 -0700 (PDT)
Date:   Mon, 11 Apr 2022 23:00:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 16/21] dt-bindings: ata: ahci: Add DWC AHCI SATA
 controller DT schema
Message-ID: <20220411200027.l5ph4lvw6dujbexg@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-17-Sergey.Semin@baikalelectronics.ru>
 <YkZCA08HZ6Nx1IqQ@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkZCA08HZ6Nx1IqQ@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 07:06:27PM -0500, Rob Herring wrote:
> On Thu, Mar 24, 2022 at 03:16:23AM +0300, Serge Semin wrote:
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
> > to be reused for the vendor-specific DT-schemas. One of which we are about
> > to introduce.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  .../bindings/ata/snps,dwc-ahci.yaml           | 121 ++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > new file mode 100644
> > index 000000000000..b443154b63aa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > @@ -0,0 +1,121 @@
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
> > +description: |
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
> > +        minimum: 1
> > +        maximum: 1024
> > +
> > +      snps,rx-ts-max:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: Maximal size of Rx DMA transactions in FIFO words
> > +        minimum: 1
> > +        maximum: 1024
> 

> Are you reading these somewhere? 

Yes I do read them in the DWC AHCI driver and use ilog2() to get
the corresponding power of two value.

> 
> Only powers of 2 are valid. (Guess what Calxeda's controller uses.)

Right and is limited to be within [1; 1024]. Do you suggest to add a
respective comment in the description or just manually enumerate the
POW2 values? I don't believe there is a ready-to-use power-of-2 type in
the /schemas/types.yaml file. BTW what about adding one seeing there are
many cases where it could be useful?

-Sergey

> 
> Rob
