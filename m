Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A093D4E8DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiC1GJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbiC1GIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:08:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F34515B6;
        Sun, 27 Mar 2022 23:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUHeXbZqydaYX/NQfm9BmH5gBuWPaX8xC72pJgs9vaLYqokXX7PSDDb3Ql5qj4eLCGBc0hUM7BLMyDElGrjkbzafMr+JdenEsEnbycuUUYMk+EkUPrCsGJNFUns1g3wu/18sh8/VcqKnDBzaHX4Wu0TavjzBAVEwW5iHG6RbcvHALEys3M1y9A3yb9Qtg5IcLRrXKfm4Xf91B85nAuPeiZFQRkB0RK8fXDga9qgTvp/uzFAVwzoc/pA1M+UEvOi+GqL73uL5208csx4qw6By3eaiq8JguoVtG7NQrX1FHbfynwQrI+PuJUbb7XxwXhHEF8o9Ru9GGhHMAPIQzcZnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDSXocJiUNY1Pz+1qKhIaiV1ijyOWkdOcNqFV7QpXEo=;
 b=icXi90HoNbnv5xtyQ9yF9jALGtMI85zHPsqWtQi9X+c/aX3Tlw6vsfjtoSySfOdRmYUDqOKWZjsr1nahP4oSkPvEgQJC9WRDNwP0Py2Gs4Hmlz3cU0CSk4Prit6Q6aikKJiNpAkePiVMgu/T1dOggzOVfXa4PXEE9J21TzNXXL0mDKwTvM21fLQsICVi8BOeVqL6t8GD1rFqFxBkMhrjm/NuHu/S7f8d+1LZ1zvGPTfuXpCfJxYqzIllBZP4s8pvYNIQVdeuOJ7c3AZNILpEHw790Ukc4ZZQXobSuOIdTdPmNlLS0RomsnsT8vHl9edNTd0sFEZUJDsrWEHdhHJWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDSXocJiUNY1Pz+1qKhIaiV1ijyOWkdOcNqFV7QpXEo=;
 b=ZPJB4W9Vqr9kabCPQAARB5Uh2/0zE9N9Gq8qEhATbYWc7QgDICRxJqbdTnFIwGmj7Ohrjl4zsn15H8Vu7hO71wyxvc42IDSTEEH+nI4TojJw35eoZik6BhCRRdMoNOEufDyO0utPtaSxe2UzsfZtcUBmOIGAPSUp85agaw0ySmL7JUzqUE38suJWKZaAkxcXVtPI3qwO1RVvGeIVO/O39YQzfkw/RVKvKU4noLrmVZhw4zzmCaCiFR/6wdvCYom7ysaQPVDVLb4umiZ047kVADcp6tW39Ji1NP0fbgiDWhyg8d7urOTd+MdgqQn436MbTaDEa6lTsEIJu95Cbn6blA==
Received: from DM5PR06CA0057.namprd06.prod.outlook.com (2603:10b6:3:37::19) by
 MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 06:07:02 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::b4) by DM5PR06CA0057.outlook.office365.com
 (2603:10b6:3:37::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Mon, 28 Mar 2022 06:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:07:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 06:07:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 27 Mar
 2022 23:06:59 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 27 Mar
 2022 23:06:55 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 6/6] arm64: tegra: Enable ASRC on various platforms
