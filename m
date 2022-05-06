Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D551D64B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391187AbiEFLQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352587AbiEFLQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:16:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FA5562F7;
        Fri,  6 May 2022 04:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RruUjGwnmq8uYIHjAYH2Fh+DuCG4bd6UPw8DSYaVHOyZcOIP6I3YFVd6WRoCIBSdAYJpMhuDIBjO7slL6mjOX5vLpmkVdOtrOYQkV4atO1imrI9z/9jynrmni1ZiDokB15nTf7cIcEIE1orIx40hdcL6mQkaWTWGgsf/BSpYoSywe567OVX6np7C3uAWsayR9I6zgsMvj4lOW+9VBbva2DAzVSb8kwkJ1zSv9lNQVKdW2cpmTHHAkG7gO8yJew1jue430/CjHKO7g8XpUAyWfVzKyFSqc1BahlpUx6IXouXB8VVUZek+s7FNgXzRoGNfBbDicFPwdGfytfxl39lEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvNapFuKF+U68xbMDSb9hJETc6pY3y6WGu7F7jVfEGQ=;
 b=k6Nc859l5OBuiDgzs+whhvguxUzezPr2rYy05DL1YSm3jQhsU7l55KCd4lXBS7WdJbNdEitwGGGNGhI4y+gZFpjCdLpt1QF6Y9zx1dOdZQMgIbEmA4L5+kUPOU9e7aNXfDbxq8yy9TmOyJp4fU5jZectVeggW1yktr7sokRpW47Ajy7cAZpJcrFqoA8plRWrwu4cTxJhggzH7foNpuwKWiFOuIKiashkvQZBv6nJEDugq2DwAXurp/exXVkzgDyuWNCixaRXDRNWu1qRJqQsV+1qJQbnGgMAqUf/dkFT8lXy97OTbObCGlY/IKwVQP0HcC6jXhalOFEfJbB/YIVQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvNapFuKF+U68xbMDSb9hJETc6pY3y6WGu7F7jVfEGQ=;
 b=VglA5mY3T0O99V7cZo4q3Y9Y25yTTbl1fKAngJ/npZ6/sEgCHC1yx69H8gE8bVgW+MtiV9sVmBSH63lhcFMEfV8x6xZ0z6aOUiZ0VZTvGocmFB6Qe0LAzLqMkcda6YB5lLOdiYjrwQ/EI0V08jbhjoJF/4IU4h+RuflVetePd+THXNgpVIVSIEMhk94QRfDY33PfiRJ4e3Q2qA6kwT3ZjWsD+kmh3VO6BcejFicexqPPuNNvx4zqb3eDfQiLfX6MCpR/zSRBRkehXC3AZv84zFssLABQDqcUnSV2doTeY0q7nujuKJTbIDLDDDvfV3JZyy47xkWJzWxENEj5T7ZW/g==
Received: from MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 11:12:27 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::e1) by MW4PR03CA0186.outlook.office365.com
 (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 11:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 11:12:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 6 May 2022 11:12:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 04:12:25 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 6 May 2022 04:12:22 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v5 0/9] CBB driver for Tegra194, Tegra234 & Tegra-Grace
Date:   Fri, 6 May 2022 16:42:08 +0530
Message-ID: <20220506111217.8833-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20d187db-18c6-4501-4894-08da2f514db9
X-MS-TrafficTypeDiagnostic: PH7PR12MB6633:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB6633E0EBCD9D8515190EFE94B9C59@PH7PR12MB6633.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcNWNs/eLq/O0NuECz1BqvbXuYZHnZnzmZUep0+3AyaQrduxCf5Fn/KpFiRDR2DlhJHJ7ZEGl4T9Hkmmm5fqpKyjNkmsskrRqCv95LgBpbiUlZGt1qzh+TBkzG+PwcQOYUqmsOy2+NbHrxakdF0VI91lCJ9muEcAo5cLPfZRVgH/AVR5jlVIW9v1unumhKUSw7kD3fRVTQTr8VCx8jaTZU2P2e5p97rCFsAteW0lfu4SLZfxAaH0EyGji+rKOV4wO/fT3qFdb4X18JwMrf1X3oTEu5djsAgMhpINZcdRy2JqWtfTmwMDsN0cZQFdkGVClRj7OHodgXpV4lDAKmbEYh3DfaLeM0O6YWEUKEp1lwaL8NVOh4xo9Y5ttNVWUTwFi4dH0rBAltsSdecv4gnpMVeZ3vRfqJ4qajG7PfDRrz9OP5d20kPy27i455nwBQ9JAII0gfle3hP2AEnFEIiRHlmyXpeZRX/HIURxO9ne8LyyTxcPoRU+Ngx6ALlfXY1orMcMMN6vn1sJqErS5CultcpqFfyFKvtnXIXUUIf/vhFCxjNBCKVY87yl8+UBj165lglyqm22oIY58R3J8VSLaDt4lxeEZlFA3cTgwY+/whsZ8NwVtx1OdXYLrurDV8ZBk0ETxX/4OTqOwBOgAkOtiEn8Y20VfVcAd/plnK1ADma1o9p4+P2qTdFFYe9KQvXZAEapRkACGPuWjOGSXSDN/A==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(54906003)(508600001)(83380400001)(36860700001)(110136005)(8936002)(36756003)(70586007)(70206006)(8676002)(4326008)(316002)(5660300002)(1076003)(26005)(6666004)(2906002)(7696005)(336012)(47076005)(426003)(186003)(40460700003)(107886003)(356005)(81166007)(2616005)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 11:12:26.8097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d187db-18c6-4501-4894-08da2f514db9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
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

Request to queue the patch series for 5.19.

---
v4 -> v5:
- fix warnings on diabling CONFIG_ACPI reported by kernel test robot.

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
 drivers/soc/tegra/cbb/tegra234-cbb.c          |  833 ++++++
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

