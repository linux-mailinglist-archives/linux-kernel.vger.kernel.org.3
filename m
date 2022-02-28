Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F174C659B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiB1JYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiB1JYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:24:04 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463043B3DC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:23:24 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6B0D83F170
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646040203;
        bh=3AkK4RxGdbmTygJvwG++DDRYgKJ3fKlzb6qBUYAxPMU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ICheEIWonqldzFJAKMy9+UQd2cLs8+VtjGDTgUOy2mV2pMm8CNQowxmC8BZobVz1z
         1xeoFYic88APwzETbvkaiTxQOaeVFkDtDRfNQSvC0uTQSasZRMT4xEdWqUffsxHTAg
         IcON4YbkN95qapqeWjXOeS6JCRNpc27D7pVZdprlXhtscqwWTeE2Bxj5cwB8D/YbqH
         dcJUumbHyew6hQTJ5aPO4VI50YUue8WN7hm3nWj3PlScMaiWb5VXKS/duw76InTPv4
         GuvySjWXMg5wrK9P6TQ8tm5qQa+16/ovYIAlasjQrqQIK8UestiXSIJb37vmw2qPIf
         B/f57WuHQWQVg==
Received: by mail-ed1-f70.google.com with SMTP id j10-20020a05640211ca00b004090fd8a936so5488796edw.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3AkK4RxGdbmTygJvwG++DDRYgKJ3fKlzb6qBUYAxPMU=;
        b=iEQD/4wrxVfygZSxCMaox5qifU9sU/sfEStYnxI4ecGd8PvM8PTqLUi6GfLxHtdPn6
         UEUmA559+NaFADBGWD/QDwEi+i7NoPxDbKqE67L5+bN2r+hCfWe40h2EVkUZ9Z6gWivU
         7JLrE1m5bERGuEK3YxJLgar9oQh2qt2o3c9l/+IHER4vNmz9kYLP/tJ8I6KKmIPuiMJY
         fgCWjrEzetdYJwwRMMMdZ/tdMSbBbCpLoZR7CT8mPErB2qxpuQ4z+MMXWNUY+tAgJHKJ
         o0dxOaOse6LbFUZ8zwWj/OEcmnTLtGGXPWWAWLUCikHNBGG4iG1nWV0cFKH5wQFRXcFr
         S+Vw==
X-Gm-Message-State: AOAM533sicaIEINJ0GtN0EXFsDbAOcmqjJWo98HbuYy2BzYyhHKxfPOJ
        t/PrNuYNuTCD0iLWVNmE5w0FSydTthR3RntkVkNMXrOM9tBnCvHKVkt4RelUOs8O8b/dVKYxCOQ
        +NyaRyAV3NWlF4K99L1xJUDX4f8vN9NbFvnR796O56g==
X-Received: by 2002:a17:906:4e83:b0:6d6:d5c8:1335 with SMTP id v3-20020a1709064e8300b006d6d5c81335mr433395eju.438.1646040203104;
        Mon, 28 Feb 2022 01:23:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvxpaUQXlZXrspRIYaQJ+p2vCjcouQfLVFcldvOi83NTKJnTIe0fV5+OZvji7GFV1Qn+rFmg==
X-Received: by 2002:a17:906:4e83:b0:6d6:d5c8:1335 with SMTP id v3-20020a1709064e8300b006d6d5c81335mr433376eju.438.1646040202852;
        Mon, 28 Feb 2022 01:23:22 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id w12-20020a17090649cc00b006d0bee77b9asm4187080ejv.72.2022.02.28.01.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:23:21 -0800 (PST)
Message-ID: <05310308-b0ff-56a0-83ac-855b1b795936@canonical.com>
Date:   Mon, 28 Feb 2022 10:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: add QCOM SM6125 display clock
 bindings
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
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
 <ea5d34c6-fe75-c096-d5b2-6a327c9d0ae5@canonical.com>
 <62ebb074-b8de-0dc3-2bbc-e43dca9d2ced@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <62ebb074-b8de-0dc3-2bbc-e43dca9d2ced@linaro.org>
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

On 27/02/2022 22:43, Dmitry Baryshkov wrote:
> On 27/02/2022 13:03, Krzysztof Kozlowski wrote:
>> On 26/02/2022 21:09, Marijn Suijten wrote:
>>> From: Martin Botka <martin.botka@somainline.org>
>>>
>>> Add device tree bindings for display clock controller for
>>> Qualcomm Technology Inc's SM6125 SoC.
>>>
>>> Signed-off-by: Martin Botka <martin.botka@somainline.org>
>>> ---
>>>   .../bindings/clock/qcom,dispcc-sm6125.yaml    | 87 +++++++++++++++++++
>>>   .../dt-bindings/clock/qcom,dispcc-sm6125.h    | 41 +++++++++
>>>   2 files changed, 128 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>>>   create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>>> new file mode 100644
>>> index 000000000000..3465042d0d9f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>>> @@ -0,0 +1,87 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/qcom,dispcc-sm6125.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Display Clock Controller Binding for SM6125
>>> +
>>> +maintainers:
>>> +  - Martin Botka <martin.botka@somainline.org>
>>> +
>>> +description: |
>>> +  Qualcomm display clock control module which supports the clocks and
>>> +  power domains on SM6125.
>>> +
>>> +  See also:
>>> +    dt-bindings/clock/qcom,dispcc-sm6125.h
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,sm6125-dispcc
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: Board XO source
>>> +      - description: Byte clock from DSI PHY0
>>> +      - description: Pixel clock from DSI PHY0
>>> +      - description: Pixel clock from DSI PHY1
>>> +      - description: Link clock from DP PHY
>>> +      - description: VCO DIV clock from DP PHY
>>> +      - description: AHB config clock from GCC
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: bi_tcxo
>>> +      - const: dsi0_phy_pll_out_byteclk
>>> +      - const: dsi0_phy_pll_out_dsiclk
>>> +      - const: dsi1_phy_pll_out_dsiclk
>>> +      - const: dp_phy_pll_link_clk
>>> +      - const: dp_phy_pll_vco_div_clk
>>> +      - const: cfg_ahb_clk
>>> +
>>> +  '#clock-cells':
>>> +    const: 1
>>> +
>>> +  '#power-domain-cells':
>>> +    const: 1
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - clock-names
>>> +  - '#clock-cells'
>>> +  - '#power-domain-cells'
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/qcom,rpmcc.h>
>>> +    #include <dt-bindings/clock/qcom,gcc-sm6125.h>
>>> +    clock-controller@5f00000 {
>>> +      compatible = "qcom,sm6125-dispcc";
>>> +      reg = <0x5f00000 0x20000>;
>>> +      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>> +               <&dsi0_phy 0>,
>>> +               <&dsi0_phy 1>,
>>> +               <0>,
>>
>> This does not look like a valid phandle. This clock is required, isn't it?
> 
> Not, it's not required for general dispcc support.
> dispcc uses DSI and DP PHY clocks to provide respective pixel/byte/etc 
> clocks. However if support for DP is not enabled, the dispcc can work 
> w/o DP phy clock. Thus we typically add 0 phandles as placeholders for 
> DSI/DP clock sources and populate them as support for respective 
> interfaces gets implemented.
> 

Then the clock is optional, isn't it? While not modeling it as optional?


Best regards,
Krzysztof
