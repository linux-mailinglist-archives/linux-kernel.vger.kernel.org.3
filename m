Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58BA473CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhLNFms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:42:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46466 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhLNFmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:42:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9408DB817E3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D53C34601;
        Tue, 14 Dec 2021 05:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639460565;
        bh=v/ozOFzbx6x0lJOK+o5SdH1MnXrCunoiEvlCykuoviY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ID+wG5Op9/3ySFidz2J3SXPLlpudftR0h2OmZ4JWX+CL15brgVxGurjCU37lZRUod
         Pr1zaWBz1gl1ejfwde5Pptjt5AEPChHlTh6tpFk5Ik1KkUffyqMjx6eqceMoS1UTu4
         5WRDfCSNPqiGfdSbZMSkdFsui4J5j82YTH3HFw4Jegn25fBfkH2uPWB7yWxwEWNbBJ
         EeM9vtO0JRvSeIJMfn5st3cyhe28os1oHcXVIZW/tepGL5wPZ0asdCnfTp4Qe4VYv5
         5FrmXyPT+TlqqE5tTik3l3J1oqUugwpSDb/VI3DbIsvgqURoHhhFTIlgsezWY8itla
         BuCqYtsJKX66Q==
Date:   Tue, 14 Dec 2021 13:42:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH v2 1/8] arm64: dts: ls1028a: Add PCIe EP nodes
Message-ID: <20211214054240.GH10916@dragon>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
 <20211204001718.8511-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204001718.8511-2-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 06:17:11PM -0600, Li Yang wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add PCIe EP nodes for ls1028a to support EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index fd3f3e8bb6ce..9efcaf68578c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -637,6 +637,18 @@ pcie1: pcie@3400000 {
>  			status = "disabled";
>  		};
>  
> +		pcie_ep1: pcie_ep@3400000 {

pcie-ep

Shawn

> +			compatible = "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
> +			reg = <0x00 0x03400000 0x0 0x00100000
> +			       0x80 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> +			interrupt-names = "pme";
> +			num-ib-windows = <6>;
> +			num-ob-windows = <8>;
> +			status = "disabled";
> +		};
> +
>  		pcie2: pcie@3500000 {
>  			compatible = "fsl,ls1028a-pcie";
>  			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
> @@ -664,6 +676,18 @@ pcie2: pcie@3500000 {
>  			status = "disabled";
>  		};
>  
> +		pcie_ep2: pcie_ep@3500000 {
> +			compatible = "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
> +			reg = <0x00 0x03500000 0x0 0x00100000
> +			       0x88 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> +			interrupt-names = "pme";
> +			num-ib-windows = <6>;
> +			num-ob-windows = <8>;
> +			status = "disabled";
> +		};
> +
>  		smmu: iommu@5000000 {
>  			compatible = "arm,mmu-500";
>  			reg = <0 0x5000000 0 0x800000>;
> -- 
> 2.25.1
> 
