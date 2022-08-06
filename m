Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3058B719
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiHFQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiHFQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:55:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4470DEAC
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:55:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id d7so5085772pgc.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6kl7q7xc9eWBDn7eSvFOAeEGxRVc5lkSfi9seiIDDOo=;
        b=SSSICNOijizu3VgA2cp0Zu3CkKA63vyYcTEjLa6TmRxSWG+BbbTXd5a+nCYUUv5+1U
         q4Wfi57XQ9pa5kBeGIzt4kyuhvaAaZhoOYlGzrzRweF0+2u3PuqQS7Ji7MqKP+XkolYw
         ujEJj38McwZT2Y/9fTBvYP6un+Ff5MHgICClZ6zAEQB3BhL3D4AORF1O4TVqTb9uIssi
         TOCanlsNtRmmIcNaEhJ2n97c7kflqd62knyEXN88pK1mTkurfotzP/EeUvZsgEcuu1Mv
         1Fj4edAyQnSeR2df2N9k+CBTztqFKfZcb4s8Dzfh7s5eaL8QtaybU8sWt4hYg6PCldjm
         XI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6kl7q7xc9eWBDn7eSvFOAeEGxRVc5lkSfi9seiIDDOo=;
        b=MIzxvcccvNCG97BcyjukGiIn86ZJxYEEuT6ppD0wp2OFd0imItWR0zU7lMttFPeh8f
         UA9TuysYTtkhBOURHw06OZ3laEHg0cdFQkG8i3cDoamvus4MVYuQpG0FjCE+XgxhGyPd
         tFP8mdgze2WwMudxuIY91OHii/lSYYcUW0bglYjxf/cIqoPuFxdDRM7m7IXpxP+DUx0r
         e2Kr5aLYoLKNOZHOJrSdVjG1AkYT6R7xmXIsTIjDkbFKrFGXPFBkhaidhEMxwgrQRd9h
         ds99BxsUhiMDZvFjN+eFPWomfnxlLFYEfDT7WKbUwnMzLfSERdFHT7bU30R5AT686LXf
         8fQA==
X-Gm-Message-State: ACgBeo1jl92mxKuqbVObBpj+2iaRu3pctFrbn/7LLRreaWldnYoXGE94
        XEVAhNX9ca517QVBWAu59l1u
X-Google-Smtp-Source: AA6agR69j4iV21JddRa7nC+LXwgxSzVR8cWPGvpoCcsw7dnZsGuGUA1R4m+eqci+hWfi1FR2yLkVtg==
X-Received: by 2002:a05:6a00:1505:b0:52e:7bec:63e7 with SMTP id q5-20020a056a00150500b0052e7bec63e7mr11568423pfu.37.1659804900303;
        Sat, 06 Aug 2022 09:55:00 -0700 (PDT)
Received: from thinkpad ([117.202.188.20])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090a420d00b001f260b1954bsm4988804pjg.13.2022.08.06.09.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:54:59 -0700 (PDT)
Date:   Sat, 6 Aug 2022 22:24:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sc8280xp-crd: disable touchscreen
 pull-up
Message-ID: <20220806165454.GN14384@thinkpad>
References: <20220805092317.4985-1-johan+linaro@kernel.org>
 <20220805092317.4985-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220805092317.4985-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 11:23:11AM +0200, Johan Hovold wrote:
> The touchscreen interrupt line has an external pull-up so disable the
> internal one as is done for the keyboard and touchpad.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 6792e88b2c6c..47192e9cf7a4 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -405,7 +405,7 @@ ts0_default: ts0-default-state {
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
