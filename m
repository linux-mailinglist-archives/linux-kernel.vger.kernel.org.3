Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16950A852
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391511AbiDUSry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391541AbiDUSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:47:47 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8D66555;
        Thu, 21 Apr 2022 11:44:56 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4FF5B221D4;
        Thu, 21 Apr 2022 20:44:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650566694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwxIDd6ckb53r37m9FPq3dmsnLv3+m/NLx3/p+VQ5J0=;
        b=ft3rFVHyL9iJbh/j5Bg58CTE3G4YJCmM0TopNT+mV/mEPWPGqZ1OkdSFFCYMIxTFf3Db8A
        AktsK7KYm473ak4tWDEr000pPRgL2kDmBhDTxhs+KgWbaA3znFHnlRrM1AJevSvImNQdfm
        FdXRm4Lo0+havDOPvnSJwUclUBMcIn4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Apr 2022 20:44:54 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 5/8] arm64: dts: ls1028a: Update SFP binding to include
 clock
In-Reply-To: <20220421175657.1259024-6-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
 <20220421175657.1259024-6-sean.anderson@seco.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d0f67b560e5e0c03549956589e6c4984@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-21 19:56, schrieb Sean Anderson:
> The clocks property is now mandatory. Add it.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Michael Walle <michael@walle.cc>

> ---
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 088271d49139..59b289b52a28 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -224,9 +224,12 @@ rst: syscon@1e60000 {
>  			little-endian;
>  		};
> 
> -		efuse@1e80000 {
> +		sfp: efuse@1e80000 {
>  			compatible = "fsl,ls1028a-sfp";
>  			reg = <0x0 0x1e80000 0x0 0x10000>;
> +			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> +					    QORIQ_CLK_PLL_DIV(4)>;
> +			clock-names = "sfp";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