Date:   Mon, 28 Mar 2022 11:35:26 +0530
Message-ID: <1648447526-14523-7-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
References: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c216cfcb-a6b3-445b-66c4-08da10812c6f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3949:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB394977821767E8E9330BE58AA71D9@MN2PR12MB3949.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXVjy7TC7zxnm+YgD6pwPRuDKXH7YQQNkM2y4d+3bayt0LNf0a24L7MkXQmUZmBdjEr5yEundSdHYXSoMOVMPC2uSAUTyBi90eZsStwW32IXU3wMm2gv98A8SFF0WpGUIBTlseRPtVR1K1zvW8p5dR91zriIj3jzO7oiwtELGoFDnyjeSxYrbWfklIVcOgerRZG/IwOB1izdWkHpxHD8athPIRF9GqdsX9tWHV5KOjPmMl4vr8o/pk6YTJJUBNx3c/boZ7l9lY5mV1zNAreGhOpF1/zifg79SuIyiRSy6vUA+HwQmVO4NVWDGJhTyQxfsXr/PwnW0YEQeVB4Sd3pIBbGdE4Az8alM7ZAxEn9SlZRQ5rLlK5ADj/IMZlYOdbalUALBj6V7LmlQCcMmIlTOfcHa8T27SNbh9bnmIpLe04qZEU71Xr0m3AGXxM1TqUfPdjssj/VK+b6vKA9VbAcGP0/HWLUMk+zpWB4CDfNRYVyD1hlKES6/qCU9yB9BXpHxjVjJMnZG5jXckiEmGz3r9xv+qMgkXwUkAgOtd7h1rlHKqhgF0KcvubIqrL9yaeLU1vg+gjP86Rtt5PP8xU7TdnwTv/6yWZQX5dMTLMxWhCJKO4+6aNkbAFM3of8n3hojJlmBTDq7mGfPwma7WyqRR3o3XjEcLJVOAU1J+1yfHDqGLR8lT1h4QdqUHTCT9OQpAoqbG8n74go+1nTRLVqcA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(8936002)(86362001)(7696005)(316002)(82310400004)(40460700003)(508600001)(26005)(336012)(186003)(5660300002)(36756003)(36860700001)(47076005)(4326008)(8676002)(356005)(81166007)(54906003)(7416002)(30864003)(110136005)(107886003)(70206006)(6666004)(2906002)(70586007)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:07:00.7107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c216cfcb-a6b3-445b-66c4-08da10812c6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ASRC module usage on various Jetson Platforms. This can be plugged
into an audio path using ALSA mixer controls.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 223 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 223 +++++++++++++++++++++
 .../arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi | 223 +++++++++++++++++++++
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  | 223 +++++++++++++++++++++
 4 files changed, 892 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index c4dee05..70737a0 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -811,6 +811,110 @@
 						remote-endpoint = <&mixer_out5_ep>;
 					};
 				};
+
+				xbar_asrc_in1_port: port@63 {
+					reg = <0x63>;
+
+					xbar_asrc_in1_ep: endpoint {
+						remote-endpoint = <&asrc_in1_ep>;
+					};
+				};
+
+				port@64 {
+					reg = <0x64>;
+
+					xbar_asrc_out1_ep: endpoint {
+						remote-endpoint = <&asrc_out1_ep>;
+					};
+				};
+
+				xbar_asrc_in2_port: port@65 {
+					reg = <0x65>;
+
+					xbar_asrc_in2_ep: endpoint {
+						remote-endpoint = <&asrc_in2_ep>;
+					};
+				};
+
+				port@66 {
+					reg = <0x66>;
+
+					xbar_asrc_out2_ep: endpoint {
+						remote-endpoint = <&asrc_out2_ep>;
+					};
+				};
+
+				xbar_asrc_in3_port: port@67 {
+					reg = <0x67>;
+
+					xbar_asrc_in3_ep: endpoint {
+						remote-endpoint = <&asrc_in3_ep>;
+					};
+				};
+
+				port@68 {
+					reg = <0x68>;
+
+					xbar_asrc_out3_ep: endpoint {
+						remote-endpoint = <&asrc_out3_ep>;
+					};
+				};
+
+				xbar_asrc_in4_port: port@69 {
+					reg = <0x69>;
+
+					xbar_asrc_in4_ep: endpoint {
+						remote-endpoint = <&asrc_in4_ep>;
+					};
+				};
+
+				port@6a {
+					reg = <0x6a>;
+
+					xbar_asrc_out4_ep: endpoint {
+						remote-endpoint = <&asrc_out4_ep>;
+					};
+				};
+
+				xbar_asrc_in5_port: port@6b {
+					reg = <0x6b>;
+
+					xbar_asrc_in5_ep: endpoint {
+						remote-endpoint = <&asrc_in5_ep>;
+					};
+				};
+
+				port@6c {
+					reg = <0x6c>;
+
+					xbar_asrc_out5_ep: endpoint {
+						remote-endpoint = <&asrc_out5_ep>;
+					};
+				};
+
+				xbar_asrc_in6_port: port@6d {
+					reg = <0x6d>;
+
+					xbar_asrc_in6_ep: endpoint {
+						remote-endpoint = <&asrc_in6_ep>;
+					};
+				};
+
+				port@6e {
+					reg = <0x6e>;
+
+					xbar_asrc_out6_ep: endpoint {
+						remote-endpoint = <&asrc_out6_ep>;
+					};
+				};
+
+				xbar_asrc_in7_port: port@6f {
+					reg = <0x6f>;
+
+					xbar_asrc_in7_ep: endpoint {
+						remote-endpoint = <&asrc_in7_ep>;
+					};
+				};
 			};
 
 			admaif@290f000 {
@@ -1935,6 +2039,119 @@
 					};
 				};
 			};
