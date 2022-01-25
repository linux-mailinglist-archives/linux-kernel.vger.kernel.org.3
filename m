Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5DF49BD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiAYUld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:41:33 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60912
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232373AbiAYUlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:41:31 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 370063F1CD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643143285;
        bh=Yy3NTBUu5YQagE6BNwyFYCziy2JOhkYDqX2knyDiSUs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=gT9gxcJFwKcgkJuTWR02W9kte6/ddNiM0AAZFXpT6tcw8vPm3KGIpH1V9iaxFGBc8
         jxE8PKhpqmmbvYUOp5ujIE3aT0cdC3UJ+wzGMJHFAqumLSEJoboiYvBQDQntYD7R8Z
         6CZv4BENATNI/zjRVqbZ9TRXPgllCtKDV+24WQDFeiNmlwvntzDB8qMeIBdZw8vt9v
         QEoWDyFM+ScfBWECJeWbB3+pu6Od467ZBPdSCTRhqPwOOJf8sY8OfOLE4gdQdvSGXt
         wIj0pAr732CDs5U6Rrb7qRAXRJF+3wVh+l74RKAn8AU2p0GrLbPQsitI4GQlNzobo7
         aVTIZpx5eYH0w==
Received: by mail-wr1-f71.google.com with SMTP id g6-20020adfbc86000000b001a2d62be244so3589695wrh.23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yy3NTBUu5YQagE6BNwyFYCziy2JOhkYDqX2knyDiSUs=;
        b=OVZ14fKm8wcB1Jq+kn7ivAk/36gIQd8cfp0i/KEMorECzexffmNa4m44Zm63F1oaez
         RUmgo00mZEn1vUS5R2QWF8BSaWja+59q01lJ7ylhMAzYeu+UkJA19pmrBGejvMyNLqMA
         tHWTr5iaF6Ecn/6YZw5nH57+lnYboa92lgH0OhniNavzj405cYFlDolFiFxXxb1NnzW6
         Gqs9DK/p2ts0rVGnh3XrMUaquA1kIyytRb4uSEO8Qz+EoC3Ogw0ypBYrsbQqr2bjiW5r
         a39x672roIaaEg9kE0ZeZRgscOMxq0G2k9W9nHq+XTu09BjiYuHlBJR4vNAwEYdW7nE0
         AO0w==
X-Gm-Message-State: AOAM5328vXa5Vti/uXp2JmrdBRw9h/qijLk5/Ukn22VuXBhdiDxGrNq1
        YAjJlnCfShWT7v9qEymV6HYzK+r11VQAS+O4UZCsPQQ7qMa3GyUK2PHWS+bqFY5hyjATeEkVQUI
        Twymvj1EgSJ88rn+QIi/6bLYcduqqkeZZ/igpOl5nqg==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr15332503wrm.5.1643143283178;
        Tue, 25 Jan 2022 12:41:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuA/wjad8NSpbLDEgzo574k34xww5VMy2rguii9v6gUtZS5LRWErqFfHbI3VeFfR8ApQYv3A==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr15332492wrm.5.1643143282876;
        Tue, 25 Jan 2022 12:41:22 -0800 (PST)
Received: from [192.168.0.60] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m8sm3158866wrj.29.2022.01.25.12.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:41:22 -0800 (PST)
Message-ID: <2a5ab61e-76ae-390d-7a9f-948d99d0e561@canonical.com>
Date:   Tue, 25 Jan 2022 21:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Adding architectural support for HPE's GXP BMC. This is
 the first of a series of patches to support HPE's BMC with Linux Kernel.
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <nick.hawkins@hpe.com>
 <20220125194609.32314-1-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220125194609.32314-1-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2022 20:46, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 

Thanks for the patches. The commit should come with description. Please
check other commits adding new sub-arch or boards for nice examples.

> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   8 +
>  arch/arm/Kconfig                              |   2 +
>  arch/arm/boot/dts/gxp.dts                     | 700 ++++++++++++++++++

DTS goes separately.

>  arch/arm/configs/gxp_defconfig                | 243 ++++++

Defconfig is separate commit.

