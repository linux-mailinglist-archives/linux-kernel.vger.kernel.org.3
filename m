Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC1F4B75AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiBORXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:23:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiBORXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:23:21 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9BBD997C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:23:10 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0ED583F1E3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644945789;
        bh=J2RC8uRwGZxu0ITv5Oc24iDHow2sld0bRthayL1DVws=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EfjhSPlWMi8Zlu3ZzNkpw6tFTBeOF5UruQ7g1sWPa1gVOIMXfdl2mkUGTqqziWmb9
         l3tBP+BX7YQWQsJMNyLx1pO1O21MVdyJqEWTz8i4WfZn8jtD2oJcEFDo8c/QSUTLTW
         4lfJ/OYMsecKvd38/DWzxnz3RtRIzVz7RJYNv1UVk9pWmU5sK/qBslgUL4qj0Lh0QI
         zKnk34QAnSEN06RvLh5u/9Kx+W/s1kdYJJxBduOqMH3fAfzJ4wIr5bA5uSlZ3oyukg
         gYxiNnnHYP4lEPPZHLOAQA7zSwVCUYlzs9GPihYZXmdbGrewkKN9cmiXrv2+YDOvCV
         Q2h0/x+D/EofQ==
Received: by mail-wm1-f72.google.com with SMTP id j39-20020a05600c1c2700b0037becd18addso813624wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J2RC8uRwGZxu0ITv5Oc24iDHow2sld0bRthayL1DVws=;
        b=Qbn1AdjeOEak3Ltq9FCAIGcUzhz8TW9S0ITCk/ahxPVH9GZw59ck2n1G5xBk/tmNuf
         dhFyfA8zPcl21hCZr3zCpy5wj1qGlJF7PGp7MaFBrNfKkeBk/lfdNZDYOxBgZYvzihS5
         kFQr1Yki3j1H9w5PrIC1mwGOv042QKrbIhsIhJZdW0RTSaztXwcjFeaDmRSbBlm+rqOZ
         HoWlpnBX7JOCDQa25YeHABRHrczDu8JB/MfwUCgPRebnRqBoYQiLyhXC9uDN36ZMXLQy
         6K2ML8LqvGLnyAYSGpIzic0AiYkVKLfTjI31iGgzs2civ6slp9FjUJlkh/TiVZ4bfsMJ
         nx+w==
X-Gm-Message-State: AOAM531LW03SqCyZyDoTNzl3P2A0/qFs7U/ek60aymqzc6dRu/qsAZXW
        WXSjpo/8pC6DP3rOMLl9dBNVGaqqk2RjAUNsfnlwQF4jSweWT8UHlb55HVb1sQ5zuu+Fr5Rz3BT
        br8WpfOnRNNBJQCmOenGdqCJmZXbBo4o8xnDrICVY3A==
X-Received: by 2002:a05:600c:286:b0:37b:ec4c:17f8 with SMTP id 6-20020a05600c028600b0037bec4c17f8mr3914971wmk.25.1644945788677;
        Tue, 15 Feb 2022 09:23:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxH2G/642pC8xPJz6RDECuqTwP05xuddosbqo4gw0jlJ+Mcmwky2nt8QFtKTu3YyT9FhA/Ugw==
X-Received: by 2002:a05:600c:286:b0:37b:ec4c:17f8 with SMTP id 6-20020a05600c028600b0037bec4c17f8mr3914945wmk.25.1644945788452;
        Tue, 15 Feb 2022 09:23:08 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o4sm14463378wms.9.2022.02.15.09.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:23:07 -0800 (PST)
Message-ID: <21ce5bf5-1e69-4112-8322-e65c8bccb353@canonical.com>
Date:   Tue, 15 Feb 2022 18:23:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220215144649.14378-1-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215144649.14378-1-sergiu.moga@microchip.com>
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

On 15/02/2022 15:46, Sergiu Moga wrote:
> Convert RTC binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/rtc/atmel,at91sam9-rtc.txt       | 25 --------
>  .../bindings/rtc/atmel,at91sam9-rtc.yaml      | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> deleted file mode 100644
> index 3f0e2a5950eb..000000000000
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Atmel AT91SAM9260 Real Time Timer
> -
> -Required properties:
> -- compatible: should be one of the following:
> -	- "atmel,at91sam9260-rtt"
> -	- "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt"
> -- reg: should encode the memory region of the RTT controller
> -- interrupts: rtt alarm/event interrupt
> -- clocks: should contain the 32 KHz slow clk that will drive the RTT block.
> -- atmel,rtt-rtc-time-reg: should encode the GPBR register used to store
> -	the time base when the RTT is used as an RTC.
> -	The first cell should point to the GPBR node and the second one
> -	encode the offset within the GPBR block (or in other words, the
> -	GPBR register used to store the time base).
> -
> -
> -Example:
> -
> -rtt@fffffd20 {
> -	compatible = "atmel,at91sam9260-rtt";
> -	reg = <0xfffffd20 0x10>;
> -	interrupts = <1 4 7>;
> -	clocks = <&clk32k>;
> -	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> -};
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> new file mode 100644
> index 000000000000..c78a8c1c9314
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/atmel,at91sam9-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel AT91 RTT Device Tree Bindings
> +
> +allOf:
> +  - $ref: "rtc.yaml#"
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - const: atmel,at91sam9260-rtt
> +      - items:
> +        - const: microchip,sam9x60-rtt
> +        - const: atmel,at91sam9260-rtt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  atmel,rtt-rtc-time-reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Should encode the GPBR register used to store the time base when the
> +      RTT is used as an RTC. The first cell should point to the GPBR node
> +      and the second one encodes the offset within the GPBR block (or in
> +      other words, the GPBR register used to store the time base).

The first cell points to a phandle, so this does not look like
uint32-array. I think this matches something like syscon. Look for
example at samsung,sysreg:
Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml

> +    items:
> +      maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - atmel,rtt-rtc-time-reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rtt@fffffd20 {

Is it a timer or a clock? If more like a RTC, then the node name should
be "rtc".

rtc.yaml requires this, so it looks like you did not test the bindings
at all?

> +        compatible = "atmel,at91sam9260-rtt";
> +        reg = <0xfffffd20 0x10>;
> +        interrupts = <1 4 7>;
> +        clocks = <&clk32k>;
> +        atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +    };


Best regards,
Krzysztof
