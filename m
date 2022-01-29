Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB64A2C15
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiA2GIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiA2GI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:08:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF9C061714;
        Fri, 28 Jan 2022 22:08:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B86A4CE2819;
        Sat, 29 Jan 2022 06:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA20C340E5;
        Sat, 29 Jan 2022 06:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643436505;
        bh=tLYaGkg/g+8W3qrZvCOUhXf3PLvEwRDD2vcUIxdn/io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJEX56Xl5Y0OV9CGxrgFZdXeJV/RB9PGuZjEcIGA8lkQ5on5zfn+Bvr59qeE+m5ag
         rAgwbha5+fTBhsXRksVnCnJzsZoja77W6eNEsBtOMeGvfEbP0D+bRkaZ46HSijZYEM
         jeLEMz+a8cG+N6UMjI6KihIgf5Jqib1OrB4ditC7/rElSHjxqSK8sbGPlq9I3ELop6
         KLYUDU1x+yEAViehYDLlmxlU5Hyqd61mCPpEewhTs+03fh6Q/0l4AE45dkQ7PgBC0Y
         q1YYherFswDVPlwiOx/y/SqMcrcUSsSciGoLgv3XrKzT3Pv7V7pZubC3aS8bgN+fCW
         A4TX8jnGK7iPw==
Date:   Sat, 29 Jan 2022 14:08:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: add PCA6416 interrupt controller
 mode
Message-ID: <20220129060818.GQ4686@dragon>
References: <20220117230639.1257549-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117230639.1257549-1-hugo@hugovil.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 06:06:39PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add interrupt controller mode for the pca6416 on i.MX8MP EVK board's.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

It doesn't apply to my branch.  Could you rebase?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index 66437b659f3a..00e1e1342162 100755
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -526,6 +526,12 @@ pca6416: gpio@20 {
>  		reg = <0x20>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pca6416_int>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
>  	};
>  
>  	codec: wm8960@1a {
> @@ -1209,6 +1215,12 @@ pinctrl_csi_mclk: csi_mclk_grp {
>  			MX8MP_IOMUXC_GPIO1_IO15__CCM_CLKO2	0x59
>  		>;
>  	};
> +
> +	pinctrl_pca6416_int: pca6416_int_grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
> +		>;
> +	};
>  };
>  
>  &vpu_g1 {
> -- 
> 2.30.2
> 
