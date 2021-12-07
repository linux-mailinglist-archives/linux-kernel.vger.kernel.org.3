Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63A46B30C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbhLGGlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:41:11 -0500
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:17249
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237253AbhLGGlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:41:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxqHAkXSWZMKr0O6XofPOgITboOKIFsQEp4jhapNG12oPBkr5hH1r++bz1e5R+VWev7CTEnnRHDgac2TLSegHFn1e0khGFhQMBY0FD0ijjpvMHb89DidJGyemT+FyeyGoVssnZSfmEJwas+x/gmDjTFu8VtIgrQupwN/NvA1ymRYbB2eF6e1MUjItHhqWUrsRCE7Tl81vee5u2dhcVbEsPUZWbDDha2a2aOxxiXApFYgJOt6kQfGZ0lR4HGL1CDByGRY994eEbHq/GgNwz29xKjOCSGmg/D/W3kamhu9yR0+rja7i9p3vn74eSGyb2ggJOfoO9vZzHh0gtPKxLH4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW2CBw1ZqgMzRjVYduwvq7BT9NVzCPU6/lpqXt4Mmzw=;
 b=iM7of2d5fbgt3L6QApA+41pOs3poWW4Seclka3LyZRDeQinAHFF5Utx0edw7fe50tloBSN5WL3UW/MZU52K+hmqOmIKCH2fncLNDzDUcbbwlXdPr90Mr+M/Xy7yFRToN7afzoJBbQ1Uh/hX9ww2QLjoklVIZks7bGgUPwlHAqa49PO/bxNdK+b602mhjEI9U9BuPwKw9WFUURpCHXOTMlyZCrSWt123U6g60KG8422fSHrDgjSVL49V2yoU0uRzrwYoZzrYphaeh6g5xgzwYaIXzgCHICEh+MpOPf5WUsxsL2w5CEDlU7IiP67M+TNRYjXaIqIikD3ocFCd1VAz/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW2CBw1ZqgMzRjVYduwvq7BT9NVzCPU6/lpqXt4Mmzw=;
 b=RoV5gQk3wRxbAygBmzQrdbJDj2M2v8/V7RksaTyxrjXnp8jmBHjVYyVOBep1ZWqeCDl8ItaZ7vq8GG0ZUjVJswKcPjioUuqKNYix/RxwykjZ0pGuv0Gz3HWCJWCAzvv9XRiWuGZzUjK3mu9BG9Su3g/dsYi8vvVOIXV2Q2+ezZJp5YAxHxDmZm6SVGkfMpPmP3OqNLeE+Mz7jGjZuUCRE+Z+0GRxTMXAkK1ETeMLpNLfwHG67h7c1wDbkcg9XsJoyX3OI8l6vpDRyqJA38jyliWvOnVn7biy4K/kuzx10ntFjPsvWEVZh+2C4VAiewO3H1qMHc35l0eBrzWJflDiAA==
Received: from BN1PR14CA0025.namprd14.prod.outlook.com (2603:10b6:408:e3::30)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 06:37:36 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::6) by BN1PR14CA0025.outlook.office365.com
 (2603:10b6:408:e3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Tue, 7 Dec 2021 06:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 06:37:36 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 6 Dec
 2021 22:37:24 -0800
Received: from audio.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 6 Dec 2021 22:37:21 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <perex@perex.cz>
CC:     <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/3] arm64: tegra: Remove non existent Tegra194 reset
Date:   Tue, 7 Dec 2021 12:02:50 +0530
Message-ID: <1638858770-22594-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638858770-22594-1-git-send-email-spujar@nvidia.com>
References: <1638858770-22594-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1670f76f-f165-437d-63fb-08d9b94c0e9d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4895:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48955067DC81BE52A8D8DB04A76E9@DM6PR12MB4895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LttAvFrAwr2Tk/vNM1w9jRsm+ZwGeZFpU4IJOYBJTPCBxnYRKWnDPclVhx83lEiRT6zJPHIKXlTyghD7v+y9Bxs4styhXYhqPJORySeOnFeHshCOrrgSBIX5P38lAGayylOqndetM2dcu1NDLN5BEbJ0KB8nKm7oIiK3iLbsFy9lca71kyMLVyTZeHeSLq2RkpEhqKXfwlGfueVK4LQIg6ncd6wJn0n4ygeGgEsPFIQSIB+fN04dSgqipO8kH9Emg6nOWlQYFzN88348BSk4EYzZmAsJVAi/tbThAwxQ5EHQJiZVF+5Z4y1XpdUjqDjZSjU9O74KL5buU411XEEHiCIHnO7ONr7v5OJxXWsx4bfx9UZ5BVtR4SnteW346Ge72LfZk/aH/StBk5P06orkSrJRC3to7x4yerBSKqXcOmi4Ni4YYVIZlG6fZQ54zoqNpv0zTSKXQtn0LwsZhcjqqntiLqqF1/emHZDJSjDvj3GoUflKNN8gK67pQiiL1tWtYo2NOs/PUPsEv8OWIhCgAc6433IoWSCQvlDbxsrBFfoC+Ep8YE9SZi3ZuxrW8lzLDkqlP2gG+NUbT6RVi1sZdVbtWJ34ilPqs302UdYORfEsYFypJzPB5nAsCiKan9lKiA/KtrQpCGIRODwmLT0J10WMFi1OuLBmEfCT4j/wsD7u3duAZcluBX8YphqDmY4Q4k5oFmAe2R7sJEfzm7SYBTXvAcTkke83X5EeJRmL6i1IMy94820mpRx9b6sHCUZhy8Er5UMZ9Ni2FRRVZH+gRyYtsM7zqJ3hZ25F4lAFMRc=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(110136005)(54906003)(83380400001)(36756003)(2616005)(34070700002)(82310400004)(86362001)(2906002)(36860700001)(40460700001)(8936002)(508600001)(356005)(4326008)(26005)(7636003)(107886003)(426003)(336012)(5660300002)(6666004)(70586007)(316002)(7416002)(70206006)(8676002)(7696005)(47076005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 06:37:36.1766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1670f76f-f165-437d-63fb-08d9b94c0e9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
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

