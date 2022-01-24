Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC00C49A80B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316080AbiAYCzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3410180AbiAYA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:28:44 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04E9C046E0F;
        Mon, 24 Jan 2022 14:12:12 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id p12so59164187edq.9;
        Mon, 24 Jan 2022 14:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xjwGE6BH9L6fTcSZWs11vc8ZPM/FGmaGzfe0rXFXqwA=;
        b=QHVQLYC2HKD8OOaj2moD02AYdjMBw8p5K4xFxHABxMRvnwHsT7GrFCjV1dS8EXr6jr
         WHDEDm/40IBf1ngAe9nODvQSh3KpnMJecKBc/ZLEMwwQRAhDWwmCVaIlh8auCpT8PyuA
         j0JU8Ix0bnxgpPWTTP9P2QEEJVftR54Mr0rNcS0pD7R/gH+DyoeeOqKhUMryA5ca23ps
         09tues9fjNMs2dZ1xFmpLu20wSuVV31jxZEv60FJ+4orBPyIfBOYVOaH9JdtoQVj1Cll
         e8i6kzb0O9NJVcRP21N3fhKl/674bw1uyvBuh5o6yoMwb6qO1zMSukWCZo6JUbl58bdL
         Bvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xjwGE6BH9L6fTcSZWs11vc8ZPM/FGmaGzfe0rXFXqwA=;
        b=bYRtbehQi88PSaxPIF9u9Dga1PMfWHfqmbGjYYDy+D1R+61yrf8fQh+vB8NujuMEYG
         XZmvvdBKWv7jFn/gvqo+KT23f0scvqPa6ptsOgOLzD+lA3Xa5R7wXXqvSJIOFo3xdkhg
         LgNAwzS9iPmM3Ou5SRq+jXpngNoN2PKO9lcXtNJuPOT92z6GrHJFwVWqbxOIshF7yREe
         dux5okBdqGEKr/d6ysVrnGT8SHryUkQy5o0LmI77dVmMPNRQnOejDNzpi5EtJkfYRjTl
         LisEQguzcHTaR1lTKd8TbUHnUEo9JieEmPmEdmqo3P/zpI3Bd91hYcUCROYvoLIf86Kb
         9fuA==
X-Gm-Message-State: AOAM533qOm90N5/eNOlOB0ynrBXl7od6cviuoUJH1FRyEJZMX8xgHoPI
        94zpEX2g2GNN/epmyMa3tulZrIFVbZc=
X-Google-Smtp-Source: ABdhPJzL/E0nl+YviU6PAtvR7wAOAR1NhNSt+vJdHQXem0U+zwh9MVk6hIDRHv32faoqc+82XORa4w==
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr7180908edz.186.1643062330973;
        Mon, 24 Jan 2022 14:12:10 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id by16sm5375876ejb.73.2022.01.24.14.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:12:10 -0800 (PST)
Message-ID: <61ef243a.1c69fb81.26cae.716b@mx.google.com>
X-Google-Original-Message-ID: <Ye8kN2Eh4DgUTg32@Ansuel-xps.>
Date:   Mon, 24 Jan 2022 23:12:07 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: mtd: partitions: Document new
 dynamic-partitions node
References: <20220120202615.28076-1-ansuelsmth@gmail.com>
 <20220120202615.28076-2-ansuelsmth@gmail.com>
 <a823e730-853d-901b-1b9f-937e1ec76444@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a823e730-853d-901b-1b9f-937e1ec76444@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:02:24PM +0100, Rafał Miłecki wrote:
> On 20.01.2022 21:26, Ansuel Smith wrote:
> > Document new dynamic-partitions node used to provide an of node for
> > partition registred at runtime by parsers. This is required for nvmem
> > system to declare and detect nvmem-cells.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >   .../mtd/partitions/dynamic-partitions.yaml    | 59 +++++++++++++++++++
> >   1 file changed, 59 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> > new file mode 100644
> > index 000000000000..7528e49f2d7e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partitions.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Dynamic partitions
> > +
> > +description: |
> > +  This binding can be used on platforms which have partitions registered at
> > +  runtime by parsers or partition table present on the flash. Example are
> > +  partitions declared from smem parser or cmdlinepart. This will create an
> > +  of node for these dynamic partition where systems like Nvmem can get a
> > +  reference to register nvmem-cells.
> > +
> > +  The partition table should be a node named "dynamic-partitions".
> > +  Partitions are then defined as subnodes. Only the label is required
> > +  as any other data will be taken from the parser.
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: dynamic-partitions
> > +
> > +patternProperties:
> > +  "@[0-9a-f]+$":
> > +    $ref: "partition.yaml#"
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    partitions {
> > +        compatible = "qcom,smem";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +    };
> > +
> > +    dynamic-partitions {
> > +      compatible = "dynamic-partitions";
> > +
> > +      art: art {
> > +        label = "0:art";
> > +        read-only;
> > +        compatible = "nvmem-cells";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        macaddr_art_0: macaddr@0 {
> > +          reg = <0x0 0x6>;
> > +        };
> > +
> > +        macaddr_art_6: macaddr@6 {
> > +          reg = <0x6 0x6>;
> > +        };
> > +      };
> > +    };
> 
> First of all: I fully support such a feature. I need it for Broadom
> platforms that use "brcm,bcm947xx-cfe-partitions" dynamic partitions.
> In my case bootloader partition is created dynamically (it doesn't have
> const offset and size). It contains NVMEM data however that needs to be
> described in DT.
> 
> This binding however looks loose and confusing to me.
>

I agree.

> First of all did you really mean to use "qcom,smem"? My first guess is
> you meant "qcom,smem-part".
> 

Yes sorry, I was referring to the smem parser qcom,smem-part 

> Secondly can't we have partitions defined just as subnodes of the
> partitions { ... }; node?
> 

I would love to use it. My only concern is that due to the fact
that we have to support legacy partition declaring, wonder if this could
create some problem. I'm referring to declaring fixed partition without
using any compatible/standard binding name.

I remember we improved that with the introduction of the nvmem binding
by making the fixed-partition compatible mandatory. But I would like to
have extra check. Wonder if to be on the safe part we can consider
appending to the "dynamic parser" a compatible like "dynamic-partitions"
and use your way to declare them (aka keeping the dynamic-partition and
removing the extra parallel partitions list)

Feel free to tell me it's just a stupid and unnecessary idea. I just
have fear to introduce regression in the partition parsing logic.

> 
> I think sth like below would make more sense:
> 
> partitions {
>     compatible = "qcom,smem-part";
> 
>     art {
>         label = "0:art";
>         read-only;
>         compatible = "nvmem-cells";
>         #address-cells = <1>;
>         #size-cells = <1>;
> 
>         macaddr_art_0: macaddr@0 {
>             reg = <0x0 0x6>;
>         };
> 
>         macaddr_art_6: macaddr@6 {
>             reg = <0x6 0x6>;
>         };
>     };
> };
> 
> 
> Then I could also reuse that for something like:
> 
> partitions {
>     compatible = "brcm,bcm947xx-cfe-partitions";
> 
>     partition-0 {
>         compatible = "nvmem-cells";
>         label = "boot";
> 
>         #address-cells = <1>;
>         #size-cells = <1>;
> 
>         mac: macaddr@0 {
>             reg = <0x100 0x6>;
>         };
>     }
> };

-- 
	Ansuel
