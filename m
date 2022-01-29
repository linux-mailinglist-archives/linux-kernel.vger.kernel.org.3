Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB74A2C03
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 06:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiA2FmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 00:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiA2FmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 00:42:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2671C061714;
        Fri, 28 Jan 2022 21:42:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A8E0B810B5;
        Sat, 29 Jan 2022 05:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE44C340E5;
        Sat, 29 Jan 2022 05:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643434935;
        bh=LoAoF7yy0Un52RRaftmOWr5pz+rkN/vIg5UWMkGtPoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O50X2Lo6oE18Dt55OF1ElH27UL3WDJ5KtZCfBi79GG6SwbZukhdEn0OIVCXbXox2/
         6qq1h3HpERGNFwgMIpWDRFDScUINWomMaKl4xAxtetOc38vozLLw1VcyRWOFHFI1Gp
         JHjREJYeAw0fS3TP1pSmAa3uRRZpd29jNipNH6TiTy61IJCKrDQOt14MQ7uAmW3kHP
         LEJcfUZhVnD71JG6YumhVma+nIx1d/Xo/49ZXE2yHaW6afmoomGlWNIHtEjV0xtiBt
         FVf4Cym4Ptt/W5gkkZ44K2DtVZJQMG6CjOr9PDK6Dv+CNIT457wBPYHGSYxz5SxbDK
         l2JHzNdon2FYA==
Date:   Sat, 29 Jan 2022 13:42:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH 2/2] Revert "arm64: dts: ls1028a: add flextimer based pwm
 nodes"
Message-ID: <20220129054209.GO4686@dragon>
References: <20220115210907.451189-1-michael@walle.cc>
 <20220115210907.451189-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115210907.451189-2-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 10:09:07PM +0100, Michael Walle wrote:
> The changes to the device tree look very wrong. There are now two
> devices with the same base address: pwm0 and ftm_alarm0. Both are using
> the Flex Timer Module. It seems like this should either be one driver or
> and MFD driver. Either way, there should only be one node in the device
> tree. Revert the offending changes to avoid getting a broken device tree
> in circulation.

Why not just fix the conflicting nodes?

Shawn

> 
> This reverts commit 71799672ea24d2935322d655d2407c1ccd7db9ff.
> 
> Fixes: 71799672ea24 ("arm64: dts: ls1028a: add flextimer based pwm nodes")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> 
> Btw, the nodes are also not sorted by the address. Otherwise it should have
> been spotted easily.
> 
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 95 -------------------
>  1 file changed, 95 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 1ef26cbc79cb..d3cc8cbaf768 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -66,13 +66,6 @@ CPU_PW20: cpu-pw20 {
>  		};
>  	};
>  
> -	rtc_clk: rtc-clk {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <32768>;
> -		clock-output-names = "rtc_clk";
> -	};
> -
>  	sysclk: sysclk {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> @@ -1245,94 +1238,6 @@ ierb@1f0800000 {
>  			reg = <0x01 0xf0800000 0x0 0x10000>;
>  		};
>  
> -		pwm0: pwm@2800000 {
> -			compatible = "fsl,vf610-ftm-pwm";
> -			#pwm-cells = <3>;
> -			reg = <0x0 0x2800000 0x0 0x10000>;
> -			clock-names = "ftm_sys", "ftm_ext",
> -				      "ftm_fix", "ftm_cnt_clk_en";
> -			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> -				 <&rtc_clk>, <&clockgen 4 1>;
> -			status = "disabled";
> -		};
> -
> -		pwm1: pwm@2810000 {
> -			compatible = "fsl,vf610-ftm-pwm";
> -			#pwm-cells = <3>;
> -			reg = <0x0 0x2810000 0x0 0x10000>;
> -			clock-names = "ftm_sys", "ftm_ext",
> -				      "ftm_fix", "ftm_cnt_clk_en";
> -			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> -				 <&rtc_clk>, <&clockgen 4 1>;
> -			status = "disabled";
> -		};
> -
> -		pwm2: pwm@2820000 {
> -			compatible = "fsl,vf610-ftm-pwm";
> -			#pwm-cells = <3>;
> -			reg = <0x0 0x2820000 0x0 0x10000>;
> -			clock-names = "ftm_sys", "ftm_ext",
> -				      "ftm_fix", "ftm_cnt_clk_en";
> -			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> -				 <&rtc_clk>, <&clockgen 4 1>;
> -			status = "disabled";
> -		};
> -
> -		pwm3: pwm@2830000 {
> -			compatible = "fsl,vf610-ftm-pwm";
> -			#pwm-cells = <3>;
> -			reg = <0x0 0x2830000 0x0 0x10000>;
> -			clock-names = "ftm_sys", "ftm_ext",
> -				      "ftm_fix", "ftm_cnt_clk_en";
> -			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> -				 <&rtc_clk>, <&clockgen 4 1>;
> -			status = "disabled";
> -		};
> -
> -		pwm4: pwm@2840000 {
> -			compatible = "fsl,vf610-ftm-pwm";
> -			#pwm-cells = <3>;
> -			reg = <0x0 0x2840000 0x0 0x10000>;
> -			clock-names = "ftm_sys", "ftm_ext",
> -				      "ftm_fix", "ftm_cnt_clk_en";
> -			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> -				 <&rtc_clk>, <&clockgen 4 1>;
> -			status = "disabled";
> -		};
> -
> -		pwm5: pwm@2850000 {
> -			compatible = "fsl,vf610-ftm-pwm";
> -			#pwm-cells = <3>;
> -			reg = <0x0 0x2850000 0x0 0x10000>;
> -			clock-names = "ftm_sys", "ftm_ext",
> -				      "ftm_fix", "ftm_cnt_clk_en";
> -			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> -				 <&rtc_clk>, <&clockgen 4 1>;
> -			status = "disabled";
> -		};
> -
> -		pwm6: pwm@2860000 {
> -			compatible = "fsl,vf610-ftm-pwm";
> -			#pwm-cells = <3>;
> -			reg = <0x0 0x2860000 0x0 0x10000>;
> -			clock-names = "ftm_sys", "ftm_ext",
> -				      "ftm_fix", "ftm_cnt_clk_en";
> -			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> -				 <&rtc_clk>, <&clockgen 4 1>;
> -			status = "disabled";
> -		};
> -
> -		pwm7: pwm@2870000 {
> -			compatible = "fsl,vf610-ftm-pwm";
> -			#pwm-cells = <3>;
> -			reg = <0x0 0x2870000 0x0 0x10000>;
> -			clock-names = "ftm_sys", "ftm_ext",
> -				      "ftm_fix", "ftm_cnt_clk_en";
> -			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> -				 <&rtc_clk>, <&clockgen 4 1>;
> -			status = "disabled";
> -		};
> -
>  		rcpm: power-controller@1e34040 {
>  			compatible = "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-2.1+";
>  			reg = <0x0 0x1e34040 0x0 0x1c>;
> -- 
> 2.30.2
> 
