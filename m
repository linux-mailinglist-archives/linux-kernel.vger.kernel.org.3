Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D7A478AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbhLQMHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:07:06 -0500
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:44256
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235845AbhLQMHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:07:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtstodBGZKPxF3iZe6q8iIB54sI0vMXkAqQ8HWfe9Hu5OVp2sJ/s26tiUSxLbjSd6tbciDm4Pbln0aCn0rD70zu4ox7KwOcESYc2YemlRwo2w9IgbcNyn1fkrLiJaWZsjSDuYDdLcF7QKbRGS+w+VI20a8xzv/XTHc8iIDIr+qsysTKR0V0odjMCyaq1N29srElMvddhcz92ImLSIdic5vTYMC+iOFQpD3GA/NeBWsR9OcGS5+Q8CxshA//Lu6zxeThA6N5mFt8gHF0raQpAW5HGytQPetwl5h0nujtzd7Ry/8LNtOTQX5xP4eipFDYczcvsO9JLh6ueSbe9H5a6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7TJUcLaxY+MLHiHl7aei4GSd7k91qooHAN6xLQjbvc=;
 b=i4GP9di05cOG+cIV13YMv0WXQ92NfbvzwmxFItvjjx8XnTulTNJpb35+i1zHkf9ec8lx2IEX9fAJGlXN5pCX2je8taTVUaZmjRbGC2rV4mofO7U2sflr8YNONgGJGtOcBNGTHTHiqVEQV9qEZNUc/duRHzbowLBdhHI7EReo+TfPqf0eoA18jxqfqIaML8It49Fj12VHiPv2SdF2lfhrPTKlQCK2uIfptUT+jCV1+heqY3pmetvM6HwM7FdwE6Bve77z+KxYnNOfeQJAOO/4ywriH/vfPKiDrwKCPsZqtEhahFK+/OLulIbN9cC9MJrK9xZRIBOXQ5kIcvVVO25jCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7TJUcLaxY+MLHiHl7aei4GSd7k91qooHAN6xLQjbvc=;
 b=QykR8HNlC427ltI3xEsi50bgRrmJ58qDyaJ/3MgRJdkxrSS+dhS3ZaaYHlXc5SpWsncoEKYbQgtwzVueCxKWW/vS/kBv9w33HK8wf196eFYkUzOX0EbKfpcma8UjhGTe6IElSJ4jVC+hTyWZsJmIF2m5G0sT85sak99wD500f7xfbIuMBKX17hTgEFjWC8pIdWfVgmmcj0im4JnJ2J/UGTqF71ywDQoCDRzolpSw9kiiUplyjbYw2AssUYxyTSsTvI9hjNRASespLhUkFXGocr0lFsAy18dXeGqoGELhF3eFIpggOJ79RQ6zJcd8VpjBArK859B9Jqs7JwPzQaEMaA==
