Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA381566F2F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiGEN3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiGEN31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:29:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC923897;
        Tue,  5 Jul 2022 05:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C51D760C38;
        Tue,  5 Jul 2022 12:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEADC341C7;
        Tue,  5 Jul 2022 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657025461;
        bh=/wZNkLMQ8f+ZI2REJC8guWCA/5+Cuw84Q5nJ99AIcHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dltjLfCNk82lbByxTujjWM7+9d44kyeRnLamAQVgTy3q5zVutAq9ESsCPfXPdl25N
         YEYgDMfLzUQ5ugYwr2AFh2AuRQqKI5luhJ6xrgXA8rUApup0KivbD1wvLoaY2/GdW9
         IHOBoCeRcE7IcNy59A1+Qf/Oc2eM+4ToUk6f+NRhG/d5H3H8K+XDJOA7y3P+vcap0a
         4E20zmfdnEjP4pvxm7FSPIIHqMj4h0bPZL8nBoYiBMRoRRJq+ccNgBR15GqNeQVFtJ
         HgkA3vba3QG1bQPHaAo0x3QT3Wj8E+1UPggDjcv0+EIpdzh9yYWMeqZVFAQzFhCLZt
         u/+18q8MD/TlQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8i18-0006yd-1j; Tue, 05 Jul 2022 14:51:02 +0200
Date:   Tue, 5 Jul 2022 14:51:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] arm64: dts: qcom: sc7280: drop PCIe PHY clock index
Message-ID: <YsQztl9KHS5csu4A@hovoldconsulting.com>
References: <20220705114032.22787-1-johan+linaro@kernel.org>
 <20220705114032.22787-2-johan+linaro@kernel.org>
 <e3b344e7-4100-e0d4-0dcd-aeef4893ad43@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b344e7-4100-e0d4-0dcd-aeef4893ad43@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 03:42:08PM +0300, Dmitry Baryshkov wrote:
> On 05/07/2022 14:40, Johan Hovold wrote:
> > The QMP PCIe PHY provides a single clock so drop the redundant clock
> > index.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Hmm. After checking the source code, the clocks entry of the phy@1c0e000 
> node also needs to be fixed.

I assume you meant pci@1c08000 here? Thanks for catching that!

> And also maybe:
> 
> Fixes: bd7d507935ca ("arm64: dts: qcom: sc7280: Add pcie clock support")
> Fixes: 92e0ee9f83b3 ("arm64: dts: qcom: sc7280: Add PCIe and PHY related 
> nodes")

Maybe, I'm a bit reluctant to add a Fixes tags for these even if they do
violate the binding. But sure, why not.

> > ---
> >   arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index e66fc67de206..b0ae2dbba50f 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -818,7 +818,7 @@ gcc: clock-controller@100000 {
> >   			reg = <0 0x00100000 0 0x1f0000>;
> >   			clocks = <&rpmhcc RPMH_CXO_CLK>,
> >   				 <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
> > -				 <0>, <&pcie1_lane 0>,
> > +				 <0>, <&pcie1_lane>,
> >   				 <0>, <0>, <0>, <0>;
> >   			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
> >   				      "pcie_0_pipe_clk", "pcie_1_pipe_clk",
> > @@ -2110,7 +2110,7 @@ pcie1_lane: phy@1c0e200 {
> >   				clock-names = "pipe0";
> >   
> >   				#phy-cells = <0>;
> > -				#clock-cells = <1>;
> > +				#clock-cells = <0>;
> >   				clock-output-names = "pcie_1_pipe_clk";
> >   			};
> >   		};

Johan
