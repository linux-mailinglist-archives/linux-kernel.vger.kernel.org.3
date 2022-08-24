Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0C359F9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiHXMWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiHXMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:22:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E1B4C619
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:22:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oQpOP-0000Sq-TT; Wed, 24 Aug 2022 14:21:57 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oQpOO-000805-Ho; Wed, 24 Aug 2022 14:21:56 +0200
Date:   Wed, 24 Aug 2022 14:21:56 +0200
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        andy.shevchenko@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: leds: Add binding for a multicolor
 group of LEDs
Message-ID: <20220824122156.GQ17485@pengutronix.de>
References: <20220824103032.163451-1-jjhiblot@traphandler.com>
 <20220824103032.163451-4-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824103032.163451-4-jjhiblot@traphandler.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:30:31PM +0200, Jean-Jacques Hiblot wrote:
> This allows to group multiple monochromatic LEDs into a multicolor
> LED, e.g. RGB LEDs.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/leds/leds-group-multicolor.yaml  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> new file mode 100644
> index 000000000000..79e5882a08e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-group-multicolor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Multi-color LED built with monochromatic LEDs
> +
> +maintainers:
> +  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> +
> +description: |
> +  This driver combines several monochromatic LEDs into one multi-color
> +  LED using the multicolor LED class.
> +
> +properties:
> +  compatible:
> +    const: leds-group-multicolor
> +
> +  leds:
> +    description:
> +      An aray of monochromatic leds
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +required:
> +  - leds
> +
> +allOf:
> +  - $ref: leds-class-multicolor.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/leds/common.h>
> +
> +    monochromatic-leds {
> +        compatible = "gpio-leds";
> +
> +        led0: led-0 {
> +            gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
> +        };
> +
> +        led1: led-1 {
> +            gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
> +        };
> +
> +        led2: led-2 {
> +            gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
> +        };

led-2 has the same GPIO as led-1, should likely be <&mcu_pio 2 GPIO_ACTIVE_HIGH>;

> +    };
> +
> +    multi-led {
> +        compatible = "leds-group-multicolor";
> +        color = <LED_COLOR_ID_RGB>;
> +        function = LED_FUNCTION_INDICATOR;
> +        leds = <&led0>, <&led1>, <&led2>;
> +    };

When reading this I wondered how the driver knows which LED has which
color. Should you assign colors to the individual LEDs to make that
clear in the example?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
