Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD0475DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbhLOQ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:56:27 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:47003 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245044AbhLOQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:56:24 -0500
Received: by mail-oo1-f44.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso6086245ood.13;
        Wed, 15 Dec 2021 08:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jRx/8XO5m2lO+UXrFb8kcYT22KejDsnyUFbPI7+hOJM=;
        b=YmJqy7oTAhqdw37ZdycPlE4xQHWzAzEyiIv1bwAJ+k800he3tpdc4eeHi8g2076nhy
         eFpnznsMMtIO3FlnVUZbKwtqK+uAyMx/3TG1ZmLZkKoL8wRRNLtUPV4GkxPiBqrLWSIC
         qcXyA32oho2Wmnd2IAvNC528WH6gkCvSzzAYRc+uqHrcyDlMEziNb9NTyUOIJk8N5rHn
         i2+iMF+glTfk7yiWA4Gg3Jq84squ2yLXheMSFWQVdqfoMbyBoTX6nyZlSSqfugrPvEk4
         1SfZKIwCVIzqn4gycQ2E9pEHMbBzBMUIp1jtvSmYoIItc234byDfWhh9SHILAXXkTXBx
         RipA==
X-Gm-Message-State: AOAM533fBaYbybONJhsSymneucSSIicFnloN6FToNMRJPGYqTE84y1hO
        amRnBaQOfAmjyZxyW1yMWg==
X-Google-Smtp-Source: ABdhPJwAyYDPJPd/QuvgrvCEGorU09o3oX0vioSImGfUA+720rBTHRNfwyRDvv4oc8UFp20LVOHoNA==
X-Received: by 2002:a4a:d47:: with SMTP id 68mr7887808oob.92.1639587383787;
        Wed, 15 Dec 2021 08:56:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j10sm528301ooq.5.2021.12.15.08.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:56:23 -0800 (PST)
Received: (nullmailer pid 1466701 invoked by uid 1000);
        Wed, 15 Dec 2021 16:56:22 -0000
Date:   Wed, 15 Dec 2021 10:56:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [next PATCH] dt-bindings: nvmem: convert mtk-efuse.txt to YAML
 schema
Message-ID: <YboeNrekGcGOZES8@robh.at.kernel.org>
References: <20211209024213.16612-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209024213.16612-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:42:13AM +0800, Chunfeng Yun wrote:
> Convert mtk-efuse.txt to YAML schema mediatek,efuse.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../bindings/nvmem/mediatek,efuse.yaml        | 89 +++++++++++++++++++
>  .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 ---------
>  2 files changed, 89 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> new file mode 100644
> index 000000000000..7332195e7f00
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/mediatek,efuse.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek efuse device tree bindings
> +
> +description: |
> +  MediaTek's efuse is used for storing calibration data, it can be accessed
> +  on ARM devices usiong I/O mapped memory.
> +
> +maintainers:
> +  - Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  $nodename:
> +    pattern: "^efuse@[0-9a-f]+$"
> +
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt7622-efuse
> +              - mediatek,mt7623-efuse
> +              - mediatek,mt8173-efuse
> +              - mediatek,mt8192-efuse
> +              - mediatek,mt8195-efuse
> +              - mediatek,mt8516-efuse
> +          - const: mediatek,efuse
> +      - const: mediatek,mt8173-efuse
> +        deprecated: true
> +
> +  reg:
> +    maxItems: 1
> +

All of: 

> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      bits:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false

...this is covered by nvmem.yaml and can be dropped.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    efuse@10206000 {
> +        compatible = "mediatek,mt8173-efuse";
> +        reg = <0x10206000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        u2_intr_p0: usb2-intr-p0@188 {
> +            reg = <0x188 0x1>;
> +            bits = <0 5>;
> +        };
> +
> +        u2_intr_p1: usb2-intr-p1@188 {
> +            reg = <0x188 0x2>;
> +            bits = <5 5>;
> +        };
> +
> +        thermal_calibration: calib@528 {
> +            reg = <0x528 0xc>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> deleted file mode 100644
> index 39d529599444..000000000000
> --- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -= Mediatek MTK-EFUSE device tree bindings =
> -
> -This binding is intended to represent MTK-EFUSE which is found in most Mediatek SOCs.
> -
> -Required properties:
> -- compatible: should be
> -	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
> -	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
> -	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
> -	      "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
> -	      "mediatek,mt8195-efuse", "mediatek,efuse": for MT8195
> -	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
> -- reg: Should contain registers location and length
> -- bits: contain the bits range by offset and size
> -
> -= Data cells =
> -Are child nodes of MTK-EFUSE, bindings of which as described in
> -bindings/nvmem/nvmem.txt
> -
> -Example:
> -
> -	efuse: efuse@10206000 {
> -		compatible = "mediatek,mt8173-efuse";
> -		reg	   = <0 0x10206000 0 0x1000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -
> -		/* Data cells */
> -		thermal_calibration: calib@528 {
> -			reg = <0x528 0xc>;
> -		};
> -	};
> -
> -= Data consumers =
> -Are device nodes which consume nvmem data cells.
> -
> -For example:
> -
> -	thermal {
> -		...
> -		nvmem-cells = <&thermal_calibration>;
> -		nvmem-cell-names = "calibration";
> -	};
> -- 
> 2.18.0
> 
> 
