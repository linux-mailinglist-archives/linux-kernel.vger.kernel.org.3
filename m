Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91B4ADEE5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383691AbiBHRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbiBHRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:05:56 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60D2C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:05:55 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 57F633F1E6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644339954;
        bh=GVwuLaFwT1ptuWPum5aqWFrUhPhVh7ci6UD8FlgdXuk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=WuxLF1nW2lOnRIvgmYiScjjGl4Ii9GC5b+x1kqpiVfi6DIV6UTHP9icHffIDY8IGp
         S65eFz8bQjt5spMqNQZnmW/xxwczTAnheUwW46UYXKUhSNJpvuzYUprjg6Z0yRNT6f
         iFR6K6tb9ED7w0wYpZyBCq6ne1Ex2HcK3Nz5RbuTUJP76o8v/WJEAnNQHmYq7urkQq
         N2qtUKKsmRlLPsv5bHo++hoYHorAd7PZ3EJsR/iX0D5dL0cF9nueapJ6ErND25KGBw
         GjuYb6n9iUikLdvntZgiEwHfCdY8mlPdylLYFyN+seFrssEtU0YW+DNpbHZOvhk82c
         nJ8lTb6Q0rhHA==
Received: by mail-ed1-f69.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso6306696edh.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GVwuLaFwT1ptuWPum5aqWFrUhPhVh7ci6UD8FlgdXuk=;
        b=m09CQj7x4ePDA7mYkXm/+O1f0DbGJdZCoTExcLYRvGNuvqacNNdE8SvD1hlLSl1ioX
         NcwES65Ws91pkZodBd1eqhEJi59ifCd/17re83MsJh5g+7p9FaH0eykYUzA+B4HQWT2n
         5MGsQLnbKY4HJgvqG0kjuK/mAxgY9uEWg7Raa8UtcvdXoEmFjJzd3zjjR+EcF/kVFVtc
         9oTNxE5K4N8hO/1abzobgLBELL4eGpjfiC1poDem5Hf8kCh3xXqayiTJQfMtQABV4Q35
         JIoFg08S4VkOo/Xvss0baIFOwWPd07U9U0lJdsc6vX2K5KaqogTK2kt8X+rmjgPgRsC8
         Xi1Q==
X-Gm-Message-State: AOAM532WmKpkwkFk1RykmaC6ZcruYdngoovUC3DtxjlTy3Jonu0KrF1R
        8HwhkYopjtsiWOr+5xU3v16751rX48cZDIjcBW8q+2Y0PVEMYloI3jlxo2b48vbvSpgEjciga0z
        5LbF/WQ1b+Sf7oGiOQoWBoQak8cy94k4w2VWWSdZvwQ==
X-Received: by 2002:a05:6402:5cf:: with SMTP id n15mr1481720edx.245.1644339953272;
        Tue, 08 Feb 2022 09:05:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx4DQmL0xf2Z7BOlyNewtYCRcfWCTsXGsac6rQ1Xow4hTNfl1p/n4zkfxO5eycxsvmtQJyew==
X-Received: by 2002:a05:6402:5cf:: with SMTP id n15mr1481693edx.245.1644339953043;
        Tue, 08 Feb 2022 09:05:53 -0800 (PST)
