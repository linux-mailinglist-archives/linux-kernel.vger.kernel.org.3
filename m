Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9863C5738F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiGMOfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbiGMOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:35:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3834F371B7;
        Wed, 13 Jul 2022 07:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4C8FB82014;
        Wed, 13 Jul 2022 14:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D559C34114;
        Wed, 13 Jul 2022 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657722918;
        bh=WlymjH9F+XhvwTLfQdzEjbhKt3wCFEw6cLV8ZRsbxyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSIDISQG7utxWtvkZCC6HbwtJRpLy37dPh/4I7G7Gshv6qNS1gokwTy2JujyN0mh0
         tfhmDQSijMty4lDWUE3y25ATbodBh9d6wHw1m6UIm7mS8PwFSnS/4OHPgWBaKYbhQ5
         9SKQgzaOFtzmI6LEmfDFL3nH9FLUdCF3td1AomumS4jtie8+6pfBMoXf7KvQU5eV0l
         pjYyIn7bA696ismvSYmo2IKQ4qwrjh+EmezXLUXSVQFfm01HDjX8BXVATc9kBAXFYd
         Sgd5xni6y+xNQ4r/0aWTknMQhnuqkdb+z3gi1qjAdM12+i/rez9uN9wDSOVOwLEBkr
         3Yw0i3w8gSDoQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBdSU-00013W-1I; Wed, 13 Jul 2022 16:35:22 +0200
Date:   Wed, 13 Jul 2022 16:35:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sc8280xp: fix USB interrupts
Message-ID: <Ys7YKkRAAI0Vbseh@hovoldconsulting.com>
References: <20220713131340.29401-1-johan+linaro@kernel.org>
 <20220713131340.29401-6-johan+linaro@kernel.org>
 <20220713141228.5z5rmgepj6mepjyp@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713141228.5z5rmgepj6mepjyp@halaneylaptop>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:12:28AM -0500, Andrew Halaney wrote:
> On Wed, Jul 13, 2022 at 03:13:38PM +0200, Johan Hovold wrote:
> > The two single-port SC8280XP USB controllers do not have an hs_phy_irq
> > interrupt. Instead they have a pwr_event interrupt which is distinct
> > from the former and not yet supported by the driver.
> > 
> > Fix the USB node interrupt names so that they match the devicetree
> > binding.
> > 
> > Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 45cc7d714fd2..4a7aa9992f3a 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -1875,8 +1875,10 @@ usb_0: usb@a6f8800 {
> >  					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
> >  					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
> >  					      <&pdc 138 IRQ_TYPE_LEVEL_HIGH>;
> > -			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
> > -					  "dm_hs_phy_irq", "ss_phy_irq";
> > +			interrupt-names = "pwr_event",
> > +					  "dp_hs_phy_irq",
> > +					  "dm_hs_phy_irq",
> > +					  "ss_phy_irq";
> >  
> >  			power-domains = <&gcc USB30_PRIM_GDSC>;
> >  
> > @@ -1925,8 +1927,10 @@ usb_1: usb@a8f8800 {
> >  					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>,
> >  					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>,
> >  					      <&pdc 136 IRQ_TYPE_LEVEL_HIGH>;
> > -			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
> > -					  "dm_hs_phy_irq", "ss_phy_irq";
> > +			interrupt-names = "pwr_event",
> > +					  "dp_hs_phy_irq",
> > +					  "dm_hs_phy_irq",
> > +					  "ss_phy_irq";
> 
> For this specific change to pwr_event:
> 
>     Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> 
> That being said, I was reviewing this against the (fairly old)
> downstream release I have, and the IRQs defined there look like this:
> 
> 		interrupts-extended = <&pdc 12 IRQ_TYPE_EDGE_RISING>,
> 				<&intc GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
> 				<&pdc 136 IRQ_TYPE_LEVEL_HIGH>,
> 				<&pdc 13 IRQ_TYPE_EDGE_RISING>;
> 		interrupt-names = "dp_hs_phy_irq", "pwr_event_irq",
> 				"ss_phy_irq", "dm_hs_phy_irq";
> 
> The part I want to highlight is that the "pwr_event" irq downstream maps
> to <&intc GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>, but the current upstream
> devicetree I'm looking at has it mapped to <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>
> 
> Do you happen to have any source you can also check to confirm if this
> is a bug or not?

Good catch! I believe this is another copy-paste error when creating
base dtsi based on some vendor source (or perhaps an error carried over
from an earlier version).

The vendor devicetree I have access to also has 811 here, which matches
the pattern for usb_0 (dwc3 interrupt + 1).

Do you mind if I fold a fix for that into a v2 of this patch?

Thanks for reviewing!

Johan
