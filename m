Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFFA4C9F94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbiCBIoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiCBIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:44:40 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67AB3E0D1;
        Wed,  2 Mar 2022 00:43:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGgqeTyz4vfziUeBLj/8gJuvZ1lNgXbRKokTRXeBlutEAQLYY05p70ua4q464w6EaE6VgY8HqSOTrKLJIaBLfSeDGc9SbzSYuBmQ6n8O72kDxeDspTfbLJSEplsuJkh3xtxVCcQlbjdE716+9BHb4w2EIuuKyMqoXOtcx1wjMmk37URj9J+uh4Bhspdtv81WYbkwn4nbkZeNAWoWc3831HIV0KlIVauSKpGGYsuKzMwWDJ/HRZXgaB9ksMHCaKFn0sEERCwGDW/mtqol5JNoLhbzqVHE9AnB5WBg0ql3aa2NSv0RA1ZlqifZ5kvfh1QlviO6XNkzcaqEqxy33EkTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ml5Y3lq8kTx6HrG2BNIQTqyEYjOhfWCDIHs6UZimOM=;
 b=QQirWNYDKmV4rNB9RrWJG9Tpr8WdCLoIx/DVO3qnlF7fsrQ4XoZ4bdT4q+sIyCcxEx+fHEldR05GddJb+CrQ6veHxPdJFGgSAQlhaOo7zXQmCVVXAX1fnQxnGMk2Zkg9pHqg+S1Ilra2rLKu2lzquHqjEyFbgyA6nqRAzG8p58tdpG+U9HiiEdW/k/jbgcLURbB7TVP4KZG1Di/HSQ9kN12Z37xYc92F+7RX3sLEo/wFWtyl1j85DjLTeMds4fVUf/HRZq7uii3TEo+g7UVLLS4b3LdMPMDA5I08Ry8ShuYeQKw4XxgmOhvH1A8Y2BFdWoXMghKl0D9NoZbIlOR/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ml5Y3lq8kTx6HrG2BNIQTqyEYjOhfWCDIHs6UZimOM=;
 b=lzH6wVhvqd0qApLcjsARq4UtY7fZxohWNfB5qG/uPXQWNUemXk/oGtKouUC5mYKR3oECww+Bh/34hCuPdQnNKpGL7LMaKVTVS4BFyuC7lLa9V0R6RV6OG05sIF9tulww3ABesptYZFbP5H80tPLSy9Exj5JcX0uVQx8zndlPTtyrLNW1ViLWA3/EeVgKonuMUbYO8e3VVlJcG96meTRplrNdJ2Yv4AEAQ3HGClFTsQ6fJZHwBqVOD5CT6oKaJdr3nHxO47p2tJRvdXisTUrcXvtD8g4V3NNXWJRURI7Hbz+bircRyaH/w8CmlktqImA/Ur1t53cOef2hWFsQ+SQyvw==
Received: from MWHPR10CA0004.namprd10.prod.outlook.com (2603:10b6:301::14) by
 CH2PR12MB4905.namprd12.prod.outlook.com (2603:10b6:610:64::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.23; Wed, 2 Mar 2022 08:43:55 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::d7) by MWHPR10CA0004.outlook.office365.com
 (2603:10b6:301::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 08:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 08:43:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 2 Mar
 2022 08:43:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 2 Mar 2022
 00:43:52 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 2 Mar 2022 00:43:49 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>, <amhetre@nvidia.com>
Subject: [Patch v4 0/4] memory: tegra: Add MC channels and error logging
Date:   Wed, 2 Mar 2022 14:13:25 +0530
Message-ID: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99b01642-a60d-49c9-32e4-08d9fc28c8e7
X-MS-TrafficTypeDiagnostic: CH2PR12MB4905:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4905D7370413186614231B45CA039@CH2PR12MB4905.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FP0oeU/afsT2E/Ghcp3WuYq2HUozzSsNlejHAHmz5Wsi9IMGoa0EwCLPO7TJvQJYQ1thT9nSaWc3lCY+I9Aym0VMMUU2POIm4uqSW//5x3vEVmPaSsr+UCtvI0AVALhdqcO0uZc9ajyb0nrlEk93SV/wcYY5RUr5rw7U74p38kfFv1Wd3Ds/be0GQSVU6RYGFdKKyichcZissCGHZq6TkZ0o+fVTSEyWdyueqUKveQ5FQ66UKNv12DH8KN1sHd3KFe+VfHg3fNBQ3d3WVgvtDB0M14miKA3IpznLwAtkZQiKdQVm0k0a5zqqFKqHZSLOwnxo2omM87TQmy/VzMouXy5i7X+XCDRx64+wYa9O9uaADCKLG6qYqHMtEna4MutQV2oACwaqScJcfoeiScA2QGV25XGtdM2ZkODJjCQLHnMVeiEqleMV1eK2RZS7c7UUoZpmZOOInGaX0c+itSMnxIL/Gwh6Y8Lvh6jqScKCEzo24G0FL6YT32ADrW7cMPN7VuATVXgDwGOx+/IcXadeaS4XAG9drdQRhU8UqpRwlDdoVI45vXHzEhRdxvpOFazMp0GQHd4l6JpTvZ6WNE8okcchZ51MRBuOTJqbwKBbBtLZeYdNiKR9S43l+Gv+0eX99w30xFhp5XxWM1r7pVU0DnpK3khVmtGCUwgWkKwdJ7zuiOnXLzzMDYJeFYyR97qLOct96/5+lGK9dBvuoBmacA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(81166007)(356005)(186003)(26005)(36860700001)(36756003)(8676002)(82310400004)(6666004)(7696005)(47076005)(110136005)(508600001)(86362001)(107886003)(40460700003)(4326008)(316002)(54906003)(70206006)(70586007)(426003)(8936002)(336012)(2616005)(83380400001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 08:43:54.8028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b01642-a60d-49c9-32e4-08d9fc28c8e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4905
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
  arm64: tegra: Add memory controller channels
  dt-bindings: memory: Update reg maxitems for tegra186
  memory: tegra: Add memory controller channels support
  memory: tegra: Add MC error logging on tegra186 onward

---
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

 .../memory-controllers/nvidia,tegra186-mc.yaml     |   2 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   7 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  21 +++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |  21 +++-
 drivers/memory/tegra/mc.c                          | 108 ++++++++++++++++++---
 drivers/memory/tegra/mc.h                          |  37 ++++++-
 drivers/memory/tegra/tegra186.c                    |  67 +++++++++++++
 drivers/memory/tegra/tegra194.c                    |  46 +++++++++
 drivers/memory/tegra/tegra234.c                    |   1 +
 include/soc/tegra/mc.h                             |  10 ++
 10 files changed, 296 insertions(+), 24 deletions(-)

-- 
2.7.4