>  arch/arm/mach-hpe/Kconfig                     |  20 +
>  arch/arm/mach-hpe/Makefile                    |   1 +
>  arch/arm/mach-hpe/gxp.c                       |  63 ++
>  8 files changed, 1039 insertions(+)
>  create mode 100644 arch/arm/boot/dts/gxp.dts
>  create mode 100644 arch/arm/configs/gxp_defconfig
>  create mode 100644 arch/arm/mach-hpe/Kconfig
>  create mode 100644 arch/arm/mach-hpe/Makefile
>  create mode 100644 arch/arm/mach-hpe/gxp.c
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 294093d45a23..e8b0ec874aed 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -515,6 +515,8 @@ patternProperties:
>      description: Jiangsu HopeRun Software Co., Ltd.
>    "^hp,.*":
>      description: Hewlett Packard

Is Hewlett Packard not an Enterprise?

> +  "^hpe,.*":
> +    description: Hewlett Packard Enterprise

...

>    "^hsg,.*":
>      description: HannStar Display Co.
>    "^holtek,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..007d99734dd1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8382,6 +8382,14 @@ L:	linux-efi@vger.kernel.org
>  S:	Maintained
>  F:	block/partitions/efi.*
>  
> +GXP ARCHITECTURE
> +M:	Jean-Marie Verdun <verdun@hpe.com>
> +M:	Nick Hawkins <nick.hawkins@hpe.com>
> +S:	Maintained
> +F:	arch/arm/boot/dts/gxp.dts
> +F:	arch/arm/configs/gxp_defconfig
> +F:	arch/arm/mach-hpe/gxp.c
> +
>  H8/300 ARCHITECTURE
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  L:	uclinux-h8-devel@lists.sourceforge.jp (moderated for non-subscribers)
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fabe39169b12..d428d0d35889 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -708,6 +708,8 @@ source "arch/arm/mach-vt8500/Kconfig"
>  
>  source "arch/arm/mach-zynq/Kconfig"
>  
> +source "arch/arm/mach-hpe/Kconfig"

All entries in that secion are ordered alphabetically, so mach-hp or
mach-hpe should not stick out.

> +
>  # ARMv7-M architecture
>  config ARCH_LPC18XX
>  	bool "NXP LPC18xx/LPC43xx"
> diff --git a/arch/arm/boot/dts/gxp.dts b/arch/arm/boot/dts/gxp.dts

This needs some better, longer name than just gxp... Look how other
files are named in that directory.

> new file mode 100644
> index 000000000000..7bd814ecaaee
> --- /dev/null
> +++ b/arch/arm/boot/dts/gxp.dts

Where is DTSI? What is this file about? Why there is no description?
What's the purpose?

Where is the dts Makefile change? How do you compile it?

