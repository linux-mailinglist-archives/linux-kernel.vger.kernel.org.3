Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0FB468E81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhLFBTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:19:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55210 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhLFBTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:19:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41757B80EF4;
        Mon,  6 Dec 2021 01:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEF8C00446;
        Mon,  6 Dec 2021 01:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638753337;
        bh=fwqR5jEuaaNMcM6XQvmhU1fM6IhHiN00Cky2djZ5ckU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nanyWaVDd66pYF402N3CLoX/tDYZyhS2sbuIliG1poQu0jIADrfgjIJGEZhms4W/k
         Y4exK3lMr1AUz/bXAf43k/H7E09o4hWxs5S41s8cVBxRlywpvK0Eqj040UY+z+bq5K
         gsL9eDydB3PdRWdw4137f4gazbNC2bZDKY4ZTY5nRBnBrgMUKl5p5YX3Z7igeg07qm
         Ut7HqpnpuOY6qhxemUQiLpC7Ryr5qFZfBJv9HQrFhA44AyQjcq2ckMAM5lqWENh/T4
         tTUQawS186dy7LF2ukrUFB1T9lwhynbTbmpIjU8JKmRKsKrfVyzfUk/mgRS2wV5qlh
         xXjDQqfjnd7VQ==
Date:   Mon, 6 Dec 2021 09:15:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] arm64: dts: imx8m: configure FEC PHY VDDIO voltage
Message-ID: <20211206011531.GM4216@dragon>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
 <20211123080506.21424-5-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123080506.21424-5-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 04:05:03PM +0800, Joakim Zhang wrote:
> As commit 2f664823a470 ("net: phy: at803x: add device tree binding")
> described, configure FEC PHY VDDIO voltage according to board design.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 4 ++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index 50b3bbb662d5..3bac87b7e142 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -117,6 +117,12 @@
>  			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
>  			reset-assert-us = <10000>;
>  			qca,disable-smarteee;
> +			vddio-supply = <&vddio>;
> +
> +			vddio: vddio-regulator {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index 342f57e8cf61..c3f15192b76c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> @@ -100,6 +100,12 @@
>  			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
>  			reset-assert-us = <10000>;
>  			qca,disable-smarteee;
> +			vddio-supply = <&vddio>;
> +
> +			vddio: vddio-regulator {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index a9e33548a2f3..c96d23fe3010 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -170,6 +170,10 @@
>  			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
>  			reset-assert-us = <10000>;
>  			qca,disable-smarteee;
> +			vddio-supply = <&vddh>;
> +
> +			vddh: vddh-regulator {
> +			};

Why does this need to be different from the one on imx8mm-evk and
imx8mn-evk?

Shawn

>  		};
>  	};
>  };
> -- 
> 2.17.1
> 
