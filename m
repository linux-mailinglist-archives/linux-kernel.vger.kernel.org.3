Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572C846B300
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbhLGGkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:40:49 -0500
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:20192
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236879AbhLGGks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:40:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEoVQElFIVF2DX1uz94rOGbJIPsYuB2peNzzED5nltVqdUHslliZ5cpaqtxMg95QJrobUMP2Uaj4nyxvmaVCmkI1U3pnMc6sK9D+rxo1sWf9D9JqS/gc36Zv88RpG4z6iwoQryAbz61/HOQQYgRo4dHGEWK+EkFIPuYFvVTScTpeBpLxali7QVeBtRjytZEUxc550IwBaGLz1of2odVfJG/lt2p8oH1Yq1bgrnXZXuB2gEGKsKJ5T0b+3lk9FPy3l1qvzkv1Ls0mrz7Pf85kpCtNPPb6KX7XoLT1NCdOWJyEeiFNKOQq5O6NOJGGmV27W/ZhFTOs0Ha9jT8q2Z5XsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osSfrQJI04fUMGFOnxxCcw7RfbnjZhGcy1BWiQ8brBo=;
 b=I4Eh0ZTvxf0e6avdP/VpEsK9+7zaENsZabOP3EhC1bk7i4asKWuvdT4JkZBKxqYlVTa509R6O4NA99SsiEWL2Dr/swVaL8BWlJDqK4qgb+Zfxc6d1uVXGDVkajVmtW+dCiZk3joZu5Ly6WqIQWdV4T+fcIccRKzcOVwapsvLWCBS7AMZiu7I8ITCAbypWfdL3bf9F7ttWM5+YNyO8i0xewtwro8QY/Uk2cgNMxZSuKBJjKoFEeoRqadW6TIvEhneK4KgwISIjr6PtLVMBmq28zFe/RKpmuyOEHGrf3YhPFnt8we9Hp+vggXR1uHsWUyB7vn1Qt5Ykul1wLvfl7WB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osSfrQJI04fUMGFOnxxCcw7RfbnjZhGcy1BWiQ8brBo=;
 b=a01BhWnqnRwF2uSvYE2l3pTenXpk+bgiSP1E3TJQ0o+r9ZOna/8Ap97sZBlLGrZ6DZvfK0vHsOqDukYI0xpHtlFpnpH9TgInjtyZmbOUyQhRk8QZJ1Afrq0HfISDDQOiVXwIEfPca9Ukp4EltBmafNe6x/L4d+YSI7+zPnw24jaluiCe3OrVT70NW9HIy0ZcfvL7S3D1LNafoUnh2ET7e2/vfqP2B/84/Ntnov4YOauAwvB1Avjb01klBylsgV0z1HKTC0aD3vmVD6/ho1is7nB1UQLUoG9t95MhbK2gN39wILazqLMA7LY5be7qqUUBe81BnOgnNfybKk1JqGU72g==
Received: from MWHPR18CA0041.namprd18.prod.outlook.com (2603:10b6:320:31::27)
 by BN7PR12MB2659.namprd12.prod.outlook.com (2603:10b6:408:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 06:37:16 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::fa) by MWHPR18CA0041.outlook.office365.com
 (2603:10b6:320:31::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Tue, 7 Dec 2021 06:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 06:37:14 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 7 Dec
 2021 06:37:13 +0000
Received: from audio.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 6 Dec 2021 22:37:10 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <perex@perex.cz>
CC:     <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/3] Fix Tegra194 HDA regression
Date:   Tue, 7 Dec 2021 12:02:47 +0530
Message-ID: <1638858770-22594-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a74f1e8-f225-45e9-a8a0-08d9b94c019d
X-MS-TrafficTypeDiagnostic: BN7PR12MB2659:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2659726EFB2BB31B6231BCE0A76E9@BN7PR12MB2659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MHD9H5G+F1N45XEIa09atTeJ1Pu02ESHKKLZisdj/vFSbpmuGSBTANol17qHkyPWQq5C2JsuA1LHABmxHXlQyOyus2ob4i1CCkibiXsrkrFRlQ/+E6lNrkTAhAv2iBRvjVerdGDutmXl9GWn5u0WphmEeKbmQcBQfmHStC+5u6yQyrwNsFptaIpHWylVBEpe8s/7cVfpXFtkt8eGh4jlnVfB3V/J4oz3Di8JsLQiFMIh9aakPefnnXtep8rpGowm5+8VDgtiNK7tAven5uoythjI+VULJ4LqtJxhAY9TgM7XdwgrtjWzUJZfB3qQvr03YHi2Jed6RyGBBcxYbIapmVy0Kigrt8HGOr+oSmxxUPfy/UrmtdedYQKDEIPeRb3wZShVZEz66mLLI54PUHCgMWmA4ED4FK5jqAeJbsfQqIg8ToNf02iSZxFWhy3pI/kmq9bQQYnf59+0iUBuqYl0zG1gN/W0WfgiDaMw2GZhOFKofVUMCqiHhQdQnQhoVOi7y2Yt0K3tf1VwEPXlmw2kiKbU4+FUFzKswbHQwupy6vs4hTrEIgvIxAv6Yw9d8DpbBVxTaOj3yqs0TkLh73MSq8/oO1MCVBNfgcbWPhRziUUR0930ypyW6KmVkqBiNhha3/s8jxSuYdk4EN9l4tRwvbXhtaEFQbHmQD1d6YPdxlU0oDa2EjkhYzY/7A/9L3BGTVNCqvKD2ncD3IJ6KUBhsraUEseuguDNiamALiv1REInWCkALLrDbZtvKW0Lefo0whbvm5P/boyJ+8NyEqWBXiMPUwvne8D5k0F4SaxR9k=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(7416002)(508600001)(83380400001)(70586007)(2906002)(186003)(107886003)(8676002)(70206006)(6666004)(82310400004)(36756003)(7696005)(36860700001)(26005)(110136005)(426003)(5660300002)(54906003)(356005)(34070700002)(4744005)(47076005)(2616005)(7636003)(4326008)(86362001)(40460700001)(336012)(316002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 06:37:14.4350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a74f1e8-f225-45e9-a8a0-08d9b94c019d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2659
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDA probe failure is observed on Tegra194 based platforms and this
happens due to a reset failure. The series fixes this problem by
avoiding explicit resets on BPMP based devices.

Sameer Pujar (3):
  ALSA: hda/tegra: Skip reset on BPMP devices
  dt-bindings: sound: tegra: Update HDA resets
  arm64: tegra: Remove non existent Tegra194 reset

 .../bindings/sound/nvidia,tegra30-hda.yaml         | 13 ++++++++----
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  5 ++---
 sound/pci/hda/hda_tegra.c                          | 24 +++++++++++++++++-----
 3 files changed, 30 insertions(+), 12 deletions(-)

-- 
2.7.4

