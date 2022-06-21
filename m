Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2A552A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 07:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345294AbiFUFu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 01:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFUFux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 01:50:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF5220CE;
        Mon, 20 Jun 2022 22:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5YbqI3I9W8psc4U6pQJSalRFlb9lueaj3d9cAiF0upR8oqYezElZeuOCdtowW4XugnCAeGbrphpuXBv7mJ6LQDFdlig5GvdKUTUeInn6PP0oc98ElFZgUlzXMJOH01oMyYKVhU7IR2ImGo6FPqd35a1yXBpJ9KxVXhfE+c61IX73NSQPeEpuHA2pFmorUhaNHqpmQwJZAU7kQnHDGwfu/kBqKeAecIkz3UCqx8DxW94E7taginYtQ6qKT3ZWBAEcqAPZomVRVVW/Gk1tT9sQ9RDNPArt401UpqeepUqHnX1kTRKyRhAo7QCUOXdhGzpPnx3ygIz4KXbYZVEOrR11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZd6jvUF8k3L97pttxib7ixtDkIzq4yinxGG3XuWd1Y=;
 b=OfhsaOyippEe4fqswoQMZ7KlJsMyiivKQsivpRrKTvOAVcVTEeOX5LwHpqvNBtH3Cujm8LOgsoAs40VRsgKjH9fOu34nRvAglPFF2lkQJcZDPvny+GXAPOqi3DelyFU3M7RSNhaf8CYKs3FyChHdNg9D71H/7feiiMYyxkCyg5yxtDJ4Qi/OZE0gH+UZcanpFQOrrLKmdmoK55SOdj5n4PxbYDlLaMLrmUyxDCHay/lojTwf8KY7J8iiwvCl5Yy22zVZc0DsyKFWJEUFd6iv5OesMN5bk/LveHcXtH7UWzT9bgQrVwCFQTB9jHLis8wQ0GoyXUfKltI2S3S/jdUFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZd6jvUF8k3L97pttxib7ixtDkIzq4yinxGG3XuWd1Y=;
 b=tKB9S/gULPsxlYnaOfU3YDRKstO441RxvCWCkwz/I8y04YZoa98zat2RtCaqXn7ugDi0t1d2b2ZrRaQ4HhGXQMYlbJpKV2quigBdryzaAm/I5xOZhiy0Ggyt5wSbSN8VQeqlqRneW2uQ5SgtAJoVPXOCGaLOAm2E3LuPsakaylbF02sJMEb62GqvpNycwvlWCITXhPFCPf7qAKV52i+hPFIZ/AjHnfw1ow5hozkcqkzNw0iPT92dxKlZUTabmnDNZ3HWlqxioDY2UyFmKZbhr+8pWSydk7lKxqV1zekH8ZIoZBmuHzdAx6eKaAvHH/dh8xu8pQUpqYl0OQEkhAotzQ==
