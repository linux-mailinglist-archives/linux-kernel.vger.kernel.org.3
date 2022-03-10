Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF174D535E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbiCJVFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343777AbiCJVFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:05:12 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B89DE0AF5;
        Thu, 10 Mar 2022 13:04:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm/uZxK4Y4IYSJafw0WfvpYkYUlPrL8ZLyAkzbplISM4qjE2e7tYVZfMPKlFacTTBxmxX+j4qRkNEoYOl6A9pU+l5MAuNqY6E8eXUCz5mR9G1U8PeB7Ybti+S6WwaWk0tM2lL4xnUUszU56NnYCa2D0WIVi02CD9WKG3tXS6AcLw3J4fgWtn4ccinuE53K6q+80yrjQhfGfj6onFAbdZzIiZ1JDC/hwPOvMYOKVTu7LOrcCLLCokHCW+Hcg/UCFszlO2Tp4r1y5w8294QJObmLuWisH8cAKJktfQBWLvZ8tKUHDjZS6l96bBEBT760phG5WxTaT7yvsVw3dY3n715Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ4EOMQb8nSbdrA+/QDgB2cFOe52CKdhw3WS0lMW3fo=;
 b=XB6Y0ilSMUkhTX+BySIJSGOU9IhDPJKBy1iU7em7+jgNLL/LlpR4PJliQzJ0vZG4wNBnlX5OhnncMPzV53GLFnyGfAaiPZvUl2D4I3Vlc9heqog5CAhu6BxNqFfbwHwfrwP5WgUtm5b0YI6lhzrLgckc7XiaRDDtPba1HwR3yDOERM5SML4xtXiYm2kw/HHZj7moFhFFG8vyNW1BYHqkcCLCS10jZZx/jyeAa/cQXSaP3D5AEDGTT837na/gKzsQfB1+BDvQlL/yGMADq1//LpSgT99kS+qBtmOlLquXCydfZLyoHQdKVmPt0c9gEt8MoEKj4CscohDgC3AvF5Vnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ4EOMQb8nSbdrA+/QDgB2cFOe52CKdhw3WS0lMW3fo=;
 b=SlPgi/Sz/mE0efJgjxwWH4s7dO0O2/xEmDTWQmPI5fV32y0o1jJ/xdLmp3oZxFFl23KWLqQgXNOrRAwC2Rff+T89RJezCJaoRFoYowhv/nM+t/BziSofsrklDafhbyw+kzQ0KXjjv6qcQJ/iBt7BHu9uWmkalI6d3n4VWH/W2GI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM6PR08MB5078.eurprd08.prod.outlook.com (2603:10a6:20b:e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 21:04:08 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5038.030; Thu, 10 Mar 2022
 21:04:08 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Levin Du <djw@t-chip.com.cn>, Tianling Shen <cnsztl@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH v2 2/3] arm64: dts: rockchip: add basic dts for the radxa rock3 model a
