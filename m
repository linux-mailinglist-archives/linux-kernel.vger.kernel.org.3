Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637D34B9C74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbiBQJtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:49:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiBQJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:49:38 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC50A17AB8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:49:23 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B2AD1402E6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645091362;
        bh=0007Apij4GTvZKW9DpvkDPnqD/lKERk9VeBYhgBTloo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=gEvoi+q9S6bpfGIYZuz7OgTKtpwQ/zOH+Fcn9rf4XdkGIeJyYDXUbvS+dm5kYGFkx
         +UDIHt5lVAFht2Ag2vcIWSOfRl40t4GC7bPZbl7HqONIqDLN4a14zKDL3fii4BBWoQ
         4AKZSkcCKpG8yK4cQpGhdFPt3MFBeyHPnGuP2kI52JnwYtkn9+eUKIIDRcld2Imbd1
         CxOS09cBgwIdZlu9oniLhEz4QXNTCI7FiwUnhyFBWqZgA2B/w8KS+UxjX/bXUJM4bH
         4RY/TzxWgtbeG1NFZLzFOpJjPVdrP10zt+zEgnwgWVmTL9L4V4bFJRpf8u6RxpP2YE
         /hvTlL8CDGJng==
Received: by mail-ej1-f69.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso1237970ejc.22
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0007Apij4GTvZKW9DpvkDPnqD/lKERk9VeBYhgBTloo=;
        b=MO9mGN+pTEZrmuNSqvRrFhsprt73pXGrwP8sSUiNAFQKR8t8sHzQ1xlq+dYsmL9J+d
         e4JHbtvy079uhe6DbbWEOEGgye21ftP9XFupdAY+SntaU86EQuXf4EVqPoEwC89Ne1ED
         RvvZQn45MT4fDfOmFbg1xc7Aw9en1SCx9DTV853b6fY/DKzcun4ZjxlCEKPTrZzD2yOR
         KJQ6kKdLpzOYAWBswjaNlPxcAcWrdOxxlctJYd64GxGl+UEILQvfH3XpKqXJelNLGcTT
         TGdxBV1+SaoTesjYhz1YA+HvQFFWNcdSTo0eg12cjZ4vevH7Pbt1Wi9GEwA5FLTobQeC
         4ydQ==
X-Gm-Message-State: AOAM530YXCmq/BDF7qpAs3fYDypOh3YneCmE4CL+Thia7CbMsNe25Oh0
        WCvnwNld5eY4L2HtBCdYI9sWEV8CfyeId8zHUwimASNU/5VenzRxAO4SURkGOAVFumWlLk58ewq
        F5oUjRY8zEYueSzHJLgOgdqXM0TaJtsKhuhE/U59dDg==
X-Received: by 2002:a17:906:9489:b0:6ce:f3a9:2c17 with SMTP id t9-20020a170906948900b006cef3a92c17mr1738780ejx.333.1645091362236;
        Thu, 17 Feb 2022 01:49:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyU4GL/xCZfq3R/yQUHRTYFTi2oBY1a8OUofVqY7Z2aF3QmZxKjn4JOmkoChKC3hfRIIHrggQ==
X-Received: by 2002:a17:906:9489:b0:6ce:f3a9:2c17 with SMTP id t9-20020a170906948900b006cef3a92c17mr1738761ejx.333.1645091362031;
        Thu, 17 Feb 2022 01:49:22 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id ha3sm985555ejb.157.2022.02.17.01.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 01:49:21 -0800 (PST)
Message-ID: <f50f6502-2132-7665-a61b-64c15760a420@canonical.com>
Date:   Thu, 17 Feb 2022 10:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] [v1] dt-bindings: timer: Add HPE GXP Timer binding
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <nick.hawkins@hpe.com>
 <20220215181936.41551-1-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215181936.41551-1-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 19:19, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Description: Creating binding for the GXP timer to be used in device tree.
>  GXP is the name of the HPE SoC.
>  This SoC is used to implement BMC features of HPE servers
>   (all ProLiant, Synergy, and many Apollo, and Superdome machines)
>    It does support many features including:
>         ARMv7 architecture, and it is based on a Cortex A9 core
>         Use an AXI bus to which
>                 a memory controller is attached, as well as
>                  multiple SPI interfaces to connect boot flash,
>                  and ROM flash, a 10/100/1000 Mac engine which
>                  supports SGMII (2 ports) and RMII
>                 Multiple I2C engines to drive connectivity with a
> 				 host infrastructure
>                 A video engine which support VGA and DP, as well as
>                  an hardware video encoder
>                 Multiple PCIe ports
>                 A PECI interface, and LPC eSPI
>                 Multiple UART for debug purpose, and Virtual UART for
>                  host connectivity
>                 A GPIO engine.

Same comment as for other patches.

> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/timer/hpe,gxp-timer.yaml         | 45 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> new file mode 100644
> index 000000000000..1f4e345c5fb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/hpe,gxp-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP TIMER
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-timer
> +
> +  reg:
> +    items:
> +      - description: T0CNT register
> +      - description: T0CS register
> +      - description: TIMELO register

That's a bit odd - you pass each register as device address space. Why
not entire address space of the timer block? Probably you have there
more registers, don't you? In such  case what if you need to access that
additional register - change bindings?

Or maybe all these registers can be put in entirely different address
ranges?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description: The frequency of the clock that drives the counter, in Hz.

I would expect here also "clocks" and "clock-names" properties, since
you clearly have a clock that driver the counter.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    timer@10003000 {
> +        compatible = "hpe,gxp-timer";
> +        reg = <0xc0000080 0x1>, <0xc0000094 0x01>, <0xc0000088 0x08>;
> +        interrupts = <0>;
> +        interrupt-parent = <&vic0>;
> +        clock-frequency = <400000000>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f41088418aae..8c2c1e8e0934 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8385,6 +8385,12 @@ L:	linux-efi@vger.kernel.org
>  S:	Maintained
>  F:	block/partitions/efi.*
>  
> +GXP TIMER
> +M:	Nick Hawkins <nick.hawkins@hpe.com>
> +M:	Jean-Marie Verdun <verdun@hpe.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> +
>  H8/300 ARCHITECTURE
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  L:	uclinux-h8-devel@lists.sourceforge.jp (moderated for non-subscribers)


Best regards,
Krzysztof