Received: from BN6PR1101CA0009.namprd11.prod.outlook.com
 (2603:10b6:405:4a::19) by BY5PR12MB3731.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 05:50:49 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::85) by BN6PR1101CA0009.outlook.office365.com
 (2603:10b6:405:4a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Tue, 21 Jun 2022 05:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 05:50:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 21 Jun
 2022 05:50:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 22:50:47 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 20 Jun 2022 22:50:46 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [RESEND PATCH v3 0/2] perf: ARM CoreSight PMU support
Date:   Tue, 21 Jun 2022 00:50:33 -0500
Message-ID: <20220621055035.31766-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed4e95fe-a9b7-49ef-55e0-08da5349fe32
X-MS-TrafficTypeDiagnostic: BY5PR12MB3731:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37318F5EF8F4336E3DF6C654A0B39@BY5PR12MB3731.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtTYgvVG5UfSNZK4JDdJecR+KKI0FQuvzIYv9FqyZ7mr7tIlAgswyEk22+iimcA0IdB/+2ogv5FcOCzsmgliXJ3oebIerlLMnTi+iSKLz8Bobjer1fp4aemYqwY/p4Lpu3lDdgAcmqsWJUCqKF2biU3kBDK7upfavheFi/ltMG4G3AKzBcMXv8qxBK0bdMLcC/7cjYoQHW/3Ll8oyvEAn1NJGJTztqUVTP0234YuZ4LwljMzKJcPcdvl4sDgUYSXn2umO12j52HnTB7V0WhEs7+0iUFEnKmGbY0grsmTrTP4+iBtb0Ssl80sYJ+xknfzKmV4oaK9fwPoPW8zFj3t+0aLt8CGnrfWgUS3u/kg/yRthyo/JpFA5wAQm6fTU6Ww2OeiJeR47C1ULX/5FgoiRHuDK7hQs9FoR9+xgE0E1NG5Db4WP16zqKCVTsLb6AEbO8yoAaFNkZm/b8MUXzL6ko4dZ5mgzXgkShWeNrFa+nirNp5Fe2fYGRotMJMrb7ovudTKINW/JSyXocdopq24OIVqsiiT1QYdx9SUkAGXH+0oDzPZMTwNX7pRmhHhj94xq1itc6cxE55UtYdTyHx9hy5/414kiVIbTxB6WpSC1orGnq/vNxgDF258urJ78w7tec+9bYH2qr9s1gwmcDU6Vg4IO5L2o7wBZNL5tG1Oz8Cw2dlpbHyzDpoAUTbnLJCvMS8y4p2u4BxJ0N632dKiichXsGFSRn+E7o6tLu2Zb7HyWKSlC33r35GRIJSlMJJPbUwgMoEizC+FuAKJyAhZOLK/RdBdl2sU5lwAC5JzwkjzQ4z+wZIZQMIAtKw0MRWaJkR+PCTpLZOs0eLr6bKgjnNrFwdc3aiG77ew+AH5LiZVaiUuBVjijC0yXSlqPxL7
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(40470700004)(36840700001)(8936002)(70586007)(8676002)(5660300002)(478600001)(966005)(110136005)(70206006)(4326008)(36860700001)(316002)(54906003)(36756003)(40480700001)(7416002)(82310400005)(6666004)(47076005)(356005)(7696005)(86362001)(82740400003)(186003)(336012)(81166007)(83380400001)(1076003)(26005)(2906002)(426003)(2616005)(107886003)(41300700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 05:50:48.7057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4e95fe-a9b7-49ef-55e0-08da5349fe32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3731
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver support for ARM CoreSight PMU device and event attributes for NVIDIA
implementation. The code is based on ARM Coresight PMU architecture and ACPI ARM
Performance Monitoring Unit table (APMT) specification below:
 * ARM Coresight PMU:
        https://developer.arm.com/documentation/ihi0091/latest
 * APMT: https://developer.arm.com/documentation/den0117/latest

Notes:
 * There is a concern on the naming of the PMU device.
   Currently the driver is probing "arm-coresight-pmu" device, however the APMT
   spec supports different kinds of CoreSight PMU based implementation. So it is
   open for discussion if the name can stay or a "generic" name is required.
   Please see the following thread:
   http://lists.infradead.org/pipermail/linux-arm-kernel/2022-May/740485.html

The patchset applies on top of
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  master next-20220524

Changes from v2:
 * Driver is now probing "arm-system-pmu" device.
 * Change default PMU naming to "arm_<APMT node type>_pmu".
 * Add implementor ops to generate custom name.
Thanks to suzuki.poulose@arm.com for the review comments.
v2: https://lore.kernel.org/all/20220515163044.50055-1-bwicaksono@nvidia.com/

Changes from v1:
 * Remove CPU arch dependency.
 * Remove 32-bit read/write helper function and just use read/writel.
 * Add .is_visible into event attribute to filter out cycle counter event.
 * Update pmiidr matching.
 * Remove read-modify-write on PMCR since the driver only writes to PMCR.E.
 * Assign default cycle event outside the 32-bit PMEVTYPER range.
 * Rework the active event and used counter tracking.
Thanks to robin.murphy@arm.com for the review comments.
v1: https://lore.kernel.org/all/20220509002810.12412-1-bwicaksono@nvidia.com/

Besar Wicaksono (2):
  perf: coresight_pmu: Add support for ARM CoreSight PMU driver
  perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute

 arch/arm64/configs/defconfig                  |    1 +
 drivers/perf/Kconfig                          |    2 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/coresight_pmu/Kconfig            |   11 +
 drivers/perf/coresight_pmu/Makefile           |    7 +
 .../perf/coresight_pmu/arm_coresight_pmu.c    | 1316 +++++++++++++++++
 .../perf/coresight_pmu/arm_coresight_pmu.h    |  177 +++
 .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  312 ++++
 .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
 9 files changed, 1844 insertions(+)
 create mode 100644 drivers/perf/coresight_pmu/Kconfig
 create mode 100644 drivers/perf/coresight_pmu/Makefile
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h


base-commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
-- 
2.17.1