Date:   Thu, 10 Mar 2022 22:03:51 +0100
Message-Id: <20220310210352.451136-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220310210352.451136-1-michael.riesch@wolfvision.net>
References: <20220310210352.451136-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0132.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::11) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60e4609f-1c86-4893-9d6e-08da02d984d6
X-MS-TrafficTypeDiagnostic: AM6PR08MB5078:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB50786CF68B59ED4EAF89F90BF20B9@AM6PR08MB5078.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IS/q9B7vrjrjhn9NS6MqWqc90rh4vBKruAHpa9q+ycQGlqeHSHwcyRXCJifWp8+kvpg9oyS4IAe53jtPKIZevnLsBNf9isrp9NHejZmTazQTIb7VKoUkfKVWNXek5U0wL/ZI9BmRxwhofVAE5p8iOLm4uz9wknObqZpnLpL2oPsyV8q7w1MAga6ktDq+M49hCcGjLJci3Vdv2tMLDDZ7IR7so/WrLJ4gtzmAH6f2PyvKhXOw6jLdUswNEMKcsSdyv4RLceWDtnv5xmTCNWZ4ZzwIQC4gn3E0JzKBWOxBQ57+jRi3TgOHV/LjPc1BvSEzCwYTmzWisXTzvw5pCW+WJlHpXBmq4KlwxkydYsWajAkwlvnvfZ2jmdSc618e5dSTwy18poUGBTkT492LBq9Onw4LzMhzgEFoVy1a9ZAifS/Rs2h12XQ9AC/KvbR29Za+ZH+tapFoEWA2R1SWnH77WeKU9T0pD2YrFqMKkpnh6B/mhuarw5NwqHhjBnlD61uwbU4X6viISJyKrpKt4VrIQUC+wFQFlIJEQfP2nUUYjzD2UJR+A6pjNRAcfXoTRNzQyD+wCtEjmssir6O5iJuMFA7ZcmTxSByv6Z+1zApSAiGe+HZ0m4/efLbbPYqBboSGCm9GLco2yEokMemvnbdfTWJvAbcdH7jVBjxA1AWkpDApOyUl1T4lRHCa4faLU+pBfmnnyyR8WZZDKr0/byQ58A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(30864003)(54906003)(186003)(44832011)(52116002)(86362001)(6486002)(66556008)(66476007)(4326008)(7416002)(5660300002)(6666004)(8936002)(66946007)(316002)(36756003)(6506007)(6512007)(38100700002)(8676002)(2906002)(107886003)(2616005)(1076003)(83380400001)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dMOrR4RGFJYlQI1I1VY22ouq23yaB9nZGvavf1rrhIUPw6pZc8ZryK6U1JzS?=
 =?us-ascii?Q?rnzDdHVh/ccsBEL1KLFx/zlM/dTuIrqVHyD2SYQGtDOOjLpi4anW5sH29F4o?=
 =?us-ascii?Q?CRaWGrDi3GYwY6m7zX20FERzuZvvBsGkwueYMg/5B/hPLiId7hYsGwXUlWve?=
 =?us-ascii?Q?S/RJdGbnd5z9ADF+6iz/6Y/h5GSHVW661N8nXRSVBzZDdrnSEkJ24IyB+OQ1?=
 =?us-ascii?Q?Innaee4jXrNj7P99rR9OtUx2qnk8pWzA0G1HCWmkKEkdO0ABTBW2ngPesvsp?=
 =?us-ascii?Q?F64lV9Rv9E3U+GXfPz7ElyCZowQPhF2qHljTsVe9XiD2lDgtM/brHyIIzbxC?=
 =?us-ascii?Q?Z82nlCa/EKh14QPNV/vZAKcDlMjnuXmq0emMnAKl3bDooINWChB0PdCe0+FG?=
 =?us-ascii?Q?rFo79w1s7piFyncUQWAxMO8fFgU8mU0P7qnI3lRmpzE9V96kgx8yhrxMG53f?=
 =?us-ascii?Q?8IJXT8ZMhLuMkKZz7NktpFzA+jVOix7Qb9Gbe7r1s/6HV9qhfzq/WikAST6a?=
 =?us-ascii?Q?/W//lyiEUAmKlMh3LKqL2QjfkF0ji5tdxBVqyvKqyzKA9i5hqqdVlPyjFjqH?=
 =?us-ascii?Q?YzOwElTBfbKsbvZiS51HC9a0EGbiMymZY45Bmu5EYrRkVceNswNQtC94qD3D?=
 =?us-ascii?Q?dFDtzNerUdsCPc8iRopkDM+Jz8nsSX3uhhBI8dcQYoDELhpBYlzfsa+G+CX/?=
 =?us-ascii?Q?wZnejuh3sQu9PBaMSoNavTvHgzmj3Hc2VjPcMwghTqw7Rf5UVEx8wfntOs+I?=
 =?us-ascii?Q?M/dSBREHEeq5Xyd51x29NqxTWZgFJmYpR5pDGnVePT/IfoucfhwiTYFC4N8I?=
 =?us-ascii?Q?iQkRHE7r2D/THN0Nv1FvmkdG6gQygEyDib6/57bH6d+3/r5FLf17IOkupPWI?=
 =?us-ascii?Q?lbAyQDs3RYqmTeBhFeDeKIYNM1wHTAg5DOJNPUT6Ui/xWg847uN6407Un49H?=
 =?us-ascii?Q?+Hiegyfa+rbcaMgb2fm4rv8qEszy+5AQrJ7tl7HUHQIDT0vMAV7fPg82l1hI?=
 =?us-ascii?Q?4RP8O1yA70GV8EtiZi0em3lqQl8rbxto7qUJiWyZs0BKDyBBJmJb2R1ADYLf?=
 =?us-ascii?Q?sK3ufTaa2/3QDbuwHEL7gcb33Z9/1cYVMmhp8cjUodXxZCPeVq7YBpGmm+P9?=
 =?us-ascii?Q?tdMtVLecZ27HMn689s1wQbPu/HZo9t8bTqi4p9KKU2zb9QCvRkt04d37gw5K?=
 =?us-ascii?Q?R9MCugE9eZunwScErmA9AMaHNHikgckjedWarwpyxaDGLm+x2wo5xLMOzq8o?=
 =?us-ascii?Q?9wqDc4+He0ZeErNcxQ1Zz/IqYJwQOPpE6DJKBmEls+iRRX58jZcfyjbyHvBl?=
 =?us-ascii?Q?5rDc7WEfvLTlJXklRtjDuaFMa+DZCSUY2n5fFfirj60etSfttZVLWiHnLHsy?=
 =?us-ascii?Q?wc0VITg1UnRxgZIW66+na/i80YrOwmBSb9jPr9ZbZJIDxhPSxnrysqnZ4S7h?=
 =?us-ascii?Q?togxC7iSoUawUd46JLemLkrjjh0gplSRD1ymXdxse22ssSPdmEoMK4toib7z?=
 =?us-ascii?Q?VguUxLiVBPA5RDICI3eNTEJsmBuvedrD6CM91x/NZTwxV4Lm2QZsZcOgKaPr?=
 =?us-ascii?Q?+wHJR+xOssuB/Ww1n6g=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e4609f-1c86-4893-9d6e-08da02d984d6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 21:04:08.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8qu3TeyP4+24rJYO3mTP/HlOmZfVpdJnRDNLa+HmF1x8hRG/slIM+GryHNFaGzcyUaYQkrOHs5V4yqhlVfeVYoTl4aC2kKjbEeZeNCTx9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic device tree for the Radxa ROCK3 Model A board (with
the Rockchip RK3568 SoC) including Ethernet, USB2 and headphone
connector.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 501 ++++++++++++++++++
 2 files changed, 502 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 479906f3ad7b..5fc9cf98473e 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -58,3 +58,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
