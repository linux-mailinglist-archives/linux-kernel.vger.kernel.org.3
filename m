Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E33F4FF3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiDMJnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiDMJnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:43:40 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2071.outbound.protection.outlook.com [40.107.95.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FA8393EF;
        Wed, 13 Apr 2022 02:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZNiiAbQUV3j1DXnn+T01dgs1qjEF1tb78zLrAf19xzeqkQ8b5ks/VwV5L4ExK1/Ry8XpY3mRXdbrEKCcLefKmVKHGmMVPT9xisH1hQ9JKsuZOT4Lm9jsI61CgLPcIaVStgysyk0y08Hs2DceQFypP2RQ/sGOnVM83Ya+uelAjm1M3cNh2m8Rxd07zM0mIqwhl/22Eh4a1fd4/f9C9tY+vZY+DGvkKJGJ5gsHNOE6KC2N04BSbMnNfRp8JHVIfPzFRzrkL6oTD5iWxKdBUafk+L5xssQ55f6BU4MNcidqv4ZmXi98nwNl++nbF0535cvCXG7yuvhZZRNZeX1wJUBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEKGrbGrS47TdEdvNEE9pkS2ts4pomEaWaGy7wDQp+Y=;
 b=WAKpvpYmZrayCullccI3y8+3kLbw8hoyCbwrbeSrlDMRD/QMnKdlvIeFnYV6plUw24411H8IAGpSwfyYbwqlhWMEug/gbbqC0hXC3stqunTVC6+9jAXSM4hrOs3rZ/Y+ZO2xhUsNQTYA20JSbivwayfhQVOts0RK8pr1c5DDraUiyhF1EdvoV3/vDw/oAgj2eIlNhg6FPTlzs6M1Pxt7dCBJ6rC0vzFMQKU2v4GEKAW91GA6OdXtwmf4pxiJEbNwBdTlCRicP4YjBY4W7+lVD5H0ya/xLF6tjgdKLR1wBCA4fqj42CJlUrhLyyYTnJgMbeKfZR5eJ6SRpzuGEraWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEKGrbGrS47TdEdvNEE9pkS2ts4pomEaWaGy7wDQp+Y=;
 b=LbrjdGejfpEZRlSNT56eWtKNudnEax3/V40XRLo/yJGtqZE7JIXsBT6aM36ziAz9+Cm37pxfI536WwPt/CohFHz718qEnaGEudQF8XEgAuFM0wS55cNA671NOKCS94KUcqfUuAvg78io7xe0AYVbmkh9WwJIgjnsraMrgDw2xp+ihx5Ah/fk289pUyEv4sFry+MoRohKVkQVgyzx5bC0fqag+u+cZy/xSLl5Bbb7jr3XyMWQBpVMTZd20xzYj+khanC/gHtXQa7SGET6f2/8JyMSjEI7pNXh1VCZCxoUmStiK9bhehbBVjdZTEAgTDggbZ6TgezjgDxAMj2pAXV6/A==
Received: from BN9PR03CA0957.namprd03.prod.outlook.com (2603:10b6:408:108::32)
 by MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 09:41:13 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::7a) by BN9PR03CA0957.outlook.office365.com
 (2603:10b6:408:108::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Wed, 13 Apr 2022 09:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 09:41:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Apr
 2022 09:40:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 02:40:25 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 13 Apr 2022 02:40:21 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <dmitry.osipenko@collabora.com>, <digetx@gmail.com>,
        <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v7 0/4] memory: tegra: Add MC channels and error logging
Date:   Wed, 13 Apr 2022 15:10:08 +0530
Message-ID: <20220413094012.13589-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ab564b7-803d-4949-4726-08da1d31bf92
X-MS-TrafficTypeDiagnostic: MW3PR12MB4588:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4588889342E9A8001B51509CCAEC9@MW3PR12MB4588.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWMerSBV7B73pwz1rA1mHIjOTm40WBeckVEa/BdJN7Gl9N2fS6HrM3NltgWWGeFxvfdkVkPkt6TUVod9AS69/Lxyh4PookSeFW0mC2E9o+5A1bAHl5HE3Hti2motvfOVTSvJy/m9xuxd/BtlbCaB8voF6+lkmO/POKWZAkEkl0NfxELeetL5jjkOGHrH76mzG6J/jqu0dVbWT0v55N141a06UYFmszxHkFRKF0F4zuvzZhuA9N3tjHa3IhUp4e45zBnxTKBqieV5QARfZWlypLOPBiMaUThQUqXECnsmccsVl3WJ91FJO5fgVUMCcVnYLkwkcG50e2CEXKxAHqMfk4FaI0dRpr4yaTnu2/RXNnrTt6GLJ4swRstKajZfyjWJFwCiCgUPSu174gysJ1/Orrfs8VF8TzDAgNIxGeEH2yoNbwUEyjZHnCS+uylbullVK6kAj3R7zrJbgb7ZAv11kxIY8iTfIFaIK5FLZS/17CBX/I30Za/PWsWkaYLXd5HJznasfFTKfQKVHY+6ZECkTgCJGyUTBvUYBeEzoKQRMpk3rCW1/MQGO1JmG3zMr+GztqmXCeDsGGnXtqSzfAGOKZL/43hAhoyLRBz3HZIuWJknuOCPrsdskBhjzFa04i6FQMMXzl6PFGGqCxStBtTV5E1PAad5jNUFLdf6KS6JezcMrB9dSOW9WfqNvugooSf20U78XnzXloXNCujyTM2MFo+RfE/Jj8zzshqCxX3VB4fcstdtSXZmqqGFNSHfXLT1lYInUVWxFKlx5Xa5QOI+Gg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(8936002)(107886003)(70206006)(2616005)(4326008)(1076003)(2906002)(47076005)(186003)(336012)(26005)(5660300002)(82310400005)(40460700003)(36756003)(36860700001)(426003)(83380400001)(316002)(86362001)(70586007)(54906003)(110136005)(508600001)(7696005)(81166007)(921005)(356005)(6666004)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 09:41:12.9265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab564b7-803d-4949-4726-08da1d31bf92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
  memory: tegra: Add memory controller channels support
  memory: tegra: Add MC error logging on tegra186 onward
  dt-bindings: memory: Update reg/reg-names validation
  arm64: tegra: Add memory controller channels

---
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
 drivers/memory/tegra/mc.h                     |  37 ++++-
 drivers/memory/tegra/tegra186.c               |  47 ++++++
 drivers/memory/tegra/tegra194.c               |   9 ++
 drivers/memory/tegra/tegra234.c               |   8 +
 include/soc/tegra/mc.h                        |   7 +
 10 files changed, 354 insertions(+), 30 deletions(-)

-- 
2.17.1

