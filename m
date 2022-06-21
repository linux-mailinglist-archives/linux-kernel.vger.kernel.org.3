Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD95529C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 05:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344399AbiFUDhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbiFUDhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:37:11 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B447F13F05
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:37:10 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-101cdfddfacso8693411fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0OkAZwfiR/IGc5OiW6l+odjK0O64O9VMbeiiBtsyMJE=;
        b=QKfx36CREpP4nFKKSmJsir+cI8BvjZ2WDoHlvYAynUsIfS/v52G2SnAXDpnnieexSn
         mHxg+rKtN3J6FVhwsCM4IAziOKeUhxPBBNU2X1RlLL6DJa4kw0IFpGrv1ymEAUNhxOd5
         PXCOtABLrY49kCho+3SQf4dsTYkyZzdrh9dSWnl/VrwLmkTuvbDnODn1EYIY8CQDzOMg
         yeZQsiBj6SIDiRUwXuxgJ8bbuol7a0DihyufYUl1i/FbVQmms3heiElEvwaCFE3HjsEq
         afUOinuMj2NW6J2BUfQwthP17WYv2+SdzrBSbL/oDqGnV8e3UHOsnKe6ggM2IL8rtHIG
         L5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0OkAZwfiR/IGc5OiW6l+odjK0O64O9VMbeiiBtsyMJE=;
        b=tdGTKZXbAMoi9fT2BzBe0mKl66Yu6/6q3fU+VZth4kDGYdiyq2w2ye5t0/i8/aYuOJ
         GU/WK5w7UcAkPMTUwpHr4VS/IEXTZ4rJ0NOJIyWYVT1vaJiwRTpGNic1seIL+wVk6Gce
         7rlEO5eMfxALQSyqrjfVxWtHyNyQ8yG9vJNi3sOTaV0ACguBQloAWrCdV9XqZg71Z748
         PbRZpy+8ASMEL3HXVnvq2npJWeM++1KGGSb8y6o20+9ob16jJbceq200zjizaw+FTRuN
         B1flyMU5fe/liI3q7tYgExaUT9fs5NPpby0Mkk+7pKtdI+Iq3jQUGh3hu5oSw/BsXUI1
         M2Yw==
X-Gm-Message-State: AJIora/S7pgQWxfI7VnfARYqyQ6kPjeXe5GrY6FmZnKc5bEw67i5L26s
        xjTTpZLV6IcsxBJ8IcxBI9qz4CVz/JwcJg==
X-Google-Smtp-Source: AGRyM1vcdaym28Iv5o1yaVIlDuqlMHf9eb+9fp49PcstJIJ4J0VfPhf56qR2V6S2TS3b+hurIf5BMg==
X-Received: by 2002:a05:6870:15c9:b0:101:e18b:d12d with SMTP id k9-20020a05687015c900b00101e18bd12dmr5070380oad.51.1655782629132;
        Mon, 20 Jun 2022 20:37:09 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a16-20020a056870b21000b000f33624baa4sm8362730oam.18.2022.06.20.20.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 20:37:08 -0700 (PDT)
Date:   Mon, 20 Jun 2022 22:37:06 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: add SC8280XP platform
Message-ID: <YrE84tLOpJtzrNW4@builder.lan>
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-3-bjorn.andersson@linaro.org>
 <79443fb4-5c09-a33f-594d-71ac93cc0317@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79443fb4-5c09-a33f-594d-71ac93cc0317@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08 Jun 03:18 CDT 2022, Krzysztof Kozlowski wrote:

