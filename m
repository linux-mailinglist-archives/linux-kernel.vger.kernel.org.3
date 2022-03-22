Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6793F4E4640
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiCVStV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiCVStS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:49:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C4B8F997;
        Tue, 22 Mar 2022 11:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 765E7B81D56;
        Tue, 22 Mar 2022 18:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6132C340F2;
        Tue, 22 Mar 2022 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647974868;
        bh=AcegB2MSlk0Godl3h3BGMTVyZS57blUmDblLAtl/clg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlaF4DNAzwPr0LgXTNCSLJOEE0JPp1SozzqeK4vUuXOJOg5uqje3Lc+PlIzS173is
         bTp+UV9jOj3Tnarge3xhS2TGGXLBJJ3upx2YWsIeUwAYc28y+8SkU3KxdD+cwleqRi
         QLAo/tmP4gyNJHDljUSYzn+Xr5aEZAfLbisxVf4F8ClZTQ1mZVbmgfi/wu2cpYYnCn
         6DlHV3dwBd4mLvSA9d3XM1pH1caj1/1+Q8gKdJqvZ1fom5jpUshJuJSYbjSwvJIO05
         2vE/Tjya1rp/Hw5g0GesY5kDdeccU4SuIXTj1YvzJJbGw5fq91uAPY8aquetlqpSsJ
         T+6LTDq1vS5/g==
Received: by pali.im (Postfix)
        id 56C07843; Tue, 22 Mar 2022 19:47:44 +0100 (CET)
Date:   Tue, 22 Mar 2022 19:47:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marek.behun@nic.cz
Subject: Re: [PATCH v2 1/2] arm64: dts: uDPU: update partition table
Message-ID: <20220322184744.pbiv3puccs2wb3lu@pali>
References: <20220322105857.1107016-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220322105857.1107016-1-robert.marko@sartura.hr>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2022 11:58:56 Robert Marko wrote:
> Partition currently called "uboot" does not only contain U-boot, but
> rather it contains TF-A, U-boot and U-boot environment.
> 
> So, to avoid accidentally deleting the U-boot environment which is
> located at 0x180000 split the partition.
> 
> "uboot" is not the correct name as you can't boot these boards with U-boot
> only, TF-A must be present as well, so rename the "uboot" partition to
> "firmware".
> 
> While we are here, describe the NOR node as "spi-flash@0" instead of
> "m25p80@0" which is the old SPI-NOR driver name.
> 
> This won't break booting for existing devices as the SoC-s BootROM is not
> partition aware at all, it will simply try booting from 0x0 of the
> boot device that is set by bootstrap pins.
> 
> This will however prevent accidental or automated flashing of just U-boot
> to the partition.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
> Changes in v2:
> * Update the commit description by adressing ABI breaking concerns
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> index 95d46e8d081c..ac64949bb53e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> @@ -99,7 +99,7 @@ &spi0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&spi_quad_pins>;
>  
> -	m25p80@0 {
> +	spi-flash@0 {
>  		compatible = "jedec,spi-nor";
>  		reg = <0>;
>  		spi-max-frequency = <54000000>;
> @@ -108,10 +108,15 @@ partitions {
>  			compatible = "fixed-partitions";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			/* only bootloader is located on the SPI */
> +
>  			partition@0 {
> -				label = "uboot";
> -				reg = <0 0x400000>;
> +				label = "firmware";
> +				reg = <0x0 0x180000>;
> +			};
> +
> +			partition@180000 {
> +				label = "u-boot-env";
> +				reg = <0x180000 0x10000>;
>  			};
>  		};
>  	};
> -- 
> 2.35.1
> 
