Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B494D074B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbiCGTKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiCGTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:10:20 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2010BAE7B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:09:24 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5363E3F79C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646680163;
        bh=q8g4tYGCrxotRx9lTZBNqkxXceWtfikA4nvN9afKB+c=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=j+YNOxFQNGX6znocE4BIXsNfo81KHpVYkBNGsfQWpMCpz1yb7Ej3jVLU3macYsICd
         9iS/LyAPgeVHOZhOChO4RhyuAk4r85Y7becFdU9RtkVDuOdu88bsb/F/AS5a4X+N9B
         oaL/WGtqwVY2AMnQ5sIQao0aZeymQLy38AnQDFpPu4ZJM/o5LJGFG1toIrOz7uzmZC
         AeIAdrwOtlEv9/75wFLEP8wNHxpzw1QdtcWpsxVJF9OCwr0JfZOSlfYDrWGym1O0gy
         uLh9ObmQv3/xV4aC7+P3JG3LXYMP0lujXUnxQOMtid//gu6up+ALkeFwKPiuZMAYQ6
         shsTai4zm30jA==
Received: by mail-ed1-f71.google.com with SMTP id n11-20020aa7c68b000000b0041641550e11so2815118edq.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q8g4tYGCrxotRx9lTZBNqkxXceWtfikA4nvN9afKB+c=;
        b=2fTZNZzBjmY/i6qKn/iZ7HlukOoMMMevRXVWKZndQvoexwt9+mXVif96mjEenU+MHD
         x6HrCbow+eH4pPqoKYrrAqRfSRp5tf95GgiMhiCYGfyXAJHxiZYSblQR1Kkkf0G/vK4S
         m+T8keK3cU+rfC/7gZVQ7JmPXIjSxq0FiEU4Mew6Z8o9sG3M6E4IJEmizh1y4KY9NOAJ
         io3i4b5YvsPdlu+EOUnnmR70Ib5T2sfEiIMmDHUOA+7z6Gdy2oJokLBJLi8sWYA4dB2b
         BXfjJ0erWwVGVb5+DXx/wgMhXSPkb1XokuRHttJtEeEqa65ROkMSjChrz7WGZM7Lu2pn
         HXiQ==
X-Gm-Message-State: AOAM533DmPsNZS+V18nn5CGrtr1QcqdvDcEaPZOH9k6ZJvqhcDt4RS/V
        zuks60XqArSQXp8vIGtb8jByTgn7kixj02YhxWwGy7cnn7oI0Q4mqTQBLEiHlY8NT7QzEM1g16+
        RRimvaqiI/WHVkkPb/I5o8cb7VkgozMvBBg8ysInIpg==
X-Received: by 2002:a05:6402:d05:b0:412:e171:28d9 with SMTP id eb5-20020a0564020d0500b00412e17128d9mr12536692edb.169.1646680162877;
        Mon, 07 Mar 2022 11:09:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnXJsZ3tP6u8vL9bjGPK4PcYrTbamwIQwunSPQfwoOShUSR1G2G0NoifRaJxoa1506PQCoHA==
X-Received: by 2002:a05:6402:d05:b0:412:e171:28d9 with SMTP id eb5-20020a0564020d0500b00412e17128d9mr12536665edb.169.1646680162655;
        Mon, 07 Mar 2022 11:09:22 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906490700b006b2512921b2sm5042639ejq.48.2022.03.07.11.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:09:21 -0800 (PST)
Message-ID: <d9bcb4b2-3d8d-d695-2bec-8a05ba7249f5@canonical.com>
Date:   Mon, 7 Mar 2022 20:09:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 1/2] dt-binding: misc: Add iop yaml file for Sunplus
 SP7021
Content-Language: en-US
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        derek.kiernan@xilinx.com, Dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com
References: <cover.1646629400.git.tonyhuang.sunplus@gmail.com>
 <57d8c6d8ce52e7152156f2fcc4b61bfd2fed1c40.1646629400.git.tonyhuang.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <57d8c6d8ce52e7152156f2fcc4b61bfd2fed1c40.1646629400.git.tonyhuang.sunplus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 06:25, Tony Huang wrote:
> Add iop yaml file for Sunplus SP7021

subject prefix is "dt-bindings", not "dt-binding".

> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v10:
>  -No change
> 
>  .../devicetree/bindings/misc/sunplus-iop.yaml      | 76 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/sunplus-iop.yaml b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
> new file mode 100644
> index 0000000..b37e697
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/sunplus-iop.yaml#

Use file name in "vendor,name" format, so "sunplus,iop.yaml".

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus IOP(8051) controller
> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +
> +description: |
> +  Processor for I/O control, RTC wake-up procedure management,
> +  and cooperation with CPU&PMC in power management.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-iop
> +
> +  reg:
> +    items:
> +      - description: IOP registers regions
> +      - description: PMC registers regions
> +      - description: MOON0 registers regions
> +
> +  reg-names:
> +    items:
> +      - const: iop
> +      - const: iop_pmc
> +      - const: moon0
> +
> +  interrupts:
> +    items:
> +      - description: IOP_INT0. IOP to system Interrupt 0.
> +                     Sent by IOP to system RISC.
> +      - description: IOP_INT1. IOP to System Interrupt 1.
> +                     Sent by IOP to system RISC.
> +
> +  memory-region:
> +    maxItems: 1
> +
> +  wakeup-gpios:
> +    description: When the linux kernel system is powered off.
> +      8051 is always powered. 8051 cand receive external signals
> +      according to this gpio pin. 8051 receives external signal
> +      through gpio pin. 8051 can power on linux kernel system.

How many items (maxItems)? Unless Rob already asked about it...

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - memory-region
> +  - wakeup-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    iop: iop@9c000400 {
> +        compatible = "sunplus,sp7021-iop";
> +        reg = <0x9c000400 0x80>, <0x9c003100 0x80>, <0x9c000000 0x80>;
> +        reg-names = "iop", "iop_pmc", "moon0";
> +        interrupt-parent = <&intc>;
> +        interrupts = <41 IRQ_TYPE_LEVEL_HIGH>, <42 IRQ_TYPE_LEVEL_HIGH>;
> +        memory-region = <&iop_reserve>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&iop_pins>;
> +        wakeup-gpios = <&pctl 1 GPIO_ACTIVE_HIGH>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7..6f336c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18242,6 +18242,11 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS IOP DRIVER
> +M:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml

Wrong path.

> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>


Best regards,
Krzysztof
