Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C66478AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhLQMHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:07:54 -0500
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com ([40.107.237.43]:38561
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235983AbhLQMHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:07:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OASL+Y0xNqBj7A5I9n9QE4998J1P6CwVJsq2sIIcb/IRj0x7UNXLA56ZEerzg2Cnfz3PjA44iJfMfD86IlSrkwl7JSQq7i6AvxmNH0c0V+qfm8TToSfh4+bSLc81XlmCx9DiWGW4mn3Ue3garWQqT5I0HsCbMrIM2GmonJtzKlFzll1mnnYTgQdczpGseWor5NqEpUgn9pdxCq4S19ofB5rmpbOU/qBENsi9+XksP3TsOLhw+EGf5oFjVTVCkA/tuy+CBYn0T4K/v6aDDLASbvcvtzqQ2A2IW+b/0Y0ZyA1dOOwSCwWrcKfyHGe+by5EQSUAhaftxf5r6VYxjEER9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSQXp5ThuFj1j+mZaSkxXTOkNfLy9gmSxSr6+YpQs0A=;
 b=cbQwSiLzIYPIIC+vdwrc9d+iU4BwLg1EDBZQISnViHqHcRB38kTXsct4cQHSShndf5f/MYKtOqAjK2uYqFhTltneMTWPRW92MLmXqcpec9trGAVflxw0abcJNkKNaKXNDVZQvyphZfcLFRLNiHLperX9nuJASK7sWvu+Ayr9qKXxZsBc9OpA2Dxc0h2NoCMiL56tWAAzzaqXodeSSbz5R7MOO5Iy0Z9ne5Gmb4IY35SpSbnHg/e6EMO2K3idHXJVhFBZ5wBWqriocd4jCqZXKjhlPjwD+UQgCroEHT92Nkvn6nDJquD0dx+95hC9MkAHZJH1rmn0pUaYIjFBRIWvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSQXp5ThuFj1j+mZaSkxXTOkNfLy9gmSxSr6+YpQs0A=;
 b=mpMNsWX3lKCHdi96dv1MAKcFfBIS6VRCBp3g5jEDViMkbCpB4ihEjyYJs+WE/jjrYS5a7ks8//EjWdLEVt8f2NDGGMJYHYYXx7HU34/mjbVskBV/ljm/dTen+Thc067Sj9r8GzBcqZmuRrShESMKPh4he6jrANqayfUvz5bxWVb357rTw2UX5v1SxYGk68UZStGaLvwFGDGRGe2dn0tLPgoYwEHmx7OQe0t7E654A7KsoGBLBUIBp2BcHAoWodTTYmhj9CvRhDjocC4hTKbseTHB056VAWdy35GjTyLeCMK8FKTPFvqcH8+jlQskqd/cIyg1XeGiLcjWi1cf7JVXBw==
Received: from MWHPR10CA0020.namprd10.prod.outlook.com (2603:10b6:301::30) by
 MN2PR12MB3215.namprd12.prod.outlook.com (2603:10b6:208:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 12:07:30 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::58) by MWHPR10CA0020.outlook.office365.com
 (2603:10b6:301::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 12:07:30 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:29 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:29 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:26 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v2 7/9] arm64: tegra: Add node for CBB2.0 in Tegra234 SOC
Date:   Fri, 17 Dec 2021 17:36:54 +0530
Message-ID: <20211217120656.16480-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217120656.16480-1-sumitg@nvidia.com>
References: <20211217120656.16480-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce91bbd3-4804-4848-1b34-08d9c155ccd7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3215D87BF3CF25F3BF37A52BB9789@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRTN5NKttOeskkIss7kW0pn+c0WG2OVZaeVPIefMlwv2fLT2uBVtrf43MrFgh82gIsRmEiuyPjl9mtlMexXAJy82/XVY2xUo02s4ula0s+DYz0u0k04h2N+NWNITHdGr6Xcnh3SPjUC+kpwWtDU/f3RVhNC5HH/SfPCpezfK2A88IM28B4ZhWJ3LE9UbDwLKKnyXo0IXdQuSxx/BPpgr2QR//cQaV2w4zbp1jon5Vaes89B6ZAUnmiXC6qUfdgoy+52H5x6bR+S1Ew2vg2AERO3JG/vnWfr4zUJDj+/j6IFANyF+k4/e6IVTctZhwmSBpXKZfNrl1mrat/CcMauBJ4ATFxRQ2AsirTce2JIim+/IZsA3oiDM0tXGqesM4x7/ETuG9kfdhIKplpIXpKIJJN+OOsq87PZjKbUq7k6WSoo6b3SPceQNJRjz/wLo1HJ9TD+Hm6yrgJhmmQTfo1tbQYI05PPePypsm9d8Suud/9skS3gf+AuP7pcW9zvXp9Qs2+jDoKKNsF3c9fOK91iV/+MvKEbXx2lkyeOx5husD/dB4jFkPRfimaWNxV8WOQ8k3F39cbwLLj4+2tgkmfTe8/SgpZAa2Q7ze3+LyIxbsMaEARLgxYwBsMDlfeRBFawFplctOwEfnJZFXD6p3NHpQ8kFiq/WPtSpaEAwMa2t47etv9ackdREBR+lp7GGJ4vGVfX6HR+AdgBeExMx9ry+3wQsbVvXT+8iSpALfDG2Qss8btV+qVf/Ph4qLL5o42vKSDMf4g3vvs408Jwnqp0Cl9GIVgby/5/S1i/7zXPCyBnUM6yaea2dh/nrQkC0QUXTpTGalmT6kG/BMWt+SkV/Hg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(8676002)(316002)(336012)(2906002)(1076003)(426003)(186003)(2616005)(40460700001)(81166007)(86362001)(47076005)(4326008)(5660300002)(356005)(82310400004)(70586007)(36756003)(34020700004)(107886003)(8936002)(6666004)(110136005)(7696005)(70206006)(54906003)(26005)(508600001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:07:30.1728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce91bbd3-4804-4848-1b34-08d9c155ccd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control Backbone(CBB) version 2.0 is used in Tegra234 SOC.
Adding nodes to enable handling of errors from different
CBB 2.0 based fabrics in Tegra234 SOC.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index f0efb3a62804..400403343529 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -73,6 +73,20 @@
 			#mbox-cells = <2>;
 		};
 
+		sce-fabric@b600000 {
+			compatible = "nvidia,tegra234-sce-fabric";
+			reg = <0xb600000 0x40000>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
+		rce-fabric@be00000 {
+			compatible = "nvidia,tegra234-rce-fabric";
+			reg = <0xbe00000 0x40000>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
 		hsp_aon: hsp@c150000 {
 			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
 			reg = <0x0c150000 0x90000>;
@@ -109,6 +123,27 @@
 			interrupt-controller;
 		};
 
+		aon-fabric@c600000 {
+			compatible = "nvidia,tegra234-aon-fabric";
+			reg = <0xc600000 0x40000>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
+		bpmp-fabric@d600000 {
+			compatible = "nvidia,tegra234-bpmp-fabric";
+			reg = <0xd600000 0x40000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
+		dce-fabric@de00000 {
+			compatible = "nvidia,tegra234-sce-fabric";
+			reg = <0xde00000 0x40000>;
+			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
 		gic: interrupt-controller@f400000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0f400000 0x010000>, /* GICD */
@@ -120,6 +155,13 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 		};
+
+		cbb-fabric@0x13a00000 {
+			compatible = "nvidia,tegra234-cbb-fabric";
+			reg = <0x13a00000 0x400000>;
+			interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
 	};
 
 	sysram@40000000 {
-- 
2.17.1

