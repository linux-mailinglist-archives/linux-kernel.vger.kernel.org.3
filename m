Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6803B5020CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349034AbiDOC7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349026AbiDOC7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:59:17 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78D9B3DDB;
        Thu, 14 Apr 2022 19:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFSc+o6Am6jJNty26LQAlFA3HCnbjMZyHluU7sySnDcqDphLdtLffaRMxD2swxmKv/tiZKne31LkzJwvXsmg2XPbdEelxY4/4vGhpUSzqlKYeR1Jpoy9jZKsAMO1j04895VRyqx6+MdpbdhZz6pVyNLGsXLQd1E9DFWUkHXPYbJv0zFIbO9LukmR4/PS4JqNjRnCytPFQ8bP419PFEooOwvbiG5bditdXbq3G4+lYkSDKZ0fDvc2fAtcNtxI5lMDWBmijPpQ0D+23h+yyxP3N5hGomz0sA+o/kkN9C4Z6NDTTzXndMK3n7900k5iy/QBTdEhqvBcTXcmiDzqJ7nNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjyQIwyzdQoTjG0KUBqQr+MNQ/aqN0BIKe5tcVINOSg=;
 b=MvSxyi299ZjrxWYMS1r9pdDDdIutgJHI+LkmSSoplHcxEWv+tcfww7yhINsfg5HCCmJx1QLrtboax7lUIyPFnHKA4HBc9kco1nPuVvtkY3XyjDb35UxpCvm+aExLcampTCrxGnC8s4aGWIP4DPvJO92v5Cmu0Q5+981N4VCIoQ6WC40u6X6b6uQD5oF5Y2hzduZDyNuE/8Fcihk64ZxSuEZYoycj+nBTistmTcujLgvdvqDUPFWFhiUavzC2+GJpwHEd3dqZUp5X0M+KtVl8XTqWY2TV1rpv1tzreBOApBXvISqGOHl1VcIRj/woK1VkGweEfaRvvktx6TYpsNupGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjyQIwyzdQoTjG0KUBqQr+MNQ/aqN0BIKe5tcVINOSg=;
 b=EdxTdU0aTsYQoLoqS02Z+mcWlUu4U/uV5j5hFd8izRH0cUGlmxcf2d37TC4KR9Gv+Md2iPZd+hbgyC7Zlwcm/czssTaNh7SJsZ8ljZhGbQTaQxLcwE3YIJdzknIBLMzngm9gc67vKn/Z/+12+U6FcM/v0CPxojemts7XMBC03TY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by DB3PR0402MB3770.eurprd04.prod.outlook.com (2603:10a6:8:12::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Fri, 15 Apr
 2022 02:56:47 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 02:56:47 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, shawnguo@kernel.org,
        festevam@gmail.com, marcel.ziswiler@toradex.com,
        l.stach@pengutronix.de, tharvey@gateworks.com,
        alexander.stein@ew.tq-group.com, ariel.dalessandro@collabora.com,
        matthias.schiffer@ew.tq-group.com, cniedermaier@dh-electronics.com,
        sebastian.reichel@collabora.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>,
        Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 2/2 v3] ARM: dts: Add initial LS1021A IoT board dts support
