Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E0753EC91
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbiFFPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbiFFO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:59:56 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2049.outbound.protection.outlook.com [40.107.212.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910E131B7C2;
        Mon,  6 Jun 2022 07:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFROp2BWC+0Ktl8dtWXUwk1n5Do5xXZRuiav2OocmQTv82GPNB39SC++ZTnTTJMf+cO9MEBjZjw6NF214mjkZwwzSzjFdi8qAMfovkZ3KI9YnKw1cqASQ/XWGxjueDRiYChpUAM3OLO93Yn7GRjoMd57zVALKowZoACzJ6TbfidOscgfir5bzjCWNAmLhxPlUbU29wTIfC2m/wQzsRa0qYbCrjfJVmZWJ6x1qwCu4q7h6O85wprYZDrC8ujgJE842yIoOOCHKg5MT2SD5db1ftgIMbspUxmWAWVgOXbmGkVEHzl8JMTM39giHv4cA2sWEZJsGgym9czisBdBNG3qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpUJsrsFsHwh5PMan/qdCfzXz73LwMa3VQ8GHIjRWNw=;
 b=Qsr19kAeiTB0cvARhlm5zjbN01W/fVVQ7mmK3gqibyXOOilp1z7Xr/oQeCfbzr8WxCSBuOkNq4LLij2P6aS6ik2eQsndwUlDewaYNRVX0sSAK7BnLBe0mVGZcOk4W0pBf0ZWiaRtzTrBQQfpumDYCFpAWaLozfJomVwBqpKHT8qRWm4mlCUaj7FZVKrndiz75S/ay0ATw4cHuv5MCQgnJpFWchUSeW961ktO9fZC/G7RUBPZIE+llBAB5lsbAYV9isn/WcxKFe2r5bGBRo6tD18XFfFzfB+BYnb/P/AC+P5LfYkr4kRDAVBrQ0LUCCKxiKs0DCsDdipb1q0tkTBqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpUJsrsFsHwh5PMan/qdCfzXz73LwMa3VQ8GHIjRWNw=;
 b=DmhOVSfNnebehNaSa0DZ22UqSVc3tePHYmyl08Z/0VO8KOzjXvaoH9YQpR1/SjnBkXk/HWb7iD3mB3PoFmWQHZXkoflQTKWN8OyKdiiTI9W1FC5TCKk29QBlG0X4tllMNQnQH8R8EZGt2Wi1yC/5BpAV6fJfMdsFqhB1OAodvi3FDBbnjkcmWjUfUTyVIxvObuTWVx5LNU7Tu9njbePbYYBwWGWpLthrYa6zFkPyo0J5HpYmVSRKsJ9pKXakUOmVTzqle9ZFJ5JtNz+XT0AGF3v3CG97wGMaNL2fA1D45Br+SRzFkrbAywrh3QJlef2+gce2DijXDyIf6bkOL8l7NQ==
Received: from MW4PR03CA0345.namprd03.prod.outlook.com (2603:10b6:303:dc::20)
 by DM5PR12MB1739.namprd12.prod.outlook.com (2603:10b6:3:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 14:59:34 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::2b) by MW4PR03CA0345.outlook.office365.com
 (2603:10b6:303:dc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Mon, 6 Jun 2022 14:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 14:59:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 6 Jun
 2022 14:59:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 07:59:33 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 6 Jun
 2022 07:59:29 -0700
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
Subject: [RESEND PATCH v3 5/6] arm64: tegra: Add OPE device on Tegra210 and later
Date:   Mon, 6 Jun 2022 20:28:56 +0530
Message-ID: <1654527537-31038-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654527537-31038-1-git-send-email-spujar@nvidia.com>
References: <1654527537-31038-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6326d9ba-1a75-4786-7591-08da47cd2b4a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1739:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB173904DD6E2A9D7BACB4BB5BA7A29@DM5PR12MB1739.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xz6c/WIY9mALsVc4spUhQ+k5vn/k8k1rdfmwcQCmialRUTdO6fAo3x+EeEc7yARX1jve59CUnlZ/fddPrWLCDTsue0IfNq6sWpWCs1i2zGNsiBdxJamt2lhgaURCWk7slfTjNXiO2QyBLDCFM472gyelIJOFzm1pQHKpDeLPaCxZA7GNyeqWJvjH3CjSK00yaHZesVNi6H69Lw5dN5y9bZrZc4OyKVn55Hi9N576YeOJX4ZKQHMN7x6Unx9xgndi7PxKUnccPj2IFVlu8nLsmoBjR9/UKg+DZWxnB0BWsRciA2IMuoc3ur+J9wpqEsjaAiAKOU3hx1Dn52Msl9tZ8KutpambCUjHEt5yIP5wFGRIOMIv0wL10skaAF5GA18BTR2gm0c7sepeaEnlzAg9pYRGyXsgtypctQ2UZlz2TTPH1qTfZ5pB+Ij34eQaWEqRFpAlWWwB/WAfibyqVwq4eZcr/paal6lwraTZ2qeNyeN74MeaHpXgyCRVA8nbookQfFIqKBMjdgXUup0XXM64EqlsnZkKIDnzj1NMZTg8gJ+dpu2miCRv4QLJZycIpoph4Xp8i9ysijXhbmdwJxA47cwR58NrjRLXw4XCUMJ5HmpHDMfDRiiBJ7Ovs79LBYE4ypa3XbixSW12xiC+uxhKLBOy3ZHhtmWmvHqkv9yrCfCF1JwnOzsogIXjE+FnRPH4gF8At+vNHIec3aw27Yljaw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(316002)(8676002)(356005)(40460700003)(86362001)(36756003)(2906002)(5660300002)(110136005)(70206006)(8936002)(81166007)(2616005)(7416002)(26005)(336012)(107886003)(426003)(70586007)(47076005)(186003)(508600001)(7696005)(6666004)(82310400005)(54906003)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:59:34.5264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6326d9ba-1a75-4786-7591-08da47cd2b4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1739
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

