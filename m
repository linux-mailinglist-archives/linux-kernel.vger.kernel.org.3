Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D8B4FED6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiDMDR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiDMDRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:17:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902FBBF7D;
        Tue, 12 Apr 2022 20:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4CC67CE210A;
        Wed, 13 Apr 2022 03:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD62C385A9;
        Wed, 13 Apr 2022 03:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649819696;
        bh=Y/LElc2oyLo1H2P/quTW0VmnTefl1bIuCvD279f/kxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nt/MQBUzI9gv1QYRzotSH8JkT39hrsg7/IksqiZrUWRy+p1JAtq6I2ZAP49jSBusC
         HZvVDX4Z8gCgH5n0KTRlX2GtpFQKAcY9tPAVsojsQMQyg1SeXZYPSwPAnUJBec0L69
         yHsyEgzGeZkeHoA7xXjry47qdxbHV5C/cndYwc/YJCeuwUF55yC4jfM6BC+r7lVxhF
         rvIX1zkUA69yCpHilVN2R1cbvcBTY2g5erAiCUsny6jylN3WRTvMk6XWty5pWKthJU
         Zl1YU95jVzT+HkXufRT93T/smywZOn4NEZ2ofMn4SzHqhGmhm7vBerrlm+elQ3wmXZ
         gqzBsvQNBcFGg==
Date:   Wed, 13 Apr 2022 08:44:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8350: Add GENI I2C/SPI DMA
 channels
Message-ID: <YlZALC0DdSPB9n+/@matsya>
References: <20220412215137.2385831-1-bjorn.andersson@linaro.org>
 <20220412215137.2385831-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412215137.2385831-2-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-22, 14:51, Bjorn Andersson wrote:
> The GENI I2C and SPI controllers may use the GPI DMA engine, define the
> rx and tx channels for these controllers to enable this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 108 +++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 7e585d9e4c68..8547c0b2f060 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -721,6 +721,9 @@ i2c14: i2c@880000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&qup_i2c14_default>;
>  				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma2 0 0 QCOM_GPI_I2C>,
> +				       <&gpi_dma2 1 0 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";

I have been thinking about this. I dont feel this is right approach here
as this is board dependent and having the firmware loaded on the board..

This was tested on HDK and can fail in MTP or other boards.. which might
be in FIFO mode

So, I think it might be apt to move these to board dtsi.. what do you
think?

-- 
~Vinod