Date:   Fri, 15 Apr 2022 10:56:00 +0800
Message-Id: <20220415025600.2019912-2-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415025600.2019912-1-jerry.huang@nxp.com>
References: <20220415025600.2019912-1-jerry.huang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::23) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 258b7644-d103-4df0-85e9-08da1e8b94b3
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3770:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3770AE96B8BC7BCF81673C0AFEEE9@DB3PR0402MB3770.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Km5RHK4viv3qgQfPhF/RqzqqgpSUYQP061VU2UcmbxoIXxADwHJc/9z0xZyCl4UeDHt9JxgL/bR5qHEYtr1ny3sAB97XWEjSuefnWpAK/kf/BfALdkGG+tc6PFfs04y8G7xa9OqRWmL9Tg4RzO9so9xCIQysjFs0/P5umJso8qxYWACu7nhl/gkW2gGoImouNFVFvsrUbDMD1Ou+LR3TJLqtAa971bVil2QUdPXjr3Lpuoy0SW/gd31uBF4TlbJt+BRpy9AXznq7N+oVcnbKuMNpB4PaFLF1sbfm+4io/mqn/DgojfOl3alyfInymA4og9olA9SqEnx8fCy4US7doMCVVFg2is0VChuEbFgx5boNaVxf1dtu+Rz2qfKC/HhHwVdlhB6BrfEKvc4HHATjbhEAGQI5dzUCL/hYDt9ZRAki3G9Axqlr3hiz1S9pvf3wiaAVnbydnBNjHX0FAhhLj4I7dm7o6v8aJUGfGzwTumoFYQqauSgH0oGHNFObtz0lC3FLcIQt/IdiCGYSlI7evBmn2HANOq/3cc8hXWiidbyg3gJi6BpblHxrW3Jly47nOVVDxMhqMLvZ8h38jaYkodrvn6eLaUawHdac3LmySJihyDiwaoPxpvgVXvSYCKNTR953xaBu2z0tHovwy0DXWp1MHfarpAZdu78XSiHdBWCVm2RUTdr78Svh9rUclkHnOZ2MMzxi/jBC5P02GFoepsamCWt4a5cU/sV3N8hbLRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(36756003)(6486002)(52116002)(5660300002)(66946007)(921005)(6666004)(2616005)(186003)(1076003)(83380400001)(66556008)(316002)(508600001)(54906003)(26005)(2906002)(6506007)(66476007)(6512007)(4326008)(38350700002)(38100700002)(86362001)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S2sYeoAVopb3GTC73Vscy1C7l5ksrWsxtegZdCDZtkTm3E6s0w0Gqxw/1QJi?=
 =?us-ascii?Q?p0rfvu6tJue3RUwRR9uR2sQFdnkgibXehiyMCVCqdJoiLZcP7qlHi9+tJXFa?=
 =?us-ascii?Q?XxC+smtnrsIot2z8DfZ5cthy1OlNcWZVn1waecMk1R6sYdlO9g6V7bpgV6sZ?=
 =?us-ascii?Q?ZRXtR9Nu1mCjxnb3yD6x9NTBbzeHMCqvJvABuAK/3q0LEJTk/TA/LLuGkxBG?=
 =?us-ascii?Q?TESRslQ7qxWtbM7cJWJUE398oh1bq42V8MTMzZ3tB5u6oOgMTfoO9q+K4J47?=
 =?us-ascii?Q?OiWRlcEiraABQe9bLSIOtKHm1rKKVpb0GBJlXL2DDsgz9R5CsAZcDqUZWvSw?=
 =?us-ascii?Q?4/kwHRT4QP0LZt6v5hhgsH0hTNzh8+ejedZ56+Ck/Q4hMnFta0YuGDcr26RK?=
 =?us-ascii?Q?p407oWdRLWq20cvaa1FylS2NBF5TnG8/GHNpMTDAxmMA8Gz1jnJMOsDJ4Wpg?=
 =?us-ascii?Q?T6dIItJzZJ6KhyJrIaoPonjF5xhWElmV6ekywdT+jfTe2NxuF4ZyMsnm8hGv?=
 =?us-ascii?Q?ltTuS3gUslOdb5PHZaWpAWSnb6qixrpmmuZ9NMXAb36ofxhBnyPGWz91qH9n?=
 =?us-ascii?Q?qgJBCON/Vb/2M4zGRmyvIjwrRT4SQR8zCuf1mVRBAwYVR1IRx6VEJsIjE10Z?=
 =?us-ascii?Q?yTDf8Or8STzfEAeuwTN9o1SGpesylD76RjOieJVLmDVwD1HYoiztolu5WVie?=
 =?us-ascii?Q?j+sKX7ph4Nf0EdwMwB1OWeGNceCmCd+ojVzHn5StrLJBj+nnn4Tj+Ya42GR0?=
 =?us-ascii?Q?6eC1dDZwLtSFQ+BadSW9y1myFyq638hIoQZkL0dlCcRAm/5EjgNe5whRhLg9?=
 =?us-ascii?Q?4XiZpoA/Yxst4YLKpobJoRFdEx+ETWDnyVV+X1qsZ/xWJdz/IDywnz9Etp7l?=
 =?us-ascii?Q?iCx7bRgHRmTXTSH5dA5jBopxMRgTd3dM5YC4bVGGecOWOrFvrSuNAqgGxrOg?=
 =?us-ascii?Q?1jwG/rnngPn4navbbzYNPFQMUKljTs+rT07l3pRx7GpjZMRIsjoF3QlRG0sR?=
 =?us-ascii?Q?30vlYr7ed/PUbmjnagSFbOPioRcg/FBBHMmVl66kS8DbGD1yW6T46HL+wQuZ?=
 =?us-ascii?Q?9jyxMIcqTtQ5doUAV4HjIYMr5gZE5Lh6XhuxxJ5M9M4HgPmW9lGCgxATayQf?=
 =?us-ascii?Q?WBFstjUJOtTI5efs76nHPXMDlGwUcLgqiLQPGAqy+5RSZjVh2rzzLZ5fAq7u?=
 =?us-ascii?Q?rXdezgCwN4NBL/IJ52FxELfWvw9Q/tlmpF8LCVSLFsQXDpiUk8G1SyYlvtrn?=
 =?us-ascii?Q?lf3ClvJqzJs9sHJ2zQfw8r1hm6s4iLqpcwsOLGQEyL/YD7J1BrTvhl33ALn7?=
 =?us-ascii?Q?0g0BkLMPTgW3doJVtKuq3gIDkFc0MzVbvmZZhk05Dk8ORiB18xZHA38/usQ4?=
 =?us-ascii?Q?0Dz9nbbZmpTV/4LRptKwATKUba9sG03TdAvRaofGedGBSkHFpQCUnRZUh2/v?=
 =?us-ascii?Q?sd8nDzuRY2RQ1GYsIV8jjLKmbWFcir2VhsHDABjklBSr7A8JoeGN0OyzJFzJ?=
 =?us-ascii?Q?CLZZBctq4V0/PvMMy71X0ZytbjX0Xr7syRsRDVv1b37/m9dL7ajHyy4EuJAx?=
 =?us-ascii?Q?ofrLm1BtcPpARUkRTTK9sDRRTdAAkKj5tRfq387pblSarmU9NghbDcQhNlzF?=
 =?us-ascii?Q?53Nz+bkpVPWH073NZLiqA9N35BTipkuM1CWKIRz8Vrf9/SWFMydq4HsmsSzO?=
 =?us-ascii?Q?tWBr43yULxfNy8im7P2yRWmh9r9Na7UILN1MPLy4U5d6Vzepln/s7/AQKwDq?=
 =?us-ascii?Q?yeq1EI7x/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258b7644-d103-4df0-85e9-08da1e8b94b3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 02:56:47.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MPBvKR+9IU392y3Q4Tngm5aIS8R1uM09o/TNgx/lqb9T5Bx+/kg+u+I1kkT3gNBclYPt2uxXcGKAGdF2duhzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1021A-IoT gateway reference design is a purpose-built,
