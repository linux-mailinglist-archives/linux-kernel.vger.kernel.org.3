Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E798E5AEDB0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiIFOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbiIFOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:38:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF3E7E00E;
        Tue,  6 Sep 2022 07:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKU/8zEjYe2X+iCHA0e/ClcuxygFcnRY3sYM9mmSnhV9pJyg1XEGD2i8CHlqZL0RHGQfdPEzDwaQfWiY1kUKNUMggZBPa9uYayWjHzuaDkAyU6zwxFJLPhhhYu2nwLIXRt0YdGb9+A/CFUFLNzhWT92aZGfEjGwzSFTojcR3gxPnoPiYy5z0Wsjf60iq1Pv01dz9gApaWRMi0AbLkgToXAIEzIDNYgU1rSZkgm1NlGMXCcwF4D92og0CgYW3PmzOJbW8wevPjFLr36fv9iSG80lh4Q/WyNoTDJoFHWQhhFaCdV8jIRIzLkOwsfpK2j52F+o3eZkdh991rK94yNGD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPNERYjPGhAdjhyZDco9ML7IVxH2tLGiq4SPkPsDxso=;
 b=hm1e3k0Q1tmpcIoZb7DcHZ+znmNXH1Hx5iNrjcHRh/TLlkh2ot72+W3jBV8T4t6kJEn7SvH1nDq76Dia9akKNfMUaAjOCTCdriEUe89nvnsglbYVWa07Rh6mfAlORYsKR/hHRU8fJxcymt/60ACpYx75ETDZEOdHzTy3ZxHBKpAEck72EfknOrqGYTkI7GArOslBYk0ZFIq4hcbQqkaPyD10BVV0hjhEXv+dtBpEPfS76FMMfoGHkYug/vSKg+vrVYPy9BVpxl1qxwB4oPcdSdquSdTlHTH36H/rPx18j9VB2M0OLWzaUNuQS/7KmaNxMwcqUyCGnmpwAceL8daf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPNERYjPGhAdjhyZDco9ML7IVxH2tLGiq4SPkPsDxso=;
 b=ISdssUAAOJPtn5U//5niSHqopSYN2sL5KNoxeFlKCeDAG1y1F0S9/DP9EgSEXk7UE8uPw4W4vnZXqUseEO4G2/e93Tf9HOWmNkO4GXCb3EW0zlyPOlbN3PwOQoo9g0+EmZTSI1Fbr4qUD5Xj+B6v/di15NIhMLrv/YaxBGV3wSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB5181.eurprd04.prod.outlook.com (2603:10a6:803:62::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 13:55:51 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 13:55:51 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Denys Drozdov <denys.drozdov@toradex.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev
