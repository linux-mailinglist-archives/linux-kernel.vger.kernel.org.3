Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F9247CC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242478AbhLVEgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:36:21 -0500
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:65217
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242496AbhLVEgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:36:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6Ezh73gS4xeyJERFNjJfUiIQ9KvoeSYyyMUwp8skLwikD5wZTFVfRMRuqVJW/wHpoZNY1UdmMO9C4y364ny2CQixy3J9w/8EMl+f4aAArRyiX04t2bXayv4TBu3/gvH1jtUoe3+rcje5RdilMVc+nlXAQPSW6QlAsEF3qS1yhC7G9o/C2uXdIfTgDBWr1rxm5wCzsGOcCi9CP4rt+r3gmgG6Zl9dlzbMF/zu5PC0texFsHZPs2MlobYIdTY1GhO325vqTWGFRJ03HwIRgrTlkyxc4VHZwiKeCP5c9jYHngtGyH8WIljMJwEdNOxob9m2KYdBG3epKHkJ/NwsC60SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW2CBw1ZqgMzRjVYduwvq7BT9NVzCPU6/lpqXt4Mmzw=;
 b=BMvf9qBo7TCd8IYuninEu7cllX/2XG2p/4cMX59bhYLjGBQud3WUy7SS7FQz9CYOamEo5s8jHoZuuL3/rWCDUzsxz+JLEMKdZN23cKahtZLZu3ToZfbiIe/Ev57xV8rC1OZe8a/tL7kqwxJeEPZqAPm06//AHvwDBqoqcvJQ1yzP1ioFoFK37vtTILgdtlcynvuoWWZ31WcSmLNdgE3OPVnj7lHz1NEHy4OfkJRIq392LD5pwOieYj/oFzPm6E3/TZSG7uUW69ChD5zBDnUBaLMI+ICbbk88zeG+T/Akjy95JhMYtO7XwWWegaQIqzHHxbtHONAF1b14+7UXHg0cqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=suse.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW2CBw1ZqgMzRjVYduwvq7BT9NVzCPU6/lpqXt4Mmzw=;
 b=Hi9wxwdDTEkv7lqD35Mfc4eaNSU7QbmtDcHft/zVMtguMSzlPGgleX/5oP7/A7uYQPIeXPDzbHnZeSdXqS1vbu3p3coU/B1IlTg5u75TDnmcAZOlbY6rJJHoPOFTwUiVy3ihud4P1lzrNEda0rGIV+Imi0drX3Qf5Q3i9lOVIQ8e+aMjjJbUlaiF7yQ2oX4JA9ld7I84pAscoymbn1z+424TfXU0JZv/M4bwdno+BgqMyDTDZEnbBnyJ3dXpngxU8OOjEGdSCaL8IITINxAkMALK7MzpfX4c8+79kAqA1QyBm10PpuBZ5Bt3x8EIeAiShxTs1u5KAwrLvbX8QIfk0g==
Received: from DS7PR03CA0243.namprd03.prod.outlook.com (2603:10b6:5:3b3::8) by
 MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.17; Wed, 22 Dec 2021 04:36:12 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::28) by DS7PR03CA0243.outlook.office365.com
 (2603:10b6:5:3b3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20 via Frontend
 Transport; Wed, 22 Dec 2021 04:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 04:36:11 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Dec
 2021 04:36:11 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Dec
 2021 04:36:10 +0000
Received: from audio.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 22 Dec 2021 04:36:07 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <perex@perex.cz>
CC:     <jonathanh@nvidia.com>, <digetx@gmail.com>, <mkumard@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 3/3] arm64: tegra: Remove non existent Tegra194 reset
Date:   Wed, 22 Dec 2021 10:05:51 +0530
Message-ID: <1640147751-4777-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640147751-4777-1-git-send-email-spujar@nvidia.com>
References: <1640147751-4777-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57b9d6c9-c85a-43e3-11b3-08d9c50494f3
X-MS-TrafficTypeDiagnostic: MW3PR12MB4364:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4364F482D51B69FAC3021DB2A77D9@MW3PR12MB4364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6FzhnJLRtTW8gQ/fs5AiQgaJqNMge8M8eOZHmdwObQ5wttj+Kyzvt3teAfQ2B98SVcezl2OQ9/eGRy38Z5B1lVqcBlR3sV05KV+aIzZkkNeZreSJNBegGvswrbNCfFi6kl00G6SUTLggn4F+WJdvGEdQSQag8sjXib4dJ4vTZ6Y/H42OLIETofdH7zbkgrHi6pzeUYAEIsDOq5Iabvx5ODw1DaAkywwSD7zu74TkaTgzlM49/6ECFpMPPL1xN5cIbEs/K0z8WdHhyiHNLKap3yTTIxnXEA7j9lkYWeJqrlnULyRl4O4K6JNiM1vXbWuD7ixzWQ8t4MrkleHAzUuG3/XUpdbicw2UQGG/P7U+uQ+8wz0GFTVb6fF4RTprgJ6Sa3GpeoyELibveZB8OeYmuY0U96j9Ya3nIwTpou0hqx5QN7zPrCOjVXPrNLnFMO8fjEXOqs9+3hL8rGAhwK5qar8nIBp6sFvXoNjdsBGcp7FBb7lmNPxg4YQTEiEXN5zLly7YI3JMhwgr0s/o28sMn/cizGrYXN/b5nt0DyJrgjOrqtZJIfFHZXKNBmcSQkREv8/dSK3GNRKD2URqHbucHKoM8gIvl/w+ZPnQCG8IQkmvNvXZMZ1uedSNB0EKNBPJ3uJwSTCXtIFb6BkG8/dqk863IRRi6YZSlte6GNm4+Vf+JbTfnBMCm4zRxtunfsSvX4HDr8+eHISUGA5SU0+4GB2ZbEULe3tvkbLkzyeFZVFjIksVGn7Ejdkq0mijw7CDx/PtHi7YKpz3sU92TOJ2P14xnsuyyp2D5IlCfiKj2TwSKlBwQ8oY7cj5++nNe7gfb6wSrpAgjD/jmTmSpkbrw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(336012)(6666004)(5660300002)(47076005)(356005)(36756003)(8676002)(107886003)(34020700004)(82310400004)(7696005)(81166007)(4326008)(7416002)(83380400001)(36860700001)(316002)(186003)(86362001)(110136005)(508600001)(40460700001)(8936002)(70206006)(70586007)(426003)(54906003)(2616005)(2906002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 04:36:11.7884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b9d6c9-c85a-43e3-11b3-08d9c50494f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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