Received: from DM3PR08CA0013.namprd08.prod.outlook.com (2603:10b6:0:52::23) by
 DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12; Fri, 17 Dec 2021 12:07:02 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::80) by DM3PR08CA0013.outlook.office365.com
 (2603:10b6:0:52::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 12:07:02 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:02 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 04:07:01 -0800
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Dec 2021 12:06:59 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v2 0/9] CBB driver for Tegra194, Tegra234 & Tegra-Grace 
Date:   Fri, 17 Dec 2021 17:36:47 +0530
Message-ID: <20211217120656.16480-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d49c2813-4bc7-4fc4-c81b-08d9c155bc73
X-MS-TrafficTypeDiagnostic: DM6PR12MB3067:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30679DAEDAC94047DBD61364B9789@DM6PR12MB3067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQiN//eQipYXbiAq/GPFKtnQpeFbHRu4BwxBXhoTROfyX2NLsi/P71YsiIOdoxPDwrrcZg7dDkhvTow0HrgMv95IZJ1HQfCaEUk/NK9WR/vWdDcw8G+7JWGKk/V2dSZwU/4Wcju7/FLFW5wtw6cIlaslV93hdylg2Q4uJfvldDQu9jy5ZvB8XYM0gHVrPxBjtUo2pbtB+KQcUuVOUMdb59q83+K9PgRTi1+yPIIpEcKg97jUgWlN0R3GPD6E+RybPjo5nWOwwRWI7LT/pHrwJ7eC7WrajKnIFkj8/ezREuDdK4ZOezzpS0h77NNT+M+sfSlXVwyHaQmdOe7td9AS8Esfspjj1NoSduM39TW/LctvRJDj0Exhaf4oZZ23jT9Qng1nCGINm1kVsfeWah++zOlOyiK5m7JzDeC8cqno+ce+yrVHnR1H1HvVl5uu//2Dj6r4ZjSqb/Upz+tpPMUrS6DTtR7e7FRpm1ylID7Ngai4rdsendmu0Vc0AvOpyWhnS2glPb3l7nTepgOsyiF0dac/zAj47Bbwwjyan8WKvjxN0JiuDqieqlaAzVOXAPR+BfCANCOHNTiU6FdyJkyTgLAsh58fpos+Xk8/gYRu2sola2VLJZ7QkXbDmGaDsq3IyROL/1Zs9XKN8GOm9UUUGrnpY/vJ5e1lGDQ5PjvBY8Qq7uRYqVHCAzcPklCu5gY6hZ1RCq6VUW9u5nLsVlzF3AlSv0i4ZBsge79z6HT9ilg1rCA9142qIDIkF+aEBGU8CaRgC1gFr8suUHiezCh0DawkL/Q+TLdwbxnroEgKIMLYQ5Fm7i8rJMpI0PSP64JW9E7LLekeYYwKx2OG3nbELw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(186003)(4326008)(7696005)(86362001)(2616005)(40460700001)(8936002)(70586007)(6666004)(26005)(426003)(508600001)(110136005)(36756003)(107886003)(70206006)(83380400001)(54906003)(47076005)(81166007)(316002)(4743002)(356005)(34020700004)(8676002)(82310400004)(336012)(2906002)(1076003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:07:02.6433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49c2813-4bc7-4fc4-c81b-08d9c155bc73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3067
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

---
v1 -> v2:
- moved err-notifier-base and off-mask-erd from DT to driver.
- yaml fixes by Thierry.

Sumit Gupta (9):
  soc: tegra: set ERD bit to mask inband errors
  dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
  dt-bindings: arm: tegra: Add NVIDIA Tegra194 axi2apb binding
  arm64: tegra: Add node for CBB1.0 in Tegra194 SOC
  soc: tegra: cbb: Add CBB1.0 driver for Tegra194
  dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
  arm64: tegra: Add node for CBB2.0 in Tegra234 SOC
  soc: tegra: cbb: Add driver for Tegra234 CBB2.0
  soc: tegra: cbb: Add support for tegra-grace SOC

 .../arm/tegra/nvidia,tegra194-axi2apb.yaml    |   40 +
 .../arm/tegra/nvidia,tegra194-cbb.yaml        |   93 +
 .../arm/tegra/nvidia,tegra234-cbb.yaml        |   70 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |   62 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |   42 +
 drivers/soc/tegra/Kconfig                     |    9 +
 drivers/soc/tegra/Makefile                    |    1 +
 drivers/soc/tegra/cbb/Makefile                |    9 +
 drivers/soc/tegra/cbb/tegra-cbb.c             |  199 ++
 drivers/soc/tegra/cbb/tegra194-cbb.c          | 2266 +++++++++++++++++
 drivers/soc/tegra/cbb/tegra234-cbb.c          |  827 ++++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   29 +-
 include/soc/tegra/fuse.h                      |    6 +
 include/soc/tegra/tegra-cbb.h                 |   43 +
 include/soc/tegra/tegra-grace-cbb.h           |  219 ++
 include/soc/tegra/tegra194-cbb.h              |  158 ++
 include/soc/tegra/tegra234-cbb.h              |  342 +++
 17 files changed, 4412 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
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

