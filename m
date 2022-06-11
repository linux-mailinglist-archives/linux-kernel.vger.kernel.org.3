Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250D1547351
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiFKJhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiFKJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:37:20 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D07532ECA;
        Sat, 11 Jun 2022 02:37:19 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 88FD7CD394;
        Sat, 11 Jun 2022 09:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1654940206; bh=Pv4FsvWvfgEkD1dHzfg4Gg5E6CXk8wuVq7wdUmNs0+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ut+6n+0zCKmQUtRtdy98cgZCJw6OGK0W5R6FomNvWBHs7pGOXuyFH8c9TA+nw6aZC
         TkEn3kAzPTqMWIe0qGlnp4IzPIymnNA6b+YNjvwB5dbCQ2D2/RzeDzu80hgGvJZcdT
         zmKOjnPUJ9eQXSovO0kHSWylGDEuqIKBGtd9zYt8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8953: add MDSS
Date:   Sat, 11 Jun 2022 11:36:45 +0200
Message-ID: <4716730.GXAFRqVoOG@g550jk>
In-Reply-To: <c7ac47e0-20a2-3972-e760-61276964445c@linaro.org>
References: <20220610225304.267508-1-luca@z3ntu.xyz> <20220610225304.267508-2-luca@z3ntu.xyz> <c7ac47e0-20a2-3972-e760-61276964445c@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

thanks for the feedback!

