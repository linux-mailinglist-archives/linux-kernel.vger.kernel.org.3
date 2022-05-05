Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CEC51C5B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382360AbiEERKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbiEERKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:10:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31782562E5;
        Thu,  5 May 2022 10:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCtgVLdJ82O9QvAGap/d4/ISqkWi8MelvcvY0hKy9mce4D4nd70uQGe3JywKeXcToLm5o5DRBjYq8VfbU7QFfmYEAux3tLFdCxZihHPNiV2Zh45LB/+RYD4Rv6Pe/PBLiXIbrOeuZUXzHELYvu4Jh+V6YXPU8o1XYSRtRJoD6Oss13vhxvyfYcHJ8u48FkYLqavX0MJrUnF9H3ZHmmbE7iat7xgz/wDOib9xF8DqQUytPqRfj0Q1gPmK/AdvaNcPOrllsTFXS2pnEhPctbcfd9wW5/gE/HpgNpIpbBcIKU5tOYYQKpVmNvAEJlHfk38qbdePcifgEItq9xek6zj2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrFakLU+n6DMY5pbsNbrovHmCQu9lByuIpvtrSZHwrA=;
 b=l9eQDpvy9+8ZwAasC9FiG/CSantrQlAGI03fI+pAOHD7CJiVcLZdxZMy1kteIs9UG8F7AhI1g8dypdMjcDdJGq+tlEGJ7rZ/A9gMS2CQxclOws0MNvSFYHHzGaqkpVUbXycnDNrxEfBnQ/sZaezsEuFC0hQFHqqjWUTW74B+jRQV4DEl/CzYui+cSWLufqxZj2SHNDnnSAuwZOWxfp2wjkvZG0huynz1u9oaCt7JJ69DV8eqxZjzWsRsstWXrpc/m6nNhnU/Gf8xtL3Hbe/2Xdi3QMBEq4Gu2Ae8qJG8j80CNmGBQnxRDLqdIDhTSNWpuPqE6ukZTxkO3DD9bNhU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrFakLU+n6DMY5pbsNbrovHmCQu9lByuIpvtrSZHwrA=;
 b=UU9b9R714HSo0Qiopk5MlyvtO83gExxelN/y/i9bqahaPAdW0vzBYo84aJO0gEmqcj32FEhYBU2Q8jATB1QouYG7Y8LdvwOejen//UzjD+jUKJEQsiyve7FB1etcCIBXM9AKfwmrMdLwZ38MJ3Z9mUxHqni042w2XF+gFRIvYU2642PIHeRGIXoPvzesIj/NlzDD2JLMS83VKFDuj2P3Gt699Keddm6Ukj2Zig0dBxk651fbpXdH0UGtMYsU5W3g0S58WSWiVkO2lW7z1jg9z1dbFL0rbAZy9cZ3JNFgvTYTZSg98NV4eEX4RysHIu153I+/4sGaHsMkHIgXRn4O/g==
Received: from BN1PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:e0::25)
 by DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 17:06:47 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::5b) by BN1PR10CA0020.outlook.office365.com
 (2603:10b6:408:e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 17:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 17:06:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 5 May 2022 17:06:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:06:45 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 5 May 2022 10:06:43 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v4 0/9] CBB driver for Tegra194, Tegra234 & Tegra-Grace
Date:   Thu, 5 May 2022 22:36:28 +0530
Message-ID: <20220505170637.26538-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af28e53f-27ac-45ca-4b1c-08da2eb9a363
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3962E684C6AB52D39EB5C25EB9C29@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLdy9RUBvRNdovBJ4buW+t6OEbXm6GuVEfu9ixyEEizq0VBx9sd9gjYP1srKLdwzq05UyTOwm84FstKQscdGVeIsNHGu6RqyxEOBvGCOSNLVGa8sR5v3e1SqX5bcVF1HZ0fsUkiFCkKZrm+QngPSk7MhhX+mHYX+xE5Bjs/71MzJevrUlp587sN7QkR2TTCC65LbIqF4fFLzgD8i72BL0pwjrXZf4o5XWFqgxPJ6ccLFSmDDawSOSQ181XYOyJDtV1qPZ/grsA2sumhZCFUr2FCMCz86MU3Zv75pTdA6aY5se8VR9yaiY7o5t6OyilunRJ94dV33NrsKizH2jOtVESqx0ANqaGSb4ztu+bxKCyyFvVUo5ujJJlFeWuuB5A61bS3Xw6KubK5iozId691djAfx2nUSiDqDL1NA5KUbJn2z6wR1c8WSaEKZtWlQLH/sJ88lsgVo2+17eeVveZnXOgjWJxPUlTlgnFQV68FzBudG6vC4PdPp+rjpZWk9Mp72N5xjjAv6P4ieuy/JieyKFavoiG6eDpPy7tfHbuPvtrRRnlDdm2fqRNDZGo0ABh0PukvktsxId3d/dvKL8qN7WUoctDFkwQCHw7rPkNzx4PLYRDMv0TObnq9AJbQOtM8qlAR4GxRGEGtDZ+7FQgzgBdv+etsWgkDoi1xrwdbovSDkMCrx4+0EvtUnZsapnJ+JNV++acxjPKgNFUIRx9XMKA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(8936002)(316002)(83380400001)(8676002)(4326008)(70586007)(110136005)(70206006)(54906003)(508600001)(5660300002)(36756003)(6666004)(2906002)(1076003)(26005)(7696005)(186003)(47076005)(426003)(336012)(40460700003)(107886003)(356005)(82310400005)(2616005)(86362001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:06:46.9648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af28e53f-27ac-45ca-4b1c-08da2eb9a363
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
v3 -> v4:
- rebased patches on 5.18-rc5.

v2 -> v3:
- fixed warnings with GCC 11.2 and W=1 reported by kernel test robot.
- changed some function names to make consistent with tegra_cbb_*.

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
 drivers/soc/tegra/cbb/tegra-cbb.c             |  198 ++
 drivers/soc/tegra/cbb/tegra194-cbb.c          | 2261 +++++++++++++++++
 drivers/soc/tegra/cbb/tegra234-cbb.c          |  831 ++++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   29 +-
 include/soc/tegra/fuse.h                      |    6 +
 include/soc/tegra/tegra-cbb.h                 |   43 +
 include/soc/tegra/tegra-grace-cbb.h           |  219 ++
 include/soc/tegra/tegra194-cbb.h              |  158 ++
 include/soc/tegra/tegra234-cbb.h              |  342 +++
 17 files changed, 4410 insertions(+), 3 deletions(-)
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

