Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AEA4B5D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiBNVtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:49:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBNVti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:49:38 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE521954E8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:49:30 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3D4FC40336
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644875369;
        bh=JIs1xiYNpUGWLEtymgYGm7pSCxeAjzoS3yDzGjJPXvE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qcfhIGPd6tSxaCbX5vQlCgrZirAgz3UI81E3r+pO/F+B1Y02TwOY8B+YY+1nIMkXV
         f4KdgV1tQGPjc11LRspaej3Z7Ruqd2ht3k7ZqcN8kI82O9fRL9cW2VVmWk/F6ys8YZ
         CJ9gwCPUmmL5iKPLANhXIBuwl1ZIzAxLhw5D4/qfYdEjHUVITEasTY5rjqPpUPl5/h
         wsHJTx9Xq932yQ2GN8Q87ZNzhuAM55W/FLwiOKx38K9RpUnieYdhtgI9I3Selzhxsh
         /kERbvX6p9m923C7Xg2XcRsI6J0ZVuUOb7fESdvQQDzUHcI1xUxie4LKdeQoy2PiRP
         W8lO1chV4OeUw==
Received: by mail-wm1-f69.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so277771wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JIs1xiYNpUGWLEtymgYGm7pSCxeAjzoS3yDzGjJPXvE=;
        b=ysbb6nutBDRv3YsMc4qNi9632qK4RYmdAG7WTDKn9Coirx9jN+T9Zp/IR8osTGyHTf
         j33o6fccXMHyup/Cw6rbj3/uTlqoZ0v/EkJztuuGIeBxEuihQCEgW61+kwGeP/Ih/9q/
         o9pIT3QSprZ0QYXRZWVuv7q7Q54/3DT05X5CoNeRQuOfnZEk95e+6y5KfECTg45mnvmO
         Rs4/7KZiUZ1izDsssZPU/bujgrHMvSRANCQQOOT/DclVFpTTpwuOsRsXXhICgP9INfAr
         1GsDNkebJkf0Dl02HMMBYYYmUVxkFwtsj/EvkTSAr/Yl6UCvMvj925dp83bm/UueAHmL
         Dzbg==
X-Gm-Message-State: AOAM53129IExXOnuJKsE4VWxFBhAVBU+TyplWQ+aJe77joJAgfnb+n+F
        044JWEQ+pWSpSb3769Jv+MogrtjlPcpmhgAJGmVCnql05SI7W8lWg2EDmuYthFdoTwxF6HsimAg
        U0Zo9ZtCT+UxJc/wDdWC9GKJtnlkf4ccCoEJJkAtMuA==
X-Received: by 2002:a05:600c:1c11:: with SMTP id j17mr606086wms.138.1644875368524;
        Mon, 14 Feb 2022 13:49:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKWcCqlvzOjQU6wfJEEKTCLPSGNxu0cNkLUzJsJZwJjpWyaSQuWK0i7UTurbPojjOb5bxVfA==
X-Received: by 2002:a05:600c:1c11:: with SMTP id j17mr606079wms.138.1644875368292;
        Mon, 14 Feb 2022 13:49:28 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id n7sm12982487wmd.30.2022.02.14.13.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 13:49:27 -0800 (PST)
Message-ID: <cf4e21e8-1ba8-a137-6063-00e1cee8e035@canonical.com>
Date:   Mon, 14 Feb 2022 22:49:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: ps2-gpio: convert binding to json-schema
Content-Language: en-US
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org
References: <20220211233137.99624-1-danilokrummrich@dk-develop.de>
 <20220211233137.99624-2-danilokrummrich@dk-develop.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220211233137.99624-2-danilokrummrich@dk-develop.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2022 00:31, Danilo Krummrich wrote:
> Convert the ps2-gpio dt-binding documentation to DT schema format using
> the json-schema.
> 
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
>  .../devicetree/bindings/serio/ps2-gpio.txt    | 23 --------
>  .../devicetree/bindings/serio/ps2-gpio.yaml   | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.txt b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
> deleted file mode 100644
> index 7b7bc9cdf986..000000000000
> --- a/Documentation/devicetree/bindings/serio/ps2-gpio.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Device-Tree binding for ps/2 gpio device
> -
> -Required properties:
> -	- compatible = "ps2-gpio"
> -	- data-gpios: the data pin
> -	- clk-gpios: the clock pin
> -	- interrupts: Should trigger on the falling edge of the clock line.
> -
> -Optional properties:
> -	- write-enable: Indicates whether write function is provided
> -	to serio device. Possibly providing the write fn will not work, because
> -	of the tough timing requirements.
> -
> -Example nodes:
> -
> -ps2@0 {
> -	compatible = "ps2-gpio";
> -	interrupt-parent = <&gpio>;
> -	interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> -	data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> -	clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> -	write-enable;
> -};
> diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
> new file mode 100644
> index 000000000000..ec6fa7b40851
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serio/ps2-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for GPIO based PS/2
> +
> +maintainers:
> +  - Danilo Krummrich <danilokrummrich@dk-develop.de>
> +
> +properties:
> +  compatible:
> +    items:

Hi,

I think you do not expect more compatibles, so skip "items".

> +      - const: ps2-gpio
> +
> +  data-gpios:
> +    description:
> +      the gpio used for the data signal
> +    maxItems: 1
> +
> +  clk-gpios:
> +    description:
> +      the gpio used for the clock signal
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      The given interrupt should trigger on the falling edge of the clock line.
> +    maxItems: 1
> +
> +  write-enable:

This does not look like a standard property. You need "type: boolean".

> +    description:
> +      Indicates whether write function is provided to serio device. Possibly
> +      providing the write function will not work, because of the tough timing
> +      requirements.
> +
> +required:

Also: compatible

> +  - data-gpios
> +  - clk-gpios
> +  - interrupts
> +
> +examples:
> +  - |
> +    ps2@0 {

Does it compile cleanly? You used an unit-address but there is no reg.

> +        compatible = "ps2-gpio";
> +        interrupt-parent = <&gpio>;
> +        interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> +        data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> +        clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> +        write-enable;
> +    };


Best regards,
Krzysztof
