Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAD94E27E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348012AbiCUNm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347988AbiCUNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE98C7306A;
        Mon, 21 Mar 2022 06:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01CC61240;
        Mon, 21 Mar 2022 13:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEDDC340E8;
        Mon, 21 Mar 2022 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647870058;
        bh=Tta+gf+lXM/5A76YW4BpjuBuyFt4HrFGmdEfOCer/ZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTFgDUVOAkqeq+MZLODh7VZJB6faVsBs7zC2CzrHiKJ+WjDoJFDMW61NSu0Rhkp03
         2tekrg1np6R9SuP0hq3wRC5EXjau3a+F/M+G7i40UFXYsh2LeYHxTM4dKfL8rk/3JF
         fy/42Pxzd6M8Fo3Uk4J4h43mmiha4oBOmERpJTJBq5/pyctMVQTV7DvXbpiRy8XfRe
         AAdAPFJbrJwjQLFXI/Jw5znjsKapqEyu9oGndZGVfsYF5J4M/YERv1jz5A0Tc6nVlW
         0M/8WC+A7Doz8qHUvbgvPnq1QKbAl1u95ZTjSgFqwx7M+jkig624WjIsoR4Ri/p0I0
         k5tP5hbvSH4Vg==
Received: by pali.im (Postfix)
        id 2BE61A5B; Mon, 21 Mar 2022 14:40:55 +0100 (CET)
Date:   Mon, 21 Mar 2022 14:40:55 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marek.behun@nic.cz
Subject: Re: [PATCH 1/2] arm64: dts: uDPU: update partition table
Message-ID: <20220321134055.o3uz5al5np7fj273@pali>
References: <20220321121728.414839-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321121728.414839-1-robert.marko@sartura.hr>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2022 13:17:27 Robert Marko wrote:
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
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

FYI, U-Boot now contains copy of kernel's A3720 DTS files, so you should
send same patch also to U-Boot project.

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
