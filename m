Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA158B726
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiHFQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiHFQ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:57:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF15410FDA
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:57:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so5633173pjl.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=76ebmEoyDutcoJLzBfpfA59MP7HNjYrE2nVwUzNVXx4=;
        b=dLTnclgE2wjc9+126UJx527e+Rj1dMy977LR1kRHsSFyHOh8aA+4AHQsok93SqbJsF
         +F/hptCFhvu1WVoblciEw3CUPpmbeW3if3nErWilI5/P9i5ZnSkXoQBheNyRXVgRqsav
         NPo7Fkv2Yx66Ie2QRIOSt3c0hU1+1g3VNRiAo6hKY3mpfGQ2e+PsIxaMbrLtqXB9thkz
         9WQK983L4Shddk7fPlIstdmbsiz0EIL693o06oHu05Z/V+Nt4oCJvYGO0n3kfRO0LNxM
         JUCuznj8JdxUivBIU5Ec4xprF1O0PYgNgeG307pQaT1QRMd9s6IfzG+yU9ymK8m8HHLR
         un3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=76ebmEoyDutcoJLzBfpfA59MP7HNjYrE2nVwUzNVXx4=;
        b=LgF2sjoJ5jZGtJUuTeS3cORp/KUgKCTrgi55yAjZ2Y4IcHhOvApcx8m2Dv4d93bsie
         8r/MSztbWQ29uTV1PEPooKno84/saxj/YwdbpPIVxUSk39LK4Sf9BC0V0vxRBqvtqCnB
         e5z+Fs2jbo2Y5U3DjSxVlqzq0TI4QgisLprw6pUHVFBx9tiDwio5PETbh7n+TBtkEcE3
         249OD+2SxLN6jLLjNPc2IjxpRXj1nRruNpr53NIK0bZWa49+gPM4MzfxjUSZS0EC/y+4
         E+AGS8jEhzMt7xKWmZ93gpgVcQAWDdkU5plhEaJKUOwxHCY62KcFUlvaQuIUA1FmHK1o
         YNYw==
X-Gm-Message-State: ACgBeo1iEb9trbRZ8QUSHmMS5G6wg+YwJfMQtuhS2ze2NiqIk+xz9cI0
        DqArbZeMgN0o2fnlZJ3CAlBR
X-Google-Smtp-Source: AA6agR5MQgs18YRo0UvkMo8BfJN8+desS3CZdbeVc9TyGXbQAWk/9/Y4xUMrmsgaBQlc/YL2zE1E3w==
X-Received: by 2002:a17:903:1d2:b0:16f:1664:dd3b with SMTP id e18-20020a17090301d200b0016f1664dd3bmr12042923plh.60.1659805056384;
        Sat, 06 Aug 2022 09:57:36 -0700 (PDT)
Received: from thinkpad ([117.202.188.20])
        by smtp.gmail.com with ESMTPSA id o7-20020a656147000000b0041cd2417c66sm3334682pgv.18.2022.08.06.09.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:57:36 -0700 (PDT)
Date:   Sat, 6 Aug 2022 22:27:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s:
 disable touchscreen pull-up
Message-ID: <20220806165730.GQ14384@thinkpad>
References: <20220805092317.4985-1-johan+linaro@kernel.org>
 <20220805092317.4985-5-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220805092317.4985-5-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 11:23:14AM +0200, Johan Hovold wrote:
> The (optional) touchscreen interrupt line has an external pull-up so
> disable the internal one as is done for the keyboard and touchpad.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 562b4458e039..85efce641a4e 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -363,7 +363,7 @@ ts0_default: ts0-default-state {
>  		int-n {
>  			pins = "gpio175";
>  			function = "gpio";
> -			bias-pull-up;
> +			bias-disable;
>  		};
>  
>  		reset-n {
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
