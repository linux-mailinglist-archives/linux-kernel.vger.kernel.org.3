Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF49D473CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhLNFj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhLNFj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:39:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49CCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5326AB817EE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A34C34604;
        Tue, 14 Dec 2021 05:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639460393;
        bh=qfiuo3dM43mejhpX35RpHK07dow4DnaeMDT75/nCQC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0X3uxX/Xkz4aVPJ4Zo7ibKpzlaH7tdt+y5VeGeVGflhVafvA7IfFsNtDyqXq2SbX
         UQIjC1KQYpWcRl+iCMR6kZfqE2fejRmBy4+WtWX8SB6pY7w2QrSXCYQ8KVNbsHZ2FV
         J0dZ3oE7sEyUIWBg62wwIcIVw6abGJxyQVih52+ljMzkPPKSpLSHLFTO4wnIyl4X2U
         jQREqzuRsS5MDxSjYHU46VFrEjZMYGUtps3TIBICj6Sd/IHKVe+DXXPGsAQpfk0pqt
         FKgWt8TF2fzUw7mpOJzQgSvsqLCvHBeZwUHbQYOio8yT91KgX/Gn/i8IAnc0r6VsGq
         Y4jws7fgD1bbA==
Date:   Tue, 14 Dec 2021 13:39:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH v2 05/10] arm64: dts: lx2160a: update PCIe nodes to match
 rev2 silicon
Message-ID: <20211214053945.GF10916@dragon>
References: <20211203235446.8266-1-leoyang.li@nxp.com>
 <20211203235446.8266-6-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203235446.8266-6-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:54:41PM -0600, Li Yang wrote:
