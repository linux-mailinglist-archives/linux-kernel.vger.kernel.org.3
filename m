Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891C54D5F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiCKKVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347768AbiCKKVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:21:12 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49150184635
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:20:08 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8D5233F19E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646994007;
        bh=H1wnHRt8J8X/ob3OQthhVS9Z7EDtH40aoB6H8WTQYjg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=boRGe6WCPfBPSxk6+EoJTc4OyEu2hweyLdO1tVj7ArKCKzWuRjs6MSkfPYzawwyfg
         7rr06icY2KxZBh52JueC+giJkQXbOiboQ2C4xefJn/ED0i5lEBqz6EhdO+EESLXE4N
         c+u9EHniX3g0eTTXDeas/DP21zxiTHbQPUl+NIdp2n9OHfhab8gecso2Gcndnj+9y7
         m7P40NOE8cD9QsM9tD9uwdLS375ErSReKPHl1BX96fxS77FuvIAlNgJRxA6Xuo2i/O
         8v4QC6DMmp7QwsW72bYGSpr9u2tVx8CkzKyl747FEAWJxqf/BXpXH+OyIffdDp/72X
         KviEI0mEQrQTw==
Received: by mail-ej1-f70.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso4684992ejk.17
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H1wnHRt8J8X/ob3OQthhVS9Z7EDtH40aoB6H8WTQYjg=;
        b=mrCIf42J9er7Mqs8zbI7CteNmQKTjXVzRsLewt013/NGlbXfZA3n74o3RoTMDUkkkE
         zAYDLZsJwfgwhU4krmSxQA8Dkar8AJNiZ8A33NyU99YcqpLlLsDvewCKSe3ubHG/rc2l
         H1uYu7Ny2bG5kG55DJxAQoYUqEfKpSmIwH0RGr6jWaijKYq5G249BKvGCEcqPyiRnHFj
         IVa1L9foC8sEiJzzDnEQNUUoti4xlVfA2kXch0/9N+EZQ6872Wg4DcWvX0MQueHXP1YG
         M2xxTCBDxfaFMVjkmaDPb0SyWpz4ko4XbhpNiC3zRJ2dlGA0lzEnwbS5g7egL/ejgo3g
         W6jQ==
X-Gm-Message-State: AOAM531z2Yy89bAxFOBAshmcnch6kRTzwHiLecKU+mqrE0gcQ2fKSxnA
        TMLtyiKewBZdNH5Ci4j+UoXnjRrG+petrF4eNLYhCLyISaLuCOJfTWSYBHOB0OvRplIZWXS2DCq
        mngb2AipHoot51flacL/idEBTHf231uOf6ebTWCg0PA==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr7931340ejs.105.1646994007160;
        Fri, 11 Mar 2022 02:20:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSSYYuWIMhX7NHr3FpazdL++adHH2b9bRncGzPn5be0G1SHIFveA0iH+QlXkzjH+ku2ai7Tw==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr7931326ejs.105.1646994006965;
        Fri, 11 Mar 2022 02:20:06 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709063f8e00b006ae0a666c02sm2790266ejj.96.2022.03.11.02.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 02:20:06 -0800 (PST)
Message-ID: <8b2deefd-032d-65f0-cebb-d18cc11faf5a@canonical.com>
Date:   Fri, 11 Mar 2022 11:20:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 07/10] dt-bindings: arm: Add HPE GXP Binding
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-7-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310195229.109477-7-nick.hawkins@hpe.com>
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

On 10/03/2022 20:52, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> This adds support for the hpe,gxp binding. The GXP is based on
> the cortex a9 processor and supports arm7.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../devicetree/bindings/arm/gxp.yaml          | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/gxp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/gxp.yaml b/Documentation/devicetree/bindings/arm/gxp.yaml
> new file mode 100644
> index 000000000000..edfd331c493e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/gxp.yaml

Missing vendor prefix in file name, so "hpe,gxp.yaml"

> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/gxp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE bmc GXP SoC driver

Driver does not fit here. I think you are adding HPE GXP platforms? If yes

> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp

This is not proper SoC/boards description. Look at intel,keembay.yaml
for example.

You also miss here other compatibles - for board(s).

> +
> +  "#address-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +
> +additionalProperties: true
> +
> +examples:
> +  - |

Skip the example, platform bindings do not have them.

Best regards,
Krzysztof
