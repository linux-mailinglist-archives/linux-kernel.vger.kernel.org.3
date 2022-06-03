Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5053C50F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbiFCGhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbiFCGgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:36:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C871E7;
        Thu,  2 Jun 2022 23:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4kMNpEZgzfojdgl9sYaAejX4l8+zmZI98TswHsNpCgF+uMKA/joAZlR9MFfPv1HRBL8Ukb6wdYDlKonMSAHpfZOy/ocAWgdkw5dzTPYeqzNKxOkxqp/8rhO207X0q1icjxzFALr/V/6JA77Plld3z8jli83mbU8lWpT9k7wlmeRB1lLjGhUqdgtkV8ZawvrphhuYnLPLzp+nvBJG6l8wU2MRKkS3LkXynz3y2gtre79yLYtKqtFZK/F6uOMTD+baNSgvwIr63acYx3c1xIUTR8yqGI8bD7umirKddw3m6oecdJMT+vZcUkF856Y7Jt8uF5vHP4MZDEf1+r/7MOh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpUJsrsFsHwh5PMan/qdCfzXz73LwMa3VQ8GHIjRWNw=;
 b=es2waII/fxXRFVnj4WXTBCgQYrDJvDZmtVOOv/0oT0A2uqjtxhLe9H1/E8T7lmX/q3ImFHAPR4jWbiKaXx57EngULF534N9uqIZJbkHLSlkmRiO0OFAbBgua29gmD8MXUQ7j3lIhkX5bnMVRkMYUUvUMYqhm4CGThM/3JRUb0sMrTP4l75qHCzo1L6oJWB/ySNrIzEOQ0UWKs4t4xbqPcWoZ8nxT7zdx5Bj7zE1hcnXM1Dg422JrnLz3ZNJL/F6TGf2xW94J+xaxlXNZDwt1Uxw6wD1hWTF1m0I7H9DA21D5nqopOigduwgXfk+qzfLwbIK6QoanGgq10Su1NjFm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpUJsrsFsHwh5PMan/qdCfzXz73LwMa3VQ8GHIjRWNw=;
 b=UxJGDdO3+56zX8mpiHaYBdk0J9bVtRh8FxBp5yCqWpgjxTHTgN4af+VrqklZDGTk0KLSsVqWHw9PeqFkLXGxg4CUM1SOahBHTOhRY+K0LL2dzlJwfBHuSTPbZlk0EP55Da5KvS/VjznzEcyzE1wvCKuVmr8CGsvSvCjLHyv22s42gL+b61SaElw3MS82eqaGCW5eUDk8ZD74qdNzJvvolQljH8Ez8OxKyRex4TZvGhg9fhcrJz0QSMAKkNWGGGy1mkiO+dJ+arqUl1fB6Wqrldp+0WAT4ksP0QbBrcPjvyJb/fOT4vkYyjMQooXw1KXTkk6eBNNOt1D0ubyUtYluwA==
Received: from DM6PR13CA0034.namprd13.prod.outlook.com (2603:10b6:5:bc::47) by
 BL0PR12MB4674.namprd12.prod.outlook.com (2603:10b6:207:38::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.15; Fri, 3 Jun 2022 06:36:47 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::cb) by DM6PR13CA0034.outlook.office365.com
 (2603:10b6:5:bc::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.4 via Frontend
 Transport; Fri, 3 Jun 2022 06:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 06:36:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 3 Jun
 2022 06:36:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 2 Jun 2022
 23:36:46 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 2 Jun 2022 23:36:42 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <thierry.reding@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 5/6] arm64: tegra: Add OPE device on Tegra210 and later
Date:   Fri, 3 Jun 2022 12:06:11 +0530
Message-ID: <1654238172-16293-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
References: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff1ab4f7-05b5-40bc-8ca1-08da452b6f18
X-MS-TrafficTypeDiagnostic: BL0PR12MB4674:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB46745008FE02ED2FDF1DCC2BA7A19@BL0PR12MB4674.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QE8NQZqDvjKs/DA3L1XqkW80dkv5qWX1Z1vz8mAivwB3L4RFRVztORxhgFmCE7ljASUM+5mXLakOIVrCDtnJoLj4eu1Zo33JWOgLTZuDMebE6+lbnj8aOicBJdVUQtjHXIGNkIPnZ+napjDJ5ygbq3U7MfG4kGBukF6zwVoLByNHmBCUWlPf6OxK2AXh7vsps75S2FZsJ5Oy15CWreJyrIiMow10QuUGFz9Wwu7c9iLmF6AtVQCHZZySHTqzZEzJ0Fx/JoA93D5WZp8G4yYqZlYeT2hgrzYwBPH1mVqEJe/XECcltd+s8A64wd/f95oy1//XcK087BV9HxaalTWqvBS1wTQgUba2oRzRlgQr3CV6J9Q6v1nSdfrfct3JITvn92UtlZuqfiltqZ9KMYa2FBvQk/TqST2FXrPUPU1KWA9e3jN00YHBpkqiO4VbjxNjDRrtS6UnA4Wh6HekmpYDy+lr1UGL2aHkN2AGHC1NBdz+ajmQhiiLuyoAGjq0vBrcYzXvgdfa/aGPhsUFmBiyBRuPYWjLMXvN63c+jXfq4aq5icT5GCWQ922eMDrsdQVR+8qFPiSAbto4xTs/LosSEHOdMmov9SC10aVvV4IGsGyaaQrGFjEix6S4d6+tb/6lJx9WxsQe1i88vAcEtivjQSrVER68+XDZIc7mnAvHNVZOSY1dyWI6/XyI06S9zFIFYOpGFWT6RJ52PNQeXF/iaw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(8676002)(5660300002)(70586007)(4326008)(40460700003)(54906003)(110136005)(36756003)(316002)(86362001)(82310400005)(7416002)(8936002)(2906002)(36860700001)(356005)(107886003)(186003)(336012)(2616005)(426003)(47076005)(26005)(508600001)(6666004)(83380400001)(81166007)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 06:36:47.5042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1ab4f7-05b5-40bc-8ca1-08da452b6f18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4674
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output Processing Engine (OPE) is a client of AHUB and is present on
Tegra210 and later generations of Tegra SoC. Add this device on the
relevant SoC DTSI files.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 23 ++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 23 ++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 40 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 23 ++++++++++++++++++
 4 files changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 0e9afc3..cd8c4f3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -509,6 +509,29 @@
 				status = "disabled";
 			};
 
