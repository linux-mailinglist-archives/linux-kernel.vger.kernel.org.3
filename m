Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F8A4B9C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbiBQJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:38:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbiBQJiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:38:25 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA811E2B00
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:38:10 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 131A33F33A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645090689;
        bh=y6Nkkbmu0HsjTmD9yEjGCtDqCQXbFI6a1gbz1pxMHPQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=H/U4S2N56jO0/vAPie8ms9ocD0CzpkA4lJ7IGWlvIlWopAZXFPb2wr7a++Jw9lpHG
         DH3niVL3O+Q9JW5YS51HTQ+uFoIciGJkjrVZmjYLH/exd4PD3CzEvT1Hz9hOu7eVIQ
         SLTBQoHBjsCmVKk2YgI207zXVUQh4m0sCUdGbDqpwH9Ea4BoWZFiqfxdDsXlgz8E+T
         2/lmc+Q9q5B3leZM5YUbxVtF8X5zx+8gAfckbMEU87ukeuQ3U9lEAjJzHkyJy9fCV8
         85urBujncCj44ZnFbp3jDojWUZ4bpbsrQY1KHCZ6UzR4EapghWSl/gGrVJSDUEqlC5
         GduNZXBQhkXeA==
Received: by mail-ej1-f70.google.com with SMTP id k16-20020a170906971000b006d0118d857aso1239165ejx.14
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y6Nkkbmu0HsjTmD9yEjGCtDqCQXbFI6a1gbz1pxMHPQ=;
        b=AqyPY1kggfbd8Czi0IurUrSyN10iLnLtFE32/pD1ksqb8p/caqxCGQXadRgDTrZRjv
         G3ZjWX8FhKneadBiijUJc06CBb6Jrt0QdLLN99B4IxRt7YxljTJ+StnhY6OMtC1UQsv1
         t0WaEdjbJMCbl0qj+uTdU7WDTQ6IdViWrGTm3yHLEheS5MK9USVySV7M3B+ZOe03dQfh
         kQpc0wpRKXFDJBvKX2ijBeYhpH9QeqvTcZ8Ef9FiP9TmPaHlBRH9OmPThS7xDKOeeDjM
         wFGrwmXy20MeWCsObKmMR8myqw0eOJDXYk8+4OpPJ5eSNnxlWwVnPMFG8UaegHmOckUB
         zM+A==
X-Gm-Message-State: AOAM5321/TbJ5gwcLHCZpzx/XVt+uSulgp0+jIzu9p8NHL/Sof9Dd90O
        s8Lr+G7qpCFxUH6y13OA98Hwtmx17kIqk/1pvv2h+ku/bt4IdiYHOCH3FgB72zNq19xDr+1JgkU
        Dfmvz+IDibu7qCPfmvqDqKn96zbdKPgRzMWa84UF7OA==
X-Received: by 2002:a50:dacb:0:b0:410:a06e:cf84 with SMTP id s11-20020a50dacb000000b00410a06ecf84mr1735098edj.176.1645090688552;
        Thu, 17 Feb 2022 01:38:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5O20i4iyuSkXfEe3ip1bLauV9NDr3fCwRTfEttd2QnBsmaH3ZSBcrjabieGiFfuRnNN4d7Q==
X-Received: by 2002:a50:dacb:0:b0:410:a06e:cf84 with SMTP id s11-20020a50dacb000000b00410a06ecf84mr1735084edj.176.1645090688356;
        Thu, 17 Feb 2022 01:38:08 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c11sm3168345edx.42.2022.02.17.01.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 01:38:07 -0800 (PST)
Message-ID: <b3284840-0f2a-89ff-8525-6a77f6ff7063@canonical.com>
Date:   Thu, 17 Feb 2022 10:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: soc: Add HPE GXP SOC binding
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <nick.hawkins@hpe.com>
 <20220216181434.41682-1-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220216181434.41682-1-nick.hawkins@hpe.com>
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

On 16/02/2022 19:14, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Description: This binding will be used in creating the HPE GXP
>  architecture. GXP is the name of the HPE SoC.
> This SoC is used to implement BMC features of HPE servers
> (all ProLiant, Synergy, and many Apollo, and Superdome machines)
> It does support many features including:
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

You need to do something with this indentation. It's unreadable. Please
look at git history to see how other people are writing longer commit
messages. Some examples of lists:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1deab8c8abe3a167142ddc080995d36a321ace60
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0a9f6487f96e746f129f15216eb8cba2bbd7c36a
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6b17743d934ecb5c7b3429c601a04f8fd254013f

> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../devicetree/bindings/soc/hpe/gxp.yaml      | 35 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/hpe/gxp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/hpe/gxp.yaml b/Documentation/devicetree/bindings/soc/hpe/gxp.yaml
> new file mode 100644
> index 000000000000..8690c1e28ed2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/hpe/gxp.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/hpe/gxp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE bmc GXP SoC driver
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp

I have no clue what this is... It is called a "SoC driver", but uses a
SoC compatible. It's not possible to understand the big picture, based
on this one patch (and it is not part of series...).

Please go through the comments you received... I provided you some time
with an example how the submission should look like:

https://lore.kernel.org/linux-samsung-soc/31da451b-a36c-74fb-5667-d4193284c6cd@canonical.com/T/#mf98d2ac27a8481dc69dd110f9861c8318cade252
1. Cover letter with changelog
2. Patches split and organized:
a. dt-bindings,
b. driver changes,
c. DTS.

Thinks could be separated, e.g. driver changes with corresponding DTS
updates, but you cannot send a bindings as separate email and DTS in
entirely different email to different people. We need to see all of them.

For example the Tesla FSD above split SPI changes into completely
separate series. That's ok. Still The series above bring everything
needed to judge/review that part.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +

Best regards,
Krzysztof
