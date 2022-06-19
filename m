Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF410550A43
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiFSLbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiFSLa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:30:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147E365F6;
        Sun, 19 Jun 2022 04:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1FE5B80CFE;
        Sun, 19 Jun 2022 11:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CA1C3411D;
        Sun, 19 Jun 2022 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655638252;
        bh=M4FK7HUp/K1RW0AhfhWOuHD0fUg2fTC1IQ6P6Bs9+vU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMgcolAP5FJaAf+vJwXmXF0k196/rK/GjR9CrIN/CB+pN5INLsLktAnAfWlpTBAUa
         b6zZNhQYGnIrA8RMzXWDATN71HWHgkR5UuRLOXHEc42pGpv7hnB3QbcIwS19F1Up44
         FJo36uP+KCzv20hzFhhFIFJOIQCqNdZAQW9IaJyL+JsxVb9BhaZYMSufQEk57AuBxj
         9rEedyS7s91SGOz+QheEcCo8Bx6VqzoIGFqEGJzim5iXJHiBTMCD9khoEL3q4akAOe
         L2W416lS55o9cBsi04/IiUy3MOxUiRo1JGfKX2Pdodu6DWVJXFD/obhoc7mYQIUuBT
         wmWci2YRZS+bg==
Date:   Sun, 19 Jun 2022 12:40:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Message-ID: <20220619124009.65bb16f4@jic23-huawei>
In-Reply-To: <20220616104211.9257-4-ddrokosov@sberdevices.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
        <20220616104211.9257-4-ddrokosov@sberdevices.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 10:42:17 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Introduce devicetree binding json-schema for MSA311 tri-axial,
> low-g accelerometer driver.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Hi Dmitry,

A few trivial suggestions to drop description entries that don't
useful information.

One thing we often end up adding very soon after new bindings are
introduced is power supplies.  If sensible to do so, it's better
to introduce them at the start and save on the noise.
Looks like this one just needs a property entry of

  vdd-supply: true

Obviously you then need to get it in the driver and turn it on
(+ off via a devm_add_action_or_reset() call) as minimal support.

Thanks,

Jonathan

> ---
>  .../bindings/iio/accel/memsensing,msa311.yaml | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> new file mode 100644
> index 000000000000..072632708d42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/accel/memsensing,msa311.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MEMSensing digital 3-Axis accelerometer
> +
> +maintainers:
> +  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
> +
> +description: |
> +  MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> +  sensitivity consumer applications. It has dynamical user selectable full
> +  scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> +  with output data rates from 1Hz to 1000Hz.
> +  Datasheet can be found at following URL
> +  https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> +
> +properties:
> +  compatible:
> +    const: memsensing,msa311
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C registers address

No need for description. It always means that for i2c devices.

> +
> +  interrupts:
> +    maxItems: 1
> +    description: optional I2C int pin can be freely mapped to specific func

Why I2C int?  Is there anything associating it with i2c specifically?

I'm not sure the description adds anything useful for this so I'd
drop it.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        accelerometer@62 {
> +            compatible = "memsensing,msa311";
> +            reg = <0x62>;
> +            interrupt-parent = <&gpio_intc>;
> +            interrupts = <29 IRQ_TYPE_EDGE_RISING>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55aeb25c004c..be39e5c214fe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12482,6 +12482,7 @@ MEMSENSING MICROSYSTEMS MSA311 ACCELEROMETER DRIVER
>  M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
>  F:	drivers/iio/accel/msa311.c
>  
>  MEN A21 WATCHDOG DRIVER