+
+			asrc@2910000 {
+				status = "okay";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0x0>;
+
+						asrc_in1_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_in1_ep>;
+						};
+					};
+
+					port@1 {
+						reg = <0x1>;
+
+						asrc_in2_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_in2_ep>;
+						};
+					};
+
+					port@2 {
+						reg = <0x2>;
+
+						asrc_in3_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_in3_ep>;
+						};
+					};
+
+					port@3 {
+						reg = <0x3>;
+
+						asrc_in4_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_in4_ep>;
+						};
+					};
+
+					port@4 {
+						reg = <0x4>;
+
+						asrc_in5_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_in5_ep>;
+						};
+					};
+
+					port@5 {
+						reg = <0x5>;
+
+						asrc_in6_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_in6_ep>;
+						};
+					};
+
+					port@6 {
+						reg = <0x6>;
+
+						asrc_in7_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_in7_ep>;
+						};
+					};
+
+					asrc_out1_port: port@7 {
+						reg = <0x7>;
+
+						asrc_out1_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_out1_ep>;
+						};
+					};
+
+					asrc_out2_port: port@8 {
+						reg = <0x8>;
+
+						asrc_out2_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_out2_ep>;
+						};
+					};
+
+					asrc_out3_port: port@9 {
+						reg = <0x9>;
+
+						asrc_out3_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_out3_ep>;
+						};
+					};
+
+					asrc_out4_port: port@a {
+						reg = <0xa>;
+
+						asrc_out4_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_out4_ep>;
+						};
+					};
+
+					asrc_out5_port: port@b {
+						reg = <0xb>;
+
+						asrc_out5_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_out5_ep>;
+						};
+					};
+
+					asrc_out6_port:	port@c {
+						reg = <0xc>;
+
+						asrc_out6_ep: endpoint {
+							remote-endpoint = <&xbar_asrc_out6_ep>;
+						};
+					};
+				};
+			};
 		};
 	};
 
@@ -2331,6 +2548,10 @@
 		       <&xbar_mixer_in5_port>, <&xbar_mixer_in6_port>,
 		       <&xbar_mixer_in7_port>, <&xbar_mixer_in8_port>,
 		       <&xbar_mixer_in9_port>, <&xbar_mixer_in10_port>,
+		       <&xbar_asrc_in1_port>, <&xbar_asrc_in2_port>,
+		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
+		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
+		       <&xbar_asrc_in7_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -2348,6 +2569,8 @@
 		       <&mixer_out1_port>, <&mixer_out2_port>,
 		       <&mixer_out3_port>, <&mixer_out4_port>,
 		       <&mixer_out5_port>,
+		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
+		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
 		       /* I/O */
 		       <&i2s1_port>, <&i2s2_port>, <&i2s3_port>, <&i2s4_port>,
 		       <&i2s5_port>, <&i2s6_port>, <&dmic1_port>, <&dmic2_port>,
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 2478ece9e..6719638 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -764,6 +764,110 @@
 							remote-endpoint = <&mixer_out5_ep>;
 						};
 					};
