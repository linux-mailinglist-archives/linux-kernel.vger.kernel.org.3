Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE377523EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347677AbiEKUSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbiEKUSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:18:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C917B6D865;
        Wed, 11 May 2022 13:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPTh6Q4GcymSlL6H+ZInROCIkJ1RKktznyeWSEVP9As86WTYnqI/tcIikH0I4bBkxmla9yrMZ6Rw4y8JHCJNoCCw6ftVxG8oothHh74KC9KB9PCT+pi3x7IgvBMjXXolxxidUAW7W+RQLAfCFfxsZmEg7V79eVpzb2pI1zNy9ewoALePLneY8CyiMqn734T1TzgSf81vBTwcBGg6ZKkvEbj3Ss5amz+ExjsnBU/tlMFMaj2XxOvx5oCNrjDp9gPru2XENLEAI7xlWLLel//HeLO117a2Rb4YOImFVk7jBKYHoC/gCxGMYIJ7h1ldj7+S26iM9mn/F1amb35ChzFA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7GWc1EzRmsSPnxOcKmqqym3uqWXt7sl5R1Evbn9erI=;
 b=XwNvLaNJ2hqcl68JV67DPqdfBTth42IqWLui+IJiB0dQmQGFl9yCXTlYoDRVmiai9zvnhz1STRgRe3cJsJEsjh782m/vpZ5Ae5AyFjH5M5WSXbr8FM/b3A3Al1er8I38sjQpNFmOK4DrUs18OMm/moNr3gjqNZw2deAtqhmK1HVAf2aB1VA22dd86d0AWk2lOa2nZe5/5HKXYcIdS+2memkCAZoWV8thSsENTpMxRPxmdc94PY9ztW0Xecf3fUIKKCDxHLqe8O2PmxgUfeG+i/kNo6YA6pyY/3hdIl6FwFBfCLXB5bW7hTZIvxmUUpp+d0x3m52ooGO+DtkpECXhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7GWc1EzRmsSPnxOcKmqqym3uqWXt7sl5R1Evbn9erI=;
 b=MgjJbT/hcpyP0IicGeiUEelsHRE5Ph4JgMXp5/gEhJ71Mc/pTlc4R6hPdntOPM+ikuW7qo7es1bZkzv5Hhcp4yAnodMnl1MB69CAR7qPQKPHcEL1ctk/E0wAns2GHmDvUQYind2dRkVS9Ngo8y8sKcxHkNUrflITBR4CGEmcgCI0b1onBflzOezn0w8qrfZ/9j4SQ4oyDeBWn0gBGNXvN3M/ZdhIOytHxVNYoV9tfMhYWlsfG61gRhkrHkhW+MSW3F/zSvnRZzipnq9m+q3KWTd170FPU918CNke03uJKyAtAm3IenJgmE0HGHV80JPb6+vJ9h17czZVoGfNMnD6zg==
Received: from DS7PR05CA0071.namprd05.prod.outlook.com (2603:10b6:8:57::14) by
 MWHPR12MB1600.namprd12.prod.outlook.com (2603:10b6:301:f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Wed, 11 May 2022 20:17:53 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::98) by DS7PR05CA0071.outlook.office365.com
 (2603:10b6:8:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5 via Frontend
 Transport; Wed, 11 May 2022 20:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 20:17:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 11 May 2022 20:17:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 13:17:52 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 11 May 2022 13:17:49 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v6 4/9] arm64: tegra: Add node for CBB1.0 in Tegra194 SOC
Date:   Thu, 12 May 2022 01:46:46 +0530
Message-ID: <20220511201651.30695-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511201651.30695-1-sumitg@nvidia.com>
References: <20220511201651.30695-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c5902af-a218-48e4-e406-08da338b545b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1600:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16002320585BE78CE36EBDC6B9C89@MWHPR12MB1600.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RG6hKMqU1MQEiPqQ5nWO9LgaZfiIyo5XBMXTaYWCULDKIRuozwGIep2nXsWtFTxzOSSB0hWayjZGMs3OGCEjpaa6DW3VujkPgRVAoZIv0WT4ww1rmtX7Q8mBsy+IQnGLMBbxP3VyvXBk2nACHcHJgTShYJkF6IdoXo4UN2mJUI9EwkfatFt3W9sKZt4kY8/TVRtAe107/5TTgA5zUo05dJSCcXYLxqrYqRp2mf+JW5pSefsZxBbtkUCiCKRXNKmWd/Gjoa/s+YxKVo2x7c4gUzfN2ObVeE5kF3vZjcbOkXULITiRlBpng5553L5bNhiQAEUL8vo0vHaGFgkq9YwXfsaoBeVjBkWAVQzB1cpGxYmu96xUMkrK+OM0ekkRwpRHH8sj0eCoiHmlp+/jkgQPgiTx72IRu7lFoyaPOZg5qEFKxdsEhJEzJY/7yj/QaqNBtxdYkbpmPZHOD3DAFwqtRR9kAIk6ciP+pzccjmZ20OTgTGKbgSy0maTKrM9a/mfghsRm2cGcEfy8RYOxzBkAX302GEbQUe4gVnNO0OGRMHO33BIUp0pgIs6/WF8evH6v6fPhibjJMN/BRCcNARGnouRn1g4WZQNNOlCEE3p6lyxhaPnB+yaRDx8GnG7CX/HNfNM7ZVVUpAheM6vKCWM4ioopr3eGjOcy69LmvuN0La/YrChzIZa5pZ+M1/05ZqC8gjlY9GKzd7htkAz8S6Odg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(1076003)(426003)(186003)(107886003)(86362001)(316002)(336012)(82310400005)(47076005)(4326008)(26005)(40460700003)(5660300002)(36756003)(36860700001)(8936002)(508600001)(81166007)(2906002)(70206006)(70586007)(83380400001)(7696005)(6666004)(54906003)(356005)(110136005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 20:17:53.4031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5902af-a218-48e4-e406-08da338b545b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1600
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index d1f8248c00f4..c0da62436ed5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -23,7 +23,7 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
-		misc@100000 {
+		apbmisc: misc@100000 {
 			compatible = "nvidia,tegra194-misc";
 			reg = <0x00100000 0xf000>,
 			      <0x0010f000 0x1000>;
@@ -88,6 +88,27 @@
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
+			compatible = "nvidia,tegra194-axi2apb";
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
@@ -1460,6 +1481,26 @@
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
 			compatible = "nvidia,tegra194-hsp";
 			reg = <0x0c150000 0x90000>;
@@ -1594,6 +1635,25 @@
 
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
 		iommu@10000000 {
 			compatible = "nvidia,tegra194-smmu", "nvidia,smmu-500";
 			reg = <0x10000000 0x800000>;
-- 
2.17.1

