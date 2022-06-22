Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13215555218
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbiFVRM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377185AbiFVRMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:12:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF90205C0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFrB3fnyd6V2PAmF1l55kBCo/QECDTDpABeAujwnIpay3/+h59kOj1P1l51Tu5P1xMiamKuk8TeXjaFaZMSBOz7imkr0dvc0Whtm5ISiFkXKHHAg5LY+9l4XA5Urb7l2cGsAkIahTAszNcEh/VAZjma9W22B8ib7TUQGDG3P83LtOnW7IDLPzUdbXSYtJKw3cybPNWI6T7Bmzb670areWvMrg4xaDPGm8dcMybyIRmHvRMWP+mq61X1TmbnkEArE0DLntV25IGpLLK+NShp/ia74vevg8iiM0P93fTeaaUvHowOntmJOpy3+PxP3hRsQOAU1FyPtS+zRHeqmZKRiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTnSXbThQzaWjlAupvGHgLH65XHqhB+ra6MPhMFTkno=;
 b=i8jgKl+pmUh/pWMybBeEDcEwXBUmZ0Z+JSyV7u/Qinlovl8wT+hqsY66kd3FM4TzFmk2aG5u4kofBaDf3GM14gwrFMU5Rzt0oOrcUQ5qo8aH2aOYVVIHhoh9fTlDF044Vx+9amiBiOMifU383pCAXJ8dR5OJiMiGKZjNnu+P0Cd2CcKFmBht4KmHBDHmvOcC69N5GNwUz5uJ8v0UO/xaGm1xSuvuH4IKvrSFaP4eLZxzNG3jC02P7lzpuKvbiyuriSOfoRxOhDl5n9wBZfszcv85Gw6F687h+PjrWz9A5P5YskMTpApfkZ5YhbaqZOxrCSyBdgcXl1N7qQmKw01+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTnSXbThQzaWjlAupvGHgLH65XHqhB+ra6MPhMFTkno=;
 b=qC6Feq5ciai2EDMklFrOo2lmL46TdpBwQ6AQWLoZn/BzX5PKYbPWZTQVLG1iz89weXMLUcyJ6LXzz1X3rCKEpAgvogoYdM3KTiq6suX4VIaqUh+ZfCaIhrJvpCCprj8DE7ditxdGcsffGr7ael0sesfhXuVp9Z/mxy82KP/tFUQ=
Received: from MWHPR08CA0049.namprd08.prod.outlook.com (2603:10b6:300:c0::23)
 by BN8PR12MB3570.namprd12.prod.outlook.com (2603:10b6:408:4a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 17:12:34 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::43) by MWHPR08CA0049.outlook.office365.com
 (2603:10b6:300:c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 22 Jun 2022 17:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 17:12:33 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 12:12:31 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
        <vasant.hegde@amd.com>, <thomas.lendacky@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 0/7] iommu/amd: Enforce IOMMU restrictions for SNP-enabled system
