Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ABF4B73AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbiBOOyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:54:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiBOOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:54:08 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EABAF1D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:53:56 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 098EC3F1E8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644936829;
        bh=nPMJHTnYZbzS8znk5AsEiCmewu+zF2DU271/1BBA6Eo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pgRbLzC7Vma+2T8v8tH4OvJds0ho/7egymd3saiOKXwwXSX61jtQweMxveFjob4dv
         kh3XAf7kP6zlVfNIVT23jwUnu08ia97GcUtVWdCnH4sP1WNHqV7vWZ+F5c54nGcQBI
         z2HmQgeJNv1KDHqWGlgk6DqqjSXYERtHaIdJh6mN5yJdoKg4+jqMMgeE/suR817taD
         drevrlMBF9I0Ax918bdQdeyjn7q0zLSeLlJnt+q6+vRbtp638nxKnzV2TUXAdATGtu
         q2TB8+9u0kKc6UAzicSq+nTG9vfktlSVikLjOO99BlOtEiBevb1H5Qxc7VrSl6NLq9
         sCYXp0T/AxVGw==
Received: by mail-wm1-f71.google.com with SMTP id h82-20020a1c2155000000b003552c13626cso1522148wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nPMJHTnYZbzS8znk5AsEiCmewu+zF2DU271/1BBA6Eo=;
        b=DnZVKaUBIA9w68V3pKZUxOR4TsZ5Ns2UGZ2dhxLwYJHmIGWrWYs95qIoBva2E7wOmk
         ADBFPpmz7jCbp9uHG8MM+ZNfOzEtn/2d02itxOPD4SkkGtvKsRSikX1zEQfrw0YDHBmk
         IHw/kJOYlwcaFUGkiOe/qpfSKTdpRIi1MKAwcFSsI/VX6MFzaBCQsKR9XVY9T3A+N3yI
         Ki+5zUoIh1RDhmkOU32Nt5fjgErSmE9AsgZbeq6hIUuQ1bUxRAXKtKh3xn0oQWkCogrF
         6LSuOYSPZIZvRLkzGoKKabPav8+xU/93mqaeZZLrasM9pJ6mBCKZy95VaBKN2PH4X3K7
         l/6g==
X-Gm-Message-State: AOAM533aRBWD4r6G1FwVjOwkOE+8nB8OAUQmlmSXYTLnzRHbviQaKOTt
        tWgn1wU501meVLBjZ5pS7S61kdc/3KkR8iVu60b6xXnbZt0p4scDoroMe20eeeLQUOCWfC2b4iD
        kzJjWffwd4566tNwopZdeGe02sKb+XY/QX67+QhTesA==
X-Received: by 2002:a05:600c:34c4:b0:37b:f84d:d55a with SMTP id d4-20020a05600c34c400b0037bf84dd55amr3308662wmq.123.1644936828657;
        Tue, 15 Feb 2022 06:53:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwon3JF6xxLKESk658q0+LTv95ZfTFy8vR9jXtExV/jZEWdqZ1UK6aKau2J/Bpu24pZQ9e+pQ==
X-Received: by 2002:a05:600c:34c4:b0:37b:f84d:d55a with SMTP id d4-20020a05600c34c400b0037bf84dd55amr3308637wmq.123.1644936828425;
        Tue, 15 Feb 2022 06:53:48 -0800 (PST)
Received: from [192.168.0.108] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r2sm19588933wmq.24.2022.02.15.06.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:53:48 -0800 (PST)
Message-ID: <b50bf9ef-eb38-8e86-70f9-7a9a959be67b@canonical.com>
Date:   Tue, 15 Feb 2022 15:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 1/2] dt-bindings:serial:Add bindings doc for Sunplus
 SoC UART Driver
Content-Language: en-US
To:     Hammer Hsieh <hammerh0314@gmail.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com
References: <1644917065-23168-1-git-send-email-hammerh0314@gmail.com>
 <1644917065-23168-2-git-send-email-hammerh0314@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1644917065-23168-2-git-send-email-hammerh0314@gmail.com>
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

On 15/02/2022 10:24, Hammer Hsieh wrote:
> Add bindings doc for Sunplus SoC UART Driver
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> ---
> Changes in v8:
>  - no change.
> 
>  .../bindings/serial/sunplus,sp7021-uart.yaml       | 56 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> new file mode 100644
> index 0000000..894324c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Sunplus SoC SP7021 UART Controller Device Tree Bindings
> +
> +maintainers:
> +  - Hammer Hsieh <hammerh0314@gmail.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-uart
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
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    aliases {
> +            serial0 = &uart0;

Incorrect indentation. With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
