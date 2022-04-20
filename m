Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A247B507EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359002AbiDTCjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358987AbiDTCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:39:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7073C37AB5;
        Tue, 19 Apr 2022 19:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DV/GfVFGCgwthIagB6u8h0cbq5wLXRZe35JKb2N7nF+Kh5LMtyrFVJFWusslg9sW8TRdB2HWJiw++mn9QQDOST5k8y3SRlNFT8MxQCTnoLxONsMsA6m4/V21a2J9BrK5ttObf5NRvIxI9w9FYFz0nYFVn6ty12nAVWXgQSbtnlz/Xsb+z97dJ2nhjH7BIZ0o7LOijB+7zd4zjAeKMMX3w6QKoZgcnSAUMxJA+nTSvvDGHW57bh+nc9TfHHVaZqY/igteUXIdhPmjTdXI+WgvtjItbSkh9YVgbFejBmTobBQcOEpx0by5b+K63AXC5AbPjNrH2mvwFusuC/q+plKKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLxxviJY7sWJlSGWX/3KBEXPh4yNMzE1ufQoS6p3u8M=;
 b=OokAav3yqzRTWwBoKN1nYTpePDeLU9SzVF2cQm2VaPzihgLAPb8U5EyXTqps2tswlLikR6HhtXkEsH0p6okjNjisFzfDGvI0ob1esWwPLHRJxcWTJKwibyFz3d8wwAh/fpAtNUnscRyKcm4qGM/ubWJJ+HvHnoOO9ah3w9PZBQh/+tD2BHnunYTiO/RTdVMRvDM8XM2csgjsPBle5MotI0UJePrzdEuPpuzaEDoUcCMhxycbHul7thCC34LmiX9yZnzCFUjXYNc9Dw/2EPHWJeqMRmsSF1LRp7CgDEp4PHX5V67ahc2QpPTn4hUvmtK4PVa+ixzNGj1cLr6iNfll+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLxxviJY7sWJlSGWX/3KBEXPh4yNMzE1ufQoS6p3u8M=;
 b=eTREz3pjLjzPjreotpchYE8KddspxqtNxCPM3FF4fBVZBXolJhxH/iJ2VFm8LLhKWv8ZpfcaSpFdQpuJp+/BfE9maby/jmHVJeIkrqnyOdTRk6CQ6zn0jP+b67vhKQa85wifQlamozyWxm8/mva6rZA8cbnli89eX0JhrWNGJWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by VI1PR04MB5597.eurprd04.prod.outlook.com (2603:10a6:803:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 02:36:19 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 02:36:19 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, l.stach@pengutronix.de,
        alexander.stein@ew.tq-group.com, festevam@gmail.com,
        tharvey@gateworks.com, marcel.ziswiler@toradex.com,
        linux@rempel-privat.de, matthias.schiffer@ew.tq-group.com,
        cniedermaier@dh-electronics.com, sebastian.reichel@collabora.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>,
        Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 2/2 v4] ARM: dts: Add initial LS1021A IoT board dts support
