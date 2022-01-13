Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD048D825
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiAMMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:40:40 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50820
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232977AbiAMMki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:40:38 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D2FCF3F198
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642077637;
        bh=NtF9Qcv8dCyv4imQqdPZ0gphBbiJgf6BkMwibu0qdek=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FylfRzFpYWYgd4WO09AQsPJqT5Q1Ge7coeHBZga3wuxwXc2pUqBtINPpHyQkh5mbF
         Q2hmNQOuK7lk6TAJ0wVYyPnJCmJ3PRV2QilTTkRgDU8Xn6oPKKTYP/dHXw3FcT7wvV
         KgiP0gTBbg/AcgEGSwu4FTriqdMU1Nl46Wcql9FomQViOjrThtg1EBARDEJndnH0nL
         LlZNysBO3TuD9KHm52N6FAr8Qhje1+5ihw0yCJ5cL7+LEeSr3gF3Vj0xvr2zzu439J
         0ZDTKrNbv53U7UhsyUCNQu1Q7yp4/VLJgNppWQuEtA547Jx3Y75VIaTzk8leaS+2yg
         MqsxOSBIo5sqg==
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso5215499edd.14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NtF9Qcv8dCyv4imQqdPZ0gphBbiJgf6BkMwibu0qdek=;
        b=frJ7IxQ/c79J53DFDf7Lb2AFrpOFf79Udt3BuF0QBkWe69xz6t35pbxMO5FTEiE6FO
         vzxldLgZjN5cRmWPAt7YhV9QFcHyI9yoFY5FicZXU1DqMiJDsC3dVmDqzgX1CDooLxBP
         /58xKgiLwLtbB6BS5tbHr6lecMZIEuAYJjG3+/TdToTpxNjGzMrj0VkaCiooRtV6MZDe
         Dn3xMtVraKwWaYe4TV693jIn/apAn4Dcy98lZgrHVvuWmgkV4aY9LRDSMD79QTrdhRnC
         nyTt+38w/czIvxRNOkoe6gFOG6oLn2SvSWVfTYbUfNi8sjCRMJINFEjcikmXA4UuUxQd
         0zSQ==
X-Gm-Message-State: AOAM5301lUhCbM2qh7nAR3Qbwh9i8gMvrwi6Dfs35qRdi4YS8TmiT6Ov
        D3tcKcXiOLkBMAtSGN8hbkbjA37m/q2vL+9lSj8LvKgmaRVB2XYI/SV3Yt6Py92VcUmfiadIJJ3
        6fg92CIghfNYsaBhDQGVQIAf0JMs8rfimujuBZ8Jmjw==
X-Received: by 2002:a05:6402:655:: with SMTP id u21mr4010428edx.30.1642077637575;
        Thu, 13 Jan 2022 04:40:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzysO4hAvoMYoJ/ruIH66z8VzH4bfZ21Ozb1u+/RRfHvZ0YP4DJm75J85RG/HrmE+6HlqV7UQ==
X-Received: by 2002:a05:6402:655:: with SMTP id u21mr4010406edx.30.1642077637409;
        Thu, 13 Jan 2022 04:40:37 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id sa13sm858440ejc.28.2022.01.13.04.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 04:40:37 -0800 (PST)
Message-ID: <c87f500e-e43e-465c-94fa-050c2b0de083@canonical.com>
Date:   Thu, 13 Jan 2022 13:40:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 01/23] dt-bindings: clock: Document FSD CMU bindings
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122311epcas5p4b7c253b49dce3bd3580407fcf312e70e@epcas5p4.samsung.com>
 <20220113121143.22280-2-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113121143.22280-2-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 13:11, Alim Akhtar wrote:
> Add dt-schema documentation for Tesla FSD SoC clock controller.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  .../bindings/clock/tesla,fsd-clock.yaml       | 212 ++++++++++++++++++
>  1 file changed, 212 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
> new file mode 100644
> index 000000000000..58f341e5004d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
> @@ -0,0 +1,212 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/tesla,fsd-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tesla FSD (Full Self-Driving) SoC clock controller
> +
> +maintainers:
> +  - Alim Akhtar <alim.akhtar@samsung.com>
> +  - linux-fsd@tesla.com
> +
> +description: |
> +  FSD clock controller consist of several clock management unit
> +  (CMU), which generates clocks for various inteernal SoC blocks.
> +  The root clock comes from external OSC clock (24 MHz).
> +
> +  All available clocks are defined as preprocessor macros in
> +  'dt-bindings/clock/fsd-clk.h' header.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - tesla,fsd-clock-cmu
> +      - tesla,fsd-clock-imem
> +      - tesla,fsd-clock-peric
> +      - tesla,fsd-clock-fsys0
> +      - tesla,fsd-clock-fsys1
> +      - tesla,fsd-clock-mfc
> +      - tesla,fsd-clock-cam_csi
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 6
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 6
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: tesla,fsd-clock-cmu
> +

Nitpick: Drop the white-spaces between if-then. It's easier to spot the
if-blocks if they are together.

> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: External reference clock (24 MHz)
> +

Drop this whitespace as well.

Rest looks good to me, except the discussion about the compatible.


Best regards,
Krzysztof
