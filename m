Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935BC509907
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385714AbiDUH0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiDUH0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:26:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C71518369;
        Thu, 21 Apr 2022 00:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 44CC3CE20D2;
        Thu, 21 Apr 2022 07:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D120C385A1;
        Thu, 21 Apr 2022 07:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650525800;
        bh=WBrrVLe9xDjGjs0TLd562+RhfrgkR1wAqV4ClV9hpjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1gdqogT46Ms5AqxWDNnmouNEeO6XyVKQItc2f7E0pDsGL/w4bbIPvQrbmfNcCnwV
         Fn1eVXuGNpS3ly2QUtsL/ZBiT80Se3xxJ1GP5YRAyt+tw7IngcCXU6uFkBSxfjPDfa
         jcrG+NRDXLbMG7B0A8hnxJcdmrp+s/IqnDPOia8w0U5zGzSc4z1+TuF7IJr6FDLwio
         2FkfacY+Ke8xhmq38NC73FwXichDkSzsrXlemTxcrzeZcX3+y0srenKNF/82/QsS9i
         xrXSbaWrPNYAjHIuWwA6nC4ID53thSDoPduZkqupkOQMCwEwLN5cW0nvg9fboymN1C
         egkp2FuS3Csgg==
Date:   Thu, 21 Apr 2022 12:53:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: db845c: Add support for MCP2517FD
Message-ID: <YmEGZML8qIOjRT/s@matsya>
References: <20220419043348.1483625-1-vkoul@kernel.org>
 <f3a159b5-ebca-ce00-88dc-ddde353c9031@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a159b5-ebca-ce00-88dc-ddde353c9031@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-22, 09:37, Krzysztof Kozlowski wrote:
> On 19/04/2022 06:33, Vinod Koul wrote:
> > Add support for onboard MCP2517FD SPI CAN transceiver attached to
> > SPI0 of RB3.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> > Changes in v2:
> >  - add cs and pinctrl config
> >  - remove misleading comment
> > 
> >  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 33 ++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > index 28fe45c5d516..4f4d45be93e3 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > @@ -28,6 +28,13 @@ chosen {
> >  		stdout-path = "serial0:115200n8";
> >  	};
> >  
> > +	/* Fixed crystal oscillator dedicated to MCP2517FD */
> > +	clk40M: can_clock {
> 
> No underscores in node names.

right, will patch up the original source as well :D

> 
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <40000000>;
> > +	};
> > +
> >  	dc12v: dc12v-regulator {
> >  		compatible = "regulator-fixed";
> >  		regulator-name = "DC12V";
> > @@ -746,6 +753,24 @@ codec {
> >  	};
> >  };
> >  
> > +&spi0 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&qup_spi0_default>;
> > +	cs-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
> > +
> > +	can@0 {
> > +		compatible = "microchip,mcp2517fd";
> > +		reg = <0>;
> > +		clocks = <&clk40M>;
> > +		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
> > +		spi-max-frequency = <10000000>;
> > +		vdd-supply = <&vdc_5v>;
> > +		xceiver-supply = <&vdc_5v>;
> > +		status = "okay";
> 
> No need for status for new nodes (unless it is an extension of existing
> node?), it is okay by default.

Yep

-- 
~Vinod
