Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C16C467099
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhLCDRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:17:08 -0500
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:48001
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230402AbhLCDRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:17:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq8ZUkbR0DkRaBQOe4z+Sk56dvb6Pg0xehtunRpP9W6a2OSF0OrBP2gK9VSELnba86hOAUV6ay2uvx5vPHpaIvQEUTHrdIkGDHG/YwJRTf9SNVuYjd6gzntPE2AKyxq61yCY0pxACgxPHI+cdAJmR+kvHLQw8Dr5oy3vJGmEU7S1DUOKnRpjWKEwWSmYzkhsuwo0ZXl7QH7GIA8s+Bn1kpUZ8pWfL6lW4YmMQt6z0osQB1aYGWTwe0epqN3wR9ofkj6HEWPhkNyyzOxx/gkWJKrlL+rmohaLae8Bmg/U+NaujqlPXheC3emzi8RNJWJai4UF78A+Yl+8Dl/FvxYQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuiewDApgLH4azZN2g0tQLulvNIX/G/CYpyjmD9UCJY=;
 b=cnE8trMKxKM5XUFNGKpTcnkVHe1qtFlwmEt5tZ81hcVirOGgX1WVOr5WCX1PhJ2x9Fg3EfpgEAxxcuLCfqMhx5ZDR1nwfrd+lqMFcqwLgBJAYQM8J7d+qmEp69eeNXub2D7TClJbvzC9SdMT9tCcyjePLIyqXCAXRZDnV+5eWUGRIZz0rVEmvN268bVcefkapcqj9B0+UvqOXDlV/nvZgsTRP/sgoPJQuFYgKSnaxve/OrI5nQWn8XLW8ndZVqF53OUbTUHYLvwUjPcORFhYRRr8PFm7ryfVUIGTd3NpPQdbOmYmxExhf43Qzgr+z+AU1AL0r4F31HqhOw1/nH9dZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuiewDApgLH4azZN2g0tQLulvNIX/G/CYpyjmD9UCJY=;
 b=QXhtFin8Fvm04HggfFVKghWQ8VVYoisyVzKQktCVrLRN7pxIISWVS3Kv5M4dEQEcKXJxee6Di0Ip6nzEzdeRD9aeCw/PMfM0Blqa0q3OifN2sENGsKbAPzS/xuQYEhAuBwS463NwKuIDkN47FYm2bk0cOHALf5kWT4BZbRFidk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by VI1PR04MB5328.eurprd04.prod.outlook.com (2603:10a6:803:59::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 3 Dec
 2021 03:13:42 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::556a:6dfd:dc0d:c407]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::556a:6dfd:dc0d:c407%4]) with mapi id 15.20.4755.014; Fri, 3 Dec 2021
 03:13:42 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, krzysztof.kozlowski@canonical.com,
        linux@rempel-privat.de, festevam@gmail.com, tharvey@gateworks.com,
        marcel.ziswiler@toradex.com, jagan@amarulasolutions.com,
        dev@lynxeye.de, cniedermaier@dh-electronics.com,
        sebastian.reichel@collabora.com
Cc:     Changming Huang <jerry.huang@nxp.com>,
        Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 2/2] ARM: dts: Add initial LS1021A IoT board dts support
