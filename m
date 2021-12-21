Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C747BFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhLUMv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:51:27 -0500
Received: from mail-bn7nam10on2062.outbound.protection.outlook.com ([40.107.92.62]:46944
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230326AbhLUMv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:51:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX5ZUFe4INfABwppXv89FZ2Wn8ZfGaOcVncqa0egsFaF/v90LveIL/fIyJRfWKYyW9RUvguc8EtdN7c5sYYY6+qX8SXDe+bcRnJMaFg2zGQUXzhu2Zlj0wHOtiqrINROCtRhqbqSAABDlPA49YFlmPODkzUizq9wW6v4K2ko33qmRNAV91GjgDsv9xq6McsCf5p0qrLjxeA8c7L2saLhbvPvBQTsuMp4RcUyppIdHX9CUV9YWwUBuKbj09ACgo8wtSAbECFXL8uDg76yUwGKQWBgoZFmzj/S9ZN9l6yPGBWDHbN2RLLUcTo0VQlHab7JJ+rdyrfHe9zuttbCrub1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM3s0tClgIfHJde5i0W3WZ7nP6OBct5uC85YwCY/018=;
 b=bgXzGRltgu89COsg6a3eO9Stk+YSJIbsKuobIkX8pGVW5UTXTzMV6UCmoOZhGrxtWdVWjDddM8mQnZZEx2O09+Gp/R6qXEZTIpTRIRIjnaC7rPpC4L/0UlqKG4Joj/zqEMoNEn6DN96Ui8O16+ZSgr9m82CPkW4fOSSeaQ0CrfvrTGK2k3MBAmA778a+GjM+oJbxdwjqnaJuHpBXp/68GYX//nGjyHnMPokkSjFPpUisnnqxK47EWSwuuCyiNvGBQXf6FEUQnoDFakmbMiM7YzU34M9E95S3aARu0J/yPCmYdOmF7V1ApFmz5FeRqFUbe+SATaGSmV0Xxgb4XaqfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM3s0tClgIfHJde5i0W3WZ7nP6OBct5uC85YwCY/018=;
 b=FIn3YXSbMVdI4cxGFcLAESHo1cvEuU11xiSUGEvT+W44Aq1iZXFX2yu1vhawMn4YkDzwsWcpqjbGhAHczQL+R8aBqLK/UDNFo4WcaGEttGLjcWv1kY7JmHHSHfwOTa2TLeQ4B4QVMTU2yqlXM3lZQfBvl3V2i4ByYdHkpOAnz9idYTIN/bYX3nRGgZlGDKQzHwDzvVEjfpw2um4l3U8HJcYLzZBtvTFsrc7B4Bt3uSQU7jdRn4Qu1J1PMKsRZtL17M19+RZOcWg706HLWS18TJkVIwY/o/EdUBZtG+j/ctfkbf7E4YWJEGaohHJhSKnr+k8KEH3YAEZMLk6x3O3qIA==
Received: from MW4PR03CA0103.namprd03.prod.outlook.com (2603:10b6:303:b7::18)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Tue, 21 Dec
 2021 12:51:24 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::f) by MW4PR03CA0103.outlook.office365.com
 (2603:10b6:303:b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 12:51:24 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:23 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:23 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:20 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <kbuild-all@lists.01.org>, <sumitg@nvidia.com>, <bbasu@nvidia.com>,
        <vsethi@nvidia.com>, <jsequeira@nvidia.com>
Subject: [Patch v3 0/9] CBB driver for Tegra194, Tegra234 & Tegra-Grace 
Date:   Tue, 21 Dec 2021 18:21:08 +0530
Message-ID: <20211221125117.6545-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caa522f9-3303-494a-9e19-08d9c4809879
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3895C15CD13F102B5A2B8BC3B97C9@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGDEMkse6WgHV3FnwfZPTqqsMStxThO/5pTJL1Nyo8cauXoLs8g4OnhP9H+HF8LwwpHPw+Cw6Sg34PJXik5I+aTZ2E4a3klSRr1A6cyT9Jaz/a1zB+Con2p0IuiMrouf8zmNGZ3SkYIpgVs5rkDOxM3cpNOP9TTJ/F8Itphc4bCrp8BwomfAly+hBgYJzPsT85ClL5ps22K4v72aT5GZgo7tBJlVw3ZS03cxrrTEozueeJLqkF6HnuvO+cmlYtBZUPnJsdphz8OMwoGVU8h4u89zdb+bc4TmXdkPSGhq6uGvHVgYoj0uDysJJie1JbLfac764pF+Y65dsxUFYHHaSTsEvt9L1j2kYVg5vUxxr+uk2DpbuB8O1B7hI2HDAE1RjPRizk9wUFdm8Isn+v9r4ppZLmplFurSLGQzNA831glTOHBvEVS1wA3HFscIQEm+EzYgfWs9VYtMiJOm9dzB0FIdQZatxkGiZAdXs6qpvX1BTNrZK2GVJ47a64/8zZX8jqi73/o29xJZSOrqj63buLRCptNRT1GTwTfqh/0lvQ/t+hWP2YwKk/m5Dl+JvGwE6aL11TeZzzlRFFalGs6DfVZ9jwC3dPgtOQrIfxLp9/a9nh2vd5Kuod6B0j7n7vNY0OkVTURQI+XhKEC606Tpq3cNCwpaSDic0Ys2Hc1VocejJtLNGfBvHvr5gWtuPcUrSOvmN9rFX8i/wwzKP8xy71r702SiOZyIH0Pn1mpldSD2WcfPA/SYteEgpGr8XG44Ml6NOwoJsAce32jbJHaf057xLaPEFES4QyWC2jVmYvgeJW7ITS5TfUTbLcz6Zwdfve/FXruoAiE/2bwaZ0otww==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(4326008)(26005)(40460700001)(110136005)(316002)(186003)(336012)(2906002)(7696005)(86362001)(81166007)(5660300002)(36860700001)(8676002)(6666004)(426003)(1076003)(508600001)(2616005)(8936002)(47076005)(36756003)(82310400004)(4743002)(107886003)(70206006)(34020700004)(83380400001)(70586007)(54906003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 12:51:24.1507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa522f9-3303-494a-9e19-08d9c4809879
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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
 drivers/soc/tegra/cbb/tegra234-cbb.c          |  829 ++++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   29 +-
 include/soc/tegra/fuse.h                      |    6 +
 include/soc/tegra/tegra-cbb.h                 |   43 +
 include/soc/tegra/tegra-grace-cbb.h           |  219 ++
 include/soc/tegra/tegra194-cbb.h              |  158 ++
 include/soc/tegra/tegra234-cbb.h              |  342 +++
 17 files changed, 4408 insertions(+), 3 deletions(-)
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

