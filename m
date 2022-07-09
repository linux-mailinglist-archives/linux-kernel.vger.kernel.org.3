Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D5356C7C9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 09:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiGIH6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 03:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIH6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 03:58:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211ED3FA03
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 00:58:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so3934350pjm.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZktL6pWVxWtO8JEUAfFR8KFdmXT8IyrBysT9NTOXmkA=;
        b=N/BiYGuIB6y6lsusYzSTEj3rMEznNOz53heND4CajXFuyZ6gSgon+IXbF9L2lKWYxv
         pPQQa986MSI8kKSwde/2h8K/E0GnhQUb//K+lWH9mE+AvRskXu8kSlrIbs2x04ssehzq
         ZjGmtEUp/303ToJTE7HhiB7Re9JrL/t28rHcKze0zij1kG1lLB2GsFW2VQPUdqEtihIk
         1YjVyG1y0A2whjMH+Fo+04z1SgyMWuCd6x5XmY+NM4zUNBujaARtgW50M/Z7SdduiMA6
         f81oG99SLVrHG8sWgOoOSPdKtBrhaWlR1L+bE1m/hbqQ/Z9n2/JWVPFIilaIA14EQyO7
         qX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZktL6pWVxWtO8JEUAfFR8KFdmXT8IyrBysT9NTOXmkA=;
        b=dsjxU+8//zeFrrLfA6uRCi1JQUWK85ppL5K6QkTshX6NvwUh5W4npLjtwv3Gmf5Dam
         4jmR8Qd8SYEUFtFwohJ9CEYZu38x+OU00sXNCYCh9tg19i6GMPOns9e22QkqJHaat5C8
         fj5UsrdSVttFzTKjhgQl5YkN0lAtsrWcBa/sitrNxD0hLAIyIBPFHuyUHYaFQ8XtzikS
         M++h5SnbKM0hzsFq6QOmevLYLLoSWGfqC1PSOAHwbEpHcjLeWH5mvl0f8vHblbt/QGGm
         ASbfiwx8Osze8IuFQkF7S9q7K8XvVT1dc/VXZoQhTTDexNl7zYpKYbJMLNofCQUj+4qx
         jEhA==
X-Gm-Message-State: AJIora+ksv8JdAxJi0mvwzkAfUTwx9z08nt/B9bxhmJVVBfn8cZKzxmf
        gm50wYgNhp7Yl+psJJTCabUO
X-Google-Smtp-Source: AGRyM1svGE0duh2gyQzidPCAWVGxgd7PJRFONpnpjftZ1stb7vU/v+bCnO+IUiJDvkfDVCrz4rxYvg==
X-Received: by 2002:a17:90b:278b:b0:1ef:b15e:61e3 with SMTP id pw11-20020a17090b278b00b001efb15e61e3mr4519506pjb.143.1657353530524;
        Sat, 09 Jul 2022 00:58:50 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id p6-20020a625b06000000b0052abc2438f1sm596742pfb.55.2022.07.09.00.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 00:58:50 -0700 (PDT)
Date:   Sat, 9 Jul 2022 13:28:39 +0530
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
Subject: Re: [PATCH 03/10] dt-bindings: PCI: qcom: Enumerate platforms with
 single msi interrupt
Message-ID: <20220709075839.GJ5063@thinkpad>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629141000.18111-4-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:53PM +0200, Johan Hovold wrote:
> Explicitly enumerate the older platforms that have a single msi host
> interrupt. This allows for adding further platforms without resorting
> to nested conditionals.
> 
> Drop the redundant comment about older chipsets instead of moving it.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

With the comment from Krzysztof on wording mentioned in patch 4/10
addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani


> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml      | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a1b4fc70e162..8560c65e6f0b 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -625,7 +625,6 @@ allOf:
>          - reset-names
>  
>      # On newer chipsets support either 1 or 8 msi interrupts
> -    # On older chipsets it's always 1 msi interrupt
>    - if:
>        properties:
>          compatible:
> @@ -660,7 +659,21 @@ allOf:
>                  - const: msi5
>                  - const: msi6
>                  - const: msi7
> -    else:
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-apq8064
> +              - qcom,pcie-apq8084
> +              - qcom,pcie-ipq4019
> +              - qcom,pcie-ipq6018
> +              - qcom,pcie-ipq8064
> +              - qcom,pcie-ipq8064-v2
> +              - qcom,pcie-ipq8074
> +              - qcom,pcie-qcs404
> +    then:
>        properties:
>          interrupts:
>            maxItems: 1
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
