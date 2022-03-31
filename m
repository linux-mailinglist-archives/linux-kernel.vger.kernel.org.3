Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5C4EDB4A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiCaOGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiCaOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:06:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC065F8D7;
        Thu, 31 Mar 2022 07:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGrgjS73OKDqJiswLwp47SXAZEqjVvCyX0OUrct8NdGwLkYWL/n0DF7gt8wm6DYPm7+JVJxM09cvkMkYGRtZAkpm7yEokP7Zp21dDgFETKjJ9rgDRVEAa5qEAXL26BsvHf7f1pujUAc6iy0lOCIwtHGSglp/hf+MRTvOtp7eyDOARevCHr6zARWUXTvXEW8htskLumYcaQw4aTjQauoVvjJW3ubOxDc3R6uVyCO0jxqPme4evod2yg7LWnPEBjs39deQd+SI+1FMQyQ/dMx/fjdmX7p4FJ7SkKNVB58qIWZA8gWyBS0CzDb2OnJ3Cv/aBiz3p9D5Gr0AoNBeBm4D6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDSXocJiUNY1Pz+1qKhIaiV1ijyOWkdOcNqFV7QpXEo=;
 b=Q/ALnMgCscey+5T8yuccRucUNf/yLxMGhiOwc9QEwM0aXwN3o0FnghjhiZfnn20Z3TlJZBmRmP3exucLRQkhXFb+c0Yw84ElgHDlcJLW0OdQ1Fk/pYBoiIYzDwBt2oCGekHGaXfoYfuQ7icsEuTq4S+KVuLU0zaaVHmalgaJOUwycR5yGYoZ5WPk+MJ5O2Tb8/Qj+difEpxtSkfuIgDjlRD9G56Ipl5VWc3nJGg6yfKyinTeBqmeQqvsjjJAkzz3A4S6rcQ2flxvvyWfhhygjRCzREkbwF/JiFa2R2gsBZd6nAv3p0uclgTE/g4nVDJsQkRUNK5TbOIcNt7rBCq6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDSXocJiUNY1Pz+1qKhIaiV1ijyOWkdOcNqFV7QpXEo=;
 b=JETQtE3A7EZ0Nh1mBS5X3NQJnh9D+mVzMTVraGNIsz5yJY6rBx8EuTbDiGraDHJJuAjQm69/7rV+SG+lygslCLuSTxgFnKwOguWunTiPv12Bs3uA5giYTBVDUahqtNIokFodBP7ktpusuvaNVnK5pQPOgvd2YCOeWFVw72VK/ktTcxFX7YbJVEFvYTcugbI2YfuP5IjApGWsZ4GZv/qMhso6z24+/YbXfJxY3dTMapjTCx1aHv2WkCncb9R5BtHynJ5Kty7aeCcAfrllRbVTp2GrkCUu8Bg9IC+3DwyvkG5srbH00NH71ACrEgUjUgxFhAS8nPrE3jxjAhOzRvuVsw==
Received: from BN9PR03CA0864.namprd03.prod.outlook.com (2603:10b6:408:13d::29)
 by CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 14:04:14 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::2e) by BN9PR03CA0864.outlook.office365.com
 (2603:10b6:408:13d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Thu, 31 Mar 2022 14:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 14:04:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 31 Mar
 2022 14:04:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 31 Mar
 2022 07:04:12 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 31 Mar
 2022 07:04:08 -0700
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
Subject: [PATCH v2 6/6] arm64: tegra: Enable ASRC on various platforms
Date:   Thu, 31 Mar 2022 19:33:32 +0530
Message-ID: <1648735412-32220-7-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
References: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c41b89c8-4ed1-4eaf-8f26-08da131f5640
X-MS-TrafficTypeDiagnostic: CO6PR12MB5476:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5476DA42169559E142AC5682A7E19@CO6PR12MB5476.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CqU2HyGJE2zoy9zYBoFNIMd4/xbe4QHcxi2+eLECnELAFyOca8DkhYpUHBmOXzLnYReJpdOv7jQ66jn1eAt4Ou5FKmxrwZIou+iBtSlyRWscWXkGIyzeXMpbBJDJsGTbgZR/qRMrQzxuvK09FgAWCNv5FUNLdrctQvdib9r7mDl7pjK3t67b4kCZGSTHaLCww8iOKaKaG0G+aE/jdJLX1i/Vwd+uJt4kQf2A10O0RLF/PnfSxrpg5eGnlDwmt1Pvs8H/TD/gro2GF0bz56yuP7E4mRO5pJuMO/Sc7s3A8xP9G/OUPf9xDbAolfyUbYc2jvz43nfw+PMnsU2eN8/VTr+CoWHAYY5EwEEIzipD7hHoWqpxm9ixxK5pkz8y8Z7qJBVXQtVFXEuwYUmOKeeiZQw38i4DGXQJE0SSQnPPpxcHZlrjhKSoPpzqAgOdwaQfFr8qDmEyQk4dsx9FuyvDf84ykxMuZsEZcnkrj7WuZHzo1Top0STTXZInrH5ttFyJPu/x72OiecduIavfn4VjRQEmiRrJMAjf1cqEEKstwKlbDaPVGsAXdZMqanXZ0k0z2NtCM5cjyd0vYFPSpAE5ungDJ0D/l3FUbCtLoj3ddvnIboRevDEoouobkNSDvwBvQlTIeOS1+4rSscBxPYrK+e3U/o4ZR9tjYegAH+8Ue2AulMFZtA3h0CC7w8AbkD3uZOt1c+u8CwP+0IpWvbe9g==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400004)(30864003)(356005)(8936002)(7416002)(5660300002)(81166007)(6666004)(2616005)(107886003)(54906003)(426003)(40460700003)(186003)(26005)(336012)(508600001)(7696005)(110136005)(36860700001)(4326008)(316002)(47076005)(70206006)(70586007)(8676002)(86362001)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:04:13.5832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41b89c8-4ed1-4eaf-8f26-08da131f5640
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