Subject: [PATCH v7 5/5] arm64: dts: freescale: add support for i.MX8DXL EVK board
Date:   Tue,  6 Sep 2022 08:53:45 -0500
Message-Id: <20220906135345.38345-9-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135345.38345-1-shenwei.wang@nxp.com>
References: <20220906135345.38345-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::18) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72ce3571-a959-4fae-18ab-08da900f823d
X-MS-TrafficTypeDiagnostic: VI1PR04MB5181:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQwptIpc+qVxwEJnJwMhu6pvsFmLTTcY/Nwi8LboZIyq8r99QNzUUJ81LhAx+8kK1hVPf2l+9UL6ARL6/u4hYcV0+tqYxuAr/dfe1eb/YtKIPefTQbjBzpGNd2ZxuSWg0Hqr4UwxU7uXaaGfKwvnE+RAfqnleVSDu9xPOLCGyWg7VyEe8SGjGqGtWVupQM5sezg9ABdUb/zD1LFH9AtV++LEJ6azEba4hGbnuj7j2Jhx37TV1AMtGeZyLnO3O3a+r8//ySS3NRReZ9Oh91DEkVukP5IeVaNy5B/kYvkqoIFdLI6HbDGCBOsA/ztp6Y5RDuehPAvCjY+D79ANCXF6m7tzVzRsXDzw2puPM3no9fbx8LbcTHCcwSLFZfjSRnZWf5CcLcm9wSqt4ck8W/B+qzEXh+c7rtJ9BZyusJxMmWDHJKEkNtrFlP7Nx57Nnck1pe2NI4skDezuo9glFdNQwsmjwjZEQxckm6CjUrma4OQ+EScXRAYOJY19SNbTo0Jn07szBlTFQLq4CmtFUeHuAIC341YKgym4NuQTwRCatoxmmc2dlaEaVIpqh1jYvbft8pgeP3Aso2MSctPgQxyb6Y+rNRAgm0DDKoNQPXtrCOiOQzXRLgRBNx4vOYNf3Y1pE/gxwwMayboQT85DXA7M6cJLzWjpP32zDPpwBKUZ4SCWssk68nJaC4SwvQvp1fzp4itgbhKquj16jKUr37uD4zMNeBhDq5CIR47HU0uSEAoJmPy49e1PzW4j0xG22mDlAs6e3ojVip0BuU16kmYZGEGIPoWIxpSabSGwFj+RoqlzJiXxbRcgdJT+waFdIZTi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(8676002)(4326008)(66476007)(2906002)(66556008)(66946007)(30864003)(44832011)(2616005)(1076003)(83380400001)(7416002)(8936002)(36756003)(38100700002)(5660300002)(38350700002)(54906003)(110136005)(316002)(41300700001)(52116002)(6486002)(478600001)(6506007)(6512007)(6666004)(55236004)(26005)(186003)(86362001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MUJvc7Ahlb0nBCqlhQG9V0UpwN+aIp/iRkAXrvk6+4EjV7GoiFWM47QS47L0?=
 =?us-ascii?Q?MaiHHPzoV65nFGjxWVx3LwFAzSIKQDbCR+GvE2Im39Iou+ZTEv2uikahIdA9?=
 =?us-ascii?Q?yHQ97ceFcJ1HXfmiGTRTxogRtYujVTp8hfqJ7k6Oh2CDtOvji7iKZogCHrzf?=
 =?us-ascii?Q?MMKXzcsqPORjHmqM5b8gcs7WSX2/+p3+JbU9j4xAkJFekh+/oY1wklUPIpHV?=
 =?us-ascii?Q?9ns/wJ4EfSKP3qdjLyC8EYdBijrqw4egVzJu31qPWzqi3EQpLgd3OR0Yl4zD?=
 =?us-ascii?Q?yP6mFs7c+Dn16vQlygESYfDScjVe4WTDGh3o/D7+0Bie3IgjIBl2AYexHUsX?=
 =?us-ascii?Q?BBSYZXdvyCmX8d2gIcWYVcO2tauMxQTHTar95GGk2N9YQ616QObgy4AxSnPp?=
 =?us-ascii?Q?eZNkpT5r7ZPQaEy6dLcpW8LkxAiDm8u7xnzjhCH7meS/T0EZdg40GxmJ0gy3?=
 =?us-ascii?Q?X8zBeQX2jhq5j064uTvIYV2OBqhr+5qCKjAZmPe2Xf+CRQhMAlUWEX4on8Gt?=
 =?us-ascii?Q?vOC5UspjDurru6aKDN0e1+QDnetuhhGyHcH6xme78k9KKHyfdSCcddJc3kQk?=
 =?us-ascii?Q?sfbS6Um/D0+Mosr0dtq0X6Gl+nQNWkz8TtfpTh5lCFXB8eMx/fukiLPueWIp?=
 =?us-ascii?Q?74tUQOaXROl4kF3PE2hKI3+m2wIzfJaKRsrp+T/7RQ5DJAJ5i+mhMMwGDVP1?=
 =?us-ascii?Q?QktoVyBd7CO/NIprHV0LtUM17XHA++7ETgQsi+EfOw46rzehrXyK+LNPy8lE?=
 =?us-ascii?Q?rXpnPAcVRdSNYcUXj3ogea28x1Y2jxHzaH3oT4kKzaXxIs4CU80NisAAG4Zt?=
 =?us-ascii?Q?IjMc34tvRRD1jJ5SukiJykO4f3K1DOAvViF3/1/Vn5E5TdspiORi1ue7ohb2?=
 =?us-ascii?Q?X/kyd6c/cwO+ZfMkn0InYTWuNurloncElIyG9vDX4KawUuoDPAGX7xt0+PxM?=
 =?us-ascii?Q?56IPgVOARjVSBhhQ0p8kpMvtNjYe4VgindNGJ/ZkZXpvLkM7oszxZCKiTMSn?=
 =?us-ascii?Q?/V3taTPZD83OC0u02BYD+DokH+TOAdp9+yfPys29o5kQ8nkp2eopaisZA8AY?=
 =?us-ascii?Q?JWxoRuYRdgO2J6hRS4InPrsRV3YnVnNO8WxAoWC4r10vb33x4Ho6DWmGgxGy?=
 =?us-ascii?Q?SZDmm+cCEBbxbx6GwCZh2FCt5y37j4vqfIsKatRRT7arS0mIQeDBjH8AIedG?=
 =?us-ascii?Q?rWUOSb13gIKGv+EkA5pZns7ahe5lVDZSbcCtvcraKCg0Ewd1QAzYqT411ovk?=
 =?us-ascii?Q?jBfktLCtmGLiIbKRa6irmSlFdFY89q5mwPb0Ua7U9TWUTcbWsAFKzluRR2nx?=
 =?us-ascii?Q?rVkmvZwx8z9lZc45DnKhrtPm37JT9x+Cy20TZiIipRnfFu9833MiHmADSQCb?=
 =?us-ascii?Q?GYWz38lAkCcLd9fnx5n7Zb6WQykQ/EYTGqzSGcAPDgDNkK5I+ltTBreRLAyL?=
 =?us-ascii?Q?5MyApphAdUvn3aYc6YMs1CJZMC92xL9ZV0tdSXf4vM4j+GF2v5rMDRL/n80j?=
 =?us-ascii?Q?wQqxxqcKLVyMTpxmryjOvXjTzcYlKxsNptuWhwjb8fhU96c+6b0kEUpvogQH?=
 =?us-ascii?Q?PjJvh+w2aHdetkJh/9CYbtMnwjf5gKPV/WFAxscz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ce3571-a959-4fae-18ab-08da900f823d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:55:51.4040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQ2R2UGfzfQ1y2ONGYh6vB3cp/cAS5wJInJKh+lp9SKn7oJeJEXKfjNZU5eepBZBvsfngEFyBD7vp6rIQfmpbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to support the EVK (Evaluation Kit Board) for the i.MX8DXL.
