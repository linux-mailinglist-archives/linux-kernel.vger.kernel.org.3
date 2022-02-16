Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEFA4B89CB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiBPN0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:26:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiBPN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:26:32 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CDC1B78C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:26:17 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 545F03F1B6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645017976;
        bh=HnLv2sgPTFeJCaPDj49F4ixfOdgITRk3XaxRkpYlXz0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=d+ytUNIq/+YlMjkBHdiOV8f4oLa5IC3GzB6jvG+C7TfcqFdyX0KOr+USFSxC9EfzW
         gq4sf5GP+2Y9PEsc59qza/ErxG8NRKgmR8tyS5azhFwTtH329ZDBm2ITajzRbvduwY
         djHyqSCQsWveL2va2wT/eOz4fRUQ919qHtZ2EAJMnfzUI3Wx3c6Q1V+f7+lSJTGT4Y
         cV623To1sFST3A04oSdbBkd9Bl541P8v4XHGEujKDhUeevB7FXVse+VpePM30PDXFt
         yGlxbJTMN8smPmt2kqJYtjVhq3t5quGgig62hqd/H4EX/8G0JdurlhhgrHXxiDxruR
         SppoGEjyty4Fw==
Received: by mail-ed1-f70.google.com with SMTP id l24-20020a056402231800b00410f19a3103so1560341eda.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HnLv2sgPTFeJCaPDj49F4ixfOdgITRk3XaxRkpYlXz0=;
        b=peWA4jqdZliCMKOAMQ5mBzf+ZvOaWA2ckOqIk535E36Hb1xfv+2qQ0w2JvaDkyEXzN
         6Ypi/IZddy6godLV+b2KhfRph/m7P4P3FP5llRaZzbQazi5Q9G81h69dPDMI04+lMKZh
         uofuGghuiqF8WhecovcnP3k1l4y9dgD3AUoS2GSOQc9OMiY8SPU2QODfyPn88Oa5ZBkg
         GcwEKPcHscx0oOKW9wYtSNBestXie2tJbYOeLcJIahZDqazEVCGnlB3JFBjSi2b0zmaX
         UQ46HHStbBHhAfQCkQi90OL2d/52DzE5amyozfkBRwPnnRDBni+uuujatP4ZAjHBbbLs
         k9Lg==
X-Gm-Message-State: AOAM533Vo6HQ2sP4vvoc+hl0zF09qP/WyTna/CPXWk5mE2J5oYX5lZcd
        ccBs6y8SS3+F1QxNk2jBz5zUJu/yx2LvZE6Y4oUqHCC9nvMfCm7r1ecPNQ5l3QkpiKEVtOq5GvD
        m1T82gkFgrUsOO0qLWBzra5bBybHzgfv0mur7+e967g==
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id t1-20020a1709061be100b006ceb0a8017dmr2212959ejg.413.1645017975940;
        Wed, 16 Feb 2022 05:26:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW6N5tK5VHWBe36Bj5vHHIMzDJlCB0AOnINLyfOUpi+aCPHYXEWQjcBrraceqmA2DJkZ7r6A==
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id t1-20020a1709061be100b006ceb0a8017dmr2212939ejg.413.1645017975741;
        Wed, 16 Feb 2022 05:26:15 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id qf12sm1085572ejc.54.2022.02.16.05.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:26:15 -0800 (PST)
Message-ID: <79a47f67-bb66-bad4-b6bc-c6a8c0ef25dc@canonical.com>
Date:   Wed, 16 Feb 2022 14:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: dma: Convert mtk-uart-apdma to DT schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, vkoul@kernel.org
Cc:     robh+dt@kernel.org, sean.wang@mediatek.com, matthias.bgg@gmail.com,
        long.cheng@mediatek.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220216114054.269656-1-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220216114054.269656-1-angelogioacchino.delregno@collabora.com>
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

On 16/02/2022 12:40, AngeloGioacchino Del Regno wrote:
> Convert the MediaTek UART APDMA Controller binding to DT schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/dma/mediatek,uart-dma.yaml       | 112 ++++++++++++++++++
>  .../bindings/dma/mtk-uart-apdma.txt           |  56 ---------
>  2 files changed, 112 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> new file mode 100644
> index 000000000000..4583c8f535b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/mediatek,uart-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek UART APDMA controller
> +
> +maintainers:
> +  - Long Cheng <long.cheng@mediatek.com>
> +
> +description: |
> +  The MediaTek UART APDMA controller provides DMA capabilities
> +  for the UART peripheral bus.
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt2712-uart-dma
> +              - mediatek,mt8516-uart-dma
> +          - const: mediatek,mt6577-uart-dma
> +      - enum:
> +          - mediatek,mt6577-uart-dma
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 16
> +
> +  interrupts:
> +    description: |
> +      TX, RX interrupt lines for each UART APDMA channel
> +    minItems: 1

It would be useful to have an "if:" block constraining the interrupts
(and reg array?), if the dma-requests is missing. If you need an
example, see length of "max8997,pmic-buck1-dvs-voltage" array in
relation to presence of max8997,pmic-buck1-uses-gpio-dvs.
https://elixir.bootlin.com/linux/v5.17-rc2/source/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml#L259

The best would be to restrict number of interrupts to number of
requests, but I think dtschema cannot express this.

> +    maxItems: 32
> +
> +  clocks:
> +    description: Must contain one entry for the APDMA main clock
> +    maxItems: 1
> +
> +  clock-names:
> +    const: apdma
> +
> +  "#dma-cells":
> +    const: 1
> +    description: |
> +      The first cell specifies the UART APDMA channel number
> +
> +  dma-requests:
> +    description: |
> +      Number of virtual channels of the UART APDMA controller
> +    maximum: 16
> +
> +  mediatek,dma-33bits:
> +    type: boolean
> +    description: Enable 33-bits UART APDMA support
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"

No need for requiring dma-cells. It is coming from dma-common.yaml.

> +

Best regards,
Krzysztof
