Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ADC4CA6A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiCBNy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242654AbiCBNww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:52:52 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F52C6254
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:51:24 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B0FFD3F5F5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646229073;
        bh=sqmPaXdxxxGctLDB8wPzIBqrPvGA/5GcLbU1pcYO7kw=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=YTaGRLEcpQu841LkpCD2mR+MnTa8an/n2pqeFYhrhzEnCkM/QYHuWmlJNWYhFx1gI
         XU4YJcGqT9xgIsdFCzvLTlY/EKK+Jvn6L8/EiRtZd5bUGTbfSCfKfW26e66z7MHH36
         YqY/EkGuzMb/8Pzzek4WTPflHw6E+vVxYd0hRgcJtX4HXOmPssHSuiZKp25M0zlG4S
         COUMhzXmO8B2qca/wVGs5rehVdNb3aWK54UwKap4Yk2EEXgjrV8wsj35ayWdlj8dOD
         kkfPXQjwVR6FKuQAUhV66V5LoAHXPjTZClzaZeVkC1feRwY1wDhPQILOjGJrmK4XP9
         aWPculVQYAF+w==
Received: by mail-ej1-f69.google.com with SMTP id c23-20020a170906925700b006d6e2797863so1010051ejx.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 05:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sqmPaXdxxxGctLDB8wPzIBqrPvGA/5GcLbU1pcYO7kw=;
        b=w8V7z+EsnNusNn7FDEow5qJ1eVtTwID6b4e7IJ63JArBHSyEVr6oh52Ytm4yKCoojY
         qkkb4TLqHIJMH/hWL2hLSJu52W2USZG+gXhuC0sUzvbPHhlHcdTyetl7zGfqcQDjm/Gr
         9vjDgp+R96v4P2gpV0O7Am7ntiCfFF54U37s5oJZmBaki7OIKBFKXToNqvmHG6vJ2+l9
         fG+5/99TACtq4QBLxWOd8YXsS9ZMy4Jflfv8X4M8zyxihxLrLke2TedLmLBULgWBkTRm
         SJviXGjW+R1pc9sLiQaJAMJj140+rIIDOf2PQ+ko1g4Zn9ppuIwXPafB37LRS/EGZ1g3
         wGpw==
X-Gm-Message-State: AOAM53162v7inqSWOXpPMdtfQDkvYK72E+EnvTBTAbrpUTfAkx79Da0O
        ql8EXwRmCytk8kObHQc27YqxNqAVyUUvN7rSoaDxAujjJ6K4dkFESaXroOMrCO22MNJnjG53E5c
        XgHa8ru5Ul9APDlwF1pTXlelGFbS3E3n9cVuaiCKQyA==
X-Received: by 2002:aa7:cc02:0:b0:411:487e:36fe with SMTP id q2-20020aa7cc02000000b00411487e36femr29496881edt.338.1646229073281;
        Wed, 02 Mar 2022 05:51:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxX4GrcpOZdSJtCi/COSwNz1OLfF4qe+Oy6hmPfNQADJxnPOKAqrg9txmB1CGt/uFrFMkDGjQ==
X-Received: by 2002:aa7:cc02:0:b0:411:487e:36fe with SMTP id q2-20020aa7cc02000000b00411487e36femr29496856edt.338.1646229073047;
        Wed, 02 Mar 2022 05:51:13 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm8402272edt.70.2022.03.02.05.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 05:51:12 -0800 (PST)
Message-ID: <2b1f7c07-3cc9-9637-4621-3c5e0e09a65e@canonical.com>
Date:   Wed, 2 Mar 2022 14:51:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: add QCOM SM6125 display clock
 bindings
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
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
 <ea5d34c6-fe75-c096-d5b2-6a327c9d0ae5@canonical.com>
 <62ebb074-b8de-0dc3-2bbc-e43dca9d2ced@linaro.org>
 <05310308-b0ff-56a0-83ac-855b1b795936@canonical.com>
 <20220302125417.iu52rvdxrmo25wwt@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220302125417.iu52rvdxrmo25wwt@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 13:54, Marijn Suijten wrote:
