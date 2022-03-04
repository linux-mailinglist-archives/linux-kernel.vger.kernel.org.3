Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838774CD8B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiCDQMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiCDQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:12:36 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130088.outbound.protection.outlook.com [40.107.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E901C9445;
        Fri,  4 Mar 2022 08:11:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSquBm1S6mvuxCmWxuuIEw7Fk2HA1qWrHtCrjyVsESDipLXUKIDXFqoqlLefzZ9z51+P4nq3+pCGu0q6Uck/2rchJmI6Ad4tm0oNXexoE3NP1ZOOxm01dsMlMnpbd/S86KkXns/U/DqiFP7MSiTi96N9Wgoi9GS3kq5QpCDTqAa81hXpn9ItOBZc69Nd50UIg/GEZUAN/X6uYe+EowYg0ttwLO3RwEji21fy38q+29cPBROydeh7VA9vwSMtd6DCyWuCJzW9VV7ZNaczERb1CO08dpgcM6ANIOkI81yTk7E6RFugw4RPDWaX0N4tYLkUH3Gj/l9LILKuowgreL7Nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrBegQthmemtahFXhXM5fiaRmm97+pq/urQh5Ie61Uo=;
 b=HNIoCdEvHwgLiJtzc8axeAejfwbp2TPxOVs1MdOIGQ00PtTBFpxgALsxl6tLSBtvP3zNlcI7gEhLaRXaKmavjgzV6vRZt1R6wossOl20BvNttiZhVQ72hZYOVGgHfDDiWlzYz/eydtwOuVL4XvHad1+Z6A1k6bCYU2gt0CCTCiKVsbiBcDT8yoqBSnocDpMT3NFqUZL7v2Xlz3Q1IsAetRd11tsugWpM/rvWou2CKpvkQdJj7w01nDdMS6RL17uN/a7tAiKPuSY/EuMT+iJ9Mj/1lknFLZArFnZ/v92TTokEzkN0sbuDeZtjb64dz04WXSgP+BqHfjdB/+vIW1YsWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrBegQthmemtahFXhXM5fiaRmm97+pq/urQh5Ie61Uo=;
 b=lNpwgvbUsFcMPMis3tudq6S/B4Uad1RvjjMds2+LZMI75zMfQuIlnkR6iBOx/gnKFIWhe2Z1vmQhZRc7OzPc/y5bSxhgyitEMctC8gn0dvL3/t76BA7Nmgj/qen1Px9CX8MoDtcmxAzthkd0I4+euf0S2zDrp+bMg171dKpeL9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DB8PR08MB5481.eurprd08.prod.outlook.com (2603:10a6:10:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 16:11:47 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5017.028; Fri, 4 Mar 2022
 16:11:47 +0000
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
Subject: [PATCH 2/3] arm64: dts: rockchip: add basic dts for the radxa rock3 model a
Date:   Fri,  4 Mar 2022 17:11:29 +0100
Message-Id: <20220304161130.34977-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304161130.34977-1-michael.riesch@wolfvision.net>
References: <20220304161130.34977-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4978932-65b1-444e-082b-08d9fdf9aea8
X-MS-TrafficTypeDiagnostic: DB8PR08MB5481:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB54815982E6D8228A095450DBF2059@DB8PR08MB5481.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KrYOnURGrvFQi1F2VPeEpIAd3rGfcomavmkNy/+hZnW0mVDQ1ri+PQmCqeYpecbVF2/72zmYboLVe6tMTPioLQknIX4a1u6HzK2pFBZIK1thjpwbgY6cBA5gCTE77BaD4+J9rvZ5QDxfTt/BO/Y3FdWfshwHr4jAcUeqoFgNuO57mdV1YB29sNrETpDrtibrVrc80rGOdZAW6hXtshnQVBIQankYIdH+mL3A8QdMz9KT94mr262lPjGOLqY3ZaN5T3LHH+3JtobAw3y0sD3cXMGa716aCCyCj9aYiGYBVFerBlLT3fu1qOsF0UHMK/pjN3Al4dbrMhceTSNSlGElwLt6tKik7zLrGPMdz4qZ6UKGnUsfldmaBvmTiWPuuswmzCyIVedn2kxNGliAEqNMR68dN37g1dfg+KAUN1iipV7tVqVo8+aeQ4Ndf6y6ErDOuiuSEgImSPJh4Yy+OAQHZhDTzb2zwxZij3CzJ3RckKaJwHSK0sA0Xgut2nq4u0T8ZLFUrFUwwpfWP/oC9Lq8OJGqDApHYou3PZat94hTSqbBInqk7hWI10FkvT8zFBLFNWYuGTQZVYI7qPVIL0SWNmtIzx4hsGusGTPTDAxuffnZ4hOQZh/O7z8dXHNYyQlpyHUv8IHHQThFdaBvr5uwUXIT3Nr2ImPYFxhiKdjzwBF/Y5iQFszXCUf3km0EhlLTp8cpi0hqOWMF44SNB274w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(5660300002)(4326008)(38100700002)(8676002)(66476007)(7416002)(86362001)(66556008)(44832011)(6486002)(2616005)(30864003)(508600001)(186003)(316002)(1076003)(107886003)(66946007)(6512007)(54906003)(36756003)(83380400001)(6666004)(52116002)(6506007)(2906002)(8936002)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sbPLaHrh8WAATgUWBhJ3LbRMJU7TikFCVCVeXiKXF4hMk8mL/Ml5IETdoad6?=
 =?us-ascii?Q?6AN2WwvroNUETNw6JO5O2hruF9u9bMpFDZwabe2HENOPiEwL+difFg4CooPy?=
 =?us-ascii?Q?lHCE3JKG+Ga5LCQHieZSa/djJS/vfZ5ZYJgfTRoZn94EGniu5xNBXL8M/hMM?=
 =?us-ascii?Q?VZP9jTQAAECC/3l1xRHo7X6cloTNEEnVTK+USZDINDNAZkm6QkDo7lFF9odM?=
 =?us-ascii?Q?NNTcvm6gnZkqrq1VACJGP0jFGFOtuCb5nLGK1lJRSQaqmiwOM0Tl3qNOAV4F?=
 =?us-ascii?Q?nyz3byyctnVrny1tUAaE/S8Li7cukQSwO9miN4Sg34gR7wPvLA5RHvfYiLpW?=
 =?us-ascii?Q?LRheOZ5m8PxB3s/Z35XumGDdNBR3Sr5cRxpinS1oSdDDz2eOMNUcZvL8DfrV?=
 =?us-ascii?Q?aT9giqFUarX1vfxOxhpHWepvlJUNU7E8eQbM9UkRUPKeJwDdCiWPW2aUZwHq?=
 =?us-ascii?Q?od4kQErwpYH8EUVuj1pEisv6r37+7XlKotMc9jV3qtUUHrMl0JOQnYGnXA5U?=
 =?us-ascii?Q?/U6Sejdkp4X4IbfCRyuK+Mgsb3yKZ3GQQ6y0AxKVprzWYAs/7bgfor2ijsSg?=
 =?us-ascii?Q?EG+TDSokFCt6JltlhBFPuqiiEM0PoS1PbTkw5Yaq//6MnEaV8TDbLOHnsIRu?=
 =?us-ascii?Q?Zd9qNvINgOJlS8iOBurqA8RfPBuqFpH6nA0HMyY6jK3kO4WcTxyFwGn+QIZd?=
 =?us-ascii?Q?RHR1atSv9FB61jguErKmq5uRs+Ur7nFbzFZ3vZyHX0QyU2yDAJTaO24dV6FY?=
 =?us-ascii?Q?HGlXinpV2EWwfmCOWJlrQFjdFvUuguiNCo93K0+FTeWouZZFCWPBUWMIu80y?=
 =?us-ascii?Q?9LbllL+tfh0pDsaziyliaRO0ca6TqnOWb+Q/YxNDvQWM/DKYpgEAlPy7s2q5?=
 =?us-ascii?Q?xVY1uqWvbfdnQymNnoohuhUiGwaBvXT3hLEuHZKgeXg6FbiK64+JdN0LuqvR?=
 =?us-ascii?Q?9/xs3jiLJYiiF80qCxN9ClTS8AUQBBr9n2g4Rq8ll/nkkzpsE7NuiB0t9mNM?=
 =?us-ascii?Q?jq3pYzWHbry5E7zgWEJqmvGn499YH41gGscFfqoJcIhQze3AzAgnIgv4W4vC?=
 =?us-ascii?Q?NNHf19hAW82ofZWDPqzR/hGjjYQ9weIQ5eeNRpzYkiu20AxePKTecNWNfZ1R?=
 =?us-ascii?Q?OCySdvWucviQFze8SkYUHCE8ukCsBjpahuJFl1zwhM33OJJU6kNGHRXF7X2n?=
 =?us-ascii?Q?KkcO9Wd/PzPcnBkM8xl3K6fctuo9gKlXzCzjOzqBIxFL5aoip/d2TBdxpslp?=
 =?us-ascii?Q?HhW0+AgVGfL6Ry5lqFVC/uzc2Q4qgfmmkJn8BmHUrRSgF6/uo/yBMjt/OC+r?=
 =?us-ascii?Q?mI5mqXpuyf5Vppkxi+OyAcibwGGPGTCKVetARKL86/kq/nNaIAzT2I7qZRw/?=
 =?us-ascii?Q?oi8mWpYpOiCdGrGryoX2Lhpbz616O+xbghQVGpSS5pez+M3pqa5mIRP+Di/F?=
 =?us-ascii?Q?o8WIgSb+3yOxWWNqJv6VSmw2tF59SCaamJaPu0QBYUddi8yaSzjes+1i38al?=
 =?us-ascii?Q?vSFugCIDDbqB+sOr9uUi3OauIJRECNu9oTpWfq9bOlH8t0lESYmJhDLyumhT?=
 =?us-ascii?Q?yLEeXx77VT5AqrPrKImHJFwqKvtxnpUuiIurtCQadRuw3waaoGY/3RGwGRO3?=
 =?us-ascii?Q?npYAqdJaKyMA2YAjQuKNf5lQOO5eQ+oizUpoBzTKQvuVlYxRJsCyy1SnP0RP?=
 =?us-ascii?Q?sSWiQ/JtbjKx+Rce133VcAu6p7davFCx1K5YsTzw3HtvkCyPwFp8xSDa3S4F?=
 =?us-ascii?Q?OZBTNpiJRw+NOKIdXfTZteBEk+2qOPA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d4978932-65b1-444e-082b-08d9fdf9aea8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 16:11:47.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIW0mzXdddzPuCieAh1r0+MFnonCzRj3lP59XAFkb3dgTcLA9pZrHH6Xr7aS/LK9lEHl5OKtyudLa1IYnVk4XVMx7AYDfqP4WmR2MV9YK0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5481
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
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 501 ++++++++++++++++++
 1 file changed, 501 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts

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

