Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EA74FB6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbiDKJLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbiDKJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:11:36 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20047.outbound.protection.outlook.com [40.107.2.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FFD3EF1A;
        Mon, 11 Apr 2022 02:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOJ4it90FUM7o8bp+zrsNf8Fl0GXRtJ2QBd2yaCmHjPBSxi8vuHmsR6gEjQeuTH9eeHSQQsMr+fnjRBNCZJO1BkgY2xF+qiCGSH3HLUBRL3qQ+7PFHZKJ+HOXHjuePOlPwEDg0/yAhh4WKLzU/O81aFRxsIOvOScz4JfRFIIIzyXi5cdsBKVUmGCnO7HlrMhSbGrrNlMz4VDriC7cPZtDyDbSb9/ku6oEqCUZ2iDroOuWDz/Wdpvz0V+j1bCrVrJkvaDDduLcQ0/frtygYoTXEMaYy5J1bp2rUh7u5JkCzDw2vLK9/H3fbn/QX44DofEM/GKQHMbtOvLnxzNZk0VAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL68mWlQI+EfRijJU68izebs5ZbC5qQuCobqc/SuPfE=;
 b=bbhTT093m6yEZE/qyD1w+TS1rQ1PcKJVRoEM3FI+3EL7cRVXyYiUrUWzVwPjhdGzfQMNrQdM3Jvn/ldmK6oBUthAh0ISEgophPtbn0XkYQFNhD/3px8TN5Ddm4H6Z2FwHcIh5GErUq+/9UoTDdqao2MDMA1/jw7JhH0OF6saAEcu2Z9hfSLDy75yHfojdRhJ+jspsQsWoh9P6Ebn6q3OPlRuQeSNZS9Snl5r6wyi5IWMQtzwpqXYCyu4YVagm61FpnmCakZvqA9nIUfZp8XlXQ4vQ59zPn66Am0jW6B02aaD7W2sXZA3XhdmRi6FQdT4OxDOb3c5//ieNcUrR5wGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZL68mWlQI+EfRijJU68izebs5ZbC5qQuCobqc/SuPfE=;
 b=rMPkCfcUwNEHMPUt53KuPe4xZvTek+OgtcvLm+9WKA7CCXBJttshgC+drtqAhh88NHpFVt5UCFLiv4LwU96tPQWvdVDBY04j307wraRkGHrz1dHUmvOx/h4W4i2O9wPe69NpBt9eFj1sbHh+pwEVO1B7Td5wdOwdfJFImOy3Lk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AM7PR04MB6951.eurprd04.prod.outlook.com (2603:10a6:20b:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 09:09:18 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 09:09:18 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, shawnguo@kernel.org,
        festevam@gmail.com, l.stach@pengutronix.de,
        alexander.stein@ew.tq-group.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, linux@rempel-privat.de,
        matthias.schiffer@ew.tq-group.com, cniedermaier@dh-electronics.com,
        sebastian.reichel@collabora.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org
Cc:     Changming Huang <jerry.huang@nxp.com>,
        Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 2/2 v2] ARM: dts: Add initial LS1021A IoT board dts support
Date:   Mon, 11 Apr 2022 17:08:28 +0800
Message-Id: <20220411090828.1965450-2-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411090828.1965450-1-jerry.huang@nxp.com>
References: <20220411090828.1965450-1-jerry.huang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0023.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::28) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdcf7e9d-a9ad-4794-a13b-08da1b9af4ff
X-MS-TrafficTypeDiagnostic: AM7PR04MB6951:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM7PR04MB695192790411845612FF38E3FEEA9@AM7PR04MB6951.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jhsc77kWETM+vEnLT6O9v9YvQYWL/7wUQS37L5YzW8C49m4LIOHxjBp4dGSPyIT5MSMDTIyhbPaecbT7VFOS9eJpaDxUBwE3azxzTslF/OJjdLfjK5d2aZTsg0YnkEfcoIPxsvDSO1DKm2oIeTYT7khd8dL/wLWQejy+q5gBk8FC7BxMvPR3mPSXNMPORY5BOD7SVZVLNq7iSuDiFLdKujDL/2w1zPm3R1bmNwdtbOE2G0blfkLJWR2Om7MfHbVpmaDsAyenjDtLP+4Z7OH79rZPJQni2kIHOb4BdZu0V3PbFixxv9S8VY1NpqVXWVSpGPHwexC5FR4/emoqoClVQ1ZSuFqbdbJ9B8xMyyz+yXtUaowhzXBSugh6d2SodPOl4mz+AUkudp6ptFfQJB7+bPVy++HajZTONxaZ+51sUe819eM7hKx+E3ZNW9USTxgMzfkeIiJambZul8c1GPt5Wd974zn/Vs4VY7R2x4iJfB0SW8gwliNSHnmTZ4sQTEZtLN+bRqHZ1ykaUyoGfmsA36A1w+aYgp7nSbWQ7Nm48TPIecv7siRTewHCNNbZ9oi1sO2M3z0q1ZdQk3jHLjtIc18eManTy0Gdc0NbqiQe9M5bfItQlv+x8W98pOv0KVikTJMX4e4JSj4DvmGUJPqmazyi/pi/HXGebJGc6F9K0lt4/SpbMirraMF7XrRia+Ah0HrMnTK6aWFKxWvScIE8xiqUrEnMCL7RdMEeTUKff3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(36756003)(7416002)(2616005)(1076003)(508600001)(186003)(26005)(38100700002)(921005)(2906002)(38350700002)(86362001)(66476007)(66556008)(8936002)(316002)(6486002)(66946007)(8676002)(52116002)(6666004)(4326008)(6512007)(6506007)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xDWJmte53a9mpMSOU4oyMNLuChs/5zZV5DSF+HKC/UihscZ+kzqcB+8WvRbR?=
 =?us-ascii?Q?W3Ls2zQnvxkxHHQo92mihb+DX+RDa2pL5H9H8OKFTD3n+QrnQ20NXpXZXkop?=
 =?us-ascii?Q?wQwSNYaKRr7kpw6vfyyhq0t+GUKhqIo7GqnmGILuHsdqS+1/YESA8g3RH2C7?=
 =?us-ascii?Q?tithD9sx5T/Qc2qcwthjA64eiUSpYxsFepYRiWwiZ7N0U9Y7EUmDwLZQvZ6l?=
 =?us-ascii?Q?27ijgSCyhrsN8XE4uOF/XpSKPet2n7jfsWbLrnpVnZ4c8onu89E/Zcubn2m3?=
 =?us-ascii?Q?RyY0lTCBH0X6x2cMWjqXRDQuD956Xxcgt7YJTzlx7kQ1gBeuHAKsrzTxj3WY?=
 =?us-ascii?Q?TG0kW25Z6W7f05PN5SfGvfzdNEablhuqELHdm0V8pJJeurcJH+3fvgwDtsgV?=
 =?us-ascii?Q?eF9+llZUVYRr+p+zL9kSXYH7135J16GXS3EWLM0+/aszbB1GzLpXJwEMxw6s?=
 =?us-ascii?Q?cvZO1aYZ7A9ei+t5sKRz4x3NAHCBFTrdOEStOQNheaE1az4BJbvBNy7FcB+9?=
 =?us-ascii?Q?jyXfIKyVM8d6uRp5mwJSIJ3VCP7+ty1BkIyH3NLXNxdRWTJSI8Ds71g9hb+4?=
 =?us-ascii?Q?5w0bGgCq3nhWc3ztAj5qJa7PhVxh++sbgJzhA/gKTAZ0MXiMK360qt2+g9M2?=
 =?us-ascii?Q?0rk1CNeXmWDkPS7eaaEO85ftabqmpOB/Nh7fPgrI5XBXjk2eky0Tk60TkmpN?=
 =?us-ascii?Q?wZTmo/fhEieuTmLT2taPpIotEZ7X0bU+JA9al8jZjyXmUTfWIz3h8XaNxtgy?=
 =?us-ascii?Q?7dwK5Jok9WOzvDjt1VtDNhdyaovudXVSG8WgLumK2tW7olrhX0r956zVXG/4?=
 =?us-ascii?Q?do18dyM5QXaChOthqefsg9zz+yQ4CmzGYVyM3zCGvztH9LcJJnP9ru3xdmaw?=
 =?us-ascii?Q?SruI7PePqsNEeTOQn7/pMMFGxD40ArgS3i/eMLHhMGC3WmJAGui+DoqUWVVw?=
 =?us-ascii?Q?XOqulE+TU+O9bLhoanlnH6dk5TUF32CwOJikzcqosgsqbGwJCzG7i1zIHgRZ?=
 =?us-ascii?Q?zUSm6WJ1LQDMMSdt+ggv+JBidOsoTpiTvTwBW3HWjMqAhjdjk2zpyeLTJE/v?=
 =?us-ascii?Q?amZTvPxn+/dto1VTcsSlbq5iywko8N46k5VbBmXzwcnAK4wf6S3GfAC2ZJNQ?=
 =?us-ascii?Q?ch3LYXUmXnTamawmQYu7pbQ7wSCuYIDPyRnDAeZE+fKghZ6QFeR/jvifUVkx?=
 =?us-ascii?Q?C61P+sV3Kj/vybcrLsWRB1kvDii1VEaod/1IqUAnXuQnlMk8TA1wWZlaVpPf?=
 =?us-ascii?Q?Cl91dbsPZl5RNEDGHqSUgcZQQM601M9mG/8nux9fn9qo63/Aa2At5tlfYGp4?=
 =?us-ascii?Q?Vyz6cUnyMgW8R0K2zk35F3+1wJ8QzrKcnQlWJO3sL2LcZYnE+d01BEWaerSd?=
 =?us-ascii?Q?GCoOLqkQ9ko12yNhDKYYOJsmd8CvpJBy+0RIBmPr7uaZawJm7oI3TudXLKrA?=
 =?us-ascii?Q?rG2z0iG5Q39h8u5gW+PtbuL1rEqB4PN1/BHE5l9sy5aPM6wChnlncJ/IRoQ+?=
 =?us-ascii?Q?XEfKNJzjsWuSZVOsY1Gm1S2c9Q3317b/p+9zX/DZfByS6gAEj9W0ppTVpU1C?=
 =?us-ascii?Q?0TYrA732DO0twnLp54pTyj4hOM13I4Ju0rJBt4scQQI2Ws3mziTSK4seJbZD?=
 =?us-ascii?Q?FGqXFX9oxU1RG68hBe6XFmipDdppR0G4OL+mWkB62lkkRiaCX0Ga39TmVHE6?=
 =?us-ascii?Q?ObO6hNZFpVFYxyJbpeiJIeS6v+sYoXRlH4ClRR9uFO2HGkgnR2QAzqNthqUM?=
 =?us-ascii?Q?XZ3UcUiUXQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcf7e9d-a9ad-4794-a13b-08da1b9af4ff
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 09:09:18.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+fKJSOI9ApMT7/g7kBM/su7O85XFTcBwCfLnHOZHvMh3rdwRcK8NsbzkE6ICcg6rZcfMC47YO/5hUvwQ4bVlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6951
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
index 000000000000..d9b56a197284
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
+			sound-dai = <&codec>;
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
+	gpio: pca9555@23 {
+		compatible = "nxp,pca9555";
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		reg = <0x23>;
+	};
+
+	codec: sgtl5000@2a {
+		#sound-dai-cells=<0x0>;
+		compatible = "fsl,sgtl5000";
+		reg = <0x2a>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_2p5v>;
+		clocks = <&sys_mclk 1>;
+	};
+
+	adc: max1239@35 {
+		compatible = "maxim,max1239";
+		reg = <0x35>;
+		#io-channel-cells = <1>;
+	};
+
+	core_monitor: ina220@44 {
+		compatible = "ti,ina220";
+		reg = <0x44>;
+		shunt-resistor = <1000>;
+	};
+
+	current_monitor: ina220@45 {
+		compatible = "ti,ina220";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
+
+	thermal_monitor: lm75b@48 {
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