+
+					xbar_asrc_in1_port: port@63 {
+						reg = <0x63>;
+
+						xbar_asrc_in1_ep: endpoint {
+							remote-endpoint = <&asrc_in1_ep>;
+						};
+					};
+
+					port@64 {
+						reg = <0x64>;
+
+						xbar_asrc_out1_ep: endpoint {
+							remote-endpoint = <&asrc_out1_ep>;
+						};
+					};
+
+					xbar_asrc_in2_port: port@65 {
+						reg = <0x65>;
+
+						xbar_asrc_in2_ep: endpoint {
+							remote-endpoint = <&asrc_in2_ep>;
+						};
+					};
+
+					port@66 {
+						reg = <0x66>;
+
+						xbar_asrc_out2_ep: endpoint {
+							remote-endpoint = <&asrc_out2_ep>;
+						};
+					};
+
+					xbar_asrc_in3_port: port@67 {
+						reg = <0x67>;
+
+						xbar_asrc_in3_ep: endpoint {
+							remote-endpoint = <&asrc_in3_ep>;
+						};
+					};
+
+					port@68 {
+						reg = <0x68>;
+
+						xbar_asrc_out3_ep: endpoint {
+							remote-endpoint = <&asrc_out3_ep>;
+						};
+					};
+
+					xbar_asrc_in4_port: port@69 {
+						reg = <0x69>;
+
+						xbar_asrc_in4_ep: endpoint {
+							remote-endpoint = <&asrc_in4_ep>;
+						};
+					};
+
+					port@6a {
+						reg = <0x6a>;
+
+						xbar_asrc_out4_ep: endpoint {
+							remote-endpoint = <&asrc_out4_ep>;
+						};
+					};
+
+					xbar_asrc_in5_port: port@6b {
+						reg = <0x6b>;
+
+						xbar_asrc_in5_ep: endpoint {
+							remote-endpoint = <&asrc_in5_ep>;
+						};
+					};
+
+					port@6c {
+						reg = <0x6c>;
+
+						xbar_asrc_out5_ep: endpoint {
+							remote-endpoint = <&asrc_out5_ep>;
+						};
+					};
+
+					xbar_asrc_in6_port: port@6d {
+						reg = <0x6d>;
+
+						xbar_asrc_in6_ep: endpoint {
+							remote-endpoint = <&asrc_in6_ep>;
+						};
+					};
+
+					port@6e {
+						reg = <0x6e>;
+
+						xbar_asrc_out6_ep: endpoint {
+							remote-endpoint = <&asrc_out6_ep>;
+						};
+					};
+
+					xbar_asrc_in7_port: port@6f {
+						reg = <0x6f>;
+
+						xbar_asrc_in7_ep: endpoint {
+							remote-endpoint = <&asrc_in7_ep>;
+						};
+					};
 				};
 
 				admaif@290f000 {
@@ -1734,6 +1838,119 @@
 						};
 					};
 				};
+
+				asrc@2910000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							asrc_in1_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <0x1>;
+
+							asrc_in2_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <0x2>;
+
+							asrc_in3_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <0x3>;
+
+							asrc_in4_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in4_ep>;
+							};
+						};
+
+						port@4 {
+							reg = <0x4>;
+
+							asrc_in5_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in5_ep>;
+							};
+						};
+
+						port@5 {
+							reg = <0x5>;
+
+							asrc_in6_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in6_ep>;
+							};
+						};
+
+						port@6 {
+							reg = <0x6>;
+
+							asrc_in7_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in7_ep>;
+							};
+						};
+
+						asrc_out1_port: port@7 {
+							reg = <0x7>;
+
+							asrc_out1_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out1_ep>;
+							};
+						};
+
+						asrc_out2_port: port@8 {
+							reg = <0x8>;
+
+							asrc_out2_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out2_ep>;
+							};
+						};
+
+						asrc_out3_port: port@9 {
+							reg = <0x9>;
+
+							asrc_out3_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out3_ep>;
+							};
+						};
+
+						asrc_out4_port: port@a {
+							reg = <0xa>;
+
+							asrc_out4_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out4_ep>;
+							};
+						};
+
+						asrc_out5_port: port@b {
+							reg = <0xb>;
+
+							asrc_out5_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out5_ep>;
+							};
+						};
+
+						asrc_out6_port:	port@c {
+							reg = <0xc>;
+
+							asrc_out6_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out6_ep>;
+							};
+						};
+					};
+				};
 			};
 		};
 
