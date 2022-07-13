Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9FF573FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiGMW5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGMW5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:57:14 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C98A4F66B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCGiOC7Pjn+BOcgAJuvhktzVzh0K2ahw5y2U7pBZGcxWs9pULBFUcGKNolV5USXIUltf/AXL8j3GqiXMt+J0RTW0ZZCU2P+L3Sh8U0FWTNT+i+2Dp8znSvRnTz9FLfpBO/v4qb/tw2OS6rd56zVWsMnFUXYeNAVcZFqQ5mBtkebFV7IxRvAz47b5NO13ESu3bdDzhWt2E5keg//7gRHcXAlFWbBJK8zCsIXkWWkJWTIywGeaXmdQIb0ABeCLKoLgRHst7YUwtQhyTinI63fSDfzjgxrmLReS5S5zRy9l9dGZSicmlyJ6fT9chq3l1rYYUwrKRsSq8GnllIUeSnLjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B845tXD9xNEzOhDIFySyO2d5TZVXPQwOdLU4a6VXwEM=;
 b=NTIy8ZRRIGyb3Sp6rqChv0AbMXmtzxqRhShuDXw0+gEhXoPAUDVpms65v5CeCd4y0SLkXCI+JalDWwbeq83eMQq23pI34YihIF2LrOnP0O3mdPm5bfwuUEF320jjb9pUfckvu0W26TVE7Z6ZkLNurNTPMbsojw588rGS88hIymEsP3jTlf1hAPaq/CmsDLdnAyawf45+A1B3lORQLiADRWDqqoPzqsUkLbe/A/R7eKZcHqB4TuYGJpxhuChPst8IFEsQ7UqVwXrfdoKlwOt6h08e6hRna7KcjtE0geiPm5AjzOQH4myrGac1cGKUxFmZxlOhYi2WRZoeFi2xd4Yb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B845tXD9xNEzOhDIFySyO2d5TZVXPQwOdLU4a6VXwEM=;
 b=0qViuFZ/kNCNIA8QNQbS8cwTTwd6KVvbJis8978RPWOTMurklJHksdh7S/cYVJT5Rc9+15c47M4x5+jt4rHW2daTPRn71Z6h5PiTZyUHpa/hpi0ILD2QFnV/b9Wr3ALb+tqBbgvQ3TGVYcXfnrUeUugXz0sMWzZoE3ImkAj0Qi0=
Received: from BN9PR03CA0511.namprd03.prod.outlook.com (2603:10b6:408:131::6)
 by BN6PR12MB1265.namprd12.prod.outlook.com (2603:10b6:404:1d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 22:57:11 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::5e) by BN9PR03CA0511.outlook.office365.com
 (2603:10b6:408:131::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Wed, 13 Jul 2022 22:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 22:57:11 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 17:57:07 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
        <ashish.kalra@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 0/9] iommu/amd: Enforce IOMMU restrictions for SNP-enabled system
