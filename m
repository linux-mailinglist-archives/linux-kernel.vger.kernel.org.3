Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B556C7CF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 10:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiGIIBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGIIBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 04:01:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002C70986
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 01:01:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id r1so588841plo.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 01:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Kv2xJstIHFNMVTi9JObJDGpbOPxYWB6plwIYntYZfnU=;
        b=hT7PdxzrgY4kMYwSPZVvWBwVaMEUe07GcOlkS0BW2Zim6pVS9k01bQBFO/1zxpeJJf
         WoCuCHnWD4Co9hA/VtKmddftYXp1OesZlPj+wPL91leKm1IDbVUGvDssH6/P5sFlaK4K
         ykAGvX0aZHryLfE4ICOoSyE7OueMijWR23AjRJiiElyoK4dwda1SY0XmDbvsPRgucR/v
         6Aq25yX8bZ0leaZf75sx9v8V6YWPPNhnEKP3/R9I8/4dGQ71d/v3hhQpRRTpQnhtwxNN
         fOyA19ytLilWESJnY8g+ASvrupaLDcWTFaFcIHEueC3boWSzyziLH7Ibs7bpomsPafQb
         tQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Kv2xJstIHFNMVTi9JObJDGpbOPxYWB6plwIYntYZfnU=;
        b=F9qaYdWAl3fWc6vg0Cy3EoCiOnX+inzvv8S1KSz24tkSxRbINl4A3ralngPL1NyFpr
         zwVROFUz8MZ7euDgWB+4DKklYRVXbtGO3Gq1bC8aPU38+HwLtu5aEXc5uD4fTI8pf7PK
         QMiaZ6WFLUyXVgBz2WwvlEpqaWo8of1Gsj0k99DrEerqKW6z1R9znHincYkczjcApf4S
         yKK68wXgOI9lGniG3dEBKQz7VuRbGC83CH6iRntHrkuT/J1GqoW0WMRuKAOxhs5nPlEP
         AMFVN6h7TlNe1MghlApIVnPqEPflq5deOe0bDKFKjofP4U7g7ErPLTL4PIQfmGF/KQ/H
         X7+w==
X-Gm-Message-State: AJIora8ntEIry1dYktSybA5UjMOsejkHCER7nV6VKIt5YsZMu5ii9+h3
        mF+WXG6NkdCxXRh34Z/4J28h
X-Google-Smtp-Source: AGRyM1t6ezElgdxxHGRnMkuUkUoVzAQGBgNEEykjrteiLAautAVsJn4UFw4R9UDVM0fFvlDU7XBl5Q==
X-Received: by 2002:a17:902:9041:b0:16a:aef:7b84 with SMTP id w1-20020a170902904100b0016a0aef7b84mr7929453plz.124.1657353663842;
        Sat, 09 Jul 2022 01:01:03 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b0016bc947c5b7sm761888plg.38.2022.07.09.01.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 01:01:03 -0700 (PDT)
Date:   Sat, 9 Jul 2022 13:30:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: PCI: qcom: Add SC8280XP to binding
Message-ID: <20220709080053.GK5063@thinkpad>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-5-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629141000.18111-5-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:54PM +0200, Johan Hovold wrote:
> Add the SC8280XP platform to the binding.
> 
> SC8280XP use four host interrupts for MSI routing so remove the obsolete
> comment referring to newer chipsets supporting one or eight interrupts
> (e.g. for backwards compatibility).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Wondering why 4 on this SoC. Is this what added in downstream or you also
verified it with IP documentation.

Thanks,
Mani

> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 50 ++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 8560c65e6f0b..a039f6110322 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -27,6 +27,7 @@ properties:
>        - qcom,pcie-qcs404
>        - qcom,pcie-sc7280
>        - qcom,pcie-sc8180x
> +      - qcom,pcie-sc8280xp
>        - qcom,pcie-sdm845
>        - qcom,pcie-sm8150
>        - qcom,pcie-sm8250
> @@ -181,6 +182,7 @@ allOf:
>              enum:
>                - qcom,pcie-sc7280
>                - qcom,pcie-sc8180x
> +              - qcom,pcie-sc8280xp
>                - qcom,pcie-sm8250
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> @@ -596,6 +598,35 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sc8280xp
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 8
> +          maxItems: 9
> +        clock-names:
> +          minItems: 8
> +          items:
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: noc_aggr_4 # NoC aggregate 4 clock
> +            - const: noc_aggr_south_sf # NoC aggregate South SF clock
> +            - const: cnoc_qx # Configuration NoC QX clock
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +
>    - if:
>        not:
>          properties:
> @@ -624,7 +655,6 @@ allOf:
>          - resets
>          - reset-names
>  
> -    # On newer chipsets support either 1 or 8 msi interrupts
>    - if:
>        properties:
>          compatible:
> @@ -660,6 +690,24 @@ allOf:
>                  - const: msi6
>                  - const: msi7
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sc8280xp
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 4
> +          maxItems: 4
> +        interrupt-names:
> +          items:
> +            - const: msi0
> +            - const: msi1
> +            - const: msi2
> +            - const: msi3
> +
>    - if:
>        properties:
>          compatible:
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