@@ -2052,6 +2269,10 @@
 		       <&xbar_mixer_in5_port>, <&xbar_mixer_in6_port>,
 		       <&xbar_mixer_in7_port>, <&xbar_mixer_in8_port>,
 		       <&xbar_mixer_in9_port>, <&xbar_mixer_in10_port>,
+		       <&xbar_asrc_in1_port>, <&xbar_asrc_in2_port>,
+		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
+		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
+		       <&xbar_asrc_in7_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -2068,6 +2289,8 @@
 		       <&adx4_out3_port>, <&adx4_out4_port>,
 		       <&mixer_out1_port>, <&mixer_out2_port>, <&mixer_out3_port>,
 		       <&mixer_out4_port>, <&mixer_out5_port>,
+		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
+		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
 		       /* BE I/O Ports */
 		       <&i2s1_port>, <&i2s2_port>, <&i2s4_port>, <&i2s6_port>,
 		       <&dmic3_port>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
index 32ce790..9c4871b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
@@ -774,6 +774,110 @@
 							remote-endpoint = <&mixer_out5_ep>;
 						};
 					};
+
+					xbar_asrc_in1_port: port@63 {
+						reg = <0x63>;
+
+						xbar_asrc_in1_ep: endpoint {
+							remote-endpoint = <&asrc_in1_ep>;
+						};
+					};
+
+					port@64 {
+						reg = <0x64>;
+
+						xbar_asrc_out1_ep: endpoint {
+							remote-endpoint = <&asrc_out1_ep>;
+						};
+					};
+
+					xbar_asrc_in2_port: port@65 {
+						reg = <0x65>;
+
+						xbar_asrc_in2_ep: endpoint {
+							remote-endpoint = <&asrc_in2_ep>;
+						};
+					};
+
+					port@66 {
+						reg = <0x66>;
+
+						xbar_asrc_out2_ep: endpoint {
+							remote-endpoint = <&asrc_out2_ep>;
+						};
+					};
+
+					xbar_asrc_in3_port: port@67 {
+						reg = <0x67>;
+
+						xbar_asrc_in3_ep: endpoint {
+							remote-endpoint = <&asrc_in3_ep>;
+						};
+					};
+
+					port@68 {
+						reg = <0x68>;
+
+						xbar_asrc_out3_ep: endpoint {
+							remote-endpoint = <&asrc_out3_ep>;
+						};
+					};
+
+					xbar_asrc_in4_port: port@69 {
+						reg = <0x69>;
+
+						xbar_asrc_in4_ep: endpoint {
+							remote-endpoint = <&asrc_in4_ep>;
+						};
+					};
+
+					port@6a {
+						reg = <0x6a>;
+
+						xbar_asrc_out4_ep: endpoint {
+							remote-endpoint = <&asrc_out4_ep>;
+						};
+					};
+
+					xbar_asrc_in5_port: port@6b {
+						reg = <0x6b>;
+
+						xbar_asrc_in5_ep: endpoint {
+							remote-endpoint = <&asrc_in5_ep>;
+						};
+					};
+
+					port@6c {
+						reg = <0x6c>;
+
+						xbar_asrc_out5_ep: endpoint {
+							remote-endpoint = <&asrc_out5_ep>;
+						};
+					};
+
+					xbar_asrc_in6_port: port@6d {
+						reg = <0x6d>;
+
+						xbar_asrc_in6_ep: endpoint {
+							remote-endpoint = <&asrc_in6_ep>;
+						};
+					};
+
+					port@6e {
+						reg = <0x6e>;
+
+						xbar_asrc_out6_ep: endpoint {
+							remote-endpoint = <&asrc_out6_ep>;
+						};
+					};
+
+					xbar_asrc_in7_port: port@6f {
+						reg = <0x6f>;
+
+						xbar_asrc_in7_ep: endpoint {
+							remote-endpoint = <&asrc_in7_ep>;
+						};
+					};
 				};
 
 				admaif@290f000 {
@@ -1794,6 +1898,119 @@
 						};
 					};
 				};
