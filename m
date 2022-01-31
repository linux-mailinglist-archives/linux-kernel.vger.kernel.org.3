Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C68A4A52B7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiAaW5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiAaW5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:57:35 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2575C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:57:35 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so3562583oov.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dN1eWoFdpgCZVld6VXRl4qQRQ3uz/MKpz+wMFlzFQrA=;
        b=R023hhJF5fERNWKU07shRsYyUTlQD46lARD776Z3yLzpInKwAIAhFMxDclzomELD5Y
         SFJvs3fnHI2JMYG4SaMPxn3qe7yoZEwwAduV3xjCC0UpIiKSOyaWYsQKMRR/eeSMgtOu
         BKtUkN3Yk+33I5v/VM8aMY5DqG1vfXAVTAf8R0IY83pBT3xP3zqyPbFMQiaZZ7LBTB8A
         nq6Zd+sY+7bo9+xrhBEsf92mPrbE6bZFAOGaJZVo/TbdWVWAcp+uiiFPKfpehCLGL11J
         6FVnTB+addNSCn5wcrMQXVE9iDy3WJrXeY0z897DS6SPZrGUAVQmSPDua4LhZ+vU8OV2
         yIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dN1eWoFdpgCZVld6VXRl4qQRQ3uz/MKpz+wMFlzFQrA=;
        b=NH4x9iSvLGpA04NSRMPnAUHxP3lEXPZn7jzwGrXVDNMAI/r0PyzoEH81sWMEqas/qK
         M3sTE5S6f6zX4qwK6piolGlAq2Rx9GpBuq1cvVfIfpFvzPxXgdna56n7m1lhooFClg+s
         AzGpPRQtaLkBS5+GinWyeOUfV3GVqU6MZj7TZCr5+IZYGP8gHCan7sK+dmb7uixIlHsO
         ASHo+UqonmKwQvXLN2qdrFTIyicAlFVU9GrckE0tSg8oo5qCIhIKuRDwrPiBQx9pic58
         nAgyg2R48hk34Ot7QjQ2wY+xxddtF172xbIGzEv8/UQOzsC1kpP4TO9DQD2iB+DFPQSv
         PINg==
X-Gm-Message-State: AOAM5331k4YIU0cOVrXxr3GU9BnhvZzkRSvCH8j5S3wUQnMnKMbIWgcT
        pLSsyJuzyXZKu9zqO7rE7GcypA==
X-Google-Smtp-Source: ABdhPJwRn6LacBFjex+kHprwEqwpJmOke2/IQAUMOEKO+ejw3nSLsT3YbO/WmS6me/j05Nej/NHk6w==
X-Received: by 2002:a9d:5c8a:: with SMTP id a10mr12764932oti.248.1643669855224;
        Mon, 31 Jan 2022 14:57:35 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id 31sm12099372otr.13.2022.01.31.14.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:57:34 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:57:32 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sc7280: Support gpu speedbin
Message-ID: <YfhpXFNcl4L+1rah@builder.lan>
References: <20220119205012.v2.1.Ibac66e1e0e565313bc28f192e6c94cb508f205eb@changeid>
 <20220119205012.v2.2.I4c2cb95f06f0c37038c80cc1ad20563fdf0618e2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119205012.v2.2.I4c2cb95f06f0c37038c80cc1ad20563fdf0618e2@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Jan 09:21 CST 2022, Akhil P Oommen wrote:

> Add the speedbin fuse and the required opps to support gpu sku.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 46 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 365a2e0..f8fc8b8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -605,6 +605,11 @@
>  			power-domains = <&rpmhpd SC7280_MX>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +
> +			gpu_speed_bin: gpu_speed_bin@1e9 {

No underscores in node names please.

Regards,
Bjorn

> +				reg = <0x1e9 0x2>;
> +				bits = <5 8>;
> +			};
>  		};
>  
>  		sdhc_1: sdhci@7c4000 {
> @@ -1762,6 +1767,9 @@
>  			interconnect-names = "gfx-mem";
>  			#cooling-cells = <2>;
>  
> +			nvmem-cells = <&gpu_speed_bin>;
> +			nvmem-cell-names = "speed_bin";
> +
>  			gpu_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
> @@ -1769,18 +1777,56 @@
>  					opp-hz = /bits/ 64 <315000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>  					opp-peak-kBps = <1804000>;
> +					opp-supported-hw = <0x03>;
>  				};
>  
>  				opp-450000000 {
>  					opp-hz = /bits/ 64 <450000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>  					opp-peak-kBps = <4068000>;
> +					opp-supported-hw = <0x03>;
>  				};
>  
>  				opp-550000000 {
>  					opp-hz = /bits/ 64 <550000000>;
>  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>  					opp-peak-kBps = <6832000>;
> +					opp-supported-hw = <0x03>;
> +				};
> +
> +				opp-608000000 {
> +					opp-hz = /bits/ 64 <608000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
> +					opp-peak-kBps = <8368000>;
> +					opp-supported-hw = <0x02>;
> +				};
> +
> +				opp-700000000 {
> +					opp-hz = /bits/ 64 <700000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					opp-peak-kBps = <8532000>;
> +					opp-supported-hw = <0x02>;
> +				};
> +
> +				opp-812000000 {
> +					opp-hz = /bits/ 64 <812000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					opp-peak-kBps = <8532000>;
> +					opp-supported-hw = <0x02>;
> +				};
> +
> +				opp-840000000 {
> +					opp-hz = /bits/ 64 <840000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					opp-peak-kBps = <8532000>;
> +					opp-supported-hw = <0x02>;
> +				};
> +
> +				opp-900000000 {
> +					opp-hz = /bits/ 64 <900000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					opp-peak-kBps = <8532000>;
> +					opp-supported-hw = <0x02>;
>  				};
>  			};
>  		};
> -- 
> 2.7.4
> 
