Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104EA51484C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358485AbiD2LiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358519AbiD2LiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:38:11 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282F9C12FB;
        Fri, 29 Apr 2022 04:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrAcUOf9kie6PG/i0l2uEk4fKAgoNd0Qn9W6fCCy5u+y6ng7pSEA5xMDs05pB3HNdU9JM3Lha4cr84bu5YPTPF4ImNi5PEDDPrE16OHPxhmfx9H/kfd0IB1tgOUfKjCYbwqrqzi/GmBNw+9cM2liqP8ErnKQW/1BUzOyGiNBkpO4p5k7yjGteckPI33AL2NkMqqNpEnukGVK08IVrce/7t0BZ5rKuDr89AQ1C9XAYsPOVfRtRY6BhbazKoFoupZA4uEwjlWB9l+VFtKV8pLbsE5RclxvOTQ9aOP+cFnO2zKbK6TsbY+ow0P6lHb8fYkCBBfY+gJI28SA/kHD1rCLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX7I1elDhjH/+8oZR2LCphcccKXRrYTaicucSljCB3Y=;
 b=Nkkn1uCRMyEpS3kbsZQ6g87+R07eLZx280bbMxq7+qejDLQ4/Hnic2WUwQcSk6q12K+41Z/uF2eoJUMzb0nXU28Yswk0JTH95Q2xg2lSpDxGGcO8qX3zZzhDoMju218RpLHNBCVNfN9cpBnLt+sYGftFpYfMmk2ZU/vIsOXm64BVNytRH9wzNapz4leCGUJyjGrpxJXP1S2fwYZ9azzgK7Xvb8x86fVSAAvBRBj17Fhu4ZQ6/S+rVpLaf/Z/KJSM8kZIsTRTcZi22xSP6u1BaoUcLrDT0QRkoQ6xMUabUdXIhybSlKJ4AzOWOHI/7L9ExBRVigqtT603SmSBmSkAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX7I1elDhjH/+8oZR2LCphcccKXRrYTaicucSljCB3Y=;
 b=nJmABXOeWDaa3D6n7uJD0ww/P8t1+mRR3ypGJY68yR3TF70d0YQhLRogHRZQISx8n246Dqam0lrIrm0Wou2njGclJzUou9um1nM1gK044XmQDZ7DPokHAUOlFyQlWkVUZDOXotQ57P+TDmI3AMynV+Ak2IHDxyLVop6ytMOzXX92b85vekV9GGPqvJCjWVezV3rPLObcGvzgvyJsI52kydCicAy+B3Pdap37juHBXYYt2D8gNxIyHjhTUbBDOBSyOsq/7h3Kh731WclcZ9i8UCOxOA3R2RJP5zE/YAieVulw0SBPGWRzjr7JVoaaFBxj/vgm1RhW9FlRQeZjX5IpOg==
Received: from MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 11:34:50 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::3f) by MW4PR03CA0032.outlook.office365.com
 (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 11:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 11:34:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 29 Apr 2022 11:34:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:34:47 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 29 Apr 2022 04:34:43 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v10 0/4] memory: tegra: Add MC channels and error logging
