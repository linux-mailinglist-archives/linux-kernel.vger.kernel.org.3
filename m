Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F94F4CA876
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiCBOrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiCBOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:47:48 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022EEC7C22
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:47:04 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id u17-20020a056830231100b005ad13358af9so1819251ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 06:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KbVcfyuITV0rCjQy15u5QkwOfQwIgScVE+BKmiVrwoA=;
        b=H88glmHUAbMi/OKY83qcwu9WNvTTNiA7uw0ie+Tgy3ay65i+t9Hxo+VMViHDb73zND
         ok9lVatGf8kTEs565A6u6SwLF8voWppCQgiGNMH0SenNmHPpfg9Nyp2tYESXJJNmR1F9
         wKxGVVkaL3JscfuiYoqkI5Pk/AJ7D6UbIhFZtCjGLeUBY34KKVFSYWi22UbRs2foojYJ
         qzyfx36YoDB4ZYteE/L3W6P/NX9vuOdxXd65pVg5lOY67KBlmyuBqhZzQcpIdTkmOsOv
         ZdDNRmwblMyo84dK8nythducx0z5YcdkiiBVQ/cLOO+RHn2jzgnGtzjIBOnxIAEq+vKI
         CIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KbVcfyuITV0rCjQy15u5QkwOfQwIgScVE+BKmiVrwoA=;
        b=btEPwcTdI7A4L5gvC8ofXvBW2HNjrbNcZQPldIxSHwxWnNse7/ZENZJEOpCrva6C2u
         CSqfC27g4dtL1POfkJ0RVgQZwtXzn0qk2Sq0qSugbrDQ/Bx9503ZwLzF2An6KWxmoQmf
         pNsj7afDK78iTU3wYn7uTgEALgFuBdYvWg9BLvt9YujSwA46E55ifZcaRuGFkszVRPY7
         AFJgW948emoyLbdL1cr1qarJ4Oe5WflMB4nIJXXgNB7QAoAyIcQDyCFUbb/wDfhTH/MS
         67OZWkK3fPQYJ7UNRjJdRQ5WmOOYHVE7TNU3/JfEU9AlsCIm3RAU3eBzReZOHemsFfOK
         WNCw==
X-Gm-Message-State: AOAM5322J1QUOEB/4VQVW8M/+JvE2OQ1ScGk9KRh4VYdUujOcpYgLDt/
        dpCgDoTk/gtiMHbatg6noQwuJg==
X-Google-Smtp-Source: ABdhPJzmpGB/PqAl+cZzADllHdqp4RYUVyp9QnOmj759Wmm9lcgY+/R4k555WXUvL+nfqCIujeFAuA==
X-Received: by 2002:a05:6830:2683:b0:5b0:43c9:8d9 with SMTP id l3-20020a056830268300b005b043c908d9mr2922478otu.368.1646232423304;
        Wed, 02 Mar 2022 06:47:03 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id bm5-20020a056820188500b0031c42eb457csm7646628oob.43.2022.03.02.06.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:47:02 -0800 (PST)
Date:   Wed, 2 Mar 2022 06:48:53 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: add QCOM SM6125 display clock
 bindings
Message-ID: <Yh+D1cHuRNQqnHf+@ripper>
References: <20220226200911.230030-1-marijn.suijten@somainline.org>
 <20220226200911.230030-3-marijn.suijten@somainline.org>
 <ea5d34c6-fe75-c096-d5b2-6a327c9d0ae5@canonical.com>
 <62ebb074-b8de-0dc3-2bbc-e43dca9d2ced@linaro.org>
 <05310308-b0ff-56a0-83ac-855b1b795936@canonical.com>
 <20220302125417.iu52rvdxrmo25wwt@SoMainline.org>
 <2b1f7c07-3cc9-9637-4621-3c5e0e09a65e@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1f7c07-3cc9-9637-4621-3c5e0e09a65e@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02 Mar 05:51 PST 2022, Krzysztof Kozlowski wrote:

> On 02/03/2022 13:54, Marijn Suijten wrote:
> > On 2022-02-28 10:23:19, Krzysztof Kozlowski wrote:
> >> On 27/02/2022 22:43, Dmitry Baryshkov wrote:
> >>> On 27/02/2022 13:03, Krzysztof Kozlowski wrote:
> >>>> On 26/02/2022 21:09, Marijn Suijten wrote:
> >>>>> From: Martin Botka <martin.botka@somainline.org>
> >>>>>
> >>>>> Add device tree bindings for display clock controller for
> >>>>> Qualcomm Technology Inc's SM6125 SoC.
> >>>>>
> >>>>> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> >>>>> ---
> >>>>>   .../bindings/clock/qcom,dispcc-sm6125.yaml    | 87 +++++++++++++++++++
> >>>>>   .../dt-bindings/clock/qcom,dispcc-sm6125.h    | 41 +++++++++
> >>>>>   2 files changed, 128 insertions(+)
> >>>>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> >>>>>   create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..3465042d0d9f
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
> >>>>> @@ -0,0 +1,87 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/clock/qcom,dispcc-sm6125.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: Qualcomm Display Clock Controller Binding for SM6125
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Martin Botka <martin.botka@somainline.org>
> >>>>> +
> >>>>> +description: |
> >>>>> +  Qualcomm display clock control module which supports the clocks and
> >>>>> +  power domains on SM6125.
> >>>>> +
> >>>>> +  See also:
> >>>>> +    dt-bindings/clock/qcom,dispcc-sm6125.h
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    enum:
> >>>>> +      - qcom,sm6125-dispcc
> >>>>> +
> >>>>> +  clocks:
> >>>>> +    items:
> >>>>> +      - description: Board XO source
> >>>>> +      - description: Byte clock from DSI PHY0
> >>>>> +      - description: Pixel clock from DSI PHY0
> >>>>> +      - description: Pixel clock from DSI PHY1
> >>>>> +      - description: Link clock from DP PHY
> >>>>> +      - description: VCO DIV clock from DP PHY
> >>>>> +      - description: AHB config clock from GCC
> >>>>> +
> >>>>> +  clock-names:
> >>>>> +    items:
> >>>>> +      - const: bi_tcxo
> >>>>> +      - const: dsi0_phy_pll_out_byteclk
> >>>>> +      - const: dsi0_phy_pll_out_dsiclk
> >>>>> +      - const: dsi1_phy_pll_out_dsiclk
> >>>>> +      - const: dp_phy_pll_link_clk
> >>>>> +      - const: dp_phy_pll_vco_div_clk
> >>>>> +      - const: cfg_ahb_clk
> >>>>> +
> >>>>> +  '#clock-cells':
> >>>>> +    const: 1
> >>>>> +
> >>>>> +  '#power-domain-cells':
> >>>>> +    const: 1
> >>>>> +
> >>>>> +  reg:
> >>>>> +    maxItems: 1
> >>>>> +
> >>>>> +required:
> >>>>> +  - compatible
> >>>>> +  - reg
> >>>>> +  - clocks
> >>>>> +  - clock-names
> >>>>> +  - '#clock-cells'
> >>>>> +  - '#power-domain-cells'
> >>>>> +
> >>>>> +additionalProperties: false
> >>>>> +
> >>>>> +examples:
> >>>>> +  - |
> >>>>> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> >>>>> +    #include <dt-bindings/clock/qcom,gcc-sm6125.h>
> >>>>> +    clock-controller@5f00000 {
> >>>>> +      compatible = "qcom,sm6125-dispcc";
> >>>>> +      reg = <0x5f00000 0x20000>;
> >>>>> +      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> >>>>> +               <&dsi0_phy 0>,
> >>>>> +               <&dsi0_phy 1>,
> >>>>> +               <0>,
> >>>>
> >>>> This does not look like a valid phandle. This clock is required, isn't it?
> > 
> > I remember it being used like this before, though upon closer inspection
> > only qcom,gcc-msm8998.yaml uses it as example.
> > 
> > The clock should be optional, in that case it is perhaps desired to omit
> > it from clock-names instead, or pretend there's a `dsi1_phy 1`?
> 
> I propose to omit it.
> 

The wire is there, it's only optional because we don't have the other
side represented in DT yet.

I believe we started filling out 0s like this because omitting elements
that are not yet possible to fill out means that the order will change
as we add more functions, something Rob has objected to. Further more as
we add more functions the existing dts will fail validation, even though
the hardware hasn't changed.


That said, even though we don't have the other piece on this particular
platform we do know where this signal comes from. So we should be able
to have a valid (or at least strongly plausible) example in the binding
- and then fill out the dts with 0s to keep validation happy until the
other pieces are filled out.

Regards,
Bjorn

> > 
> >>>
> >>> Not, it's not required for general dispcc support.
> >>> dispcc uses DSI and DP PHY clocks to provide respective pixel/byte/etc 
> >>> clocks. However if support for DP is not enabled, the dispcc can work 
> >>> w/o DP phy clock. Thus we typically add 0 phandles as placeholders for 
> > 
> > Is there any semantic difference between omitting the clock from DT (in
> > clocks= /and/ clock-names=) or setting it to a 0 phandle?
> 
> Yes, there is. The DT validation does not check the meaning behind
> values, so there is no difference between valid phandle/ID and 0. While
> not having a clock at all is spotted by validation.
> 
> > 
> >>> DSI/DP clock sources and populate them as support for respective 
> >>> interfaces gets implemented.
> >>>
> >>
> >> Then the clock is optional, isn't it? While not modeling it as optional?
> > 
> > It looks like this should be modelled using minItems: then, and
> > "optional" text/comment? Other clocks are optional as well, we don't
> > have DSI 1 in downstream SM6125 DT sources and haven't added the DP PLL
> > in our to-be-upstreamed mainline tree yet.
> 
> Are they really optional? Or maybe they should not even be provided?
> 
> 
> Best regards,
> Krzysztof