Received: from [192.168.0.94] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i22sm3066468ejx.128.2022.02.08.09.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 09:05:51 -0800 (PST)
Message-ID: <3221dd42-7a14-7ac6-0b61-634a77a45753@canonical.com>
Date:   Tue, 8 Feb 2022 18:05:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] arm64: dts: ti: Introduce base support for AM62x SoC
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-5-vigneshr@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220208131827.1430086-5-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
> The AM62 SoC family is the follow on AM335x built on K3 Multicore SoC
> architecture platform, providing ultra-low-power modes, dual display,
> multi-sensor edge compute, security and other BOM-saving integration.
> The AM62 SoC targets broad market to enable applications such as
> Industrial HMI, PLC/CNC/Robot control, Medical Equipment, Building
> Automation, Appliances and more.
> 
> Some highlights of this SoC are:
> 
> * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>   Pin-to-pin compatible options for single and quad core are available.
> * Cortex-M4F for general-purpose or safety usage.
> * Dual display support, providing 24-bit RBG parallel interface and
>   OLDI/LVDS-4 Lane x2, up to 200MHz pixel clock support for 2K display
>   resolution.
> * Selectable GPUsupport, up to 8GFLOPS, providing better user experience
>   in 3D graphic display case and Android.
> * PRU(Programmable Realtime Unit) support for customized programmable
>   interfaces/IOs.
> * Integrated Giga-bit Ethernet switch supporting up to a total of two
>   external ports (TSN capable).
> * 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, GPMC for
>   NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
>   1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
> * Dedicated Centralized System Controller for Security, Power, and
>   Resource Management.
> * Multiple low power modes support, ex: Deep sleep,Standby, MCU-only,
>   enabling battery powered system design.
> 
> This add bare minimum DT describing ARM compute clusters, Main, MCU and
> Wakeup domain and interconnects, UARTs and I2Cs to enable booting using
> ramdisk.
> 
> More details can be found in the Technical Reference Manual:
> https://www.ti.com/lit/pdf/spruiv7
> 
> Co-developed-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Co-developed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 263 +++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  36 +++
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi |  41 ++++
>  arch/arm64/boot/dts/ti/k3-am62.dtsi        | 104 ++++++++
>  arch/arm64/boot/dts/ti/k3-am625.dtsi       | 103 ++++++++
>  5 files changed, 547 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625.dtsi
> 

(...)

> diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> new file mode 100644
> index 000000000000..f1a46be27c37
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for AM62 SoC Family
> + *
> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pinctrl/k3.h>
> +#include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +/ {
> +	model = "Texas Instruments K3 AM625 SoC";
> +	compatible = "ti,am625";

This is am625, but the file is am62. Why having the split?

> +	interrupt-parent = <&gic500>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +
> +		psci: psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +		};
> +	};
> +
> +	a53_timer0: timer-cl0-cpu0 {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
> +	};
> +
> +	pmu: pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	cbass_main: bus@f0000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x00 0x000f0000 0x00 0x000f0000 0x00 0x00030000>, /* Main MMRs */
> +			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
> +			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
> +			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
> +			 <0x00 0x0070C000 0x00 0x0070C000 0x00 0x00000200>, /* USB1 debug trace */
> +			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
> +			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
> +			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
> +			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
> +			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
> +			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
> +			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
> +			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
> +			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
> +			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* sa3 sproxy data */
> +			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
> +			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* sa3 sproxy config */
> +			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
> +			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
> +			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
> +			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
> +			 <0x00 0x31100000 0x00 0x31100000 0x00 0x00050000>, /* USB1 DWC3 Core window */
> +			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
> +
> +			 /* MCU Domain Range */
> +			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
> +
> +			 /* Wakeup Domain Range */
> +			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
> +			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
> +
> +		cbass_mcu: bus@4000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>; /* Peripheral window */
> +		};
> +
> +		cbass_wakeup: bus@2b000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
> +				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
> +		};
> +	};
> +};
> +
> +/* Now include the peripherals for each bus segments */
> +#include "k3-am62-main.dtsi"
> +#include "k3-am62-mcu.dtsi"
> +#include "k3-am62-wakeup.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> new file mode 100644
> index 000000000000..887f31c23fef
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for AM625 SoC family in Quad core configuration
> + *
> + * TRM: https://www.ti.com/lit/pdf/spruiv7
> + *
> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am62.dtsi"
> +
> +/ {
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +

This file is not included anywhere, so does it mean that your SoC comes
without the cores and each board designer plugs the cores separately?


Best regards,
Krzysztof
