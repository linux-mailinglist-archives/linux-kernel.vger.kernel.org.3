Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3A56C7F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiGIITX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 04:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGIITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 04:19:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE45B747A7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 01:19:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so653252pjf.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XYytBhjFDte4ukeddP8GL3eEazUdm96Q+RTOUDhx6WI=;
        b=sfuy1IOjvtSoFBnaR5YiWXaxQZRMe9TzSYs8Tqd1is2Dh8fmNZHYJ9B1osPTXYhVUj
         TsVKA/F24UiGa0UXQK43ZLXsz93/9PjFXaoV3GNt2nc/9CqJF/D50sFt+3uiubqAx3Ix
         XkwsTtqvuqVhr67bJ1/i+zZAv227o6aBdB/owBfX6u6njLODuO4rkVfIMYDdZpLJGmo+
         oRNyTS0I/sBOI8XH2aAJDWVgGWQvvWHu9bzS3hcff4IBSKpPbnECpWHifcmH9JR56Xki
         gO2EzWQJWY0Ee0gm+GdISwken0hAS8wh002lvdyczNTjNfTfp3p/44P5pl8un4EJjX9Z
         bsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XYytBhjFDte4ukeddP8GL3eEazUdm96Q+RTOUDhx6WI=;
        b=JnvmDux51ztEKIUDug4PxkdfP0zIL/FsIYKzWMCF8D0phB8K+e4KTUHsiQdAevSh7b
         1gNMmartHNsJ8Z2eVWUKIrmIBnSIj1mvrdfFyOXXMi36P4sz+ih0TsIMMav1TTdu9nv1
         548aSHfggUMrJFWTYnRmkmsHiYJ9FUBt8lU+AgozpHSAgG9GVYtQbqEZA6fUEKE5WlI1
         ofEmWQur8yI3nEXxIb9pDTjXZDb1aSz7B++SudLcbDgUS+cZbwQDxNSn1dzlby5YIfuR
         vJQfwhYBrkYcZyiXte7P1Jy4M1pLwsjOXecfReOXu2L+zbEEo7YNLBKJ2vywD40ZjYcN
         EPXw==
X-Gm-Message-State: AJIora8SFPdZd40sacPVa0184p3sBjrgFt/C3xxCzCr2E9eJquRqsiXG
        jCo7t5kXhjVh/6Pxk1I2MKJWvsO9pXA0
X-Google-Smtp-Source: AGRyM1vNlPDz9NAYWfXTtW0pwGQeLJSMgUs89J5AozN9cA3Zay4iiv+XhYQJukyb+eKY/R43djKrwQ==
X-Received: by 2002:a17:902:d292:b0:16b:e6a4:5768 with SMTP id t18-20020a170902d29200b0016be6a45768mr7904280plc.128.1657354758213;
        Sat, 09 Jul 2022 01:19:18 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id ka19-20020a17090b475300b001ec798b0dc4sm651647pjb.38.2022.07.09.01.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 01:19:17 -0700 (PDT)
Date:   Sat, 9 Jul 2022 13:49:08 +0530
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
Subject: Re: [PATCH 07/10] PCI: qcom: Add support for SA8540P
Message-ID: <20220709081908.GN5063@thinkpad>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-8-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629141000.18111-8-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:57PM +0200, Johan Hovold wrote:
> The SA8540P platform has five PCIe controllers: two 4-lane, two 2-lane
> and one 1-lane.
> 
> Add a new "qcom,pcie-sa8540p" compatible string and reuse the 1.9.0 ops.
> 
> Note that like for SC8280XP, the SA8540 controllers need two or three
> interconnect clocks to be enabled.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index da3f1cdc4ba6..8ab88e5743da 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1461,6 +1461,11 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
>  	.ops = &ops_2_4_0,
>  };
>  
> +static const struct qcom_pcie_cfg sa8540p_cfg = {
> +	.ops = &ops_1_9_0,
> +	.has_ddrss_sf_tbu_clk = true,
> +};
> +
>  static const struct qcom_pcie_cfg sc8280xp_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_ddrss_sf_tbu_clk = true,
> @@ -1626,6 +1631,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &ipq8074_cfg },
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
> +	{ .compatible = "qcom,pcie-sa8540p", .data = &sa8540p_cfg },
>  	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
>  	{ .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
>  	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
