Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5355B0892
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIGPai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIGPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:30:36 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5486EF12;
        Wed,  7 Sep 2022 08:30:34 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id BEC95C7023;
        Wed,  7 Sep 2022 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1662564630; bh=PBuavX/FI8zoNi4Yjs2NUwse88XH7Qen5TwuTvKTMFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uWv8uKGVTh/KDAzcw1siELCkpqZlURBcIALCy5h1bT5+OZOgnYR/yS5OzAKU/IT8W
         DWrrGtwYeKh9WpiMUXWtH0F7EUaHUsp2namiCQUuC6x74PX7JfQwhj6ZIIRzXzzFhz
         NZg+zJODwITdaZ9Hw9uzds8bYYNDEcRbNaSbX3MI=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: msm8953: add MDSS
Date:   Wed, 07 Sep 2022 17:30:30 +0200
Message-ID: <12049260.O9o76ZdvQC@g550jk>
In-Reply-To: <CAA8EJpqjnafKyUrd1ntYFeGTDtRxgEUSu0Mg9wNGxObJ3wF0Kw@mail.gmail.com>
References: <20220906183334.203787-1-luca@z3ntu.xyz> <20220906183334.203787-4-luca@z3ntu.xyz> <CAA8EJpqjnafKyUrd1ntYFeGTDtRxgEUSu0Mg9wNGxObJ3wF0Kw@mail.gmail.com>
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

On Dienstag, 6. September 2022 21:41:11 CEST Dmitry Baryshkov wrote:
> On Tue, 6 Sept 2022 at 21:36, Luca Weiss <luca@z3ntu.xyz> wrote:
> > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> > 
> > Add the MDSS, MDP and DSI nodes that are found on msm8953 SoC.
> > 
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > Changes since v2:
> > - add "core" clock for mdss as suggested by Dmitry Baryshkov
> > 
> >  arch/arm64/boot/dts/qcom/msm8953.dtsi | 210 ++++++++++++++++++++++++++
> >  1 file changed, 210 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > b/arch/arm64/boot/dts/qcom/msm8953.dtsi index 3d11331e78d2..580333141a66
> > 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> > @@ -726,6 +726,216 @@ tcsr_phy_clk_scheme_sel: syscon@193f044 {
> > 
> >                         reg = <0x193f044 0x4>;
> >                 
> >                 };
> > 
> > +               mdss: mdss@1a00000 {
> > +                       compatible = "qcom,mdss";
> > +
> > +                       reg = <0x1a00000 0x1000>,
> > +                             <0x1ab0000 0x1040>;
> > +                       reg-names = "mdss_phys",
> > +                                   "vbif_phys";
> > +
> > +                       power-domains = <&gcc MDSS_GDSC>;
> > +                       interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                       interrupt-controller;
> > +                       #interrupt-cells = <1>;
> > +
> > +                       clocks = <&gcc GCC_MDSS_AHB_CLK>,
> > +                                <&gcc GCC_MDSS_AXI_CLK>,
> > +                                <&gcc GCC_MDSS_VSYNC_CLK>,
> > +                                <&gcc GCC_MDSS_MDP_CLK>;
> > +                       clock-names = "iface",
> > +                                     "bus",
> > +                                     "vsync",
> > +                                     "core";
> > +
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +
> > +                       status = "disabled";
> > +
> > +                       mdp: mdp@1a01000 {
> > +                               compatible = "qcom,mdp5";
> 
> Could you please change this to "qcom,msm8953-mdp5", "qcom,mdp5".

This would be the first dtsi using the two compatibles then, correct? Are there 
any plans to adjust other SoCs?

> 
> > +                               reg = <0x1a01000 0x89000>;
> > +                               reg-names = "mdp_phys";
> > +
> 
> [skipped]
> 
> > +
> > +                       dsi0_phy: dsi-phy@1a94400 {
> 
> Let's probably use a generic name 'phy' here and for dsi1_phy.

Here also, the bindings examples all use dsi-phy@, are there any plans to 
change that and adjust other dtsi files?

> 
> The rest looks good to me.

Thanks!

Regards
Luca

> 
> > +                               compatible = "qcom,dsi-phy-14nm-8953";
> > +                               reg = <0x1a94400 0x100>,
> > +                                     <0x1a94500 0x300>,
> > +                                     <0x1a94800 0x188>;
> > +                               reg-names = "dsi_phy",
> > +                                           "dsi_phy_lane",
> > +                                           "dsi_pll";
> > +
> > +                               #clock-cells = <1>;
> > +                               #phy-cells = <0>;
> > +
> > +                               clocks = <&gcc GCC_MDSS_AHB_CLK>,
> > <&xo_board>; +                               clock-names = "iface",
> > "ref";
> > +
> > +                               status = "disabled";
> > +                       };




