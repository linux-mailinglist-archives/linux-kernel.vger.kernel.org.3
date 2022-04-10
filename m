Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6F34FAB5D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiDJB2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiDJB2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:28:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8881FFD15;
        Sat,  9 Apr 2022 18:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20B3EB80A39;
        Sun, 10 Apr 2022 01:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959BBC385A4;
        Sun, 10 Apr 2022 01:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649553949;
        bh=dhIKRfQnFR0J7ifWqm1AfWCZSimVYan34JlaRiuG5gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gl8grT+E7Bh2+swwuot6Yb4Fv0Oq57woE7eSlngyVMCTShZmT2ZC224sA6KNiyzX5
         eLgsMR17gN9FqMw4XvTBFRMfUJfasnI4oesc15LYQiCp6+TkYOkG0CLtAUmTIVDQPs
         P6XNxXZxrLUb7YKSdyGxpWD2dh9MIeuwI12qXGyJwWLhxEdYaUIA5y1xwU7V7X7sES
         mnIwXGhu4XRjy+ZDVuRuZL8yTeaIFIAPlqhLL2x1wCuolE4bT2g++fPM8DD0rVpkSQ
         1wgmkIL4NHJ2KGw+RT8tK66PqEJM8HKwWIt0PaffRhX1v+x84Ou+Wtyf7vpG4KbprX
         twF3BH51eLQiA==
Date:   Sun, 10 Apr 2022 09:25:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Biwen Li <biwen.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: ls208xa-rdb: fix errata E-00013
Message-ID: <20220410012543.GJ129381@dragon>
References: <20220317190109.3742-1-leoyang.li@nxp.com>
 <20220317190109.3742-5-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317190109.3742-5-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:01:08PM -0500, Li Yang wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Specify a channel zero in idle state to
> avoid enterring tri-stated state for PCA9547.

Please check Documentation/process/submitting-patches.rst for commit log
wrapping requirement.

> About E-00013:
> 	- Description: I2C1 and I2C3 buses

Use space instead of tab for bullet indent.

Shawn

> 	  are missing pull-up.
> 	- Impact: When the PCA954x device is tri-stated, the I2C bus
> 	  will float. This makes the I2C bus and its associated
> 	  downstream devices inaccessible.
> 	- Hardware fix: Populate resistors R189 and R190 for I2C1
> 	  and resistors R228 and R229 for I2C3.
> 	- Software fix: Remove the tri-state option from the PCA954x
> 	  driver(PCA954x always on enable status, specify a
> 	  channel zero in dts to fix the errata E-00013).
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
> index 4b71c4fcb35f..a752f06a2e74 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
> @@ -49,6 +49,8 @@ pca9547@75 {
>  		reg = <0x75>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		idle-state = <0>;
> +
>  		i2c@1 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -- 
> 2.25.1
> 
