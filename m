Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B04A626E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbiBAR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:29:07 -0500
Received: from mail-oo1-f46.google.com ([209.85.161.46]:42708 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiBAR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:29:06 -0500
Received: by mail-oo1-f46.google.com with SMTP id w5-20020a4a9785000000b0030956914befso114372ooi.9;
        Tue, 01 Feb 2022 09:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iMYzAJDNaV/gptZ3or49lK9EJLg7H9JXnTy+JftInwE=;
        b=V2XxgBmKCXqn4L7X20maCj1r/2OKIFYwgv3Sve0WVc5IRfXqWaIjxn2jgakqP5BsiF
         MEWT2yIBqJZPZOPvDJ+k616tUkQ/pvqecx18FlnuTHVYosA+pGN0COpY13sIiql5Yi5B
         EouKG9+/QcirgKCh2yU0uf4x/dFV7rgKBcOiuaMYlQXCtjonULe3pLxyv/qj8EodqdGI
         q50LbDq6aYw5PqmgKhRvdHPU1arq50Ac6p5eNRPNpJa58BwtlFySZvfyGl0O4pDNJ+9u
         sErghFLqfNllrKE89nFSv+PwrGNUq7FiWfXG/M3E0lxmknxNsEihKuEvc2qy7ipj9vAi
         /0xg==
X-Gm-Message-State: AOAM530ETtj1UubVdVS5tm5vJ/PkW6VkrIgmeSo5BufH+sFw7UlsXl3i
        0P9X3Qca35jtIDOTQltJxneBpNjXzA==
X-Google-Smtp-Source: ABdhPJxaDofsHCoDc63WiBgkP6sKeiud4f2oJ4Ih7vvph+GKzrueFLxq7DJxC6JjxnQAG3WR7HrTHw==
X-Received: by 2002:a4a:ddc1:: with SMTP id i1mr13006229oov.96.1643736545500;
        Tue, 01 Feb 2022 09:29:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d22sm14160141otp.79.2022.02.01.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:29:04 -0800 (PST)
Received: (nullmailer pid 243935 invoked by uid 1000);
        Tue, 01 Feb 2022 17:29:03 -0000
Date:   Tue, 1 Feb 2022 11:29:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: gpio-fan: convert to YAML
Message-ID: <Yflt302QEqs5gabI@robh.at.kernel.org>
References: <20220126200350.3633576-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126200350.3633576-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 08:03:50PM +0000, Corentin Labbe wrote:
> Converts hwmon/gpio-fan.txt to YAML
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> 
> I didnt found any clear maintainer and since DT yaml mandates a
> maintainer section, I set devicetree@vger.kernel.org.
> 
>  .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 --------
>  .../devicetree/bindings/hwmon/gpio-fan.yaml   | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> deleted file mode 100644
> index f4cfa350f6a1..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Bindings for fan connected to GPIO lines
> -
> -Required properties:
> -- compatible : "gpio-fan"
> -
> -Optional properties:
> -- gpios: Specifies the pins that map to bits in the control value,
> -  ordered MSB-->LSB.
> -- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
> -  control value that should be set to achieve them. This array
> -  must have the RPM values in ascending order.
> -- alarm-gpios: This pin going active indicates something is wrong with
> -  the fan, and a udev event will be fired.
> -- #cooling-cells: If used as a cooling device, must be <2>
> -  Also see:
> -  Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> -  min and max states are derived from the speed-map of the fan.
> -
> -Note: At least one the "gpios" or "alarm-gpios" properties must be set.
> -
> -Examples:
> -
> -	gpio_fan {
> -		compatible = "gpio-fan";
> -		gpios = <&gpio1 14 1
> -			 &gpio1 13 1>;
> -		gpio-fan,speed-map = <0    0
> -				      3000 1
> -				      6000 2>;
> -		alarm-gpios = <&gpio1 15 1>;
> -	};
> -	gpio_fan_cool: gpio_fan {
> -		compatible = "gpio-fan";
> -		gpios = <&gpio2 14 1
> -			 &gpio2 13 1>;
> -		gpio-fan,speed-map =	<0    0>,
> -					<3000 1>,
> -					<6000 2>;
> -		alarm-gpios = <&gpio2 15 1>;
> -		#cooling-cells = <2>; /* min followed by max */
> -	};
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> new file mode 100644
> index 000000000000..15bb5efd3cb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/gpio-fan.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for fan connected to GPIO lines
> +
> +maintainers:
> +  - OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>
> +
> +properties:
> +  compatible:
> +    const: gpio-fan
> +
> +  gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: Specifies the pins that map to bits in the control value,
> +      ordered MSB-->LSB.
> +
> +  gpio-fan,speed-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: A mapping of possible fan RPM speeds and the
> +      control value that should be set to achieve them. This array
> +      must have the RPM values in ascending order.
> +
> +  alarm-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: This pin going active indicates something is wrong with
> +      the fan, and a udev event will be fired.
> +
> +  "#cooling-cells":
> +    const: 2
> +    description: If used as a cooling device, must be <2>
> +      Also see Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> +      min and max states are derived from the speed-map of the fan.
> +
> +anyOf:
> +  - required:
> +      - gpios
> +  - required:
> +      - alarm-gpios
> +
> +additionalProperties: False
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/cortina,gemini-clock.h>
> +    #include <dt-bindings/reset/cortina,gemini-reset.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    gpio1: gpio@4d000000 {
> +      compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
> +      reg = <0x4d000000 0x100>;
> +      interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
> +      resets = <&syscon GEMINI_RESET_GPIO0>;
> +      clocks = <&syscon GEMINI_CLK_APB>;
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +    };

No need to show providers in examples.

And one example is probably sufficient here.

> +    gpio_fan {
> +      compatible = "gpio-fan";
> +        gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +        gpio-fan,speed-map = <0    0>,
> +                             <3000 1>,
> +                             <6000 2>;
> +        alarm-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/cortina,gemini-clock.h>
> +    #include <dt-bindings/reset/cortina,gemini-reset.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    gpio2: gpio@4d000000 {
> +      compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
> +      reg = <0x4d000000 0x100>;
> +      interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
> +      resets = <&syscon GEMINI_RESET_GPIO0>;
> +      clocks = <&syscon GEMINI_CLK_APB>;
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +    };
> +    gpio_fan_cool: gpio_fan {
> +      compatible = "gpio-fan";
> +      gpios = <&gpio2 8 GPIO_ACTIVE_HIGH
> +               &gpio2 1 GPIO_ACTIVE_HIGH>;
> +      gpio-fan,speed-map = <0    0
> +                           3000 1
> +                           6000 2>;
> +      alarm-gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
> +      #cooling-cells = <2>; /* min followed by max */
> +    };
> -- 
> 2.34.1
> 
> 
