Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF38E52C17D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbiERRi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiERRit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:38:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2072.outbound.protection.outlook.com [40.107.101.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02921216070;
        Wed, 18 May 2022 10:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KN/hy09GHQl3Y64v7HI5e6+82/Vo3ePG1ZSj+FhvbcqvEapr3onF0PB93iRoZAZbdTA7IFzijv7V0xb+H5IZA8OHZPCT38aVO7Y451DRaASJFrsTemFy047c7o/fWBNRbMjI1m2zidb6XUX2pOFQ2wV0M5rVtZ+BlvT8dnnAYZN3LgRsUYHr13yI1MXzBosm7s2I+OBC0oSNjO4KmGVzO6qLGeLB6l2CU5z/ImXeR7b4DDbrkduq58jZ+4sW1KbPCnIv//BrcxyeLM47GvuVQnxProFb1IYPDB2HIccwcRBYpalvfWy7AuxOOswKzE5kf6vObkC5SQC+WuWh5HGy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L7XCwYBJX/gpQ2CU13ea8VwmgvJ3GTqFW0xPlK4VS4=;
 b=XDBNmGkSp58wtzMJTF/LVnggtXaSvxMpObIUij6urSn9HDu6Vr7BeIw65abvZv5Yai+uJkR2Mb4nFA1GM2uuShRTbp6uU42jrbjgWkP7XZ/qs/pmkA0gqaLOG3e+lo2hKbfD4AW5yAPBS0DaP5G6M7p3OnKZFWC2zI0bSuFY0LYwg55njUHs5WDNVZX8jzCZ1RSNNkNWydTJ0O1F+IDvv6ovvxpPGQI3hzLIfY/xGBMdZGoQEqF+9V7WUIRKsukJgsJvQICp/u2r5U138vKIQkzt9luAO/sr+cH47EhRJ+5SpCebjQq8MMokkzrPQ6P14CN68FjgOCsc8jEGDckvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8L7XCwYBJX/gpQ2CU13ea8VwmgvJ3GTqFW0xPlK4VS4=;
 b=rgoPZjVTMZ19Sd3ERHqMfaAVKHsIfLU+bdyt7S1V5xBia3m/eAIsqY2IdA6s4bDEAT+ugDU/bfBmjN2QsGBKDK42te6ro9fGtzVLBUk/OMULxrdgjIlKUm1U0JHsRf05dsKCAcpWP4rTlk2x6asNMWQK0FQz1kSvcfmVJf4Fd9zuYF730aSDZGhjyvDZT7Hzi2OHvy3e8DkGKnKOrgf8xL2Sbt6l7UBmicH9/zK8qy7NfGG1Fn1z7VVGbs6+JwcTnYk/RkeQNLGu/HtGPmKxHIieZyB3bnRRHB7stAEvqCWwbdk12r599Egtf2m2TO+RT5OWB7pLDkRCBnSK5J+ZhA==
Received: from DM6PR10CA0019.namprd10.prod.outlook.com (2603:10b6:5:60::32) by
 BN6PR1201MB2530.namprd12.prod.outlook.com (2603:10b6:404:b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 17:38:39 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::33) by DM6PR10CA0019.outlook.office365.com
 (2603:10b6:5:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Wed, 18 May 2022 17:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 17:38:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 17:38:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 10:38:37 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 18 May
 2022 10:38:33 -0700
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
Subject: [PATCH 6/6] arm64: tegra: Enable OPE on various platforms
Date:   Wed, 18 May 2022 23:06:12 +0530
Message-ID: <1652895372-29885-7-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
References: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e947a4e0-9a77-4c97-76ee-08da38f53e7a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2530:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB253032DAE3873443C72E3AECA7D19@BN6PR1201MB2530.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbcZVmX0mm4FsZobT75j4N8noXXLNW4icCoCYXIME8ZZwRDtNAPg2N+5VCjZHp2xJ1U0w7GNRzI8lNccsIGSUY/edPuT8ltqWdI4dUgmiFClQ1tXlv8OvVZRiJ+grqRwACAStFjnwgyBIWQ5AD/2r2SiDs8mWSIpvI+/JKt4XSqst+3Xd1Y6BV0gXg2q7iEVOYbTIQkGH1p9xq+E9oNbRp83XFeFIN8Q9KQSWwgP6wWYriUdYmJUgggqTkO/RjPX6QLeCvuPeo9qm31FnvKwihjKJaGzDxUDdPOzppRc2jUj6Swp4vMSMyZLlYmAAxunCelLQTqKqIaI5XDjD5ePBPAMnMCaDpizj1lH4FE3LrP9mfa7wa6Acm6UbsSQtq+xADMZS22QxLYa5AJruSgCRWEQKnbIJxkKMQwrQVtBaYLgJ+UDZcjNgzL9Id67JbKcLxmi0iPpabdnqSzTTV3K8WEMq4m6OrJnTf2wcwqWD9Jw0ytY9EbWv1TMSuE4SJrSXWt3DdovioiSIum15H7Ks2qo9TjNkR8NrT4kbPJpyDRwbrZBQBHGqMlpE0psCDFA+Yh8VAs2GLmeTlsT/ESr9l8njXxau1h5ZwIc7tuOE2pCzckM5t684JwVCf7+i/HC55k7w6w4eYgaXAJMbNTN3XiRx8bPBdLPtuWm5xKu/rzIRo9+VA2O2vazni7iV9uOI6N9LtHlw0qEsXQU8OxFlQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(70586007)(70206006)(186003)(2616005)(36756003)(8676002)(426003)(47076005)(336012)(36860700001)(107886003)(8936002)(40460700003)(54906003)(110136005)(30864003)(26005)(82310400005)(6666004)(356005)(2906002)(7416002)(508600001)(7696005)(316002)(81166007)(5660300002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 17:38:39.0984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e947a4e0-9a77-4c97-76ee-08da38f53e7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2530
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable OPE module usage on various Jetson platforms. This can be plugged
into an audio path using ALSA mixer controls. Add audio-graph-port binding
to use OPE device with generic audio-graph based sound card.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 43 +++++++++++
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 43 +++++++++++
 .../arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi | 43 +++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 84 ++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 84 ++++++++++++++++++++++
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  | 43 +++++++++++
 6 files changed, 340 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index 70737a0..05543c3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -915,6 +915,22 @@
 						remote-endpoint = <&asrc_in7_ep>;
 					};
 				};
+
+				xbar_ope1_in_port: port@70 {
+					reg = <0x70>;
+
+					xbar_ope1_in_ep: endpoint {
+						remote-endpoint = <&ope1_cif_in_ep>;
+					};
+				};
+
+				port@71 {
+					reg = <0x71>;
+
+					xbar_ope1_out_ep: endpoint {
+						remote-endpoint = <&ope1_cif_out_ep>;
+					};
+				};
 			};
 
 			admaif@290f000 {
@@ -1911,6 +1927,31 @@
 				};
 			};
 
