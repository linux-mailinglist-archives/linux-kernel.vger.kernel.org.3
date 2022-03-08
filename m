Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0C4D204A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbiCHSbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiCHSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:31:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0190339812;
        Tue,  8 Mar 2022 10:30:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTl+WF9Vb1gZPS8OQmGyOg8leobaRuRWpkMJLzOnYjRSSLWiN75GGF5r4tmdLsBRBvvC5rv8PBGW/dKM7+LhwUnwHcBxU5mECFYJMgkRXCMRvWN+pN4kPULXtHRKGSE0QVzkzqG4aq5fuxyUOaIboI8NdUn/5KbdNws4Oysq6KIb6gHGhOgW0AQiXi2kGXkbYc1EaRjxigzvonkreYLKJxzy/MFLnRnZH08sfxkbgFtP1RtOa7l2coTZeseJb9bxamsNeRMNUEaxbG+Z3Gbk0FkEehKFx1U9MPDEGYdqJvX3K/pky3BtwWZL2mOTFdiyFtaigmPYac4A5Pv6ndSelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq5PpjfUyjun3Rr2v1vshs8axBMxPlrbTq3CvHrqIuQ=;
 b=avKQWx+0k3aXjmJ6567GIJ+j942nK5IgMEG6477+jVJcqbyddQvOFNh0DOYonNmAGaN/f1AEIZwlTUGWmITK9jLElps1Lxv5MhOyc/WB7cCXHnOr87AYVv7+RyyScUdbCEJU1gEXPt1EHtRDuBmcP+7PyJ2fnA9H0EUjhZtOZ2ZAXmRGlT/0qrtumFDepQiympx8dkbeBc6x99XCOmllAkpxhDsAy8pjcAjLa4m9qU2cNnWtdOls3aWhjBK8eeLac8hpiXCXizoMOdG9gKqUs/eCt97t9QSeKydRsztlpMkY33qxl4y050a+rzxkE9AC2XGQrTV34+L5N9PM0C3Xmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq5PpjfUyjun3Rr2v1vshs8axBMxPlrbTq3CvHrqIuQ=;
 b=iJIKJ2D8HWbcOltPF+QS/wjFsd2BOCsIsMyHsfGLRvmAH3dtVKpj5f2kJOJJ8dm5qEl7kIjmDd80HF3MUSqYnMvs/MLfmR9F5vDwSJBQwzvEbTvuF+2cLdeA+ytcNKe1vydLBpbOBR8Elz/g0pDcxAAafsq9cUgQBAM3DmM8ruz36VSVV8yHzGlOICkadM+2zknDYnzH7L7jZJgFlNoKhne+UgQKGga1hfI3CFN5Yh3Sp2BDm6Fd91QPLN4M9vpuU6kVA7SB3NyUUnHDC61I+oMv2Y//WqFgwJRYQON+BaYP5GCjJPgtqlk/MRkJ0/H9IKmpSTX74564aKRoE5Fm0g==
Received: from BN9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::20)
 by DM6PR12MB3802.namprd12.prod.outlook.com (2603:10b6:5:1c5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Tue, 8 Mar
 2022 18:30:37 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::c5) by BN9P223CA0015.outlook.office365.com
 (2603:10b6:408:10b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 18:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 18:30:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 8 Mar
 2022 18:30:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 10:30:33 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Mar 2022 10:30:30 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v4] arm64: tegra: Add QSPI controllers on Tegra234
Date:   Wed, 9 Mar 2022 00:00:26 +0530
Message-ID: <20220308183026.66394-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ed89b77-9c79-4bc6-f5bd-08da0131bd85
X-MS-TrafficTypeDiagnostic: DM6PR12MB3802:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38024D3B3EA3C5B46423B078C3099@DM6PR12MB3802.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYS62glHQ9irVkVkDVI624PJVaYnN9GckqsNZsZRLJlrGW0ZKk07MVPHNT7IMt2OXJSTsWbgOnWpY3rYW6hAyjNY5uy6nDp+z0oAYO6NbkRoTGnPl+OZNyq7//0eElrUan4ECyNX6SMFkyMAKOaCye1JEqDtqR4WxDA7cHZj2DlT5jDmNsYyhY5edBvLifuPXibrupEtcNX/uxsO3spsK7qIaWXlzYio7416cYKbMPE3Z+puOszAxB3DIcRn8iB9JBzU27OPEzwedJ43izoBTu5PCid8WS6o41DhkaGrrhVf3ggiXmKSmx9e6NtLLRsgmYzIpPNlwNfqekrrfQ9QiSK4fzFFcsyyxVvviqqtrvjcU1KSXshzbi2LUNcW54gbr9Gdz1dozVxMFbtrRydw5ySWgwMVvggpnMHx4jIA/CcLGBZG3cwYWyeeDZMJ8azIkapS5DaJd6RZHX0ckam4cqZOH1V26Br8PufQwquyA6pX3yyjk32AnppRoGtdyaHpkQu6GCX3u6ZL1Cavq236yJ/f05tR05BcRo0cvfim8tu16A9N7JI4JQY0QSP8h69Jw4eJQJr9QMdmFQHB730yiW9m3CAUNtq7oBNRZ5V+ge/UvH8UxIMcZBDrKK44P1sx9QAsJRrXQUc8D2KDPlLH9tY+KpvfiD6TRilroD3X+Ytbo7mr56hacJ0xQfP/fVWv28HYhCdEy2XS0Uz5u3ZlFw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(7696005)(81166007)(356005)(54906003)(110136005)(70206006)(6666004)(86362001)(6636002)(8676002)(70586007)(5660300002)(508600001)(4326008)(316002)(8936002)(107886003)(1076003)(426003)(336012)(2616005)(26005)(40460700003)(186003)(36860700001)(36756003)(83380400001)(47076005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 18:30:36.9326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed89b77-9c79-4bc6-f5bd-08da0131bd85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3802
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Singhal <ashishsingha@nvidia.com>

