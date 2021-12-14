Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776A2473CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhLNFsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:48:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48510 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhLNFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:48:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7457B817EE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B393DC34601;
        Tue, 14 Dec 2021 05:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639460891;
        bh=WuGSJShI2QIz0wC1ZbAIk1LaghcSTEvb30SmNo3z3f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xct+et4D/mIxCGr1XcI5EnsY1xNVjiO7+acCwxH2FgkTvnef/jp8KRfJibYn2eMmm
         9dG17I5Hrq4L9aTJaqE/hcnjjTH5rViVn+jLjKXhZ05DCMVrW6r9h6oQbR4WQIPKCZ
         6jVfZRtrfBglcYpfycyW0SgEqZliPlqixi2slTLuum8pyQMMWcQ3qbfK5YasuR4OrX
         Q5MVv6Qrqj1u4lJWMVgFU/Lo4hDmyc1FWWAiZHY7KztqgqVdqcBEFAbQt8QyKl7Eur
         LdvWhlYlkVpw1UoS1jjTckpAAbf142tQuLyiiOMQkIe2Xh76dpsSxQrtGUesVXNm05
         8/LJE14IZw2aA==
Date:   Tue, 14 Dec 2021 13:48:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>, Li Yang <leoyang.lil@nxp.com>
Subject: Re: [PATCH v2 6/8] arm64: dts: ls1028a-qds: move rtc node to the
 correct i2c bus
Message-ID: <20211214054805.GJ10916@dragon>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
 <20211204001718.8511-7-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204001718.8511-7-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 06:17:16PM -0600, Li Yang wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> The i2c rtc is on i2c2 bus not i2c1 bus, so fix it in dts.
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> Signed-off-by: Li Yang <leoyang.lil@nxp.com>

Do we need a Fixes tag?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 00d5b81bdef3..baa1cc9b9835 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -276,11 +276,6 @@ temperature-sensor@4c {
>  				vcc-supply = <&sb_3v3>;
>  			};
>  
> -			rtc@51 {
> -				compatible = "nxp,pcf2129";
> -				reg = <0x51>;
> -			};
> -
>  			eeprom@56 {
>  				compatible = "atmel,24c512";
>  				reg = <0x56>;
> @@ -322,6 +317,15 @@ mux: mux-controller {
>  
>  };
>  
> +&i2c1 {
> +	status = "okay";
> +
> +	rtc@51 {
> +		compatible = "nxp,pcf2129";
> +		reg = <0x51>;
> +	};
> +};
> +
>  &enetc_port1 {
>  	phy-handle = <&qds_phy1>;
>  	phy-mode = "rgmii-id";
> -- 
> 2.25.1
> 