Date:   Wed, 13 Jul 2022 17:56:42 -0500
Message-ID: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88eabf3b-7d9d-4a46-43f8-08da65230534
X-MS-TrafficTypeDiagnostic: BN6PR12MB1265:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RS3s9g5aIJfP9gZZahFWBQQ3JzQZ5HmR/Fau14/wNIJMYIBp7GdVSMV6xEe9kPTQF1RZoNgdI8KWgx84+Vur2EBGTv3ZtKJ44WZMG9kUwmDvhr/UvYnoaDUrsZXxINhYfqk4jQvaJyKm4pzEtpb7Ff5rzeU849I01d5rEO5KvOLbsJyIMroafpWErG4XJbsXKbaUMOmM/GZ5bm47IgwxPqtjRTw94SYpmCBhFhY82c699gI58Q5PIAlMjaShJnWpgP/bq5uiJVmmb4Q/GL3kF3TNvvC9FZAQrRDGJ6je2W3js2szv0/lIvHWe4/Dc4orGKob7qtuWC+9BUdr57T2Rnh60GfZIvRvWP837ooHZC0rSBjZw8R7C+8Ii43vyylauIdsovMT/tpQKrdewicWx1q96Rr8Bx18ZGGpnYhrp+xdxJF5z0C3gm3JTj566h9q/uveejogb6q6UJcLBhSxtOb7mLZbiaS58yrUxlGaX/VEkshAUNy4nP6vGvoH0PFMhrx9KggqXbKQ5/4uP/rHHIW5oGeIyz8MkB1SGFNA7dYX3Y6L281YkY/EoLZ4EFxB7lNDRGadn6AphzXIJeyKdsK5JYDSuqdjyH1iP9+4D7Ck+BOH983yr5l6j9EHHGrp6fJTaU0+EQLqn34MNFwDXSkvChuAA8TTYAE83Aka7ryoFTfgXkpXCGA9Qv3JMatf4d7mkOVzWVuMXh0DzhUUZQvXd6SFZjtKk646T+CuB7XBwtoqOb8ccJ0jJhEZoJ1aBkTmgCPQwVkz3kJMd1FDpEi4IuI7GDymkDKkmcb1vYohIjonebzPzUO6KS76qonOkSNWiu0Y3oSIe2vIov0uk99F9qgm2LdCiwpHGSa9nB+qij/aImc/v7h1uh6NOHhK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(40470700004)(36840700001)(26005)(41300700001)(7696005)(6666004)(478600001)(1076003)(8676002)(40460700003)(70586007)(70206006)(86362001)(110136005)(82310400005)(316002)(54906003)(83380400001)(4326008)(81166007)(2616005)(36860700001)(16526019)(82740400003)(47076005)(336012)(426003)(356005)(186003)(40480700001)(36756003)(8936002)(5660300002)(2906002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:57:11.1293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88eabf3b-7d9d-4a46-43f8-08da65230534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1265
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support the new AMD Secure Nested Paging (SNP) feature, AMD IOMMU driver
needs to be modified to comply with new restrictions enforced by the SNP
feature.

The SNP feature detection needs to happen early in the IOMMU driver
initialization, and the feature must be supported across all IOMMUs.

To simplify the detection process, this series introduces global variables
for tracking IOMMU Extended Feature Registers (EFR and EFR2), which store
common feature bits across all IOMMUs. These global variables are available
as soon as the IVRS table is parsed, which happens at the beginning of
the driver initialization. Therefore, they can be used for early detection
of SNP feature. (See patch 2 - 5)

Once the feature is detected, IOMMU driver needs to be informed when the
feature system-wide. Therefor, the function amd_iommu_snp_enable() is
introduced in patch 6, and will be called by SEV-SNP driver.

When IOMMU driver initializing the device table entries (DTEs), care must
be taken when setting up the DTE[TV] bit on SNP-enabled system.
(See patch 7)

Lastly, an SNP-enabled system requires IOMMU v1 page table to be configured
with non-zero DTE[Mode] for DMA-capable devices. This affects a number of
use cases such as IOMMU pass-through mode and AMD IOMMUv2 APIs for binding/
unbinding pasid cannot be supported with SNP. These are handled in patch 8
and 9.

Testing:
  - Tested booting and verify dmesg.
  - Tested booting with iommu=pt
  - Tested changing the iommu domain to identity at runtime
  - Tested loading amd_iommu_v2 driver
  - Tested booting SEV/SNP-enabled guest
  - Tested when CONFIG_AMD_MEM_ENCRYPT is not set

Chanages from v3:
(https://www.spinics.net/lists/kernel/msg4409539.html)
  - Patch 1, 2, and 5 are new.
  - Patch 3: Modify to use global common EFR/EFR2 vaiable
             when tracking supported features.

Best Regards,
Suravee

Brijesh Singh (1):
  iommu/amd: Introduce function to check and enable SNP

Suravee Suthikulpanit (8):
  iommu/amd: Change macro for IOMMU control register bit shift to
    decimal value
  iommu/amd: Introduce Support for Extended Feature 2 Register
  iommu/amd: Introduce global variable for storing common EFR and EFR2
  iommu/amd: Process all IVHDs before enabling IOMMU features
  iommu/amd: Globally detect SNP support
  iommu/amd: Set translation valid bit only when IO page tables are in
    use
  iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY after SNP is enabled
  iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled

 drivers/iommu/amd/amd_iommu.h       |   5 +
 drivers/iommu/amd/amd_iommu_types.h |  46 +++++----
 drivers/iommu/amd/init.c            | 153 +++++++++++++++++++++++-----
 drivers/iommu/amd/iommu.c           |  24 ++++-
 include/linux/amd-iommu.h           |   4 +
 5 files changed, 183 insertions(+), 49 deletions(-)

-- 
2.32.0

