Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928F159803C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiHRIid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241839AbiHRIiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:38:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C025C342
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:38:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o2so1257955lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=U8mib6crvM0rQuERDFjof2hyN3a8okkIg9elL9u0kJg=;
        b=jwVCHD0CWJBCZHk/o1nvJTaQxhcAHc0QSo/nmKSl0ydzcjaq1dxcCDu8GNWnH4k7f2
         2SCUs2e9LPknCY86BzjOmpULs4gbuOqNVbtX5edaUcGC8z9UL3fmvua8ZvoEV1N7t8gq
         WIIPvo7UA9Gh9t9c2ZhYrZ016vq8fqqr5tehMISzFX2ohP6OquuzSL7pcco3Z3CUzQDH
         Xw2v4vuL1W66yymzi3tasz6J9o0r8WBa5olITkHvBDHX06iiJgS1nxmMxnHARUjd0NAr
         FN8yj9HK3oxugtepJmLkVXc0TXk2qAg7t/G/f2YsLEanoCb9OZmsH4hjgvm/6qqHC5eq
         ddnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=U8mib6crvM0rQuERDFjof2hyN3a8okkIg9elL9u0kJg=;
        b=u6/N8Q5dgxy7+2bMpg3u5KDXQZ2WWuKla0uxyA9QUMQcQuhb/+EckqPXGZN05pndiu
         lean+rQS/FWmWf8apozNlVfDXevHdLOZFc98RifOYWN/l+bPSgNAdGf+f2DszXO/wR9z
         jhtpGcO0C2KKtl1vXNvS56B5Laq6hkrcmDc1l7QvxBkkWHdupZnRiCSWDaYWwXk838f8
         QIxtmaq6xTM4ifMurhcLpHqVU3RS7mSmoah56V1JhnmYoa2Y/g9qWG++rS934lkzQmPx
         cugnVJlTLcluzRbsOocWp1EKm5XvxIo9S7hHKQSVLpq3TRzAedkQTnxZszgA9P/Y0W29
         bfCw==
X-Gm-Message-State: ACgBeo0BobdOxK8oatCNcxMmEutd2QEpUFdn5mj/bSHlR60oR0HkojXg
        Ld/vlz1SegfpAu/4LTYVGQAoZ1Yog+vIAcUn
X-Google-Smtp-Source: AA6agR5NsU+UQzU9oVHwISH+Y9TpxsOzS9WjuSBkYYfeX1UpvgeIKBtf3CU3dewTKcmiosg1tIUoiQ==
X-Received: by 2002:a05:6512:2207:b0:492:b573:63a0 with SMTP id h7-20020a056512220700b00492b57363a0mr685074lfu.325.1660811898541;
        Thu, 18 Aug 2022 01:38:18 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id b18-20020a05651c033200b002618dae9fe8sm136199ljp.73.2022.08.18.01.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 01:38:17 -0700 (PDT)
Message-ID: <c1a98a3e-609e-7783-b1b7-3bb39caa8c65@linaro.org>
Date:   Thu, 18 Aug 2022 11:38:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        admin@hifiphile.com, kavyasree.kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817075517.49575-3-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 10:55, Sergiu Moga wrote:
> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
> json-schema format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
>  2 files changed, 190 insertions(+), 98 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
> new file mode 100644
> index 000000000000..cf15d73fa1e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
> @@ -0,0 +1,190 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,at91-usart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
> +
> +maintainers:
> +  - Richard Genoud <richard.genoud@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:

This looks quite different than bindings and you commit msg is saying it
is only a conversion. Mention any changes against original bindings.

> +      - const: atmel,at91rm9200-usart
> +      - const: atmel,at91sam9260-usart
> +      - const: microchip,sam9x60-usart

That's an enum

> +      - items:
> +          - const: atmel,at91rm9200-dbgu
> +          - const: atmel,at91rm9200-usart
> +      - items:
> +          - const: atmel,at91sam9260-dbgu
> +          - const: atmel,at91sam9260-usart
> +      - items:
> +          - const: microchip,sam9x60-dbgu
> +          - const: microchip,sam9x60-usart
> +      - items:
> +          - const: microchip,sam9x60-usart
> +          - const: atmel,at91sam9260-usart

This is not correct - contradicts earlier one.

