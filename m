Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3B551D1F2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388410AbiEFHJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388382AbiEFHJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:09:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E75DD34
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:05:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so10047609pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cGsWnmcdsW5+Xbz2FC0gnC+YhC9gKY5ai2q+ZLxNWKk=;
        b=iGfeU6j4YOla+JtEHUOB09UfEODgM9SORI0CjiGCK3q2DfKIne0qOPtu0MdS35Rotn
         Hx32nUuF+ubpNJfY6lFTixhB70XxgTCUCCJoFGINp7JQUwqslisT8ONxyMiucPfwmVQo
         BcFb8kYte/P5jcgoSxwC16k4VOUSXc8gItHA/Ex91Ubt4UdlZTQ6mexhIy/yn5JqZsmj
         Fr6aheufgPglMQ0D7EQSMolgLewxrLfZaHj1bxb3I0gKzPRzRQQemhkTmtazoSrtpyMr
         nzwuClYjHKZW6ndVApHAanUqj7vWmsckKD0+ywNg+CaxDC4w/gXYRww+HpnawMjnneyQ
         aFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cGsWnmcdsW5+Xbz2FC0gnC+YhC9gKY5ai2q+ZLxNWKk=;
        b=kWdbGihqfVD1cYwm31efqOyvUjWovYNo+KpPavtRN/CgBjl56cDu/wmyqGj18Yad7s
         vmCzKLFHAc3ZkqXJBSdiN8VfHtuv+Cniw566sTQrWEucUQbfVklL0GO3Ceha/F4ghRVi
         sRzy461/qqM7c6p53rZ02tED0VBHfDyiOVDCmh6bhqnKtsBoFYox4PRceqp8xyzjVp3l
         vaLaYUDPHYsX1s/dteJO91PFMt2rerD73GUzUgj+ghfNxqAYGogQ5Wut8ylYklDtTIox
         v8SjZvA4PFfKqwYpvbRYQOvjx0EKChqMKO0OOmT9sZXlHiOICRxBt9ekYls0dIDeVMiC
         r2zA==
X-Gm-Message-State: AOAM5315vLiTtIoXUZvdv5dgznL31HKePau9RocGv1UvXZtxzl+/bmL2
        s1z4d8w1OVQuePQu/PsBN5ez
X-Google-Smtp-Source: ABdhPJzsB3eC1EyI0ybZRmYrUTNiZQMxNEEm9JOshBJBQsw2h5Kg3NaX5TAl6/ej75kNHI1+th2v3Q==
X-Received: by 2002:a17:903:244c:b0:15e:b3f7:950d with SMTP id l12-20020a170903244c00b0015eb3f7950dmr2086414pls.9.1651820737005;
        Fri, 06 May 2022 00:05:37 -0700 (PDT)
Received: from thinkpad ([117.207.26.33])
        by smtp.gmail.com with ESMTPSA id v1-20020a622f01000000b0050dc76281c5sm2573828pfv.159.2022.05.06.00.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 00:05:36 -0700 (PDT)
Date:   Fri, 6 May 2022 12:35:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ARM: dts: qcom: sdx65-mtp: Enable USB3 and PHY
 support
Message-ID: <20220506070531.GE17659@thinkpad>
References: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651482395-29443-5-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1651482395-29443-5-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 02:36:35PM +0530, Rohit Agarwal wrote:
> Enable the support for USB3 controller, QMP PHY and HS PHY on SDX65 MTP.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

I hope you have tested the interface using a gadget driver.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index 79dc31a..6920524 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -123,7 +123,7 @@
>  			regulator-max-microvolt = <1300000>;
>  		};
>  
> -		ldo1 {
> +		vreg_l1b_1p2: ldo1 {
>  			regulator-min-microvolt = <1200000>;
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> @@ -141,13 +141,13 @@
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> -		ldo4 {
> +		vreg_l4b_0p88: ldo4 {
>  			regulator-min-microvolt = <880000>;
>  			regulator-max-microvolt = <912000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> -		ldo5 {
> +		vreg_l5b_1p8: ldo5 {
>  			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <1800000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> @@ -177,7 +177,7 @@
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> -		ldo10 {
> +		vreg_l10b_3p08: ldo10 {
>  			regulator-min-microvolt = <3088000>;
>  			regulator-max-microvolt = <3088000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> @@ -244,3 +244,24 @@
>  		};
>  	};
>  };
> +
> +&usb {
> +	status = "okay";
> +};
> +
> +&usb_dwc3 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_hsphy {
> +	status = "okay";
> +	vdda-pll-supply = <&vreg_l4b_0p88>;
> +	vdda33-supply = <&vreg_l10b_3p08>;
> +	vdda18-supply = <&vreg_l5b_1p8>;
> +};
> +
> +&usb_qmpphy {
> +	status = "okay";
> +	vdda-phy-supply = <&vreg_l4b_0p88>;
> +	vdda-pll-supply = <&vreg_l1b_1p2>;
> +};
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
