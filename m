Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F694957F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378067AbiAUBti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:49:38 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:39750 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378039AbiAUBt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:49:28 -0500
Received: by mail-oi1-f179.google.com with SMTP id e81so11600984oia.6;
        Thu, 20 Jan 2022 17:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5sobOilTW6v8xilz4tZ45KrTnGC9z7mamXeHGoMLDbg=;
        b=6BeEPgOtPG5Kt4YgDgXGuwmTEbW5kdEsRGyHd3nK4cX+jwqZfbKXGxa0pj/+bxoF5b
         jL2ElVAsfuV8sY8KLIPJbuQINdGug7T/ki90MbjQ/ti6A4oq2kFdElgqCjBWC+uMPIeS
         obHnexsY+dpzH5W5njcWRC0rLQblQteYE6YcJ7KMbRu7/clnkPbj6WG4orXxBjWTu6bc
         PAOsyW6usikE+eoAXTEHc+fxBAYpbx3F8GE05uZ8R9RRvFwpdkO/yhgAitkpBYxJRnQW
         khymIMqrkv1bDib5D97uqAYJyLjAHDxET2OmmAC68aXoT8dOlqVgYnSUta6OqkqWcYOb
         08lQ==
X-Gm-Message-State: AOAM533lLElvKPyDQSgSTvHJpsN4JLOldalxnH65zTPxLC/y1s4SnxK5
        QPmxevZTy6s54POpA+qWICb/sZsOvg==
X-Google-Smtp-Source: ABdhPJzzlOCamMojh5k4oRwg23pIHtOaXP/PGM7aOMQoTKqRCSgDPwOQGdv7YHEXQ3lIzH6y6GICQw==
X-Received: by 2002:a05:6808:1490:: with SMTP id e16mr1483948oiw.84.1642729767615;
        Thu, 20 Jan 2022 17:49:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e23sm439611otp.42.2022.01.20.17.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 17:49:27 -0800 (PST)
Received: (nullmailer pid 2331686 invoked by uid 1000);
        Fri, 21 Jan 2022 01:49:26 -0000
Date:   Thu, 20 Jan 2022 19:49:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: mtd: partitions: Document new
 dynamic-partitions node
Message-ID: <YeoRJlTbILNtZgoW@robh.at.kernel.org>
References: <20220120202615.28076-1-ansuelsmth@gmail.com>
 <20220120202615.28076-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120202615.28076-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:26:14PM +0100, Ansuel Smith wrote:
> Document new dynamic-partitions node used to provide an of node for
> partition registred at runtime by parsers. This is required for nvmem
> system to declare and detect nvmem-cells.

So you have some discoverable way to find all the partitions and the 
nvmem cells are at an unknown (to the DT) location, but still need to be 
described in DT?

> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../mtd/partitions/dynamic-partitions.yaml    | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> new file mode 100644
> index 000000000000..7528e49f2d7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partitions.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dynamic partitions
> +
> +description: |
> +  This binding can be used on platforms which have partitions registered at
> +  runtime by parsers or partition table present on the flash. Example are
> +  partitions declared from smem parser or cmdlinepart. This will create an

Some information in DT and some on the cmdline seems broken to me. Pick 
one or the other.

> +  of node for these dynamic partition where systems like Nvmem can get a
> +  reference to register nvmem-cells.
> +
> +  The partition table should be a node named "dynamic-partitions".
> +  Partitions are then defined as subnodes. Only the label is required
> +  as any other data will be taken from the parser.
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: dynamic-partitions

This is useless. This tells me nothing about the what's in the 
partitions.

> +
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    $ref: "partition.yaml#"
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "qcom,smem";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +    };
> +
> +    dynamic-partitions {
> +      compatible = "dynamic-partitions";
> +
> +      art: art {
> +        label = "0:art";
> +        read-only;
> +        compatible = "nvmem-cells";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        macaddr_art_0: macaddr@0 {
> +          reg = <0x0 0x6>;
> +        };
> +
> +        macaddr_art_6: macaddr@6 {
> +          reg = <0x6 0x6>;
> +        };
> +      };
> +    };
> -- 
> 2.33.1
> 
> 
