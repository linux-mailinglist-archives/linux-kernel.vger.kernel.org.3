Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818704D6372
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349343AbiCKO3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbiCKO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:29:36 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981B3EBAD8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:28:32 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A2AE3F4BE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647008911;
        bh=PdIndayzdh0p1erKParNfrZ1poZ/AkWCjFd9nsPB1bM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=r53M9jV+B8XmgcA7X8IiKPGsHT7nVwDDq+PhKCeLEp8O9hBjfPqebgMaJEYmLdO41
         L4ZeuYKaCVDw7wTKxrLQOPKY35ERdumH+YC+7eJ5XsqVrZiNypcu5WIRkxhRpCN9hw
         xLOq1Wl6hbrD+Hjn4wp1lLn6ZQZBQ0z3GsaygtXWuzuDFOk0X4VR1TPrL/dvsHoo28
         c0XB6NC1mVZbWOAYxCzPVZtkZl0EQSHJfAu56847GseXvaDF9Jgt0+THQ7ZcYJpUoT
         TaLrq7s2tucgCsjpsV8vnfEYJN8japQMpOxZE5Q3kCgqyov/dxB+lOVLSQlj9GqS3w
         cDr6/edhPbHVg==
Received: by mail-ej1-f70.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso5007779eje.20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PdIndayzdh0p1erKParNfrZ1poZ/AkWCjFd9nsPB1bM=;
        b=nYacU9/xcxhTEb4TP/AOR1ddF1wvVWNN6xMAb7Add/gmCKbfGyFfefEgZBkAFlPPZp
         BojrAYPJuk7iMxPGnsqQbV+77Go6ZEQwe7NdtDd95zzE27MM7NQq52BxE6xY76uGoq1c
         FQAk7FKcXqCp3pqnJ+t90Tod801NiN3Gyv5T/y1IQC5OaMC9zelPJbiqA/OmRTvrpCTZ
         H1153VbPLauIRr/DYxkR8XTqK4vZBUY8N0awW895yTaped0vLfVJ4KejawB9K+g1BRP2
         4EKo61OG/gwOT38b2WtmqRsc1y5pJJpcT3nP2NNv0iKY7iwd3tv7RhEkgXwUE8V862lr
         hAXw==
X-Gm-Message-State: AOAM530KeC3TfFY0Wt2WO2yyC9ddwqKIWpTi4C/OhM6RB9D5NnPq6fcw
        IeMM6kE+nwm236o2DbpVxWuGcvPBLYtF00lh+t2la6Dtq5DXSIgPpWNuH535pq37sCvCN5QAjjY
        EYHBgRqA+OzaFUB7/zCNzuKvcH4Xh8N8U0ZhBJuLU9A==
X-Received: by 2002:a17:906:40a:b0:6db:3e2a:a7ce with SMTP id d10-20020a170906040a00b006db3e2aa7cemr8563512eja.255.1647008910476;
        Fri, 11 Mar 2022 06:28:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxu7HRELcvW932dJyiTM8RcnBlSViVbwCdvsfEGJ7B4Ej6w1K6mhpjwwmEC8B/O6gJR4wVowQ==
X-Received: by 2002:a17:906:40a:b0:6db:3e2a:a7ce with SMTP id d10-20020a170906040a00b006db3e2aa7cemr8563494eja.255.1647008910276;
        Fri, 11 Mar 2022 06:28:30 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id z7-20020a05640240c700b00416cee953dasm1089877edb.24.2022.03.11.06.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 06:28:29 -0800 (PST)
Message-ID: <0454647b-7aa3-ed70-0b92-1e5c98d0adc0@canonical.com>
Date:   Fri, 11 Mar 2022 15:28:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] dt-bindings: phy: mediatek: Add YAML schema for PCIe
 PHY
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
References: <20220311133527.5914-1-jianjun.wang@mediatek.com>
 <20220311133527.5914-3-jianjun.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311133527.5914-3-jianjun.wang@mediatek.com>
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

On 11/03/2022 14:35, Jianjun Wang wrote:
> Add YAML schema documentation for PCIe PHY on MediaTek chipsets.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  .../bindings/phy/mediatek,pcie-phy.yaml       | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> new file mode 100644
> index 000000000000..da15b4bf3117
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek PCIe PHY Device Tree Binding

Title is for hardware, so s/Device Tree Binding//

> +
> +maintainers:
> +  - Jianjun Wang <jianjun.wang@mediatek.com>
> +
> +description: |
> +  The PCIe PHY supports physical layer functionality for PCIe Gen3 port.
> +
> +properties:
> +  compatible:
> +    const: mediatek,pcie-phy

Is it going to be exactly one pcie-phy for all Mediatek chipsets for
next years? Are you sure about that? It sounds highly unlikely....

> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: sif
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  nvmem-cells:
> +    maxItems: 7
> +    description:
> +      Phandles to nvmem cell that contains the efuse data, if unspecified,
> +      default value is used.
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: glb_intr
> +      - const: tx_ln0_pmos
> +      - const: tx_ln0_nmos
> +      - const: rx_ln0
> +      - const: tx_ln1_pmos
> +      - const: tx_ln1_nmos
> +      - const: rx_ln1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pciephy: phy@11e80000 {
> +        compatible = "mediatek,pcie-phy";
> +        #phy-cells = <0>;
> +        reg = <0x11e80000 0x10000>;
> +        reg-names = "sif";
> +        nvmem-cells = <&pciephy_glb_intr>,
> +                      <&pciephy_tx_ln0_pmos>,
> +                      <&pciephy_tx_ln0_nmos>,
> +                      <&pciephy_rx_ln0>,
> +                      <&pciephy_tx_ln1_pmos>,
> +                      <&pciephy_tx_ln1_nmos>,
> +                      <&pciephy_rx_ln1>;
> +        nvmem-cell-names = "glb_intr", "tx_ln0_pmos",
> +                           "tx_ln0_nmos", "rx_ln0",
> +                           "tx_ln1_pmos", "tx_ln1_nmos",
> +                           "rx_ln1";
> +    };


Best regards,
Krzysztof
