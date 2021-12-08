Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B5E46D310
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhLHMNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:13:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58752 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbhLHMNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:13:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3C2DCE1FD6;
        Wed,  8 Dec 2021 12:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA5BC341CA;
        Wed,  8 Dec 2021 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638965411;
        bh=Jm3qvJnwIM8XkCcFVtPu2jUX5ZvPVIUSd05PWLnQZVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1/uJZzfEdzN3Gwp+kH3PV1cdXDThRlyeFXjz5XqfG+6JxzCuSxr4KrRAzS9oFfTj
         IQ/EsM2UykeTj2auyLkz04w67GadPXi3Slfha4S5nvkXKPlmFd6W52G1xo5lCysol1
         FsJexiVqTQ3aXBJEtpkRag71KH+jCwi2bffNq9VZHdA05Sy0mBN1HIdqbch0FfnhXZ
         w1J6xOmT5BB8e2Pe6PJclPQ1We+1MhpaQvm+lP4iLhSP2uTqM8g9mSSD3UXjYhaiUO
         4Vdc/Kr3RsFuObnptku8mrinUKJWHd6oj3UKlLpirSImVxTdnD3hz/vNcn6A2GLJcv
         uLzYJU+pJsiBQ==
Date:   Wed, 8 Dec 2021 20:10:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, ping.bai@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] arm64: dts: imx8ulp: add scmi firmware node
Message-ID: <20211208121000.GG4216@dragon>
References: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
 <20211117032740.2518926-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117032740.2518926-3-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 11:27:39AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8ULP use scmi firmware based power domain and sensor support.
> So add the firmware node and the sram it uses.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index fb8714379026..d567ef93f8d8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/clock/imx8ulp-clock.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/imx8ulp-power.h>
>  
>  #include "imx8ulp-pinfunc.h"
>  
> @@ -102,6 +103,40 @@ sosc: clock-sosc {
>  		#clock-cells = <0>;
>  	};
>  
> +	sram@2201f000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0 0x2201f000 0x0 0x1000>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x0 0x2201f000 0x1000>;
> +
> +		scmi_buf: scmi_buf@0 {

Hyphen is more recommended than underscore for node name.  Or just
follow the naming in arm,scmi.yaml example?

Shawn

> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0x400>;
> +		};
> +	};
> +
> +	firmware {
> +		scmi {
> +			compatible = "arm,scmi-smc";
> +			arm,smc-id = <0xc20000fe>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			shmem = <&scmi_buf>;
> +
> +			scmi_devpd: protocol@11 {
> +				reg = <0x11>;
> +				#power-domain-cells = <1>;
> +			};
> +
> +			scmi_sensor: protocol@15 {
> +				reg = <0x15>;
> +				#thermal-sensor-cells = <0>;
> +			};
> +		};
> +	};
> +
>  	soc@0 {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> -- 
> 2.25.1
> 