new file mode 100644
index 000000000000..18d2d8e5e693
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3568.dtsi"
+
+/ {
+	model = "Radxa ROCK3 Model A";
+	compatible = "radxa,rock3a", "rockchip,rk3568";
+
+	aliases {
+		ethernet0 = &gmac1;
+		mmc0 = &sdmmc0;
+		mmc1 = &sdhci;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led_user: led-0 {
+			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
+			linux,default-trigger = "heartbeat";
+			pinctrl-names = "default";
+			pinctrl-0 = <&led_user_en>;
+		};
+	};
+
+	rk809-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Analog RK809";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&rk809>;
+		};
+	};
+
+	vcc12v_dcin: vcc12v-dcin {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc3v3_sys: vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	vcc5v0_usb: vcc5v0-usb {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	vcc5v0_usb_host: vcc5v0-usb-host {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_host_en>;
+		regulator-name = "vcc5v0_usb_host";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
+	assigned-clock-rates = <0>, <125000000>;
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m1_miim
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_rgmii_bus>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	vdd_cpu: regulator@1c {
+		compatible = "tcs,tcs4525";
+		reg = <0x1c>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
+		#clock-cells = <1>;
+		clock-names = "mclk";
+		clocks = <&cru I2S1_MCLKOUT_TX>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>, <&i2s1m0_mclk>;
+		rockchip,system-power-controller;
+		#sound-dai-cells = <0>;
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+		wakeup-source;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-name = "vdd_logic";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-init-microvolt = <900000>;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-name = "vdd_gpu";
+				regulator-always-on;
+				regulator-init-microvolt = <900000>;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_npu: DCDC_REG4 {
+				regulator-name = "vdd_npu";
+				regulator-init-microvolt = <900000>;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG5 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_image: LDO_REG1 {
+				regulator-name = "vdda0v9_image";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-name = "vdda_0v9";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-name = "vdda0v9_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-name = "vccio_acodec";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-name = "vcc3v3_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG7 {
+				regulator-name = "vcca_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pmu: LDO_REG8 {
+				regulator-name = "vcca1v8_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca1v8_image: LDO_REG9 {
+				regulator-name = "vcca1v8_image";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3: SWITCH_REG1 {
+				regulator-name = "vcc_3v3";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: SWITCH_REG2 {
+				regulator-name = "vcc3v3_sd";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+
+		codec {
+			mic-in-differential;
+		};
+	};
+};
+
+&i2s1_8ch {
+	rockchip,trcm-sync-tx-only;
+	status = "okay";
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&eth_phy_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	ethernet {
+		eth_phy_rst: eth_phy_rst {
+			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		led_user_en: led_user_en {
+			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int: pmic_int {
+			rockchip,pins =
+				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	usb {
+		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio2-supply = <&vcc_1v8>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_1v8>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcca_1v8>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb2phy1 {
+	status = "okay";
+};
+
+&usb2phy1_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy1_otg {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
-- 
2.30.2