+
+				asrc@2910000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							asrc_in1_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <0x1>;
+
+							asrc_in2_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <0x2>;
+
+							asrc_in3_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <0x3>;
+
+							asrc_in4_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in4_ep>;
+							};
+						};
+
+						port@4 {
+							reg = <0x4>;
+
+							asrc_in5_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in5_ep>;
+							};
+						};
+
+						port@5 {
+							reg = <0x5>;
+
+							asrc_in6_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in6_ep>;
+							};
+						};
+
+						port@6 {
+							reg = <0x6>;
+
+							asrc_in7_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in7_ep>;
+							};
+						};
+
+						asrc_out1_port: port@7 {
+							reg = <0x7>;
+
+							asrc_out1_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out1_ep>;
+							};
+						};
+
+						asrc_out2_port: port@8 {
+							reg = <0x8>;
+
+							asrc_out2_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out2_ep>;
+							};
+						};
+
+						asrc_out3_port: port@9 {
+							reg = <0x9>;
+
+							asrc_out3_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out3_ep>;
+							};
+						};
+
+						asrc_out4_port: port@a {
+							reg = <0xa>;
+
+							asrc_out4_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out4_ep>;
+							};
+						};
+
+						asrc_out5_port: port@b {
+							reg = <0xb>;
+
+							asrc_out5_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out5_ep>;
+							};
+						};
+
+						asrc_out6_port:	port@c {
+							reg = <0xc>;
+
+							asrc_out6_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out6_ep>;
+							};
+						};
+					};
+				};
 			};
 		};
 
@@ -2102,6 +2319,10 @@
 		       <&xbar_mixer_in5_port>, <&xbar_mixer_in6_port>,
 		       <&xbar_mixer_in7_port>, <&xbar_mixer_in8_port>,
 		       <&xbar_mixer_in9_port>, <&xbar_mixer_in10_port>,
+		       <&xbar_asrc_in1_port>, <&xbar_asrc_in2_port>,
+		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
+		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
+		       <&xbar_asrc_in7_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -2119,6 +2340,8 @@
 		       <&mixer_out1_port>, <&mixer_out2_port>,
 		       <&mixer_out3_port>, <&mixer_out4_port>,
 		       <&mixer_out5_port>,
+		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
+		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
 		       /* BE I/O Ports */
 		       <&i2s3_port>, <&i2s5_port>,
 		       <&dmic1_port>, <&dmic2_port>, <&dmic4_port>,
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 34d6a01..eaf1994 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -763,6 +763,110 @@
 							remote-endpoint = <&mix_out5>;
 						};
 					};
+
+					xbar_asrc_in1_port: port@63 {
+						reg = <0x63>;
+
+						xbar_asrc_in1_ep: endpoint {
+							remote-endpoint = <&asrc_in1_ep>;
+						};
+					};
+
+					port@64 {
+						reg = <0x64>;
+
+						xbar_asrc_out1_ep: endpoint {
+							remote-endpoint = <&asrc_out1_ep>;
+						};
+					};
+
+					xbar_asrc_in2_port: port@65 {
+						reg = <0x65>;
+
+						xbar_asrc_in2_ep: endpoint {
+							remote-endpoint = <&asrc_in2_ep>;
+						};
+					};
+
+					port@66 {
+						reg = <0x66>;
+
+						xbar_asrc_out2_ep: endpoint {
+							remote-endpoint = <&asrc_out2_ep>;
+						};
+					};
+
+					xbar_asrc_in3_port: port@67 {
+						reg = <0x67>;
+
+						xbar_asrc_in3_ep: endpoint {
+							remote-endpoint = <&asrc_in3_ep>;
+						};
+					};
+
+					port@68 {
+						reg = <0x68>;
+
+						xbar_asrc_out3_ep: endpoint {
+							remote-endpoint = <&asrc_out3_ep>;
+						};
+					};
+
+					xbar_asrc_in4_port: port@69 {
+						reg = <0x69>;
+
+						xbar_asrc_in4_ep: endpoint {
+							remote-endpoint = <&asrc_in4_ep>;
+						};
+					};
+
+					port@6a {
+						reg = <0x6a>;
+
+						xbar_asrc_out4_ep: endpoint {
+							remote-endpoint = <&asrc_out4_ep>;
+						};
+					};
+
+					xbar_asrc_in5_port: port@6b {
+						reg = <0x6b>;
+
+						xbar_asrc_in5_ep: endpoint {
+							remote-endpoint = <&asrc_in5_ep>;
+						};
+					};
+
+					port@6c {
+						reg = <0x6c>;
+
+						xbar_asrc_out5_ep: endpoint {
+							remote-endpoint = <&asrc_out5_ep>;
+						};
+					};
+
+					xbar_asrc_in6_port: port@6d {
+						reg = <0x6d>;
+
+						xbar_asrc_in6_ep: endpoint {
+							remote-endpoint = <&asrc_in6_ep>;
+						};
+					};
+
+					port@6e {
+						reg = <0x6e>;
+
+						xbar_asrc_out6_ep: endpoint {
+							remote-endpoint = <&asrc_out6_ep>;
+						};
+					};
+
+					xbar_asrc_in7_port: port@6f {
+						reg = <0x6f>;
+
+						xbar_asrc_in7_ep: endpoint {
+							remote-endpoint = <&asrc_in7_ep>;
+						};
+					};
 				};
 
 				i2s@2901000 {
@@ -1733,6 +1837,119 @@
 						};
 					};
 				};
