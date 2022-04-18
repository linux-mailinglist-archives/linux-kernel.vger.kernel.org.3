Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E3E505A55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiDROyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiDROx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC8225FF;
        Mon, 18 Apr 2022 06:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272866123E;
        Mon, 18 Apr 2022 13:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C7CC385A1;
        Mon, 18 Apr 2022 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650289368;
        bh=bqGZ1kGzyUYlvq41yPIPnL6lghliWJl9al76Y6Ostu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EG4G8cSPEIjpvBEh3QKd83QugJPpMcYsstxGLCukXXwMri6KydxLAwqGdhAAborIZ
         /JWcOA0MLN9QVbRgDxbmOY30mwEP83Zhix5Fl0X5gblHoCuPk5Hbg+7t19GzzzMDQm
         6ZjywOk5cjEkAeE/w3Je6HlWK/H1MjEV8v37e3zEvku9VYjKACEL4kGHDxlEr7UP6r
         6XjUXuiLR2kbNMCOmdny1RbAEGvWmmvxVM+8uCQngUlXBO8ZiiFdZoW09pgBpWP4/l
         47KD63l8ON6Oyf765MNc3/HWuWhs8Wf5necNkSV6jLBlY1SJhuuctmaHG0PKqcuu1M
         vYF21C1QUparg==
Date:   Mon, 18 Apr 2022 19:12:41 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: db845c: Add support for MCP2517FD
Message-ID: <20220418134241.GA161722@thinkpad>
References: <20220418125841.1409738-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418125841.1409738-1-vkoul@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 06:28:41PM +0530, Vinod Koul wrote:
> Add support for onboard MCP2517FD SPI CAN transceiver attached to
> SPI0 of RB3.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 28fe45c5d516..5179f8ddb060 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -28,6 +28,13 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	/* Fixed crystal oscillator dedicated to MCP2517FD */
> +	clk40M: can_clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <40000000>;
> +	};
> +
>  	dc12v: dc12v-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "DC12V";
> @@ -746,6 +753,22 @@ codec {
>  	};
>  };
>  
> +&spi0 {
> +	/* On Low speed expansion */

Only SPI2 is exposed on the LS header. This one is dedicated to CAN controller.

> +	status = "okay";

No chip select? Since CAN controller may operate at higher frequencies, it
makes sense to increase the drive strength of the pins.

Thanks,
Mani

> +
> +	can@0 {
> +		compatible = "microchip,mcp2517fd";
> +		reg = <0>;
> +		clocks = <&clk40M>;
> +		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
> +		spi-max-frequency = <10000000>;
> +		vdd-supply = <&vdc_5v>;
> +		xceiver-supply = <&vdc_5v>;
> +		status = "okay";
> +	};
> +};
> +
>  &spi2 {
>  	/* On Low speed expansion */
>  	label = "LS-SPI0";
> -- 
> 2.34.1
> 
