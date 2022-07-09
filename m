Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630C256C7C4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGIHua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGIHu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 03:50:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CA93ED67
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 00:50:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a15so828852pfv.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 00:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yMfpiE9grWAGWTOlyBH6CFYlcFupIx5Mf4UNkVo3g3Q=;
        b=Vlek+yevX1Ayy2RxpRcADiBJMyxptQdotOEAbiPPZlSpAuDRSHZQUbMGvXCdWvXcM6
         61fRPwhNDjGsOirYSsuV7Dh+tpcqvR2/1b46fZOVHspGx6FPFn1ByH6XL6N/O12pCtzl
         U29gdhuN3pZH91DyeHOq9+Zw7KZdK5m6dWo3Igt+THctHV8THGoiqDNb8pD2ynwJ+P5F
         dZglCk7lYAQCTOOnB45nj530SaW6tSlTFVQYlWNG1DmManJhx+UujqKKq/nDR5M29utH
         eRqGwYggXi5E8Gd1vLekFwYj/4kHuZpOJgCCWSF4RUta9HJuqX0ZMSxaj2L91aZaV+EG
         TQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yMfpiE9grWAGWTOlyBH6CFYlcFupIx5Mf4UNkVo3g3Q=;
        b=WplqaaibclAsfe0l9oFUNUVg9UDNILiuTJG5azB4K62RtFLU3+Gel8/SSQ6vNLyffG
         PhTceYT9Y0mjrppMx8MdodnzrRajDVkdtHWqwU69pTcAKEPpPvvtP2w9IV4eiaxdaw3r
         C7Ef1fJB1vtgSqMsy3fdNYiWMx79cGGH/7BnHoyi4UVQH4nRBtFA+5nKwm6Qagz8fIof
         9QuapTPYqtnJ+x6RRhXmqrqFUnFKncpRj76u8z5kq6Y31bez9Njbu8JK/+WKIaZUD8hq
         +uKGQSvLsYC05exX7sPtPf2wejZ0k+kZhz4q4CwDrAk3Ox7nwnyAkVsGeg8B+3ig5Czz
         LZ/g==
X-Gm-Message-State: AJIora//fEPa09HIuGYS9o3OoHySRP/8JaSxUnnKcFKdmlr5JcZxNKkb
        VWmksSLlRE1FA162GKW9V4qN
X-Google-Smtp-Source: AGRyM1vPoOQg2mf4YJs9uorcFuSPAoAm6lnOZgF1aeZHQrjGq3y0Dt/z46mNPVnqVaaQrse1Jbe4Pg==
X-Received: by 2002:a63:de04:0:b0:412:b0b0:88a2 with SMTP id f4-20020a63de04000000b00412b0b088a2mr6474955pgg.585.1657353025697;
        Sat, 09 Jul 2022 00:50:25 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b0015e8d4eb2ddsm703844plx.295.2022.07.09.00.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 00:50:25 -0700 (PDT)
Date:   Sat, 9 Jul 2022 13:20:17 +0530
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
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Fix msi-interrupt
 conditional
Message-ID: <20220709075017.GI5063@thinkpad>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629141000.18111-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:52PM +0200, Johan Hovold wrote:
> Fix the msi-interrupt conditional which always evaluated to false due to
> a misspelled property name ("compatibles" in plural).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index ed9f9462a758..a1b4fc70e162 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -628,7 +628,7 @@ allOf:
>      # On older chipsets it's always 1 msi interrupt
>    - if:
>        properties:
> -        compatibles:
> +        compatible:
>            contains:
>              enum:
>                - qcom,pcie-msm8996
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
