Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73449F997
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348577AbiA1MiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:38:25 -0500
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:10281
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348557AbiA1MiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:38:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGanqivB0yUGPIuvy0TQVSuPmGzALGXmV2TmpobNWkf85/4xOFhSUY+I25dLf0h+vy+NLECKlPjwkk6T98dUUsn+fSDv27b/Dmtj6tN44rrTC5FdeJ6y0KMEJXH67E8RbVxmZVAzFt9LberibqQjiP2w2HmMVhsCtkw3Y0cRTAWmnLJIwkIjJ9y9sT/W39t354r/bkERU0kBxOy1mAWdknzLsL8MGn2yj3s1zKbT77/IVGMq6AuM1SN+dn1odZ3/3mQhITnN6XkVMeRyWzGy/ANuQpMvAJlqOoJEUAIBg2SRMbUMupnfU1UgOk64EbxCFnWLbM/RGk4yzCuvcLIaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b3fUkH17fwX22uoTRF5TuBy1N/DMoYxmUkGxXxIDRM=;
 b=SvYKRr/nhLJCDQIPdUdw4avuj6zEXtVXFNnXkVkWz+F4fF2YsrpCSVq5tUoP0ry10N+InopjUsf5FTxLZZF1IjT8I2yyd+V6Fh3jU3X2H70fHnfyKltJJCgB/t4KjWFr3G5FX0d0dNxYGNEhzT3NMQNu6TmX8eKnjKvPubxaZPnMZLEJHuBRSY6WqvVfF/wA1siczpOhzcSLHriKDiAR0vuEUbx+faq7eJ2xWz20i9wMqf2wOs24PlbewYNQU/dKOtJHq3eUj+ZYgryhY/hhIe7nNKc4077AixXdesmXw+c2RRiUYr+rHx703Anc69QYY0Xtck9RlO+O985eTj0SNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b3fUkH17fwX22uoTRF5TuBy1N/DMoYxmUkGxXxIDRM=;
 b=p3urFvkvt+c0I2oby09NhkEkEX4HyGOKW/+sWOC+oRNvy0d6SSmJCqY0NzkOIc1guIp4smTi0P0bJpVt39sirR7A/dXqpnpICPOULBO1HckwLzoHe++shKTQFIjCXIGWItVCc1E7cINT9EQoLUDL7rwU2Nx9nFQLdkD/Y4r009kXDQZNM1pp8hdT/XKo/jT9KT1Rg4ODtRNlGy37i2YqWt0q/uJ/GSMeJqCfO5D35QdzKUNhz+83FG87EmfH5ugfB+jldowSHQd6imzkPyhBN2ZfNdE3p+PB8RkwgPK5V3nf9p1P3qIQ1saXduKSFCH1i7AFg7lEeH+qWBbdSQhyZA==
Received: from BN8PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:d4::12)
 by DM5PR12MB2455.namprd12.prod.outlook.com (2603:10b6:4:b7::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 12:38:22 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::9f) by BN8PR04CA0038.outlook.office365.com
 (2603:10b6:408:d4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 12:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 12:38:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Fri, 28 Jan 2022 12:38:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Fri, 28 Jan 2022 04:38:20 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 28 Jan 2022 04:38:17 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 4/5] arm64: tegra: Add audio devices on Tegra234
Date:   Fri, 28 Jan 2022 18:07:55 +0530
Message-ID: <1643373476-8538-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
References: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5a16a42-702b-4974-3c1f-08d9e25b1203
X-MS-TrafficTypeDiagnostic: DM5PR12MB2455:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2455133EADAEE689FA6E372EA7229@DM5PR12MB2455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAXug9JTXrP61UvqjNxIL+nCqypWI9DX0WnH+qV8BB4sXXeErDBBPnym1Nleiqk5Ip+Gt9SFbNH/+OTvJogPnKhTFe3W0Oy1p/dA8PNt4y3LYOWD+cS8ADPYQO9Ay14os3eGHXdN3OYOHA87y/t0bkui91SbnSoOvbctfrSjX4/lROCnAJkwfgM0VT9CUgKFdeXKHHkLczsCKA34SHcFGRcKw8+RUb/7qp6UjINmkMhoQi+J4xbPr7vG2EhK3cCIHqeiGwJftq/3Muos0416qZ4Ornp9iLkHMWohRq/Vj5Ms8yKmSeqKIXSsOsAq7GsD7yWBMoASh7jcyETdorNaHn6vPufQLKOnxCU4v77Me0ClNQ70OSCw3lszQlBjni8Acljzd4XZuDNlRVKxr7KX7sJTS8iL4sXU1KL8lXXm5Px675vFZiJIiKOpKF/hd7hRBUjWXb1/LSRS905MJ836wNtDJH2Vn7Y7i2L3Ur90jJDcrssuX/JYxt+9NWdYzBdBNjf93qcij1N78U6CAB/ejW/kCXzTrCt4gN+3WcClBa9BH2U3D0i9aEMGiCw1SE328eaOpTchxyHZrOhrjKLaThLgn7oPfgqdKzjPE/oqgB5RyS5gAuSzzibEBtLTFkIYety21/SmZUEjB94ZEmkJu6XoY6eiQuWvAwY/2ybpps5nokjpyqlXTLEMw6rN8FNd7eQH5/AdWtLgKWg+TOYC9uCvIDG2G2/ZnHOdtb8GAnfT0Hn2HHlvMkxIvfCWA/enP9QnMr6sf7b+aow8K7zIzmR8u2f097BBlcqvbZkB9NY=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(110136005)(40460700003)(30864003)(5660300002)(70206006)(2906002)(54906003)(83380400001)(86362001)(6666004)(82310400004)(336012)(81166007)(356005)(26005)(426003)(7696005)(107886003)(7416002)(186003)(36860700001)(316002)(36756003)(8676002)(47076005)(508600001)(70586007)(8936002)(4326008)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 12:38:21.9239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a16a42-702b-4974-3c1f-08d9e25b1203
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add following devices which are part of APE subsystem
 * ACONNECT, AGIC and ADMA
 * AHUB and children (ADMAIF, I2S, DMIC, DSPK, MVC, SFC,
   AMX, ADX and Mixer)

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 415 +++++++++++++++++++++++++++++++
 1 file changed, 415 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 6b6f1580..42658e6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 #include <dt-bindings/memory/tegra234-mc.h>
+#include <dt-bindings/power/tegra234-powergate.h>
 #include <dt-bindings/reset/tegra234-reset.h>
 
 / {
@@ -19,6 +20,420 @@
 
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
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
 		misc@100000 {
 			compatible = "nvidia,tegra234-misc";
 			reg = <0x00100000 0xf000>,
-- 
2.7.4