+			tegra_ope1: processing-engine@2908000 {
+				compatible = "nvidia,tegra186-ope",
+					     "nvidia,tegra210-ope";
+				reg = <0x2908000 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				sound-name-prefix = "OPE1";
+				status = "disabled";
+
+				equalizer@2908100 {
+					compatible = "nvidia,tegra186-peq",
+						     "nvidia,tegra210-peq";
+					reg = <0x2908100 0x100>;
+				};
+
+				dynamic-range-compressor@2908200 {
+					compatible = "nvidia,tegra186-mbdrc",
+						     "nvidia,tegra210-mbdrc";
+					reg = <0x2908200 0x200>;
+				};
+			};
+
 			tegra_amixer: amixer@290bb00 {
 				compatible = "nvidia,tegra186-amixer",
 					     "nvidia,tegra210-amixer";
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index d1f8248..e65d1b0 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -562,6 +562,29 @@
 					status = "disabled";
 				};
 
+				tegra_ope1: processing-engine@2908000 {
+					compatible = "nvidia,tegra194-ope",
+						     "nvidia,tegra210-ope";
+					reg = <0x2908000 0x100>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges;
+					sound-name-prefix = "OPE1";
+					status = "disabled";
+
+					equalizer@2908100 {
+						compatible = "nvidia,tegra194-peq",
+							     "nvidia,tegra210-peq";
+						reg = <0x2908100 0x100>;
+					};
+
+					dynamic-range-compressor@2908200 {
+						compatible = "nvidia,tegra194-mbdrc",
+							     "nvidia,tegra210-mbdrc";
+						reg = <0x2908200 0x200>;
+					};
+				};
+
 				tegra_amixer: amixer@290bb00 {
 					compatible = "nvidia,tegra194-amixer",
 						     "nvidia,tegra210-amixer";
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 4f0e51f..04383a1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1723,6 +1723,46 @@
 				status = "disabled";
 			};
 
+			tegra_ope1: processing-engine@702d8000 {
+				compatible = "nvidia,tegra210-ope";
+				reg = <0x702d8000 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				sound-name-prefix = "OPE1";
+				status = "disabled";
+
+				equalizer@702d8100 {
+					compatible = "nvidia,tegra210-peq";
+					reg = <0x702d8100 0x100>;
+				};
+
+				dynamic-range-compressor@702d8200 {
+					compatible = "nvidia,tegra210-mbdrc";
+					reg = <0x702d8200 0x200>;
+				};
+			};
+
+			tegra_ope2: processing-engine@702d8400 {
+				compatible = "nvidia,tegra210-ope";
+				reg = <0x702d8400 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				sound-name-prefix = "OPE2";
+				status = "disabled";
+
+				equalizer@702d8500 {
+					compatible = "nvidia,tegra210-peq";
+					reg = <0x702d8500 0x100>;
+				};
+
+				dynamic-range-compressor@702d8600 {
+					compatible = "nvidia,tegra210-mbdrc";
+					reg = <0x702d8600 0x200>;
+				};
+			};
+
 			tegra_amixer: amixer@702dbb00 {
 				compatible = "nvidia,tegra210-amixer";
 				reg = <0x702dbb00 0x800>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cb3af53..7e07684 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -304,6 +304,29 @@
 					status = "disabled";
 				};
 
+				tegra_ope1: processing-engine@2908000 {
+					compatible = "nvidia,tegra234-ope",
+						     "nvidia,tegra210-ope";
+					reg = <0x2908000 0x100>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges;
+					sound-name-prefix = "OPE1";
+					status = "disabled";
+
+					equalizer@2908100 {
+						compatible = "nvidia,tegra234-peq",
+							     "nvidia,tegra210-peq";
+						reg = <0x2908100 0x100>;
+					};
+
+					dynamic-range-compressor@2908200 {
+						compatible = "nvidia,tegra234-mbdrc",
+							     "nvidia,tegra210-mbdrc";
+						reg = <0x2908200 0x200>;
+					};
+				};
+
 				tegra_mvc1: mvc@290a000 {
 					compatible = "nvidia,tegra234-mvc",
 						     "nvidia,tegra210-mvc";
-- 
2.7.4

