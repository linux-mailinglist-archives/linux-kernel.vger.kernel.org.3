Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B5649F98B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348533AbiA1MiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:38:09 -0500
Received: from mail-bn1nam07on2062.outbound.protection.outlook.com ([40.107.212.62]:23009
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234635AbiA1MiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:38:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f08qqXPeMiA5h1UPj5lsgHlvvjnXAjE4vJrnhxTIOqwHkKY6/5wSvM4iRgcfA4r+IkaVnN6H5KjIrwH9qukVD/RAZDVr3fJL6VleCnLlVhwFRkPsCXMr/R//LOufniyCbUSVUeYEejwzQH1CF+dYNBP4lF35tg0CsFdREpoBn44HfwWBrtY0GxvJzovDWORmeWiv4QtJE3csnXZfTveKm5XvFjOLeN36D3Em9errHHFfw5jBtmAwsZsWuTOiaZzHHmLVyLOheJ3BWBluXOYYHkmuoh7eelJ+XmGqART9jNbGl/QNzQUSBQ7IdEIQxHZHpK4ovXzSAuKtP4WNWF8gXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aepb0TkuLT3v0kXrbj1Sj0+gUWnU6wUhuPcdOEYiBII=;
 b=AMY7+vz7jwJAbQYgtq8l+ZJ7FNx7n9WQOCu4AxRc6G21tIG7y5AdEcIehkPsYdH15LeJ0sESfc94yaRmdDI4XY/kVvA5xqejUgn/xknwlAi7Xr73Pn/UZ+eZ2SS5xzjPrtMjEe9QiPy0RhsOCZtRvjFdVcggBsvhGPTOR0l7znHxPnDBijBOsBznqyTc3eUjz64GCOH+S5OchB5ifGiK5CzDPnVA57DVcmuUX3M2rZuk9RAO7eLWNVgG7s4/RMLiQHHwPYkYUSBjWEDQ5ECCZ/p0Atnbc0AAxg0mNYnurlTPqDx0zrr6svD3FujPaEs8THOJ2k/Hkle3RlbjwpiQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aepb0TkuLT3v0kXrbj1Sj0+gUWnU6wUhuPcdOEYiBII=;
 b=t3RNbvkwJUNg32ZU8DP8hPbl0rjIc7R31FsigcaK1eS74wHxviFJ79v4t6vhDsHNw7JqZxOtv/YG8a4fNf6uWX2JhiqHt6cAIMCP7FdVXGPSBs6JoGHRdNAgzcA15ff5kKGfQg9icria1lwJUZnhpXUYNkbFKBeNeSFvd9BXxdG+weU4RYbDtAVoyS5yVbVjVSJl6tAbY9qjvyuH0BWDt67I/5/XYOZsoPmmaqPz/gKJMrvBGoO1NHQ6hXg9Irv4qIjA8fmeg7vX8yJeaKDFIhqsQ80IaKC+gmheMJy2R4+7xe8YH+DTEdgPs3kDoudzRtXsk4oytKeUIwHR9CTgBw==
Received: from BN9PR03CA0567.namprd03.prod.outlook.com (2603:10b6:408:138::32)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 12:38:06 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::13) by BN9PR03CA0567.outlook.office365.com
 (2603:10b6:408:138::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 12:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 12:38:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Fri, 28 Jan 2022 12:38:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Fri, 28 Jan 2022 04:38:05 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 28 Jan 2022 04:38:02 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 0/5] Tegra234 APE support
