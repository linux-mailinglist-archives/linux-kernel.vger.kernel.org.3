Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7312F4C5A68
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiB0KEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiB0KEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:04:34 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CFA5C647
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 02:03:57 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E4C964003C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645956235;
        bh=IfVXPHlKvsF/IugNOxJ2nfDin24YI7mhh0WDRsHK5Xo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=P/mAev3ks6m/REqgAqjHXLVl9KPAHGZ/Ncc2NMJUUfNrHvhPodopMyItXyCVR180W
         RaROqczYBdlKDPapvQL+s5nO/FXH/omMkqLBvDXnFURGRraBCv65VYYIySPd5EUJXr
         9E2xNPoWZCEnZkFkWlCgPqDk81sEcTU74++b+0kAIw3WQ36k910aLmrQ/bc4BnwoGK
         mNjn79OR/LX4TRMXYtbnZiYUvp1Q3xtJVru0dBrWGm3YPOurcud1eFdn2BRDa2xAOE
         IJmgEHPPSJUbD5c46bFl90Y1FZS0e8vQgoYmLV8/CkOe/F+M7M/afvvfhEo7XmRXXL
         Fzzf408yO0ebg==
Received: by mail-ed1-f69.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so4002644edh.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 02:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IfVXPHlKvsF/IugNOxJ2nfDin24YI7mhh0WDRsHK5Xo=;
        b=7BYPjaYMswpi3cP4VeuPmS4MJkAED4Xy8AipyjNywQ8LUG6ajUFPMryklZlX8dhnir
         /FTDJuItcj7LZhAwIzRp0pZ5kXqIzLTd0tMy0hqvkpVfz/rkWoAWAXjORopIVnN5PVOJ
         c1oYu5R1rzQiUkcE1JP0pKXbHgIaiG5/tZ8EAytz58nm0bnGYYj+ivYtol3nNMjy52jN
         lFRdEROAMD1KafhUAp5GRrHtiXZw9nTI2/ewLqgeToXW0E+/mx3ZZ8QbVPsM68XyWps0
         TPA6w/aVQBUYMe2IsUEbC/yA3jMHqTKRoAEsiCgVPFwfGVa4zflYsPAv95ltuF73hY9H
         JGgA==
X-Gm-Message-State: AOAM531lTMj8azGt8oUdarEIfW8dMaapbH/L2xNSZ31CXQz20+TnDacI
        +Hd+x9YOYSi3u2adkv3g77EIGHXEqDOHhBkv2YUOJIlV8Z8GPtBI0e5PCzYvnyNyDy0JCURoGNj
        LTgB7SJZkA/tdoqm7wYiJAkvC9/Gwxlrq46wYZlb2Hw==
X-Received: by 2002:a17:906:6d09:b0:6b9:2e0e:5bdd with SMTP id m9-20020a1709066d0900b006b92e0e5bddmr11270621ejr.246.1645956234704;
        Sun, 27 Feb 2022 02:03:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPviELBAb3YlJF3dqApYWhzkERExWKru4Uij+RIvAJZ8xES86UbS47+QTJNfsojvKwn0q7ag==
X-Received: by 2002:a17:906:6d09:b0:6b9:2e0e:5bdd with SMTP id m9-20020a1709066d0900b006b92e0e5bddmr11270607ejr.246.1645956234415;
        Sun, 27 Feb 2022 02:03:54 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id ee21-20020a056402291500b00410d4261313sm4211234edb.24.2022.02.27.02.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 02:03:53 -0800 (PST)
Message-ID: <ea5d34c6-fe75-c096-d5b2-6a327c9d0ae5@canonical.com>
Date:   Sun, 27 Feb 2022 11:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: add QCOM SM6125 display clock
 bindings
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220226200911.230030-1-marijn.suijten@somainline.org>
 <20220226200911.230030-3-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220226200911.230030-3-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2022 21:09, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6125 SoC.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  .../bindings/clock/qcom,dispcc-sm6125.yaml    | 87 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,dispcc-sm6125.h    | 41 +++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> new file mode 100644
> index 000000000000..3465042d0d9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,dispcc-sm6125.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Clock Controller Binding for SM6125
> +
> +maintainers:
> +  - Martin Botka <martin.botka@somainline.org>
> +
> +description: |
> +  Qualcomm display clock control module which supports the clocks and
> +  power domains on SM6125.
> +
> +  See also:
> +    dt-bindings/clock/qcom,dispcc-sm6125.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm6125-dispcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Byte clock from DSI PHY0
> +      - description: Pixel clock from DSI PHY0
> +      - description: Pixel clock from DSI PHY1
> +      - description: Link clock from DP PHY
> +      - description: VCO DIV clock from DP PHY
> +      - description: AHB config clock from GCC
> +
> +  clock-names:
> +    items:
> +      - const: bi_tcxo
> +      - const: dsi0_phy_pll_out_byteclk
> +      - const: dsi0_phy_pll_out_dsiclk
> +      - const: dsi1_phy_pll_out_dsiclk
> +      - const: dp_phy_pll_link_clk
> +      - const: dp_phy_pll_vco_div_clk
> +      - const: cfg_ahb_clk
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +    #include <dt-bindings/clock/qcom,gcc-sm6125.h>
> +    clock-controller@5f00000 {
> +      compatible = "qcom,sm6125-dispcc";
> +      reg = <0x5f00000 0x20000>;
> +      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +               <&dsi0_phy 0>,
> +               <&dsi0_phy 1>,
> +               <0>,

This does not look like a valid phandle. This clock is required, isn't it?


Best regards,
Krzysztof