> The original dts was created based on the non-production rev1 silicon
> which was only used for evaluation.  Update the PCIe nodes to align with
> the different controller used in production rev2 silicon.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Reviewed-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 96 +++++++++----------
>  1 file changed, 48 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index fcde09f36018..de680521e1d1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -1088,10 +1088,10 @@ sata3: sata@3230000 {
>  		};
>  
>  		pcie1: pcie@3400000 {
> -			compatible = "fsl,lx2160a-pcie";

Drop lx2160a specific compatible for lx2160a SoC?

Shawn

> -			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
> -			      <0x80 0x00000000 0x0 0x00002000>; /* configuration space */
> -			reg-names = "csr_axi_slave", "config_axi_slave";
> +			compatible = "fsl,ls2088a-pcie";
> +			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
> +			reg-names = "regs", "config";
>  			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
>  				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
>  				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> @@ -1100,26 +1100,26 @@ pcie1: pcie@3400000 {
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			apio-wins = <8>;
> -			ppio-wins = <8>;
> +			num-viewport = <8>;
>  			bus-range = <0x0 0xff>;
> -			ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000
> +				  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> -			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
>  			status = "disabled";
>  		};
>  
>  		pcie2: pcie@3500000 {
> -			compatible = "fsl,lx2160a-pcie";
> -			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
> -			      <0x88 0x00000000 0x0 0x00002000>; /* configuration space */
> -			reg-names = "csr_axi_slave", "config_axi_slave";
> +			compatible = "fsl,ls2088a-pcie";
> +			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
> +			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
> +			reg-names = "regs", "config";
>  			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
>  				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
>  				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> @@ -1128,26 +1128,26 @@ pcie2: pcie@3500000 {
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			apio-wins = <8>;
> -			ppio-wins = <8>;
> +			num-viewport = <8>;
>  			bus-range = <0x0 0xff>;
> -			ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			ranges = <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000
> +				  0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> -			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
>  			status = "disabled";
>  		};
>  
>  		pcie3: pcie@3600000 {
> -			compatible = "fsl,lx2160a-pcie";
> -			reg = <0x00 0x03600000 0x0 0x00100000>, /* controller registers */
> -			      <0x90 0x00000000 0x0 0x00002000>; /* configuration space */
> -			reg-names = "csr_axi_slave", "config_axi_slave";
> +			compatible = "fsl,ls2088a-pcie";
> +			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
> +			       0x90 0x00000000 0x0 0x00002000>; /* configuration space */
> +			reg-names = "regs", "config";
>  			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
>  				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
>  				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> @@ -1156,26 +1156,26 @@ pcie3: pcie@3600000 {
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			apio-wins = <256>;
> -			ppio-wins = <24>;
> +			num-viewport = <256>;
>  			bus-range = <0x0 0xff>;
> -			ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			ranges = <0x81000000 0x0 0x00000000 0x90 0x00010000 0x0 0x00010000
> +				  0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 2 &gic 0 0 GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 3 &gic 0 0 GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 4 &gic 0 0 GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> -			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
>  			status = "disabled";
>  		};
>  
>  		pcie4: pcie@3700000 {
> -			compatible = "fsl,lx2160a-pcie";
> -			reg = <0x00 0x03700000 0x0 0x00100000>, /* controller registers */
> -			      <0x98 0x00000000 0x0 0x00002000>; /* configuration space */
> -			reg-names = "csr_axi_slave", "config_axi_slave";
> +			compatible = "fsl,ls2088a-pcie";
> +			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
> +			       0x98 0x00000000 0x0 0x00002000>; /* configuration space */
> +			reg-names = "regs", "config";
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
>  				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
>  				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> @@ -1184,26 +1184,26 @@ pcie4: pcie@3700000 {
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			apio-wins = <8>;
> -			ppio-wins = <8>;
> +			num-viewport = <8>;
>  			bus-range = <0x0 0xff>;
> -			ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			ranges = <0x81000000 0x0 0x00000000 0x98 0x00010000 0x0 0x00010000
> +				  0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 2 &gic 0 0 GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 3 &gic 0 0 GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 4 &gic 0 0 GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> -			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
>  			status = "disabled";
>  		};
>  
>  		pcie5: pcie@3800000 {
> -			compatible = "fsl,lx2160a-pcie";
> -			reg = <0x00 0x03800000 0x0 0x00100000>, /* controller registers */
> -			      <0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
> -			reg-names = "csr_axi_slave", "config_axi_slave";
> +			compatible = "fsl,ls2088a-pcie";
> +			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
> +			       0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
> +			reg-names = "regs", "config";
>  			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
>  				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
>  				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> @@ -1212,26 +1212,26 @@ pcie5: pcie@3800000 {
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			apio-wins = <256>;
> -			ppio-wins = <24>;
> +			num-viewport = <256>;
>  			bus-range = <0x0 0xff>;
> -			ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			ranges = <0x81000000 0x0 0x00000000 0xa0 0x00010000 0x0 0x00010000
> +				  0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 2 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 3 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 4 &gic 0 0 GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> -			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
>  			status = "disabled";
>  		};
>  
>  		pcie6: pcie@3900000 {
> -			compatible = "fsl,lx2160a-pcie";
> -			reg = <0x00 0x03900000 0x0 0x00100000>, /* controller registers */
> -			      <0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
> -			reg-names = "csr_axi_slave", "config_axi_slave";
> +			compatible = "fsl,ls2088a-pcie";
> +			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
> +			       0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
> +			reg-names = "regs", "config";
>  			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
>  				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
>  				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> @@ -1240,18 +1240,18 @@ pcie6: pcie@3900000 {
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			apio-wins = <8>;
> -			ppio-wins = <8>;
> +			num-viewport = <8>;
>  			bus-range = <0x0 0xff>;
> -			ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			ranges = <0x81000000 0x0 0x00000000 0xa8 0x00010000 0x0 0x00010000
> +				  0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 2 &gic 0 0 GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 3 &gic 0 0 GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 4 &gic 0 0 GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> -			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
>  			status = "disabled";
>  		};
>  
> -- 
> 2.25.1
> 