Date:   Fri,  3 Dec 2021 11:13:32 +0800
Message-Id: <20211203031332.902485-2-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203031332.902485-1-jerry.huang@nxp.com>
References: <20211203031332.902485-1-jerry.huang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0017.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::22) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
Received: from Ares.ap.freescale.net (119.31.174.73) by AM9P192CA0017.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 03:13:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2825b8dc-d5a1-4ecb-755b-08d9b60ae886
X-MS-TrafficTypeDiagnostic: VI1PR04MB5328:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <VI1PR04MB5328D6C4ED0D73432EEB36FAFE6A9@VI1PR04MB5328.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHOzemjnYYlWNMVrRowOyzkHhFS5NSuyyDnxJZtqQorTS2GwR/jrHDrhXnDquCoVGSdVAR9QpA3oRRfwo+rgUYBSBhiteucRsDLtwdjHc0QB4BKB6a94e+qoMORgc6Y5zErFMMTUgO79Qqu5sR0vai23dZzAhIQc2mnYjmpEwNJ+j73n6CSehNTXCBJCBx6mxGKIy9Gggj5md7Y7ETH5haX6VKvrtNoCTywOjhZ7Z/5CguPEpt8y55WOPykj0A9Lvtea9mZhyn/VZ/vpwbrmG6cbVxWcqh6cwAIfYTnuOJ0fpD0ODeYLDMsvA8ZhQSBmLueUG3P4bkXFXpla2mNkqjlgh+fuCfYG+FvtkzZPD/MfcbLSjuUllnaU0o+byMf8WP5nAM6kpteIhBygtGdgeGWv5j5X+mmB3iGwZlpYJIqub+cH0JxvZy2V0QsQTADZLNe+/veELESl463tTFESWAkDMsMnZc0CFHYEvonApgDSgoVJvNvvArI4AuG1I/Wcg/TvGmT8uHPAGWEFqxuhGEnjX3mX1UpyCDrfoi8nbbgVYzhcyMeLDBwZiTEavIRCEJ4fFljtR9AOnTy47d6f2QS98/+AvQYSROSRT+waZquUgIpke4RIaLeUS6zw0qOkYmOGIYeijVq6/V62Cf3y9SUvF2LdWxLfAaS3txaOod6qxOhVTQWuc9s6oe6xAo4VvHR+Glj6L4AgzYWtHL05CR2BKEl+txJd0cuy/ytdgu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(26005)(54906003)(66476007)(7416002)(83380400001)(66946007)(956004)(1076003)(6486002)(66556008)(6512007)(186003)(2616005)(8676002)(508600001)(921005)(2906002)(36756003)(4326008)(8936002)(316002)(6506007)(38350700002)(52116002)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARd2hwZhF9/N14H92u+/pZYZYv0eixEktGq0d0xOHML/wuNGKCqhiRMOUYwk?=
 =?us-ascii?Q?EXzzDqUuTAb8bK2Q7G/lTJipz5RGLHgKI8oPo3oY3HSAKX9jYhQmQIOkXKCC?=
 =?us-ascii?Q?Eqb89RwyQSb3GfaOQyPk2pRCLXENktymoTFovtQu1iXxshsA9Y8H2d4sBURX?=
 =?us-ascii?Q?cYSMgu91lEo6yhYGkAilU3hPRfteuCHldG7UxlXp9BVU+CK511i+Yw/L+HlF?=
 =?us-ascii?Q?1kW7cN2vwp2KjkmLhV4OtJwQ4mSN+oEfZBd0C0B577YPhy5cCN98QP+I/6RH?=
 =?us-ascii?Q?lCBR6ipaWLwg2FjLpKLSW/BetY1xFpm/wPqztmy5C+fL3Hfyjj79tsk4ThE/?=
 =?us-ascii?Q?OZMjVIICZhV5rNHGkSmZI85zWRTyUUZjeaCRHKRBf3+QFB92Rnj+KMB2lQ4B?=
 =?us-ascii?Q?ujvDzLmN4x0F6ujwZpd4gIFy/+b6izPW6+g4obqEpMkgMFdtvji5jmeUVy8P?=
 =?us-ascii?Q?+1luJeP9SE72wVnA9g7LJFqmuo7o/4O6wL/zCDh7PoowIvuyUGDIfQWBj/tS?=
 =?us-ascii?Q?4rMk4tC86V5kmrD/DaE0UfZgFA5qAwkC39ktxwy9wN0+PwwJAkMqUvDXHExs?=
 =?us-ascii?Q?qZJ++zX5sINWeOb0YANu53ylObWMf+h7Cdtm2+aR5/pTlwGg0cKW5OV0dePS?=
 =?us-ascii?Q?wBu/GTZTyg2wqrPRfaaQGsJkm0knfHupDQ1nEgN163uAg4FbDkq8uCuWXIuF?=
 =?us-ascii?Q?ZPyukdJzOaY1a8aIPWyOasQv1DCzSn2SnKngZibkIWiKaRZ2OvSwqyusaPiz?=
 =?us-ascii?Q?4ukCV19OTQLxSSH+jVsxXcvyNRM1eAN+CwFonaBqMV+xz1yzG5hLf5qfIPCw?=
 =?us-ascii?Q?uTwPfLERJLGMcG53FdPyU3d4K4PwGbsCMMpBjwOPl7rGpZvXIsVtF0Y5yLyp?=
 =?us-ascii?Q?gX1hY5hv/PKkrl3EI9Y+xjHjKMx9/Vs6JtbqytEVUTefe0/nrFgPbGcj3iOJ?=
 =?us-ascii?Q?jhHF19uaAjEj3qpKQfIzvjSHpWYcYymPvdDc02vpNOBLV77YmALoqASXHExI?=
 =?us-ascii?Q?f2SDvhas+EWSwRl7megsDMFVN7dApL1ARiXOxI1t96j0TYNDG/7peRkLrOFq?=
 =?us-ascii?Q?1GarjB8f9/iw9gJsvDrHj2PPyH2lkK45One59aOZRb8PNPvrUlS2riWB26aL?=
 =?us-ascii?Q?/1vUcirAIlqbW862hwxYZrv5zxsHaGyP30r+TtRyt0h5679BbZgN/ocEmPkk?=
 =?us-ascii?Q?8vezvxDvCQkG9fvFtVRNiu1deINFN4fog+3+yb+V1JF3/FJtKnHjx/Ky7DGs?=
 =?us-ascii?Q?+DojQmvcLgo2mdkxOrBeupYalO/ZAPxJp0LfhI/MOqXRNvlMe6mt40S81tBI?=
 =?us-ascii?Q?F/v2szWQgi2wapKYqDuCyZbIpGWVhBXpGNmXUpXC1bXbPZvkJo+X16VkZ5Dy?=
 =?us-ascii?Q?hmBlxCGNWZmA4tMBVhpQEAaIXaBQbTWmO1HrtjkoRFn7QkUPVSky/h87Yixq?=
 =?us-ascii?Q?4gL3CX8R6sfR8wedQkewrT090qW/b7HnC+jwNf91YK+QB8kDtk/QquSy/LGx?=
 =?us-ascii?Q?YOE5sdqdiRZ6f6sPzcUgfG6j6vMO8ep+n72lfFk7vWK9zypD1ijG1TnHPbo+?=
 =?us-ascii?Q?u4aqj0Ola94An2dVPYoy0C8JEnMPQ7G6TL7xCBeJ3HF74l2y70siN0xLlcNn?=
 =?us-ascii?Q?FWfWGG5mE/CgLcJ12F+k7IY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2825b8dc-d5a1-4ecb-755b-08d9b60ae886
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:13:41.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XseffE5/EcfxtCHxs9B89tSd7K+rQvDg1SUO8Pz4ihEzC2V0kSi0FXvXEqle1v9YTyfpcncD0NonK/N7ypgphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5328
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
 arch/arm/boot/dts/Makefile        |   3 +-
 arch/arm/boot/dts/ls1021a-iot.dts | 248 ++++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/ls1021a-iot.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0de64f237cd8..8534f6f94bc3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -727,7 +727,8 @@ dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-moxa-uc-8410a.dtb \
 	ls1021a-qds.dtb \
 	ls1021a-tsn.dtb \
