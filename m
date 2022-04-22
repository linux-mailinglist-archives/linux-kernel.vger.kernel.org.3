Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA950BEFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiDVRtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiDVRsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:48:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B501D78FFB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:45:26 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id r12-20020a056830418c00b006054e1142acso5968768otu.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rg2t3QjS7swC7CCiD53ULPLxJwbqove3OB++0DlUPOM=;
        b=rnQZnBYynxzLCkaXTaGnxFQL4AnOzdgbt+/LyfgIxZnFmh2kLZYF489V/PStkDRRk3
         ELRQRo2dmDDnWjViR5NBAGniSK4SV30vYUAREBVPT6rixhn6Z3ZxjCE/ypI+r3c/OLsA
         itQ9wujwDjGfB1gINksmSU1Tlr2sG/OrryEuBTWr6eXsBIhtqzCUbmsidLdh8bRPOwof
         XQpDV7bqra0eFhoTtXIxH4P8sIxHFHeIb3VM/lpdH5riMPJtJhIsjdxC4AArPIXk/6qu
         PS4OyA8Cf62F9JoCLsK87DJnBamhrR2x9P0X6xsk+zwqA0MuLmLM0LbG6ENlECOzYXTf
         whuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rg2t3QjS7swC7CCiD53ULPLxJwbqove3OB++0DlUPOM=;
        b=sM+ehwDOzXsdxzKPbi9UlqIZxAyv7lUeGa6Kc/8eY6k1tkYjkazspAm0vkrNd4OxjW
         DHyjA73A1JJQbxMmJ3vcFCeXl7UzWoFGrfunmbe7TbeyQlylUSqi2qq19yjwRJd+cgdZ
         h2jvjPDvFMskTavKp249mfQYa4RAZrXUWaKUeT899aCKTdMEZKzBxnox2UYkW2i27SM9
         rL1uNmKHZT4GFdSeWdgPROCdV+ZwsIZrvgerAp+RUfsy73gNUrbTEhr2frT3K1jtBBHT
         XSEozN6z61b9/ULruEjJVp0MqWIOCQM9hva+5rCi0zwTTYtoI4lYnBXk86Qn0FUHjNXR
         sjig==
X-Gm-Message-State: AOAM533ZcPKqATet73xJrmzMM+gmfejULD/zA6hhxazHkqivv1I6YRWX
        lUdS9Xht6cf+4v+UlpMWOEBVaw==
X-Google-Smtp-Source: ABdhPJzrJ9MT6DuHvfnHQFUTPgYGuhuBV0Pg3wovOt7szDKz5NOAaGD5S8Ep8UHUxc+wv1y5bNPlxg==
X-Received: by 2002:a05:6830:440a:b0:605:87ec:9b23 with SMTP id q10-20020a056830440a00b0060587ec9b23mr1505671otv.151.1650649388208;
        Fri, 22 Apr 2022 10:43:08 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id z5-20020a4a8085000000b0033a2f400b17sm1033343oof.25.2022.04.22.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:43:07 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:43:01 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Christopher Obbard <chris.obbard@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Alex Bee <knaerzche@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add vdec support for RK3328
Message-ID: <YmLpJQwdcSPHgZag@eze-laptop>
References: <20220422133803.989256-1-chris.obbard@collabora.com>
 <20220422133803.989256-4-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422133803.989256-4-chris.obbard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:38:03PM +0100, Christopher Obbard wrote:
> The RK3328 has an vdec device with dedicated iommu.
> Describe the device and required power-domains in the
> devicetree.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 25 +++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index f8ef149fedad..390e1e4a8fc9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -306,6 +306,10 @@ power-domain@RK3328_PD_HEVC {
>  			};
>  			power-domain@RK3328_PD_VIDEO {
>  				reg = <RK3328_PD_VIDEO>;
> +				clocks = <&cru ACLK_RKVDEC>,
> +					 <&cru HCLK_RKVDEC>,
> +					 <&cru SCLK_VDEC_CABAC>,
> +					 <&cru SCLK_VDEC_CORE>;
>  				#power-domain-cells = <0>;
>  			};
>  			power-domain@RK3328_PD_VPU {
> @@ -660,6 +664,25 @@ vpu_mmu: iommu@ff350800 {
>  		power-domains = <&power RK3328_PD_VPU>;
>  	};
>  
> +	vdec: video-codec@ff360000 {
> +		compatible = "rockchip,rk3328-vdec", "rockchip,rk3399-vdec";
> +		reg = <0x0 0xff360000 0x0 0x400>;
> +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>,
> +			 <&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>;
> +		clock-names = "axi", "ahb", "cabac", "core";
> +		assigned-clocks = <&cru ACLK_RKVDEC>, <&cru SCLK_VDEC_CABAC>,
> +				  <&cru SCLK_VDEC_CORE>;
> +		assigned-clock-rates = <400000000>, <400000000>, <300000000>;
> +		resets = <&cru SRST_VDEC_A>, <&cru SRST_VDEC_H>,
> +			 <&cru SRST_VDEC_CABAC>, <&cru SRST_VDEC_CORE>,
> +			 <&cru SRST_VDEC_NIU_A>, <&cru SRST_VDEC_NIU_H>;
> +		reset-names = "video_a", "video_h", "video_cabac", "video_core",
> +			"niu_a", "niu_h";
> +		iommus = <&vdec_mmu>;
> +		power-domains = <&power RK3328_PD_VIDEO>;
> +	};
> +
>  	vdec_mmu: iommu@ff360480 {
>  		compatible = "rockchip,iommu";
>  		reg = <0x0 0xff360480 0x0 0x40>, <0x0 0xff3604c0 0x0 0x40>;
> @@ -667,7 +690,7 @@ vdec_mmu: iommu@ff360480 {
>  		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>;
>  		clock-names = "aclk", "iface";
>  		#iommu-cells = <0>;
> -		status = "disabled";
> +		power-domains = <&power RK3328_PD_VIDEO>;
>  	};
>  
>  	vop: vop@ff370000 {
> -- 
> 2.34.1
> 
