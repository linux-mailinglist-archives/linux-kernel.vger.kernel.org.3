Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E3B5062D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348121AbiDSDik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348122AbiDSDiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426CE2FE4C;
        Mon, 18 Apr 2022 20:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3B9260FFD;
        Tue, 19 Apr 2022 03:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A92C385A7;
        Tue, 19 Apr 2022 03:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650339327;
        bh=+F9JGD4KqeeqwH+a4MzUoyXOvCmNj1M1S3c5szbFd60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FApLXCw3BbnBSnpQXwxVaG4JtP5YRm2Zevz6ttb/RBbaMHuQ6AuPNQo57wdzXjYrE
         wjReCl8T9rsgLIO/yon+ErKM7ewGmMrsh97Su67P1OIlFFcbz4xsOWcoRJxOJg+DLJ
         4HwqdhHZiiN1a8tS0i0Lhs2DGyFYtg4eFzznta2K0Srn4CXiKpax4iUfabQ/VEtBkS
         u7ANXrvfKn/Wzah28eb624O+I3ltEIioCO2wR8koSxTDfXWDs1AiA5r0Eu21dt901r
         YZ0dNne2et31zRDB09dIHQJcm+XHYTeS8D05gsKUukTM44Jo/ThvMJ06ohIIe315Yo
         U94omlkbRR6rw==
Date:   Tue, 19 Apr 2022 09:05:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: db845c: Add support for MCP2517FD
Message-ID: <Yl4t+gaIvPvL2O0/@matsya>
References: <20220418125841.1409738-1-vkoul@kernel.org>
 <20220418134241.GA161722@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418134241.GA161722@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-22, 19:12, Manivannan Sadhasivam wrote:
> On Mon, Apr 18, 2022 at 06:28:41PM +0530, Vinod Koul wrote:
> > Add support for onboard MCP2517FD SPI CAN transceiver attached to
> > SPI0 of RB3.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 23 ++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > index 28fe45c5d516..5179f8ddb060 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > @@ -28,6 +28,13 @@ chosen {
> >  		stdout-path = "serial0:115200n8";
> >  	};
> >  
> > +	/* Fixed crystal oscillator dedicated to MCP2517FD */
> > +	clk40M: can_clock {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <40000000>;
> > +	};
> > +
> >  	dc12v: dc12v-regulator {
> >  		compatible = "regulator-fixed";
> >  		regulator-name = "DC12V";
> > @@ -746,6 +753,22 @@ codec {
> >  	};
> >  };
> >  
> > +&spi0 {
> > +	/* On Low speed expansion */
> 
> Only SPI2 is exposed on the LS header. This one is dedicated to CAN controller.

ok

> 
> > +	status = "okay";
> 
> No chip select? Since CAN controller may operate at higher frequencies, it
> makes sense to increase the drive strength of the pins.

Okay will add and send v2

-- 
~Vinod