+			ope@2908000 {
+				status = "okay";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0x0>;
+
+						ope1_cif_in_ep: endpoint {
+							remote-endpoint = <&xbar_ope1_in_ep>;
+						};
+					};
+
+					ope1_out_port: port@1 {
+						reg = <0x1>;
+
+						ope1_cif_out_ep: endpoint {
+							remote-endpoint = <&xbar_ope1_out_ep>;
+						};
+					};
+				};
+			};
+
 			amixer@290bb00 {
 				status = "okay";
 
@@ -2552,6 +2593,7 @@
 		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
 		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
 		       <&xbar_asrc_in7_port>,
+		       <&xbar_ope1_in_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -2571,6 +2613,7 @@
 		       <&mixer_out5_port>,
 		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
 		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
+		       <&ope1_out_port>,
 		       /* I/O */
 		       <&i2s1_port>, <&i2s2_port>, <&i2s3_port>, <&i2s4_port>,
 		       <&i2s5_port>, <&i2s6_port>, <&dmic1_port>, <&dmic2_port>,
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 7df8983..151c3d2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -868,6 +868,22 @@
 							remote-endpoint = <&asrc_in7_ep>;
 						};
 					};
+
+					xbar_ope1_in_port: port@70 {
+						reg = <0x70>;
+
+						xbar_ope1_in_ep: endpoint {
+							remote-endpoint = <&ope1_cif_in_ep>;
+						};
+					};
+
+					port@71 {
+						reg = <0x71>;
+
+						xbar_ope1_out_ep: endpoint {
+							remote-endpoint = <&ope1_cif_out_ep>;
+						};
+					};
 				};
 
 				admaif@290f000 {
@@ -1710,6 +1726,31 @@
 					};
 				};
 
+				ope@2908000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							ope1_cif_in_ep: endpoint {
+								remote-endpoint = <&xbar_ope1_in_ep>;
+							};
+						};
+
+						ope1_out_port: port@1 {
+							reg = <0x1>;
+
+							ope1_cif_out_ep: endpoint {
+								remote-endpoint = <&xbar_ope1_out_ep>;
+							};
+						};
+					};
+				};
+
 				amixer@290bb00 {
 					status = "okay";
 
@@ -2273,6 +2314,7 @@
 		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
 		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
 		       <&xbar_asrc_in7_port>,
+		       <&xbar_ope1_in_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -2291,6 +2333,7 @@
 		       <&mixer_out4_port>, <&mixer_out5_port>,
 		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
 		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
+		       <&ope1_out_port>,
 		       /* BE I/O Ports */
 		       <&i2s1_port>, <&i2s2_port>, <&i2s4_port>, <&i2s6_port>,
 		       <&dmic3_port>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
index 7acc32d..35c50fe 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
@@ -878,6 +878,22 @@
 							remote-endpoint = <&asrc_in7_ep>;
 						};
 					};