> On 07/06/2022 23:41, Bjorn Andersson wrote:
> > Introduce initial support for the Qualcomm SC8280XP platform, aka 8cx
> > Gen 3. This initial contribution supports SMP, CPUfreq, CPU cluster
> > idling, GCC, TLMM, SMMU, RPMh regulators, power-domains and clocks,
> > interconnects, some QUPs, UFS, remoteprocs, USB, watchdog, LLCC and
> > tsens.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2195 ++++++++++++++++++++++++
> >  1 file changed, 2195 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > new file mode 100644
> > index 000000000000..4143813643ad
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -0,0 +1,2195 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2022, Linaro Limited
> > + */
> > +
> > +#include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
> > +#include <dt-bindings/clock/qcom,rpmh.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/interconnect/qcom,sc8280xp.h>
> > +#include <dt-bindings/mailbox/qcom-ipcc.h>
> > +#include <dt-bindings/power/qcom-rpmpd.h>
> > +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > +#include <dt-bindings/thermal/thermal.h>
> > +
> > +/ {
> > +	interrupt-parent = <&intc>;
> > +
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	clocks {
> > +		xo_board: xo-board {
> 
> xo-board-clk
> 
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <38400000>;
> 
> The clock is probably on the board, so the frequency should be rather
> defined in DTS.
> 

It's an interesting question, but I don't think it's possible to change
the rate of this clock from one board to another.

So I think it's best to keep this in the .dtsi, to avoid unnecessary
duplication.


Thanks for the feedback, will update the remaining things.

Regards,
Bjorn

> > +		};
> > +
> > +		sleep_clk: sleep-clk {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <32764>;
> > +		};
> > +	};
> 
> (...)
> 
> > +
> > +		qup1: geniqup@ac0000 {
> > +			compatible = "qcom,geni-se-qup";
> > +			reg = <0 0x00ac0000 0 0x6000>;
> > +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> > +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> > +			clock-names = "m-ahb", "s-ahb";
> > +			iommus = <&apps_smmu 0x83 0>;
> > +
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		ufs_mem_hc: ufshc@1d84000 {
> 
> Just "ufs" as node name.
> 
> > +			compatible = "qcom,sc8280xp-ufshc", "qcom,ufshc",
> > +				     "jedec,ufs-2.0";
> > +			reg = <0 0x01d84000 0 0x3000>;
> > +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> > +			phys = <&ufs_mem_phy_lanes>;
> > +			phy-names = "ufsphy";
> > +			lanes-per-direction = <2>;
> > +			#reset-cells = <1>;
> > +			resets = <&gcc GCC_UFS_PHY_BCR>;
> > +			reset-names = "rst";
> > +
> > +			power-domains = <&gcc UFS_PHY_GDSC>;
> > +			required-opps = <&rpmhpd_opp_nom>;
> > +
> > +			iommus = <&apps_smmu 0xe0 0x0>;
> > +
> > +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>
> > +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> > +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> > +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> > +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> > +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> > +			clock-names = "core_clk",
> > +				      "bus_aggr_clk",
> > +				      "iface_clk",
> > +				      "core_clk_unipro",
> > +				      "ref_clk",
> > +				      "tx_lane0_sync_clk",
> > +				      "rx_lane0_sync_clk",
> > +				      "rx_lane1_sync_clk";
> > +			freq-table-hz = <75000000 300000000>,
> > +					<0 0>,
> > +					<0 0>,
> > +					<75000000 300000000>,
> > +					<0 0>,
> > +					<0 0>,
> > +					<0 0>,
> > +					<0 0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		ufs_mem_phy: phy@1d87000 {
> > +			compatible = "qcom,sc8280xp-qmp-ufs-phy";
> > +			reg = <0 0x01d87000 0 0xe10>;
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +			clock-names = "ref",
> > +				      "ref_aux";
> > +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> > +
> > +			resets = <&ufs_mem_hc 0>;
> > +			reset-names = "ufsphy";
> > +			status = "disabled";
> > +
> > +			ufs_mem_phy_lanes: phy@1d87400 {
> > +				reg = <0 0x01d87400 0 0x108>,
> > +				      <0 0x01d87600 0 0x1e0>,
> > +				      <0 0x01d87c00 0 0x1dc>,
> > +				      <0 0x01d87800 0 0x108>,
> > +				      <0 0x01d87a00 0 0x1e0>;
> > +				#phy-cells = <0>;
> > +				#clock-cells = <0>;
> > +			};
> > +		};
> > +
> > +		ufs_card_hc: ufshc@1da4000 {
> 
> node name: ufs
> 
> > +			compatible = "qcom,sc8280xp-ufshc", "qcom,ufshc",
> > +				     "jedec,ufs-2.0";
> > +			reg = <0 0x01da4000 0 0x3000>;
> > +			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> > +			phys = <&ufs_card_phy_lanes>;
> > +			phy-names = "ufsphy";
> > +			lanes-per-direction = <2>;
> > +			#reset-cells = <1>;
> > +			resets = <&gcc GCC_UFS_CARD_BCR>;
> > +			reset-names = "rst";
> > +
> > +			power-domains = <&gcc UFS_CARD_GDSC>;
> > +
> > +			iommus = <&apps_smmu 0x4a0 0x0>;
> > +
> > +			clocks = <&gcc GCC_UFS_CARD_AXI_CLK>,
> > +				 <&gcc GCC_AGGRE_UFS_CARD_AXI_CLK>,
> > +				 <&gcc GCC_UFS_CARD_AHB_CLK>,
> > +				 <&gcc GCC_UFS_CARD_UNIPRO_CORE_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&gcc GCC_UFS_CARD_TX_SYMBOL_0_CLK>,
> > +				 <&gcc GCC_UFS_CARD_RX_SYMBOL_0_CLK>,
> > +				 <&gcc GCC_UFS_CARD_RX_SYMBOL_1_CLK>;
> > +			clock-names = "core_clk",
> > +				      "bus_aggr_clk",
> > +				      "iface_clk",
> > +				      "core_clk_unipro",
> > +				      "ref_clk",
> > +				      "tx_lane0_sync_clk",
> > +				      "rx_lane0_sync_clk",
> > +				      "rx_lane1_sync_clk";
> > +			freq-table-hz = <75000000 300000000>,
> > +					<0 0>,
> > +					<0 0>,
> > +					<75000000 300000000>,
> > +					<0 0>,
> > +					<0 0>,
> > +					<0 0>,
> > +					<0 0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		ufs_card_phy: phy@1da7000 {
> > +			compatible = "qcom,sc8280xp-qmp-ufs-phy";
> > +			reg = <0 0x01da7000 0 0xe10>;
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +			clock-names = "ref",
> > +				      "ref_aux";
> > +			clocks = <&gcc GCC_UFS_1_CARD_CLKREF_CLK>,
> > +				 <&gcc GCC_UFS_CARD_PHY_AUX_CLK>;
> > +
> > +			resets = <&ufs_card_hc 0>;
> > +			reset-names = "ufsphy";
> > +			status = "disabled";
> > +
> > +			ufs_card_phy_lanes: phy@1da7400 {
> > +				reg = <0 0x01da7400 0 0x108>,
> > +				      <0 0x01da7600 0 0x1e0>,
> > +				      <0 0x01da7c00 0 0x1dc>,
> > +				      <0 0x01da7800 0 0x108>,
> > +				      <0 0x01da7a00 0 0x1e0>;
> > +				#phy-cells = <0>;
> > +				#clock-cells = <0>;
> > +			};
> > +		};
> > +
> > +		tcsr_mutex: hwlock@1f40000 {
> > +			compatible = "qcom,tcsr-mutex";
> > +			reg = <0x0 0x01f40000 0x0 0x20000>;
> > +			#hwlock-cells = <1>;
> > +		};
> > +
> > +		usb_0_hsphy: phy@88e5000 {
> > +			compatible = "qcom,sc8280xp-usb-hs-phy",
> > +				     "qcom,usb-snps-hs-5nm-phy";
> > +			reg = <0 0x088e5000 0 0x400>;
> > +			status = "disabled";
> 
> status goes to the end
> 
> > +			#phy-cells = <0>;
> > +
> > +			clocks = <&gcc GCC_USB2_HS0_CLKREF_CLK>;
> > +			clock-names = "ref";
> > +
> > +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> > +		};
> > +
> > +		usb_2_hsphy0: phy@88e7000 {
> > +			compatible = "qcom,sc8280xp-usb-hs-phy",
> > +				     "qcom,usb-snps-hs-5nm-phy";
> > +			reg = <0 0x088e7000 0 0x400>;
> > +			status = "disabled";
> 
> ditto
> 
> > +			#phy-cells = <0>;
> > +
> > +			clocks = <&gcc GCC_USB2_HS0_CLKREF_CLK>;
> > +			clock-names = "ref";
> > +
> > +			resets = <&gcc GCC_QUSB2PHY_HS0_MP_BCR>;
> > +		};
> > +
> > +		usb_2_hsphy1: phy@88e8000 {
> > +			compatible = "qcom,sc8280xp-usb-hs-phy",
> > +				     "qcom,usb-snps-hs-5nm-phy";
> > +			reg = <0 0x088e8000 0 0x400>;
> > +			status = "disabled";
> 
> ditto
> 
> > +			#phy-cells = <0>;
> > +
> > +			clocks = <&gcc GCC_USB2_HS1_CLKREF_CLK>;
> > +			clock-names = "ref";
> > +
> > +			resets = <&gcc GCC_QUSB2PHY_HS1_MP_BCR>;
> > +		};
> > +
> > +		usb_2_hsphy2: phy@88e9000 {
> > +			compatible = "qcom,sc8280xp-usb-hs-phy",
> > +				     "qcom,usb-snps-hs-5nm-phy";
> > +			reg = <0 0x088e9000 0 0x400>;
> > +			status = "disabled";
> 
> ditto and so on
> 
> Best regards,
> Krzysztof