small footprint hardware platform equipped with a wide array
of both high-speed connectivity and low speed serial interfaces.

CC: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
changes in v3:
  - adjust to generic node name for i2c nodes

 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/ls1021a-iot.dts | 227 ++++++++++++++++++++++++++++++
 2 files changed, 228 insertions(+)
 create mode 100644 arch/arm/boot/dts/ls1021a-iot.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..e2faf913e313 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -744,6 +744,7 @@ dtb-$(CONFIG_SOC_IMX7ULP) += \
 dtb-$(CONFIG_SOC_LAN966) += \
 	lan966x-pcb8291.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
+	ls1021a-iot.dtb \
 	ls1021a-moxa-uc-8410a.dtb \
 	ls1021a-qds.dtb \
 	ls1021a-tsn.dtb \
diff --git a/arch/arm/boot/dts/ls1021a-iot.dts b/arch/arm/boot/dts/ls1021a-iot.dts
new file mode 100644
index 000000000000..9e5a41880050
--- /dev/null
+++ b/arch/arm/boot/dts/ls1021a-iot.dts
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021-2022 NXP
+ *
+ */
+
+/dts-v1/;
+#include "ls1021a.dtsi"
+
+/ {
+	model = "LS1021A-IOT Board";
+	compatible = "fsl,ls1021a-iot", "fsl,ls1021a";
+
+	sys_mclk: clock-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
+	reg_3p3v: regulator-3V3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_2p5v: regulator-2V5 {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker Ext",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"Microphone Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Speaker Ext", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+			frame-master;
+			bitclock-master;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+			frame-master;
+			bitclock-master;
+		};
+	};
+};
+
+&can0{
+	status = "disabled";
+};
+
+&can1{
+	status = "disabled";
+};
+
+&can2{
+	status = "disabled";
+};
+
+&can3{
+	status = "okay";
+};
+
+&dcu {
+	display = <&display>;
+	status = "okay";
+
+	display: display@0 {
+		bits-per-pixel = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+
+			timing0: mode0 {
+				clock-frequency = <25000000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <80>;
+				hfront-porch = <80>;
+				vback-porch = <16>;
+				vfront-porch = <16>;
+				hsync-len = <12>;
+				vsync-len = <2>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+			};
+		};
+	};
+};
+
+&enet0 {
+	tbi-handle = <&tbi1>;
+	phy-handle = <&phy1>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&enet1 {
+	tbi-handle = <&tbi1>;
+	phy-handle = <&phy3>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&enet2 {
+	fixed-link = <0 1 1000 0 0>;
+	phy-connection-type = "rgmii-id";
+	status = "okay";
+};
+
+&esdhc{
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	pca9555: gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	sgtl5000: codec@2a {
+		#sound-dai-cells=<0x0>;
+		compatible = "fsl,sgtl5000";
+		reg = <0x2a>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_2p5v>;
+		clocks = <&sys_mclk 1>;
+	};
+
+	max1239: adc@35 {
+		compatible = "maxim,max1239";
+		reg = <0x35>;
+		#io-channel-cells = <1>;
+	};
+
+	ina2201: core_monitor@44 {
+		compatible = "ti,ina220";
+		reg = <0x44>;
+		shunt-resistor = <1000>;
+	};
+
+	ina2202: current_monitor@45 {
+		compatible = "ti,ina220";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
+
+	lm75b: thermal_monitor@48 {
+		compatible = "national,lm75b";
+		reg = <0x48>;
+	};
+};
+
+&lpuart0 {
+	status = "okay";
+};
+
+&mdio0 {
+	phy0: ethernet-phy@0 {
+		reg = <0x0>;
+	};
+
+	phy1: ethernet-phy@1 {
+		reg = <0x1>;
+	};
+
+	phy2: ethernet-phy@2 {
+		reg = <0x2>;
+	};
+
+	phy3: ethernet-phy@3 {
+		reg = <0x3>;
+	};
+
+	tbi1: tbi-phy@1f {
+		reg = <0x1f>;
+		device_type = "tbi-phy";
+	};
+};
+
+&qspi {
+	num-cs = <2>;
+	status = "okay";
+
+	s25fl128s: flash@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
+&sai2 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
-- 
2.25.1

