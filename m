Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD17947C014
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhLUMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:52:03 -0500
Received: from mail-bn8nam08on2066.outbound.protection.outlook.com ([40.107.100.66]:56673
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237852AbhLUMvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:51:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpm/bDdRcTd4YT/GUljacMzm1wQNkCNp8EvhgZ6U28LWF2bpFwZkMtQRay0IOTscXM/knK7GbnTOUI+qpMXQynVnV3F4H32FIUMI5mWMbCAeIz1gXuvU4egoqQGdMZNMIyXvMem7Gx0sVxrbhSZCbVW4SFltNE/g+cRQDfiKd/YtY/mWPqRv+mB4y1991VqsDUs04dfSA97m3z/DSJaxRe6bjcBwBEy2c6zFlXeieFRkERTepP9sNKXawDm2YaA48oK/fXOM8OPcWsP1E8sqN6VCbT79z+676qhI+YMV6Tidlt867AG5jti7HUwC4zThMqT3NCSnh13iByuWOhBx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSQXp5ThuFj1j+mZaSkxXTOkNfLy9gmSxSr6+YpQs0A=;
 b=FcCJ0b5J3giQXHGx+IiQFZmmdG+Mo5ZD7FMJTLD1B85QBD2cOGBMwL5NaHjjGgNuhQzNUz44S/MmBporZwGBvuZja2q0uRwl7GBIZXz5haZGDqSJStSkbWznWRyriVQUzIswHoUxc27mH1HAPS4Oj53dmvAYySrsl8f3PL3/iHXJH6+Fl1eXZwQCttC4U42HHRpojT78RF0lcUi9+4VOsAzGMK/3+V0Z01xX/MN7PekPROmgao65nzbwsst5v2d0VhFN7/a6Sid6KrlJzkearHtP04+NJSdqhrPb6PeUvlnedIrvUdpkSjxbi+LTDbLhglAXG14kPLhwAuGqYKxzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSQXp5ThuFj1j+mZaSkxXTOkNfLy9gmSxSr6+YpQs0A=;
 b=Q4z+kfPMTAvUs4JxeN1dZvmlUm6Q/C7XcsSkqihLvxoGQDIY4MuHTxlE95Wrsg2gNnUcQ6CxmVe6NW/0bxQ0fchfZOvBJmJVJLtedu2kPI4d0+Lb5rzcR92qiyVdaFyGY3TiHRhKp1O9QNXOMoGJYW72Hkj2tiy2+5eMR8pDBibR7v1YLQFglY+vxtoSgm2hxRww+yRycPh1V9fSqw1AfL0nCAAEA1d0DoKhzmPhWunReS+MkNmNF7jbHBoIRLgegpaJsuR8NsWBVpFOilvezWiqYl8cw3lI05Ujn9KdVAGU+lj8lhR3oebpRRJX5qpgtGKQOkWhmIPmzDVsrLRCDA==
Received: from MWHPR2001CA0023.namprd20.prod.outlook.com
 (2603:10b6:301:15::33) by MWHPR12MB1869.namprd12.prod.outlook.com
 (2603:10b6:300:111::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Tue, 21 Dec
 2021 12:51:51 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::5f) by MWHPR2001CA0023.outlook.office365.com
 (2603:10b6:301:15::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 12:51:51 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:49 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:49 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:46 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <kbuild-all@lists.01.org>, <sumitg@nvidia.com>, <bbasu@nvidia.com>,
        <vsethi@nvidia.com>, <jsequeira@nvidia.com>
Subject: [Patch v3 7/9] arm64: tegra: Add node for CBB2.0 in Tegra234 SOC
Date:   Tue, 21 Dec 2021 18:21:15 +0530
Message-ID: <20211221125117.6545-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221125117.6545-1-sumitg@nvidia.com>
References: <20211221125117.6545-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96577fa8-5c35-4348-84fc-08d9c480a8e8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1869:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB18696426EA156C02B3D1F94AB97C9@MWHPR12MB1869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4IMrCCvE7rd7zS3w2bh7gSskMIE1wp97fDE3QilpT3seDyU9L7w8yuWR0hyLPuhIA5hc28eYrw2EYZ4oz8xgxBk+lXR9gibd59NHktDTSQxNIW5wSsj2S9aiAwCFxba5aT/C+EwVAF4ndrG1vdBk9W9Va+ZKkcEX+7TlkXPkOS/Hxrm9klyijcYpKR/7HYNa8q4cuLg9iKyTSyOZQD9qpvEILxUyM3E3O1LMVp+33/KpIla+KfSxLaGhg8NTf25OXAeotyE8Wfz4pJnKSI5MCO7po2aLb+Q5wkNj02k66qyhOa9kz9oYdLzaMpkrAXxor1LRUZTD+CGvCyTlKLoB/mUAqCU+EbfMkltdGChbpxRIqqocN3V0gGWQBp8i5D7s01ErFRXXs9ODIzqa/jyxkREd4OJIkFFADijrMsqiBFFnV3vy+sd6r4ghrmvdJEOg3BXWxcs8Ybvuvls1W41PL9OnJrzbRDQO9ZejZuLIYn9a51N3DFMUm6SWizI0EH/zsE7POPzJyGKAtUK7A6wjF4g2Hy9mLGeQLTYMkw+xkt9LI2xXsidtUTG6rDdDpyQydsn5WGbcauArqdRvQi0h/qi+cR5zurDqiELGV1tJ9ZA4B2TTF0owkdt9HIZkQb2hbdpE7jJI2KzbiZALmdSULeWLRZAGlbKctH8fqFHw792vYs3XJ5X002Xmmu/6iFw4q7pjScbCez/LZz726AHnCobzGC0sIoBijo0LrA1ItVwIjtQjmZBWbFFkZCoPN6TvCGVGd3kb3HJh9F88SUAHne1HqAzdVgc4LGRV1/6QSafGfuW/VGf4ALtSECow86lvtzRGvjS/NUFkN+8k6sKeg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(356005)(36756003)(70206006)(34020700004)(1076003)(5660300002)(47076005)(40460700001)(336012)(508600001)(26005)(110136005)(70586007)(8936002)(86362001)(2906002)(4326008)(2616005)(36860700001)(6666004)(54906003)(7696005)(82310400004)(107886003)(81166007)(316002)(426003)(186003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 12:51:51.7054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96577fa8-5c35-4348-84fc-08d9c480a8e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1869
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

