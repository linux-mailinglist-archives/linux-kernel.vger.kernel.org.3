Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEB351F834
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiEIJdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiEII60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:58:26 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FDF1FB2CD;
        Mon,  9 May 2022 01:54:33 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 49986CA961;
        Mon,  9 May 2022 08:47:29 +0000 (UTC)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1050240007;
        Mon,  9 May 2022 08:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652086045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ivoK15iFFrCyokd4/a45dZRdTsG0bp4wFqdXqPeAM7k=;
        b=L+gPH//MEtnEnPB2S1YMtTVv5CEds3o+9pQNMRNwd3Unh17uEomiSh3BUwXgPTpTUxf0Dt
        49guFFmxTUU+2rqXdBlDOzrVC0g1rpe50N70z04SiHxB/ZREv5OZbGyXxBYeCxNtFEZ0UE
        Cablq2dqsLtAQCwAPcXAsLbVKnVnWIDhMgTPnH0MksYm8/OntgDPUFD7s9UY6qrjPoh1Q6
        nzGM/iIdld711XjfVFIw8O9G4gjHWvm6XFdq1suGGT/D7fFKebNnSm6t+RD452gO/IkHGG
        U0kXhck429GabN3N4WKAtnSEIbvAxOJc3NikFYbSIILE/7aIVmHFOTYon75M2A==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org, marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/2] arm64: dts: uDPU: update partition table
In-Reply-To: <20220322105857.1107016-1-robert.marko@sartura.hr>
References: <20220322105857.1107016-1-robert.marko@sartura.hr>
Date:   Mon, 09 May 2022 10:47:18 +0200
Message-ID: <87mtfrrt2h.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

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
> ---
> Changes in v2:
> * Update the commit description by adressing ABI breaking concerns

Applied on mvebu/dt64

Thanks,

Gregory


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

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
