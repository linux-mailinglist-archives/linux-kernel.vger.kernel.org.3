Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4D49C64C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiAZJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiAZJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:27:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D1C06161C;
        Wed, 26 Jan 2022 01:27:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9250B81C25;
        Wed, 26 Jan 2022 09:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D99C340E3;
        Wed, 26 Jan 2022 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643189267;
        bh=vhq9IzfZY0Kkx/iKL/tX8aAEwobUSIlwyapbLm1SG0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u6aW7MD6w+srRDr2esmBrnP+5wgDjCkAElIkKryBN6VkGdyagIqHWsVDi8TghiJnl
         LyAmq1M0bueEVSPpk7iU49oakTEfv2kWppLeOc3loLvMi8ZVJdPiFNO92LIN5H+1oq
         zc4JDaHdpMdxMLJTnZdokPj7NY7TUiLzKLic8LIOXh9vaIrkq0AHwC/uGuUfDksPeP
         DjkxGzYwPwx+L3ppbJiEwY+TNYSKoAV/Y66Na+EGkneAUCqDQ1Kdd8FMo5DSVhqYwU
         403Ho+S1GaU4hQnsatw9WBphT6xR6nhmn2QR+xtR7iGaU5Eq+P4rzQe377L4Ru5SWH
         Ew9n3rsZZt0gA==
Date:   Wed, 26 Jan 2022 17:27:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        y.bas@phytec.com
Subject: Re: [PATCH RESEND 2/2] ARM: dts: imx6qdl: Handle unneeded
 MFD-subdevices correctly
Message-ID: <20220126092741.GK4686@dragon>
References: <20211216115529.2331475-1-andrej.picej@norik.com>
 <20211216115529.2331475-2-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216115529.2331475-2-andrej.picej@norik.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 12:55:29PM +0100, Andrej Picej wrote:
> From: Yunus Bas <y.bas@phytec.de>
> 
> The proper way to handle partly used MFD devices are to describe all MFD
> subdevices in the devicetree and disable the not used ones. This
> suppresses any warnings that may arise as a result.
> 
> Signed-off-by: Yunus Bas <y.bas@phytec.de>
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Use subject prefix like

  ARM: dts: imx6qdl-phytec: ...

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi      |  5 +++++
>  arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> index 2ec154756bbc..3590f439adf5 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> @@ -213,6 +213,11 @@ pmic_rtc: rtc {
>  		da9063_wdog: wdt {
>  			compatible = "dlg,da9063-watchdog";
>  		};
> +
> +		onkey {
> +			compatible = "dlg,da9063-onkey";
> +			status = "disabled";
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> index 94b254bfd054..28a805384668 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> @@ -116,6 +116,16 @@ watchdog {
>  			dlg,use-sw-pm;
>  		};
>  
> +		thermal {
> +			compatible = "dlg,da9062-thermal";
> +			status = "disabled";
> +		};
> +
> +		gpio {
> +			compatible = "dlg,da9062-gpio";
> +			status = "disabled";
> +		};
> +
>  		regulators {
>  			vdd_arm: buck1 {
>  				regulator-name = "vdd_arm";
> -- 
> 2.25.1
> 