> @@ -0,0 +1,700 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for HPE GXP
> + */
> +
> +/dts-v1/;
> +/ {
> +  #address-cells = <1>;
> +  #size-cells = <1>;
> +	compatible = "HPE,GXP";

Didn't checkpatch complain about undocumented compatible?

If even if it did not, you need to document it. And solve all the issues
like - why uppercase, where is DTSI or SoC compatible... and what is it
exactly?

> +	model = "GXP";

So informative... Model GXP like compatible.

> +
> +	chosen {
> +		bootargs = "earlyprintk console=ttyS0,115200 user_debug=31";

earlyprint is a debugging feature, not suitable for mainline DTS. The
same seems with "user_debug=31". Remove both.

Console should go to chosen stdout-path node instead.

> +	};
> +
> +	aliases {
> +	};

No need for an empty node.

> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x40000000 0x20000000>;
> +	};
> +
> +	ahb@80000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		vic0: vic@ceff0000 {

Node names should be generic, so this is interrupt-controller.

> +			compatible = "arm,pl192-vic";
> +			interrupt-controller;
> +			reg = <0xceff0000 0x1000>;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		vic1: vic@80f00000 {
> +			compatible = "arm,pl192-vic";
> +			interrupt-controller;
> +			reg = <0x80f00000 0x1000>;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		timer0: timer@c0000080 {
> +			compatible = "hpe,gxp-timer";

Undocumented compatible. Also looks too generic.

> +			reg = <0xc0000080 0x1>, <0xc0000094 0x01>, <0xc0000088 0x08>;
> +			interrupts = <0>;
> +			interrupt-parent = <&vic0>;
> +			clock-frequency = <400000000>;
> +		};
> +
> +		watchdog: watchdog@c0000090 {
> +			compatible = "hpe,gxp-wdt";

Undocumented compatible. Also looks too generic.

> +			reg = <0xc0000090 0x02>, <0xc0000096 0x01>;
> +		};
> +
> +		uartc: serial@c00000f0 {
> +			compatible = "ns16550a";
> +			reg = <0xc00000f0 0x8>;
> +			interrupts = <19>;
> +			interrupt-parent = <&vic0>;
> +			clock-frequency = <1846153>;
> +			reg-shift = <0>;
> +		};
> +
> +		uarta: serial@c00000e0 {
> +			compatible = "ns16550a";
> +			reg = <0xc00000e0 0x8>;
> +			interrupts = <17>;
> +			interrupt-parent = <&vic0>;
> +			clock-frequency = <1846153>;
> +			reg-shift = <0>;
> +		};
> +
> +		uartb: serial@c00000e8 {
> +			compatible = "ns16550a";
> +			reg = <0xc00000e8 0x8>;
> +			interrupts = <18>;
> +			interrupt-parent = <&vic0>;
> +			clock-frequency = <1846153>;
> +			reg-shift = <0>;
> +		};
> +
> +		vuart_a_cfg: vuarta_cfg@80fc0230 {
> +			compatible = "hpe,gxp-vuarta_cfg", "simple-mfd", "syscon";
> +			reg = <0x80fc0230 0x100>;
> +			reg-io-width = <1>;
> +		};
> +
> +		vuart_a: vuart_a@80fd0200 {
> +			compatible = "hpe,gxp-vuart";
> +			reg = <0x80fd0200 0x100>;
> +			interrupts = <2>;
> +			interrupt-parent = <&vic1>;
> +			clock-frequency = <1846153>;
> +			reg-shift = <0>;
> +			status = "okay";
> +			serial-line = <3>;
> +			vuart_cfg = <&vuart_a_cfg>;
> +		};
> +
> +		usb0: ehci@cefe0000 {
> +			compatible = "generic-ehci";
> +			reg = <0xcefe0000 0x100>;
> +			interrupts = <7>;
> +			interrupt-parent = <&vic0>;
> +		};
> +
> +		usb1: ohci@cefe0100 {
> +			compatible = "generic-ohci";
> +			reg = <0xcefe0100 0x110>;
> +			interrupts = <6>;
> +			interrupt-parent = <&vic0>;
> +		};
> +
> +		spifi0: spifi@c0000200 {

What is spifi? Maybe "spi"?

> +			compatible = "hpe,gxp-spifi";

Undocumented compatible. Also looks too generic.

> +			reg = <0xc0000200 0x80>, <0xc000c000 0x100>, <0xf8000000 0x8000000>;
> +			interrupts = <20>;
> +			interrupt-parent = <&vic0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			flash@0 {
> +				compatible = "jedec,spi-nor";
> +				reg = <0>;
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					bmc@0 {
> +						label = "bmc";
> +						reg = <0x0 0x2000000>;
> +					};
> +					u-boot@0 {
> +						label = "u-boot";
> +						reg = <0x0 0x60000>;
> +					};
> +					u-boot-env@60000 {
> +						label = "u-boot-env";
> +						reg = <0x60000 0x20000>;
> +					};
> +					kernel@80000 {
> +						label = "kernel";
> +						reg = <0x80000 0x4c0000>;
> +					};
> +					rofs@540000 {
> +						label = "rofs";
> +						reg = <0x540000 0x1740000>;
> +					};
> +					rwfs@1c80000 {
> +						label = "rwfs";
> +						reg = <0x1c80000 0x250000>;
> +					};
> +					section@1edf000{
> +						label = "section";
> +						reg = <0x1ed0000 0x130000>;
> +					};
> +				};
> +			};
> +
> +			flash@1 {
> +				compatible = "jedec,spi-nor";
> +				reg = <1>;
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					host-prime@0 {
> +						label = "host-prime";
> +						reg = <0x0 0x02000000>;
> +					};
> +					host-second@0 {
> +						label = "host-second";
> +						reg = <0x02000000 0x02000000>;
> +					};
> +				};
> +			};
> +		};
> +
> +		sram@d0000000 {
> +			compatible = "mtd-ram";
> +			reg = <0xd0000000 0x80000>;
> +			bank-width = <1>;
> +			erase-size =<1>;
> +			partition@0 {
> +				label = "host-reserved";
> +				reg = <0x0 0x10000>;
> +			};
> +			partition@10000 {
> +				label = "nvram";
> +				reg = <0x10000 0x70000>;
> +			};
> +		};
> +
> +		srom@80fc0000 {
> +			compatible = "hpe,gxp-srom", "simple-mfd", "syscon";
> +			reg = <0x80fc0000 0x100>;
> +		};
> +
> +		vrom@58000000 {
> +			compatible = "mtd-ram";
> +			bank-width = <4>;
> +			reg = <0x58000000 0x4000000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "vrom-prime";
> +				reg = <0x0 0x2000000>;
> +			};
> +			partition@2000000 {
> +				label = "vrom-second";
> +				reg = <0x2000000 0x2000000>;
> +			};
> +		};
> +
> +		i2cg: i2cg@c00000f8 {

What's this exactly?

> +			compatible = "syscon";
> +			reg = <0xc00000f8 0x08>;
> +		};
> +
> +		i2c0: i2c@c0002000 {
> +			compatible = "hpe,gxp-i2c";
> +			reg = <0xc0002000 0x70>;
> +			interrupts = <9>;
> +			interrupt-parent = <&vic0>;
> +			i2cg-handle = <&i2cg>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c1: i2c@c0002100 {
> +			compatible = "hpe,gxp-i2c";
> +			reg = <0xc0002100 0x70>;
> +			interrupts = <9>;
> +			interrupt-parent = <&vic0>;
> +			i2cg-handle = <&i2cg>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c2: i2c@c0002200 {
> +			compatible = "hpe,gxp-i2c";
> +			reg = <0xc0002200 0x70>;
> +			interrupts = <9>;
> +			interrupt-parent = <&vic0>;
> +			i2cg-handle = <&i2cg>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			24c02@50 {
> +				compatible = "atmel,24c02";
> +				pagesize = <8>;
> +				reg = <0x50>;
> +			};
> +		};
> +
> +		i2c3: i2c@c0002300 {
> +			compatible = "hpe,gxp-i2c";
> +			reg = <0xc0002300 0x70>;
> +			interrupts = <9>;
> +			interrupt-parent = <&vic0>;
> +			i2cg-handle = <&i2cg>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c4: i2c@c0002400 {
> +			compatible = "hpe,gxp-i2c";
> +			reg = <0xc0002400 0x70>;
> +			interrupts = <9>;
> +			interrupt-parent = <&vic0>;
> +			i2cg-handle = <&i2cg>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c5: i2c@c0002500 {
> +			compatible = "hpe,gxp-i2c";
> +			reg = <0xc0002500 0x70>;
> +			interrupts = <9>;
> +			interrupt-parent = <&vic0>;
> +			i2cg-handle = <&i2cg>;
> +		};
> +
> +		i2c6: i2c@c0002600 {
> +			compatible = "hpe,gxp-i2c";
> +			reg = <0xc0002600 0x70>;
> +			interrupts = <9>;
> +			interrupt-parent = <&vic0>;
> +			i2cg-handle = <&i2cg>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c7: i2c@c0002700 {
> +			compatible = "hpe,gxp-i2c";
> +			reg = <0xc0002700 0x70>;
> +			interrupts = <9>;
> +			interrupt-parent = <&vic0>;
> +			i2cg-handle = <&i2cg>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			psu1: psu@58 {
> +				compatible = "hpe,gxp-psu";
> +				reg = <0x58>;
> +			};
> +
> +			psu2: psu@59 {
> +				compatible = "hpe,gxp-psu";
> +				reg = <0x59>;
> +			};
> +		};
> +
> +		i2c8: i2c@c0002800 {
> +			compatible = "hpe,gxp-i2c";
> +			reg = <0xc0002800 0x70>;
> +			interrupts = <9>;
> +			interrupt-parent = <&vic0>;
> +			i2cg-handle = <&i2cg>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c9: i2c@c0002900 {
> +			compatible = "hpe,gxp-i2c";
> +			reg = <0xc0002900 0x70>;
> +			interrupts = <9>;
> +			interrupt-parent = <&vic0>;
> +			i2cg-handle = <&i2cg>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2cmux@4 {

Does it even compile with W=1? The unit address looks quite different
than what is below.

Also - node name should be generic.

> +			compatible = "i2c-mux-reg";
> +			i2c-parent = <&i2c4>;
> +			reg = <0xd1000074 1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			i2c4@1 {
> +				reg = <1>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			i2c4@3 {
> +				reg = <3>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			i2c4@4 {
> +				reg = <4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		i2cmux@6 {
> +			compatible = "i2c-mux-reg";
> +			i2c-parent = <&i2c6>;
> +			reg = <0xd1000076 1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			i2c6@1 {
> +				reg = <1>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			i2c6@2 {
> +				reg = <2>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			i2c6@3 {
> +				reg = <3>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			i2c6@4 {
> +				reg = <4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			i2c6@5 {
> +				reg = <5>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		mdio0: mdio@c0004080 {
> +			compatible = "hpe,gxp-umac-mdio";
> +			reg = <0xc0004080 0x10>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ext_phy0: ethernt-phy@0 {
> +				compatible = "ethernet-phy-ieee802.3-c22";
> +				phy-mode = "sgmii";
> +				reg = <0>;
> +			};
> +		};
> +
> +		mdio1: mdio@c0005080 {
> +			compatible = "hpe,gxp-umac-mdio";
> +			reg = <0xc0005080 0x10>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			int_phy0: ethernt-phy@0 {
> +				compatible = "ethernet-phy-ieee802.3-c22";
> +				phy-mode = "gmii";
> +				reg = <0>;
> +			};
> +			int_phy1: ethernt-phy@1 {
> +				compatible = "ethernet-phy-ieee802.3-c22";
> +				phy-mode = "gmii";
> +				reg = <1>;
> +			};
> +		};
> +
> +		umac0: umac@c0004000 {
> +			compatible = "hpe, gxp-umac";

No spaces in compatibles. Previous comments about compatibles also
apply. About node name as well.

I'll stop on DTS now, because it does not look much better below.

> +			reg = <0xc0004000 0x80>;
> +			interrupts = <10>;
> +			interrupt-parent = <&vic0>;
> +			mac-address = [94 18 82 16 04 d8];
> +			phy-handle = <&ext_phy0>;
> +			int-phy-handle = <&int_phy0>;
> +		};
> +

(...)

> diff --git a/arch/arm/configs/gxp_defconfig b/arch/arm/configs/gxp_defconfig
> new file mode 100644
> index 000000000000..f37c6630e06d
> --- /dev/null
> +++ b/arch/arm/configs/gxp_defconfig
> @@ -0,0 +1,243 @@
> +CONFIG_KERNEL_XZ=y
> +CONFIG_DEFAULT_HOSTNAME="gxp"
> +CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BSD_PROCESS_ACCT=y
> +CONFIG_BSD_PROCESS_ACCT_V3=y
> +CONFIG_LOG_BUF_SHIFT=18
> +CONFIG_CFS_BANDWIDTH=y
> +CONFIG_RT_GROUP_SCHED=y
> +CONFIG_CGROUP_FREEZER=y
> +CONFIG_CGROUP_DEVICE=y
> +CONFIG_CGROUP_CPUACCT=y
> +CONFIG_NAMESPACES=y
> +CONFIG_SCHED_AUTOGROUP=y
> +CONFIG_RELAY=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +CONFIG_KALLSYMS_ALL=y
> +CONFIG_EMBEDDED=y
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_SLAB=y
> +CONFIG_ARCH_MULTI_V6=y
> +CONFIG_ARCH_HPE=y
> +CONFIG_ARCH_HPE_GXP=y
> +CONFIG_SECCOMP=y
> +# CONFIG_ATAGS is not set
> +CONFIG_ZBOOT_ROM_TEXT=0x0
> +CONFIG_ZBOOT_ROM_BSS=0x0
> +# CONFIG_SUSPEND is not set
> +CONFIG_JUMP_LABEL=y
> +# CONFIG_STRICT_KERNEL_RWX is not set
> +# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> +CONFIG_KSM=y
> +CONFIG_CLEANCACHE=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_PACKET_DIAG=y
> +CONFIG_UNIX=y
> +CONFIG_UNIX_DIAG=y
> +CONFIG_XFRM_USER=y
> +CONFIG_XFRM_STATISTICS=y
> +CONFIG_INET=y
> +CONFIG_VLAN_8021Q=y
> +CONFIG_NETLINK_DIAG=y
> +CONFIG_NET_NCSI=y
> +# CONFIG_WIRELESS is not set
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +# CONFIG_STANDALONE is not set
> +CONFIG_MTD=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_PHYSMAP=y
> +CONFIG_MTD_PHYSMAP_OF=y
> +CONFIG_MTD_PLATRAM=y
> +CONFIG_MTD_SPI_NOR=y
> +CONFIG_SPI_GXP_SPIFI=y
> +CONFIG_BLK_DEV_NULL_BLK=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_BLK_DEV_NBD=y
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_EEPROM_AT24=y
> +CONFIG_SCSI=y
> +CONFIG_BLK_DEV_SD=y
> +# CONFIG_SCSI_LOWLEVEL is not set
> +CONFIG_NETDEVICES=y
> +# CONFIG_NET_VENDOR_ALACRITECH is not set
> +# CONFIG_NET_VENDOR_AMAZON is not set
> +# CONFIG_NET_VENDOR_AQUANTIA is not set
> +# CONFIG_NET_VENDOR_ARC is not set
> +# CONFIG_NET_VENDOR_AURORA is not set
> +# CONFIG_NET_VENDOR_BROADCOM is not set
> +# CONFIG_NET_VENDOR_CADENCE is not set
> +# CONFIG_NET_VENDOR_CAVIUM is not set
> +# CONFIG_NET_VENDOR_CIRRUS is not set
> +# CONFIG_NET_VENDOR_CORTINA is not set
> +# CONFIG_NET_VENDOR_EZCHIP is not set
> +# CONFIG_NET_VENDOR_FARADAY is not set
> +# CONFIG_NET_VENDOR_GOOGLE is not set
> +# CONFIG_NET_VENDOR_HISILICON is not set
> +# CONFIG_NET_VENDOR_HUAWEI is not set
> +# CONFIG_NET_VENDOR_INTEL is not set
> +# CONFIG_NET_VENDOR_MARVELL is not set
> +# CONFIG_NET_VENDOR_MELLANOX is not set
> +# CONFIG_NET_VENDOR_MICREL is not set
> +# CONFIG_NET_VENDOR_MICROCHIP is not set
> +# CONFIG_NET_VENDOR_MICROSEMI is not set
> +# CONFIG_NET_VENDOR_NATSEMI is not set
> +# CONFIG_NET_VENDOR_NETRONOME is not set
> +# CONFIG_NET_VENDOR_NI is not set
> +# CONFIG_NET_VENDOR_QUALCOMM is not set
> +# CONFIG_NET_VENDOR_RENESAS is not set
> +# CONFIG_NET_VENDOR_ROCKER is not set
> +# CONFIG_NET_VENDOR_SAMSUNG is not set
> +# CONFIG_NET_VENDOR_SEEQ is not set
> +# CONFIG_NET_VENDOR_SOLARFLARE is not set
> +# CONFIG_NET_VENDOR_SMSC is not set
> +# CONFIG_NET_VENDOR_SOCIONEXT is not set
> +# CONFIG_NET_VENDOR_STMICRO is not set
> +# CONFIG_NET_VENDOR_SYNOPSYS is not set
> +# CONFIG_NET_VENDOR_VIA is not set
> +# CONFIG_NET_VENDOR_WIZNET is not set
> +# CONFIG_NET_VENDOR_XILINX is not set
> +CONFIG_UMAC=y
> +# CONFIG_USB_NET_DRIVERS is not set
> +# CONFIG_WLAN is not set
> +# CONFIG_INPUT_LEDS is not set
> +CONFIG_INPUT_EVDEV=y
> +# CONFIG_KEYBOARD_ATKBD is not set
> +CONFIG_KEYBOARD_GPIO=y
> +CONFIG_KEYBOARD_GPIO_POLLED=y
> +# CONFIG_INPUT_MOUSE is not set
> +CONFIG_SERIO_LIBPS2=y
> +CONFIG_VT_HW_CONSOLE_BINDING=y
> +# CONFIG_LEGACY_PTYS is not set
> +CONFIG_SERIAL_8250=y
> +# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_NR_UARTS=6
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=6
> +CONFIG_SERIAL_8250_EXTENDED=y
> +CONFIG_SERIAL_8250_SHARE_IRQ=y
> +CONFIG_SERIAL_8250_GXP_VUART=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_TTY_PRINTK=y
> +CONFIG_IPMI_HANDLER=y
> +CONFIG_IPMI_DEVICE_INTERFACE=y
> +CONFIG_IPMI_SI=y
> +CONFIG_IPMI_SSIF=y
> +CONFIG_HPE_KCS_IPMI_BMC=y
> +CONFIG_HW_RANDOM_TIMERIOMEM=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_GXP=y
> +CONFIG_I2C_SLAVE=y
> +CONFIG_I2C_SLAVE_EEPROM=y
> +CONFIG_SPI=y
> +CONFIG_GPIOLIB=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_GPIO_GXP=y
> +CONFIG_SENSORS_EMC1403=y
> +CONFIG_SENSORS_GXP_FAN_CTRL=y
> +CONFIG_SENSORS_GXP_CORETEMP=y
> +CONFIG_SENSORS_GXP_PSU=y
> +CONFIG_SENSORS_GXP_POWER=y
> +CONFIG_WATCHDOG=y
> +CONFIG_GXP_WATCHDOG=y
> +CONFIG_MFD_SYSCON=y
> +CONFIG_FB=y
> +CONFIG_FB_THUMBNAIL=y
> +CONFIG_FB_SIMPLE=y
> +CONFIG_USB=y
> +CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_ROOT_HUB_TT=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_HCD_PLATFORM=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GXP_UDC=y
> +CONFIG_USB_CONFIGFS=y
> +CONFIG_USB_CONFIGFS_SERIAL=y
> +CONFIG_USB_CONFIGFS_ACM=y
> +CONFIG_USB_CONFIGFS_OBEX=y
> +CONFIG_USB_CONFIGFS_NCM=y
> +CONFIG_USB_CONFIGFS_ECM=y
> +CONFIG_USB_CONFIGFS_ECM_SUBSET=y
> +CONFIG_USB_CONFIGFS_RNDIS=y
> +CONFIG_USB_CONFIGFS_EEM=y
> +CONFIG_USB_CONFIGFS_MASS_STORAGE=y
> +CONFIG_USB_CONFIGFS_F_LB_SS=y
> +CONFIG_USB_CONFIGFS_F_FS=y
> +CONFIG_USB_CONFIGFS_F_HID=y
> +CONFIG_USB_CONFIGFS_F_PRINTER=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
> +CONFIG_LEDS_TRIGGER_ONESHOT=y
> +CONFIG_LEDS_TRIGGER_MTD=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_LEDS_TRIGGER_CPU=y
> +CONFIG_LEDS_TRIGGER_GPIO=y
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> +CONFIG_LEDS_TRIGGER_TRANSIENT=y
> +CONFIG_LEDS_TRIGGER_PANIC=y
> +# CONFIG_VIRTIO_MENU is not set
> +# CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_HPE_GXP_XREG=y
> +CONFIG_HPE_GXP_FN2=y
> +CONFIG_HPE_GXP_CSM=y
> +CONFIG_HPE_GXP_SROM=y
> +CONFIG_FANOTIFY=y
> +CONFIG_OVERLAY_FS=y
> +CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> +CONFIG_TMPFS=y
> +CONFIG_TMPFS_POSIX_ACL=y
> +CONFIG_JFFS2_FS=y
> +# CONFIG_JFFS2_FS_WRITEBUFFER is not set
> +CONFIG_JFFS2_SUMMARY=y
> +CONFIG_JFFS2_FS_XATTR=y
> +# CONFIG_JFFS2_FS_POSIX_ACL is not set
> +# CONFIG_JFFS2_FS_SECURITY is not set
> +CONFIG_SQUASHFS=y
> +CONFIG_SQUASHFS_XZ=y
> +CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> +# CONFIG_NETWORK_FILESYSTEMS is not set
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_ASCII=y
> +CONFIG_NLS_ISO8859_1=y
> +CONFIG_NLS_UTF8=y
> +CONFIG_CRYPTO_CCM=y
> +CONFIG_CRYPTO_GCM=y
> +CONFIG_CRYPTO_CRC32C=y
> +CONFIG_CRYPTO_ARC4=y
> +CONFIG_CRYPTO_DEFLATE=y
> +CONFIG_CRYPTO_LZO=y
> +CONFIG_CRYPTO_ZSTD=y
> +CONFIG_CRYPTO_USER_API_HASH=y
> +# CONFIG_CRYPTO_HW is not set
> +CONFIG_CRC16=y
> +# CONFIG_XZ_DEC_ARM is not set
> +# CONFIG_XZ_DEC_ARMTHUMB is not set
> +CONFIG_DMA_API_DEBUG=y
> +CONFIG_PRINTK_TIME=y
> +CONFIG_BOOT_PRINTK_DELAY=y
> +CONFIG_DYNAMIC_DEBUG=y
> +CONFIG_DEBUG_INFO=y
> +# CONFIG_ENABLE_MUST_CHECK is not set
> +CONFIG_MAGIC_SYSRQ=y
> +CONFIG_PANIC_ON_OOPS=y
> +CONFIG_FUNCTION_PROFILER=y
> +CONFIG_STACK_TRACER=y
> +CONFIG_SCHED_TRACER=y
> +CONFIG_STRICT_DEVMEM=y
> +CONFIG_DEBUG_USER=y
> +CONFIG_DEBUG_LL=y
> +CONFIG_DEBUG_LL_UART_8250=y
> +CONFIG_DEBUG_UART_PHYS=0xC00000F0
> +CONFIG_DEBUG_UART_VIRT=0xF00000F0
> +CONFIG_DEBUG_UART_8250_SHIFT=0
> +CONFIG_EARLY_PRINTK=y
> +CONFIG_TEST_KSTRTOX=y
> diff --git a/arch/arm/mach-hpe/Kconfig b/arch/arm/mach-hpe/Kconfig
> new file mode 100644
> index 000000000000..9b27f97c6536
> --- /dev/null
> +++ b/arch/arm/mach-hpe/Kconfig
> @@ -0,0 +1,20 @@
> +menuconfig ARCH_HPE
> +	bool "HPE SoC support"
> +	help
> +	  This enables support for HPE ARM based SoC chips
> +if ARCH_HPE
> +
> +config ARCH_HPE_GXP
> +	bool "HPE GXP SoC"
> +	select ARM_VIC
> +	select PINCTRL
> +	select IRQ_DOMAIN
> +	select GENERIC_IRQ_CHIP
> +	select MULTI_IRQ_HANDLER
> +	select SPARSE_IRQ
> +	select CLKSRC_MMIO
> +	depends on ARCH_MULTI_V7
> +	help
> +	  Support for GXP SoCs
> +
> +endif
> diff --git a/arch/arm/mach-hpe/Makefile b/arch/arm/mach-hpe/Makefile
> new file mode 100644
> index 000000000000..8b0a91234df4
> --- /dev/null
> +++ b/arch/arm/mach-hpe/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ARCH_HPE_GXP) += gxp.o
> diff --git a/arch/arm/mach-hpe/gxp.c b/arch/arm/mach-hpe/gxp.c
> new file mode 100644
> index 000000000000..b58f25fbae5a
> --- /dev/null
> +++ b/arch/arm/mach-hpe/gxp.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P.
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +
> +#include <linux/init.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clocksource.h>
> +
> +#define IOP_REGS_PHYS_BASE 0xc0000000
> +#define IOP_REGS_VIRT_BASE 0xf0000000
> +#define IOP_REGS_SIZE (240*SZ_1M)
> +
> +#define IOP_EHCI_USBCMD 0x0efe0010
> +
> +static struct map_desc gxp_io_desc[] __initdata = {
> +	{
> +	.virtual	= (unsigned long)IOP_REGS_VIRT_BASE,
> +	.pfn		= __phys_to_pfn(IOP_REGS_PHYS_BASE),
> +	.length		= IOP_REGS_SIZE,
> +	.type		= MT_DEVICE,
> +	},
> +};
> +
> +void __init gxp_map_io(void)
> +{
> +	iotable_init(gxp_io_desc, ARRAY_SIZE(gxp_io_desc));
> +}
> +
> +static void __init gxp_dt_init(void)
> +{
> +	//reset EHCI host controller for clear start

Linux style comments please, so /*.

> +	__raw_writel(0x00080002,

What is this magic value?

> +		(void __iomem *)(IOP_REGS_VIRT_BASE + IOP_EHCI_USBCMD));

Why do you need the cast?

> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static void gxp_restart(enum reboot_mode mode, const char *cmd)
> +{
> +	pr_info("gpx restart");

Skip it.

> +	__raw_writel(1, (void __iomem *) IOP_REGS_VIRT_BASE);
> +}
> +
> +static const char * const gxp_board_dt_compat[] = {
> +	"HPE,GXP",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(GXP_DT, "HPE GXP")
> +	.init_machine	= gxp_dt_init,
> +	.map_io		= gxp_map_io,
> +	.restart	= gxp_restart,
> +	.dt_compat	= gxp_board_dt_compat,
> +MACHINE_END


Best regards,
Krzysztof
