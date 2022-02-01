Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44CD4A570C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiBAFqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiBAFql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:46:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33DC061714;
        Mon, 31 Jan 2022 21:46:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DFE6B82D07;
        Tue,  1 Feb 2022 05:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D8BC340EB;
        Tue,  1 Feb 2022 05:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643694398;
        bh=4jhc4KiRG+gjV3+hhYlzG4iOCdqfQKVt9RFGvLCDa8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfcrvaQi7rZ0CKSrq0fwkMHjZgHcnMLyWewMEogQnguIeCPUglePWsuu1oTonratJ
         KCiVdLyIAexubhn/0Cz8A8NlEvMlhJ1TvB0fbNWp5Axr61nJWysKnO+XPw6OvakWaT
         zT3H7Hk+xQYLHRSyZ4swS7xvZl/SizZdfu8IRfCKy4JDXo8ZhkAFjbBEhDAf15gLIi
         S1+SxR/KVCL/iU2Omy1xkCStES2UunYscjmOB8y7tvsjuvB9h3pdt4bbfuziRHT7wi
         o3rSUtbxjGm7++MbNxHiu+bZjFWEaZT9LzzNz60JnA2sgGXWcKNh8JYBf7eYHIo1uq
         CEeRv6njt3Cbg==
Date:   Tue, 1 Feb 2022 11:16:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     David Heidelberg <david@ixit.cz>, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to
 yaml
Message-ID: <YfjJOQIuGJvedFmJ@matsya>
References: <20211227170151.73116-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227170151.73116-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-12-21, 18:01, David Heidelberg wrote:
> Convert Qualcomm PMIC SPMI binding to yaml format.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

