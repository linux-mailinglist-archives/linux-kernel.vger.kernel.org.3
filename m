Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF595336E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244217AbiEYGtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbiEYGtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:49:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96156EC7E;
        Tue, 24 May 2022 23:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8TBqcxU4/3qyJqD+icnM1rueZ31/UIoPM0QDWixg3yjGEvDCDWeo6vqVRnqGlpt8/vcfZx1/EmLlU6RYKH2ukqNFr7Gf3iSFnl2ILY2ysxAuvo+sCnYiP3gzY7uQ84EajfpszxRdR2QeMi0QOOhfm0a16ftyROgwJI6s+l1hw7SiSap2fJGDVqM4gAvPixyRZAWix4es/KBpiibxBUM7J+1/RW43Aa4OC23/c0NizepDFGBlOEWUJzLLEK56YUqlqgmqb2Zb9qZp2XjjRCkKOQHUaP+GO8I9Dqhdd8H09q5R6zB3DANFdKBfWmWwZ1M4DQ9yMLvlJJHmV1jKjHv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SdKu2mzwuM6ScgSwpbG8zdidRFgymK6jcf0sycbyb8=;
 b=GECFaxCBOGdv7O3j4vYsoguakVWR2h2BihK29lui8hcWbVOgHn38T9y9dcImrv0wqw3HeXFeTu9cuDPxKTvSU4n6j57X5tI/qjhl5I1TiRs2kdk94chNh5oWekNGdnuN3XD1PG6pR3aXgfsUezwoaUFRZqO1L9HOcdj18wdHCj4ybyRGhw6t6TjY/BRuCSxZk7C5yMT1tHRDzfn64l5l7AQy5p6gVpF88daWRdcbwWeaXR1fyRWRXfPiLCikrpXJYgdmoBK1ClmvRLPX/TaBMQWp+BrWwmML7i0ur3TnSe7malEovuTLvf5i4+01xwxxer0z1+v63oiNBXNMB4BiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SdKu2mzwuM6ScgSwpbG8zdidRFgymK6jcf0sycbyb8=;
 b=MHv5HmTcUOub3gUOvS0LN3ujnfGEr9gu/E1LA/HZL/xTu2qFo/0aD7U4+ZsfxUdWjC01KqyBWSuN9wyEQH91BVgHEIH2VwSm9KF09hYAjSPhPhRqIep2RHlRe0KelT0hL41cf/SbSQKgto+kqZRyVKjlGSFMn5ngGNMIg/47avMwXDFkcsl7mqk3azryoO79kQUnQVBjA8jp0AFc5PVBIB2GuXnTFhaXlrhRBd0qFDQt6LBve8+v80YG0hhzINv8f7HQvBJ+dc1gx8FbCvmWKHuwbt6+Qz1/lHO39JGkkjJEHIPdTJ2I9opmbNXTK1Mvm593Lq8MwLD7WsJf2iYEPw==
Received: from DS7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:3b8::26)
 by DM6PR12MB2665.namprd12.prod.outlook.com (2603:10b6:5:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 25 May
 2022 06:48:58 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::53) by DS7PR03CA0021.outlook.office365.com
 (2603:10b6:5:3b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 06:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 06:48:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 25 May 2022 06:48:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 23:48:56 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 24 May 2022 23:48:56 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v3 0/2] perf: ARM CoreSight PMU support
Date:   Wed, 25 May 2022 01:48:35 -0500
Message-ID: <20220525064837.7263-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220515163044.50055-1-bwicaksono@nvidia.com>
References: <20220515163044.50055-1-bwicaksono@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c47f9e-bf24-4cec-8b15-08da3e1aa4aa
X-MS-TrafficTypeDiagnostic: DM6PR12MB2665:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB266573587436F8DF9D0CD961A0D69@DM6PR12MB2665.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHUGmLu55LJnKZNQTsYGVqwp0AOGJetW8k4BSaDOXMPzuEST1VCGVLybQa0RW9vF6t4l59Za8WNum043OKt7yVVQm6W8yiWDxFdarr0Ax8IAmAr9ygcXgIyCOrhUp80KlD55e39wgI5YRc5x+VDR07RbJAya8su/gzazSXs+03ty1MQiZB7Q7TX7HrpLDun/a96bOY2yqAwOa0UuBb13hFhpXNm+CjPLgtiTBVCVrK6MnIKhT10o0kwWQeOflxUBTT+ABLx3ATfev1rh/5FUtu46T38neh65D/Bqk3o/g7I3ZHjNOkb9nJZuJGgAyJ45ESE/Zwajruv4VDD6MoLlHOiw3FjnXbSmH9gux8e2TQ07Fr/OCXDu51osL2jJHjUzCYXjn/IzRZp/25MeNGbHWMLKBB5FjAHYzAdSP27XDZ6g+TECpwIQN9F0wvwC1k4rFgElZch3x1UZ/vIegc0s9Lxy+7o7gAuaLOPgZIfWfQaaUNaOfDwW1pisSH/VqI18fds4fX0gZHMCvi84qdHGRqD9UijrNmhgIk44laBeWS2du0b5QOQf9BULiiwluR+wovyCSO5G0PKTTrj7byu/Uh9sCV0DZc2dztY+FxHmG2uoJDNXSIHV8mLKKYME61Ykkl7l+MKVDg+vfo+G+gWZvTOc9mvX4v4rQ98ehZ2MVgIrq8K4P1o/cuXFoVuu6l5TxhDQeLnI1QDWvyBgLHHltwCYZwv7CP3SR6W6Nm2bDlOPVuFH3b1H13U4Xo/HnukZrrLFTri8deo3cLNsy/NOlv6Aw5FEfPT9oU+9B03OjybUuSxdwJ9PUERM7z8AZurDPTBXb7LGkkyg8XqxPstpxQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(36860700001)(2906002)(7696005)(110136005)(81166007)(356005)(5660300002)(54906003)(82310400005)(6666004)(40460700003)(107886003)(336012)(426003)(316002)(8676002)(26005)(8936002)(4326008)(70206006)(70586007)(1076003)(186003)(86362001)(2616005)(508600001)(83380400001)(966005)(7416002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 06:48:57.7964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c47f9e-bf24-4cec-8b15-08da3e1aa4aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2665
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes from v1:
 * Remove CPU arch dependency.
 * Remove 32-bit read/write helper function and just use read/writel.
 * Add .is_visible into event attribute to filter out cycle counter event.
 * Update pmiidr matching.
 * Remove read-modify-write on PMCR since the driver only writes to PMCR.E.
 * Assign default cycle event outside the 32-bit PMEVTYPER range.
 * Rework the active event and used counter tracking.
Thanks to robin.murphy@arm.com for the review comments.

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

