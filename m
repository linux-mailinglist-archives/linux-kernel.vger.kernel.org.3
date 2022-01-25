Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D449AEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453865AbiAYI4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:56:13 -0500
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:59712
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1452479AbiAYItN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:49:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLkHyXxUpEY675GuZtBhHnbY4z95nVvshH1SFuPDQadk/MLwvVXF8eI6WcR2htOdFJl3/yNmBTaUayvmeshAcQtRnjCgEq/obaYFo/5qDmk7U9PfaEnGDVWMwvwgJP6CcHxg+itFkVyrV8KCxddW/saRBfOHFRCQOQdo0iMuXYLkiCYOD1oJbuvb01Lh/t+cjoiVoafx8/rHXF3MQXpNJvy55M45M7ATLyXHkzrmFazgRuDAuPrrLLjiMIhc5J2MrwMjd8INelFLi7BfNq7CeMD9aHMFJ0+QDQzZcZOrkEvqL+wvaJ8cAi/NPu5Jbamyc9xOdcsWf41ekaAAdTjLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62a+vcENTYK56SCU1Gvnp7CrAHxk9Uu0BzFl1UKjU4w=;
 b=ly58BBiTq2rQcCEvvn6qvCOP1MEMCA092bZ2tDJX1/EODxe3a8aFapcGrD2+aTG3yGU4YRDaJEWZsAlBZ2LmoYSh2263YmpV5tiintZ5VKpU8fKN2VKC1ealS7Vn1aROLynMsxcmKOsLVmYKOfbk4UMOLAcrXP/EQ7gzFcRQp5zssb6qh3Y0lKx141h2aaHGZt6XTaATpRYPxx97HgElL/lVcG29re5V1ZPnKl8FChTCT/o9PExOJ4Rb97we0qeRsHzfBwQ+qy8/1hBx79pC9ooMK1PBzg1dTyoWnM0SbND4/Th0cxDe2j44jvnL+Y1yOcrEUJIfU+AMxW3w99NaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62a+vcENTYK56SCU1Gvnp7CrAHxk9Uu0BzFl1UKjU4w=;
 b=O5oa9WDRyEDIFy4y12MrLoRfdlUzzJnk04CHCFlfVakqTCjYjOefaNM5olRBWyZCe8mnBa1PNzxpiDxW6YbVV5NNTCI91V5R5HtdAHxgcP/a1JpjVhN/dvv+TkPXYIyyoMjHD1iPKaUcVhfCM9jIU4EMBl8nOaQTArSVdpSPPpTIYdmW9qqStVLPltw259Zsm/wFnwlhTW/spDSaeqGR1Cx5Q/4aHrfgpky+tV4oprPjw6uwP+scoDBOjwtABPVdtmCIwswsJmywt2Dn0gnjAkMU5F4XKBTqUruixDO7ZUoATdCHMjMExjJGE17YHDhGfHkfsyfcFznunwNOQUD1Bw==
Received: from MWHPR22CA0045.namprd22.prod.outlook.com (2603:10b6:300:69::31)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 08:49:07 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::5b) by MWHPR22CA0045.outlook.office365.com
 (2603:10b6:300:69::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Tue, 25 Jan 2022 08:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:49:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 25 Jan 2022 08:49:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Tue, 25 Jan 2022 00:49:04 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 25 Jan 2022 00:49:01 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 5/5] arm64: tegra: APE sound card for Jetson AGX Orin
