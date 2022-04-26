Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D30350F2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbiDZHlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbiDZHlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:41:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05301331B5;
        Tue, 26 Apr 2022 00:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4YAzyFrjis3FXVI05IR4KJt6Ofc8JD0l75WR0TJNupVFdx0sR+JwsVegntj6BLwXDjm9che3bImwqcRBqdRA44hjAJzn5dMqNpZiunrprCGVrYopp0FXvI2dExJOHNa4OHb47/HMrZiLydEOyz14mglMEcOL7dZGvdQ/vqzXU6A9HRUqtbqO69J2g2M7kQhMOHkfEJx8+6pbtqfHFYK42gzfvauO9iEvbhwYs5E0/g1uJv93sne8WlILb9g7gMsVnwKY/mlCLwHJ2nLk/iuVZ3HXZyqp2yIIb8I8DwA70mizpRxbkMceQklxQNJw4LhFY7GiULEOU+HmvjqkrufEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv3L3GRknGHONtvTTaG2WHCghWYxlAxiGUfuIO8RDb4=;
 b=gZOOato8FiaPA6EnchCkCizX7L+uV7gsLcLu2l8muwtMBJdkumduymthqoQ+fSrfxaCBX08UVYuvn84mdj/TJR38pm+wayu0l26cgFQ58FkVFE02qdXMNNlhhnjqVcGjD+Apf305kK1/K7D9MujSXQdeGwQzfHCWLbSB4U9ZsJCzggyHJS2HxLygOJne2iCzxaszN2LkiGIXxq3lOrwL4GA+InTA9lwpybCS/kwZNcCvJkFplmPqNc/7uwPr7NyuwAg3yzi72BdnVp/t9/M5d2XAIdtzIEgH5Nat4fwLFl7LpzJ0TtwKcsB3vBdeuf7E4AbSFC8/R3NlvKoqFh/HKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv3L3GRknGHONtvTTaG2WHCghWYxlAxiGUfuIO8RDb4=;
 b=FHHW65cM/nQVdoMFz0l1WtTzHxRX3V7B3miv1TwN26V3u13khu7F54sK5NUQ+nROBGIJO/8TmhptuDHiALVa1Zq9KKsn+YlUcs9vo+2FxdsV4FK+kgibRH4Q9OJF6hvdQ7EArskJAh0kkNAqk146XZFpcTd6stM2+m10t9Z8t36lMDWffzbq2dd0ZDjIPkm7c11xjD66ia2n101fs3TJJ8svfhiJ1g9q2lE3O/gN+FCu4UwJQXEHS8VMjAEEsv4yUIQEPs+wM2atnouqu6OUTXsFl8gR7MJ6Uhnhglggucd2XzINi8yW1T96c4W2yJzWrmeDS0/nOmdXEKcwy6+qcg==
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by BY5PR12MB4935.namprd12.prod.outlook.com (2603:10b6:a03:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 07:38:37 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::17) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 07:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 07:38:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 26 Apr 2022 07:38:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 00:38:35 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 26 Apr 2022 00:38:32 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v9 0/4] memory: tegra: Add MC channels and error logging
Date:   Tue, 26 Apr 2022 13:08:23 +0530
Message-ID: <20220426073827.25506-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ec0ee3f-a0e0-4a9d-1cf6-08da2757c683
X-MS-TrafficTypeDiagnostic: BY5PR12MB4935:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49355EF7834DA52993BE2FD9CAFB9@BY5PR12MB4935.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2xn69P5l6iLtzwHMe8zgzR03yI22ybLzaEIQ/hfG8lm87JU9dd7DRDZEQDYg4NaC6zVj8T0rsOpbazwoTDEMA8Fira8di8tyosxl07A7Fb7+vmnV0ZbhxefqqHG95yRRxKAkqBSc8chs8pf7WgM37bjTFFAu8N8aBl00v8zqsb8e5qnEEfVd7w1GZCiZj7ybyu3NGCDwWBSKxA3zgPWOtF0A/y91SrKXylugLvEXNoMbZeFN2vxR7fgFg7ep1+XiZvZ5E12bkEoL1KXDLB7gtfZG+Nd1Wr3dsQZzcLbcUgTyLEpEQ5dXJbubGvzu4PegIrCUuOPYFbyfU17xnXr8A+Z/PKT/8GK7ZmYjI53ecDCLFuFCiQpu/7Rx9xPbu0DqPkvgFCjjUN3p7Np8a0/uP0/4TrTjAhV+x+ixDRCx5xz3uWatFde779OxMBObmTx7rhGqgaVgOjqpRYZkNBQerMjy0GVNsk33fPsFc1k1/AJMPklFqieaXpY6nFIg9q45oTH02JpJfDqBZ+ZtRd0CzfFZ9rYHcmu44yM9sns9MMT7D3j5rsdlI2UM8KLL9A9dQ0vfEqHEXPZYYvPpSTSJaB5n5NI2NO/CzpxA4mg+f6ZG5+Zz25yZbqpszQAerJjcReILJEdY/UQEO2cMvRmD0ncq46j9gtE7kZ/pVrk3zWyL7bYK6470xg/bjNJN3OLECIBrm5SVVXvFRem9ZNMlWnupePJZsWpvBaeqbeAnHw=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(1076003)(36756003)(47076005)(2616005)(5660300002)(107886003)(356005)(83380400001)(36860700001)(921005)(186003)(336012)(426003)(82310400005)(81166007)(8936002)(7696005)(86362001)(26005)(6666004)(8676002)(2906002)(70206006)(4326008)(508600001)(70586007)(316002)(40460700003)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:38:37.0747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec0ee3f-a0e0-4a9d-1cf6-08da2757c683
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
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

