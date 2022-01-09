Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981EE488B6B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiAIRkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiAIRkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:40:42 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02047C06173F;
        Sun,  9 Jan 2022 09:40:41 -0800 (PST)
Received: from [81.101.6.87] (port=47182 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6cBJ-0008Uy-Rs; Sun, 09 Jan 2022 17:40:38 +0000
Date:   Sun, 9 Jan 2022 17:46:33 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings:iio:frequency: add admv1014 doc
Message-ID: <20220109174625.7f5d8ff7@jic23-huawei>
In-Reply-To: <20220103092201.21576-3-antoniu.miclaus@analog.com>
References: <20220103092201.21576-1-antoniu.miclaus@analog.com>
        <20220103092201.21576-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 11:22:00 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

binding rather than doc.  Yaml is code a well as documentation afterall.

> Add device tree bindings for the ADMV1014 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/frequency/adi,admv1014.yaml  | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> new file mode 100644
> index 000000000000..a3e5e61c8ade
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv1014.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV1014 Microwave Downconverter
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Wideband, microwave downconverter optimized for point to point microwave
> +   radio designs operating in the 24 GHz to 44 GHz frequency range.
> +
> +   https://www.analog.com/en/products/admv1014.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv1014
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  clocks:
> +    description:
> +      Definition of the external clock.

Not a particularly helpful way of describing it.  
This is the local oscillator input.  I'd put the description
in clock-names rather than here as then it's obvious what lo_in
means.

> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lo_in
> +
> +  vcm-supply:
> +    description:
> +      Analog voltage regulator.

There seem to be a whole load of other VCC_X supplies from the datasheet.
They should all be here. 

> +
> +  adi,input-mode:
> +    description:
> +      Select the input mode.
> +      iq - in-phase quadrature (I/Q) input
> +      if - complex intermediate frequency (IF) input
> +    enum: [iq, if]
> +
> +  adi,detector-enable:
> +    description:
> +      Digital Rx Detector Enable. The Square Law Detector output is
> +      available at output pin VDET.
> +    type: boolean
> +
> +  adi,p1db-comp-enable:
> +    description:
> +      Turn on bits to optimize P1dB.

Expand comp to compensation perhaps as not a totally clear abbreviation.

> +    type: boolean
> +
> +  adi,quad-se-mode:
> +    description:
> +      Switch the LO path from differential to single-ended operation.
> +      se-neg - Single-Ended Mode, Negative Side Disabled.
> +      se-pos - Single-Ended Mode, Positive Side Disabled.
> +      diff - Differential Mode.
> +    enum: [se-neg, se-pos, diff]
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - vcm-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      admv1014@0{
> +        compatible = "adi,admv1014";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        clocks = <&admv1014_lo>;
> +        clock-names = "lo_in";
> +        vcm-supply = <&vcm>;
> +        adi,quad-se-mode = "diff";
> +        adi,detector-enable;
> +        adi,p1db-comp-enable;
> +      };
> +    };
> +...

