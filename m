Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755F746F0B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhLIRKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:10:22 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:20960
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242274AbhLIRKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:10:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+dNEcS7QpSeAvqFyay0nPXt+GZ2hxtc6fQrIvQTlMh8UgqThmDRItG5t6ncXqClfXk+UCzgUXOiE2SqIJvG8m4TyYy+zKmnQReUbwTF/X2X2nVL6gVOQfGVsnLSqLOZKiz+Q6m1ryM/5TPmieQeI+ilI2HjpbXtr1vDK/RAG4yIeZaMqP2MDAc/iLh+PUWvVFcUlc7cVVeng6qRhQjxKvCCkwHwgI6Ri69M2M1U9XpoC0guwYlQJXcZdset0TUvQ+1UAwcVYGX8ETwLm0shHpQKUNWawJdO08SQb4MMJ1aqSd4XTm7UD1l8hu50AD89RvDLVHWsPS/JdKb16URRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYl6BRrI6/jay0QlDZzNIGU3T8P25PYAHfN6lWaPn1c=;
 b=deBXnT603EJ4kpwU1PMlzYM2ZWeWSWLPqM0zuF7FI6mI1+Pbf4yrssebHaN65reUWgI9ttB13zRQ1o97WD8QekbaLV6BHQ1LSPhoE1db/sKWi2lcHx9ypQ96ifaWR56O3Xyu8qAus7M7gBJ7/sLEN1Nt++3dckjyv0IigVPEcIfax1UYpB9vz8DtHQpkgAGDDWFPCuyNLYh9qnYZFSw1pGgpSMsRTmeYLcEg9LTqPiP/GfF941v0zM2/lFlzGloj6Jnc9K3UF4+0TiZnhR2P/RnPiHdHjraBM728elHD5yuBM9YgnIky4+uK/bKbhIL0q7H/DlygSfJPmJwY9GGtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYl6BRrI6/jay0QlDZzNIGU3T8P25PYAHfN6lWaPn1c=;
 b=k4j7NR6/RYw0/mrg7J+23l0QXSTAd5HakAPYC9l12Ea7O2T8B7GUik//EsjkD7UybNxGUj8xzPVpCtn/WVSIf9Wk3sib8DndJ+zh1+RSfVSL0pwrjFtc06mOCHXV2p31U3XQ8/WcYSIRDTSzqYZpVP6uE/8HeouPNA4+/rQQ9rIjGGWL/SZ2G3PZJtQDMcZ0PcVRWh7A6QwUgZnUHF/Rx7BcBCGmdvJ7JTMPgbrvlEqmXxj5CvptYjeV+opGWjz7B2FspWoF8QDcEfNYrxT+njlhZNPZGwA1+2KgUxezvZztt3P8F3W1Ro9uBJNuBCyMVvDe8OUZdSBM4ZlN8XmyXQ==
Received: from MWHPR1601CA0021.namprd16.prod.outlook.com
 (2603:10b6:300:da::31) by MW2PR12MB2458.namprd12.prod.outlook.com
 (2603:10b6:907:8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 17:06:40 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::6) by MWHPR1601CA0021.outlook.office365.com
 (2603:10b6:300:da::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend
 Transport; Thu, 9 Dec 2021 17:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:06:40 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:06:36 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:06:34 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 09:06:31 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v1 3/8] arm64: tegra: Add node for CBB1.0 in Tegra194 SOC
