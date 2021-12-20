Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18247B22A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbhLTRbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:31:25 -0500
Received: from mail-co1nam11on2085.outbound.protection.outlook.com ([40.107.220.85]:15008
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240224AbhLTRbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:31:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkNf2zic6+ueYRzt9WVJTf1pqmJIxOhTNfVA5kpHJWBwKHMYcn6FVbd3RoDGq7bvumTU83xJvCn1EJlQAKbIp9z646jedIJf3i6UXgwxG0G7ZGHupI5MOhTplLI3augCT6vwIotqnejB7JEysLnPmpm7+Uaps7MCNvcGASf5eVS5sCEQg8cqy7iG0bUE92pxWwFi5CKW0x7kz2OgEdyHkvusiAdUJPDvKBnEFOaSzt08lM8FTVk1a8GLSRbV8X/BDZ7SSV7ueWt0HtnZOx2pgixPjNbHjVE4huRyD0Dh7agdJdl3KeWS79XzSVQCE/87NO8eC+CKERcos8fjJ6tHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW2CBw1ZqgMzRjVYduwvq7BT9NVzCPU6/lpqXt4Mmzw=;
 b=l8q9NNLzKSUKUG5zsQrvyLKdAo8gYGTLN4O3pLUBDoxbgk/27A+gG2GvXZG5rVtFKuRYDEcSzorTf/Kf0shHCnuuCiklhdBH9G+ABkEjxRQnG+zudMHBtUUFhOCkPtg4JdfKPcJ3WmyNjOYi2/w4A2nDFwImrFf02wgco7hBUg4TPixy5rzlQeLAp8Ag0505bIDYsqitwGOt67I0K6nDkEvSha+MD9O9/D6/gaONKaFiNR9BUI5UIzDiOUI/b7V+v/gvj4tiHOpjgDjx2W81szl9JFHHlluM8Y7MlkzO8NG4DCespd61x0YfZR3xPSMxqNBms+8du+hcsVtRqYQ5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=suse.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW2CBw1ZqgMzRjVYduwvq7BT9NVzCPU6/lpqXt4Mmzw=;
 b=fTOgTI6HSDZ0ymgeINlKNDm9YXVflG3hO9rBxRJwZ0NM7GWPOIn8YM32o5h7w2yY0H3Trq3w9MLw0cUAw9S3/zXIk+e52Vz3+NLmh54uLtnCFY+/Glcblq3xVzcl84TKs6hwd/GsKWqFVaWuKF99opfG6O2liWEGn0nVmfmlmYv1c+uB3llUU3NP0AU5NZ7xZyWnh9DaCWG01pFR+6z0n9UCQaMB/cG6pVCgB1jFtd8W2qzriIVD5Tpk4m3qg9usbMf9qWy6IXI6IzlRojJkZe5yQJNnuey2OckZzw4wmAgtGKKQMTaCE8LZWunyH+dUVnLbkyCm+6/zVAhpiOEZzQ==
Received: from BN9PR03CA0619.namprd03.prod.outlook.com (2603:10b6:408:106::24)
 by BN6PR12MB1457.namprd12.prod.outlook.com (2603:10b6:405:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 17:31:18 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::40) by BN9PR03CA0619.outlook.office365.com
 (2603:10b6:408:106::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Mon, 20 Dec 2021 17:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Mon, 20 Dec 2021 17:31:18 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 20 Dec
 2021 17:30:43 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 20 Dec
 2021 09:30:43 -0800
Received: from audio.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 20 Dec 2021 17:30:40 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <perex@perex.cz>
CC:     <jonathanh@nvidia.com>, <digetx@gmail.com>, <mkumard@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 3/3] arm64: tegra: Remove non existent Tegra194 reset
Date:   Mon, 20 Dec 2021 23:00:08 +0530
Message-ID: <1640021408-12824-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640021408-12824-1-git-send-email-spujar@nvidia.com>
References: <1640021408-12824-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bfaff71-5cf1-4660-b29b-08d9c3de8875
X-MS-TrafficTypeDiagnostic: BN6PR12MB1457:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14571B8912AC3DA7AFEAC691A77B9@BN6PR12MB1457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYrs9g+jP+SykKrX6IMIvrZwc8aQ4NFgJB7ZN8uOXzvJ7sm039b6lcxtip2NXCZFazICgVWqvZfFwVny3B5BgVWxKEv4R10BrvhYY+kwAlxc12cp0gKZ4zT6yG3m8KxqUxDUqZJY1xiNju3jrqfhxtpmuvhdssLBPdHGLQYB4Mn4tXdPiDxluxn0ebjzqmsKt0CUMLrJ553vn43RX6ZWsw9R58sDl5Fzd9re+OrNZq64ID7RcS6RoQp9jeVVr0b//1fdvo83MQ6/sxEMBZQNvWy/gyM6pjTq7vBEWAhnbypEEJwMZe8Kdzc+QIw5KzVaclhRuPtJQiUc1USCRxiBAm6GGSFng1VrrzaFGP7alq6E0V5kd+jI/n556IJFY9EUBj3fUJvGnyTv1BFGPmglhVV8l9MDmo5n3aXPA2PHiTE08hke+Y/Goweh0IPwyhQmywveU/WcI7cC4IjaOsvWcW6AOncIm7Ma4uhXhxliy5zoh/Cq3WbsKz9FbWxSH1X8rodeu9rqzKuFy7CAycnEmX7HfmwkZCvd5cHUWa3k8Czjiy9JlwRtjUUoqonVcNKJky1+I/v1dqxs2/PPL9VVLQKsmMMqvZTyqSdOPsqggne1vebevB96Sk7J5PKMdoGBsrnM9Y9aHguu5ilAclaRadevzFx5swmlul/Ee/P8jeB/qJXOkF1w0IF0itvF9RazjkUvXe5w0a6ytRTvvtmSGkdx9JlaWG7JoPQqce1vqpkqDWZ3DHvpIO/4hvh5BVvB9Z2BgCtUXjmzhKkewtS3uyuYrdkmMnniQVPMyeKNNXDD2bpJdGGlOutP2MZoVdPyp3OkOHmCLFiPhbv8HBM6Kg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(356005)(81166007)(83380400001)(7696005)(7416002)(5660300002)(186003)(508600001)(36756003)(86362001)(8676002)(82310400004)(54906003)(316002)(26005)(2906002)(40460700001)(8936002)(110136005)(426003)(6666004)(2616005)(70206006)(336012)(70586007)(4326008)(107886003)(36860700001)(47076005)(34020700004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 17:31:18.7331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfaff71-5cf1-4660-b29b-08d9c3de8875
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1457
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 does not really have "hda2codec_2x" related reset. Hence drop
this entry to reflect actual HW.

Fixes: 4878cc0c9fab ("arm64: tegra: Add HDA controller on Tegra194")
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 8d29b7f..6a1d896 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -976,9 +976,8 @@
 				 <&bpmp TEGRA194_CLK_HDA2CODEC_2X>;
 			clock-names = "hda", "hda2hdmi", "hda2codec_2x";
 			resets = <&bpmp TEGRA194_RESET_HDA>,
-				 <&bpmp TEGRA194_RESET_HDA2HDMICODEC>,
-				 <&bpmp TEGRA194_RESET_HDA2CODEC_2X>;
-			reset-names = "hda", "hda2hdmi", "hda2codec_2x";
+				 <&bpmp TEGRA194_RESET_HDA2HDMICODEC>;
+			reset-names = "hda", "hda2hdmi";
 			power-domains = <&bpmp TEGRA194_POWER_DOMAIN_DISP>;
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_HDAR &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_HDAW &emc>;
-- 
2.7.4

