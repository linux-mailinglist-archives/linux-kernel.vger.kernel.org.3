Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CAF56A88F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiGGQsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbiGGQsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:48:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81C554D4C7;
        Thu,  7 Jul 2022 09:48:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D9491063;
        Thu,  7 Jul 2022 09:48:06 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99803F792;
        Thu,  7 Jul 2022 09:48:04 -0700 (PDT)
Date:   Thu, 7 Jul 2022 17:48:01 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-sunxi@lists.linux.dev, Icenowy Zheng <icenowy@aosc.xyz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunxi: dts: Fix SPI NOR campatible on Orange Pi Zero
Message-ID: <20220707174801.36e010da@donnerap.cambridge.arm.com>
In-Reply-To: <20220707163855.18838-1-msuchanek@suse.de>
References: <20220707163855.18838-1-msuchanek@suse.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Jul 2022 18:38:55 +0200
Michal Suchanek <msuchanek@suse.de> wrote:

Hi,

> Without "jedec,spi-nor" compatible the flash memory cannot be probed by
> u-boot.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> index f19ed981da9d..d114bbc5f441 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> @@ -169,7 +169,7 @@ &spi0 {
>  	flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
> +		compatible = "mxicy,mx25l1606e", "winbond,w25q128", "jedec,spi-nor";

Naming three compatible strings violates the binding:
arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dtb: flash@0: compatible: 'oneOf' conditional failed, one must be fixed:
        ['mxicy,mx25l1606e', 'winbond,w25q128', 'jedec,spi-nor'] is too long
        'mxicy,mx25l1606e' is not one of ['issi,is25lp016d', 'micron,mt25qu02g', 'mxicy,mx25r1635f', 'mxicy,mx25u6435f', 'mxicy,mx25v8035f', 'spansion,s25sl12801', 'spansion,s25fs512s']
        'jedec,spi-nor' was expected
        From schema: Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

Not entirely sure why it didn't scream before, actually, because to me it
looks like ending in jedec,spi-nor is mandatory.
Anyway, IIUC the Macronix chip was the one shipped with the (later)
boards, so we should use just that and "jedec,spi-nor".
The actual vendor would be detected at runtime anyway.

Cheers,
Andre

>  		reg = <0>;
>  		spi-max-frequency = <40000000>;
>  	};

