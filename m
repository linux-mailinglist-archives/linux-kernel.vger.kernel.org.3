Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE49A4ADEF5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383728AbiBHRJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbiBHRJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:09:10 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99296C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:09:09 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 80BF43F1E9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644340148;
        bh=YH0zMlFVq6OBGsp7byUNxL8VwC9u6t6pNgeSdsv9WD0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Wzu0zK0uoFuSK1YMORfE4sFdW/b9eSi5YlbyMdrYZpCZQBU00JIz3dSCvbjplo87x
         ymZoNM7fWTGAdQhwrrPYq13gPcQWmRBay7xyrTRcJUxSDbDbBsTNds2UB7rvHYeQBD
         AORq6Gt3QmXqZTz80+OJxqWaGtNilmEnKjc5iHy1BVpKs/smCQB2M/UdMBIMZxGt2x
         rVwYMr1fyxvp2bd+A1Zk8wD522r+2xroQOGDsj0HNiQAQoI1bLVFyv6jdKOxJrt1nD
         oV1URvpqfo8bppl/9AZ/xa9uB3DGAGKyaMQHZt4Uo0uENeSWl5R9yQopoXH0JT3Wyu
         PbCUNuhiqiUeA==
Received: by mail-ed1-f69.google.com with SMTP id b26-20020a056402139a00b004094fddbbdfso10080671edv.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YH0zMlFVq6OBGsp7byUNxL8VwC9u6t6pNgeSdsv9WD0=;
        b=0lQvXI1Gm0Si3VPyQ9DUtiXhl6BQJH54XVgsQ58az8HIn6ZiLDVCBLLGlTu6brTyeU
         G4KKmhWTMr5TN0oJ4mFeQrnTQ0qQYXAd5lPC48XOWv+/wi67nRljcmy9/AF6tBzfibDb
         o5JJn6UjKpPtJygQhwVgI3ama1N++e+hSienBAuF10xscR2Ibbld8IfmDixUXiXxs8CN
         SQ8mMCVje7Lbm57rW1x5664uy8jj5F0ToZ6chbyCT9SYkmNsGfhYFVbIFM6tRdJYVEWh
         eNJzlYLNmFqfbd3pPGOkQzSonH2N0pOUT2WDWabF+uwpIC1Gj1/XnUWXdMmh8FCzqivf
         yniw==
X-Gm-Message-State: AOAM533r0suJSSACAGZ4aTlp3SWtkDs58wBjCB4Qs81BMrhMgySXBNP2
        rldbbKBlXdKDcjKDzKFxSUgddMn7egRBwNo08+MAqgPzlQTZwknZjBK6DyNmgHQtXVrbGsLTSJX
        6ZK6VXdithYlJTnT8/SfcfKYFsLeg138f+x3l/pzTFw==
X-Received: by 2002:a17:906:9741:: with SMTP id o1mr4659080ejy.452.1644340144995;
        Tue, 08 Feb 2022 09:09:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW2zQG2untp/j+hnbH88My2yeMbqKaWDko/Kl+pDLKhQ6yZNVbEKgHb+lXWBbrGygU5uOU1A==
X-Received: by 2002:a17:906:9741:: with SMTP id o1mr4658859ejy.452.1644340141434;
        Tue, 08 Feb 2022 09:09:01 -0800 (PST)
Received: from [192.168.0.94] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id d10sm2527387ejb.22.2022.02.08.09.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 09:09:00 -0800 (PST)
Message-ID: <65bfa443-5117-9e69-8b6e-0c40099bd149@canonical.com>
Date:   Tue, 8 Feb 2022 18:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/5] arm64: dts: ti: Add support for AM62-SK
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-6-vigneshr@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220208131827.1430086-6-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 14:18, Vignesh Raghavendra wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> AM62 StarterKit (SK) board is a low cost, small form factor board
> designed for TI’s AM625 SoC. It supports the following interfaces:
> * 2 GB DDR4 RAM
> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
> * x1 HDMI Port with audio + x1 OLDI/LVDS Display interface for Dual Display
> * x1 Headphone Jack
> * x1 USB2.0 Hub with two Type A host and x1 USB Type-C DRP Port
> * x1 UHS-1 capable µSD card slot
> * 2.4/5 GHz WLAN + Bluetooth 4.2 through WL1837
> * 512 Mbit OSPI flash
> * x4 UART through UART-USB bridge
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> * 40-pin User Expansion Connector
> * 24-pin header for peripherals in MCU island (I2C, UART, SPI, IO)
> * 20-pin header for Programmable Realtime Unit (PRU) IO pins
> * 15-pin CSI header
> 
> Add basic support for AM62-SK.
> 
> Schematics: https://www.ti.com/lit/zip/sprr448
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile        |   2 +
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 206 +++++++++++++++++++++++++
>  2 files changed, 208 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-sk.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 90be511bc4d0..02e5d80344d0 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -21,3 +21,5 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
> +
> +dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> new file mode 100644
> index 000000000000..9a6ff601f44d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AM625 SK: https://www.ti.com/lit/zip/sprr448
> + *
> + * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-am625.dtsi"
> +
> +/ {
> +	compatible =  "ti,am625-sk", "ti,am625";
> +	model = "Texas Instruments AM625 SK";
> +
> +	aliases {
> +		serial2 = &main_uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 2G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> +
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_tfa_ddr: tfa@9e780000 {
> +			reg = <0x00 0x9e780000 0x00 0x80000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0000000 0x00 0x200000>;
> +			no-map;
> +		};
> +	};
> +
> +	vmain_pd: fixed-regulator-vmain-pd {
> +		/* TPS65988 PD CONTROLLER OUTPUT */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmain_pd";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc_5v0: fixedregulator-vcc5v0 {
> +		/* Output of LM34936 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vmain_pd>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc_3v3_sys: fixedregulator-vcc-3v3-sys {

Generic node names (as in DT spec), so regulator-[0-9]. The label and
regulator-name property describe it's user-friendly purpose.

> +		/* output of LM61460-Q1 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3_sys";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vmain_pd>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usr_led_pins_default>;
> +
> +		led-0 {

Best regards,
Krzysztof