> On 2022-02-28 10:23:19, Krzysztof Kozlowski wrote:
>> On 27/02/2022 22:43, Dmitry Baryshkov wrote:
>>> On 27/02/2022 13:03, Krzysztof Kozlowski wrote:
>>>> On 26/02/2022 21:09, Marijn Suijten wrote:
>>>>> From: Martin Botka <martin.botka@somainline.org>
>>>>>
>>>>> Add device tree bindings for display clock controller for
>>>>> Qualcomm Technology Inc's SM6125 SoC.
>>>>>
>>>>> Signed-off-by: Martin Botka <martin.botka@somainline.org>
>>>>> ---
>>>>>   .../bindings/clock/qcom,dispcc-sm6125.yaml    | 87 +++++++++++++++++++
>>>>>   .../dt-bindings/clock/qcom,dispcc-sm6125.h    | 41 +++++++++
>>>>>   2 files changed, 128 insertions(+)
>>>>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>>>>>   create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..3465042d0d9f
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>>>>> @@ -0,0 +1,87 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/clock/qcom,dispcc-sm6125.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Qualcomm Display Clock Controller Binding for SM6125
>>>>> +
>>>>> +maintainers:
>>>>> +  - Martin Botka <martin.botka@somainline.org>
>>>>> +
>>>>> +description: |
>>>>> +  Qualcomm display clock control module which supports the clocks and
>>>>> +  power domains on SM6125.
>>>>> +
>>>>> +  See also:
>>>>> +    dt-bindings/clock/qcom,dispcc-sm6125.h
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - qcom,sm6125-dispcc
>>>>> +
>>>>> +  clocks:
>>>>> +    items:
>>>>> +      - description: Board XO source
>>>>> +      - description: Byte clock from DSI PHY0
>>>>> +      - description: Pixel clock from DSI PHY0
>>>>> +      - description: Pixel clock from DSI PHY1
>>>>> +      - description: Link clock from DP PHY
>>>>> +      - description: VCO DIV clock from DP PHY
>>>>> +      - description: AHB config clock from GCC
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: bi_tcxo
>>>>> +      - const: dsi0_phy_pll_out_byteclk
>>>>> +      - const: dsi0_phy_pll_out_dsiclk
>>>>> +      - const: dsi1_phy_pll_out_dsiclk
>>>>> +      - const: dp_phy_pll_link_clk
>>>>> +      - const: dp_phy_pll_vco_div_clk
>>>>> +      - const: cfg_ahb_clk
>>>>> +
>>>>> +  '#clock-cells':
>>>>> +    const: 1
>>>>> +
>>>>> +  '#power-domain-cells':
>>>>> +    const: 1
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - clocks
>>>>> +  - clock-names
>>>>> +  - '#clock-cells'
>>>>> +  - '#power-domain-cells'
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/clock/qcom,rpmcc.h>
>>>>> +    #include <dt-bindings/clock/qcom,gcc-sm6125.h>
>>>>> +    clock-controller@5f00000 {
>>>>> +      compatible = "qcom,sm6125-dispcc";
>>>>> +      reg = <0x5f00000 0x20000>;
>>>>> +      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>>>> +               <&dsi0_phy 0>,
>>>>> +               <&dsi0_phy 1>,
>>>>> +               <0>,
>>>>
>>>> This does not look like a valid phandle. This clock is required, isn't it?
> 
> I remember it being used like this before, though upon closer inspection
> only qcom,gcc-msm8998.yaml uses it as example.
> 
> The clock should be optional, in that case it is perhaps desired to omit
> it from clock-names instead, or pretend there's a `dsi1_phy 1`?

I propose to omit it.

> 
>>>
>>> Not, it's not required for general dispcc support.
>>> dispcc uses DSI and DP PHY clocks to provide respective pixel/byte/etc 
>>> clocks. However if support for DP is not enabled, the dispcc can work 
>>> w/o DP phy clock. Thus we typically add 0 phandles as placeholders for 
> 
> Is there any semantic difference between omitting the clock from DT (in
> clocks= /and/ clock-names=) or setting it to a 0 phandle?

Yes, there is. The DT validation does not check the meaning behind
values, so there is no difference between valid phandle/ID and 0. While
not having a clock at all is spotted by validation.

> 
>>> DSI/DP clock sources and populate them as support for respective 
>>> interfaces gets implemented.
>>>
>>
>> Then the clock is optional, isn't it? While not modeling it as optional?
> 
> It looks like this should be modelled using minItems: then, and
> "optional" text/comment? Other clocks are optional as well, we don't
> have DSI 1 in downstream SM6125 DT sources and haven't added the DP PLL
> in our to-be-upstreamed mainline tree yet.

Are they really optional? Or maybe they should not even be provided?


Best regards,
Krzysztof