The patch has enabled the serial console, SD/EMMC interface, and
the eqos and fec ethernet network.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 426 ++++++++++++++++++
 2 files changed, 427 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 8bf7f7ecebaa..2741205efe84 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-85bb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-899b.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-9999.dtb
 
+dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
new file mode 100644
index 000000000000..868c75945af3
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019~2020, 2022 NXP
+ */
+
+/dts-v1/;
+
+#include "imx8dxl.dtsi"
+
+/ {
+	model = "Freescale i.MX8DXL EVK";
+	compatible = "fsl,imx8dxl-evk", "fsl,imx8dxl";
+
+	aliases {
+		i2c2 = &i2c2;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart0;
+	};
+
+	chosen {
+		stdout-path = &lpuart0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * Memory reserved for optee usage. Please do not use.
+		 * This will be automatically added to dtb if OP-TEE is installed.
+		 * optee@96000000 {
+		 *     reg = <0 0x96000000 0 0x2000000>;
+		 *     no-map;
+		 * };
+		 */
+
+		/* global autoconfigured region for contiguous allocations */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x14000000>;
+			alloc-ranges = <0 0x98000000 0 0x14000000>;
+			linux,cma-default;
+		};
+	};
+
+	mux3_en: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "mux3_en";
+		gpio = <&pca6416_2 8 GPIO_ACTIVE_LOW>;
+		regulator-always-on;
+	};
+
+	reg_fec1_sel: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fec1_supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416_1 11 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		status = "disabled";
+	};
+
+	reg_fec1_io: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "fec1_io_supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		status = "disabled";
+	};
+
+	reg_usdhc2_vmmc: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "SD1_SPWR";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&lsio_gpio4 30 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <3480>;
+	};
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	nvmem-cells = <&fec_mac1>;
+	nvmem-cell-names = "mac-address";
+	snps,reset-gpios = <&pca6416_1 2 GPIO_ACTIVE_LOW>;
+	snps,reset-delays-us = <10 20 200000>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			eee-broken-1000t;
+			qca,disable-smarteee;
+			vddio-supply = <&vddio0>;
+
+			vddio0: vddio-regulator {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+		};
+	};
+};
+
+/*
+ * fec1 shares the some PINs with usdhc2.
+ * by default usdhc2 is enabled in this dts.
+ * Please disable usdhc2 to enable fec1
+ */
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-txid";
+	phy-handle = <&ethphy1>;
+	fsl,magic-packet;
+	rx-internal-delay-ps = <2000>;
+	nvmem-cells = <&fec_mac0>;
+	nvmem-cell-names = "mac-address";
+	status = "disabled";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			reset-gpios = <&pca6416_1 0 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			qca,disable-smarteee;
+			vddio-supply = <&vddio1>;
+
+			vddio1: vddio-regulator {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pca6416_1: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca6416_2: gpio@21 {
+		compatible = "ti,tca6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9548_1: i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			max7322: gpio@68 {
+				compatible = "maxim,max7322";
+				reg = <0x68>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				status = "disabled";
+			};
+		};
+
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+		};
+
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x5>;
+		};
+
+		i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x6>;
+		};
+	};
+};
+
+&lpuart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart0>;
+	status = "okay";
+};
+
+&lsio_gpio4 {
+	status = "okay";
+};
+
+&lsio_gpio5 {
+	status = "okay";
+};
+
+&thermal_zones {
+	pmic-thermal0 {
+		polling-delay-passive = <250>;
+		polling-delay = <2000>;
+		thermal-sensors = <&tsens IMX_SC_R_PMIC_0>;
+
+		trips {
+			pmic_alert0: trip0 {
+				temperature = <110000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
+			pmic_crit0: trip1 {
+				temperature = <125000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&pmic_alert0>;
+				cooling-device =
+					<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	no-sd;
+	no-sdio;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	cd-gpios = <&lsio_gpio5 1 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD	0x000514a0
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHK_PAD	0x000014a0
+			IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1		0x0600004c
+			IMX8DXL_SNVS_TAMPER_OUT1_LSIO_GPIO2_IO05_IN	0x0600004c
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			IMX8DXL_USB_SS3_TC0_CONN_USB_OTG1_PWR		0x00000021
+		>;
+	};
+
+	pinctrl_usbotg2: usbotg2grp {
+		fsl,pins = <
+			IMX8DXL_USB_SS3_TC1_CONN_USB_OTG2_PWR		0x00000021
+		>;
+	};
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			IMX8DXL_ENET0_MDC_CONN_EQOS_MDC				0x06000020
+			IMX8DXL_ENET0_MDIO_CONN_EQOS_MDIO			0x06000020
+			IMX8DXL_ENET1_RGMII_RXC_CONN_EQOS_RGMII_RXC		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD0_CONN_EQOS_RGMII_RXD0		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD1_CONN_EQOS_RGMII_RXD1		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD2_CONN_EQOS_RGMII_RXD2		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD3_CONN_EQOS_RGMII_RXD3		0x06000020
+			IMX8DXL_ENET1_RGMII_RX_CTL_CONN_EQOS_RGMII_RX_CTL	0x06000020
+			IMX8DXL_ENET1_RGMII_TXC_CONN_EQOS_RGMII_TXC		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD0_CONN_EQOS_RGMII_TXD0		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD1_CONN_EQOS_RGMII_TXD1		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD2_CONN_EQOS_RGMII_TXD2		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD3_CONN_EQOS_RGMII_TXD3		0x06000020
+			IMX8DXL_ENET1_RGMII_TX_CTL_CONN_EQOS_RGMII_TX_CTL	0x06000020
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB0_PAD		0x000014a0
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB1_PAD		0x000014a0
+			IMX8DXL_ENET0_MDC_CONN_ENET0_MDC			0x06000020
+			IMX8DXL_ENET0_MDIO_CONN_ENET0_MDIO			0x06000020
+			IMX8DXL_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC		0x00000060
+			IMX8DXL_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0		0x00000060
+			IMX8DXL_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1		0x00000060
+			IMX8DXL_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2		0x00000060
+			IMX8DXL_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x00000060
+			IMX8DXL_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x00000060
+			IMX8DXL_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC		0x00000060
+			IMX8DXL_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0		0x00000060
+			IMX8DXL_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1		0x00000060
+			IMX8DXL_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2		0x00000060
+			IMX8DXL_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3		0x00000060
+			IMX8DXL_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x00000060
+		>;
+	};
+
+	pinctrl_lpspi3: lpspi3grp {
+		fsl,pins = <
+			IMX8DXL_SPI3_SCK_ADMA_SPI3_SCK		0x6000040
+			IMX8DXL_SPI3_SDO_ADMA_SPI3_SDO		0x6000040
+			IMX8DXL_SPI3_SDI_ADMA_SPI3_SDI		0x6000040
+			IMX8DXL_SPI3_CS1_ADMA_SPI3_CS1		0x6000040
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			IMX8DXL_SPI1_SCK_ADMA_I2C2_SDA		0x06000021
+			IMX8DXL_SPI1_SDO_ADMA_I2C2_SCL		0x06000021
+		>;
+	};
+
+	pinctrl_cm40_lpuart: cm40lpuartgrp {
+		fsl,pins = <
+			IMX8DXL_ADC_IN2_M40_UART0_RX		0x06000020
+			IMX8DXL_ADC_IN3_M40_UART0_TX		0x06000020
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			IMX8DXL_SPI1_CS0_ADMA_I2C3_SDA		0x06000021
+			IMX8DXL_SPI1_SDI_ADMA_I2C3_SCL		0x06000021
+		>;
+	};
+
+	pinctrl_lpuart0: lpuart0grp {
+		fsl,pins = <
+			IMX8DXL_UART0_RX_ADMA_UART0_RX		0x06000020
+			IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041
+			IMX8DXL_EMMC0_CMD_CONN_EMMC0_CMD	0x00000021
+			IMX8DXL_EMMC0_DATA0_CONN_EMMC0_DATA0	0x00000021
+			IMX8DXL_EMMC0_DATA1_CONN_EMMC0_DATA1	0x00000021
+			IMX8DXL_EMMC0_DATA2_CONN_EMMC0_DATA2	0x00000021
+			IMX8DXL_EMMC0_DATA3_CONN_EMMC0_DATA3	0x00000021
+			IMX8DXL_EMMC0_DATA4_CONN_EMMC0_DATA4	0x00000021
+			IMX8DXL_EMMC0_DATA5_CONN_EMMC0_DATA5	0x00000021
+			IMX8DXL_EMMC0_DATA6_CONN_EMMC0_DATA6	0x00000021
+			IMX8DXL_EMMC0_DATA7_CONN_EMMC0_DATA7	0x00000021
+			IMX8DXL_EMMC0_STROBE_CONN_EMMC0_STROBE	0x00000041
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX8DXL_ENET0_RGMII_TX_CTL_LSIO_GPIO4_IO30	0x00000040 /* RESET_B */
+			IMX8DXL_ENET0_RGMII_TXD1_LSIO_GPIO5_IO00	0x00000021 /* WP */
+			IMX8DXL_ENET0_RGMII_TXD2_LSIO_GPIO5_IO01	0x00000021 /* CD */
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX8DXL_ENET0_RGMII_RXC_CONN_USDHC1_CLK		0x06000041
+			IMX8DXL_ENET0_RGMII_RX_CTL_CONN_USDHC1_CMD	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD0_CONN_USDHC1_DATA0	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD1_CONN_USDHC1_DATA1	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD2_CONN_USDHC1_DATA2	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD3_CONN_USDHC1_DATA3	0x00000021
+			IMX8DXL_ENET0_RGMII_TXD0_CONN_USDHC1_VSELECT	0x00000021
+		>;
+	};
+};
-- 
2.25.1