On Samstag, 11. Juni 2022 01:20:31 CEST Dmitry Baryshkov wrote:
> On 11/06/2022 01:53, Luca Weiss wrote:
> > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> > 
> > Add the MDSS, MDP and DSI nodes that are found on msm8953 SoC.
> > 
> > IOMMU is not added because support for it isn't yet upstream and MDSS
> > works fine without IOMMU on 8953.
> > 
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> 
> Looks good, few minor nits below.
> 
> > ---
> > 
> >   arch/arm64/boot/dts/qcom/msm8953.dtsi | 202 ++++++++++++++++++++++++++
> >   1 file changed, 202 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > b/arch/arm64/boot/dts/qcom/msm8953.dtsi index ffc3ec2cd3bc..a2aca3d05899
> > 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > @@ -726,6 +726,208 @@ tcsr_phy_clk_scheme_sel: syscon@193f044 {
> > 
> >   			reg = <0x193f044 0x4>;
> >   		
> >   		};
> > 
> > +		mdss: mdss@1a00000 {
> > +			compatible = "qcom,mdss";
> > +
> > +			reg = <0x1a00000 0x1000>,
> > +			      <0x1ab0000 0x1040>;
> > +			reg-names = "mdss_phys",
> > +				    "vbif_phys";
> > +
> > +			power-domains = <&gcc MDSS_GDSC>;
> > +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;
> > +
> > +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> > +				 <&gcc GCC_MDSS_AXI_CLK>,
> > +				 <&gcc GCC_MDSS_VSYNC_CLK>;
> 
> Please also add GCC_MDSS_MDP_CLK at the end of this array. It might be
> required to read HW_REV register.

I don't think if I add that clock with the name "core" (or similar) that it
would be used by the driver:

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/msm/msm_mdss.c#L274-L302

Regards
Luca

> 
> > +			clock-names = "iface",
> > +				      "bus",
> > +				      "vsync";
> > +
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> 
> status = "disabled";
> 
> > +
> > +			mdp: mdp@1a01000 {
> > +				compatible = "qcom,mdp5";
> > +				reg = <0x1a01000 0x89000>;
> > +				reg-names = "mdp_phys";
> > +
> > +				interrupt-parent = <&mdss>;
> > +				interrupts = <0>;
> > +
> > +				power-domains = <&gcc MDSS_GDSC>;
> > +
> > +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
> > +					 <&gcc GCC_MDSS_AXI_CLK>,
> > +					 <&gcc GCC_MDSS_MDP_CLK>,
> > +					 <&gcc GCC_MDSS_VSYNC_CLK>;
> > +				clock-names = "iface",
> > +					      "bus",
> > +					      "core",
> > +					      "vsync";
> > +
> > +				// iommus = <&apps_iommu 0xc00 0>;
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						mdp5_intf1_out: endpoint {
> > +							remote-endpoint = <&dsi0_in>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +						mdp5_intf2_out: endpoint {
> > +							remote-endpoint = <&dsi1_in>;
> > +						};
> > +					};
> > +				};
> > +			};
> > +
> > +			dsi0: dsi@1a94000 {
> > +				compatible = "qcom,mdss-dsi-ctrl";
> > +				reg = <0x1a94000 0x400>;
> > +				reg-names = "dsi_ctrl";
> > +
> > +				interrupt-parent = <&mdss>;
> > +				interrupts = <4>;
> > +
> > +				assigned-clocks = <&gcc BYTE0_CLK_SRC>,
> > +						  <&gcc PCLK0_CLK_SRC>;
> > +				assigned-clock-parents = <&dsi0_phy 0>,
> > +							 <&dsi0_phy 1>;
> > +
> > +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
> > +					 <&gcc GCC_MDSS_AHB_CLK>,
> > +					 <&gcc GCC_MDSS_AXI_CLK>,
> > +					 <&gcc GCC_MDSS_BYTE0_CLK>,
> > +					 <&gcc GCC_MDSS_PCLK0_CLK>,
> > +					 <&gcc GCC_MDSS_ESC0_CLK>;
> > +				clock-names = "mdp_core",
> > +					      "iface",
> > +					      "bus",
> > +					      "byte",
> > +					      "pixel",
> > +					      "core";
> > +
> > +				phys = <&dsi0_phy>;
> > +				phy-names = "dsi";
> > +
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> 
> status = "disabled";
> 
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						dsi0_in: endpoint {
> > +							remote-endpoint = <&mdp5_intf1_out>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +						dsi0_out: endpoint {
> > +						};
> > +					};
> > +				};
> > +			};
> > +
> > +			dsi0_phy: dsi-phy@1a94400 {
> > +				compatible = "qcom,dsi-phy-14nm-8953";
> > +				reg = <0x1a94400 0x100>,
> > +				      <0x1a94500 0x300>,
> > +				      <0x1a94800 0x188>;
> > +				reg-names = "dsi_phy",
> > +					    "dsi_phy_lane",
> > +					    "dsi_pll";
> > +
> > +				#clock-cells = <1>;
> > +				#phy-cells = <0>;
> 
> status = "disabled";
> 
> > +
> > +				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
> > +				clock-names = "iface", "ref";
> > +			};
> > +
> > +			dsi1: dsi@1a96000 {
> > +				compatible = "qcom,mdss-dsi-ctrl";
> > +				reg = <0x1a96000 0x400>;
> > +				reg-names = "dsi_ctrl";
> > +
> > +				interrupt-parent = <&mdss>;
> > +				interrupts = <5>;
> > +
> > +				assigned-clocks = <&gcc BYTE1_CLK_SRC>,
> > +						  <&gcc PCLK1_CLK_SRC>;
> > +				assigned-clock-parents = <&dsi1_phy 0>,
> > +							 <&dsi1_phy 1>;
> > +
> > +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
> > +					 <&gcc GCC_MDSS_AHB_CLK>,
> > +					 <&gcc GCC_MDSS_AXI_CLK>,
> > +					 <&gcc GCC_MDSS_BYTE1_CLK>,
> > +					 <&gcc GCC_MDSS_PCLK1_CLK>,
> > +					 <&gcc GCC_MDSS_ESC1_CLK>;
> > +				clock-names = "mdp_core",
> > +					      "iface",
> > +					      "bus",
> > +					      "byte",
> > +					      "pixel",
> > +					      "core";
> > +
> > +				phys = <&dsi1_phy>;
> > +				phy-names = "dsi";
> > +
> > +				status = "disabled";
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						dsi1_in: endpoint {
> > +							remote-endpoint = <&mdp5_intf2_out>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +						dsi1_out: endpoint {
> > +						};
> > +					};
> > +				};
> > +			};
> > +
> > +			dsi1_phy: dsi-phy@1a96400 {
> > +				compatible = "qcom,dsi-phy-14nm-8953";
> > +				reg = <0x1a96400 0x100>,
> > +				      <0x1a96500 0x300>,
> > +				      <0x1a96800 0x188>;
> > +				reg-names = "dsi_phy",
> > +					    "dsi_phy_lane",
> > +					    "dsi_pll";
> > +
> > +				#clock-cells = <1>;
> > +				#phy-cells = <0>;
> > +
> > +				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
> > +				clock-names = "iface", "ref";
> > +
> > +				status = "disabled";
> > +			};
> > +		};
> > +
> > 
> >   		spmi_bus: spmi@200f000 {
> >   		
> >   			compatible = "qcom,spmi-pmic-arb";
> >   			reg = <0x200f000 0x1000>,




