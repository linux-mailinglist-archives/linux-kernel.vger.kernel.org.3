Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2B647CC32
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbhLVEgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:36:03 -0500
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:1233
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238993AbhLVEgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:36:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP1v5hFBzGv7/NiiFfwJBNJRgG0x09MfmZXwgHkBFgRJ6Ps3Df76MgnQVYz2vvi2lAVtmMVpGboqMTRl9yLyv/r8oZWvV7Wo6eSr3qCyK316Fdtuml5226yBd/6QH0RA8Q5GIllHktAKbl2//4ulTDorNFPcWNFWXO2MMlehzc/d4nzl0vytLg6lrRYWvofFvIUbfLbg/h5mavNPsbEfQy7jHKL1iVhEzvvFSc88srDLRlioxTHdYovx6GJ+pnf4sdfNMGIYyG4Ur/8XL9mHZtdPpRWd9NNHrFQ8cBl+KCLXhLIZXKG2bxRtryxhERmbfBuRQ5AXXHMqctDSHgYe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJfUthxHYtpc37hGwUQVxfGmK95bT8NPHrzh4qViFf0=;
 b=JyeCdB8UIfqzJi2M7CAbQHV5pRl4zO6VhhmGmesy3br5V0khtao7+osSKiHHzBxovIPuRAnFXXL279e2CoRjnGL15LCbaNGgdQsZ+5c2JqBcIqk4Ua2BR7Eo4kCmPcY/ylbu5ydh8niU21b0G1HxWSs8ghYNCDRX7Ryhosk44f55Lzadzd7mxrafSn7oFoKZ7G3jLZ9+G//0g4hcV+vjsMaeXLMq9vDRg8YET6livWyXfwH4wclWyaonU/9G3B7110GfI1jrvJ0AcJD0MVZ/jeRvFwJQ6/fq82DEl5wTERQbrQq9hOaqsGyuQP7gcOl6WuLfN1GDrWLwq6Rj2Jpi9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=suse.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJfUthxHYtpc37hGwUQVxfGmK95bT8NPHrzh4qViFf0=;
 b=CsuI7Eq32ntVBxK0cTvD+d8XJ4EqUImI65k0/zytztO70cLyZAzFdYAAbFpmgGJqsokTMAy84+LKW2TsdVZ7lTaIPXThK/Wp/iTNrXNFhqk8Zo2eEBK0QjTx6smziB0/mE34ijQfKFjPgrnIMmjzUy74xY2hDsedRsxQajmTTvjS+pjpwO5xxx8q/1yAgPYFWITY2y1AKmF/THrJYGqSmpg39K0OXL5hveQGY+sulHYEz3IkIykTHE0n2SH2I8mWVQ89cOx6/uwfN6eJ66Z1imC05wBejO0KqnwRy0mxO+R0oJaXWZn7zOXJCGx2470NsnQJyKUNAayuD3VCtlKN0Q==
Received: from BN0PR04CA0191.namprd04.prod.outlook.com (2603:10b6:408:e9::16)
 by BN6PR12MB1458.namprd12.prod.outlook.com (2603:10b6:405:d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Wed, 22 Dec
 2021 04:36:00 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::64) by BN0PR04CA0191.outlook.office365.com
 (2603:10b6:408:e9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Wed, 22 Dec 2021 04:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 04:36:00 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Dec
 2021 04:35:59 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Dec
 2021 04:35:58 +0000
Received: from audio.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 22 Dec 2021 04:35:55 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <perex@perex.cz>
CC:     <jonathanh@nvidia.com>, <digetx@gmail.com>, <mkumard@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 0/3] Fix Tegra194 HDA regression
Date:   Wed, 22 Dec 2021 10:05:48 +0530
Message-ID: <1640147751-4777-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32e70685-5559-4cec-52dc-08d9c5048e56
X-MS-TrafficTypeDiagnostic: BN6PR12MB1458:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14589BDBAB8D56E7382982F4A77D9@BN6PR12MB1458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40C/MOiq634fpOhzFXvWSQBqJSd0QKEgj7hpHSH/q0Tcu4K2GOSJqKjQN5sp/09ZIJldsj2Gka2yiPq7RcbBxcYF9CR+6NunhmY7RYDjA4NMiq2Ljco/QzJJ9xX789FTxjxb0FWcVQCpnWoUjbET5taZDHa64Za95OioYrTVwSkW+2yo2B7Dm4QtoRS8F+jkrbJKzLV1lZuyQvEbvqFLro8aa9bftfP74uY4B4mAc4R1PX5hclQUCRgfit2a10QJMR62uAjmJczh9WTxPErPAjEG/+G8ncgRKlPtZwH3AHgLT+wfrjqrIZnMzO93mVzfXH7hPF9fM0HyyatEuS/DSTrMalNk419IsGzLjScKGeDdAwPemMNAuMKKMfgghw/cXBFhzJNqxn3tRR9Nb8VDFU8fZncTYc6eTTQHOlO3BRloCUYcJHEFYRi2tyTzrQCBZW85303ok44AKNluOAYkzXntn0s7cfdM/Fiio3+szJpBqVE9lSq/qhOUvxf+bnbzRc1++bK5uq1cKBksVJ3VMlHZI47eWY73s6ZPYR+CF5yGWBwmz//n024mp2vTuTaCs+LDDofqVMFQx8cKwZqrE+rkZe+r9EyMLIgP2/ODiDgzB0Q+2IpGVAtLAOYqRhB6+9O+e/zL3OAyrby2mVQ7O3EOmoLtxge2LXWhx4uJzOv2dD8ZvDVCIBjy59ajNHc48uImSQ+SO3SpN2OlFDHG4TITc0DC+WxnHBGfrXyRZ93X2FJIX9kUMZCc14xd4J0cFrX2nKlcqg2nmF1NrxUpHA6oHpNgSLQ8BYE3m4UX5csNugrdLYs8L3LMxFQBcSGwkQd/uu1Xg/XEInawPL5DEw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(316002)(8676002)(8936002)(110136005)(7696005)(54906003)(336012)(6666004)(7416002)(86362001)(107886003)(34020700004)(426003)(2906002)(36860700001)(4326008)(70206006)(2616005)(186003)(82310400004)(36756003)(26005)(47076005)(70586007)(81166007)(508600001)(5660300002)(83380400001)(4744005)(40460700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 04:36:00.6480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e70685-5559-4cec-52dc-08d9c5048e56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1458
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDA probe failure is observed on Tegra194 based platforms and this
happens due to reset failure. This series fixes the problem by
skipping the failing reset and DT bindings are updated accordingly.


Changelog
=========
 v2 -> v3:
 ---------
   * Use reset bulk APIs in HDA driver as suggested by Dmitry.


 v1 -> v2:
 ---------
   * Updated HDA driver patch to skip the failing reset instead of
     skipping resets in general for BPMP devices as per comment from
     Dmitry.
   * Used a better strucure name for SoC data as per comment from
     Thierry.
   * Dropped 'Fixes' tag in binding doc patch as per comment from
     Dmitry.

Sameer Pujar (3):
  ALSA: hda/tegra: Fix Tegra194 HDA reset failure
  dt-bindings: sound: tegra: Update HDA resets
  arm64: tegra: Remove non existent Tegra194 reset

 .../bindings/sound/nvidia,tegra30-hda.yaml         | 13 +++++--
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  5 +--
 sound/pci/hda/hda_tegra.c                          | 45 +++++++++++++++++-----
 3 files changed, 47 insertions(+), 16 deletions(-)

-- 
2.7.4

