Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15841549FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351198AbiFMUrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbiFMUqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:46:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A176DF66
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gd1so6594043pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VXJlE60TzLimhLd0tty5b77lTGeJKh95VUak2wi/XUs=;
        b=kJ/ii4vt0i1PlUZnRuxuIbTopuOA6qa1kPMQkaaNSw6tHmADzY3d9Xcp+QHdBfWdvv
         wlzOWbRZ0d5ax1glSh1rNg87HTO4PEzLWy1FpDdrfNtFDAWKYqsnfwzPGb5zUKADw/DU
         8t+IiihnEh7fN3qidCCppubFYHQ76N5fPGYoTqAo/MnBi1BP8vJdj4z19PszdEYCfj8K
         dJ1eiA/693YKj3+FsLYUzdikQw6ZpupAY0PDhxobrQVraw+4BxWuihnZwVFYTorMtl1+
         Gy53/SyV2SyzAtE8At/6J8epCxDI8iC9v0dmViKXcw40Zw44+XQgqAo3RV9e3QLezLWS
         kErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VXJlE60TzLimhLd0tty5b77lTGeJKh95VUak2wi/XUs=;
        b=Pf/G3vFECU/HTeAgQ42vLeEPCBYt56mgKff9uRJo2i5+kcJcgG0dpc0QGOxmJN67CE
         LKe/vtTXU1FTAD2eUMVWf1kQQ6UhQ2CH6bo9xRVf5YcOix6/D0xeNEYNee7qqNEMwD1w
         FDgxlVlZPsIPrlH/Z034lAU5PYLZh61HUBlBdJ7ehB1ZKIIvEzKLzxmxI6jjI1fqJ4Ii
         HybLSEEqhC+HUv6h+D59/1y/amEfIGrme5LVXl758xEYoPcNBwMZ0OaEOYvfI1x48ON6
         tkajFGV4aLUK6u5qOY/JJ2WcAHOp0qEZ77H5jMW20ANnm5O99v5z9MLDWhyzbwy3xbIO
         B+CQ==
X-Gm-Message-State: AJIora/eZf5g2X47UyOsk5Uf0/S9/GCnPwe1COrTDoKUrcFdLFIaM4l5
        DK3zIBRMweb1KHR8PP43RuwNYg==
X-Google-Smtp-Source: AGRyM1vWzTcTfsDd3FUtm2X7cnh++7uLWXt1vnagtQkS1evXyeHkVS2PXMEznsn7tpK0KWpGZ+WXxg==
X-Received: by 2002:a17:90b:1b05:b0:1e2:a053:2fad with SMTP id nu5-20020a17090b1b0500b001e2a0532fadmr378048pjb.209.1655150263687;
        Mon, 13 Jun 2022 12:57:43 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:43 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 10/15] arm64: dts: Add AMD Pensando Elba SoC support
Date:   Mon, 13 Jun 2022 12:56:53 -0700
Message-Id: <20220613195658.5607-11-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add AMD Pensando common and Elba SoC specific device nodes

Signed-off-by: Brad Larson <blarson@amd.com>
---
 arch/arm64/boot/dts/amd/Makefile              |   1 +
 arch/arm64/boot/dts/amd/elba-16core.dtsi      | 189 +++++++++++++++++
 arch/arm64/boot/dts/amd/elba-asic-common.dtsi | 103 ++++++++++
 arch/arm64/boot/dts/amd/elba-asic.dts         |  28 +++
 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 106 ++++++++++
 arch/arm64/boot/dts/amd/elba.dtsi             | 191 ++++++++++++++++++
 6 files changed, 618 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
 create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi

diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
index 68103a8b0ef5..9bba020fa880 100644
--- a/arch/arm64/boot/dts/amd/Makefile
+++ b/arch/arm64/boot/dts/amd/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb
+dtb-$(CONFIG_ARCH_PENSANDO) += elba-asic.dtb
diff --git a/arch/arm64/boot/dts/amd/elba-16core.dtsi b/arch/arm64/boot/dts/amd/elba-16core.dtsi
new file mode 100644
index 000000000000..274dd80de1a4
--- /dev/null
+++ b/arch/arm64/boot/dts/amd/elba-16core.dtsi
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020-2022 AMD Pensando
+ */
+
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 { cpu = <&cpu0>; };
+				core1 { cpu = <&cpu1>; };
+				core2 { cpu = <&cpu2>; };
+				core3 { cpu = <&cpu3>; };
+			};
+
+			cluster1 {
+				core0 { cpu = <&cpu4>; };
+				core1 { cpu = <&cpu5>; };
+				core2 { cpu = <&cpu6>; };
+				core3 { cpu = <&cpu7>; };
+			};
+
+			cluster2 {
+				core0 { cpu = <&cpu8>; };
+				core1 { cpu = <&cpu9>; };
+				core2 { cpu = <&cpu10>; };
+				core3 { cpu = <&cpu11>; };
+			};
+
+			cluster3 {
+				core0 { cpu = <&cpu12>; };
+				core1 { cpu = <&cpu13>; };
+				core2 { cpu = <&cpu14>; };
+				core3 { cpu = <&cpu15>; };
+			};
+		};
+
+		/* CLUSTER 0 */
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x0>;
+			next-level-cache = <&l2_0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x1>;
+			next-level-cache = <&l2_0>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x2>;
+			next-level-cache = <&l2_0>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x3>;
+			next-level-cache = <&l2_0>;
+			enable-method = "psci";
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+		};
+
+		/* CLUSTER 1 */
+		cpu4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x100>;
+			next-level-cache = <&l2_1>;
+			enable-method = "psci";
+		};
+
+		cpu5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x101>;
+			next-level-cache = <&l2_1>;
+			enable-method = "psci";
+		};
+
+		cpu6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x102>;
+			next-level-cache = <&l2_1>;
+			enable-method = "psci";
+		};
+
+		cpu7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x103>;
+			next-level-cache = <&l2_1>;
+			enable-method = "psci";
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+		};
+
+		/* CLUSTER 2 */
+		cpu8: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x200>;
+			next-level-cache = <&l2_2>;
+			enable-method = "psci";
+		};
+
+		cpu9: cpu@201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x201>;
+			next-level-cache = <&l2_2>;
+			enable-method = "psci";
+		};
+
+		cpu10: cpu@202 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x202>;
+			next-level-cache = <&l2_2>;
+			enable-method = "psci";
+		};
+
+		cpu11: cpu@203 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x203>;
+			next-level-cache = <&l2_2>;
+			enable-method = "psci";
+		};
+
+		l2_2: l2-cache2 {
+			compatible = "cache";
+		};
+
+		/* CLUSTER 3 */
+		cpu12: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x300>;
+			next-level-cache = <&l2_3>;
+			enable-method = "psci";
+		};
+
+		cpu13: cpu@301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x301>;
+			next-level-cache = <&l2_3>;
+			enable-method = "psci";
+		};
+
+		cpu14: cpu@302 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x302>;
+			next-level-cache = <&l2_3>;
+			enable-method = "psci";
+		};
+
+		cpu15: cpu@303 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x303>;
+			next-level-cache = <&l2_3>;
+			enable-method = "psci";
+		};
+
+		l2_3: l2-cache3 {
+			compatible = "cache";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/amd/elba-asic-common.dtsi b/arch/arm64/boot/dts/amd/elba-asic-common.dtsi
new file mode 100644
index 000000000000..155d35b8459f
--- /dev/null
+++ b/arch/arm64/boot/dts/amd/elba-asic-common.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020-2022, AMD Pensando
+ */
+
+#include <dt-bindings/reset/amd,pensando-elba-reset.h>
+
+&ahb_clk {
+	clock-frequency = <400000000>;
+};
+
+&emmc_clk {
+	clock-frequency = <200000000>;
+};
+
+&flash_clk {
+	clock-frequency = <400000000>;
+};
+
+&ref_clk {
+	clock-frequency = <156250000>;
+};
+
+&qspi {
+	status = "okay";
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+		spi-rx-bus-width = <2>;
+		m25p,fast-read;
+		cdns,read-delay = <0>;
+		cdns,tshsl-ns = <0>;
+		cdns,tsd2d-ns = <0>;
+		cdns,tchsh-ns = <0>;
+		cdns,tslch-ns = <0>;
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-hw-reset;
+	reset-names = "hw";
+	resets = <&rstc EMMC_HW_RESET>;
+	status = "okay";
+};
+
+&wdt0 {
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	status = "okay";
+	rtc@51 {
+		compatible = "nxp,pcf85263";
+		reg = <0x51>;
+	};
+};
+
+&spi0 {
+	num-cs = <4>;
+	cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
+		   <&porta 7 GPIO_ACTIVE_LOW>;
+	status = "okay";
+	spi@0 {
+		compatible = "amd,pensando-elbasr", "simple-mfd";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		spi-max-frequency = <12000000>;
+
+		rstc: reset-controller@0 {
+			compatible = "amd,pensando-elbasr-reset";
+			reg = <0>;
+			#reset-cells = <1>;
+		};
+	};
+
+	spi@1 {
+		compatible = "amd,pensando-elbasr", "simple-mfd";
+		reg = <1>;
+		spi-max-frequency = <12000000>;
+	};
+
+	spi@2 {
+		compatible = "amd,pensando-elbasr", "simple-mfd";
+		reg = <2>;
+		spi-max-frequency = <12000000>;
+		interrupt-parent = <&porta>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	spi@3 {
+		compatible = "amd,pensando-elbasr", "simple-mfd";
+		reg = <3>;
+		spi-max-frequency = <12000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/amd/elba-asic.dts b/arch/arm64/boot/dts/amd/elba-asic.dts
new file mode 100644
index 000000000000..bb64fd042b63
--- /dev/null
+++ b/arch/arm64/boot/dts/amd/elba-asic.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for AMD Pensando Elba Board.
+ *
+ * Copyright (c) 2020-2022 AMD Pensando
+ */
+
+/dts-v1/;
+
+#include "elba.dtsi"
+#include "elba-16core.dtsi"
+#include "elba-asic-common.dtsi"
+#include "elba-flash-parts.dtsi"
+
+/ {
+	model = "AMD Pensando Elba Board";
+	compatible = "amd,pensando-elba-ortano", "amd,pensando-elba";
+
+	aliases {
+		serial0 = &uart0;
+		spi0 = &spi0;
+		spi1 = &qspi;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
diff --git a/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi b/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
new file mode 100644
index 000000000000..2599d1b22026
--- /dev/null
+++ b/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020-2022 AMD Pensando
+ */
+
+&flash0 {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "flash";
+			reg = <0x10000 0xfff0000>;
+		};
+
+		partition@f0000 {
+			label = "golduenv";
+			reg = <0xf0000 0x10000>;
+		};
+
+		partition@100000 {
+			label = "boot0";
+			reg = <0x100000 0x80000>;
+		};
+
+		partition@180000 {
+			label = "golduboot";
+			reg = <0x180000 0x200000>;
+		};
+
+		partition@380000 {
+			label = "brdcfg0";
+			reg = <0x380000 0x10000>;
+		};
+
+		partition@390000 {
+			label = "brdcfg1";
+			reg = <0x390000 0x10000>;
+		};
+
+		partition@400000 {
+			label = "goldfw";
+			reg = <0x400000 0x3c00000>;
+		};
+
+		partition@4010000 {
+			label = "fwmap";
+			reg = <0x4010000 0x20000>;
+		};
+
+		partition@4030000 {
+			label = "fwsel";
+			reg = <0x4030000 0x20000>;
+		};
+
+		partition@4090000 {
+			label = "bootlog";
+			reg = <0x4090000 0x20000>;
+		};
+
+		partition@40b0000 {
+			label = "panicbuf";
+			reg = <0x40b0000 0x20000>;
+		};
+
+		partition@40d0000 {
+			label = "uservars";
+			reg = <0x40d0000 0x20000>;
+		};
+
+		partition@4200000 {
+			label = "uboota";
+			reg = <0x4200000 0x400000>;
+		};
+
+		partition@4600000 {
+			label = "ubootb";
+			reg = <0x4600000 0x400000>;
+		};
+
+		partition@4a00000 {
+			label = "mainfwa";
+			reg = <0x4a00000 0x1000000>;
+		};
+
+		partition@5a00000 {
+			label = "mainfwb";
+			reg = <0x5a00000 0x1000000>;
+		};
+
+		partition@6a00000 {
+			label = "diaguboot";
+			reg = <0x6a00000 0x400000>;
+		};
+
+		partition@8000000 {
+			label = "diagfw";
+			reg = <0x8000000 0x7fe0000>;
+		};
+
+		partition@ffe0000 {
+			label = "ubootenv";
+			reg = <0xffe0000 0x10000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/amd/elba.dtsi b/arch/arm64/boot/dts/amd/elba.dtsi
new file mode 100644
index 000000000000..9739641261c3
--- /dev/null
+++ b/arch/arm64/boot/dts/amd/elba.dtsi
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020-2022, AMD Pensando
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include "dt-bindings/interrupt-controller/arm-gic.h"
+
+/ {
+	model = "Elba ASIC Board";
+	compatible = "amd,pensando-elba";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	dma-coherent;
+
+	ahb_clk: oscillator0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	emmc_clk: oscillator2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	flash_clk: oscillator3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	ref_clk: oscillator4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a72-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		i2c0: i2c@400 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x400 0x0 0x100>;
+			clocks = <&ahb_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-sda-hold-time-ns = <480>;
+			snps,sda-timeout-ms = <750>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		wdt0: watchdog@1400 {
+			compatible = "snps,dw-wdt";
+			reg = <0x0 0x1400 0x0 0x100>;
+			clocks = <&ahb_clk>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		qspi: spi@2400 {
+			compatible = "amd,pensando-elba-qspi", "cdns,qspi-nor";
+			reg = <0x0 0x2400 0x0 0x400>,
+			      <0x0 0x7fff0000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&flash_clk>;
+			cdns,fifo-depth = <1024>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x7fff0000>;
+			status = "disabled";
+		};
+
+		spi0: spi@2800 {
+			compatible = "amd,pensando-elba-spi";
+			reg = <0x0 0x2800 0x0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&ahb_clk>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			num-cs = <2>;
+			status = "disabled";
+		};
+
+		gpio0: gpio@4000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x4000 0x0 0x78>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			porta: gpio-port@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <8>;
+				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				interrupt-parent = <&gic>;
+				#interrupt-cells = <2>;
+			};
+
+			portb: gpio-port@1 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <1>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <8>;
+			};
+		};
+
+		uart0: serial@4800 {
+			compatible = "ns16550a";
+			reg = <0x0 0x4800 0x0 0x100>;
+			clocks = <&ref_clk>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		gic: interrupt-controller@800000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x800000 0x0 0x200000>,	/* GICD */
+			      <0x0 0xa00000 0x0 0x200000>,	/* GICR */
+			      <0x0 0x60000000 0x0 0x2000>,	/* GICC */
+			      <0x0 0x60010000 0x0 0x1000>,	/* GICH */
+			      <0x0 0x60020000 0x0 0x2000>;	/* GICV */
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#interrupt-cells = <3>;
+			ranges;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+			/*
+			 * Elba specific pre-ITS is enabled using the
+			 * existing property socionext,synquacer-pre-its
+			 */
+			gic_its: msi-controller@820000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x0 0x820000 0x0 0x10000>;
+				msi-controller;
+				#msi-cells = <1>;
+				socionext,synquacer-pre-its =
+							<0xc00000 0x1000000>;
+			};
+		};
+
+		emmc: mmc@30440000 {
+			compatible = "amd,pensando-elba-sd4hc", "cdns,sd4hc";
+			reg = <0x0 0x30440000 0x0 0x10000>,
+			      <0x0 0x30480044 0x0 0x4>;	/* byte-lane ctrl */
+			clocks = <&emmc_clk>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,phy-input-delay-sd-highspeed = <0x4>;
+			cdns,phy-input-delay-legacy = <0x4>;
+			cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
+			cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;
+			mmc-ddr-1_8v;
+			status = "disabled";
+		};
+
+		syscon: syscon@307c0000 {
+			compatible = "amd,pensando-elba-syscon", "syscon";
+			reg = <0x0 0x307c0000 0x0 0x3000>;
+		};
+	};
+};
-- 
2.17.1