Date:   Fri, 29 Apr 2022 17:04:34 +0530
Message-ID: <20220429113438.13988-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a0bbf93-2c43-4787-a388-08da29d4459e
X-MS-TrafficTypeDiagnostic: MW3PR12MB4457:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB44574989C0967E6A99B5651ACAFC9@MW3PR12MB4457.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8syvZ0CdF+ABkrPam3g76Kul6ogCrtbYFU/GkopcClN568kz5ngaN9JUhmINtHT463iGCbmbkxF9nMxvWgiE2/+OUgKmTCxi0P0xnWF8m8DY4GnPKh82CGJUufznfiZJHTPfbVBTdEhrzMgl3COalzCUX7PSFTnBj2kM88Dbwb7jsLMSdlilcNCJI7unQ5rVPy/ClfUMBJhZNkOHdsncNPp2kbCjfbILJUObBER7lZOol+NO4DmTuqaQJOK+FvBBXQ5xC2rUqBQvfohG0p6o4uAYj12Ztus6Fn6GO7k8orREZqZFx5FQnLgAIidOMjlefRibGOp6pDSU0kA2SJ+JjygqLQecW2DqTGNxGPlWms9fKeLHHIFMrnNW10UJ4LQRF9MXABKl6Itc2Chfk08Zz5wpkSyVsvbV23nLJQBdNxbbXZUtC/QO3RnXv2/ArlwcaeDVMw3DHV67nTMvRiwfWnS4a6wEkBKRJsQQDlkDgwrykBQe0TYnIr0lT+0pNGZ80f9w9VbNcrYN9xvqGbdqwSboUBCu9vHoUlRjLyZaVeffReHt0uoH7pPPWTDSb5Mvqs4hOKlmysg8pE1b7HXGCEhx2PiEtUOOCb4jMKDASNqw2Cqo+zhuYvJQjiTSUeIk/F8YHDrkz6Cj6pTOLqyRKuWXjA1yC9JSLJwn7qADuR+nH+vF5lqMmTol0h2iaXbMhS518xnjRrtxq14ELqtCiLD4ORd6DLY7rHk4E29b5Jg=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(54906003)(83380400001)(40460700003)(70586007)(70206006)(316002)(36860700001)(8676002)(81166007)(4326008)(110136005)(2616005)(2906002)(6666004)(356005)(26005)(921005)(7696005)(82310400005)(47076005)(5660300002)(508600001)(107886003)(426003)(8936002)(186003)(1076003)(86362001)(36756003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 11:34:50.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0bbf93-2c43-4787-a388-08da29d4459e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From tegra186 onward, memory controllers support multiple channels.
Add memory controller channels in device tree and add support to map
address spaces of these channels in tegra MC driver.
When memory controller interrupt occurs, registers from these channels
are required to be read in order to get error information.
Add error logging support from tegra186 onward for memory controller
interrupts.

Ashish Mhetre (4):
  memory: tegra: Add memory controller channels support
  memory: tegra: Add MC error logging on tegra186 onward
  dt-bindings: memory: tegra: Update validation for reg and reg-names
  arm64: tegra: Add memory controller channels

---
Changes in v10:
- Removed map_regs() callback and moved corresponding code to
  tegra186_mc_probe()

Changes in v9:
- Updated data type of loop variable 'i' from int to unsigned int
- Used sizeof(*mc->ch_regs) instead of sizeof(void __iomem *)
- Updated commit message

Changes in v8:
- Updated the bindings patch commit message to reflect the ABI change
  and added "tegra" in subject
- Updated function name with "mc_" prefix
- Used snprintf instead of sprintf
- Set mc->bcast_ch_regs to NULL in case of old bindings and checking for
  NULL before accessing it

Changes in v7:
- Updated reg-names as per comments on v6
- Removed use of of_property_count_elems_of_size() and used broadcast
  reg for checking whether old or new DTS is getting used
- Updated variable names as per comments on v6
- Added helper function for getting global_intstatus bit from channel
- Used to_platform_device() instead of passing pdev pointer to
  map_regs()
- Allocated ch_regs at runtime
- Updated DT binding documentation to add validation for reg-names

Changes in v6:
- Added reg-names for each reg item of memory controller node
- Added logging for interrupts on multiple memory controller channels
- Added clearing interrupt support for global intstatus
- Updated DT binding documentation to work with existing DTS as well
- Updated function to get MC channels
- Updated variable names

Changes in v5:
- Updated patch sequence such that driver patches are before DT patches
- Fixed DT ABI break from v4
- Fixed smatch bug
- Updated description in DT binding documentation
- Updated variable names

Changes in v4:
- Added memory controller channels support
- Added newlines after every break statement of all switch cases
- Fixed compile error with W=1 build
- Fixed the interrupt mask bit logic

Changes in v3:
- Removed unnecessary ifdefs
- Grouped newly added MC registers with existing MC registers
- Removed unnecessary initialization of variables
- Updated code to use newly added field 'has_addr_hi_reg' instead of ifdefs

Changes in v2:
- Updated patch subject and commit message
- Removed separate irq handlers
- Updated tegra30_mc_handle_irq to be used for tegra186 onwards as well

 .../nvidia,tegra186-mc.yaml                   |  80 +++++++++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   8 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  24 ++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  24 ++-
 drivers/memory/tegra/mc.c                     | 140 ++++++++++++++++--
 drivers/memory/tegra/mc.h                     |  43 +++++-
 drivers/memory/tegra/tegra186.c               |  43 ++++++
 drivers/memory/tegra/tegra194.c               |   9 ++
 drivers/memory/tegra/tegra234.c               |   8 +
 include/soc/tegra/mc.h                        |   7 +
 10 files changed, 356 insertions(+), 30 deletions(-)

-- 
2.17.1

