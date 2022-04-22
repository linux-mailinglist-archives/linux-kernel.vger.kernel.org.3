Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6550BBFC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449549AbiDVPrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449561AbiDVPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:46:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2048.outbound.protection.outlook.com [40.92.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33D5DE4F;
        Fri, 22 Apr 2022 08:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbgyaVazkYmMUFqN6uEtdextqshiu9sUvPXGvLArXq5J2hTNp63LkEKAdO4AB6J4o6jMlLSsKiEMIMmOW1wep8hfdOjaHoHsBPJLOme3uUTVsZe7RCorseiLcalmVGVskedAYrQo76O4nb1ETmljMBUhXF/M58nxaZE65Wh719R1qKj23QENAqlnwOdz4b6AlFnVAhQDXNwrsHjtjYmFgcJli0MeZoX3s8rcDswBJeVm0V6oL8bPQ4MNeKOR3gA6qUbt4WmRmEdnlEfSzEWyQWG7jUxO5NbDPhbqPZmZLKCU4eL2IRhlJxR3gbNHLeZRWWNZtO5C+53goeXfJ0ZbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvJHw1ekFeQ/5or066Kmv/UA5wbK0ZQ6EoGiQ1Pdgc8=;
 b=dVGwWGO9ircRdMrHTGZ0T7bZa4iHluaBMGqL01fhN79ydfwlf15aIPc93TRXxT4O01p/55pzz1rqySGuJFvuLnS8ZQtANS1GXBI2tCvUcuu32Xc0/F9anJdJRhTsfx1m5QWkRuEZTprtt5UKD+UWIMBzOnylcPIZ+oz1S3G2Qm8gpP1NqJEHK8F8CA1HV6jcT6CV150Fvf+ysLnWJBrtH4K09Ury7PLDwGbhQC3fhUXZnEfi92WmUoZ1jwsLKVVwEsBItFLEuPCxH4a1GqUw1/yUuFWsQhFaxK2VJ3yTaLZtbRMBXfeDJaJp7p0Lsjel2+O/vHaLkBfSsG9iVKGrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvJHw1ekFeQ/5or066Kmv/UA5wbK0ZQ6EoGiQ1Pdgc8=;
 b=XvoE/MsOC7rUNYr+2aox6Kw9gDSs+iCXecQwomDgP8d1CnaCMicR3VVTxLHBs49HNUps0d1aivYHv0m3bhvDJ3YbZYlphmKhQYe6PCjadR5dckL/9NM9BybL5j14xt0A9hD0iXNvMETmLwkgWq297hr1q2vOkmBeY9ieKA73Eoq9cqnoWgOYgsPz3HFi/jom4f8p98V/VaEVVRmUoVxTV91Xhu1XiMeKAJE2z8T5yOVuIyHa3NahZ1/GYLM7kxPMPTqFCGFcrUquU2TL9nHCUL5r8h2HxxMN2qHFsmFDBvgxLGF9FVnAxSY0NFerBKaCyVETCeUmpLZEIgLchdrEOw==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by DM5PR2001MB1836.namprd20.prod.outlook.com (2603:10b6:4:17::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:42:57 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:42:57 +0000
From:   icenowy@outlook.com
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 10/12] arm64: allwinner: dts: add DTSI file for R329 SoC
Date:   Fri, 22 Apr 2022 23:41:13 +0800
Message-ID: <BYAPR20MB247209BA9B07425FADC82A84BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [rjxwSqcypWDq2tJfHZzDxqAz4veJeXTo]
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154115.1068642-8-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 084024c5-ed35-4091-3685-08da2476c611
X-MS-TrafficTypeDiagnostic: DM5PR2001MB1836:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEKG/ir5JA4ISrkOT2cV5hT2YtoKA3LiA6ew66kNpmrgYjYeH6IMtTk9IoZjYdKTrWK8Qj6f6k/2mK4qDKF/yD1D11XAzgUmpsWY6Pq+mR4f7DeCZ0HaPZg2FrLJYNfkJEoG0x+ssfCUUXoSvi2002H3ZChD8YEuq/PLJWmkOBDRZGrTnFn84PyIVnQict8MQ/pamDQkU5IO0R2HfJxka8SkNhjCgqz36FyqDqPAIRGvZ/K9Gd3LNO67dIGLrKk/N58wOn47YC4eBXrXxubf5vbM5ciKdcFSf0nfqHSGWma6pd9ZmI8aoXTDBq5HYP6+lHzXswV31pbQZSU2yKusjmEp51Dq4Ht0BLaWq2jWn9QJMYW4xYqFrcH3c9/viOCHVDAXuy6usQOwa2FEKkXcHB8jVaewyphxge4dqUchp8oAosIGq52YoYq5eMp0H+yCe3H9ML2i95oe2919FGtmR8IDfxxQjTQ7e6vl/AVLP/75TeEeEYDtqnpkjtuQZ4dShVWHu521kmayB7hJB/EoehkrMCJRU0E38NQuYpqhAclGd1McYizdPCyaz02jU2S+oJrB4DseildyTTWrJH+jPA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jAWDShazPnZqnr7MisLUi3Ftm6JqP7HWD3sutbkk3xvIN4Qi2PJdJyuTCCQm?=
 =?us-ascii?Q?LK8B7FXAlwpd2/9QYJFBMg9XHkgS7u3d0NO4HDzotZgreVKcmDJbZO27L/2z?=
 =?us-ascii?Q?Q8uj7RK539PGDs4+PPWmQQhWHqwmfLeCdM1jTtWR4lo6wstSgo9/G8AJ/S0R?=
 =?us-ascii?Q?uI2BnSfSDvKWvxluZzHLpkyTZXq/qEOoj+k9roHN6Zj20rPq70Vs6R/yyyU3?=
 =?us-ascii?Q?qiR/D4BT9k+E9ZSMz3K5woosbjyCy4pRzc4W6sW8bKNsQih1z+IgXGFIZXKg?=
 =?us-ascii?Q?AtLIg8p1s2qvwi2qCTeRktOPA0TtfKRJ49HYaVudun8/PmW71vEpYdibPCcw?=
 =?us-ascii?Q?YO3i4tawbU1E68aW350uzuJYx0X2Y7a0laV5hJJJrgvceKPmhmzAk8+6H3GC?=
 =?us-ascii?Q?2cNbvNrTfczr9yvhwj06mc2zRBjAJtzJ9Lt0M+w/OVw+NtN0QhwE7KSwpPWb?=
 =?us-ascii?Q?YHdZZ3YcB1Urd/gvuk4lLjyy3bIWN46h/2H4pw4ktuLgyBOFeZ6+GABIXeez?=
 =?us-ascii?Q?389GnG6gisiD4whRkgOOVeIT0s0sZLyFMdeya+DghB5bptCEQ4AQS7TSCwRc?=
 =?us-ascii?Q?/R9PzuJOaU6W046vEKwSW8jcJh0xfxwzu9vMd/Twv8arPX1WSTCe7Av/18Ez?=
 =?us-ascii?Q?f7bNk265o9V/PqaLlO/7Xvz6v5to84TFgvpjrJuxwBQKp3Q66O9kQZ7uUTHU?=
 =?us-ascii?Q?MIBdPU9qdHmqSohrAWlnCAkxnpI0h/kzgicb/LsGMhtRGBi9bzjhq1KL0gvU?=
 =?us-ascii?Q?YAcc+IgZR/odqndkCruwxd2LML1qaqbBrY7/BjrMG+2jB3CM9qNC9cNQxQ/U?=
 =?us-ascii?Q?GUDBiRBfwgqShMEeDBh6UJYwqV4VgI7DYhKXkF18diU5FGr4RIHI14ICEnc9?=
 =?us-ascii?Q?YlW1COaU0L7/RJ2WzrYtCq9lBShUPL2KCDIycQq0pycc5/wSYhZX4hQDQ8Or?=
 =?us-ascii?Q?yDIoQhx5PmnfIwRbtHKH0dAkj6e/JrKRgK6OLUeIR8yn1E3ZL38el/8DXpxQ?=
 =?us-ascii?Q?h/f5m/mZPAjL3YcgS9P1GNvdW2dhtZ3sL+PUs0iuKlaIhU1JnEt3i4J7bzpN?=
 =?us-ascii?Q?ig18YcYbCMW8h4JDWpwQL/OEXdtGRdSzQnMPz3Wwqnt13maGm69aEkhi7h9y?=
 =?us-ascii?Q?u3Wo+S/wx0mIwV774wte7/pAUPnkNI2bBJ1qSFQn9diwei9Px2m50jnrzZvt?=
 =?us-ascii?Q?u8zBeguZrbsrTgMmOraKRvrSmOsj0b3kiKBuZK6NhWjg6/VDJZxE21WGenCj?=
 =?us-ascii?Q?3sCfqePmcl2Qr/q+XHL8ThjCUjdctrtLmnO0Ti9UqkITihSHBFTFITvBW9zE?=
 =?us-ascii?Q?L9yIVHQK6pHP88OB1xu4qRWeZsNHy7XIfuelUFeygVtY63g3H3p1sdbvSXGs?=
 =?us-ascii?Q?oCZv0dwkfudUAmc1GNLzaeReauuMsXgIqZJBKqRRDAYxRupk4tFgewoQpBVD?=
 =?us-ascii?Q?xBKOpKTLr1Y=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084024c5-ed35-4091-3685-08da2476c611
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:42:57.6760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2001MB1836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner R329 is a new SoC focused on smart audio devices.

Add a DTSI file for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../arm64/boot/dts/allwinner/sun50i-r329.dtsi | 275 ++++++++++++++++++
 1 file changed, 275 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi
new file mode 100644
index 000000000000..249ed9ff0c5c
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2021 Sipeed
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun6i-rtc.h>
+#include <dt-bindings/clock/sun50i-r329-ccu.h>
+#include <dt-bindings/reset/sun50i-r329-ccu.h>
+#include <dt-bindings/clock/sun50i-r329-r-ccu.h>
+#include <dt-bindings/reset/sun50i-r329-r-ccu.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <1>;
+			enable-method = "psci";
+		};
+	};
+
+	osc24M: osc24M_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24M";
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		arm,no-tick-in-suspend;
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		watchdog: watchdog@20000a0 {
+			compatible = "allwinner,sun50i-r329-wdt-reset",
+				     "allwinner,sun50i-r329-wdt",
+				     "allwinner,sun6i-a31-wdt";
+			reg = <0x020000a0 0x20>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
+		pio: pinctrl@2000400 {
+			compatible = "allwinner,sun50i-r329-pinctrl";
+			reg = <0x02000400 0x400>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc CLK_OSC32K>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			uart0_pb_pins: uart0-pb-pins {
+				pins = "PB4", "PB5";
+				function = "uart0";
+			};
+
+			mmc0_pf_pins: mmc0-pf-pins {
+				pins = "PF0", "PF1", "PF2",
+				       "PF3", "PF4", "PF5";
+				function = "mmc0";
+			};
+
+			mmc1_clk_pg0: mmc1-clk-pg0 {
+				pins = "PG0";
+				function = "mmc1_clk";
+			};
+
+			mmc1_cmd_pg1: mmc1-clk-pg1 {
+				pins = "PG1";
+				function = "mmc1_cmd";
+			};
+
+			mmc1_d0_pg2: mmc1-clk-pg2 {
+				pins = "PG2";
+				function = "mmc1_d0";
+			};
+
+			mmc1_d1_pg3: mmc1-clk-pg3 {
+				pins = "PG3";
+				function = "mmc1_d1";
+			};
+
+			mmc1_d2_pg4: mmc1-clk-pg4 {
+				pins = "PG4";
+				function = "mmc1_d2";
+			};
+
+			mmc1_d3_pg5: mmc1-clk-pg5 {
+				pins = "PG5";
+				function = "mmc1_d3";
+			};
+		};
+
+		ccu: clock@2001000 {
+			compatible = "allwinner,sun50i-r329-ccu";
+			reg = <0x02001000 0x1000>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>, <&rtc CLK_IOSC>,
+				 <&r_ccu CLK_PLL_CPUX>,
+				 <&r_ccu CLK_PLL_PERIPH>,
+				 <&r_ccu CLK_PLL_PERIPH_2X>,
+				 <&r_ccu CLK_PLL_PERIPH_800M>,
+				 <&r_ccu CLK_PLL_AUDIO0>,
+				 <&r_ccu CLK_PLL_AUDIO0_DIV2>,
+				 <&r_ccu CLK_PLL_AUDIO0_DIV5>,
+				 <&r_ccu CLK_PLL_AUDIO1>,
+				 <&r_ccu CLK_PLL_AUDIO1_2X>,
+				 <&r_ccu CLK_PLL_AUDIO1_4X>;
+			clock-names = "hosc", "losc", "iosc",
+				      "pll-cpux",
+				      "pll-periph",
+				      "pll-periph-2x",
+				      "pll-periph-800m",
+				      "pll-audio0",
+				      "pll-audio0-div2",
+				      "pll-audio0-div5",
+				      "pll-audio1",
+				      "pll-audio1-2x",
+				      "pll-audio1-4x";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		uart0: serial@2500000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x02500000 0x400>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			status = "disabled";
+		};
+
+		uart1: serial@2500400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x02500400 0x400>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
+			status = "disabled";
+		};
+
+		uart2: serial@2500800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x02500800 0x400>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
+			status = "disabled";
+		};
+
+		uart3: serial@2500c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x02500c00 0x400>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@3021000 {
+			compatible = "arm,gic-400";
+			reg = <0x03021000 0x1000>,
+			      <0x03022000 0x2000>,
+			      <0x03024000 0x2000>,
+			      <0x03026000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		mmc0: mmc@4020000 {
+			compatible = "allwinner,sun50i-r329-mmc";
+			reg = <0x04020000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc@4021000 {
+			compatible = "allwinner,sun50i-r329-mmc";
+			reg = <0x04021000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC1>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		r_ccu: clock@7010000 {
+			compatible = "allwinner,sun50i-r329-r-ccu";
+			reg = <0x07010000 0x10000>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>, <&rtc CLK_IOSC>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		r_pio: pinctrl@7022000 {
+			compatible = "allwinner,sun50i-r329-r-pinctrl";
+			reg = <0x07022000 0x400>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc CLK_OSC32K>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		rtc: rtc@7090000 {
+			compatible = "allwinner,sun50i-r329-rtc";
+			reg = <0x07090000 0x400>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_R_BUS_RTC>, <&osc24M>, <&r_ccu CLK_R_AHB>;
+			clock-names = "bus", "hosc", "ahb";
+			#clock-cells = <1>;
+		};
+	};
+};
-- 
2.35.1

