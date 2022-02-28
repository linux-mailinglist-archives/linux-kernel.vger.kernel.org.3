Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE39C4C64EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiB1IiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiB1IiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:38:04 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3FE21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:37:26 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t14so7861534pgr.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ynGg2zlkHSS5uUPpWwSzbItTsNZH58rQZbqFZgztoM8=;
        b=d6Jbu3CdNMQsazBWSswdFlX71jnvC2OzDQGnpcQZy4hY/VRq9htwILWHKHCRNwZlxb
         QABfwFHLEdSErqzIA/52v8X7D3XrCb3BNY2JgUMD7Q6rx8gehHo+kCpq+XGvlK9QfL69
         FiDE7h4eTRtJui+POeOn3ysa2z+AG2hfDQShJSUIQ3736J4/abxiIVRZrKH/D4Jb3V3Q
         1zCYQ4dDurH/m/dGd8oKofgHpXCcIAAn4gVZOm6DEEzIXjFf4fvDu15pHOMKHE3FQNDr
         hCxCdSm/1Hzciq3mJh5CbJdc3X25E7T4WvnLmAP/p9/fTCrUbb0SYThu+vVDTFwLxf76
         iOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ynGg2zlkHSS5uUPpWwSzbItTsNZH58rQZbqFZgztoM8=;
        b=a738N/9IXoDrQDpVnzSLy8qy1T6j1kGTYh0ZBtdq6le3bO0hJ8Gc4ZXe+PXCMbxgYX
         a8uNcj8G33v47iTX5ByNNmBh0SApqSo0hx4EoJDvqJhcQNFWc37XIuNkCvrJGCyE2fzM
         H9lIPyuiwes2GvvlZCo/klFxtf4+9bo4ryaB8ck4urdtRTRloEHkAwk29UiatUZfJHVI
         iq9wf1qtAkfncTewpvQ7CqkeTlolR2FzAPyOkvgrxNsVacj6d1QXngCe+AuCX+n2hlZm
         +5cRCLB3LYWdC+iUnTNZ1DHzb82fMblnPWEM3g2GHe9tZGd4rO9/FlfQ7V+9maPcwsBe
         h0Pg==
X-Gm-Message-State: AOAM531rYNxWMwSKEa5AbGwBOSgfHQf/XtI80aoNF0Z5tXI5cNa5gWFv
        HiveSMAkA20L4cwgCf9sd3Dr
X-Google-Smtp-Source: ABdhPJxF+kaqGPpgvaKP8k/NA35bIq5wvbaZuNcwU5y8NraOPitDfJywFHd8kXd9QvuiAE9PG9faOw==
X-Received: by 2002:aa7:8d08:0:b0:4e1:5fb5:b15 with SMTP id j8-20020aa78d08000000b004e15fb50b15mr20191752pfe.70.1646037445811;
        Mon, 28 Feb 2022 00:37:25 -0800 (PST)
Received: from workstation ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id m6-20020a056a00080600b004e1bb196743sm13345953pfk.5.2022.02.28.00.37.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Feb 2022 00:37:25 -0800 (PST)
Date:   Mon, 28 Feb 2022 14:07:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Convert rda,8810pl-timer to YAML
Message-ID: <20220228083721.GA12451@workstation>
References: <20220225173734.GA7573@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225173734.GA7573@standask-GA-A55M-S2HP>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 06:37:34PM +0100, Stanislav Jakubek wrote:
> Convert RDA Micro Timer bindings to DT schema format.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  .../bindings/timer/rda,8810pl-timer.txt       | 20 --------
>  .../bindings/timer/rda,8810pl-timer.yaml      | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 48 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> deleted file mode 100644
> index 4db542c9a0fd..000000000000
> --- a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -RDA Micro RDA8810PL Timer
> -
> -Required properties:
> -- compatible      :  "rda,8810pl-timer"
> -- reg             :  Offset and length of the register set for the device.
> -- interrupts      :  Should contain two interrupts.
> -- interrupt-names :  Should be "hwtimer", "ostimer".
> -
> -Example:
> -
> -		apb@20900000 {
> -			compatible = "simple-bus";
> -			...
> -			timer@10000 {
> -				compatible = "rda,8810pl-timer";
> -				reg = <0x10000 0x1000>;
> -				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
> -					     <17 IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names = "hwtimer", "ostimer";
> -			};
> diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
> new file mode 100644
> index 000000000000..f9043a4488d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/rda,8810pl-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RDA Micro RDA8810PL Timer
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: rda,8810pl-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: hwtimer
> +      - const: ostimer
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    timer@20910000 {
> +      compatible = "rda,8810pl-timer";
> +      reg = <0x20910000 0x1000>;
> +      interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
> +                   <17 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "hwtimer", "ostimer";
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d5c2c035f82..cbf91f0ecbfb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2563,7 +2563,7 @@ F:	Documentation/devicetree/bindings/arm/rda.yaml
>  F:	Documentation/devicetree/bindings/gpio/gpio-rda.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
>  F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.yaml
> -F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> +F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
>  F:	arch/arm/boot/dts/rda8810pl-*
>  F:	drivers/clocksource/timer-rda.c
>  F:	drivers/gpio/gpio-rda.c
> -- 
> 2.25.1
> 
