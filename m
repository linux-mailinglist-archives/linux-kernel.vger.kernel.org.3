Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DB0494B68
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359756AbiATKJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:09:44 -0500
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:27936
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234793AbiATKJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:09:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EW6vlH+Qw93J4evHiZGxDLTn0sEzttafBiWh4+t2kVl3qaGU1dTd0L/Okqtrw2hIjLbyOFAFew1l13pVeEfzsvC1a8KsfcWv5+ZiN1D3PkcjKR2Xt7RGqa1Ipd/RpK8VuoOBAhiYj19y4pMdO8jvSrshOB5PcdKsUvUwyee0L5xrgzICRSunvt2iEZLYTUu3k4m+H41FKvSEVcuwiuvVaWiMvgO4giLo6e/yIAjPJoBbSdkA9HIVjngcEBel/fiN1qxrfTbm4NSKu11d3a/shymZVfmfg3gy+JADN2uOOxKzfmPaJPMyO3Vv1v7zvQ7/ZAZR2+wRFvkdaA8uG3b+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3fiCp/p+PA/hlhAEiW5b1I2rwvFkyhwDZS2D6kP/Mc=;
 b=jcto6MTQkctj8Bm16H1NWUI+p1lzpzdhmDorm7PDdRhjh76d2UQgDbX5InroowOjI/Uxr+9cg5kaNj/apUnV4znV5rk02WLb/oUQs/a499UvmmmtL6VayaL0e8qlQ5l84qNWReYPzkB6cRZe/SON4Fpfd4V9avt1rXXaod6MLOCBmSNA4dwDgW/HGEzanK2Cx6U4+gv9UNrr7ile+sbdGGMKL7uXB0lg++D5c3/+oTiUQU2UgEd1FSvutrN6pOZehgbjpOtAF3Y3RCSV4wagLMtKjety7A5grdpkZthjSkdtVXWJ915Cmn617S+bLeumnaHyM4YycoI9jm2n8/8hDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3fiCp/p+PA/hlhAEiW5b1I2rwvFkyhwDZS2D6kP/Mc=;
 b=kf7dlIyV51Jg1ut6ptlxFf1DgR6mKi9IXT6rBpvo2kfaR2hhiehnX9a82WQ4vxHE+lm4HYFGR4Dd5XOasuv3+Jh92lUP9qG3uaE9lEgiDtaD/0f8EsTKLKEPf9Rpp09FJWnmwex+ebvfSGe81Ln3uEeDAp2RJZepqmfOXNyaaTtjVZixVL2hMDjfLezHlrYjqLhSgNS4su3r9QlnW/HCP4l4mls5ZZouLdSqGftS3cPkpW/G8me45NVgOcWujM7rXZU0AliBAt+eQb0+oNhTv1i16VAzhSWXr817WY+1a9fU1uC040zuGZ9HH/RijjecIp4Zj/Q3aNVKuW1Kk/xmIQ==
Received: from BN7PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:20::25)
 by DM5PR12MB2454.namprd12.prod.outlook.com (2603:10b6:4:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 10:09:41 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::e7) by BN7PR02CA0012.outlook.office365.com
 (2603:10b6:408:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 10:09:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 10:09:40 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 20 Jan
 2022 10:09:39 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 20 Jan
 2022 10:09:39 +0000
Received: from kkartik-desktop.nvidia.com (10.127.8.12) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 20 Jan 2022 10:09:37 +0000
From:   Kartik <kkartik@nvidia.com>
To:     <robh+dt@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kkartik@nvidia.com>
Subject: [PATCH] arm64: tegra: enable uart instance on 40-pin header
Date:   Thu, 20 Jan 2022 15:41:51 +0530
Message-ID: <1642673511-8267-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4a00620-538c-48f5-4463-08d9dbfcf929
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2454CF3EE42235AD82EEE482CD5A9@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: st5RrF2eoLwpJBCcOeCd8YGd1cSiWRLZdzrNvXPK28k4D13gSCpkGUNhF16gOHf39jCwV4t4bNaJGORIVHYaFM5O7kjRpD1lH/K+kp7upo+oZ6k8PS0svWGZdJm2Wmdi8T/wSip4ONQohl3kZgXw/ok9IoWtOxqA9Xn6LXz8HCa0zNjIm2tRuzl2oqX4lsOaaNsxv39i1shcmSIBplHRO5sGme4GjEMMdo6PKcVzB1CrKTfr8y2h77yV1A37a094XUw+jHasXpFmfxpCoCLJVt1OzOd2U57kRgVUj6A7siK1ZDG5Wjx7s1v7ZFDjgE9Q2ecBA4jKy47n8EoaDwakUUGItsVszfv8fZuE5Sq9ixVPSG8fQkVEbN0H+f7Y+r2sjCgi14cJwNeh3u1zyYQEPb4ixEm3DecG5eSiMHtSu7VqDouhGO5DhD+xqM/5L26q4lFLrhlPCvzlYeZ9+smGLE50etV+0dh3j/FLMJ8Nabj36hVzCS4FUVI9uFTmJFbIciam8WT6TfXgh6A4sdDb/rcLGZEXyoahlhfchBovtxr4OjfQTrffP1gkHZsVAXUiAOu4ajxtiQuDwcFCeMgs9CbwUtU22JW0+wi6Ey7OZCFWlOSjK/EdTHtI9SA4jp7FGK3tUQp1pfQgpi64hmUOqbl+4G9DUIF1GqQGd6De/31iUNnMXigSoMGRd6khKq4430xIT+IJbhJKSSGz/ubKH8WslfYD0kOpiKNiJ+T2RmcZpM49Ir3u86xlwdXMWq68YJ6LF8lnTbltm6Xq5XW4g98/bs4+UPuaz4zpP6sjgKY=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(82310400004)(356005)(47076005)(70206006)(5660300002)(6666004)(70586007)(36860700001)(8936002)(316002)(40460700001)(86362001)(36756003)(336012)(2906002)(2616005)(426003)(508600001)(186003)(26005)(7696005)(81166007)(8676002)(7049001)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 10:09:40.6389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a00620-538c-48f5-4463-08d9dbfcf929
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kartik <kkartik@nvidia.com>

On P3737 board, UART-A is available on 40-pin header.

Enable UART-A for P3737 and change the compatible string to
"nvidia,tegra194-hsuart". This enables serial-tegra driver, which
supports HW flow control and is the preffered driver for higher
baud rates.

Signed-off-by: kartik <kkartik@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index efbbb87..4eda238 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -11,6 +11,7 @@
 	aliases {
 		mmc3 = "/bus@0/mmc@3460000";
 		serial0 = &tcu;
+		serial1 = &uarta;
 	};
 
 	chosen {
@@ -18,6 +19,13 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	bus@0 {
+		serial@3100000 {
+			compatible = "nvidia,tegra194-hsuart";
+			status = "okay";
+		};
+	};
+
 	serial {
 		status = "okay";
 	};
-- 
2.7.4

