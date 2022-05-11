Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB29523EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245071AbiEKURP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347626AbiEKURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:17:12 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0D9694B6;
        Wed, 11 May 2022 13:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnvFxY5DA08tY4EV9S70lC385rP1XrqI7RljShbbf6olEFM777kU9JE5MZXzbB0BjuC11Hk28qvgwseOmNRw5FHOYv/qrohNTTVxLYIBPjj1eZp/CjtHFCIAG2JHWMfbpTRH4JN2JBNUHN544oX17aFv4svS3MDQdhCx5vio2/avuU34l/+kl6Ef9YEEe0o+GoQxZTD2xKhKIFkQG3FutDYq+oHAMF2zNNSQcrMWFQQ0rCBidomLBXCwRftHN6LoE/RCI9Ege2OOtAAnw9Za3BzMrLXM9TusSkkSyN3t4vp/PhggV46pcwetQruxF3aLc2xULKtFA4GcqokhNFkPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu6UZjsb6WihpYGnIFYEYP/Mb7cSztH7rf4wPghUSa4=;
 b=Fpt140+L+xznwgzVjAqhzdYz+XeIjupLx9ukx5f/NAVlX47i8eBS6n5xNQWOJlXR7I7WZ3EMoRXoxglFyFR0sTMLpDGLRrWFUqk9efxFeoz6P64yaXqde/kqZQh2XdNdmWTQP4X5Gzf12p0xOg4NTCDsnGjWOjjncrnzjudCGnleYSMZYSXcCvnGxwHCXQiq2JQqorjM3RmRZQPiLI4lynwT0s8OMqn8FxWu6KHDPHWMd/HH15tukcVGBhYmTUmFTXxj+e1+8iNA5q4TMVsc3kNxjFdIsbiEsp7tpTIeE5Zk3sTj6Fg2DQkTGlE34eW8jX2C/+i30dtHew1VCfxuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu6UZjsb6WihpYGnIFYEYP/Mb7cSztH7rf4wPghUSa4=;
 b=DjkQFWLnWCq2KX3w00+jAyPdo647xKXOu6UwLlA0tpgrpKfoZuo4JC3Oz0c3c28WtAoSc1zX9EexEnlkb20EOgEze5+0d11OUMlJiW6fppPvQ/u9sX4iEIIibNAEZQC2VLVhixJZgH+d3FXqQb4I/ARXpL2oQkYIlARYnooKHkMiOMwcR8pk86gysFGd6VGiX4wxo1cQd0+wlIVdW11PLsbMeEyTSI7uoKBnEhETYISTE1Kyf8XmIQMhJ2OFngrKH1yByFSR+R6W3WIo8VM62inrK6kR3TNsgZhwGYGv0KNHJ0hhwTrnClkoFFN8o7zKlz1UAKA+KouQVpLRtvMEgQ==
Received: from MW4PR04CA0271.namprd04.prod.outlook.com (2603:10b6:303:89::6)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 20:17:08 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::b2) by MW4PR04CA0271.outlook.office365.com
 (2603:10b6:303:89::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 20:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 20:17:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 11 May 2022 20:17:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 13:17:06 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 11 May 2022 13:17:04 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v6 0/9] CBB driver for Tegra194, Tegra234 & Tegra-Grace 
Date:   Thu, 12 May 2022 01:46:42 +0530
Message-ID: <20220511201651.30695-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511201651.30695-1-sumitg@nvidia.com>
References: <20220511201651.30695-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fdc7b04-e2d5-43fc-d99e-08da338b3969
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB257365798F0DC49E1C382A10B9C89@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiNzRs3+jmriUnwAnrCB62TodKg59FzafX8wn6V8XGazuRoa3Q+3KFMSAQMULuNo6fUv//19h+SM6armzeTFgRWHJi+XT0mMPHbW8Oc+qcMdNb93TIXw6TSAM3EVIFoRm0Z1qHafiXMG6qPgt4h43/S3WpUUjXN5euH3gwCAcGDOD75ZXHgKZ6/qnzWu7/Tvct1DojQmjpyBn32raq/CzV313UPtlRX7BRgGoYrYLKZURYSQtPth+kVjKOzpx4cSb37Tu8eEEjx1yRBYJblh9GC8R2DTEcmlUJvFFt0Fjl5ebCSNTBUAQJHjIzYUXgLWtJYfStB6bh34+hRym6lDrqRcsDM1TyS/c0mN1Ks8gQLlMamjMFpNU1s2miwDrMjT12LP6difLleC0BF0I9JNpmNSSdJvp+1tFUDh3hGJsI1WFwzg+nY+x87Crv+WpJ7c3wrzSiHzR0mpbSbWgqUFKQcmQzOmi3UdWX3t65YR+NmXhctInt5YBVJjeoJrl/75S4Ufqcp6EW1AV7JcoHLVXSc+S9yn0HXtObYhiL1r4eayisAsAD9SEGBvX+k/Y6fwW43LgyYhZLiE021W5jPzsTxqLfHugnS3dZ4btemqu81ThAg7TWfK05Jga7YU4Mi6hD0QcpxVEsZFr8TIRIrc7RIaxXJ+ZD45+kyWxxzBzR18IT+hkmH/zKDLqBiMcy3OGX1xxYuR/2uT8wqtZdCXRw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(110136005)(5660300002)(8936002)(86362001)(508600001)(316002)(70206006)(70586007)(54906003)(8676002)(81166007)(4326008)(6666004)(83380400001)(7696005)(36860700001)(186003)(356005)(36756003)(82310400005)(336012)(426003)(47076005)(40460700003)(26005)(2616005)(107886003)(4743002)(2906002)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 20:17:08.1961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdc7b04-e2d5-43fc-d99e-08da338b3969
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
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