Date:   Tue, 25 Jan 2022 14:18:11 +0530
Message-ID: <1643100491-5398-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643100491-5398-1-git-send-email-spujar@nvidia.com>
References: <1643100491-5398-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b47ef94-0829-4050-9811-08d9dfdf8beb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4298:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42982DD66AEF3A8210613B2AA75F9@DM6PR12MB4298.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqsReumzkyxq0lJWvzc3eGnNr3mg13cklPCLSEziRBA5Jo3xf41Rs68RyjAApfB6ajP+tLICqCctnIlsNEw4+Z7PwNCWFi0QKy33QUtNT6nhitCl+DizAf/OMAo3RfSnB5rJhLUW7XCOI0JkZvBqRwI5JoaRuksepwXgqgD6GBl6ypoTSpLZ8fu/8AoJ8I5vHi6eAHObswDrOLXJXnVHUTeIE7eh8/eYCHb3omGcMwHI1bM1SR6dQx1uusKLUCNQlZ+h7Qj63edOHL5qYcRQGH5cZK7yNszatFnKLw9T+QJhqz/516EqHRJhLO55UKT5qKOTRMvBiZyplDZEx9ijHtc6Chj4+z7LQuyM8HE76jzFs9wTiB5ZYup9bMk0/vMEyUZT9pXRKBjuFXkVEROhTKXAMix09+bgfta298XHlkkCtIgDY5JquCzVPsaGwyWX1YPGRMW6JoK6YOqVJBJ4iN8u1Q3H5v3VHARpmQoCKFrOed4MWuX6EPASoYBuFOM5s3nU9YAuvSLuldoGW4vN2B1s74bibpAvoaF7HI36HPnUEk91jrS+Z3N9t/q7yaad6WQo6BcP6Bc8iA50rwg8x06+ym4FqE/6JW7CU1Zy2CyA+DFPM1NBetV57hkId2ivypdujKUjb9e7zzTar7Y6GHzveYQOMQvNsv5nJ9ohDngx+/0Uz0qE/D97j4V9L63eHWdalUovLbMX+H3S+XRBF35Q23SBYqgaoiPwkWCC40MXDowu2ZaxiL3pfjqQasf2ddPO8yoAYlygg4s22k4O/wAqnmiUSTezYEmT+09eVNk=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(426003)(70586007)(2616005)(70206006)(40460700003)(4326008)(5660300002)(81166007)(107886003)(30864003)(6666004)(508600001)(356005)(83380400001)(8676002)(8936002)(186003)(86362001)(336012)(7696005)(36860700001)(2906002)(316002)(36756003)(54906003)(26005)(110136005)(47076005)(7416002)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:49:06.6716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b47ef94-0829-4050-9811-08d9dfdf8beb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio-graph based sound card support on Jetson AGX Orin
platform. The sound card binds following modules:
 * I/O interfaces such as I2S and DMIC (to be specific I2S1,
   I2S2, I2S4, I2S6 and DMIC3 instances).
 * HW accelerators such as MVC, SFC, AMX, ADX and Mixer (all
   the available instances).

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  | 1781 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   18 +
 2 files changed, 1799 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 6b7440f..014fe00 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -22,6 +22,1732 @@
 	};
 
 	bus@0 {
+		aconnect@2900000 {
+			status = "okay";
+
+			ahub@2900800 {
+				status = "okay";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0x0>;
+
+						xbar_admaif0_ep: endpoint {
+							remote-endpoint = <&admaif0_ep>;
+						};
+					};
+
+					port@1 {
+						reg = <0x1>;
+
+						xbar_admaif1_ep: endpoint {
+							remote-endpoint = <&admaif1_ep>;
+						};
+					};
+
+					port@2 {
+						reg = <0x2>;
+
+						xbar_admaif2_ep: endpoint {
+							remote-endpoint = <&admaif2_ep>;
+						};
+					};
+
+					port@3 {
+						reg = <0x3>;
+
+						xbar_admaif3_ep: endpoint {
+							remote-endpoint = <&admaif3_ep>;
+						};
+					};
+
+					port@4 {
+						reg = <0x4>;
+
+						xbar_admaif4_ep: endpoint {
+							remote-endpoint = <&admaif4_ep>;
+						};
+					};
+
+					port@5 {
+						reg = <0x5>;
+
+						xbar_admaif5_ep: endpoint {
+							remote-endpoint = <&admaif5_ep>;
+						};
+					};
+
+					port@6 {
+						reg = <0x6>;
+
+						xbar_admaif6_ep: endpoint {
+							remote-endpoint = <&admaif6_ep>;
+						};
+					};
+
+					port@7 {
+						reg = <0x7>;
+
+						xbar_admaif7_ep: endpoint {
+							remote-endpoint = <&admaif7_ep>;
+						};
+					};
+
+					port@8 {
+						reg = <0x8>;
+
+						xbar_admaif8_ep: endpoint {
+							remote-endpoint = <&admaif8_ep>;
+						};
+					};
+
+					port@9 {
+						reg = <0x9>;
+
+						xbar_admaif9_ep: endpoint {
+							remote-endpoint = <&admaif9_ep>;
+						};
+					};
+
+					port@a {
+						reg = <0xa>;
+
+						xbar_admaif10_ep: endpoint {
+							remote-endpoint = <&admaif10_ep>;
+						};
+					};
+
+					port@b {
+						reg = <0xb>;
+
+						xbar_admaif11_ep: endpoint {
+							remote-endpoint = <&admaif11_ep>;
+						};
+					};
+
+					port@c {
+						reg = <0xc>;
+
+						xbar_admaif12_ep: endpoint {
+							remote-endpoint = <&admaif12_ep>;
+						};
+					};
+
+					port@d {
+						reg = <0xd>;
+
+						xbar_admaif13_ep: endpoint {
+							remote-endpoint = <&admaif13_ep>;
+						};
+					};
+
+					port@e {
+						reg = <0xe>;
+
+						xbar_admaif14_ep: endpoint {
+							remote-endpoint = <&admaif14_ep>;
+						};
+					};
+
+					port@f {
+						reg = <0xf>;
+
+						xbar_admaif15_ep: endpoint {
+							remote-endpoint = <&admaif15_ep>;
+						};
+					};
+
+					port@10 {
+						reg = <0x10>;
+
+						xbar_admaif16_ep: endpoint {
+							remote-endpoint = <&admaif16_ep>;
+						};
+					};
+
+					port@11 {
+						reg = <0x11>;
+
+						xbar_admaif17_ep: endpoint {
+							remote-endpoint = <&admaif17_ep>;
+						};
+					};
+
+					port@12 {
+						reg = <0x12>;
+
+						xbar_admaif18_ep: endpoint {
+							remote-endpoint = <&admaif18_ep>;
+						};
+					};
+
+					port@13 {
+						reg = <0x13>;
+
+						xbar_admaif19_ep: endpoint {
+							remote-endpoint = <&admaif19_ep>;
+						};
+					};
+
+					xbar_i2s1_port: port@14 {
+						reg = <0x14>;
+
+						xbar_i2s1_ep: endpoint {
+							remote-endpoint = <&i2s1_cif_ep>;
+						};
+					};
+
+					xbar_i2s2_port: port@15 {
+						reg = <0x15>;
+
+						xbar_i2s2_ep: endpoint {
+							remote-endpoint = <&i2s2_cif_ep>;
+						};
+					};
+
+					xbar_i2s4_port: port@17 {
+						reg = <0x17>;
+
+						xbar_i2s4_ep: endpoint {
+							remote-endpoint = <&i2s4_cif_ep>;
+						};
+					};
+
+					xbar_i2s6_port: port@19 {
+						reg = <0x19>;
+
+						xbar_i2s6_ep: endpoint {
+							remote-endpoint = <&i2s6_cif_ep>;
+						};
+					};
+
+					xbar_dmic3_port: port@1c {
+						reg = <0x1c>;
+
+						xbar_dmic3_ep: endpoint {
+							remote-endpoint = <&dmic3_cif_ep>;
+						};
+					};
+
+					xbar_sfc1_in_port: port@20 {
+						reg = <0x20>;
+
+						xbar_sfc1_in_ep: endpoint {
+							remote-endpoint = <&sfc1_cif_in_ep>;
+						};
+					};
+
+					port@21 {
+						reg = <0x21>;
+
+						xbar_sfc1_out_ep: endpoint {
+							remote-endpoint = <&sfc1_cif_out_ep>;
+						};
+					};
+
+					xbar_sfc2_in_port: port@22 {
+						reg = <0x22>;
+
+						xbar_sfc2_in_ep: endpoint {
+							remote-endpoint = <&sfc2_cif_in_ep>;
+						};
+					};
+
+					port@23 {
+						reg = <0x23>;
+
+						xbar_sfc2_out_ep: endpoint {
+							remote-endpoint = <&sfc2_cif_out_ep>;
+						};
+					};
+
+					xbar_sfc3_in_port: port@24 {
+						reg = <0x24>;
+
+						xbar_sfc3_in_ep: endpoint {
+							remote-endpoint = <&sfc3_cif_in_ep>;
+						};
+					};
+
+					port@25 {
+						reg = <0x25>;
+
+						xbar_sfc3_out_ep: endpoint {
+							remote-endpoint = <&sfc3_cif_out_ep>;
+						};
+					};
+
+					xbar_sfc4_in_port: port@26 {
+						reg = <0x26>;
+
+						xbar_sfc4_in_ep: endpoint {
+							remote-endpoint = <&sfc4_cif_in_ep>;
+						};
+					};
+
+					port@27 {
+						reg = <0x27>;
+
+						xbar_sfc4_out_ep: endpoint {
+							remote-endpoint = <&sfc4_cif_out_ep>;
+						};
+					};
+
+					xbar_mvc1_in_port: port@28 {
+						reg = <0x28>;
+
+						xbar_mvc1_in_ep: endpoint {
+							remote-endpoint = <&mvc1_cif_in_ep>;
+						};
+					};
+
+					port@29 {
+						reg = <0x29>;
+
+						xbar_mvc1_out_ep: endpoint {
+							remote-endpoint = <&mvc1_cif_out_ep>;
+						};
+					};
+
+					xbar_mvc2_in_port: port@2a {
+						reg = <0x2a>;
+
+						xbar_mvc2_in_ep: endpoint {
+							remote-endpoint = <&mvc2_cif_in_ep>;
+						};
+					};
+
+					port@2b {
+						reg = <0x2b>;
+
+						xbar_mvc2_out_ep: endpoint {
+							remote-endpoint = <&mvc2_cif_out_ep>;
+						};
+					};
+
+					xbar_amx1_in1_port: port@2c {
+						reg = <0x2c>;
+
+						xbar_amx1_in1_ep: endpoint {
+							remote-endpoint = <&amx1_in1_ep>;
+						};
+					};
+
+					xbar_amx1_in2_port: port@2d {
+						reg = <0x2d>;
+
+						xbar_amx1_in2_ep: endpoint {
+							remote-endpoint = <&amx1_in2_ep>;
+						};
+					};
+
+					xbar_amx1_in3_port: port@2e {
+						reg = <0x2e>;
+
+						xbar_amx1_in3_ep: endpoint {
+							remote-endpoint = <&amx1_in3_ep>;
+						};
+					};
+
+					xbar_amx1_in4_port: port@2f {
+						reg = <0x2f>;
+
+						xbar_amx1_in4_ep: endpoint {
+							remote-endpoint = <&amx1_in4_ep>;
+						};
+					};
+
+					port@30 {
+						reg = <0x30>;
+
+						xbar_amx1_out_ep: endpoint {
+							remote-endpoint = <&amx1_out_ep>;
+						};
+					};
+
+					xbar_amx2_in1_port: port@31 {
+						reg = <0x31>;
+
+						xbar_amx2_in1_ep: endpoint {
+							remote-endpoint = <&amx2_in1_ep>;
+						};
+					};
+
+					xbar_amx2_in2_port: port@32 {
+						reg = <0x32>;
+
+						xbar_amx2_in2_ep: endpoint {
+							remote-endpoint = <&amx2_in2_ep>;
+						};
+					};
+
+					xbar_amx2_in3_port: port@33 {
+						reg = <0x33>;
+
+						xbar_amx2_in3_ep: endpoint {
+							remote-endpoint = <&amx2_in3_ep>;
+						};
+					};
+
+					xbar_amx2_in4_port: port@34 {
+						reg = <0x34>;
+
+						xbar_amx2_in4_ep: endpoint {
+							remote-endpoint = <&amx2_in4_ep>;
+						};
+					};
+
+					port@35 {
+						reg = <0x35>;
+
+						xbar_amx2_out_ep: endpoint {
+							remote-endpoint = <&amx2_out_ep>;
+						};
+					};
+
+					xbar_amx3_in1_port: port@36 {
+						reg = <0x36>;
+
+						xbar_amx3_in1_ep: endpoint {
+							remote-endpoint = <&amx3_in1_ep>;
+						};
+					};
+
+					xbar_amx3_in2_port: port@37 {
+						reg = <0x37>;
+
+						xbar_amx3_in2_ep: endpoint {
+							remote-endpoint = <&amx3_in2_ep>;
+						};
+					};
+
+					xbar_amx3_in3_port: port@38 {
+						reg = <0x38>;
+
+						xbar_amx3_in3_ep: endpoint {
+							remote-endpoint = <&amx3_in3_ep>;
+						};
+					};
+
+					xbar_amx3_in4_port: port@39 {
+						reg = <0x39>;
+
+						xbar_amx3_in4_ep: endpoint {
+							remote-endpoint = <&amx3_in4_ep>;
+						};
+					};
+
+					port@3a {
+						reg = <0x3a>;
+
+						xbar_amx3_out_ep: endpoint {
+							remote-endpoint = <&amx3_out_ep>;
+						};
+					};
+
+					xbar_amx4_in1_port: port@3b {
+						reg = <0x3b>;
+
+						xbar_amx4_in1_ep: endpoint {
+							remote-endpoint = <&amx4_in1_ep>;
+						};
+					};
+
+					xbar_amx4_in2_port: port@3c {
+						reg = <0x3c>;
+
+						xbar_amx4_in2_ep: endpoint {
+							remote-endpoint = <&amx4_in2_ep>;
+						};
+					};
+
+					xbar_amx4_in3_port: port@3d {
+						reg = <0x3d>;
+
+						xbar_amx4_in3_ep: endpoint {
+							remote-endpoint = <&amx4_in3_ep>;
+						};
+					};
+
+					xbar_amx4_in4_port: port@3e {
+						reg = <0x3e>;
+
+						xbar_amx4_in4_ep: endpoint {
+							remote-endpoint = <&amx4_in4_ep>;
+						};
+					};
+
+					port@3f {
+						reg = <0x3f>;
+
+						xbar_amx4_out_ep: endpoint {
+							remote-endpoint = <&amx4_out_ep>;
+						};
+					};
+
+					xbar_adx1_in_port: port@40 {
+						reg = <0x40>;
+
+						xbar_adx1_in_ep: endpoint {
+							remote-endpoint = <&adx1_in_ep>;
+						};
+					};
+
+					port@41 {
+						reg = <0x41>;
+
+						xbar_adx1_out1_ep: endpoint {
+							remote-endpoint = <&adx1_out1_ep>;
+						};
+					};
+
+					port@42 {
+						reg = <0x42>;
+
+						xbar_adx1_out2_ep: endpoint {
+							remote-endpoint = <&adx1_out2_ep>;
+						};
+					};
+
+					port@43 {
+						reg = <0x43>;
+
+						xbar_adx1_out3_ep: endpoint {
+							remote-endpoint = <&adx1_out3_ep>;
+						};
+					};
+
+					port@44 {
+						reg = <0x44>;
+
+						xbar_adx1_out4_ep: endpoint {
+							remote-endpoint = <&adx1_out4_ep>;
+						};
+					};
+
+					xbar_adx2_in_port: port@45 {
+						reg = <0x45>;
+
+						xbar_adx2_in_ep: endpoint {
+							remote-endpoint = <&adx2_in_ep>;
+						};
+					};
+
+					port@46 {
+						reg = <0x46>;
+
+						xbar_adx2_out1_ep: endpoint {
+							remote-endpoint = <&adx2_out1_ep>;
+						};
+					};
+
+					port@47 {
+						reg = <0x47>;
+
+						xbar_adx2_out2_ep: endpoint {
+							remote-endpoint = <&adx2_out2_ep>;
+						};
+					};
+
+					port@48 {
+						reg = <0x48>;
+
+						xbar_adx2_out3_ep: endpoint {
+							remote-endpoint = <&adx2_out3_ep>;
+						};
+					};
+
+					port@49 {
+						reg = <0x49>;
+
+						xbar_adx2_out4_ep: endpoint {
+							remote-endpoint = <&adx2_out4_ep>;
+						};
+					};
+
+					xbar_adx3_in_port: port@4a {
+						reg = <0x4a>;
+
+						xbar_adx3_in_ep: endpoint {
+							remote-endpoint = <&adx3_in_ep>;
+						};
+					};
+
+					port@4b {
+						reg = <0x4b>;
+
+						xbar_adx3_out1_ep: endpoint {
+							remote-endpoint = <&adx3_out1_ep>;
+						};
+					};
+
+					port@4c {
+						reg = <0x4c>;
+
+						xbar_adx3_out2_ep: endpoint {
+							remote-endpoint = <&adx3_out2_ep>;
+						};
+					};
+
+					port@4d {
+						reg = <0x4d>;
+
+						xbar_adx3_out3_ep: endpoint {
+							remote-endpoint = <&adx3_out3_ep>;
+						};
+					};
+
+					port@4e {
+						reg = <0x4e>;
+
+						xbar_adx3_out4_ep: endpoint {
+							remote-endpoint = <&adx3_out4_ep>;
+						};
+					};
+
+					xbar_adx4_in_port: port@4f {
+						reg = <0x4f>;
+
+						xbar_adx4_in_ep: endpoint {
+							remote-endpoint = <&adx4_in_ep>;
+						};
+					};
+
+					port@50 {
+						reg = <0x50>;
+
+						xbar_adx4_out1_ep: endpoint {
+							remote-endpoint = <&adx4_out1_ep>;
+						};
+					};
+
+					port@51 {
+						reg = <0x51>;
+
+						xbar_adx4_out2_ep: endpoint {
+							remote-endpoint = <&adx4_out2_ep>;
+						};
+					};
+
+					port@52 {
+						reg = <0x52>;
+
+						xbar_adx4_out3_ep: endpoint {
+							remote-endpoint = <&adx4_out3_ep>;
+						};
+					};
+
+					port@53 {
+						reg = <0x53>;
+
+						xbar_adx4_out4_ep: endpoint {
+							remote-endpoint = <&adx4_out4_ep>;
+						};
+					};
+
+					xbar_mixer_in1_port: port@54 {
+						reg = <0x54>;
+
+						xbar_mixer_in1_ep: endpoint {
+							remote-endpoint = <&mixer_in1_ep>;
+						};
+					};
+
+					xbar_mixer_in2_port: port@55 {
+						reg = <0x55>;
+
+						xbar_mixer_in2_ep: endpoint {
+							remote-endpoint = <&mixer_in2_ep>;
+						};
+					};
+
+					xbar_mixer_in3_port: port@56 {
+						reg = <0x56>;
+
+						xbar_mixer_in3_ep: endpoint {
+							remote-endpoint = <&mixer_in3_ep>;
+						};
+					};
+
+					xbar_mixer_in4_port: port@57 {
+						reg = <0x57>;
+
+						xbar_mixer_in4_ep: endpoint {
+							remote-endpoint = <&mixer_in4_ep>;
+						};
+					};
+
+					xbar_mixer_in5_port: port@58 {
+						reg = <0x58>;
+
+						xbar_mixer_in5_ep: endpoint {
+							remote-endpoint = <&mixer_in5_ep>;
+						};
+					};
+
+					xbar_mixer_in6_port: port@59 {
+						reg = <0x59>;
+
+						xbar_mixer_in6_ep: endpoint {
+							remote-endpoint = <&mixer_in6_ep>;
+						};
+					};
+
+					xbar_mixer_in7_port: port@5a {
+						reg = <0x5a>;
+
+						xbar_mixer_in7_ep: endpoint {
+							remote-endpoint = <&mixer_in7_ep>;
+						};
+					};
+
+					xbar_mixer_in8_port: port@5b {
+						reg = <0x5b>;
+
+						xbar_mixer_in8_ep: endpoint {
+							remote-endpoint = <&mixer_in8_ep>;
+						};
+					};
+
+					xbar_mixer_in9_port: port@5c {
+						reg = <0x5c>;
+
+						xbar_mixer_in9_ep: endpoint {
+							remote-endpoint = <&mixer_in9_ep>;
+						};
+					};
+
+					xbar_mixer_in10_port: port@5d {
+						reg = <0x5d>;
+
+						xbar_mixer_in10_ep: endpoint {
+							remote-endpoint = <&mixer_in10_ep>;
+						};
+					};
+
+					port@5e {
+						reg = <0x5e>;
+
+						xbar_mixer_out1_ep: endpoint {
+							remote-endpoint = <&mixer_out1_ep>;
+						};
+					};
+
+					port@5f {
+						reg = <0x5f>;
+
+						xbar_mixer_out2_ep: endpoint {
+							remote-endpoint = <&mixer_out2_ep>;
+						};
+					};
+
+					port@60 {
+						reg = <0x60>;
+
+						xbar_mixer_out3_ep: endpoint {
+							remote-endpoint = <&mixer_out3_ep>;
+						};
+					};
+
+					port@61 {
+						reg = <0x61>;
+
+						xbar_mixer_out4_ep: endpoint {
+							remote-endpoint = <&mixer_out4_ep>;
+						};
+					};
+
+					port@62 {
+						reg = <0x62>;
+
+						xbar_mixer_out5_ep: endpoint {
+							remote-endpoint = <&mixer_out5_ep>;
+						};
+					};
+				};
+
+				i2s@2901000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s1_cif_ep: endpoint {
+								remote-endpoint = <&xbar_i2s1_ep>;
+							};
+						};
+
+						i2s1_port: port@1 {
+							reg = <1>;
+
+							i2s1_dap_ep: endpoint {
+								dai-format = "i2s";
+								/* Place holder for external Codec */
+							};
+						};
+					};
+				};
+
+				i2s@2901100 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s2_cif_ep: endpoint {
+								remote-endpoint = <&xbar_i2s2_ep>;
+							};
+						};
+
+						i2s2_port: port@1 {
+							reg = <1>;
+
+							i2s2_dap_ep: endpoint {
+								dai-format = "i2s";
+								/* Place holder for external Codec */
+							};
+						};
+					};
+				};
+
+				i2s@2901300 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s4_cif_ep: endpoint {
+								remote-endpoint = <&xbar_i2s4_ep>;
+							};
+						};
+
+						i2s4_port: port@1 {
+							reg = <1>;
+
+							i2s4_dap_ep: endpoint {
+								dai-format = "i2s";
+								/* Place holder for external Codec */
+							};
+						};
+					};
+				};
+
+				i2s@2901500 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							i2s6_cif_ep: endpoint {
+								remote-endpoint = <&xbar_i2s6_ep>;
+							};
+						};
+
+						i2s6_port: port@1 {
+							reg = <1>;
+
+							i2s6_dap_ep: endpoint {
+								dai-format = "i2s";
+								/* Place holder for external Codec */
+							};
+						};
+					};
+				};
+
+				sfc@2902000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc1_cif_in_ep: endpoint {
+								remote-endpoint = <&xbar_sfc1_in_ep>;
+							};
+						};
+
+						sfc1_out_port: port@1 {
+							reg = <1>;
+
+							sfc1_cif_out_ep: endpoint {
+								remote-endpoint = <&xbar_sfc1_out_ep>;
+							};
+						};
+					};
+				};
+
+				sfc@2902200 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc2_cif_in_ep: endpoint {
+								remote-endpoint = <&xbar_sfc2_in_ep>;
+							};
+						};
+
+						sfc2_out_port: port@1 {
+							reg = <1>;
+
+							sfc2_cif_out_ep: endpoint {
+								remote-endpoint = <&xbar_sfc2_out_ep>;
+							};
+						};
+					};
+				};
+
+				sfc@2902400 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc3_cif_in_ep: endpoint {
+								remote-endpoint = <&xbar_sfc3_in_ep>;
+							};
+						};
+
+						sfc3_out_port: port@1 {
+							reg = <1>;
+
+							sfc3_cif_out_ep: endpoint {
+								remote-endpoint = <&xbar_sfc3_out_ep>;
+							};
+						};
+					};
+				};
+
+				sfc@2902600 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							sfc4_cif_in_ep: endpoint {
+								remote-endpoint = <&xbar_sfc4_in_ep>;
+							};
+						};
+
+						sfc4_out_port: port@1 {
+							reg = <1>;
+
+							sfc4_cif_out_ep: endpoint {
+								remote-endpoint = <&xbar_sfc4_out_ep>;
+							};
+						};
+					};
+				};
+
+				amx@2903000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx1_in1_ep: endpoint {
+								remote-endpoint = <&xbar_amx1_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx1_in2_ep: endpoint {
+								remote-endpoint = <&xbar_amx1_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx1_in3_ep: endpoint {
+								remote-endpoint = <&xbar_amx1_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx1_in4_ep: endpoint {
+								remote-endpoint = <&xbar_amx1_in4_ep>;
+							};
+						};
+
+						amx1_out_port: port@4 {
+							reg = <4>;
+
+							amx1_out_ep: endpoint {
+								remote-endpoint = <&xbar_amx1_out_ep>;
+							};
+						};
+					};
+				};
+
+				amx@2903100 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx2_in1_ep: endpoint {
+								remote-endpoint = <&xbar_amx2_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx2_in2_ep: endpoint {
+								remote-endpoint = <&xbar_amx2_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx2_in3_ep: endpoint {
+								remote-endpoint = <&xbar_amx2_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx2_in4_ep: endpoint {
+								remote-endpoint = <&xbar_amx2_in4_ep>;
+							};
+						};
+
+						amx2_out_port: port@4 {
+							reg = <4>;
+
+							amx2_out_ep: endpoint {
+								remote-endpoint = <&xbar_amx2_out_ep>;
+							};
+						};
+					};
+				};
+
+				amx@2903200 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx3_in1_ep: endpoint {
+								remote-endpoint = <&xbar_amx3_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx3_in2_ep: endpoint {
+								remote-endpoint = <&xbar_amx3_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx3_in3_ep: endpoint {
+								remote-endpoint = <&xbar_amx3_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx3_in4_ep: endpoint {
+								remote-endpoint = <&xbar_amx3_in4_ep>;
+							};
+						};
+
+						amx3_out_port: port@4 {
+							reg = <4>;
+
+							amx3_out_ep: endpoint {
+								remote-endpoint = <&xbar_amx3_out_ep>;
+							};
+						};
+					};
+				};
+
+				amx@2903300 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							amx4_in1_ep: endpoint {
+								remote-endpoint = <&xbar_amx4_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <1>;
+
+							amx4_in2_ep: endpoint {
+								remote-endpoint = <&xbar_amx4_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <2>;
+
+							amx4_in3_ep: endpoint {
+								remote-endpoint = <&xbar_amx4_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <3>;
+
+							amx4_in4_ep: endpoint {
+								remote-endpoint = <&xbar_amx4_in4_ep>;
+							};
+						};
+
+						amx4_out_port: port@4 {
+							reg = <4>;
+
+							amx4_out_ep: endpoint {
+								remote-endpoint = <&xbar_amx4_out_ep>;
+							};
+						};
+					};
+				};
+
+				adx@2903800 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx1_in_ep: endpoint {
+								remote-endpoint = <&xbar_adx1_in_ep>;
+							};
+						};
+
+						adx1_out1_port: port@1 {
+							reg = <1>;
+
+							adx1_out1_ep: endpoint {
+								remote-endpoint = <&xbar_adx1_out1_ep>;
+							};
+						};
+
+						adx1_out2_port: port@2 {
+							reg = <2>;
+
+							adx1_out2_ep: endpoint {
+								remote-endpoint = <&xbar_adx1_out2_ep>;
+							};
+						};
+
+						adx1_out3_port: port@3 {
+							reg = <3>;
+
+							adx1_out3_ep: endpoint {
+								remote-endpoint = <&xbar_adx1_out3_ep>;
+							};
+						};
+
+						adx1_out4_port: port@4 {
+							reg = <4>;
+
+							adx1_out4_ep: endpoint {
+								remote-endpoint = <&xbar_adx1_out4_ep>;
+							};
+						};
+					};
+				};
+
+				adx@2903900 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx2_in_ep: endpoint {
+								remote-endpoint = <&xbar_adx2_in_ep>;
+							};
+						};
+
+						adx2_out1_port: port@1 {
+							reg = <1>;
+
+							adx2_out1_ep: endpoint {
+								remote-endpoint = <&xbar_adx2_out1_ep>;
+							};
+						};
+
+						adx2_out2_port: port@2 {
+							reg = <2>;
+
+							adx2_out2_ep: endpoint {
+								remote-endpoint = <&xbar_adx2_out2_ep>;
+							};
+						};
+
+						adx2_out3_port: port@3 {
+							reg = <3>;
+
+							adx2_out3_ep: endpoint {
+								remote-endpoint = <&xbar_adx2_out3_ep>;
+							};
+						};
+
+						adx2_out4_port: port@4 {
+							reg = <4>;
+
+							adx2_out4_ep: endpoint {
+								remote-endpoint = <&xbar_adx2_out4_ep>;
+							};
+						};
+					};
+				};
+
+				adx@2903a00 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx3_in_ep: endpoint {
+								remote-endpoint = <&xbar_adx3_in_ep>;
+							};
+						};
+
+						adx3_out1_port: port@1 {
+							reg = <1>;
+
+							adx3_out1_ep: endpoint {
+								remote-endpoint = <&xbar_adx3_out1_ep>;
+							};
+						};
+
+						adx3_out2_port: port@2 {
+							reg = <2>;
+
+							adx3_out2_ep: endpoint {
+								remote-endpoint = <&xbar_adx3_out2_ep>;
+							};
+						};
+
+						adx3_out3_port: port@3 {
+							reg = <3>;
+
+							adx3_out3_ep: endpoint {
+								remote-endpoint = <&xbar_adx3_out3_ep>;
+							};
+						};
+
+						adx3_out4_port: port@4 {
+							reg = <4>;
+
+							adx3_out4_ep: endpoint {
+								remote-endpoint = <&xbar_adx3_out4_ep>;
+							};
+						};
+					};
+				};
+
+				adx@2903b00 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							adx4_in_ep: endpoint {
+								remote-endpoint = <&xbar_adx4_in_ep>;
+							};
+						};
+
+						adx4_out1_port: port@1 {
+							reg = <1>;
+
+							adx4_out1_ep: endpoint {
+								remote-endpoint = <&xbar_adx4_out1_ep>;
+							};
+						};
+
+						adx4_out2_port: port@2 {
+							reg = <2>;
+
+							adx4_out2_ep: endpoint {
+								remote-endpoint = <&xbar_adx4_out2_ep>;
+							};
+						};
+
+						adx4_out3_port: port@3 {
+							reg = <3>;
+
+							adx4_out3_ep: endpoint {
+								remote-endpoint = <&xbar_adx4_out3_ep>;
+							};
+						};
+
+						adx4_out4_port: port@4 {
+							reg = <4>;
+
+							adx4_out4_ep: endpoint {
+								remote-endpoint = <&xbar_adx4_out4_ep>;
+							};
+						};
+					};
+				};
+
+				dmic@2904200 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							dmic3_cif_ep: endpoint {
+								remote-endpoint = <&xbar_dmic3_ep>;
+							};
+						};
+
+						dmic3_port: port@1 {
+							reg = <1>;
+
+							dmic3_dap_ep: endpoint {
+								/* Place holder for external Codec */
+							};
+						};
+					};
+				};
+
+				mvc@290a000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							mvc1_cif_in_ep: endpoint {
+								remote-endpoint = <&xbar_mvc1_in_ep>;
+							};
+						};
+
+						mvc1_out_port: port@1 {
+							reg = <1>;
+
+							mvc1_cif_out_ep: endpoint {
+								remote-endpoint = <&xbar_mvc1_out_ep>;
+							};
+						};
+					};
+				};
+
+				mvc@290a200 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0>;
+
+							mvc2_cif_in_ep: endpoint {
+								remote-endpoint = <&xbar_mvc2_in_ep>;
+							};
+						};
+
+						mvc2_out_port: port@1 {
+							reg = <1>;
+
+							mvc2_cif_out_ep: endpoint {
+								remote-endpoint = <&xbar_mvc2_out_ep>;
+							};
+						};
+					};
+				};
+
+				amixer@290bb00 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port@0 {
+							reg = <0x0>;
+
+							mixer_in1_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_in1_ep>;
+							};
+						};
+
+						port@1 {
+							reg = <0x1>;
+
+							mixer_in2_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_in2_ep>;
+							};
+						};
+
+						port@2 {
+							reg = <0x2>;
+
+							mixer_in3_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_in3_ep>;
+							};
+						};
+
+						port@3 {
+							reg = <0x3>;
+
+							mixer_in4_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_in4_ep>;
+							};
+						};
+
+						port@4 {
+							reg = <0x4>;
+
+							mixer_in5_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_in5_ep>;
+							};
+						};
+
+						port@5 {
+							reg = <0x5>;
+
+							mixer_in6_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_in6_ep>;
+							};
+						};
+
+						port@6 {
+							reg = <0x6>;
+
+							mixer_in7_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_in7_ep>;
+							};
+						};
+
+						port@7 {
+							reg = <0x7>;
+
+							mixer_in8_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_in8_ep>;
+							};
+						};
+
+						port@8 {
+							reg = <0x8>;
+
+							mixer_in9_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_in9_ep>;
+							};
+						};
+
+						port@9 {
+							reg = <0x9>;
+
+							mixer_in10_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_in10_ep>;
+							};
+						};
+
+						mixer_out1_port: port@a {
+							reg = <0xa>;
+
+							mixer_out1_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_out1_ep>;
+							};
+						};
+
+						mixer_out2_port: port@b {
+							reg = <0xb>;
+
+							mixer_out2_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_out2_ep>;
+							};
+						};
+
+						mixer_out3_port: port@c {
+							reg = <0xc>;
+
+							mixer_out3_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_out3_ep>;
+							};
+						};
+
+						mixer_out4_port: port@d {
+							reg = <0xd>;
+
+							mixer_out4_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_out4_ep>;
+							};
+						};
+
+						mixer_out5_port: port@e {
+							reg = <0xe>;
+
+							mixer_out5_ep: endpoint {
+								remote-endpoint = <&xbar_mixer_out5_ep>;
+							};
+						};
+					};
+				};
+
+				admaif@290f000 {
+					status = "okay";
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						admaif0_port: port@0 {
+							reg = <0x0>;
+
+							admaif0_ep: endpoint {
+								remote-endpoint = <&xbar_admaif0_ep>;
+							};
+						};
+
+						admaif1_port: port@1 {
+							reg = <0x1>;
+
+							admaif1_ep: endpoint {
+								remote-endpoint = <&xbar_admaif1_ep>;
+							};
+						};
+
+						admaif2_port: port@2 {
+							reg = <0x2>;
+
+							admaif2_ep: endpoint {
+								remote-endpoint = <&xbar_admaif2_ep>;
+							};
+						};
+
+						admaif3_port: port@3 {
+							reg = <0x3>;
+
+							admaif3_ep: endpoint {
+								remote-endpoint = <&xbar_admaif3_ep>;
+							};
+						};
+
+						admaif4_port: port@4 {
+							reg = <0x4>;
+
+							admaif4_ep: endpoint {
+								remote-endpoint = <&xbar_admaif4_ep>;
+							};
+						};
+
+						admaif5_port: port@5 {
+							reg = <0x5>;
+
+							admaif5_ep: endpoint {
+								remote-endpoint = <&xbar_admaif5_ep>;
+							};
+						};
+
+						admaif6_port: port@6 {
+							reg = <0x6>;
+
+							admaif6_ep: endpoint {
+								remote-endpoint = <&xbar_admaif6_ep>;
+							};
+						};
+
+						admaif7_port: port@7 {
+							reg = <0x7>;
+
+							admaif7_ep: endpoint {
+								remote-endpoint = <&xbar_admaif7_ep>;
+							};
+						};
+
+						admaif8_port: port@8 {
+							reg = <0x8>;
+
+							admaif8_ep: endpoint {
+								remote-endpoint = <&xbar_admaif8_ep>;
+							};
+						};
+
+						admaif9_port: port@9 {
+							reg = <0x9>;
+
+							admaif9_ep: endpoint {
+								remote-endpoint = <&xbar_admaif9_ep>;
+							};
+						};
+
+						admaif10_port: port@a {
+							reg = <0xa>;
+
+							admaif10_ep: endpoint {
+								remote-endpoint = <&xbar_admaif10_ep>;
+							};
+						};
+
+						admaif11_port: port@b {
+							reg = <0xb>;
+
+							admaif11_ep: endpoint {
+								remote-endpoint = <&xbar_admaif11_ep>;
+							};
+						};
+
+						admaif12_port: port@c {
+							reg = <0xc>;
+
+							admaif12_ep: endpoint {
+								remote-endpoint = <&xbar_admaif12_ep>;
+							};
+						};
+
+						admaif13_port: port@d {
+							reg = <0xd>;
+
+							admaif13_ep: endpoint {
+								remote-endpoint = <&xbar_admaif13_ep>;
+							};
+						};
+
+						admaif14_port: port@e {
+							reg = <0xe>;
+
+							admaif14_ep: endpoint {
+								remote-endpoint = <&xbar_admaif14_ep>;
+							};
+						};
+
+						admaif15_port: port@f {
+							reg = <0xf>;
+
+							admaif15_ep: endpoint {
+								remote-endpoint = <&xbar_admaif15_ep>;
+							};
+						};
+
+						admaif16_port: port@10 {
+							reg = <0x10>;
+
+							admaif16_ep: endpoint {
+								remote-endpoint = <&xbar_admaif16_ep>;
+							};
+						};
+
+						admaif17_port: port@11 {
+							reg = <0x11>;
+
+							admaif17_ep: endpoint {
+								remote-endpoint = <&xbar_admaif17_ep>;
+							};
+						};
+
+						admaif18_port: port@12 {
+							reg = <0x12>;
+
+							admaif18_ep: endpoint {
+								remote-endpoint = <&xbar_admaif18_ep>;
+							};
+						};
+
+						admaif19_port: port@13 {
+							reg = <0x13>;
+
+							admaif19_ep: endpoint {
+								remote-endpoint = <&xbar_admaif19_ep>;
+							};
+						};
+					};
+				};
+			};
+
+			dma-controller@2930000 {
+				status = "okay";
+			};
+
+			interrupt-controller@2a40000 {
+				status = "okay";
+			};
+		};
+
 		ethernet@6800000 {
 			status = "okay";
 
@@ -73,4 +1799,59 @@
 	serial {
 		status = "okay";
 	};
+
+	sound {
+		status = "okay";
+
+		compatible = "nvidia,tegra186-audio-graph-card";
+
+		dais = /* ADMAIF (FE) Ports */
+		       <&admaif0_port>, <&admaif1_port>, <&admaif2_port>, <&admaif3_port>,
+		       <&admaif4_port>, <&admaif5_port>, <&admaif6_port>, <&admaif7_port>,
+		       <&admaif8_port>, <&admaif9_port>, <&admaif10_port>, <&admaif11_port>,
+		       <&admaif12_port>, <&admaif13_port>, <&admaif14_port>, <&admaif15_port>,
+		       <&admaif16_port>, <&admaif17_port>, <&admaif18_port>, <&admaif19_port>,
+		       /* XBAR Ports */
+		       <&xbar_i2s1_port>, <&xbar_i2s2_port>, <&xbar_i2s4_port>,
+		       <&xbar_i2s6_port>, <&xbar_dmic3_port>,
+		       <&xbar_sfc1_in_port>, <&xbar_sfc2_in_port>,
+		       <&xbar_sfc3_in_port>, <&xbar_sfc4_in_port>,
+		       <&xbar_mvc1_in_port>, <&xbar_mvc2_in_port>,
+		       <&xbar_amx1_in1_port>, <&xbar_amx1_in2_port>,
+		       <&xbar_amx1_in3_port>, <&xbar_amx1_in4_port>,
+		       <&xbar_amx2_in1_port>, <&xbar_amx2_in2_port>,
+		       <&xbar_amx2_in3_port>, <&xbar_amx2_in4_port>,
+		       <&xbar_amx3_in1_port>, <&xbar_amx3_in2_port>,
+		       <&xbar_amx3_in3_port>, <&xbar_amx3_in4_port>,
+		       <&xbar_amx4_in1_port>, <&xbar_amx4_in2_port>,
+		       <&xbar_amx4_in3_port>, <&xbar_amx4_in4_port>,
+		       <&xbar_adx1_in_port>, <&xbar_adx2_in_port>,
+		       <&xbar_adx3_in_port>, <&xbar_adx4_in_port>,
+		       <&xbar_mixer_in1_port>, <&xbar_mixer_in2_port>,
+		       <&xbar_mixer_in3_port>, <&xbar_mixer_in4_port>,
+		       <&xbar_mixer_in5_port>, <&xbar_mixer_in6_port>,
+		       <&xbar_mixer_in7_port>, <&xbar_mixer_in8_port>,
+		       <&xbar_mixer_in9_port>, <&xbar_mixer_in10_port>,
+		       /* HW accelerators */
+		       <&sfc1_out_port>, <&sfc2_out_port>,
+		       <&sfc3_out_port>, <&sfc4_out_port>,
+		       <&mvc1_out_port>, <&mvc2_out_port>,
+		       <&amx1_out_port>, <&amx2_out_port>,
+		       <&amx3_out_port>, <&amx4_out_port>,
+		       <&adx1_out1_port>, <&adx1_out2_port>,
+		       <&adx1_out3_port>, <&adx1_out4_port>,
+		       <&adx2_out1_port>, <&adx2_out2_port>,
+		       <&adx2_out3_port>, <&adx2_out4_port>,
+		       <&adx3_out1_port>, <&adx3_out2_port>,
+		       <&adx3_out3_port>, <&adx3_out4_port>,
+		       <&adx4_out1_port>, <&adx4_out2_port>,
+		       <&adx4_out3_port>, <&adx4_out4_port>,
+		       <&mixer_out1_port>, <&mixer_out2_port>, <&mixer_out3_port>,
+		       <&mixer_out4_port>, <&mixer_out5_port>,
+		       /* BE I/O Ports */
+		       <&i2s1_port>, <&i2s2_port>, <&i2s4_port>, <&i2s6_port>,
+		       <&dmic3_port>;
+
+		label = "NVIDIA Jetson AGX Orin APE";
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index e1885ca..34babc4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1691,6 +1691,24 @@
 		status = "disabled";
 	};
 
+	sound {
+		status = "disabled";
+
+		clocks = <&bpmp TEGRA234_CLK_PLLA>,
+			 <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+		clock-names = "pll_a", "plla_out0";
+		assigned-clocks = <&bpmp TEGRA234_CLK_PLLA>,
+				  <&bpmp TEGRA234_CLK_PLLA_OUT0>,
+				  <&bpmp TEGRA234_CLK_AUD_MCLK>;
+		assigned-clock-parents = <0>,
+					 <&bpmp TEGRA234_CLK_PLLA>,
+					 <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_APER &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_APEW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommus = <&smmu_niso0 TEGRA234_SID_APE>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.7.4

