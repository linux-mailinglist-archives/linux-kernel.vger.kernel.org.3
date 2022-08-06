Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFDE58B71D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiHFQ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiHFQ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:57:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5693EDED5
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:57:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso10878863pjf.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fwvVz3ZPNf1Ua4BJXgNnz062mWeBDEEWiBC/4i632uM=;
        b=UsaZP4n5lbS6AHNXgKun6rTZN8kjhea9TnD0P67vH9gDHbXki2lnEsUYE2K1/Ux3m3
         BnWL54UmBE1wEPnemy4ctmQnnDO4beGdpauxnBajSw73ffFFlw3FdgNgJq8rAYtxS0/y
         xbTs96mDVrFm/79NGdbI/eIIXKp6jQmMgASHwnEN4a/0agRvl96so3mozh7naw3Cb2YR
         EH/EAI6dacd12OZsTiyBDjomRBdmeiBxOAa/7yWrT9fq0sescPGyDOTzGl2r9dFoPXi9
         bEsjMlFtZN5Ilwg/F94rXqyLFP1HusK7C9il9PCgS0a9j37AH+88lgurWqHgmOW8/bzb
         DJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fwvVz3ZPNf1Ua4BJXgNnz062mWeBDEEWiBC/4i632uM=;
        b=m1EqK/dLsy66kIHTAOPdOYxxdAO67YLJk65Zd0j049QGIWOhbP3EEhHHnzoLcd7xjt
         Rbtqe15CfRVAlAQ/Tx3Sq+BhT6jbN5DeYKpk0jixe0KVn4jyI253sQ1f7wfQBtaL65+A
         TCGo4VhnDz79jmuv+SVwIERyE93WmwJBdtq4IsBwCj5LKtRNnkL7Y4V2Es/HoP9nKSLA
         u9Eg8QDUk3D4vcWPBXf0fk3YD2J2zmWDqGYc3kWzkWpZzdJ/cwzMZ4WieJJkb/v+5FBm
         eNuHh4qHgF/DzRdAzN3yAJzq71CFmsb8DXyAm3soiDaUGkwoGxxLZh0ITSwJmLYZ3e1J
         Qspg==
X-Gm-Message-State: ACgBeo07JizoLEGQM4/zTiQJsHNbuH7OFrG1uTv49FNfFaPB129oHXI3
        Dw2zsRYaQJMsbxQ4j6F/eu5h
X-Google-Smtp-Source: AA6agR7ESBRGzNpxO609+Ee4UmCGERmwQkH+j7vG0fhAMAiaSiTEYGdTGwaX0tq8g8QMbFbuN5eeTw==
X-Received: by 2002:a17:903:1111:b0:16a:acf4:e951 with SMTP id n17-20020a170903111100b0016aacf4e951mr11525532plh.72.1659805028962;
        Sat, 06 Aug 2022 09:57:08 -0700 (PDT)
Received: from thinkpad ([117.202.188.20])
        by smtp.gmail.com with ESMTPSA id g17-20020aa79f11000000b0052d3899f8c3sm5320852pfr.36.2022.08.06.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:57:08 -0700 (PDT)
Date:   Sat, 6 Aug 2022 22:27:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] arm64: dts: qcom: sc8280xp-crd: mark HID wakeup
 sources
Message-ID: <20220806165703.GP14384@thinkpad>
References: <20220805092317.4985-1-johan+linaro@kernel.org>
 <20220805092317.4985-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220805092317.4985-4-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 11:23:13AM +0200, Johan Hovold wrote:
> The touchpad and keyboard can wake the system from suspend so declare
> them as wakeup sources.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index ae8be1b743ce..fea7d8273ccd 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -237,6 +237,8 @@ touchpad@15 {
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&tpad_default>;
> +
> +		wakeup-source;
>  	};
>  
>  	keyboard@68 {
> @@ -249,6 +251,8 @@ keyboard@68 {
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&kybd_default>;
> +
> +		wakeup-source;
>  	};
>  };
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
