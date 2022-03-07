Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6814F4D04AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244352AbiCGQ4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbiCGQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:56:39 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822477E0AA;
        Mon,  7 Mar 2022 08:55:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMePbEfYCzmF7aUSZIPP27QzMna2sOlZmLw2vbvYg+n2tzACVLBMS/AAPGe6sjqlePD1vV2r35NsuRZQSyuRM+ky7DNdX/KsX5mCe/9ibBhR2TuHe6qOHPNQ6mnrlgPPZDxN25SjE3WgRaPMa9HD7Bthz0mmNXrvcrwz5irHT0z0KAKBBidsViAlcg6uG0KFt0UZ8ve7iwBv3/y4r8mp4erMfGXZqWP7HmtEho8Q0hnJfnZ4LgCLWlZrCnk4BrUz2WOZv3rBXcg67FnDpZ156Z+rJvrB76WaJSC0IthUllDeh7MlGTEJP3XXJ/6WKDyY9NP+GPmGxdO1MStpz0nzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm4JSVI64PJrZxwZRKB1bugq8YJK6qzHc2PTByHzUvI=;
 b=AvOnrvfJIAUeaAf3doW46sfawkfLZPefJwwUAFU8/IDGcEHRzQVPT/gSjJLSU3ypWlRmOqTGXX+1160GJ4iqdMwc/L+xreKRAra6/ABTCoUhN151Ow+X2l/S+AnquAXqqJrZ6/jXYpU4lM9thH/IXWVKTamoxBwMisYuIQXkis64KMBowwtjH8JcqJNmvOYE96RclJWmNIM9oAiDMHlTk43aRvelF+Civl5xAx2rQXBMjCJULN2ULIj6qMK8mSp3xEKi5npwC+LqpTzrSTFOBf5TiP7tb9rmwDZwUwXW7AxWaUrvcch47qTU6fgAxEfyCMzORz/7vqnCQZhI/2DTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm4JSVI64PJrZxwZRKB1bugq8YJK6qzHc2PTByHzUvI=;
 b=EwypUWtl4cpDgdmOheiXnlfRK8gK5/c6r4zOuvtQTMnxd204Kkeb1PP+u11SpphD2CANspZxU3ateLfE+ekIgu1uI0HrK6Y7AELn0PA2qBOiY5CJE52lZt4Ej+hjDcBlq+1r5Npn+2O4z6kX04u9JzRA+hOxn6wHbUWrZUgrFTGq5K/W91iTgyvzWktbBwmV/HD9m3eoNQ+4AdFE1Vp8e25GzgMhmy5FDojK4Cg8meAan1jwzyw4YL15qAzsRstWVc4fceO/SwqBACNtsEnbzSubagD428i/zb8KHehOH3HVReO3hXxyT9YKVvQtyZkTduQFoKTavmkC8bC92Q1Z6A==
Received: from MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35)
 by DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 16:55:41 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::d5) by MW4PR04CA0270.outlook.office365.com
 (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Mon, 7 Mar 2022 16:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 16:55:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Mar
 2022 16:55:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Mar 2022
 08:55:39 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 7 Mar 2022 08:55:35 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v3 3/3] arm64: tegra: Add QSPI controllers on Tegra234
Date:   Mon, 7 Mar 2022 22:25:19 +0530
Message-ID: <20220307165519.38380-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220307165519.38380-1-kyarlagadda@nvidia.com>
References: <20220307165519.38380-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d48e371f-f64d-4b48-0a13-08da005b4ff4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3324:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3324942DFF3BABF2279CD2C2C3089@DM6PR12MB3324.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aySHxCVeDfOL22284h8S14QIeaO8SsueIbGjWtmn348NGIStf5iFsNQ18Vi0p5MPzrG2Gdcjmx0G1ZPxlvY72MO9QASm1cBII55f6K0t6B8AXOuCfzWn3lqwdq3+npVt7MjJOOJ/Ve69fnU6xrP6Hodr4UfHmOJorwdYT2l+GGc1PSDHMpIoixmA4QKBKFN0gLodY+ylotYmLLunmby0Bwb6JCEkEyEOZToHChqp7pe2iLI/w+GPoeZaeIHr678C0P7oxhmV9yINIcLtYvuDEPuXwM5ImaGwGrkRxHDfHDh9ksHC6Yx4zxnktA+jt1Un1tnJBzo3UlsGRU6fk0+oWKjx8G4+SR+drc+j04STW0OA3khH0VaSiSGtwcp+WDoZHW/P9fiyXQVAip0akTCZMFQlK28mzxG1fFXea9xuVrkDzohjsnHL+5VDenpZMZ+RxXQfu1UJaseEi1+baUhwRJKQLGZBt3ZVF4JSefRadi8d7dLXvFtbmBTC7GA66HZqCaVDnfvb7CVKawh00lF6iVhehtrk+RQw+MMd8BkhK7acpfrQP2w/b6Bp/8Z9RmFi1uAv1mIKBdbbqER01V8yHMf+0kISDIvVLpVFFzdEiqwUDorbMs7a8/ggKsrlas6uExiOOBnwhgwL+pqmfd26ntES5Akuara1oKOKAs4ZZJKW6hUxuMNngNseeqkPaNcIvhr9KnbYQbKOnQ9qGMWK2A==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70206006)(316002)(54906003)(40460700003)(6636002)(82310400004)(8676002)(4326008)(86362001)(110136005)(8936002)(356005)(81166007)(2906002)(5660300002)(2616005)(336012)(426003)(70586007)(186003)(26005)(1076003)(508600001)(107886003)(7696005)(6666004)(36860700001)(83380400001)(47076005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:55:40.8357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d48e371f-f64d-4b48-0a13-08da005b4ff4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3324
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
index aaace605bdaa..bd82b324703f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -666,6 +666,34 @@
 			#pwm-cells = <2>;
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
index 1362cd5e03f0..1652d8d9e106 100644
--- a/include/dt-bindings/reset/tegra234-reset.h
+++ b/include/dt-bindings/reset/tegra234-reset.h
@@ -41,6 +41,8 @@
 #define TEGRA234_RESET_PWM7			74U
 #define TEGRA234_RESET_PWM8			75U
 #define TEGRA234_RESET_SDMMC4			85U
+#define TEGRA234_RESET_QSPI0			76U
+#define TEGRA234_RESET_QSPI1			77U
 #define TEGRA234_RESET_UARTA			100U
 #define TEGRA234_RESET_PEX0_CORE_0		116U
 #define TEGRA234_RESET_PEX0_CORE_1		117U
-- 
2.17.1