Steve, Can this be picked up please. I will rebase my v7 update based on
this...

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> v2:
>  - add #address and #size-cells
>  - add reg and remove spmi include from example
> v3:
>  - fix doc reference error (make refcheckdocs)
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.txt           |   2 +-
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 120 ++++++++++++++++++
>  3 files changed, 121 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> index 7a27c500ff63..3810a80536f7 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> @@ -58,7 +58,7 @@ Required properties for peripheral child nodes:
>  Optional properties for peripheral child nodes:
>  - interrupts:      Interrupts are specified as a 4-tuple. For more information
>                     see:
> -                   Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> +                   Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
>  - interrupt-names: Corresponding interrupt name to the interrupts property
>  
>  Each child node of SPMI slave id represents a function of the PMIC. In the
> diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> deleted file mode 100644
> index ca645e21fe47..000000000000
> --- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -Qualcomm SPMI Controller (PMIC Arbiter)
> -
> -The SPMI PMIC Arbiter is found on Snapdragon chipsets.  It is an SPMI
> -controller with wrapping arbitration logic to allow for multiple on-chip
> -devices to control a single SPMI master.
> -
> -The PMIC Arbiter can also act as an interrupt controller, providing interrupts
> -to slave devices.
> -
> -See Documentation/devicetree/bindings/spmi/spmi.yaml for the generic SPMI
> -controller binding requirements for child nodes.
> -
> -See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
> -generic interrupt controller binding documentation.
> -
> -Required properties:
> -- compatible : should be "qcom,spmi-pmic-arb".
> -- reg-names  : must contain:
> -     "core" - core registers
> -     "intr" - interrupt controller registers
> -     "cnfg" - configuration registers
> -   Registers used only for V2 PMIC Arbiter:
> -     "chnls"  - tx-channel per virtual slave registers.
> -     "obsrvr" - rx-channel (called observer) per virtual slave registers.
> -
> -- reg : address + size pairs describing the PMIC arb register sets; order must
> -        correspond with the order of entries in reg-names
> -- #address-cells : must be set to 2
> -- #size-cells : must be set to 0
> -- qcom,ee : indicates the active Execution Environment identifier (0-5)
> -- qcom,channel : which of the PMIC Arb provided channels to use for accesses (0-5)
> -- interrupts : interrupt list for the PMIC Arb controller, must contain a
> -               single interrupt entry for the peripheral interrupt
> -- interrupt-names : corresponding interrupt names for the interrupts
> -                    listed in the 'interrupts' property, must contain:
> -     "periph_irq" - summary interrupt for PMIC peripherals
> -- interrupt-controller : boolean indicator that the PMIC arbiter is an interrupt controller
> -- #interrupt-cells :  must be set to 4. Interrupts are specified as a 4-tuple:
> -    cell 1: slave ID for the requested interrupt (0-15)
> -    cell 2: peripheral ID for requested interrupt (0-255)
> -    cell 3: the requested peripheral interrupt (0-7)
> -    cell 4: interrupt flags indicating level-sense information, as defined in
> -            dt-bindings/interrupt-controller/irq.h
> -
> -Example:
> -
> -	spmi {
> -		compatible = "qcom,spmi-pmic-arb";
> -		reg-names = "core", "intr", "cnfg";
> -		reg = <0xfc4cf000 0x1000>,
> -		      <0xfc4cb000 0x1000>,
> -		      <0xfc4ca000 0x1000>;
> -
> -		interrupt-names = "periph_irq";
> -		interrupts = <0 190 0>;
> -
> -		qcom,ee = <0>;
> -		qcom,channel = <0>;
> -
> -		#address-cells = <2>;
> -		#size-cells = <0>;
> -
> -		interrupt-controller;
> -		#interrupt-cells = <4>;
> -	};
> diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> new file mode 100644
> index 000000000000..55d379c85fd9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spmi/qcom,spmi-pmic-arb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SPMI Controller (PMIC Arbiter)
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +
> +description: |
> +  The SPMI PMIC Arbiter is found on Snapdragon chipsets. It is an SPMI
> +  controller with wrapping arbitration logic to allow for multiple on-chip
> +  devices to control a single SPMI master.
> +
> +  The PMIC Arbiter can also act as an interrupt controller, providing interrupts
> +  to slave devices.
> +
> +allOf:
> +  - $ref: spmi.yaml
> +
> +properties:
> +  compatible:
> +    const: qcom,spmi-pmic-arb
> +
> +  reg:
> +    oneOf:
> +      - items: # V1
> +          - description: core registers
> +          - description: interrupt controller registers
> +          - description: configuration registers
> +      - items: # V2
> +          - description: core registers
> +          - description: tx-channel per virtual slave regosters
> +          - description: rx-channel (called observer) per virtual slave registers
> +          - description: interrupt controller registers
> +          - description: configuration registers
> +
> +  reg-names:
> +    oneOf:
> +      - items:
> +          - const: core
> +          - const: intr
> +          - const: cnfg
> +      - items:
> +          - const: core
> +          - const: chnls
> +          - const: obsrvr
> +          - const: intr
> +          - const: cnfg
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: periph_irq
> +
> +  interrupt-controller: true
> +
> +  '#address-cells': true
> +
> +  '#interrupt-cells':
> +    const: 4
> +    description: |
> +      cell 1: slave ID for the requested interrupt (0-15)
> +      cell 2: peripheral ID for requested interrupt (0-255)
> +      cell 3: the requested peripheral interrupt (0-7)
> +      cell 4: interrupt flags indicating level-sense information,
> +              as defined in dt-bindings/interrupt-controller/irq.h
> +
> +  '#size-cells': true
> +
> +  qcom,ee:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 5
> +    description: >
> +      indicates the active Execution Environment identifier
> +
> +  qcom,channel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 5
> +    description: >
> +      which of the PMIC Arb provided channels to use for accesses
> +
> +required:
> +  - compatible
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - '#interrupt-cells'
> +  - qcom,ee
> +  - qcom,channel
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spmi@fc4cf000 {
> +        compatible = "qcom,spmi-pmic-arb";
> +        reg-names = "core", "intr", "cnfg";
> +        reg = <0xfc4cf000 0x1000>,
> +              <0xfc4cb000 0x1000>,
> +              <0xfc4ca000 0x1000>;
> +
> +        interrupt-names = "periph_irq";
> +        interrupts = <0 190 0>;
> +
> +        qcom,ee = <0>;
> +        qcom,channel = <0>;
> +
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +
> +        interrupt-controller;
> +        #interrupt-cells = <4>;
> +    };
> +
> -- 
> 2.34.1

-- 
~Vinod
