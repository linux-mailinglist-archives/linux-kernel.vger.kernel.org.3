Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2949A554233
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356975AbiFVFSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356903AbiFVFS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:18:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A1835878;
        Tue, 21 Jun 2022 22:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD5DAB81B1F;
        Wed, 22 Jun 2022 05:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA20C34114;
        Wed, 22 Jun 2022 05:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655875101;
        bh=VoV8OGSZ0jorZeFVFgHmp7IeeSZV7t8CzZfDnFCBZuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ae4psxoNF+hbYlE8i4wuyynB1QHpCSs+URyM/jWAAwxBaD/wGP/IMFuBKKdgWjnOf
         7zziA3DQ/En+AR0W7aCuKzLw6QQF6g8AtVt0j+4+oRmSW2xIn4xDnXiACu+o0urfKo
         qNHRXi3opuTOcd7ITbf/t3wCGKDJd2kL9mE00aXw8UwbbZf+en6IQF6EIuDclbJwvj
         hlPiEPLJPnFKVDdk2ngd4vv2dcLAYshGrTBVBrj0BkQ8nB8cJLdlaIib3Qm+Z3rg8j
         6Qy9g0ZDKzlXhvSdL83L80mT7izuwNVjhAeTXKKXSi06pGfjE1HrtBf2mt+VrMdp48
         xLbDQ4rc5sKBA==
Date:   Wed, 22 Jun 2022 10:48:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andrey Konovalov <andrey.konovalov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: fix default pinctrl settings
 for blsp1_spi1
Message-ID: <YrKmGfUrOw5awgNw@matsya>
References: <20220611195713.131597-1-andrey.konovalov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611195713.131597-1-andrey.konovalov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-22, 22:57, Andrey Konovalov wrote:
> The current settings refer to "blsp_spi1" function which isn't defined.
> For this reason an attempt to enable blsp1_spi1 interface results in
> the probe failure below:
> 
> [    3.492900] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> [    3.502460] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> [    3.517725] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> [    3.532998] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> [    3.548277] spi_qup: probe of 78b6000.spi failed with error -22
> 
> Fix this by making the functions used in qcs404.dtsi to match the contents
> of drivers/pinctrl/qcom/pinctrl-qcs404.c.

Right, I cannot find blsp_spi1 which is the only one which is missing,
not sure why...

Bjorn do you recall why SPI1 is treated differently...

> 
> Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index d912166b7552..0d9e1f19aa67 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -669,8 +669,25 @@ blsp1_spi0_default: blsp1-spi0-default {
>  			};
>  
>  			blsp1_spi1_default: blsp1-spi1-default {
> -				pins = "gpio22", "gpio23", "gpio24", "gpio25";
> -				function = "blsp_spi1";
> +				mosi {
> +					pins = "gpio22";
> +					function = "blsp_spi_mosi_a1";
> +				};
> +
> +				miso {
> +					pins = "gpio23";
> +					function = "blsp_spi_miso_a1";
> +				};
> +
> +				cs_n {
> +					pins = "gpio24";
> +					function = "blsp_spi_cs_n_a1";
> +				};
> +
> +				clk {
> +					pins = "gpio25";
> +					function = "blsp_spi_clk_a1";
> +				};
>  			};
>  
>  			blsp1_spi2_default: blsp1-spi2-default {
> -- 
> 2.25.1

-- 
~Vinod
