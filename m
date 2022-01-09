Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD04888CF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiAILLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiAILLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:11:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C79C06173F;
        Sun,  9 Jan 2022 03:11:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBA0A60EC8;
        Sun,  9 Jan 2022 11:11:31 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 6014BC36AEB;
        Sun,  9 Jan 2022 11:11:28 +0000 (UTC)
Date:   Sun, 9 Jan 2022 11:17:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     iain@hunterembedded.co.uk, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Add binding for ti,adc1018. It allows selection
 of channel as a Device Tree property
Message-ID: <20220109111718.49d2d2cb@jic23-huawei>
In-Reply-To: <20211231131951.1245508-1-drhunter95@gmail.com>
References: <20211231131951.1245508-1-drhunter95@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 13:19:15 +0000
Iain Hunter <drhunter95@gmail.com> wrote:

> New binding file uses the adc.yaml to define channel selection 
> 
> Signed-off-by: Iain Hunter <drhunter95@gmail.com>
Hi Iain,

A few comments in addition to those Rob sent.
It's worth noting that there is a lot of 'history' in IIO bindings so
sometimes copying stuff from an existing binding is no longer the way
things should be done.

Jonathan

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

No.  Should be some sort of index value. If I recall correctly, existing use is reg == channel
number when single ended and more loosely defined for differential.  In many cases first of the
pair, but that's not always guaranteed to be unique (e.g. 0-1 and 0-3 in this case).

> +
> +      ti,adc-channels:
> +        description: |
> +          List of single-ended channels muxed for this ADC. It can have up to 4
> +          channels numbered 0-3

This is a new binding, so how can we have deprecated properties?
Also seems very odd indeed to have a list of channels defined inside a per channel node.

> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        deprecated: true
> +
> +      ti,adc-diff-channels:

Can this use diff-channels in the standard adc binding:
Documentation/devicetree/bindings/iio/adc/adc.yaml

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
> +          items:
> +            - description: |
> +                "vinp" indicates positive input number
> +              minimum: 0
> +              maximum: 2
> +            - description: |
> +                "vinn" indicates negative input number
> +              minimum: 1
> +              maximum: 3

This should be a pair based constraint as not all options possible. Something like
          oneOf:
            - items:
                - const: 0
                - const: 1
            - items:
                - enum: [0, 1, 2]
		- const: 3

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

More recent approach to this is the one you've used for differential channels
- 1 child node per channel.

> +        };
> +    };
> +  - |
> +    // example on SPI0 with differential between inputs 0 and 3

The SPI0 vs 1 is correctly not part of this example, so drop that from
the comment.

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

This doesn't obey the schema you have above at all. Would looks something like
               channel@0 {
                 diff-channels = <0 3>;
               }

> +        };
> +    };
> +
> +...

