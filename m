Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F47484543
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiADPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:53:06 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:43003 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiADPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:53:05 -0500
Received: by mail-oo1-f53.google.com with SMTP id y13-20020a4a624d000000b002daae38b0b5so11636551oog.9;
        Tue, 04 Jan 2022 07:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gmD9gob3cVkYBn2LPjKtrssDrTRedlQOZymezF9lzDw=;
        b=kv9elvgdhzHuY5vw4pgcoCs4fSHeTWcSAOQ1v6NCLv9jrrgfGsGumavAyGDO6GKHCm
         qC3YHRFSqNmNOc8tbLJl0ZzXeSc/0IzHf/rIibBACqqZOFGvkl2zOGtUmmlnzuBTPsxL
         Q3D1A5nF5YnV3S1Ky1+FaJtzgYYmKCuIVne3/7g8j7QhDCEVbQIgQXsrbCzFaCLygqtw
         7Bfsx6e/4Qo5El5oSVEfNbdACwxK6zEKQWFi621FRz+jG//pcy3FTImbJfIHCP/7CeDH
         T0caEpDIvGvKOk/QW33OaN/gHwI7GRB0Xwy7QpnwuAwFj7OOEh+DgXfx2rAjiaIjkd5M
         KZnQ==
X-Gm-Message-State: AOAM5319LAXqJmvPncsQgTZBU/jnV1w3hOOvpxCp19S4NiUhS0xrL1s3
        gJLkv3VlehESXwD7Ll5i3NvhARTBvw==
X-Google-Smtp-Source: ABdhPJy4FbFDx1d9qJF2qP8KX1bPzUniKDu1IcZFFxtDmZcOuFBU6RwD3vdfgy5FJqfDgeBo5j2HvA==
X-Received: by 2002:a4a:a808:: with SMTP id o8mr31846217oom.64.1641311585096;
        Tue, 04 Jan 2022 07:53:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a6sm9787231oil.6.2022.01.04.07.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:53:04 -0800 (PST)
Received: (nullmailer pid 910487 invoked by uid 1000);
        Tue, 04 Jan 2022 15:53:03 -0000
Date:   Tue, 4 Jan 2022 09:53:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     iain@hunterembedded.co.uk, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Add binding for ti,adc1018. It allows selection
 of channel as a Device Tree property
Message-ID: <YdRtX4mX4WmYacoT@robh.at.kernel.org>
References: <20211231131951.1245508-1-drhunter95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231131951.1245508-1-drhunter95@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 01:19:15PM +0000, Iain Hunter wrote:
> New binding file uses the adc.yaml to define channel selection 

For the subject, follow the conventions used by other files in the 
subsystem. Run 'git log --oneline directory/for/file' and it should be 
evident.

> 
> Signed-off-by: Iain Hunter <drhunter95@gmail.com>
> ---
>  .../bindings/iio/adc/ti,ads1018.yaml          | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> new file mode 100644
> index 000000000000..a65fee9d83dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS1018 4 channel I2C analog to digital converter
> +
> +maintainers:
> +  - Iain Hunter <iain@hunterembedded.co.uk>
> +
> +description: |
> +  Datasheet at: https://www.ti.com/lit/gpn/ads1018
> +  Supports both single ended and differential channels.
> +
> +properties:
> +  compatible:
> +    const: ti,ads1018
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  spi-max-frequency: true
> +  spi-cpol: true
> +  spi-cpha: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - spi-cpha
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^channel@([0-3])$":

0-3 doesn't match the allowed 'reg' values.

> +    $ref: "adc.yaml"
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: |
> +            Must be 0, actual channel selected in ti,adc-channels for single ended
> +            or ti-adc-channels-diff for differential
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0]
> +
> +      ti,adc-channels:
> +        description: |
> +          List of single-ended channels muxed for this ADC. It can have up to 4
> +          channels numbered 0-3
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        deprecated: true
> +
> +      ti,adc-diff-channels:
> +        description: |
> +          List of differential channels muxed for this ADC between the pins vinp
> +          and vinn. The 4 possible options are:
> +          vinp=0, vinn=1
> +          vinp=0, vinn=3
> +          vinp=1, vinn=3
> +          vinp=2, vinn=3
> +
> +          They are listed in a pair <vinp vinn>.
> +
> +          Note: At least one of "ti,adc-channels" or "ti,adc-diff-channels" is
> +          required.
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +        items:

No bounds for the number of tuples?

> +          items:
> +            - description: |
> +                "vinp" indicates positive input number
> +              minimum: 0
> +              maximum: 2
> +            - description: |
> +                "vinn" indicates negative input number
> +              minimum: 1
> +              maximum: 3
> +
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    // example on SPI1 with single ended channel 1
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@1 {
> +            compatible = "ti,ads1018";
> +            reg = <0x0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            spi-cpha;
> +            ti,adc-channels = <1>;
> +        };
> +    };
> +  - |
> +    // example on SPI0 with differential between inputs 0 and 3
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads1018";
> +            reg = <0x0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            spi-cpha;
> +            ti,adc-diff-channels = <0 3>;
> +        };
> +    };
> +
> +...
> -- 
> 2.25.1
> 
> 
