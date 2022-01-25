Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C432949AE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453264AbiAYIxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:53:06 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:46654
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1452461AbiAYItH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:49:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWRltsMo0BJt5+wZfeN89EHXgM4h+GfeJZvm4rJP4VyoG6MkidSzi5fvh5NrifI1noRLLlh8Hk8DRy5HQjBKfoaBRUdJLjxEYLJxoPbslCO7050+B9MogdPrx1LneI2yI9kp+iDLxIBZIP6hIm8aShg8hU8Jb1asJxxhJO/d13Df4F6dJgNrx4WvdAsbeRLojCzzSwwEoqUaQuW0kJbuDb0RyNzhciS7NeGH3YYFpzQj2gEmg6N9FgKjDhi4mNjC3T0NqrHEMR+c5MKgPpQCo3GfCMoQgx8WRGp/16I12gQn5czCzwLWxnAb1yU9qvBH9Sk6dnJReKFttOxe+c5u0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq4Xsk3GGdSWYopufuwlSilK0VfI46yvDrfqeu9xK/0=;
 b=Q3Tl2EktQZHZdZ0/L1akKKQzghhvn3CzNa84xMToFAygUzJ5zBoqfnXoZnOgv40tGGSP9/p8ugUQs2RL0CXfGSl/mdOkUR1CD6TduP+DS821G+ADO1LKdNTPqtnrBFOSfgYZmrQupCV4zDF9ex+oY4NELJQyN3/AuxowqG5d5arZ1wtEVwYqjDQsvx7tYEBrDnqFoQwJ+eY1iGbkWqddORIE2STeUxcz5nPG6lpyQuss3HC9oJ3hCbkJa6egAmFlYOfbMmJ2/fG03ix18XzZWDtgAb3eQlLFUasbEXQL6zqDsmFu2SnSiHAPv2qKrXw4669/pMgue1B+zi0ek4a86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq4Xsk3GGdSWYopufuwlSilK0VfI46yvDrfqeu9xK/0=;
 b=giiOQMTbVitHEPiS3Pj1mpSsSFeJ7zJrsaaRQLJhlWrdzHoSLD/4rME3ao3KMwDR3Cz+E7iEg2GdrzEhlN4yr8WngaqRumKHlwnNIspiZOUYJbz0ViQYClBw0XWeY4lPfamH6GE6GBPNMBFnWDQBmvCaj2OtofP0OZzMva2FNfJmjyTZ442MhVB8FiYBgy7o2GZomdcsPsMvrk6HkEeQzdonNVKvFH0GErFosLcV8Ie77HkD7aieoiTFkHpK5O/EeXhd2l68QdkfiGfMd+KspFsPwTXK79ethd6ETxHzeJ7+wjfDE1YQdIxUtjmZsXwrGwOfsZzneDrHswQMoNqiXA==
Received: from DM5PR16CA0016.namprd16.prod.outlook.com (2603:10b6:3:c0::26) by
 CY4PR1201MB0008.namprd12.prod.outlook.com (2603:10b6:903:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 08:49:03 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::c2) by DM5PR16CA0016.outlook.office365.com
 (2603:10b6:3:c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19 via Frontend
 Transport; Tue, 25 Jan 2022 08:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:49:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 25 Jan 2022 08:49:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Tue, 25 Jan 2022 00:49:01 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 25 Jan 2022 00:48:58 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 4/5] arm64: tegra: Add audio devices on Tegra234
