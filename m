Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707F248FC4D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 12:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiAPLZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 06:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiAPLY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 06:24:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C5C061574;
        Sun, 16 Jan 2022 03:24:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C6F9B80D3D;
        Sun, 16 Jan 2022 11:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F66C36AE7;
        Sun, 16 Jan 2022 11:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642332296;
        bh=SCm04AFPsLST/8ZlVrtGPvyNPIJ3KZ962EHDyckiGZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HGqax4vFQK6J0AxhqaMoxaDep75PIIIEccQ0z6I5FWuausPJQEBQ5IBujRmh0vBhN
         y3SLmRcnGHIaGzMuWGMUkC93/BHBobWQ4vRer44UR7Rtdoz+vDwCkICOXANTJ5b7Ob
         cjIsNtbWYo3RTwiWaxQh5w8/LmiJP+HqqZBdIVSKA/iTr1eeRRXi0hHAx2mgCR8o/6
         PRSuL0W+aY+iO62VPEA8YefbjuXhmFYBqomi9k28wRm1MWXpAV980Ogi/N1OHN1zMT
         lcCfXATIgQrrOJyzIytIyRJLYi7r0cumRAExpaKqUJhNg3yGhhrsSGiNgxrXyLor/L
         0N0PotkRZCliA==
Date:   Sun, 16 Jan 2022 11:30:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: addac: one-bit-adc-dac yaml
 documentation
Message-ID: <20220116113056.535a5cad@jic23-huawei>
In-Reply-To: <20220111115919.14645-1-cristian.pop@analog.com>
References: <20220111115919.14645-1-cristian.pop@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 13:59:18 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> This adds device tree bindings for the one-bit-adc-dac.

This series really needs a cover letter where you describe in
general terms what the aim is etc.

> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> V1->V2                                                                     
>  - I am aware of the recommendation of rename/move this driver. Should we  
>    consider "drivers/io/gpio.c"? 

Probably keep with the naming of the hwmon iio bridge and go with
gpio_iio.c to indicate bridge from gpio to iio.

I'll put more general comments in patch 2 review, but I'm very doubtful
that setting this up via dt is giong to be the way forward.
Shall we say, the iio_hwmon bindings have always been controversial and
we'd probably not get away with them today...

Reason being it's policy not wiring and reflects internal Linux subsystem
constructs, not generic things applicable to all operating systems.

                                          
>  - Add .yaml file                                                          
>  - Remove blank lines, remove unnecessary coma                             
>  - Remove macros for channels                                              
>  - Check if channel is input for write_raw                                 
>  - Use labels instead of extend_name                                       
>  - Fix channel indexing                                                    
>  - Use "sizeof(*channels)" in devm_kcalloc()                               
>  - Remove assignment: " indio_dev->dev.parent = &pdev->dev;"               
>  - Remove "platform_set_drvdata"                               
Not in this patch so shouldn't be in this description.            
>  - Remove "adi" from compatible string since is not ADI specific driver.
> ---

Version log here for stuff in this patch.  Fine to have the log in the
cover letter if the changes tend to go across multiple patches (renames etc).

>  .../bindings/iio/addac/one-bit-adc-dac.yaml   | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml b/Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml
> new file mode 100644
> index 000000000000..dbed0f3b1ca4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/addac/one-bit-adc-dac.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/addac/one-bit-adc-dac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices one bit ADC DAC driver
> +
> +maintainers:
> +  - Cristian Pop <cristian.pop@analog.com>
> +
> +description: |
> +  One bit ADC DAC driver
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,one-bit-adc-dac
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  in-gpios:
> +    description: Input GPIOs
> +
> +  out-gpios:
> +    description: Output GPIOs
> +
> +required:
> +  - compatible
> +  - in-gpios
> +  - out-gpios
> +
> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADDAC.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: |
> +          The channel number.
> +
> +      label:
> +        description: |
> +          Unique name to identify which channel this is.
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    one-bit-adc-dac@0 {
> +        compatible = "one-bit-adc-dac";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        in-gpios = <&gpio 17 0>, <&gpio 27 0>;
> +        out-gpios = <&gpio 23 0>, <&gpio 24 0>;
> +
> +        channel@0 {
> +          reg = <0>;
> +          label = "i_17";
> +        };
> +
> +        channel@1 {
> +          reg = <1>;
> +          label = "i_27";
> +        };
> +
> +        channel@2 {
> +          reg = <2>;
> +          label = "o_23";
> +        };
> +
> +        channel@3 {
> +          reg = <3>;
> +          label = "o_24";
> +        };
> +    };

