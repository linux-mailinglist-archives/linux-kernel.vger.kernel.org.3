Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE7A4DAD62
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354840AbiCPJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237322AbiCPJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:26:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68BF62A3A;
        Wed, 16 Mar 2022 02:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSldX50CXwISBH3l33aSOly+QEyXe+K/gKuzoKI8tGPGyCxRa6qHsxzf3vq33naeanwyjnCbtIsba3Ow8TK3pUT3wkjI5sEybB9cbI4X2trkhde5nCMFaag/+2P+fbUXxZaL64sNgH11ybpyTlEATVEQuXOsphc8o9K0lO0kji6E/47oNLFWiFW/EjcHRuoh5RNLLCgBk+xatZITF99vSQ6k2qyMA/rpZS17U308OpLbzRnq0PbW6EUaV+JY7aZ2PC8Ku7n8S5a0jcMQjHQv6PHQMDnuoSg0YNs/H5HKu1ySfizDOom92gw4IjqdKLHvOLbFks34eBjah45BiiqIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9819Vieiv0F7qnkfckksy302AFgdLh9p5SeJxv9vhU=;
 b=F0p2EKcNoPTkP1sqnnkQ7t/PDEWDFpk4/t33/VuL/8U/HK6artDh2yFQnNP5w/xVrFNrpuKaNYibrXkJKuCEswFwEtgjaH1qrXptx9U5M0BGgh4AcpTuQekvLJH8JWubv2OvH2lxI6WUAQ5nun/vtMiSY+jIkJcIcR0wsU3E7cWcPUfs5wzVjHM+fB59ZB4w4fQ00h3IVfzm2GPD54HDI++V7Bd0V0+PR6NU+s4N3Kj6LaflJoKRnoJ5WxR+cffi+PYUgMif+3tZtMEjztFzLQXpCoi/x4Q7w/AyVU7QARK7rJ4ysjd6zG67XfD8W6R1jLkq0FYf6rTMpG1EaH23nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9819Vieiv0F7qnkfckksy302AFgdLh9p5SeJxv9vhU=;
 b=WEaGOUtBrLcw4j63HAoTIRsXaepqaY5Z+Ql4IDDI5Xcw1NzyJAEf8/ALKd14JfYsvJT36h8j4jlDtlv0QtY/6C+C46Ke99MSeGHES+WBgZUqR1+1m4o0iKPPQXgTCtH0fy/LtKTe5lJPlwdwemZb7ga6UQfQyjzg78HxoeoCtCt1bsNk9anY1NX3e+RVlVISxI1VceUOHX7f/oZJ/8CQ9eByXyDyo1ZokIhUN0O53RidJoC6cQg3btqYofJxqb+ARq4txRWkFkULrorlHIsXA5VsuQCB8jemvRfUMoiHyxadzgKxRSqN/P0O8GZgREHDcS+pjeigZclnydZJfMIrZQ==
Received: from DM6PR17CA0024.namprd17.prod.outlook.com (2603:10b6:5:1b3::37)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 09:25:41 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::2d) by DM6PR17CA0024.outlook.office365.com
 (2603:10b6:5:1b3::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Wed, 16 Mar 2022 09:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 09:25:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 16 Mar
 2022 09:25:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 02:25:39 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 02:25:36 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@canonical.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>, <amhetre@nvidia.com>
Subject: [Patch v5 0/4] memory: tegra: Add MC channels and error logging
Date:   Wed, 16 Mar 2022 14:55:21 +0530
Message-ID: <20220316092525.4554-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dfebe50-ab93-4850-9532-08da072ef0a1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4898:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB48988D1D4B3D207D5C131EB6CA119@BL0PR12MB4898.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Va9XPFJKcgGq/0x1qG+2fD4zdkhv802UGazZmgpJJeTW6VkKpRFyr08ix93HZ6/+izbxaBLxHL574+gAU3OpQMI/yYzCcy4TCDjSDl9wLaYm/QCBT0jg2CWkS18OlZTfRY8pC2nH7wuSQgCGrl4h05byZ7GCin1x+VKvjvNBrmaIpf5rNEekJSLUqPgw83XGXmCFt57N7YcQhq2zkQz6Sgg63fkbV3alwdINghBbqm0LZA6jnWK2XokqBVgYq1sov1aoQiVqugI/bIrS8vR+wQEN2LEXaZVrF8YVmgy/n0Jg35SJ/sZCrz8omqBbdEbSlreIb5KxJc90Rq1450O/euYAx2n0QEocoL/lqyBpK4lzPow7nhJ0J85w3IsduhCZeIaJbIUA8/FxP3Cy/PBbxrEbGeYRxa32ZRmU6laagWUwzTwioV0SrCxAl5FSMuFKOWjadnsOvUmBLElYDs0ZpJQvWLUjqSkQuNVf+mYCyioh7xTP3BHz3DJMxSF5T0+GvoC4zSo75nUAz5WTADWNiUgInOA17M0IRquNFQv3cGPSNFEt04pFoaHCkMhAtDWipjHTPf2cSz+OZM4S88NXnG3wfHLIyFCm5nBus3b6JbrMVDk0+J8+3gRJleCm7i8hWxehJN7cnxGQvWOW1WX7KPefepAdFufw7VMc7ze480G5Y7COSJZGfJ7h7Zipc9VFX5403h8m3Ruj36sDvDk+uQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(36860700001)(86362001)(2906002)(40460700003)(81166007)(356005)(82310400004)(5660300002)(316002)(7696005)(1076003)(186003)(107886003)(2616005)(508600001)(54906003)(26005)(6666004)(36756003)(110136005)(83380400001)(47076005)(70206006)(4326008)(8676002)(336012)(426003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:25:41.2107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfebe50-ab93-4850-9532-08da072ef0a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
  dt-bindings: memory: Update reg maxitems for tegra186
  arm64: tegra: Add memory controller channels

---
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

 .../nvidia,tegra186-mc.yaml                   |  16 ++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   7 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  21 +++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  21 +++-
 drivers/memory/tegra/mc.c                     | 114 +++++++++++++++---
 drivers/memory/tegra/mc.h                     |  37 +++++-
 drivers/memory/tegra/tegra186.c               |  87 +++++++++++++
 drivers/memory/tegra/tegra194.c               |  44 +++++++
 drivers/memory/tegra/tegra234.c               |  59 +++++++++
 include/soc/tegra/mc.h                        |  11 ++
 10 files changed, 389 insertions(+), 28 deletions(-)

-- 
2.17.1

