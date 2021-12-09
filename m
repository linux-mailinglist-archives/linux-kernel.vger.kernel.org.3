Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D497446F196
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbhLIR0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:26:14 -0500
Received: from mail-sn1anam02on2083.outbound.protection.outlook.com ([40.107.96.83]:6485
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242783AbhLIR0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:26:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4ne2HYRI3jgF7FGXkJ/k4Y2j8EA38qPO+dc5fT2T60br3FCO1DHSeGJ5+eHZBG3wz/A5IINGmn3SpVGiLRopVy+5pxNp8szkAdmnSwDbeZaWVIOZzjYQXBRox1P5RkOcoH7vd9jMHmq6yL+s5JBkbWfYA7L85UfYCQqv/ZpGWP7/dW6gDMQuMyggGZ/Xve12GB9N/FfEzDutS7HemUU6EZZC7GJyCx/Jh5VJd77/HGOHpkj529TSlv6KKzi59vIeZPOgDjRPoahcSPdeSy7R7GeVtJfvM8kXaeCguYk5hXBHtaSKNaldfzhhSMCWHgqPcVgi/HvoO+M9i3Pxk+7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DfxmQDUbvUJ0if1sjrKmZPyqNdIiAHNroWq7NM+qSQ=;
 b=j35c6DQqimIPDNSXQzQ2NS33Y6byH3Lo3v2g7GK534z0iXc57ScyzyOqPXvPtaHme/LgI8CwUwtO90G8vCUzMRVvM0iNfBTEJdSu+hwUgKiPYBJXkcfeqA7VxTSHmrDYSwyrePW8LHAYlK81LSlzh655ED/awIIOkvFurNv4pWaMC0ax1N7tqf28supioUlBmgf9bJDMOQdb89Ay+A5rf930pGoT55Y3rBCQTg4ucpkfZ6NMCcbrMjabErph/inGUNkCM6yqItSK1yyP62uYBtTOQCb84F0jQJeZYyPfnkjokcIv6/uyTQSmxkwd6tDUg0ahOIA5AWDJq0VEeD8MsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DfxmQDUbvUJ0if1sjrKmZPyqNdIiAHNroWq7NM+qSQ=;
 b=fIc1n2c1LS20IYF7IGdazsA5h6coM3RUM1S1sbap2bRa3Kraf/RCcmGBMAEQaL2lLLxph5q3M4C4cAmMtU0Nf2Yy80Cad0f83duBEuzuOD4XaX5xE8vT23ibUUY146JNzSDHtI3FnBzxT9kuQTWvST4qvZ1PBdoYrdbhzFiJfXj8FwhSTbB9Or/FeVjTXXKxAxIEobL88cA1ccJs3sGdbfPI1ZVXiGoEWjTsdg/wZ9obyAxKhgmc893mxEilGE5HVks39xw3ua4rEidvaC6zwW003OyJAUDprL2hFcY8QgHl00VgMXYk8ufl6c43jvVzm/PcLAEgmHX569mPw7I2LQ==
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 17:22:37 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::e6) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:22:37 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:15 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:13 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:10 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch Resend v1 0/8] CBB driver for Tegra194, Tegra234 & Tegra-Grace 
Date:   Thu, 9 Dec 2021 22:51:58 +0530
Message-ID: <20211209172206.17778-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4c5f09f-f8e5-46ab-95ea-08d9bb387f53
X-MS-TrafficTypeDiagnostic: DM6PR12MB4896:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48961ED0A3DDFBED60C496ADB9709@DM6PR12MB4896.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMBNKHpkfVRHZAGxxrBq+ltqMROEkt8gyEw/vAh70vlRSyDcE+KrQ28fIdzomNFCaz4wpwdfnvbya0l16X4d+IagaJwxh1BPXjEiHlNyQqfYxp1jFggqoe0k00YR1YfR38wBRarkZd9O1pRQORzEUl/DRgS0MRTEDaF5EGi3GCZtIk5EVvOX3vtDCbQvRL3TFiGPkpW3X23qKfSNB2IXnRMiiCXHFk1gnCIgbjXHhGu4UUVm1NBuS2KATaNLNV5rFftuo/Xt6er6y9hJzu14NDhzpeLFtkMdKGn88fql1LWCjyRBpUwqUaDfQvITruP6WJW87CNmjL1tdVRB3/pzKl3c9AlmH0S+elivLIahOQtXNBhN7iYcEsaljeohrgjle5hh2vJDuXoBrutGkz3+HVujc5miPjQjPFNmwZSH8aLFMTXX0riyQwSxD/M3tGqcvxSaQhbcuejDldV9OOt3ona2vCdpDTaycVW+gz04RjDeWZfo1w7HhYveRa9MdTvxhI7ZSZ/eocmJ72W51yTyRNfUoz8ld490HGeb+uDYV8H1//hvvHLybW6CRILf0JwQa7f9vPJWFd4Enwk95XZBpBQOsK0RZXVBhVx9JpGOhHf5cJilfPHavTwpeWpftPG3V39StnzCweIBFVwRqBF9ZM7lPKDsa3VyK8Ot+ZLPvLtfCydkmAnLG97+LZ/MhCph1O/h7S+n5X76RAZbBvAmTovfDS/IeSiZ0eWQyt2zFUi48K/uCdDey0uDAvRWPNKYz+iQ/taa88QmLkzZwErdgulEV5yK3hLkCHCSy6gUDHA=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(5660300002)(36756003)(426003)(70206006)(82310400004)(4326008)(7696005)(508600001)(83380400001)(86362001)(1076003)(107886003)(26005)(47076005)(8936002)(34020700004)(2906002)(186003)(36860700001)(316002)(356005)(2616005)(4743002)(6666004)(7636003)(110136005)(8676002)(336012)(70586007)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:22:37.4945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c5f09f-f8e5-46ab-95ea-08d9bb387f53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series adds Control BackBone(CBB) error handling
driver for Tegra194, Tegra234 and Tegra-Grace SOC's.
Tegra194 is using CBB version 1.0. Tegra234 and Tegra-Grace
are using CBB version 2.0. Both CBB1.0 and CBB2.0 have
different internal architecture. So, separate drivers are
required.
Tegra194 and Tegra234 are using Device Tree. Tegra-Grace is
using ACPI.