+
+					xbar_ope1_in_port: port@70 {
+						reg = <0x70>;
+
+						xbar_ope1_in_ep: endpoint {
+							remote-endpoint = <&ope1_cif_in_ep>;
+						};
+					};
+
+					port@71 {
+						reg = <0x71>;
+
+						xbar_ope1_out_ep: endpoint {
+							remote-endpoint = <&ope1_cif_out_ep>;
+						};
+					};
 				};
 
 				admaif@290f000 {
@@ -1770,6 +1786,31 @@
 					};
 				};
 
+				ope@2908000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							ope1_cif_in_ep: endpoint {
+								remote-endpoint = <&xbar_ope1_in_ep>;
+							};
+						};
+
+						ope1_out_port: port@1 {
+							reg = <0x1>;
+
+							ope1_cif_out_ep: endpoint {
+								remote-endpoint = <&xbar_ope1_out_ep>;
+							};
+						};
+					};
+				};
+
 				amixer@290bb00 {
 					status = "okay";
 
@@ -2323,6 +2364,7 @@
 		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
 		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
 		       <&xbar_asrc_in7_port>,
+		       <&xbar_ope1_in_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -2342,6 +2384,7 @@
 		       <&mixer_out5_port>,
 		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
 		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
+		       <&ope1_out_port>,
 		       /* BE I/O Ports */
 		       <&i2s3_port>, <&i2s5_port>,
 		       <&dmic1_port>, <&dmic2_port>, <&dmic4_port>,
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 328fbfe..55dcbf6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -682,6 +682,56 @@
 				};
 			};
 
+			ope@702d8000 {
+				status = "okay";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0x0>;
+
+						ope1_cif_in_ep: endpoint {
+							remote-endpoint = <&xbar_ope1_in_ep>;
+						};
+					};
+
+					ope1_out_port: port@1 {
+						reg = <0x1>;
+
+						ope1_cif_out_ep: endpoint {
+							remote-endpoint = <&xbar_ope1_out_ep>;
+						};
+					};
+				};
+			};
+
+			ope@702d8400 {
+				status = "okay";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0x0>;
+
+						ope2_cif_in_ep: endpoint {
+							remote-endpoint = <&xbar_ope2_in_ep>;
+						};
+					};
+
+					ope2_out_port: port@1 {
+						reg = <0x1>;
+
+						ope2_cif_out_ep: endpoint {
+							remote-endpoint = <&xbar_ope2_out_ep>;
+						};
+					};
+				};
+			};
+
 			amixer@702dbb00 {
 				status = "okay";
 
@@ -1251,6 +1301,38 @@
 						remote-endpoint = <&mixer_out5_ep>;
 					};
 				};
+
+				xbar_ope1_in_port: port@41 {
+					reg = <0x41>;
+
+					xbar_ope1_in_ep: endpoint {
+						remote-endpoint = <&ope1_cif_in_ep>;
+					};
+				};
+
+				port@42 {
+					reg = <0x42>;
+
+					xbar_ope1_out_ep: endpoint {
+						remote-endpoint = <&ope1_cif_out_ep>;
+					};
+				};
+
+				xbar_ope2_in_port: port@43 {
+					reg = <0x43>;
+
+					xbar_ope2_in_ep: endpoint {
+						remote-endpoint = <&ope2_cif_in_ep>;
+					};
+				};
+
+				port@44 {
+					reg = <0x44>;
+
+					xbar_ope2_out_ep: endpoint {
+						remote-endpoint = <&ope2_cif_out_ep>;
+					};
+				};
 			};
 		};
 	};
@@ -1281,6 +1363,7 @@
 		       <&xbar_mixer_in5_port>, <&xbar_mixer_in6_port>,
 		       <&xbar_mixer_in7_port>, <&xbar_mixer_in8_port>,
 		       <&xbar_mixer_in9_port>, <&xbar_mixer_in10_port>,
+		       <&xbar_ope1_in_port>, <&xbar_ope2_in_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -1293,6 +1376,7 @@
 		       <&mixer_out1_port>, <&mixer_out2_port>,
 		       <&mixer_out3_port>, <&mixer_out4_port>,
 		       <&mixer_out5_port>,
