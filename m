Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0458948FD19
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiAPM61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:58:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34598 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiAPM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:58:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFCC5B80CBB;
        Sun, 16 Jan 2022 12:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455B9C36AE9;
        Sun, 16 Jan 2022 12:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642337901;
        bh=crWtyNK5zxiQBZDo3g0NyCg6HOCKw7F4DWaYul3pOEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XQZyS2M3331U8AIPsDScFgEW8t/cR+vBZLahOJFRgeSMzAc6np2HiByRCR2fJLXNQ
         OjdFrk+yaVQR5HM0SrwIEd4OF2GAvfW3bLMHgfvdLttorA+CeehqwJ4Yjmhz/EfTtv
         JG57wYi3m/11pFc4V0/IeK0cxRaLJZWL9g30CnHiRr5BNLAMYMwmtvIoraZazaVW1V
         WOCX/RX15qDUdcuM3KVBJMvbk7RHiV3hC9j9ixgQ8KSWuEyN5Eo8mS6FKmlHt9BTR1
         AdfvLPhIvEBeabtBh9A7iLAYytZQ29Nfx/VRVfL5E+Tyad5in+o8XRZsee8gCQwPMN
         Dix2mq6givYwA==
Date:   Sun, 16 Jan 2022 13:04:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings:iio:frequency: add admv1014 binding
Message-ID: <20220116130422.167bca2e@jic23-huawei>
In-Reply-To: <20220110151350.164095-1-antoniu.miclaus@analog.com>
References: <20220110151350.164095-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 17:13:49 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the ADMV1014 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Just one totally trivial comment on this that I could tidy up with applying
if patch 1 is good and others are happy with the series.

Thanks,

Jonathan

> ---
> changes in v2:
>  - move clock description unde `clock-names` section
>  - expand `p1db-comp-enable` to `p1db-compensation-enable`
>  - add regulators for all VCC_* supplies, as suggested
>  .../bindings/iio/frequency/adi,admv1014.yaml  | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> new file mode 100644
> index 000000000000..9c43cec72560
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> @@ -0,0 +1,129 @@
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
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lo_in
> +    description:
> +      Definition of the external clock that serves as input Local Oscillator.
Trivial: Not sure "Definition of" adds anything?
	External clock that provides the Local Oscilator input.
perhaps?

> +
> +  vcm-supply:
> +    description:
> +      Common-mode voltage regulator.
> +
> +  vcc-if-bb-supply:
> +    description:
> +      BB and IF supply voltage regulator.
> +
> +  vcc-vga-supply:
> +    description:
> +      RF Amplifier supply voltage regulator.
> +
> +  vcc-vva-supply:
> +    description:
> +      VVA Control Circuit supply voltage regulator.
> +
> +  vcc-lna-3p3-supply:
> +    description:
> +      Low Noise Amplifier 3.3V supply voltage regulator.
> +
> +  vcc-lna-1p5-supply:
> +    description:
> +      Low Noise Amplifier 1.5V supply voltage regulator.
> +
> +  vcc-bg-supply:
> +    description:
> +      Band Gap Circuit supply voltage regulator.
> +
> +  vcc-quad-supply:
> +    description:
> +      Quadruple supply voltage regulator.
> +
> +  vcc-mixer-supply:
> +    description:
> +      Mixer supply voltage regulator.
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
> +  adi,p1db-compensation-enable:
> +    description:
> +      Turn on bits to optimize P1dB.
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
> +        adi,p1db-compensation-enable;
> +      };
> +    };
> +...

