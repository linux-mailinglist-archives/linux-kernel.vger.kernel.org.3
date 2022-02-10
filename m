Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2434B1285
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244111AbiBJQRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:17:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbiBJQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:17:28 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59239397
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:17:29 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 919773F324
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644509846;
        bh=g6QE7ds2byVUPRAmXXnezb98jQ3Ciok2epjMz+QKaeU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JS56m55PTus2DMxULZIJeVMLudHt/vXGPdkBT/YHzlCSaeg0cnxyWWUOdm1acBdrU
         TlkhcSVsHKc+9EJ16O/ZIA9J2BQ4LBMcQr8pfGGHXNIEZHX36gKBb9b5IO3eSy1Pw4
         TrRjMk7lGNT5pcZAKLNY1sZ18BUWwsydc2qezQLFCavk/TmoqizPy5uqMyxZET6W97
         MA74nZTO0wFjGNfJ6EaqPMfiF81tx36UD9v3u+roFgrrILQTueGKfNpB+ldo0nTX6Y
         N+svNfIxOKhuh743XSef+xxC+o8vcqzqa2dL93yozOE9zi5+q1H1BYtP9df8hej8Po
         9IsMB3VfvlOmQ==
Received: by mail-ed1-f69.google.com with SMTP id x6-20020a05640226c600b0040fe1993eebso2916809edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g6QE7ds2byVUPRAmXXnezb98jQ3Ciok2epjMz+QKaeU=;
        b=4Glt9BZD8izhagV7zDhSm4+AtH3opJLlxqi0w0ACBPoSBmuLgT4uKRzR7LPLifc8d1
         UbuonwQBJrUoA0TF8nX+Bej9NMypQj8eWN9k2LU4U6xW+Fl8oxeeWUbtLzjyRQrYZdsE
         s8FwUjZZoalmelEAuarb1k7lhyAkvWBHKXP52+dDDT3y1zVIy2n8lluw7crm8O/TNwEg
         dcpFRr36OBuW5tp3Ir0UPUh8/MHw0d6f3rQ6CMCLlVlf+NvV+Wzl3FTVWY1rFNG6gJYm
         xtmMiL2/P7uIi2YQ8MKL4eIV/FUZnlbPLutxShq8g0yn+rqbkxDh8ro5XUCNYlGcDttw
         JezA==
X-Gm-Message-State: AOAM530SAIYlRue9FDUOm1szsOfMCu6dh0y+0pPzotWpUUt+tr/mfSBQ
        XIa+HBYm+BpMW8lxsVg/wICiKhMW11Q2qh869MIxk6u1P8fWM5NJjJqCqLm4ZzRATTKH0PNFfyX
        bPuDG9MzwG6W031B0L7oUM6VQ+h9x7QwoZtunlUWbSQ==
X-Received: by 2002:a05:6402:3492:: with SMTP id v18mr9198289edc.345.1644509846145;
        Thu, 10 Feb 2022 08:17:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz022B9e0ZAfVuWMzgucY3m74/1+NS8nZSUh8fsyf0+32xhVV6P2uT+MCE0To8/aXu94C79eA==
X-Received: by 2002:a05:6402:3492:: with SMTP id v18mr9198269edc.345.1644509845938;
        Thu, 10 Feb 2022 08:17:25 -0800 (PST)
Received: from [192.168.0.99] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h15sm3179019ejz.134.2022.02.10.08.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:17:25 -0800 (PST)
Message-ID: <373b87ad-8bcf-e3f3-60fd-14d933fb2f4f@canonical.com>
Date:   Thu, 10 Feb 2022 17:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: watchdog: convert faraday,ftwdt010 to
 yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, linux@roeck-us.net,
        robh+dt@kernel.org, wim@linux-watchdog.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220210155450.2939129-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220210155450.2939129-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 16:54, Corentin Labbe wrote:
> Converts watchdog/faraday,ftwdt010.txt to yaml.
> This permits to detect missing properties like clocks and resets or
> compatible like moxa,moxart-watchdog.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - Added myself as maintainer as requested by Linus
> - Added $ref to watchdog.yaml
> - Removed useless quotes
> - Added blank lines between properties
> - Removed timeout-sec as already provided by watchdog.yaml
> 
> Change since v2:
> - rewrite compatible section
> 
>  .../bindings/watchdog/faraday,ftwdt010.txt    | 22 -------
>  .../bindings/watchdog/faraday,ftwdt010.yaml   | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
> deleted file mode 100644
> index 9ecdb502e605..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -Faraday Technology FTWDT010 watchdog
> -
> -This is an IP part from Faraday Technology found in the Gemini
> -SoCs and others.
> -
> -Required properties:
> -- compatible : must be one of
> -  "faraday,ftwdt010"
> -  "cortina,gemini-watchdog", "faraday,ftwdt010"
> -- reg : shall contain base register location and length
> -- interrupts : shall contain the interrupt for the watchdog
> -
> -Optional properties:
> -- timeout-sec : the default watchdog timeout in seconds.
> -
> -Example:
> -
> -watchdog@41000000 {
> -	compatible = "faraday,ftwdt010";
> -	reg = <0x41000000 0x1000>;
> -	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> -};
> diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> new file mode 100644
> index 000000000000..e7b90ba41093
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/faraday,ftwdt010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday Technology FTWDT010 watchdog
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +  - Corentin Labbe <clabbe@baylibre.com>
> +
> +description: |
> +  This is an IP part from Faraday Technology found in the Gemini
> +  SoCs and others.
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: faraday,ftwdt010
> +      - items:
> +        - enum:
> +          - cortina,gemini-watchdog
> +          - moxa,moxart-watchdog
> +        - const: faraday,ftwdt010

I think you have indentation warnings.

> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: PCLK
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

Are you sure your DTSes don't have warnings? You include watchdog.yaml
schema (good) so here should be unevaluatedProperties to accept ones
mentioned there.

Just add "timeout-sec" to example below to see the error.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    watchdog@41000000 {
> +      compatible = "faraday,ftwdt010";
> +      reg = <0x41000000 0x1000>;
> +      interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +  - |
> +    watchdog: watchdog@98500000 {
> +      compatible = "moxa,moxart-watchdog", "faraday,ftwdt010";
> +      reg = <0x98500000 0x10>;
> +      clocks = <&clk_apb>;
> +      clock-names = "PCLK";
> +    };
> +...


Best regards,
Krzysztof