> +      - items:
> +          - const: microchip,sam9x60-dbgu
> +          - const: microchip,sam9x60-usart
> +          - const: atmel,at91sam9260-dbgu
> +          - const: atmel,at91sam9260-usart

What? You wrote above that microchip,sam9x60-dbgu is compatible only
with microchip,sam9x60-usart. Now you write it is also compatible with
other ones?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    contains:
> +      const: usart

No, this has to be specific/fixed list.

> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2

Not really - define the items. One item could be optional, though.

> +
> +  dmas:
> +    items:
> +      - description: TX DMA Channel
> +      - description: RX DMA Channel
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  atmel,usart-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |

No need for |

> +      Must be either 1 for SPI or 0 for USART.

Mention the header.

> +    enum: [ 0, 1 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +
> +if:

Put it under allOf.

> +  properties:
> +    $nodename:
> +      pattern: "^serial@[0-9a-f]+$"
> +then:
> +  allOf:
> +    - $ref: /schemas/serial/serial.yaml#
> +    - $ref: /schemas/serial/rs485.yaml#
> +
> +  properties:
> +    atmel,use-dma-rx:
> +      type: boolean
> +      description: use of PDC or DMA for receiving data
> +
> +    atmel,use-dma-tx:
> +      type: boolean
> +      description: use of PDC or DMA for transmitting data
> +
> +    atmel,fifo-size:
> +      $ref: /schemas/types.yaml#/definitions/uint32
> +      description: |

No need for |

> +        Maximum number of data the RX and TX FIFOs can store for FIFO
> +        capable USARTS.
> +      enum: [ 16, 32 ]
> +
> +else:
> +  if:
> +    properties:
> +      $nodename:
> +        pattern: "^spi@[0-9a-f]+$"
> +  then:
> +    allOf:
> +      - $ref: /schemas/spi/spi-controller.yaml#
> +
> +    properties:
> +      atmel,usart-mode:
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      "#address-cells":
> +        const: 1
> +
> +    required:
> +      - atmel,usart-mode
> +      - "#size-cells"
> +      - "#address-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/mfd/at91-usart.h>
> +    #include <dt-bindings/dma/at91.h>
> +
> +    /* use PDC */
> +    usart0: serial@fff8c000 {
> +        compatible = "atmel,at91sam9260-usart";
> +        reg = <0xfff8c000 0x4000>;
> +        interrupts = <7>;
> +        clocks = <&usart0_clk>;
> +        clock-names = "usart";
> +        atmel,use-dma-rx;
> +        atmel,use-dma-tx;
> +        rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
> +        cts-gpios = <&pioD 16 GPIO_ACTIVE_LOW>;
> +        dtr-gpios = <&pioD 17 GPIO_ACTIVE_LOW>;
> +        dsr-gpios = <&pioD 18 GPIO_ACTIVE_LOW>;
> +        dcd-gpios = <&pioD 20 GPIO_ACTIVE_LOW>;
> +        rng-gpios = <&pioD 19 GPIO_ACTIVE_LOW>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/mfd/at91-usart.h>
> +    #include <dt-bindings/dma/at91.h>
> +
> +    /* use DMA */
> +    usart1: serial@f001c000 {
> +        compatible = "atmel,at91sam9260-usart";
> +        reg = <0xf001c000 0x100>;
> +        interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
> +        clocks = <&usart0_clk>;
> +        clock-names = "usart";
> +        atmel,use-dma-rx;
> +        atmel,use-dma-tx;
> +        dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
> +               <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
> +        dma-names = "tx", "rx";
> +        atmel,fifo-size = <32>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/mfd/at91-usart.h>
> +    #include <dt-bindings/dma/at91.h>
> +
> +    /* SPI mode */
> +    spi0: spi@f001c000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "atmel,at91sam9260-usart";
> +        atmel,usart-mode = <AT91_USART_MODE_SPI>;
> +        reg = <0xf001c000 0x100>;

compatible, then reg then the reset of properties

> +        interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
> +        clocks = <&usart0_clk>;
> +        clock-names = "usart";
> +        dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
> +               <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
> +        dma-names = "tx", "rx";
> +        cs-gpios = <&pioB 3 GPIO_ACTIVE_HIGH>;
> +    };

Best regards,
Krzysztof
