Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5451D1E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388356AbiEFHHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388234AbiEFHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:07:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D7266CBC
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:03:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so5986549pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=N/CJ0IuFbENZ0XsBpfzxU2/XIsUvMC250wn/I1eAZN8=;
        b=Y1sh2qXlw6QwJ297F0lnTnGcr4ixHMCxlLL5it9fsZWQi0J0/Wr73Otc5aj10rbe5t
         /oFNN/n5ncdnecJzxnYHpoqSbyYVDlzNdx2R1mcdxYjvrzFQJ0Gda/HbX/YsMb1DUDHU
         AfQ5q6Ikaszl5XlLr3kVyKAM6jy8p7qttCIuciddixWXOD+UqrUu8ePch4wxPbtQ06NU
         m3s9wP/0TGrrkTdtx/jce36zGKORlnV6csfFnZgLldICCA2JuDHqHDzknXkIC5imAoVl
         /W3qIKCSGbuyzjhdpXW2egv6vFcsEHnzQHZcTYpv47FCzZItW4f8cEk8I9vL85PY+pw9
         AVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N/CJ0IuFbENZ0XsBpfzxU2/XIsUvMC250wn/I1eAZN8=;
        b=zmxHODlYrCEksYqT/2YNdCBra1tOhWjsvvUt5S+MFLc/cxJB+yEaeVbr2tEtAqFkx2
         NvmSNa73m8X5jCjehRjO78970BfJ6WO2ienDR14QNY46WzSQ+cUS8xRN+BCXX6m7jo24
         E9nrjyf9EUYJ8HMTqCELEUj9KUMSryauZPAJOVAB2SOOk2tXQp4qTOScDEoxKhw/HXR3
         dtpVmvpeqAV871qgcslxuX4yKIi17Mt/MOSMVpSpG4YJ6xjK9BUkhd6vzTUub33+D+my
         o4rvqqlf/VocDII/oBCHWajfg+txfF2pQxnLRRuE3zHZtJ2IURioGCGhJqtAztHkamMQ
         eRgw==
X-Gm-Message-State: AOAM5320hn5nscEkgoOb8o5104BctiNoS6rx9cKCNrrxGMKhVbfPiVIK
        UhUzidanOm9+8bLDPcHM1KFvQPvhMdWK
X-Google-Smtp-Source: ABdhPJxRFZBMco6xkQcpvYha8gM0x1l8eieauOXyFlH83TCZS3y/KZ3wXqddQf4gTZHQF8B34BcW7A==
X-Received: by 2002:a17:902:aa42:b0:15c:f066:3888 with SMTP id c2-20020a170902aa4200b0015cf0663888mr2201580plr.102.1651820616892;
        Fri, 06 May 2022 00:03:36 -0700 (PDT)
Received: from thinkpad ([117.207.26.33])
        by smtp.gmail.com with ESMTPSA id n21-20020a170903405500b0015e8d4eb1f9sm845394pla.67.2022.05.06.00.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 00:03:36 -0700 (PDT)
Date:   Fri, 6 May 2022 12:33:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ARM: dts: qcom: sdx65: Add USB3 and PHY support
Message-ID: <20220506070330.GD17659@thinkpad>
References: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651482395-29443-4-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1651482395-29443-4-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 02:36:34PM +0530, Rohit Agarwal wrote:
> Add devicetree nodes for enabling USB3 controller, Qcom QMP PHY and
> SNPS HS PHY on SDX65.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 83 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index d989837..a64be20 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -126,6 +126,7 @@
>  			reg = <0x00100000 0x001f7400>;
>  			clocks = <&rpmhcc RPMH_CXO_CLK>, <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>;
>  			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
> +			#power-domain-cells = <1>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  		};
> @@ -139,6 +140,45 @@
>  			status = "disabled";
>  		};
>  
> +		usb_hsphy: phy@ff4000 {
> +			compatible = "qcom,usb-snps-hs-7nm-phy";
> +			reg = <0xff4000 0x120>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "ref";
> +			resets = <&gcc GCC_QUSB2PHY_BCR>;
> +		};
> +
> +		usb_qmpphy: phy@ff6000 {
> +			compatible = "qcom,sdx65-qmp-usb3-uni-phy";
> +			reg = <0x00ff6000 0x1c8>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
> +				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +				 <&gcc GCC_USB3_PRIM_CLKREF_EN>;
> +			clock-names = "aux", "cfg_ahb", "ref";
> +
> +			resets = <&gcc GCC_USB3PHY_PHY_BCR>,
> +				 <&gcc GCC_USB3_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			usb_ssphy: phy@ff6200 {
> +				reg = <0x00ff6e00 0x160>,
> +				      <0x00ff7000 0x1ec>,
> +				      <0x00ff6200 0x1e00>;
> +				#phy-cells = <0>;
> +				#clock-cells = <0>;
> +				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_uni_phy_pipe_clk_src";
> +			};
> +		};
> +
>  		system_noc: interconnect@1620000 {
>  			compatible = "qcom,sdx65-system-noc";
>  			reg = <0x1620000 0x31200>;
> @@ -178,6 +218,49 @@
>  			status = "disabled";
>  		};
>  
> +		usb: usb@a6f8800 {
> +			compatible = "qcom,sdx65-dwc3", "qcom,dwc3";
> +			reg = <0x0a6f8800 0x400>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB30_SLV_AHB_CLK>,
> +				 <&gcc GCC_USB30_MASTER_CLK>,
> +				 <&gcc GCC_USB30_MSTR_AXI_CLK>,
> +				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_SLEEP_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
> +					"sleep";
> +
> +			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 19 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 76 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 18 IRQ_TYPE_EDGE_BOTH>;
> +			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
> +					  "ss_phy_irq", "dm_hs_phy_irq";
> +
> +			power-domains = <&gcc USB30_GDSC>;
> +
> +			resets = <&gcc GCC_USB30_BCR>;
> +
> +			usb_dwc3: usb@a600000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0a600000 0xcd00>;
> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0x1a0 0x0>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				phys = <&usb_hsphy>, <&usb_ssphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +			};
> +		};
> +
>  		spmi_bus: qcom,spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0xc440000 0xd00>,
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