+		       <&ope1_out_port>, <&ope2_out_port>,
 		       /* I/O DAP Ports */
 		       <&i2s1_port>, <&i2s2_port>, <&i2s3_port>, <&i2s4_port>,
 		       <&i2s5_port>, <&dmic1_port>, <&dmic2_port>, <&dmic3_port>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index 746bd52..1c6882d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -1074,6 +1074,56 @@
 				};
 			};
 
+			ope@702d8000 {
+				status = "okay";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0x0>;
+
+						ope1_cif_in_ep: endpoint {
+							remote-endpoint = <&xbar_ope1_in_ep>;
+						};
+					};
+
+					ope1_out_port: port@1 {
+						reg = <0x1>;
+
+						ope1_cif_out_ep: endpoint {
+							remote-endpoint = <&xbar_ope1_out_ep>;
+						};
+					};
+				};
+			};
+
+			ope@702d8400 {
+				status = "okay";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0x0>;
+
+						ope2_cif_in_ep: endpoint {
+							remote-endpoint = <&xbar_ope2_in_ep>;
+						};
+					};
+
+					ope2_out_port: port@1 {
+						reg = <0x1>;
+
+						ope2_cif_out_ep: endpoint {
+							remote-endpoint = <&xbar_ope2_out_ep>;
+						};
+					};
+				};
+			};
+
 			amixer@702dbb00 {
 				status = "okay";
 
@@ -1611,6 +1661,38 @@
 						remote-endpoint = <&mixer_out5_ep>;
 					};
 				};
+
+				xbar_ope1_in_port: port@41 {
+					reg = <0x41>;
+
+					xbar_ope1_in_ep: endpoint {
+						remote-endpoint = <&ope1_cif_in_ep>;
+					};
+				};
+
+				port@42 {
+					reg = <0x42>;
+
+					xbar_ope1_out_ep: endpoint {
+						remote-endpoint = <&ope1_cif_out_ep>;
+					};
+				};
+
+				xbar_ope2_in_port: port@43 {
+					reg = <0x43>;
+
+					xbar_ope2_in_ep: endpoint {
+						remote-endpoint = <&ope2_cif_in_ep>;
+					};
+				};
+
+				port@44 {
+					reg = <0x44>;
+
+					xbar_ope2_out_ep: endpoint {
+						remote-endpoint = <&ope2_cif_out_ep>;
+					};
+				};
 			};
 		};
 	};
@@ -1884,6 +1966,7 @@
 		       <&xbar_mixer_in5_port>, <&xbar_mixer_in6_port>,
 		       <&xbar_mixer_in7_port>, <&xbar_mixer_in8_port>,
 		       <&xbar_mixer_in9_port>, <&xbar_mixer_in10_port>,
+		       <&xbar_ope1_in_port>, <&xbar_ope2_in_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -1896,6 +1979,7 @@
 		       <&mixer_out1_port>, <&mixer_out2_port>,
 		       <&mixer_out3_port>, <&mixer_out4_port>,
 		       <&mixer_out5_port>,
+		       <&ope1_out_port>, <&ope2_out_port>,
 		       /* I/O DAP Ports */
 		       <&i2s3_port>, <&i2s4_port>,
 		       <&dmic1_port>, <&dmic2_port>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 14289f86..83c566c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -867,6 +867,22 @@
 							remote-endpoint = <&asrc_in7_ep>;
 						};
 					};
+
+					xbar_ope1_in_port: port@70 {
+						reg = <0x70>;
+
+						xbar_ope1_in_ep: endpoint {
+							remote-endpoint = <&ope1_cif_in_ep>;
+						};
+					};
+
+					port@71 {
+						reg = <0x71>;
+
+						xbar_ope1_out_ep: endpoint {
+							remote-endpoint = <&ope1_cif_out_ep>;
+						};
+					};
 				};
 
 				i2s@2901000 {
@@ -1490,6 +1506,31 @@
 					};
 				};
 
+				ope@2908000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							ope1_cif_in_ep: endpoint {
+								remote-endpoint = <&xbar_ope1_in_ep>;
+							};
+						};
+
+						ope1_out_port: port@1 {
+							reg = <0x1>;
+
+							ope1_cif_out_ep: endpoint {
+								remote-endpoint = <&xbar_ope1_out_ep>;
+							};
+						};
+					};
+				};
+
 				mvc@290a000 {
 					status = "okay";
 
@@ -2045,6 +2086,7 @@
 		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
 		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
 		       <&xbar_asrc_in7_port>,
+		       <&xbar_ope1_in_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -2063,6 +2105,7 @@
 		       <&mix_out4_port>, <&mix_out5_port>,
 		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
 		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
+		       <&ope1_out_port>,
 		       /* BE I/O Ports */
 		       <&i2s1_port>, <&i2s2_port>, <&i2s4_port>, <&i2s6_port>,
 		       <&dmic3_port>;
-- 
2.7.4

