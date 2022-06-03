Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A981753C509
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbiFCGhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbiFCGhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:37:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323B16269;
        Thu,  2 Jun 2022 23:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPkQKXXFSJOIXeRP5p8VW8JDwKjEzDCgQuuphHr7ajBs6SMA+KYk60iNn3NHBQlEBkTBiLaCEnN7KYBfkqatHuRxFHyDqWwpnRusGZcpAA7sYBl+rtcjZdX3IHbH0gkrq4yXcRxJFlfON4HvUb1aPUUP+ma0Q2ENIRVuxr6jCeIizXQ17Ago7LRfLc3XIruyEasLFElW8JrZYWCyH1C763EsRZEPiyVBXv6xkvlX3RP5B+DulMOc5gALow+k6ujZx6Hmvk8nnFWNjp7lz4ETpY/AIGCa14fmUPT8yY9LxqVxoLV328f6JpkWqDL+TVhb81ra+puCUyM6Sx8s9DU/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ8gkYjQTPE4SOVgYS9rPRHYZwXubcDQdkDVCiW0s7o=;
 b=YErmznFDKxtMGbgKdDCMSwdVwsDGAONwSNKc/w+T0X6OttX2XVWvbt5Twdt2FMhYpw4ml/vz19Nn7jfdR0aGvTFKREOwxFaqzgRVjbnd3vFUBh3I26SJx25rLFfmRRObrt1YVdbsuR2IBsjn+8h1Ic49HEog2K7qkQJYS+4qijnZt7+itzF2evwr2vqfFSrEKyvY8XC+A5t1dlwN7X6a8Gkp5SticYxwJ30MoV8EH5rO5afaWDs6OYAqA5M7EQQQKtbV3wh/KCe5f0QJC1zxjmrEQwb1pgD8xysIevK8pcHrlt7nGXLXOYxHW9HlGyqwCxJk+DNczeqKxrO4jn/1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ8gkYjQTPE4SOVgYS9rPRHYZwXubcDQdkDVCiW0s7o=;
 b=byKQXIi1TWPAi1vLZkpt00/20/QOAjWmDxSu1YHdu3b7QPItqIVtYStwYHb5CvBsjuprOzGzSQRw27ghE5w/0rlL+1YWZTw6a+DC12WTJdMZuXPt+4xfeQ0+BLz3qtEkTGLkckDd3zTjXcys+X7SePPkloRq65e4Q54Vr6nnECoQhJng6+A/V3SCh+wpVeyoi1AAGd6ZAt9VW2RPjWbivRSPUfXMDu8LxhXxwix+iSSXEMqTo+y1MwqRXoPXfwyF0XXNWOCd6bpmm4MHtAypnIm/daXMqZlTc9JHjdDZD/xeQUVk899gNpSL8V//AvgrnJrzrHWzbb2uiWz9F7hoFQ==
Received: from BN6PR19CA0078.namprd19.prod.outlook.com (2603:10b6:404:133::16)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 06:36:52 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::af) by BN6PR19CA0078.outlook.office365.com
 (2603:10b6:404:133::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Fri, 3 Jun 2022 06:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 06:36:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 3 Jun
 2022 06:36:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 2 Jun 2022
 23:36:50 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 2 Jun 2022 23:36:46 -0700
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
Subject: [PATCH v3 6/6] arm64: tegra: Enable OPE on various platforms
Date:   Fri, 3 Jun 2022 12:06:12 +0530
Message-ID: <1654238172-16293-7-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
References: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0846fa38-3318-4c83-5eab-08da452b71fd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4565:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4565D4ACBE75EE63E83A5D77A7A19@MN2PR12MB4565.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17FPnc/L9JOjPiPjkjJVDDwk0tptBynbfa+AmgQeYzmh/Quyzrry+9S7MHbFqhyn6nIjKPjXTEyBjoSQ75jC707DBIE40QXqVMrm75OztKTIUhEnBM/NvNF/As6eiiMUAHBB4nQjqKE9c5Da1rApowPVORuiHEr3/Lox637KBKszApZq3aerTIMESwb6CAqa4h1P7Gyofr/hQO5AXQ2coiYDudD9mGRRr6nvaDl2hfUcBq284iUICKe0AEFLqv9Qv8ubv0zBgPfk2i+th/lZqIT/+Jg4yO39k+v4PEufJYflMRH3N6JiXPFf1/mXirpwU3K1jn9Re2iKgJUzOf1p5jkD5sru71YJvLi6rGIreSdOFZydY/QaQoEW1tcXGuGaA3cN8iWb1rpbpAvbuSgRjfu7H+jloBvCp/NpEvr3tqMl00lMwN+4a4p2SNSfRLZRbxJJOl0tmd6hlj0km7sv50kP7368cYkyqv/7ETnzSWNq4SBP/oEHV9gh2k92Guonl5j0CndZJ9WxjwA5qJKwNIjiYBINCZwRKkmZpOfxtdAiBDVvxoLsGp+F2S/IPoRpiXB2naHstDuhWZXp3dImnEyNqc1/lCZYXTTqnoJD7bsxKCplgZZe2cD1TFPCdlsd530FRcQdF0gIyOp0BlJgNdMjQ0bEtfWssRmBk2bLNu3XqNqtGEQPoJAV9feg5zJsG8QP2p7/kHPpDAhth9SXfw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(36860700001)(4326008)(8676002)(2616005)(186003)(81166007)(70586007)(70206006)(8936002)(36756003)(40460700003)(86362001)(54906003)(110136005)(356005)(82310400005)(30864003)(5660300002)(2906002)(7416002)(47076005)(6666004)(7696005)(508600001)(26005)(107886003)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 06:36:52.2499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0846fa38-3318-4c83-5eab-08da452b71fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 70737a0..bd18977 100644
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
 
+			processing-engine@2908000 {
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
index bce518a..fafd707 100644
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
 
+				processing-engine@2908000 {
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
index 7acc32d..4cee935 100644
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
 
+				processing-engine@2908000 {
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
index 328fbfe..1e26ca9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -682,6 +682,56 @@
 				};
 			};
 
+			processing-engine@702d8000 {
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
+			processing-engine@702d8400 {
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
index 746bd52..749b44c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -1074,6 +1074,56 @@
 				};
 			};
 
+			processing-engine@702d8000 {
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
+			processing-engine@702d8400 {
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
index eaf1994..3f6c399 100644
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
 
+				processing-engine@2908000 {
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
 
@@ -2044,6 +2085,7 @@
 		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
 		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
 		       <&xbar_asrc_in7_port>,
+		       <&xbar_ope1_in_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -2062,6 +2104,7 @@
 		       <&mix_out4_port>, <&mix_out5_port>,
 		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
 		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
+		       <&ope1_out_port>,
 		       /* BE I/O Ports */
 		       <&i2s1_port>, <&i2s2_port>, <&i2s4_port>, <&i2s6_port>,
 		       <&dmic3_port>;
-- 
2.7.4

