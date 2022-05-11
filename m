Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8836523EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbiEKURI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245071AbiEKURC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:17:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B9169491;
        Wed, 11 May 2022 13:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvWbjckRyb/cXRvT0SjSF2E5tBsUYudI0QV3Vkg46jepyCJBN26aK7Nb2GHil4k6K3G4eko6ft06cB1FRQXP3ivQpbFbWbq8KOmN9QkcEJUHgr0jDJM2s/6U8/9RoRzOIAaIh8iCHdmOpdnO6UJ9gsBJBEEmi6Lwvvgaio0+LiF+CkyoPTbvk5TrLNoJsb9kli5L3UuZNa+5Q1k9HoiItHzDXWFrZ3nq1J1bZ7eq/itU2fxRlb0Uy/Nt8A8SHoxZ4ELWRtvkga4HtwHKAASTUvpMT5TTN+y7VcvV1qLmsDUthV8sJIbxHnPWD+pscr/y77/prwE2xp6EqILyeuar9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu6UZjsb6WihpYGnIFYEYP/Mb7cSztH7rf4wPghUSa4=;
 b=eyZzs/M626wuzZOr/l86goENO6mOjhC/N3YgD12elaJO8SN+qDzz/9hM4p53L2Og4GAb8dpNReroXnndgvwrMbm3v4EjlIYSkIla/agA92/smgoN6DQg4HN7TtPthicXQkOhde1uVX3O84V2YK4i9S5dH4sRASt43ZHcIsEOX1b889FRj+i9EAGL73KB+wf2CE+YzGlao7jK5/P98USOMKp+PnJupElLs/XuPL19CVwziVPLUWvl9IypNyAv9XwzVWf3TPrmjttBg2+VvtKM6iD1exn+JBj22od8ky8E/XkD5lqPX1WiG+ny4YWBY/vC8u9OJMPOUiliHvMrcLyWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu6UZjsb6WihpYGnIFYEYP/Mb7cSztH7rf4wPghUSa4=;
 b=HC4yxJ540MoQIRg3zXUy7LA6GVhYrSY1k78SQR4GW3PRWDub2fXATtFWP9tnwfbcQMqod0P1BuKOGNweP0dWdvQPTRuvLxSUjmpFAN93ovLE8ograZvixuZxig2YLyds83n+KuqyQfsYhuniiw7gvdEU5SDzg51R1mUIMNS5gHcWdONb8EBrYS5kQVWP/e3U/RiLxZ6C54sdtqnGdo/tHhCXlpTy2HrblPNFTJYdNig2efLg217hie1B4HvVtHqktSH5IoUoUq7bxbCnM+VVLGvYMpkMtra/Nhu4M/wbcPjVtAzUuCcRB3N9AjeBK8YaQFnU4bAVGF8e8qFJxThVBw==
Received: from MW4PR04CA0231.namprd04.prod.outlook.com (2603:10b6:303:87::26)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 20:16:59 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::17) by MW4PR04CA0231.outlook.office365.com
 (2603:10b6:303:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 20:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 20:16:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 11 May 2022 20:16:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 13:16:58 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 11 May 2022 13:16:55 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v6 0/9] CBB driver for Tegra194, Tegra234 & Tegra-Grace 
Date:   Thu, 12 May 2022 01:46:41 +0530
Message-ID: <20220511201651.30695-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae6f8438-f2bd-4541-ff92-08da338b340f
X-MS-TrafficTypeDiagnostic: MN0PR12MB5788:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB578824943079B576B6032E1BB9C89@MN0PR12MB5788.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08THanSWSlA5AAE25tuFX8Cv8xlrNH3jmtnBZoAdiIeZtCcpeQ6yAxcjEnzFT3cXd8OKWktBvgSLxebcmiY2JzwFQn2pAHygMMz7LvMNmeRBVWLHl5VJvjexfpislJ7ceyu+q0xLUjjihKH17r1DikWbwsL4DmGyCfK7tezLnpUkeiXn3js3H2+KcaAsMVRaKZTAJfSvhcGOJwfyUAiXCUrMfEjT+WKMbzIu+7U2OBhlZ1XFTloucANYI6nNbOcARS9u+wWHrvX6IXYdpfkpnX48Ok0YBpT/8J/dunhVC28C9x3auvcpTAKOT22OwNb0cCSCNcA+TiyFUWIWGGWhKIPnUMOqIWJln156X9i5mtY7ylkyj2Bl8JOIwF67W8H5eOj4H/EbjnHqTzmDjONohiXhNFqvgYzgQFPm8NQ66j9PFKa1JlQAWGY13uHJRd7WJRSD5GV/GLrghNPY/S5H60iwLFf8M5ET40zr5gMzdMWx5O55QchERORbpyNxWN6Bu0wLECjMBp1bHR8rqSqIIC53QvtLK6SG0sS8eMjNRQSkpFeX4uCKCOzMNpoxxpea5jeyF0+eKqWCztEPsqKTpUQMr9RV0aOyw408TzIkc8ZsCZV2Q0eeDq1z1JquJYDTez4PXvL27Sr8o3Z6lcIOQI5i6TcuEiRGZIhomXSeIzRWU8uycnUBlf2SxWxY/LAM2J3gjGMSjtlfWhGHLzWNng==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(426003)(186003)(107886003)(6666004)(47076005)(336012)(2616005)(1076003)(4743002)(7696005)(2906002)(40460700003)(26005)(5660300002)(8936002)(508600001)(8676002)(36756003)(86362001)(81166007)(110136005)(316002)(83380400001)(70206006)(70586007)(4326008)(54906003)(36860700001)(82310400005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 20:16:59.2343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6f8438-f2bd-4541-ff92-08da338b340f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
v5 -> v6:
- Minor changes in yaml files in patch number 2 and 6.

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
 .../arm/tegra/nvidia,tegra194-cbb.yaml        |   98 +
 .../arm/tegra/nvidia,tegra234-cbb.yaml        |   74 +
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
 17 files changed, 4421 insertions(+), 3 deletions(-)
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

