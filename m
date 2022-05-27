Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C59535E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbiE0K10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350993AbiE0K1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:27:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B9A111BB0;
        Fri, 27 May 2022 03:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5IRbUemYDp0mOHpZgZ7PnKMU4+JR4PpOspWzTgeI2KlWGbBklxd251Gn7/wt1cZIMeLaijk6GgBAuZn66c1WXmTfO7C22XVGyvIq77D6fjpv2UWfx94Pqy9X4/pi18z7OKJAkGezJtLwcTPcWsygW0zXcPERDyq40brf/olVsbos+WFN4uMwgydkkk9cMh0wStLDHlDLZtOml7WaBRUOBH//JuuZKa7ccyQKwF6E+BpMJV8BHUc8WgTringRIC1zpD4G5IT/yqCL8Qk2k5BLwsmleU2L+zHWfj+S7XhpNVy+ZVUIEVf+3xC4P7/gQavJsU8h58uIZ3W1kLqKN86kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ8gkYjQTPE4SOVgYS9rPRHYZwXubcDQdkDVCiW0s7o=;
 b=UOcnTpZVcPS/EHsV0ZjPjR6KqlmdFoFlblTuewmsTGda6Mp5Z3PqEHfdr+p267b44p2e0wnPQeo5ZtxPUujPNwaswVvEYhW9UknLU7d667OlQ4VdBuWDDBskAjmw+5aR231VQa2w2cjVLs+6J72L7uXQvny5KrO6jenqjdTOdiUSHjrHgyARCz4cUa2rvUUgV8oYuONtEhvbyzJvCh0z1Loc00WTWJwmVOxLxD1YEfAYR/TD46PnZv8kJ4ngRIfiTS5dP0b6SUA3Oenn5TnMHQp4wfEmZeqFoD3x/kH0Su1puyjPWR/pHmOax1iy4FZ41uSxzNqrew36Tr5pROTqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ8gkYjQTPE4SOVgYS9rPRHYZwXubcDQdkDVCiW0s7o=;
 b=fnPgIq6g7Fy3lH8+0n0oehOzfrDOfwNdIYP8r+G72jC1lD5RlS0HgEBOkPUqFOP6NOFFOBWXEnbZue49OYB+5eZ1GKlS9yAbBDyvCLnt17Xg/Ds0+uH46cD2q2vcujOERnEVDPJql226HX2AqiPmLYs9RkI7vL8LEsx15HEvxVm7napBP9PzAUojV3kTz6SthJf4azeCG4eji++G/NujIq2ugB6ujNryWoxw2cwkl/uf7x8/gKMQk7WD7sfdfgTz2aysMjudhWejq5OtbLU+vGNyDHH/hcEaUVV2Tz6HKjM17o2cGZeWY8hTru66hp7dIt8Z60IUdpuAPGgm0CycHw==
Received: from MW3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:303:2b::10)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 10:26:49 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::a8) by MW3PR05CA0005.outlook.office365.com
 (2603:10b6:303:2b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Fri, 27 May 2022 10:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5293.13 via Frontend Transport; Fri, 27 May 2022 10:26:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 27 May
 2022 10:26:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 27 May
 2022 03:26:47 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Fri, 27 May
 2022 03:26:43 -0700
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
Subject: [PATCH v2 6/6] arm64: tegra: Enable OPE on various platforms
Date:   Fri, 27 May 2022 15:56:12 +0530
Message-ID: <1653647172-2569-7-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653647172-2569-1-git-send-email-spujar@nvidia.com>
References: <1653647172-2569-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff6ca903-1d53-42eb-e96e-08da3fcb688a
X-MS-TrafficTypeDiagnostic: CY5PR12MB6622:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6622DD96FF3D7FDC535EC7A7A7D89@CY5PR12MB6622.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpyRllgpX+xzSzyCw/WqO3ogE/hiAz5t2iuSAJbejhus5ALrvQGF/vMoEMcTGmH9domr+UrO3sYe/B2p1yvqq/JiInDH49JLE37TyWYG1zSNV5z+/rrZWIRrYho8ka//t1Iwk+ijNShhDn/UfeAQoYiWSI7d/hH3/p1EMvQNA+wW/9FKpJsG4le9+9L0T7fkA0Rodenu08dErvqgzdwE8+v/ywp+8wai0B6clBDzPfNDDQb4XhhQMg+DspnyFOI5XcQjyhKh+1NivnyXIYvEYkf1FkkIGrIY7BOfGrizsX5xlEZ9ZW4mgC2iFPV6YW0QeBKLXRfG3afbqt0gE2bmd5yN490PARGxVq4LObfIIBkOmPxYflgoZpcKSHul2LoBBnW5DrlCL1MD8YJuewg3WvwfPMmRO9ummyqyVVwOCb46LanuH6U2ZBkddjv/SSA4mnKsrRI0bcajvv9plM2+CaS+zLL5XJ7KrLYMweic/Q7bxDTx5YOzwup6Ka9ijTYAs0dSPj//n2Xo76+l/UK2qB9P+CA9RKvZveIKxSe1qD0X4uTwq6ImoemJ4OOMmQ+jFqlBA2pWljS4xgn4tl70tZTvTSKBeRtPrW5E3fHpLUh0cjNikcIURG6lgMusO0NwXkT8SMAQZX9AkNBHESi5oL4qa0qjto8BDgz2LkEdjHhsRVaQ4CTmJxFkddcwsxHu43hLhdCOOvGZB7ydBIv27Q==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(8676002)(4326008)(8936002)(70586007)(36756003)(70206006)(82310400005)(7696005)(40460700003)(110136005)(36860700001)(54906003)(86362001)(186003)(2906002)(508600001)(356005)(30864003)(81166007)(7416002)(6666004)(26005)(5660300002)(107886003)(336012)(426003)(47076005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 10:26:48.9785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6ca903-1d53-42eb-e96e-08da3fcb688a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

