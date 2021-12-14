Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAF9473CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhLNFkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhLNFku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:40:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B19C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:40:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01468612B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5031BC34604;
        Tue, 14 Dec 2021 05:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639460449;
        bh=4z7FeS4gE+x7mTX3nQbO22qXp5q8+0QWEKkDTXrMqaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kvv7r+I8RUEZvhgsbEe3whr7S8kCq72s7QEIVq3TUBSn8q3SMvbnQIJYNa8loOQBq
         j6UADdwvso12ZLujJx6xm9/I+pWTupZyvVU8McQfxK4rWDKUf+797s8e/5rNbLcok9
         aZQZut/wKEHW18eUmszJLgGIN3UBbCaNVGGPua4639bppBDmYz1+JIfnYVNGZJhkuC
         4cneowc5W6EYJfdoUPDvodylPRxEpazhcm47hO8mXOvZV1q6HNLpjg+Arq9uPd8vUt
         Kb32JdasANWU5Ga1BRUd6t41Y9IwwuqgjMQqOnfFBTdY4SRS1QlaWHBDnBuPHGCc1s
         P6zKC/iJjZGeA==
Date:   Tue, 14 Dec 2021 13:40:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH v2 06/10] arm64: dts: lx2160a: add pcie EP mode nodes
Message-ID: <20211214054044.GG10916@dragon>
References: <20211203235446.8266-1-leoyang.li@nxp.com>
 <20211203235446.8266-7-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203235446.8266-7-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:54:42PM -0600, Li Yang wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> The LX2160A PCIe EP mode nodes based on controller used on lx2160a rev2.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Reviewed-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index de680521e1d1..593c5a498ae3 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -1115,6 +1115,16 @@ pcie1: pcie@3400000 {
>  			status = "disabled";
>  		};
>  
> +		pcie_ep1: pcie_ep@3400000 {

Hyphen is more recommended than underscore for node name.

Shawn

> +			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
> +			reg = <0x00 0x03400000 0x0 0x00100000
> +			       0x80 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ob-windows = <8>;
> +			num-ib-windows = <8>;
> +			status = "disabled";
> +		};
> +
>  		pcie2: pcie@3500000 {
>  			compatible = "fsl,ls2088a-pcie";
>  			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
> @@ -1143,6 +1153,16 @@ pcie2: pcie@3500000 {
>  			status = "disabled";
>  		};
>  
> +		pcie_ep2: pcie_ep@3500000 {
> +			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
> +			reg = <0x00 0x03500000 0x0 0x00100000
> +			       0x88 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ob-windows = <8>;
> +			num-ib-windows = <8>;
> +			status = "disabled";
> +		};
> +
>  		pcie3: pcie@3600000 {
>  			compatible = "fsl,ls2088a-pcie";
>  			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
> @@ -1171,6 +1191,16 @@ pcie3: pcie@3600000 {
>  			status = "disabled";
>  		};
>  
> +		pcie_ep3: pcie_ep@3600000 {
> +			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
> +			reg = <0x00 0x03600000 0x0 0x00100000
> +			       0x90 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ob-windows = <256>;
> +			num-ib-windows = <24>;
> +			status = "disabled";
> +		};
> +
>  		pcie4: pcie@3700000 {
>  			compatible = "fsl,ls2088a-pcie";
>  			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
> @@ -1199,6 +1229,16 @@ pcie4: pcie@3700000 {
>  			status = "disabled";
>  		};
>  
> +		pcie_ep4: pcie_ep@3700000 {
> +			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
> +			reg = <0x00 0x03700000 0x0 0x00100000
> +			       0x98 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ob-windows = <8>;
> +			num-ib-windows = <8>;
> +			status = "disabled";
> +		};
> +
>  		pcie5: pcie@3800000 {
>  			compatible = "fsl,ls2088a-pcie";
>  			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
> @@ -1227,6 +1267,16 @@ pcie5: pcie@3800000 {
>  			status = "disabled";
>  		};
>  
> +		pcie_ep5: pcie_ep@3800000 {
> +			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
> +			reg = <0x00 0x03800000 0x0 0x00100000
> +			       0xa0 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ob-windows = <256>;
> +			num-ib-windows = <24>;
> +			status = "disabled";
> +		};
> +
>  		pcie6: pcie@3900000 {
>  			compatible = "fsl,ls2088a-pcie";
>  			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
> @@ -1255,6 +1305,16 @@ pcie6: pcie@3900000 {
>  			status = "disabled";
>  		};
>  
> +		pcie_ep6: pcie_ep@3900000 {
> +			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
> +			reg = <0x00 0x03900000 0x0 0x00100000
> +			       0xa8 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ob-windows = <8>;
> +			num-ib-windows = <8>;
> +			status = "disabled";
> +		};
> +
>  		smmu: iommu@5000000 {
>  			compatible = "arm,mmu-500";
>  			reg = <0 0x5000000 0 0x800000>;
> -- 
> 2.25.1
> 