Date:   Tue, 25 Jan 2022 14:18:10 +0530
Message-ID: <1643100491-5398-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643100491-5398-1-git-send-email-spujar@nvidia.com>
References: <1643100491-5398-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ef372f1-2424-40f7-953c-08d9dfdf898d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0008:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00080264F66A0CD81CF6C86FA75F9@CY4PR1201MB0008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uooDvd5epFEdsDnXif568B9+tkpB9YMbn7gNqq815ZA5o4PYmch6gcHV+kvDCEbatgMPZ4IZ3dyijJLk880s8bhUBsGxKgnIc9KWZ1XEnLjO8MdgUs2wLm7IRCGAj1D48M0C+TEdPu+mCB2hxfSj+HhX9FaOjOBI9cjLFY6CcPuw5skrxo551GeAOPeFNW+XqtAIUiZoVcfU0zfYJ0RYWUk/UL7kFhf4mQ1i5t1rohFwysT5xKnmLiWIea9/Fj5+1vCXnMo/xyUyQc5KzS6pqpYH55HbA6yUsJsBZjY/cTpSRznWos8XCMpGA9imvJSWOcyxfE45/vDkwQTDOIhcxi1tAsRk7mrXJwzQJOslmKKcGsPwM2oTkFlyYYSYKQ2MhIEmyZTqO7L+q0e/Y8ItjBIvC+dAg3Vp5kg8lopvEDqR39kfoR5vkFgsKojoLZgWvW3ih4IRUcKkQvsXULJlLUWtQ5c2MYCe+LaFa3nkSuJOq8CYwC+/zfgOvLpzo31TIbjagRbglFJ3rjK+ymxLm2gDv7WkeBPDQqPYpZuQKawHHh4GUpYFNhpap2x9+9remx9kHK3AYm7eWyNpBJr2s5zxoFOWp58WItbVhbVRylFILprNyRpwDqLs/MCHV32o8y8WM/2pOMJ6Aak6TlG2+4ci20U+mGnKCFw1rQKJ76vZ2gc5s5Z6Z0dK0Z0q67BTsxQS2c2MOet1M/z64DsFheMICNMI8W6wn5Mcyleg8tgSk5SAwiDzOgWN4IGwuoSKhlPUpe1ZtCEbeZ+sFLGZqxEnRps9GUMd7p87+zSNCZ4=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700004)(316002)(47076005)(6666004)(4326008)(336012)(8676002)(30864003)(86362001)(5660300002)(54906003)(70586007)(356005)(36860700001)(83380400001)(8936002)(110136005)(107886003)(7696005)(26005)(2906002)(426003)(40460700003)(82310400004)(2616005)(508600001)(186003)(81166007)(36756003)(70206006)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:49:02.6375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef372f1-2424-40f7-953c-08d9dfdf898d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add following devices which are part of APE subsystem
 * ACONNECT, AGIC and ADMA
 * AHUB and children (ADMAIF, I2S, DMIC, DSPK, MVC, SFC,
   AMX, ADX and Mixer)

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 414 +++++++++++++++++++++++++++++++
 1 file changed, 414 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index f54ad0d..e1885ca 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -87,6 +87,420 @@
 			gpio-controller;
 		};
 