This adds the QSPI controllers on the Tegra234 SoC and populates the
SPI NOR flash device for the Jetson AGX Orin platform.

Signed-off-by: Ashish Singhal <ashishsingha@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
v4:
sort definitions in include and dt files

 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  | 12 ++++++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 28 +++++++++++++++++++
 include/dt-bindings/clock/tegra234-clock.h    |  8 ++++++
 include/dt-bindings/reset/tegra234-reset.h    |  2 ++
 4 files changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
index d95a542c0bca..798de9226ba5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
@@ -7,6 +7,18 @@
 	compatible = "nvidia,p3701-0000", "nvidia,tegra234";
 
 	bus@0 {
+		spi@3270000 {
+			status = "okay";
+
+			flash@0 {
+				compatible = "jedec,spi-nor";
+				reg = <0>;
+				spi-max-frequency = <102000000>;
+				spi-tx-bus-width = <4>;
+				spi-rx-bus-width = <4>;
+			};
+		};
+
 		mmc@3460000 {
 			status = "okay";
 			bus-width = <8>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index aaace605bdaa..448512af7dea 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -654,6 +654,20 @@
 			reset-names = "i2c";
 		};
 
+		spi@3270000 {
+			compatible = "nvidia,tegra234-qspi";
+			reg = <0x3270000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA234_CLK_QSPI0_2X_PM>,
+				 <&bpmp TEGRA234_CLK_QSPI0_PM>;
+			clock-names = "qspi", "qspi_out";
+			resets = <&bpmp TEGRA234_RESET_QSPI0>;
+			reset-names = "qspi";
+			status = "disabled";
+		};
+
 		pwm1: pwm@3280000 {
 			compatible = "nvidia,tegra194-pwm",
 				     "nvidia,tegra186-pwm";
@@ -666,6 +680,20 @@
 			#pwm-cells = <2>;
 		};
 
+		spi@3300000 {
+			compatible = "nvidia,tegra234-qspi";
+			reg = <0x3300000 0x1000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA234_CLK_QSPI1_2X_PM>,
+				 <&bpmp TEGRA234_CLK_QSPI1_PM>;
+			clock-names = "qspi", "qspi_out";
+			resets = <&bpmp TEGRA234_RESET_QSPI1>;
+			reset-names = "qspi";
+			status = "disabled";
+		};
+
 		mmc@3460000 {
 			compatible = "nvidia,tegra234-sdhci", "nvidia,tegra186-sdhci";
 			reg = <0x03460000 0x20000>;
diff --git a/include/dt-bindings/clock/tegra234-clock.h b/include/dt-bindings/clock/tegra234-clock.h
index 8cae969e8cba..bd4c3086a2da 100644
--- a/include/dt-bindings/clock/tegra234-clock.h
+++ b/include/dt-bindings/clock/tegra234-clock.h
@@ -140,6 +140,14 @@
 #define TEGRA234_CLK_PEX2_C9_CORE		173U
 /** @brief output of gate CLK_ENB_PEX2_CORE_10 */
 #define TEGRA234_CLK_PEX2_C10_CORE		187U
+/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_QSPI0 switch divider output */
+#define TEGRA234_CLK_QSPI0_2X_PM		192U
+/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_QSPI1 switch divider output */
+#define TEGRA234_CLK_QSPI1_2X_PM		193U
+/** @brief output of the divider QSPI_CLK_DIV2_SEL in CLK_RST_CONTROLLER_CLK_SOURCE_QSPI0 */
+#define TEGRA234_CLK_QSPI0_PM			194U
+/** @brief output of the divider QSPI_CLK_DIV2_SEL in CLK_RST_CONTROLLER_CLK_SOURCE_QSPI1 */
+#define TEGRA234_CLK_QSPI1_PM			195U
 /** @brief CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC_LEGACY_TM switch divider output */
 #define TEGRA234_CLK_SDMMC_LEGACY_TM		219U
 /** @brief output of gate CLK_ENB_PEX0_CORE_0 */
diff --git a/include/dt-bindings/reset/tegra234-reset.h b/include/dt-bindings/reset/tegra234-reset.h
index 1362cd5e03f0..547ca3b60caa 100644
--- a/include/dt-bindings/reset/tegra234-reset.h
+++ b/include/dt-bindings/reset/tegra234-reset.h
@@ -40,6 +40,8 @@
 #define TEGRA234_RESET_PWM6			73U
 #define TEGRA234_RESET_PWM7			74U
 #define TEGRA234_RESET_PWM8			75U
+#define TEGRA234_RESET_QSPI0			76U
+#define TEGRA234_RESET_QSPI1			77U
 #define TEGRA234_RESET_SDMMC4			85U
 #define TEGRA234_RESET_UARTA			100U
 #define TEGRA234_RESET_PEX0_CORE_0		116U
-- 
2.17.1

