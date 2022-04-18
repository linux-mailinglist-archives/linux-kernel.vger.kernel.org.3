Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D3A504D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiDRHWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 03:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiDRHWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 03:22:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3697F1704F;
        Mon, 18 Apr 2022 00:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4A6FB8037A;
        Mon, 18 Apr 2022 07:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D92C385A8;
        Mon, 18 Apr 2022 07:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650266368;
        bh=baKBpk7VihDzDSn3PYHeldYtpGAf73jNn1xOpukMvMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlCiicasvOHWYdPuj3J7ijN0DlZYwE4dW0J5J1nrSdtiIheqkBX4I7ZdZo3EGpcb9
         IfJCZCndxo7OkbEqfGz+AtOLtZbebI6hUCia8X927p/Zk4/PK/CcW3li9faty2B2GX
         QvIQt6JPeyKRR3P2vf8pjAgU+gOMFBr7pRpgewgQZySsrs60Gpw8H2Fw3GuluTyTii
         RR+JDwxG+sNCH0CqnJqEF5IRoWQM+5+twGFT5wELi9BK+lRduZXfATQ0Ux0YSqsXnf
         ezV6c7s4VkFbVO1Ukdte1TwtW1qx98lOM4hHuyVo1u7f55MlSpdGVwyrZeSD/DaUc4
         LyZeQeNIUWhmg==
Date:   Mon, 18 Apr 2022 12:49:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8350: Add GENI I2C/SPI DMA
 channels
Message-ID: <Yl0Q/Hbkyp5/sH8T@matsya>
References: <20220412215137.2385831-1-bjorn.andersson@linaro.org>
 <20220412215137.2385831-2-bjorn.andersson@linaro.org>
 <YlZALC0DdSPB9n+/@matsya>
 <YlZKIKR1iHO+Btwk@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlZKIKR1iHO+Btwk@ripper>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-22, 20:57, Bjorn Andersson wrote:
> On Tue 12 Apr 20:14 PDT 2022, Vinod Koul wrote:
> 
> > On 12-04-22, 14:51, Bjorn Andersson wrote:
> > > The GENI I2C and SPI controllers may use the GPI DMA engine, define the
> > > rx and tx channels for these controllers to enable this.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm8350.dtsi | 108 +++++++++++++++++++++++++++
> > >  1 file changed, 108 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > > index 7e585d9e4c68..8547c0b2f060 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > > @@ -721,6 +721,9 @@ i2c14: i2c@880000 {
> > >  				pinctrl-names = "default";
> > >  				pinctrl-0 = <&qup_i2c14_default>;
> > >  				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> > > +				dmas = <&gpi_dma2 0 0 QCOM_GPI_I2C>,
> > > +				       <&gpi_dma2 1 0 QCOM_GPI_I2C>;
> > > +				dma-names = "tx", "rx";
> > 
> > I have been thinking about this. I dont feel this is right approach here
> > as this is board dependent and having the firmware loaded on the board..
> > 
> > This was tested on HDK and can fail in MTP or other boards.. which might
> > be in FIFO mode
> > 
> 
> But if the controller is in FIFO mode, then !fifo_disable so we wouldn't
> try to pick up the dmas. And in the opposite case, i.e. when
> fifo_disable, the introduction of the GPI implementation meant that the
> i2c driver wouldn't no longer probe without the dmas specified.
> 
> Unfortunately we don't have any i2c busses enabled on the MTP currently,
> so I'm not able to validate this easily.
> 
> 
> For the SPI driver though, the same logic is used to invoke
> spi_geni_grab_gpi_chan(). So dmas will only be considered if
> fifo_disabled is set.

Right, I tested that and it works just fine. So lets go ahead with this
approach

> That said, in the even that the SPI driver finds a fifo_disabled
> controller and dma_request_chan() returns an error, we will fall back to
> fifo mode instead. I'm not sure if that's desirable...

I agree, we should not fall back, that does not make sense at all

-- 
~Vinod
