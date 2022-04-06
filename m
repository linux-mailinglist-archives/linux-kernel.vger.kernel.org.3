Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A7B4F5754
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348537AbiDFHMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiDFG5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:57:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2070.outbound.protection.outlook.com [40.107.212.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF21D2069;
        Tue,  5 Apr 2022 22:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWBeqpQOx40kDLsJi2SfpzHzOq+5K6jOK/b7eioiFQkqzkEeOXMzoUxwSLLO/+NK/Ukl6eAtZtSDbejVPhtSqBLG2hQq7lTxABZdqRJhRvDWY0hapQ8u1dZ3pfm5PKKhaMlojj8UyVS2baHAEwM+oArRT0R3HYPvo6Dq3ytPEjRkOfqxPLHififnb8nku2bcGTksYpfwQ6s9D3EJ2PWn7ehxeKW7ke8+POkDkvz1wqscwUVKHt+uf9WK5tIZtYEIWpmQgDf2TeqOcRt9rkocXnmHGKCuqmQcBV+MiCb18oYNrBvtCqLKmth0Msx1WG68rSn2ljhE7xSsY5PTwMUk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99r1v5r5od5O/aXUdW2QEQW8bEtdH3taAa31oRxXURc=;
 b=iM/wntrFBCOYmfWdEWCZ/jip/1e+EEaDVLYrHVaxa2B0QZeLVYszSA+R3Zr3MtJ0kVVh46S2eeHIcwpCBHMZQ2WtV9xuu+ofmB3cBk+4mGJn70LBtTe2pfMqpfD9YYPfNj0G2ebBxvjmLVFNbL+KWX5QfGAuZzuNcmGihA2ANHYjoC5eO+KC61gmiReylXtOsnjk9TbMKeuvR4Ox+pRdXkKFlbNhVPRLk+wx5/B2GZDVZQGQWKhvwdhLuBkUTvR4LIYHq8Cjqp/6JrhwqUhL4qhFPlsvfgii5YVnVYe8IYdZ2C5xddRCyuhysj73z0F7pqEy218vkK6vkq1/rxteFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99r1v5r5od5O/aXUdW2QEQW8bEtdH3taAa31oRxXURc=;
 b=bl5/V+H9guGDgjnwKJogQ+Ry4QbrgLnyXbMbiZdLkLhGW9pLiCH2xxt87aDpD2rDwEs3sREWzo3m2nVYe0sntaW7KBxz8+NQ10zeVBFuxNB32XECsSTKIE5bX72V35stvGh6NytrHwne7faRDg3zjAtEYs5lohrtBLxzsgWnR4teh3dESBRHIs7f+Fl7OgIMkfBwhQPtSsri8Ricm6eJmpRmp+78UouILQ8Dwkc0DApZsUtBLt0Edqp8sfAX7iz9NT6kZu8htfVe1chPKxvrPSiFuShhEURHRjLkCY7+DKvIM1BwhltjN7jkPEn9y/wGXRKUnJcEn9KH8N/ZiKJb5g==
Received: from MW2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:907:1::14)
 by BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 05:25:11 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::99) by MW2PR16CA0037.outlook.office365.com
 (2603:10b6:907:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 05:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 05:25:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 6 Apr
 2022 05:25:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 22:25:09 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 5 Apr 2022 22:25:06 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v6 0/4] memory: tegra: Add MC channels and error logging
Date:   Wed, 6 Apr 2022 10:54:55 +0530
Message-ID: <20220406052459.10438-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1c7e2b9-5b80-4f5b-c292-08da178dd22f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4968:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4968A014F2D945CE68E87274CAE79@BY5PR12MB4968.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrYfiMagzHiS2YS+4J/g2r+LAiWVnYuAKkQFe2iX8R+T1w1dsdpKwhoEfXMNUYf2jQziWlNMTkSLAoMpMCasA4Br9+BJeqzd8Ot7Nl3b/UuEBKXQxkIVwsiWtMAKdCx/JHW/Dv32CDOohRk5dec3BsXSzU6UelkQzG4mpHNTl6EtT1JM6ZNjH1blHmcst5Li4jxZwJYLKTLdhRI6CP9ilmniDAJXFAJ6bv8Dh93ilG8H6/7qziuLyO8yrtg5ygq4MPckP+oHTNL/V1a0qqFFsMmXpKBoOEjD14B6I3NkfFAXLAa0GpasP8PpscPkJMJ1sZzQAUSu5i0Rb4fuLvqpIMVNWAnGodFbr6rtnm50QfpLBs0lkgD+sAB2bHFyxsNQv2Y73wiMDfNcDqgNSzEn6+1Mc7rsUcTibq7qrGfQNdcYRz1bJKcaoQlnuQyy4DBsc+BolPD+Cq1AY/MRaQFzE3SjZPWDjayclNpixrI9y2duLeMDqIrg7fTMZeQ7EF9GKtbAfzfGs43MKKVS/ePsc6jIvKs7fyYmAF9lXmdtJWG9qOphlV6AnGuZVX3kDN7eK7ImtKMwc7wDVSMB/dDcEKnmMQhA2MgY6BRDgoptAEAap7NTr2/k1AzWbAIlDieOD6ERYpLLxvEuhKSLM9Iz9weVwtgTtYhADmHL4AY2DxPEcuPyHwJRiOk2MaW311givpQlnAUO79Ch45H1+pPvXQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70206006)(70586007)(4326008)(8676002)(316002)(54906003)(110136005)(36860700001)(36756003)(86362001)(356005)(81166007)(83380400001)(26005)(186003)(1076003)(2616005)(7696005)(508600001)(6666004)(82310400005)(40460700003)(8936002)(336012)(426003)(47076005)(107886003)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 05:25:10.9425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c7e2b9-5b80-4f5b-c292-08da178dd22f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
  dt-bindings: memory: Update reg maxitems for tegra186
  arm64: tegra: Add memory controller channels

---
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

 .../nvidia,tegra186-mc.yaml                   |  14 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   7 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  21 ++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  21 ++-
 drivers/memory/tegra/mc.c                     | 120 +++++++++++++++---
 drivers/memory/tegra/mc.h                     |  37 +++++-
 drivers/memory/tegra/tegra186.c               |  98 ++++++++++++++
 drivers/memory/tegra/tegra194.c               |  45 +++++++
 drivers/memory/tegra/tegra234.c               |  64 ++++++++++
 include/soc/tegra/mc.h                        |  12 ++
 10 files changed, 412 insertions(+), 27 deletions(-)

-- 
2.17.1

