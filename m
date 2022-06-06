Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657A753EA6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbiFFPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbiFFO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:59:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E131EE05;
        Mon,  6 Jun 2022 07:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjsl1HY8x8u6V7i9jwpXUrsxdPYHJnOjqf3IkLi+p4CD/wj1SdWxbwLV5LeLdQpTOMWxvkJiGNBRIJb+jCWebNfY+BohtqmLyu36Un/yBpa0o8TS9p1QhjNJcHNlVqev/d+2PVDEKCmymaz7P9WRkVMkIPQ7j+Al0ooUcK992IOA4tZQSD3huEhUsCINra1qFs8YhHcjb4r2LkNQAwmZZGxP5g4wUPLAOaf+bmAEYrvZtNCx93rJHGYcqztxbFyWeETSxj4CgjDDqn833GjUhywbmFA185xRtIa+V6yJhp2KYdXffKKbMaJBvAubw0aXhUGO5tMhpR+UdxfUnGJwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ8gkYjQTPE4SOVgYS9rPRHYZwXubcDQdkDVCiW0s7o=;
 b=KXx36PF5fn6zjL9ac7UPUsHcdIOSNA/Pv267rKSvbxqg6kXhc4QfTD+m8O9Qiil0b/QBVXz22GM2I0iUXVmLCuz1M7a4cfxScj8aiu682wCTYNOaMSYsHMoXiaCK9AVfIOaOJMFAeAeZOJYZaq16ectBj0ZdQR2QYC/xg7yd3kZcxJBkwjOG/luWNOdtQIF9uA6UNa2amDkCKl4/uBtHEUrw0UU86K1kilLckryl8tcXLk8EiugbBjrkZ19160aRgRJkTpbye64tSf6N6OeG5FiqVbzZ27RrzJab5nBGV3ME+bgJdzvhsXCErf3ddg6v1cMsYssqbD7cS0JQEu8u/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ8gkYjQTPE4SOVgYS9rPRHYZwXubcDQdkDVCiW0s7o=;
 b=UttxFFPziENzHvVimVlGyg/uz8eUABUJQNMn12tQ/200JbEjUVSyWvIs7U4sGUz69awB3AglXHB4hDvgse4VWMsJG2BMNF/2gVRiXTGGd4MwP6nq6k+ChmMEJ8ePHQFdJpMK+Kz1EeQAjQTxDko5KiD+0GE0WPKGKS+mY3s4vdwebqkuge3qWrFxVvpd7JAp9Yc4APWrCgQslaX47d3T+E4FW8o3GhXfyExkpxfTG8vlaa6L9kd0YvvpCewb7tUHLCQY+qgByEDGXvVFK9VU3zDQtHzjCOVHW39Nt4ylGZAN6RhpX8DEnHSmYCML7mkyubnsOdNLiWvS7DsPd+JTtQ==
Received: from CO2PR07CA0072.namprd07.prod.outlook.com (2603:10b6:100::40) by
 DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Mon, 6 Jun 2022 14:59:39 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::96) by CO2PR07CA0072.outlook.office365.com
 (2603:10b6:100::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Mon, 6 Jun 2022 14:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 14:59:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 6 Jun
 2022 14:59:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 07:59:37 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 6 Jun
 2022 07:59:33 -0700
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
Subject: [RESEND PATCH v3 6/6] arm64: tegra: Enable OPE on various platforms
Date:   Mon, 6 Jun 2022 20:28:57 +0530
Message-ID: <1654527537-31038-7-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654527537-31038-1-git-send-email-spujar@nvidia.com>
References: <1654527537-31038-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf8fad6-0a56-4ec9-1dea-08da47cd2ddd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5722:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5722E6FEA71659C1CDC2EC40A7A29@DM4PR12MB5722.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUBsqrISk6w+wq7L2YD6YvVAyBBU4zJydCzeXT5rtdC9dKY2y1eVyNqrMGSp54JIRwtMjsvZEpjmrlwpBMq8tAsfL6ukDB2PpptF3+kfZqCPNPGRWuVgcARVMMzFyVHzmtyMxDQ1wekmaA9yaz5OnrAW7llILC8Yf0n04v2Dj5kci94vs/JXibxMN3ltzODcv5Th/dQUVi55dJtQkaqHF18pD1aA4FCmhJSFnsOWeaNbKiUoJ/HM7opiqWOgqThPkDWzfgDJgQyQONXRvLav/7vWjyMLpfMLsJ8pEnlmBOoQhP6MA1lZW2csoBAjZQDrRF282ng914TQWKsqE8xFfnP8UDiC2lLuhjN7BdkYTof2BIiifPR9nusIMZAJjT4ZXGhi+701IZCU3mv6HoGK/nkCQTlrkxCqwJnPqY9yJniQO6VuU4F85YK4sgPOqZhyctTzKG0o+6ggj4bk1mrDVjgPwhy2+/o6IS2qI67vnoPRhPAPArEs+PEqdpZyEHbOMTf36anmDIyZi0FCakiyWqGHbJaBCJOFhMQYdlD0jxpi7G0X0HHr1TJ/2V3iyB6g77w+s25kvPAvIsHe+iup39muHhzRc3+28ZFFZ5sPz8kLG7f3F6WMU38lzi5yI8iXSIj/ebC8Poi8yWM7Ul7u1hZIk8sKzopdQ5V/IKD+hREDOLqO1lHWURqSb3/7otUYmnL6Np25e4DidSn+yt0SSg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(110136005)(54906003)(26005)(70206006)(70586007)(81166007)(2616005)(82310400005)(36756003)(7696005)(107886003)(4326008)(8676002)(86362001)(47076005)(336012)(36860700001)(30864003)(40460700003)(5660300002)(7416002)(426003)(508600001)(356005)(316002)(2906002)(8936002)(6666004)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:59:38.8273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf8fad6-0a56-4ec9-1dea-08da47cd2ddd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

