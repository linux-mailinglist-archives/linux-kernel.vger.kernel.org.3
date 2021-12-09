Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B246F087
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbhLIRJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:09:20 -0500
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:47812
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232691AbhLIRJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:09:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpelurtKZt2iaybKxLE8MzIZp1FKlL8HlWrrkaFeinsxxfRt6SptaW+ZYF+r5fn5hIzt0YeK423yb12gatZ5uHxWzgLWDLi4Bunw/mbc4lmWrW0kVblk2I+4bFb6n1LxXqhU2gjzSMSa2eQkArXPt8lFhErYVhRRKcd/9t4st0VkRIH4IK5m9fueSp03q6GcXOZR3da9vcrTH9Oi9LNrqNJjnqhY4Tauig+NpHig9fjJsdwxWMCCj9xOIuzb1OfXEq4AQcIJPwOwCB4KRQEPjUh/+FG2pp8+H7l1V13mocH85cIr8135gnmMr4LVmZjJQ4npO05s+Ee6vBYjAEUO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DfxmQDUbvUJ0if1sjrKmZPyqNdIiAHNroWq7NM+qSQ=;
 b=IWn7TxOqO69c0q8lugD0aKWYRp3EQ36/RRXR3QbMDQxeLQGcm9N1Tsw7fO0NkYuTZvxi/govIWkERAebNQ1aZwD1lkDSfw/+0MRr7J1jdu939u8vGpc5bhJFtEKL2guPnKoU23HNm47/lE12qfi5pum7YQgC+l7y3WoICtYNzFYFHKG4S0FQXXj/0PjavudNl3eIqhp+vyea/ibMvWPk27CJqU5yGRXfz7VO7xy3bInSJdpe6WmQJ7NSu/tVmBfCo+6mTXvqTPjPX2ing5h6oONuAZxtSLrrLGy3EibRQymnS9maObtPccpNYMUKmVWSBmcuBz/0s8hl5I+Irc8JnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DfxmQDUbvUJ0if1sjrKmZPyqNdIiAHNroWq7NM+qSQ=;
 b=aUajhKvHnRtpv4WrUJT/mXmx+uEWm06if4IzHpzQHVbDf9JitHuayYmCCZc8c88vpt3ToE9D0QMTvsMoGfZdL7KqprlUo03eSwjOjaAbRmMGVg+OGmR0KRmUHT63Qnp1wchXl3o7xWoJFpriOm0iBGsLogsfAxkV9VCROqKvg0ZrLuCUBOfv4w5v6hSDGzJkoLxKxuNz/BrF6MPjCXuipTkw53TZstedHBDl14hKY+vSL/rgZrA6n+0OH1PuE5sR4Gc/7Im8PVO016Sp/C32n0x8Ey7+bZrPhqaShGN6uHr1Zdtlqd0s96vQvQa9P3AkgNIZy8FoFgt3odIfHsHchw==
Received: from MWHPR19CA0070.namprd19.prod.outlook.com (2603:10b6:300:94::32)
 by DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 17:05:35 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::4f) by MWHPR19CA0070.outlook.office365.com
 (2603:10b6:300:94::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Thu, 9 Dec 2021 17:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:05:34 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:05:34 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:05:31 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:05:29 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v1 0/8] CBB driver for Tegra194, Tegra234 & Tegra-Grace 
Date:   Thu, 9 Dec 2021 22:35:25 +0530
Message-ID: <20211209170525.17094-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5dc46cc-ad77-418f-81dd-08d9bb361dbf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3529:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35298ED4D9053E5241D39BB1B9709@DM6PR12MB3529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RR+CBRjXZ9bNmUKzW09t2omzmt8PSRSTMBKQEffS+a2yMCW8UQWhYLFv+Tn3Kw+I05RfC6iVfWErz0orJoW2q7wjnAtpqWWWUJ32/toY+4i5nPOA/geLFAYsSMwrPyGepgurpDDnCMfEq6931x6fVgNa23rnzezXScTVOndRelcKXMBi1A0xcgv9oWWFxjX3PLqCawKlrqXwb64SCp+AVcVtLU34ylItjkb6kIncIvlGYsvOH6kqPT11bbEuxZkD6lBhG1vBAD+oBbPTbOyDEABHR9anVo5fH5bbfF8myXFJkEx4ZLiAtwvKYZPioFSZhoJBIYUVcaf7t5gNJegLbfxAePp8/kh+uvhC1Y3w89ulzKqOS9ilSK5GNvxuUbBBiVWlGFKEdpMshGxXFlB+upuFQ6F4dDBV8R2N1RPv7f6x1ZLQAyX3VRSE+NlChuWr+nWg5lH+R2qhh8SZKHPWnmsvfCqD8vwtZ5leaZMVEGx1b7DjEwXPTPjZYMLHZgUTWUjipXKoQJGZCqwUiIvaJISybA7v5Jlf1dtGXhKGMZEUsteLFVUv3Ra2BcYp7FqCWg4gmfsiTOn867jED4s8pRbw1f2c1v7IOWENq/l4/j5ekMxhmOG+sjEZMQ/0q6zFrWlz6FMnhrYEd8oIeYfucfBcCnpLDSbyf+00wM/E3vu6/LJIQnbGDpqNIflVV+pSE5GJB0q8GPKuxIqjp89t0sSJ58ibMKEfScBM1qedcF4WcEb94MYytG839odNd4rImk4+OiBsVXuxVLrSpCcl0KABqGileI5T2JiHcurBoPo=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(2616005)(316002)(110136005)(54906003)(4326008)(5660300002)(47076005)(107886003)(8936002)(336012)(1076003)(2906002)(426003)(6666004)(36860700001)(26005)(8676002)(34020700004)(70206006)(70586007)(508600001)(4743002)(82310400004)(36756003)(186003)(83380400001)(7696005)(40460700001)(356005)(86362001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:05:34.7916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dc46cc-ad77-418f-81dd-08d9bb361dbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3529
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