Date:   Fri, 28 Jan 2022 18:07:51 +0530
Message-ID: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae2f04ff-9eba-4125-ae0d-08d9e25b08d8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5176DDA2A387B43BDAE9733FA7229@BL1PR12MB5176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sMm3E/vzMlE2rSAgcri04yyuUls/6E1UaxpoS1Ib5TxxmhQtu+HH3ptQ2r9fof4Bzn+sQygnGRvNPjAp4M8OKmwOcjiamQYHP+jHUaihoOVkqaHEhj8v9INeFBh5t8TCZfg9ne/S2RKMIT8tafjYenlkg4AnEzCFzNNSmdDXGzu72y3maFI/aNYXlMWcgNUOiKeEO5+S7s/8voqaAL3ZtxMWEdcNy6wV3b29RN4NKwVGCjkiWAu9Wkh97gN6TkbfSmU+pNg0JYBdYTBZk1i56H4+n9qfFnGaPhFyS1tqa2iueK7WdsAf98qc6AgMnvlxyKfy+Un2Vde9/rdLlhQY7Ajj4Y/QjqqPiHmZhXTH2EdQwOPiEO/6xIpFss8pVIgK4VBmNanCtDscpMItHi0yjNPmVQiVe1LrddSoJaIEyjidmk3TQtXQy8XF+eeJkcvJEa9TLUcHjj/MdzTik3NQoIHqry1fy+PNaown/oRvRzb0wgS9Bgi7P3LiQlEvcmztwMNzxuioD1f9FRbK+fcUeijlVB4rkMqbLZ98EG0A3V4wtb151joKaIeaXQeArsEmzS9w7CTaj0gRvqUrPKUdfcOSPsutCZl9GZ79zRLZ4Rmn8Rj+HyBKhIVs3mtWcWtkG/6oiBI3Rt9UFfvcsJSL0FPYczwr54P1CIWOvvpskTUsAvsxZveQN2ZCJXDLWsrYGJn2GtR1qiJaDRwUZN25A==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7416002)(6666004)(81166007)(70586007)(70206006)(54906003)(36860700001)(508600001)(83380400001)(82310400004)(356005)(4326008)(8936002)(8676002)(86362001)(5660300002)(7696005)(110136005)(186003)(26005)(47076005)(2906002)(36756003)(316002)(40460700003)(2616005)(426003)(107886003)(336012)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 12:38:06.6236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2f04ff-9eba-4125-ae0d-08d9e25b08d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds APE support on Tegra234 and enables sound card on
Jetson AGX Orin platform.


Changelog
=========
 v2->v3
 ------
   * Fixed DT build error related to power-domain and
     iommu reference.

     Reported-by: kernel test robot <lkp@intel.com>

 v1->v2
 ------
   * Rebased patches on latest linux-next

Mohan Kumar (1):
  ASoC: tegra: Update AHUB driver for Tegra234

Sameer Pujar (4):
  dt-bindings: Add Tegra234 APE support
  dt-bindings: Document Tegra234 APE support
  arm64: tegra: Add audio devices on Tegra234
  arm64: tegra: APE sound card for Jetson AGX Orin

 .../bindings/bus/nvidia,tegra210-aconnect.yaml     |    1 +
 .../bindings/dma/nvidia,tegra210-adma.yaml         |    4 +-
 .../bindings/interrupt-controller/arm,gic.yaml     |    1 +
 .../bindings/sound/nvidia,tegra186-dspk.yaml       |    4 +-
 .../bindings/sound/nvidia,tegra210-admaif.yaml     |    4 +-
 .../bindings/sound/nvidia,tegra210-adx.yaml        |    1 +
 .../bindings/sound/nvidia,tegra210-ahub.yaml       |    1 +
 .../bindings/sound/nvidia,tegra210-amx.yaml        |    3 +
 .../bindings/sound/nvidia,tegra210-dmic.yaml       |    1 +
 .../bindings/sound/nvidia,tegra210-i2s.yaml        |    1 +
 .../bindings/sound/nvidia,tegra210-mixer.yaml      |    1 +
 .../bindings/sound/nvidia,tegra210-mvc.yaml        |    1 +
 .../bindings/sound/nvidia,tegra210-sfc.yaml        |    1 +
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  | 1783 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |  432 +++++
 include/dt-bindings/clock/tegra234-clock.h         |   74 +-
 include/dt-bindings/memory/tegra234-mc.h           |    7 +
 include/dt-bindings/power/tegra234-powergate.h     |    9 +
 sound/soc/tegra/tegra210_ahub.c                    |  146 +-
 sound/soc/tegra/tegra210_ahub.h                    |    4 +-
 20 files changed, 2473 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra234-powergate.h

-- 
2.7.4

