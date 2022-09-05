Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE185AC870
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiIEBLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiIEBLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:11:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6A227163;
        Sun,  4 Sep 2022 18:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75006B80D70;
        Mon,  5 Sep 2022 01:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE76C433C1;
        Mon,  5 Sep 2022 01:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662340264;
        bh=ldNva4ftghdca/S3rxMHbDvUKXG5rCNxNXiZuTq45Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6AHCdWvp8NdxkxYDlPI+aCgz4tVB2GJJ9harmqq1gV2Dd10QrAwZ2J3HjX45Q6rZ
         14mR7y+Xm0bJo04Q+Gj+mCDiEZ8VXBgjyV+lK/P4Z3S7RpLLPdt9Rfwohaz0yJkPP2
         4ELQEY6SoNHYF3v28Se8afGYaEFKPgBYv+/d8VlBX/bO/uVSI5Q0pmi1okSFKedZ2P
         GaYNF3IPYW5v8mbU0IiJ673nh/YtV5R2B5FZLrAB4ZdcQlgrQAIUdZoKF/KtLcEiaQ
         Sb9cpkAc9eIByp8BBs26k1bJCvL2mOeRE0E42/QSmNPOTb+Q8CNKigpW+9YGsl4Wi+
         0suH8ltnR/9CA==
Date:   Mon, 5 Sep 2022 09:10:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH 2/9] arm64: dts: ls1046a: Add the PME interrupt to PCIe
 EP nodes
Message-ID: <20220905011059.GR1728671@dragon>
References: <20220824231200.494-1-leoyang.li@nxp.com>
 <20220824231200.494-3-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824231200.494-3-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 06:11:53PM -0500, Li Yang wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add the PME interrupt property to the PCIe EP nodes.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index ddae3cb0a977..fce3c6401653 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -813,6 +813,8 @@ pcie_ep1: pcie_ep@3400000 {
>  			reg = <0x00 0x03400000 0x0 0x00100000>,
>  			      <0x40 0x00000000 0x8 0x00000000>;
>  			reg-names = "regs", "addr_space";
> +			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */

The comment seems unnecessary, considering we have the interrupt-names
below?

Shawn

> +			interrupt-names = "pme";
>  			num-ib-windows = <6>;
>  			num-ob-windows = <8>;
>  			status = "disabled";
> @@ -849,6 +851,8 @@ pcie_ep2: pcie_ep@3500000 {
>  			reg = <0x00 0x03500000 0x0 0x00100000>,
>  			      <0x48 0x00000000 0x8 0x00000000>;
>  			reg-names = "regs", "addr_space";
> +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> +			interrupt-names = "pme";
>  			num-ib-windows = <6>;
>  			num-ob-windows = <8>;
>  			status = "disabled";
> @@ -885,6 +889,8 @@ pcie_ep3: pcie_ep@3600000 {
>  			reg = <0x00 0x03600000 0x0 0x00100000>,
>  			      <0x50 0x00000000 0x8 0x00000000>;
>  			reg-names = "regs", "addr_space";
> +			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> +			interrupt-names = "pme";
>  			num-ib-windows = <6>;
>  			num-ob-windows = <8>;
>  			status = "disabled";
> -- 
> 2.37.1
> 
