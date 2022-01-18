Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E0493044
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349709AbiARWBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:01:00 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:50797 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiARWAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:00:55 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 4cdc8265;
        Tue, 18 Jan 2022 23:00:52 +0100 (CET)
Date:   Tue, 18 Jan 2022 23:00:52 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kettenis@openbsd.org,
        povik+lin@protonmail.com
In-Reply-To: <20220118191839.64086-2-povik+lin@protonmail.com> (message from
        Martin =?utf-8?Q?Povi=C5=A1er?= on Tue, 18 Jan 2022 19:21:03 +0000)
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: Add Apple NCO
References: <20220118191839.64086-1-povik+lin@protonmail.com> <20220118191839.64086-2-povik+lin@protonmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-ID: <d3cbbeb0d20fbd64@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 18 Jan 2022 19:21:03 +0000
> From: Martin Povišer <povik+lin@protonmail.com>
> 
> The NCO block found on Apple SoCs is a programmable clock generator
> performing fractional division of a high frequency input clock.
> 
> Signed-off-by: Martin Povišer <povik+lin@protonmail.com>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  .../devicetree/bindings/clock/apple,nco.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/apple,nco.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/apple,nco.yaml b/Documentation/devicetree/bindings/clock/apple,nco.yaml
> new file mode 100644
> index 000000000000..da56b64b8fff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/apple,nco.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/apple,nco.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoCs' NCO block
> +
> +maintainers:
> +  - Martin Povišer <povik+lin@protonmail.com>
> +
> +description: |
> +  The NCO (Numerically Controlled Oscillator) block found on Apple SoCs
> +  such as the t8103 (M1) is a programmable clock generator performing
> +  fractional division of a high frequency input clock.
> +
> +  It carries a number of independent channels and is typically used for
> +  generation of audio bitclocks.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - apple,t6000-nco
> +        - apple,t8103-nco
> +      - const: apple,nco
> +
> +  clocks:
> +    description:
> +      Specifies the reference clock from which the output clocks
> +      are derived through fractional division.
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - '#clock-cells'
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    nco_clkref: clock-ref {
> +      compatible = "fixed-clock";
> +      #clock-cells = <0>;
> +      clock-frequency = <900000000>;
> +      clock-output-names = "nco-ref";
> +    };
> +
> +    nco: clock-controller@23b044000 {
> +      compatible = "apple,t8103-nco", "apple,nco";
> +      reg = <0x3b044000 0x14000>;
> +      #clock-cells = <1>;
> +      clocks = <&nco_clkref>;
> +    };
> --
> 2.33.0
> 
> 
> 
