Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A90749DB86
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiA0H2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:28:14 -0500
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:10464
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237339AbiA0H2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:28:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeKTHsEIIDsVf5w1enApqLXPOPGB7T9bqp++i2Nf/AEcqMRNd7zI6gFlYf5o/40Is6rvY+kcdCE/FT2GMdnDub0wFV26JAbQZ5XViWeZYOh2NynUtdnpbyvhe6T179u14Mz5TnmWHq6Lvx0mV9KXy0SU4y+nE9wSnd0GkvlNoBmHiEYQ44lBUTgXaEsCsUaTHzoSUAR14WDikPjm00weo/KuONodUJvROFp0voNkeG8BqBoH3kCK/PvXIvKPCFlJ4lEGrglTFx2FwqD1lXu5pQBa2Ge3W8eteTgvtQj8n7qNTQ7r1Mmm5+1miHNWRYtNEGkv/FA/K8CjKred4bo8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkn13UsAW/ZN3h0bYMNYhvdFNz92dzzUxrVSSeEPXfc=;
 b=RmRN4H6PfkyDLhbMYHJTvGK6IZmuyroG2Otcs/a6WJ6DZCVmqPzTunjv4QQKkKeR8dDAXvVftmtrkVVh9PmcVGuSO+5Rjli0iK7PHv5p8L9L622cqLjqYvMeME/JdYT0kEtde3TzQgAfJA4bYTEq3dwn9Va+hYyeDKj3VoxIewlGWx/yMgyZmZNupVxuRi3S6pZve7cSjgsIsTSvQqzNvhzu1NK8Eq7Mvea9RGK3bSABEZZMywoqg7m05Q/B2o8MGHo+rdkLF2W0NDT2HfKOzA2i6qaA+8F00wK9uOV5im/+Fa9rTLpsGzJ9G/al9YmE1H33+BrImGY1xwb7qDowCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkn13UsAW/ZN3h0bYMNYhvdFNz92dzzUxrVSSeEPXfc=;
 b=KEyDvhtFsekDGg7z4xb0JXBBwPSElqXoxawxr+8ghiDPmGnBnau3LKZO26aXZVznUqVBgM0wC1U9fBvSio5hQqBFu9+O4Sc0XpM9t6IUTc5XN1osNnLDc7Mg1B1SzacMnDRyBN4BU1Ogb8fVF9I0f2k8svF/3zDf2w4C/zXRe4PzxHAYL0rksJYUPSiF+otTfSr5vnB8WaKqR/IuJfG+A7LayXMEYt1C+DZBeItU0n6h8e1iS9hGm2WKczhLU1WBzRuNClJjwsRYMKa7ndxZYfxNU/Xr0m9dD93/pvchaedyj6xCEUqhJxo/e+3TK5WQu2Qq54r8gG1T2kW/FDJzBA==
Received: from DM5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:3:12b::16)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 07:28:05 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::4c) by DM5PR04CA0030.outlook.office365.com
 (2603:10b6:3:12b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 07:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 07:28:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Thu, 27 Jan 2022 07:28:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Wed, 26 Jan 2022 23:28:03 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 26 Jan 2022 23:28:00 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 5/5] arm64: tegra: APE sound card for Jetson AGX Orin
Date:   Thu, 27 Jan 2022 12:57:35 +0530
Message-ID: <1643268455-15567-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643268455-15567-1-git-send-email-spujar@nvidia.com>
References: <1643268455-15567-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9027cb9-e1fd-4191-ce1a-08d9e1668f43
X-MS-TrafficTypeDiagnostic: BN9PR12MB5145:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51452BDB931C60F3775D9A8AA7219@BN9PR12MB5145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFFMnPJTeLRkNTQ2fwc3SnwiHMVDLoHwhOZ8JbTPvP36KbJbTdqyn5hiq104+OeS7wMHPBmszagCJQYhFuQ0RfTpfc88Tf5uZR3SCDHtpCjIY1UI2Qa1inUJfRSEq5LUft8PougF0iVfGE6qtSblmu4RHqL6M4qZlIYWpc/6PHFHCi8cO1NsArqdzbH4BKJTIKKLerKXMOMNHuvwkRf4Sk5M4NTw8tAXP21a4g8s4MJu27aRZQJZmGNmPXDIw1aiIsuto2851vXKQPNTxVPMqghRhZcIZH/ouAH7fB2wQwqTANK0fxLXWrMlQskcBRkN5pOxYSjqifmoWwUmt3O5KvTW5AnRiFzTqLw8/paie0dM/d9dXxnb+ABoD6vOY3+7o5UJnV5J7QXZf3ddLobW9TvIekbSJ+Jc2Xzt1YQFYK+fxn1+cAumE9dm0eI/U2PE6iTrd1K4RbqU62ft5rJYjhRpjPS35rDN4tRzOUWxaCLPXyPfm2qSFe09888XMzYukycRp+UX82pX2mZ2XsgS9t9xGwuxXzoglizmoKY/whZlwUGiGK47f6eJLSI1aIkuXtavYmzSWWDAgLqHCnyBlQxi5qs+1g9sOKtfow9Aakm/DkOprjovez/U+BcwZpORsDEaIDG/VerbW1s62mzNrRk5tUsmTn5kB8pi1I5IX+hOsVcBgxVRl0XHl7KZic8cfTMejhcUrIzmbOdQqDIzzg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(2906002)(5660300002)(508600001)(7696005)(2616005)(6666004)(36756003)(30864003)(7416002)(83380400001)(4326008)(36860700001)(186003)(47076005)(26005)(316002)(336012)(426003)(54906003)(82310400004)(107886003)(110136005)(81166007)(70206006)(70586007)(40460700003)(8676002)(356005)(8936002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 07:28:05.4104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9027cb9-e1fd-4191-ce1a-08d9e1668f43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  | 1783 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   18 +
 2 files changed, 1801 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index efbbb87..4ae0e9e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -13,6 +13,1734 @@
 		serial0 = &tcu;
 	};
 
+	bus@0 {
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
+	};
+
 	chosen {
 		bootargs = "console=ttyS0,115200n8";
 		stdout-path = "serial0:115200n8";
@@ -21,4 +1749,59 @@
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
index aad7fd5..272a0c0 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1106,6 +1106,24 @@
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

