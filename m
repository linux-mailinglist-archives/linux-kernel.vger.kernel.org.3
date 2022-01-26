Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6162E49C660
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiAZJgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:36:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38636 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiAZJgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:36:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27B27615F8;
        Wed, 26 Jan 2022 09:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE56C340E3;
        Wed, 26 Jan 2022 09:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643189765;
        bh=aQM0q2S8evodH/WEjYRiOEZ0nH6KQTk5G4P9myouHpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoC8GxKKGjbyi3oyF+tWoyK5pREXBctG5k0i6Cu7rwaVIAiI/nHSXZ+UYzs9bNso+
         AQcAZA8fVUua1fLe66E1oi9x+S3fIa5J5iNs6nxjgm2XBcb4EJCUdkB4x8ENHKXjB0
         /VdxSGKZbx42OeHFGx4MTtEw8jot/yXfBWBLnHJdxzYG/Xf9OyMRsNGko8FwaIghU2
         Yv89FofXjkl/jXTFJ1kpzFOSpeB9zV+nKB9XULErezuiFfwerNYtjDlfci+2fZrcQV
         92ssUyhhn9n0jLwtDdC/Tqz901gi4MYG1JcjBsGMpW3DB5hazS/96ebVJRSUH1bxgM
         cTOGCA58QmORA==
Date:   Wed, 26 Jan 2022 17:35:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mn-venice-gw7902: disable gpu
Message-ID: <20220126093558.GL4686@dragon>
References: <20211216161227.31960-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216161227.31960-1-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:12:27AM -0800, Tim Harvey wrote:
> Since commit 99aa29932271 ("arm64: dts: imx8mn: Enable GPU")
> imx8mn-venice-gw7902 will hang during kernel init because it uses
> a MIMX8MN5CVTI which does not have a GPU.

I do not quite follow on this.  i.MX8MN integrates a GPU, and
MIMX8MN5CVTI is built on i.MX8MN, correct?  If so, how comes
MIMX8MN5CVTI doesn't have a GPU?

> 
> Disable pgc_gpumix to work around this. We also disable the GPU devices
> that depend on the gpumix power domain and pgc_gpu to avoid them staying
> in a probe deferred state forever.

Is this an indication that GPU should be disabled in imx8mn.dtsi and
enabled board by board?

Shawn

> 
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../boot/dts/freescale/imx8mn-venice-gw7902.dts      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> index 236f425e1570..2d58005d20e4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> @@ -220,6 +220,10 @@
>  	};
>  };
>  
> +&disp_blk_ctrl {
> +	status = "disabled";
> +};
> +
>  /* off-board header */
>  &ecspi2 {
>  	pinctrl-names = "default";
> @@ -251,6 +255,10 @@
>  	};
>  };
>  
> +&gpu {
> +	status = "disabled";
> +};
> +
>  &i2c1 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -546,6 +554,10 @@
>  	status = "okay";
>  };
>  
> +&pgc_gpumix {
> +	status = "disabled";
> +};
> +
>  /* off-board header */
>  &sai3 {
>  	pinctrl-names = "default";
> -- 
> 2.17.1
> 