Date:   Thu, 9 Dec 2021 22:36:28 +0530
Message-ID: <20211209170628.17243-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fa7868d-85ee-40ea-22e2-08d9bb3644a3
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2458B5E09CC71DB0B65DB53EB9709@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUB53AktDXIfJsIRPl2IfheOJ872nmYg+fmc0xLTmqwBXMhlULfbvkmq+ju4TxfENZdGWZQytDD0Ud2h1vcc1QItB3Ctstjdhg6XkmljWA518yYv16fQ/3Bj5uuZlp2EOub+jDHO0GE6h/Mq5DXnvbqUtJ+RH0X43UOkpO51TItERM/GYnGJc/Xo3Gz7y+xtymdfKvbqok/XJl7XHQzdAfx+zQIinmWVVX/4bScT76ysJKN1g/oZnAMozHZXNcDtq7oH+j6Bq0k9/WS5fS5jHbuktxvnmVB4rDizoyjt6u7GO/N64ujqY+DZVKQfnpLS8yzSKKh/uBkaJgN9ya4jIuP86o36ZDmYtPdEupvL38BNE8rOe7uY7hNMYhKDvq1vngczm4zOQzZXjC8eYTq7Z7lFJ3jNf8lvy28cKskkt/j6Tfb3FHWGqY30S4h819XitURxlgaMZkLYuKWgGlQFgZzw4LcV8AhVJydhGxHiZKySBHNykJUzPcbTzyO+j3PI8S75dDEci/VZrPTEtX5HXiGu1d1HpgUsyXaWNgLn3wxg7xhgMJQRpd/8zqTlOHNk+0nN5ZXsvdgrIzXLWHIKnoZ0ZTGvv/Oo/BQ+bFStcRINW0PaiUUoTRfUggDJ7yOCYXwIwCP32q5qhoDdGuPIjTCyDJd3YvJKPT4b6qJAZ8PjkjWNU8pvYAyEqH6vusLTH+9ND0S9qIj55dXSIQu5ah2YY1C4FYq7VgoYrb+iosSfGu0nUZCohlW6DtCQxxIJ2SAonXBW69lIUpDBbaOzyZVYAZRFf/qjQ+yrT/GN7yU=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(2906002)(82310400004)(70586007)(186003)(26005)(356005)(6666004)(8676002)(316002)(2616005)(34020700004)(70206006)(5660300002)(86362001)(47076005)(83380400001)(4326008)(508600001)(54906003)(426003)(336012)(110136005)(36860700001)(107886003)(1076003)(8936002)(36756003)(7636003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:06:40.0368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa7868d-85ee-40ea-22e2-08d9bb3644a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding device tree nodes to enable the driver for handling errors from
Control Backbone(CBB). CBB version 1.0 is used in Tegra194 SOC.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 62 +++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 851e049b3519..b302a46ce53e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -22,7 +22,7 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
-		misc@100000 {
+		apbmisc: misc@100000 {
 			compatible = "nvidia,tegra194-misc";
 			reg = <0x00100000 0xf000>,
 			      <0x0010f000 0x1000>;
@@ -87,6 +87,27 @@
 			gpio-controller;
 		};
 
+		cbb-noc@2300000 {
+			compatible = "nvidia,tegra194-cbb-noc";
+			reg = <0x02300000 0x1000>;
+			interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
+		axi2apb: axi2apb@2390000 {
+			compatible = "nvidia,tegra194-axi2apb-bridge";
+			reg = <0x2390000 0x1000>,
+			    <0x23a0000 0x1000>,
+			    <0x23b0000 0x1000>,
+			    <0x23c0000 0x1000>,
+			    <0x23d0000 0x1000>,
+			    <0x23e0000 0x1000>;
+			status = "okay";
+		 };
+
 		ethernet@2490000 {
 			compatible = "nvidia,tegra194-eqos",
 				     "nvidia,tegra186-eqos",
@@ -1359,6 +1380,26 @@
 			#phy-cells = <0>;
 		};
 
+		sce-noc@b600000 {
+			compatible = "nvidia,tegra194-sce-noc";
+			reg = <0xb600000 0x1000>;
+			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
+		rce-noc@be00000 {
+			compatible = "nvidia,tegra194-rce-noc";
+			reg = <0xbe00000 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
 		hsp_aon: hsp@c150000 {
 			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
 			reg = <0x0c150000 0x90000>;
@@ -1374,6 +1415,15 @@
 			#mbox-cells = <2>;
 		};
 
+		aon-noc@c600000 {
+			compatible = "nvidia,tegra194-aon-noc";
+			reg = <0xc600000 0x1000>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
 		gen2_i2c: i2c@c240000 {
 			compatible = "nvidia,tegra194-i2c";
 			reg = <0x0c240000 0x10000>;
@@ -1552,6 +1602,16 @@
 			status = "okay";
 		};
 
+		bpmp-noc@d600000 {
+			compatible = "nvidia,tegra194-bpmp-noc";
+			reg = <0xd600000 0x1000>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
 		host1x@13e00000 {
 			compatible = "nvidia,tegra194-host1x";
 			reg = <0x13e00000 0x10000>,
-- 
2.17.1