+
+				asrc@2910000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							asrc_in1_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <0x1>;
+
+							asrc_in2_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <0x2>;
+
+							asrc_in3_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <0x3>;
+
+							asrc_in4_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in4_ep>;
+							};
+						};
+
+						port@4 {
+							reg = <0x4>;
+
+							asrc_in5_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in5_ep>;
+							};
+						};
+
+						port@5 {
+							reg = <0x5>;
+
+							asrc_in6_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in6_ep>;
+							};
+						};
+
+						port@6 {
+							reg = <0x6>;
+
+							asrc_in7_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_in7_ep>;
+							};
+						};
+
+						asrc_out1_port: port@7 {
+							reg = <0x7>;
+
+							asrc_out1_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out1_ep>;
+							};
+						};
+
+						asrc_out2_port: port@8 {
+							reg = <0x8>;
+
+							asrc_out2_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out2_ep>;
+							};
+						};
+
+						asrc_out3_port: port@9 {
+							reg = <0x9>;
+
+							asrc_out3_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out3_ep>;
+							};
+						};
+
+						asrc_out4_port: port@a {
+							reg = <0xa>;
+
+							asrc_out4_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out4_ep>;
+							};
+						};
+
+						asrc_out5_port: port@b {
+							reg = <0xb>;
+
+							asrc_out5_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out5_ep>;
+							};
+						};
+
+						asrc_out6_port:	port@c {
+							reg = <0xc>;
+
+							asrc_out6_ep: endpoint {
+								remote-endpoint = <&xbar_asrc_out6_ep>;
+							};
+						};
+					};
+				};
 			};
 
 			dma-controller@2930000 {
@@ -1823,6 +2040,10 @@
 		       <&xbar_mix_in5_port>, <&xbar_mix_in6_port>,
 		       <&xbar_mix_in7_port>, <&xbar_mix_in8_port>,
 		       <&xbar_mix_in9_port>, <&xbar_mix_in10_port>,
+		       <&xbar_asrc_in1_port>, <&xbar_asrc_in2_port>,
+		       <&xbar_asrc_in3_port>, <&xbar_asrc_in4_port>,
+		       <&xbar_asrc_in5_port>, <&xbar_asrc_in6_port>,
+		       <&xbar_asrc_in7_port>,
 		       /* HW accelerators */
 		       <&sfc1_out_port>, <&sfc2_out_port>,
 		       <&sfc3_out_port>, <&sfc4_out_port>,
@@ -1839,6 +2060,8 @@
 		       <&adx4_out3_port>, <&adx4_out4_port>,
 		       <&mix_out1_port>, <&mix_out2_port>, <&mix_out3_port>,
 		       <&mix_out4_port>, <&mix_out5_port>,
+		       <&asrc_out1_port>, <&asrc_out2_port>, <&asrc_out3_port>,
+		       <&asrc_out4_port>, <&asrc_out5_port>, <&asrc_out6_port>,
 		       /* BE I/O Ports */
 		       <&i2s1_port>, <&i2s2_port>, <&i2s4_port>, <&i2s6_port>,
 		       <&dmic3_port>;
-- 
2.7.4