-	ls1021a-twr.dtb
+	ls1021a-twr.dtb \
+	ls1021a-iot.dtb
 dtb-$(CONFIG_SOC_VF610) += \
 	vf500-colibri-eval-v3.dtb \
 	vf610-bk4.dtb \
diff --git a/arch/arm/boot/dts/ls1021a-iot.dts b/arch/arm/boot/dts/ls1021a-iot.dts
new file mode 100644
index 000000000000..47ad718dc542
--- /dev/null
+++ b/arch/arm/boot/dts/ls1021a-iot.dts
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP
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
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_3p3v: regulator@0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_2p5v: regulator@1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "2P5V";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
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
+&esdhc{
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	max1239@35 {
+		compatible = "maxim,max1239";
+		reg = <0x35>;
+		#io-channel-cells = <1>;
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
+	pca9555: pca9555@23 {
+		compatible = "nxp,pca9555";
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		reg = <0x23>;
+	};
+
+	ina220@44 {
+		compatible = "ti,ina220";
+		reg = <0x44>;
+		shunt-resistor = <1000>;
+	};
+
+	ina220@45 {
+		compatible = "ti,ina220";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
+
+	lm75b@48 {
+		compatible = "national,lm75b";
+		reg = <0x48>;
+	};
+
+	adt7461a@4c {
+		compatible = "adt7461a";
+		reg = <0x4c>;
+	};
+};
+
+&i2c1 {
+	status = "disabled";
+};
+
+&ifc {
+	status = "disabled";
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
+	qflash0: s25fl128s@0 {
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
-- 
2.25.1