+		aconnect@2900000 {
+			compatible = "nvidia,tegra234-aconnect",
+				     "nvidia,tegra210-aconnect";
+			clocks = <&bpmp TEGRA234_CLK_APE>,
+				 <&bpmp TEGRA234_CLK_APB2APE>;
+			clock-names = "ape", "apb2ape";
+			power-domains = <&bpmp TEGRA234_POWER_DOMAIN_AUD>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x02900000 0x02900000 0x200000>;
+			status = "disabled";
+
+			tegra_ahub: ahub@2900800 {
+				compatible = "nvidia,tegra234-ahub";
+				reg = <0x02900800 0x800>;
+				clocks = <&bpmp TEGRA234_CLK_AHUB>;
+				clock-names = "ahub";
+				assigned-clocks = <&bpmp TEGRA234_CLK_AHUB>;
+				assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x02900800 0x02900800 0x11800>;
+				status = "disabled";
+
+				tegra_i2s1: i2s@2901000 {
+					compatible = "nvidia,tegra234-i2s",
+						     "nvidia,tegra210-i2s";
+					reg = <0x2901000 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_I2S1>,
+						 <&bpmp TEGRA234_CLK_I2S1_SYNC_INPUT>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA234_CLK_I2S1>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S1";
+					status = "disabled";
+				};
+
+				tegra_i2s2: i2s@2901100 {
+					compatible = "nvidia,tegra234-i2s",
+						     "nvidia,tegra210-i2s";
+					reg = <0x2901100 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_I2S2>,
+						 <&bpmp TEGRA234_CLK_I2S2_SYNC_INPUT>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA234_CLK_I2S2>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S2";
+					status = "disabled";
+				};
+
+				tegra_i2s3: i2s@2901200 {
+					compatible = "nvidia,tegra234-i2s",
+						     "nvidia,tegra210-i2s";
+					reg = <0x2901200 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_I2S3>,
+						 <&bpmp TEGRA234_CLK_I2S3_SYNC_INPUT>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA234_CLK_I2S3>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S3";
+					status = "disabled";
+				};
+
+				tegra_i2s4: i2s@2901300 {
+					compatible = "nvidia,tegra234-i2s",
+						     "nvidia,tegra210-i2s";
+					reg = <0x2901300 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_I2S4>,
+						 <&bpmp TEGRA234_CLK_I2S4_SYNC_INPUT>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA234_CLK_I2S4>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S4";
+					status = "disabled";
+				};
+
+				tegra_i2s5: i2s@2901400 {
+					compatible = "nvidia,tegra234-i2s",
+						     "nvidia,tegra210-i2s";
+					reg = <0x2901400 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_I2S5>,
+						 <&bpmp TEGRA234_CLK_I2S5_SYNC_INPUT>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA234_CLK_I2S5>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S5";
+					status = "disabled";
+				};
+
+				tegra_i2s6: i2s@2901500 {
+					compatible = "nvidia,tegra234-i2s",
+						     "nvidia,tegra210-i2s";
+					reg = <0x2901500 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_I2S6>,
+						 <&bpmp TEGRA234_CLK_I2S6_SYNC_INPUT>;
+					clock-names = "i2s", "sync_input";
+					assigned-clocks = <&bpmp TEGRA234_CLK_I2S6>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <1536000>;
+					sound-name-prefix = "I2S6";
+					status = "disabled";
+				};
+
+				tegra_sfc1: sfc@2902000 {
+					compatible = "nvidia,tegra234-sfc",
+						     "nvidia,tegra210-sfc";
+					reg = <0x2902000 0x200>;
+					sound-name-prefix = "SFC1";
+					status = "disabled";
+				};
+
+				tegra_sfc2: sfc@2902200 {
+					compatible = "nvidia,tegra234-sfc",
+						     "nvidia,tegra210-sfc";
+					reg = <0x2902200 0x200>;
+					sound-name-prefix = "SFC2";
+					status = "disabled";
+				};
+
+				tegra_sfc3: sfc@2902400 {
+					compatible = "nvidia,tegra234-sfc",
+						     "nvidia,tegra210-sfc";
+					reg = <0x2902400 0x200>;
+					sound-name-prefix = "SFC3";
+					status = "disabled";
+				};
+
+				tegra_sfc4: sfc@2902600 {
+					compatible = "nvidia,tegra234-sfc",
+						     "nvidia,tegra210-sfc";
+					reg = <0x2902600 0x200>;
+					sound-name-prefix = "SFC4";
+					status = "disabled";
+				};
+
+				tegra_amx1: amx@2903000 {
+					compatible = "nvidia,tegra234-amx",
+						     "nvidia,tegra194-amx";
+					reg = <0x2903000 0x100>;
+					sound-name-prefix = "AMX1";
+					status = "disabled";
+				};
+
+				tegra_amx2: amx@2903100 {
+					compatible = "nvidia,tegra234-amx",
+						     "nvidia,tegra194-amx";
+					reg = <0x2903100 0x100>;
+					sound-name-prefix = "AMX2";
+					status = "disabled";
+				};
+
+				tegra_amx3: amx@2903200 {
+					compatible = "nvidia,tegra234-amx",
+						     "nvidia,tegra194-amx";
+					reg = <0x2903200 0x100>;
+					sound-name-prefix = "AMX3";
+					status = "disabled";
+				};
+
+				tegra_amx4: amx@2903300 {
+					compatible = "nvidia,tegra234-amx",
+						     "nvidia,tegra194-amx";
+					reg = <0x2903300 0x100>;
+					sound-name-prefix = "AMX4";
+					status = "disabled";
+				};
+
+				tegra_adx1: adx@2903800 {
+					compatible = "nvidia,tegra234-adx",
+						     "nvidia,tegra210-adx";
+					reg = <0x2903800 0x100>;
+					sound-name-prefix = "ADX1";
+					status = "disabled";
+				};
+
+				tegra_adx2: adx@2903900 {
+					compatible = "nvidia,tegra234-adx",
+						     "nvidia,tegra210-adx";
+					reg = <0x2903900 0x100>;
+					sound-name-prefix = "ADX2";
+					status = "disabled";
+				};
+
+				tegra_adx3: adx@2903a00 {
+					compatible = "nvidia,tegra234-adx",
+						     "nvidia,tegra210-adx";
+					reg = <0x2903a00 0x100>;
+					sound-name-prefix = "ADX3";
+					status = "disabled";
+				};
+
+				tegra_adx4: adx@2903b00 {
+					compatible = "nvidia,tegra234-adx",
+						     "nvidia,tegra210-adx";
+					reg = <0x2903b00 0x100>;
+					sound-name-prefix = "ADX4";
+					status = "disabled";
+				};
+
+
+				tegra_dmic1: dmic@2904000 {
+					compatible = "nvidia,tegra234-dmic",
+						     "nvidia,tegra210-dmic";
+					reg = <0x2904000 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_DMIC1>;
+					clock-names = "dmic";
+					assigned-clocks = <&bpmp TEGRA234_CLK_DMIC1>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <3072000>;
+					sound-name-prefix = "DMIC1";
+					status = "disabled";
+				};
+
+				tegra_dmic2: dmic@2904100 {
+					compatible = "nvidia,tegra234-dmic",
+						     "nvidia,tegra210-dmic";
+					reg = <0x2904100 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_DMIC2>;
+					clock-names = "dmic";
+					assigned-clocks = <&bpmp TEGRA234_CLK_DMIC2>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <3072000>;
+					sound-name-prefix = "DMIC2";
+					status = "disabled";
+				};
+
+				tegra_dmic3: dmic@2904200 {
+					compatible = "nvidia,tegra234-dmic",
+						     "nvidia,tegra210-dmic";
+					reg = <0x2904200 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_DMIC3>;
+					clock-names = "dmic";
+					assigned-clocks = <&bpmp TEGRA234_CLK_DMIC3>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <3072000>;
+					sound-name-prefix = "DMIC3";
+					status = "disabled";
+				};
+
+				tegra_dmic4: dmic@2904300 {
+					compatible = "nvidia,tegra234-dmic",
+						     "nvidia,tegra210-dmic";
+					reg = <0x2904300 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_DMIC4>;
+					clock-names = "dmic";
+					assigned-clocks = <&bpmp TEGRA234_CLK_DMIC4>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <3072000>;
+					sound-name-prefix = "DMIC4";
+					status = "disabled";
+				};
+
+				tegra_dspk1: dspk@2905000 {
+					compatible = "nvidia,tegra234-dspk",
+						     "nvidia,tegra186-dspk";
+					reg = <0x2905000 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_DSPK1>;
+					clock-names = "dspk";
+					assigned-clocks = <&bpmp TEGRA234_CLK_DSPK1>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <12288000>;
+					sound-name-prefix = "DSPK1";
+					status = "disabled";
+				};
+
+				tegra_dspk2: dspk@2905100 {
+					compatible = "nvidia,tegra234-dspk",
+						     "nvidia,tegra186-dspk";
+					reg = <0x2905100 0x100>;
+					clocks = <&bpmp TEGRA234_CLK_DSPK2>;
+					clock-names = "dspk";
+					assigned-clocks = <&bpmp TEGRA234_CLK_DSPK2>;
+					assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+					assigned-clock-rates = <12288000>;
+					sound-name-prefix = "DSPK2";
+					status = "disabled";
+				};
+
+				tegra_mvc1: mvc@290a000 {
+					compatible = "nvidia,tegra234-mvc",
+						     "nvidia,tegra210-mvc";
+					reg = <0x290a000 0x200>;
+					sound-name-prefix = "MVC1";
+					status = "disabled";
+				};
+
+				tegra_mvc2: mvc@290a200 {
+					compatible = "nvidia,tegra234-mvc",
+						     "nvidia,tegra210-mvc";
+					reg = <0x290a200 0x200>;
+					sound-name-prefix = "MVC2";
+					status = "disabled";
+				};
+
+				tegra_amixer: amixer@290bb00 {
+					compatible = "nvidia,tegra234-amixer",
+						     "nvidia,tegra210-amixer";
+					reg = <0x290bb00 0x800>;
+					sound-name-prefix = "MIXER1";
+					status = "disabled";
+				};
+
+				tegra_admaif: admaif@290f000 {
+					compatible = "nvidia,tegra234-admaif",
+						     "nvidia,tegra186-admaif";
+					reg = <0x0290f000 0x1000>;
+					dmas = <&adma 1>, <&adma 1>,
+					       <&adma 2>, <&adma 2>,
+					       <&adma 3>, <&adma 3>,
+					       <&adma 4>, <&adma 4>,
+					       <&adma 5>, <&adma 5>,
+					       <&adma 6>, <&adma 6>,
+					       <&adma 7>, <&adma 7>,
+					       <&adma 8>, <&adma 8>,
+					       <&adma 9>, <&adma 9>,
+					       <&adma 10>, <&adma 10>,
+					       <&adma 11>, <&adma 11>,
+					       <&adma 12>, <&adma 12>,
+					       <&adma 13>, <&adma 13>,
+					       <&adma 14>, <&adma 14>,
+					       <&adma 15>, <&adma 15>,
+					       <&adma 16>, <&adma 16>,
+					       <&adma 17>, <&adma 17>,
+					       <&adma 18>, <&adma 18>,
+					       <&adma 19>, <&adma 19>,
+					       <&adma 20>, <&adma 20>;
+					dma-names = "rx1", "tx1",
+						    "rx2", "tx2",
+						    "rx3", "tx3",
+						    "rx4", "tx4",
+						    "rx5", "tx5",
+						    "rx6", "tx6",
+						    "rx7", "tx7",
+						    "rx8", "tx8",
+						    "rx9", "tx9",
+						    "rx10", "tx10",
+						    "rx11", "tx11",
+						    "rx12", "tx12",
+						    "rx13", "tx13",
+						    "rx14", "tx14",
+						    "rx15", "tx15",
+						    "rx16", "tx16",
+						    "rx17", "tx17",
+						    "rx18", "tx18",
+						    "rx19", "tx19",
+						    "rx20", "tx20";
+					status = "disabled";
+				};
+			};
+
+			adma: dma-controller@2930000 {
+				compatible = "nvidia,tegra234-adma",
+					     "nvidia,tegra186-adma";
+				reg = <0x02930000 0x20000>;
+				interrupt-parent = <&agic>;
+				interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+					      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				#dma-cells = <1>;
+				clocks = <&bpmp TEGRA234_CLK_AHUB>;
+				clock-names = "d_audio";
+				status = "disabled";
+			};
+
+			agic: interrupt-controller@2a40000 {
+				compatible = "nvidia,tegra234-agic",
+					     "nvidia,tegra210-agic";
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				reg = <0x02a41000 0x1000>,
+				      <0x02a42000 0x2000>;
+				interrupts = <GIC_SPI 145
+					      (GIC_CPU_MASK_SIMPLE(4) |
+					       IRQ_TYPE_LEVEL_HIGH)>;
+				clocks = <&bpmp TEGRA234_CLK_APE>;
+				clock-names = "clk";
+				status = "disabled";
+			};
+		};
+
 		ethernet@2310000 {
 			compatible = "nvidia,tegra234-eqos", "nvidia,tegra186-eqos",
 				     "snps,dwc-qos-ethernet-4.10";
-- 
2.7.4