Date:   Wed, 22 Jun 2022 12:11:24 -0500
Message-ID: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bb67e03-38bc-4c43-d591-08da547265ea
X-MS-TrafficTypeDiagnostic: BN8PR12MB3570:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3570FE9B8E84084952B9CF0CF3B29@BN8PR12MB3570.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tu1Kd3p6sGKG7feK2kUIuAofk2RjB29OGrUYkEOa26BNL9qAvbmGcxTcY0rOC+ZD3Z/Td3IW1fpONbnb2RxqqJ4kXfm2rwJJjJ0HuWkj7zgbW0GBTtFxWnrpRXdmIC1Y2mq+lnAhHPJi+Lhax7hjRgJsVPh12vVajmtOcP54EdkgYWGIIakw3KdY691bkMavaRa6Ltxvk20APflM1EPn24VemyuHlZaw+IbXKT4cGIFkU1DorsqtbOU5wSac57eoFHGwILXtZ47Z5wRObjSM6OxPRiAEnnX+zznH5eVJJ33RlPHdoFRv0FBqI952RLu62uwkHqibkEvHlcNdP5bkMTEe5zYU68ttITFZeLse7/uPaht9oGi4JSSJ67t5AX4wcFkRtQlumZr71WQIEwvkBU6J8g2nN9tPftOPoc6VUTDhkWMXJq3J9ElqR38mCT46Q7stxMMSEp+jES5qHBePQhWQiVODDe8WHGPGg32RW76TqiySLi36eho2+VoJcOq0r/OnjUxM77fBqEQ9HU49Kmsucg720JMXU2u3CAjPalsjsSoGvA9CogS5dU3U4i9b0Pab2MR5ZSXfPTtynCO5jLLDE4pvOsElAYVe1woAwq2GTfNijNVEnfV2Py/XXHWHeSgGUQeNqwzurNrK+aQVPvbI/J6RDN8wzYNKJ65SR85KYnsowDr9VFmFOAZz0h14cykvkpgjx5x906LCZmVGAHfXSvyBvNu0BriC91mr57KL+CQjtum/fEEcUr8LfXxGgrA1KOcNTYuswiD+FDsAPabhCSFXm1GXbAnlHhL0jATjb7RydYQzJyVU3PK59cU1/Y/NJFrVKol4ToD78zCJ2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(40470700004)(46966006)(6666004)(41300700001)(86362001)(26005)(36860700001)(82740400003)(336012)(356005)(16526019)(186003)(1076003)(40460700003)(2616005)(81166007)(426003)(82310400005)(47076005)(54906003)(7696005)(110136005)(5660300002)(8936002)(316002)(8676002)(83380400001)(70586007)(70206006)(4326008)(36756003)(40480700001)(2906002)(44832011)(966005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:12:33.7365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb67e03-38bc-4c43-d591-08da547265ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3570
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SNP-enabled system requires IOMMU v1 page table to be configured with
non-zero DTE[Mode] for DMA-capable devices. This effects a number of
usecases such as IOMMU pass-through mode and AMD IOMMUv2 APIs for
binding/unbinding pasid.

The series introduce a global variable to check SNP-enabled state
during driver initialization, and use it to enforce the SNP restrictions
during runtime.

Also, for non-DMA-capable devices such as IOAPIC, the recommendation
is to set DTE[TV] and DTE[Mode] to zero on SNP-enabled system.
Therefore, additinal checks is added before setting DTE[TV].

Testing:
  - Tested booting and verify dmesg.
  - Tested booting with iommu=pt
  - Tested loading amd_iommu_v2 driver
  - Tested changing the iommu domain at runtime
  - Tested booting SEV/SNP-enabled guest
  - Tested when CONFIG_AMD_MEM_ENCRYPT is not set

Pre-requisite:
  - [PATCH v3 00/35] iommu/amd: Add multiple PCI segments support
    https://lore.kernel.org/linux-iommu/20220511072141.15485-29-vasant.hegde@amd.com/T/

Chanages from V2:
(https://lists.linuxfoundation.org/pipermail/iommu/2022-June/066392.html)
  - Patch 4:
     * Update pr_err message to report SNP not supported.
     * Remove export GPL.
     * Remove function stub when CONFIG_AMD_MEM_ENCRYPT is not set.
  - Patch 6: Change to WARN_ONCE.

Best Regards,
Suravee

Brijesh Singh (1):
  iommu/amd: Introduce function to check and enable SNP

Suravee Suthikulpanit (6):
  iommu/amd: Warn when found inconsistency EFR mask
  iommu/amd: Process all IVHDs before enabling IOMMU features
  iommu/amd: Introduce an iommu variable for tracking SNP support status
  iommu/amd: Set translation valid bit only when IO page tables are in
    use
  iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY after SNP is enabled
  iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled

 drivers/iommu/amd/amd_iommu_types.h |   5 ++
 drivers/iommu/amd/init.c            | 109 +++++++++++++++++++++++-----
 drivers/iommu/amd/iommu.c           |  27 ++++++-
 include/linux/amd-iommu.h           |   4 +
 4 files changed, 123 insertions(+), 22 deletions(-)

-- 
2.32.0