Date:   Wed, 20 Apr 2022 10:35:56 +0800
Message-Id: <20220420023556.33157-2-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420023556.33157-1-jerry.huang@nxp.com>
References: <20220420023556.33157-1-jerry.huang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15a3e39e-4414-45ee-3572-08da22768c8b
X-MS-TrafficTypeDiagnostic: VI1PR04MB5597:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <VI1PR04MB55978F0FFDE5654C074BCAF9FEF59@VI1PR04MB5597.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuVgl4s86bTz+dn2XNEVAuwhPlTs9ioWeOHYPe/n+ymc5rJDAQFvQK+OIFgstCkb7VmPQr8rbQyZmP562vX5IcLlEmfyWWF+sBsxe9egKUrIaThr8n9VPzWFacgEu2NJH1hHKy0QLY6u0+TgnLICetMmTjjlaNBtz/WtL/+B/D4+pn8bZ2n3h8MqQ/wox738FXDS/RGq6O+WEScf1AuLrHQ76YIo6WbR0n01yRba1HvUK3uYOO66TPSFGpoqnge84ChGQnYKhNChzk4EcHfEN1N9GnCKcJlvOBz6EbTu0oIRaFmq2JkMy9IS8ABGDVtDx6FFEXFrIx33HC02CxQ0PvW55vh7vAeF4z6z6j1QsRE3P7mTVDME6boUmxyn7GD7prhhIhtHwINSuLVlmRRSV1cKIqctAmECH4JKfyBBcEeyLX71FTkBpxDnOoeQHdM6cciBq/lrgp/zKt3XX1ox2F4JqxIASoAhs3Q3LCxnysxSU/WuRH/EK+/1h8g0AlM2lEu4bhVCS5LARXy+5rZwY4StpJaag7dscix/3lb0IP66Z3ZwMzNoCXbshhddPZOha3d3aH5qHoXfwKIOvqbc1nYlxVZZZfZkWazKe6913mUfXKaI1Z8WKNotV+omjvVA/Bmr0i+jAxsmvz6viDB+Ojt615XtL5Q8zpQmzcR46zK9swv+XsWfabSbaVaNBzuBHM1RSxKORjuw9O2DjH6tVFgK3AFye5N3SolhZJLtJ5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(52116002)(2616005)(38100700002)(66476007)(316002)(54906003)(6506007)(6666004)(5660300002)(7416002)(8936002)(8676002)(4326008)(6512007)(921005)(38350700002)(508600001)(83380400001)(2906002)(1076003)(36756003)(26005)(186003)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+szcfs2QAet+ysjGV/Yr4oLMCbvNtH0bCHr0bdhI5gTYFxaXEYM1f1E2razx?=
 =?us-ascii?Q?wP6CMsJyyXPfWB9EWHOqM6zpEVZVcBKqij6MTVgkGbNuzlEl5seqztZVjuFV?=
 =?us-ascii?Q?bG2wlVI16/L81y4JgDG9nZTacv3BYkPYek+XIIkMHkjl84mbnwKUS2twUGgH?=
 =?us-ascii?Q?B62wHISLLnd0zvv3D+S5M8yJ7YOvT+rRhVUNeaBdRVyLsekKlc497K6rXxrB?=
 =?us-ascii?Q?RrJQqZfaqchLC7H3/WpQwIFkO/m1ZHfIzxOI+YJzgLkFZJRtZbNaQSdyp0rI?=
 =?us-ascii?Q?J+QqxqracapghsqBz9p3WCNZlZ0JnT0Lz+kdFGvHqoqkvVKQJ1CUSwRhhF+Y?=
 =?us-ascii?Q?DIBOyu+wn3I+OsB8bnjCKl/ON40XyZXml1N+jLvb41+LVuOZWSn8LTrm9ltf?=
 =?us-ascii?Q?7APoMalGBKDdCbFoIAGS1I1ksgcpWkHYDsOj6/tZyk40CM5skilhDa6ABYec?=
 =?us-ascii?Q?T7oPug8YYe6IRHmT4ddyrVKd+IdShvGCsJ2EcQClspneVDS3zFwn4TnvdPwy?=
 =?us-ascii?Q?ayuphN/x/uXVWILv991BdNyLFaE9/gcxcuiTZYibMiXXZ1rI+1gjKfIyMTNz?=
 =?us-ascii?Q?RFuM3DkLf27K14iSkYQN1LlgFAo3ayBjZiCJrXo6b2ybo3fUbIvQ9aZowFjU?=
 =?us-ascii?Q?+MkGlaVFJLhkgfyVsmJUqDTNKUP4x40NCW8tZ0oYbgwI0NMJQmohfImqc+3m?=
 =?us-ascii?Q?wVZUBIdoo7IPTdN4dtsPdZDjcL4IICnXHYDCNfjGcGcCBuAbL1WKsNaC3Q/I?=
 =?us-ascii?Q?X2IH634knS8z0Y7/8nKRJJiL2iAirmvMI2gZHqY8x9ap5pWQA/xzefkM0HP0?=
 =?us-ascii?Q?LZFr0nvhipKIU4XSVhIvdbI5YLpiV4z6gUtFmMCwZEmE+Zb3BS4L7R88sL+y?=
 =?us-ascii?Q?qBJoCNLVp9a+CiPhTEEv32FDgj2f9VSxXha9F2EUqdCXpJsmH7Ij7PgwFvPT?=
 =?us-ascii?Q?8NFr70xnuYMNwZCqvJdKN+XqSzPlcyktwZdpI722FXzZle+fOTnWcqlSuZKe?=
 =?us-ascii?Q?UVK9e5OUx/Faavt8KnKEoixRNE2asUjhGtkthbipbjMp6ShNJ4GAYKv6+Xa8?=
 =?us-ascii?Q?BWVcI2/8bUSmc3CZ0oqDd95YAWuksBCJh22IwXcRtJTbIR78bPVWJtm/39E+?=
 =?us-ascii?Q?4qu2OkSo4tEoqYbhhFiRfqNlzssi5QSQubI6h5lLNtr1JwgM6vRHggb4SvXi?=
 =?us-ascii?Q?qjzbsa/X+V5nmSYRxMFMM8UloIXmb8LAUFEBPmHIunxQVjPkAIVIEw0ETGrT?=
 =?us-ascii?Q?gChDTFIKzpj49mjuSi5jeKozgIIkw7q7k6siz2xCVV70M+PQTZyKMELy/bIc?=
 =?us-ascii?Q?ZUt7cxzMZCEyZPDaH3V2cG6Rtoy+oAW2yms03Z5K4uPeuBk7kMvuY7hxotyt?=
 =?us-ascii?Q?d1DU8hTNNP4sU0dzd6nT7R75AaZFlv7MVdF603Bsz52YiOqYxVzfVJtG8JCQ?=
 =?us-ascii?Q?Csp4GNbmKNpUdkwMxNM03GIg2UfvRzHp3RCck/mK1SplYRrmNVw7O8XRfkyy?=
 =?us-ascii?Q?LXuCqOz0eDPMwLpdS2fhM7L2xNQXTR9X1vQ10OcCfGpnSdwSirza1D9Uy2Mx?=
 =?us-ascii?Q?8zuRYTOjYc1x05yOSr1KC206gpSZ6voLoC4MrJLpdBAQhzU56Uj8L62C5u7l?=
 =?us-ascii?Q?/83MSAuYPcNEaHgkclpKZjf9JrRMFVLLMwU5V3KFI41kfgyl9WvVknwjNpVs?=
 =?us-ascii?Q?jINFMeOxUj+QQnbiPyTY64npuGGnwRB3fFiw6DiJOTHynSOjDmGoLSQR8Pmz?=
 =?us-ascii?Q?Wo5UdTAksQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a3e39e-4414-45ee-3572-08da22768c8b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 02:36:18.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PDcKhDARVpoz4VART8dgWPH5ZVr32ep81Jhxoz8JaomU5kL5KA2/FoL9tee4jcUs6M4H+hTp1k0SMDfPbwdcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5597
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
changes in v4:
  - adjust node names with hyphen
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
index 000000000000..bdb7186f3590
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
+	sgtl5000: audio-codec@2a {
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
+	ina2201: core-monitor@44 {
+		compatible = "ti,ina220";
+		reg = <0x44>;
+		shunt-resistor = <1000>;
+	};
+
+	ina2202: current-monitor@45 {
+		compatible = "ti,ina220";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
+
+	lm75b: thermal-monitor@48 {
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