Sumit Gupta (8):
  soc: tegra: set ERD bit to mask inband errors
  dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
  arm64: tegra: Add node for CBB1.0 in Tegra194 SOC
  soc: tegra: cbb: Add CBB1.0 driver for Tegra194
  dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
  arm64: tegra: Add node for CBB2.0 in Tegra234 SOC
  soc: tegra: cbb: Add driver for Tegra234 CBB2.0
  soc: tegra: cbb: Add support for tegra-grace SOC

 .../arm/tegra/nvidia,tegra194-cbb.yaml        |  121 +
 .../arm/tegra/nvidia,tegra234-cbb.yaml        |   80 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |   62 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |   49 +
 drivers/soc/tegra/Kconfig                     |    9 +
 drivers/soc/tegra/Makefile                    |    1 +
 drivers/soc/tegra/cbb/Makefile                |    9 +
 drivers/soc/tegra/cbb/tegra-cbb.c             |  199 ++
 drivers/soc/tegra/cbb/tegra194-cbb.c          | 2266 +++++++++++++++++
 drivers/soc/tegra/cbb/tegra234-cbb.c          |  822 ++++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   29 +-
 include/soc/tegra/fuse.h                      |    6 +
 include/soc/tegra/tegra-cbb.h                 |   43 +
 include/soc/tegra/tegra-grace-cbb.h           |  219 ++
 include/soc/tegra/tegra194-cbb.h              |  158 ++
 include/soc/tegra/tegra234-cbb.h              |  340 +++
 16 files changed, 4410 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
 create mode 100644 drivers/soc/tegra/cbb/Makefile
 create mode 100644 drivers/soc/tegra/cbb/tegra-cbb.c
 create mode 100644 drivers/soc/tegra/cbb/tegra194-cbb.c
 create mode 100644 drivers/soc/tegra/cbb/tegra234-cbb.c
 create mode 100644 include/soc/tegra/tegra-cbb.h
 create mode 100644 include/soc/tegra/tegra-grace-cbb.h
 create mode 100644 include/soc/tegra/tegra194-cbb.h
 create mode 100644 include/soc/tegra/tegra234-cbb.h

-- 
2.17.1

