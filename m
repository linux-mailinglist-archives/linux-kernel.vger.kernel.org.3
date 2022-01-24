Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B0498766
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbiAXR7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244730AbiAXR7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:59:45 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5371C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:59:44 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 10-20020a9d030a000000b0059f164f4a86so5853708otv.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BWwjW0EgyeuAgOSjmucK+gRx+PtrFHCFEX+4W9R0sEU=;
        b=YSweSEefUIGjTO7Imvy1aBv4aceTxzYRkl9vNQVQArDmVSgcsBRvXuSCtqg1Ql2fF9
         5PGUleSjA7aaCdqSfARUJPculq5XPpCzT3Vxh0XROBNnPvadRxCWDp6Xg1ZNujvsy82o
         a0QlZiE43WGqZ3GwOZFtfJJhvZIP9JPIGY7Leo7ySep+wcXRHcO9pAUf/pmutY2ukWN1
         vuL3PbmWITR77XnUNyYiAdbgcLiIDDteYWmVps5I4zkD2zdOTiZEtPAVQVGdsTWyaLzu
         ojUNlZvnnQaejg+5fHh1pQLGkDmnvzBU6VfqLG6oTCztj4XP/RLABz0mkEDJ9lcZOw7N
         VghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BWwjW0EgyeuAgOSjmucK+gRx+PtrFHCFEX+4W9R0sEU=;
        b=7TtNfSKJgqtSPy/CyNHEWljpN9VmbYm66rAqemhiXHCuIXyO7jtGRFl76hnPQtWa3k
         d4acnjhAbecSA80isci1G4a0xmNLusfMCug7sSodZIAiKELwOtATLBVwgWOz2JzshltG
         hWpzWUNAtMwwZEez93W5wbx4slyAjp1pemoHkc9qXgMUJn4QLNva/uJq6yPX99pDPpfm
         PKKA6cy8GbZVmV81F5+gpM1ctqNE6qTWEPyb4RTAnpsK2yz1sj03Q7S23rMjFTRcSBTk
         egTUb6qgGuFV43G9Z5fHqZEy/6qMOb2sAhm9vYjykDUoEFqUK9FtjwVik2/I7u02RtBi
         8kTg==
X-Gm-Message-State: AOAM531GdQnSswoyItVyY5jwLF69fE3dqW5uJEo8VeR+KIfMqKjX6hr1
        br1VewZsm9oBZ0zBmXsmgplAng==
X-Google-Smtp-Source: ABdhPJySYnuZd0DI70tivFuNgNTa7ff7pGvfWbGlgF9rKiiZAQ114+3pPAVe9TWT1/FEsJ21HcSG0A==
X-Received: by 2002:a05:6830:34a3:: with SMTP id c35mr12681501otu.206.1643047184272;
        Mon, 24 Jan 2022 09:59:44 -0800 (PST)
Received: from eze-laptop ([190.194.87.200])
        by smtp.gmail.com with ESMTPSA id a128sm2663439oob.17.2022.01.24.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:59:43 -0800 (PST)
Date:   Mon, 24 Jan 2022 14:59:37 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, aford@beaconembedded.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH V3 06/10] arm64: dts: imx8mq: Enable both G1 and G2 VPU's
 with vpu-blk-ctrl
Message-ID: <Ye7pCfcasWunm8F3@eze-laptop>
References: <20220124023125.414794-1-aford173@gmail.com>
 <20220124023125.414794-7-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124023125.414794-7-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 08:31:20PM -0600, Adam Ford wrote:
> With the Hantro G1 and G2 now setup to run independently, update
> the device tree to allow both to operate.  This requires the
> vpu-blk-ctrl node to be configured.  Since vpu-blk-ctrl needs
> certain clock enabled to handle the gating of the G1 and G2
> fuses, the clock-parents and clock-rates for the various VPU's
> to be moved into the pgc_vpu because they cannot get re-parented
> once enabled, and the pgc_vpu is the highest in the chain.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel

> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 2df2510d0118..549b2440f55d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -737,7 +737,21 @@ pgc_gpu: power-domain@5 {
>  					pgc_vpu: power-domain@6 {
>  						#power-domain-cells = <0>;
>  						reg = <IMX8M_POWER_DOMAIN_VPU>;
> -						clocks = <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
> +						clocks = <&clk IMX8MQ_CLK_VPU_DEC_ROOT>,
> +							 <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
> +							 <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> +						assigned-clocks = <&clk IMX8MQ_CLK_VPU_G1>,
> +								  <&clk IMX8MQ_CLK_VPU_G2>,
> +								  <&clk IMX8MQ_CLK_VPU_BUS>,
> +								  <&clk IMX8MQ_VPU_PLL_BYPASS>;
> +						assigned-clock-parents = <&clk IMX8MQ_VPU_PLL_OUT>,
> +									 <&clk IMX8MQ_VPU_PLL_OUT>,
> +									 <&clk IMX8MQ_SYS1_PLL_800M>,
> +									 <&clk IMX8MQ_VPU_PLL>;
> +						assigned-clock-rates = <600000000>,
> +								       <600000000>,
> +								       <800000000>,
> +								       <0>;
>  					};
>  
>  					pgc_disp: power-domain@7 {
> @@ -1457,30 +1471,31 @@ usb3_phy1: usb-phy@382f0040 {
>  			status = "disabled";
>  		};
>  
> -		vpu: video-codec@38300000 {
> -			compatible = "nxp,imx8mq-vpu";
> -			reg = <0x38300000 0x10000>,
> -			      <0x38310000 0x10000>,
> -			      <0x38320000 0x10000>;
> -			reg-names = "g1", "g2", "ctrl";
> -			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "g1", "g2";
> +		vpu_g1: video-codec@38300000 {
> +			compatible = "nxp,imx8mq-vpu-g1";
> +			reg = <0x38300000 0x10000>;
> +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>;
> +			power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G1>;
> +		};
> +
> +		vpu_g2: video-codec@38310000 {
> +			compatible = "nxp,imx8mq-vpu-g2";
> +			reg = <0x38310000 0x10000>;
> +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> +			power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
> +		};
> +
> +		vpu_blk_ctrl: blk-ctrl@38320000 {
> +			compatible = "fsl,imx8mq-vpu-blk-ctrl";
> +			reg = <0x38320000 0x100>;
> +			power-domains = <&pgc_vpu>, <&pgc_vpu>, <&pgc_vpu>;
> +			power-domain-names = "bus", "g1", "g2";
>  			clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
> -				 <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
> -				 <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
> -			clock-names = "g1", "g2", "bus";
> -			assigned-clocks = <&clk IMX8MQ_CLK_VPU_G1>,
> -					  <&clk IMX8MQ_CLK_VPU_G2>,
> -					  <&clk IMX8MQ_CLK_VPU_BUS>,
> -					  <&clk IMX8MQ_VPU_PLL_BYPASS>;
> -			assigned-clock-parents = <&clk IMX8MQ_VPU_PLL_OUT>,
> -						 <&clk IMX8MQ_VPU_PLL_OUT>,
> -						 <&clk IMX8MQ_SYS1_PLL_800M>,
> -						 <&clk IMX8MQ_VPU_PLL>;
> -			assigned-clock-rates = <600000000>, <600000000>,
> -					       <800000000>, <0>;
> -			power-domains = <&pgc_vpu>;
> +				 <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> +			clock-names = "g1", "g2";
> +			#power-domain-cells = <1>;
>  		};
>  
>  		pcie0: pcie@33800000 {
> -- 
> 2.32.0
> 
