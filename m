Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE36C5ABC93
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 05:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiICD0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 23:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiICD0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 23:26:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59723ED54;
        Fri,  2 Sep 2022 20:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EFB7B82D29;
        Sat,  3 Sep 2022 03:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FECEC433D7;
        Sat,  3 Sep 2022 03:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662175588;
        bh=98NKJlaPWZHnwvVGk2QKrUmwnmDcquvTeKOMmxSnIrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldm+DGAekvedKf/is4OTH/bJJQftOyWcsLLuaCqmL5rH9JtaDKaF789Fz9fFYFTXx
         Txr8XZKvwqwqTExMP0Z92I7onXCsue6XhL+pRzphk9CjneOjSNhXjXctGKb9kLm2DY
         6fugTwrokdeiycxG3QwCmOqTHZxgkCMScjAKr+3MY2k+g2C29mNCVkl2rapafRutp0
         a+ppdT0Bj/mhjeO/2sqQmYyB+35kc0drgCJb+ZqW6ThE1GWLSzcTeLycndDLP61bhJ
         cUiKLvpVPQmdt9OKu+x9ycfIUnsg9MXVoXkB9JGDxfDPUyhBgakmakXCudBmk+yhQT
         6fgBYUFxdfuFQ==
Date:   Sat, 3 Sep 2022 11:26:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 0/8] arm64: dts: imx8mm-kontron: Improvements and OSM
 board support
Message-ID: <20220903032621.GD1728671@dragon>
References: <20220822080357.24478-1-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822080357.24478-1-frieder@fris.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:03:46AM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This set contains a few improvements for the imx8mm-kontron devicetrees
> (patch 3-7) and support for a new SoM (patch 8, including baseboard) that
> complies to the Open Standard Module (OSM) 1.0 hardware specification, size S
> (https://sget.org/standards/osm).
> 
> It also includes binding changes in patch 1 and 2.
> 
> Changes in v4:
> * fix hex values and unit addresses in SPI NOR partition nodes
> * fix SoM dtsi includes
> 
> Changes in v3:
> * drop patch for 2 which was applied separately
> * rebase on v6.0-rc1
> * rename compatibles and file names
> 
> Changes in v2:
> * move binding changes to beginning of patchset
> * Allow arbitrary regulator names in PCA9450 bindings
> * Use voltage rail names from schematic for PMIC regulator-names
> * Add SPI NOR partition layout to devicetree
> * Remove unneeded header include
> * Add tags
> 
> Frieder Schrempf (8):
>   dt-bindings: arm: fsl: Rename compatibles for Kontron i.MX8MM
>     SoM/board
>   dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S board
>   arm64: dts: imx8mm-kontron: Adjust compatibles, file names and model
>     strings
>   arm64: dts: imx8mm-kontron: Use the VSELECT signal to switch SD card
>     IO voltage
>   arm64: dts: imx8mm-kontron: Remove low DDRC operating point
>   arm64: dts: imx8mm-kontron: Use voltage rail names from schematic for
>     PMIC regulator-names
>   arm64: dts: imx8mm-kontron: Add SPI NOR partition layout
>   arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S

Applied all, thanks!
