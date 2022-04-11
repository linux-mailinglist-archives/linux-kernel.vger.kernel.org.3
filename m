Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A0F4FB4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiDKHeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245458AbiDKHdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:33:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8FC3D4B5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:31:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s8so13828804pfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FfEzcEDEdqQNmI2+YlsWqpFHuyfIdxXuU7HJ0a4fGQo=;
        b=sI/ocz9wDZjxqQqOzNmUcUDPN9KrGYS3zYDMdkd/sWnqmiDS1qt93vVIsObw85l7D9
         tlheE45On53591S96LiPbVvo19qWHmNxVLuoxaGKXaR5s1I2i1aqGq9aynFgTqH/GYES
         d1591qqOSCVrOLcI1VKeXoNHewXSF/oesLBGcfM+nlrpuYiTX1UiNtBmc9WMNqfrhqaF
         r72BDpgCqppBoyRm+TQetcd0kIhaTKzUj/1uEFHFVxzEJgsLG0Fd/uzUi+9fvZUXQaLx
         vSsSHMG7dmUJfSs9x8IiErIWasoH/m+FWmuFI/Y9Cixwc8l1a4RfKVS/IKeYDRCNx000
         95uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfEzcEDEdqQNmI2+YlsWqpFHuyfIdxXuU7HJ0a4fGQo=;
        b=MuNCXw69tQUvt7k1gpFB7a16/uzim8QmGWm4q+31LXN0eGpsuNi58c7+wGyGeya0Pv
         ZLztJ/4snOAJYAXxZ+eFwFHK+iY2bLYihau/q3A1VRDzmk7QrHMvSNis/9n6dnjO8XAK
         7Iw+3tHXtARukILmrGzmbVJsctKlRaGPZqJSRU+V64/Qt05G5ydWvo3o6ErlLSMkwirN
         e7NZoOwWgCTBO7dYKXNribSpRsNDVlgKqFVGqP082tb5hK7V61zOxkoyzBKNtEUmZ4IZ
         CS1FuEdHLiADRMUOtLrUCi3+bT8JJZ99S9QNJKGcfqSwB7cRCNo0F4QICZ4WqmtRlCNK
         fgmg==
X-Gm-Message-State: AOAM531b50QFXydqVlCsJpUTGyHDDfygP3x27LGxwUE814FdTs380Xvf
        mIwAeOMBStdqKcNu4UzCj0WP
X-Google-Smtp-Source: ABdhPJx2Xho7Q5HAaLdf8iiaBePJw/O334cIT0KhKVd34d6Wo1TE9jRJs8qmvQqrP21VT/DmNFOI+w==
X-Received: by 2002:a63:3185:0:b0:39c:c854:34ae with SMTP id x127-20020a633185000000b0039cc85434aemr16189345pgx.13.1649662292941;
        Mon, 11 Apr 2022 00:31:32 -0700 (PDT)
Received: from thinkpad ([117.217.182.106])
        by smtp.gmail.com with ESMTPSA id a9-20020a056a000c8900b004fb37ecc6bbsm35321318pfv.65.2022.04.11.00.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 00:31:32 -0700 (PDT)
Date:   Mon, 11 Apr 2022 13:01:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/7] ARM: dts: qcom: sdx65: Add support for SDHCI
 controller
Message-ID: <20220411073124.GC24975@thinkpad>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649660143-22400-4-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649660143-22400-4-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:25:39PM +0530, Rohit Agarwal wrote:
> Add devicetree support for SDHCI controller found in Qualcomm SDX65
> platform. The SDHCI controller is based on the MSM SDHCI v5 IP.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 365df74..632ac78 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -168,6 +168,19 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		sdhc_1: sdhci@8804000 {
> +			compatible = "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x08804000 0x1000>;
> +			reg-names = "hc_mem";
> +			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> +				<&gcc GCC_SDCC1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
>  		pdc: interrupt-controller@b210000 {
>  			compatible = "qcom,sdx65-pdc", "qcom,pdc";
>  			reg = <0xb210000 0x10000>;
> -- 
> 2.7.4
> 
