Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9046E34C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhLIHmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:42:05 -0500
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:36832
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229787AbhLIHmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:42:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4iOLQi1oT7p4ZVhRDhUeM1EdiGjYRlIiuB1Jn8VXVcxgzcBO1UrJl47ZnqxU169hABvmrrA1F4jdbBr3i/fpQSpGgHsfJmLBYfU6HCxZF7FkxOtRlnDmRjL0L99NnG3ovv5ul6iHK05+mEUlBvCQJUrfA6eOJYExG2gb4c4euVmSPHdK81ZafKIBl1adFLx0JFbSgQu07+XCW+oaFF++nS7PddIYsUi2ibCVkatKvkJ9LnYqxz037nGvLgfrgK4kpilKjU2pSL+tqJRQvtOyXzL6dxL5GrcP+osvGfOi4j3uFY7tcWPS3XXN5BTDobBHnxOpvXSNs67OYuX4FImqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frfqYP0l1N9nP2wcQD1OuVIaQVqdXndKoBWugpJA9qE=;
 b=cjjI+f50nMuYHx5Zxf5diT3swfdR5q4kSM8O18iVzsQtWL+M79nfv+2BH98OTlp9aqdSKYin5lAOLOjG5f9XArA6HgWYkaIvD9ctx4/r7MvTWyvVZEyD2geVcvwClAYpbAsEPllpxDKAh273+rhI06RIAtcRdJH6YAfVFXPGS6ssJgB70PgV/8xCqq7RHJI+MdSCd7JQZYVw7KCQpjJREZ+lwGoNYcNqXCG7nqvn+O2uJku+WAjYqc6s/uzrIZWhD9LaF7Udmb5gLNroczaQ/snHPrA6hmoi7Xtm5gdp7kCMF99+d71znupselvvRVrkGoCsqdE2UbnIoG9z3DPPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frfqYP0l1N9nP2wcQD1OuVIaQVqdXndKoBWugpJA9qE=;
 b=HrIt6H4oT+FdFn3KTKzbIgA6S4GYoEKitfnmOnczMCu36HZBGlVDAdRlREKG1no7uC5BJLHJ2RVAd05mg/SCL02ItHP45dBDsKM86ik6e1Fb76kqWf+BZpzNv05tS1/66QW48/zWtwLIQXydZBX5e0ABpN6cdJvSu6CIiVKSw8qoUQN8t8NQVPqaQOPERerYe35H/q71DwITBPwU1noz+HyWvr5cjlHC/IieGG0zSwYzMduBVtyuQuEWT2UBKUIHLosnHnYcOTwIDpwiAAa+DHtIPNfkvnj5Ok0c1Y0k5txUNt1qBT3c5RAPb8PqLb/eLbY6VAHw6U9e6SnE3EU1ng==
Received: from MWHPR12CA0032.namprd12.prod.outlook.com (2603:10b6:301:2::18)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 07:38:28 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::17) by MWHPR12CA0032.outlook.office365.com
 (2603:10b6:301:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend
 Transport; Thu, 9 Dec 2021 07:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 07:38:27 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:25 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:24 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 23:38:23 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Date:   Wed, 8 Dec 2021 23:38:16 -0800
Message-ID: <20211209073822.26728-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7ec6ac9-cb38-4aa7-27f4-08d9bae6e42c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4045:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4045258DFAE2D41B3B180359AB709@MN2PR12MB4045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfqIOElDNWpKyBgQe+wfDvfF7YmKPS5/oIuZF48nnJabsz0FZe8w4MJ2oVeKa/mh5gVFsSAH24EV/SNGN1xMA36SuUjaJIcjurwEgLC9jnYG0Jif0cmalSRvFn+3vuG/Uwjs1zGhUZqoocTwDk5wAOGRODYwNnOj7w7Hs9i2rAPkhCNrhtGWbYuRAfTgNYqvqTbG8ibnX8i7/3OhfeT5i2zRlpQ6AQeDnyxI4FSdIgIjB2LSPtab3UBrcOS4ew6NhlYcEuZghaLpwZNPQ3SLr1LZgPfI5tfReoTrO8kGyDLc2HTbY6/wLrT4b8TmoQv7QvnO75iCnJnEy24UV8/kEHga7CCGC5bdBEnSg/s8rP/XwPSvVphODxSgNapLU+L6fTZgxCnfsCQnvb4CkAuMLyUoadUYm0UP5EEyg8D3oh4neCbpyC+r0QV6R2/U5m2BA6Btiub7154GXsv+4qvKvjLCqI/J/7p6d7QwPN/8ftBEpBM3WrGaXUoagMELXqi7V2wMcJ1f8rZzanNTV32YX9cM4Y+6F98DsLAD5RwNZDIwy1w3no38p8ruNgWYH12ziMwRzDelDOB+BOGEEndznHPtXOMHKKlXXMdhbWxFY7nU9GJcHopwWcOR1nyio9g1Qek+FEeHw5dGST/734J76hSwbZUquXgvoMgA5tV5pnLzXPKeXtltqmyGR22je/1QyUJssJ5CKcqu1W9TogVbT+d9sJgyZLl8vObNsLHwmKr+aFay+xwJdYfeAarb/W+VoyRToxNAZl9Y33N6VKTGJalEVT+Obb1YUZcsPZMxZv7k4LLvCrtwylXNsh5TFQhORAZ2mAXWaXvYcIiJgmVIDrAOkEWvDdaR/hIsSKptni1grZgmhQ9rZmmHFrEzsbD9ovkNPmcviPth1mNrAYvoGiwGVzIkva7ulOTkEO3Ffl8=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(4326008)(356005)(86362001)(82310400004)(40460700001)(110136005)(2616005)(7636003)(5660300002)(34070700002)(70206006)(70586007)(36756003)(83380400001)(36860700001)(966005)(508600001)(8676002)(186003)(426003)(336012)(26005)(47076005)(1076003)(2906002)(7696005)(54906003)(316002)(8936002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:38:27.8891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ec6ac9-cb38-4aa7-27f4-08d9bae6e42c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds a new mappings node to debugfs for
tegra-smmu driver. The first five patches are all preparational
changes for PATCH-6, based on Thierry's review feedback against
v5.

Changelog
v8:
 * No changes for PATCH 1-4
 * PATCH-5:
 * * bypassed "group->as == as" to fix KMSG bug reported by Dmitry
 * PATCH-6:
 * * changed to use u32 casting for IOVA outputs
 * * squashed Dmitry's change to list all swgroup names in the same
     group_soc since they share the same as pointer
v7: https://lore.kernel.org/linux-iommu/20211208084732.23363-1-nicolinc@nvidia.com/T/
 * Added "Acked-by" from Thierry to PATCH1,4,5
 * No other changes for PATCH1,3,4,5
 * PATCH-2: dropped "s/soc/group_soc" change
 * PATCH-6:
 * * avoided forward declaration
 * * dropped castings in pd_pt_index_iova()
 * * used "'-' : 'S'" for non-secure attribute
 * * changed multi-line outputs to single-line format
v6: https://lore.kernel.org/linux-iommu/20210915043806.GA19185@Asurada-Nvidia/t/
 * Added PATCH1-3 for better naming conventions
 * Added PATCH4-5 to embed previous struct tegra_smmu_group_debug
   into struct tegra_smmu_group
 * Dropped parentheses at SMMU_PTE_ATTR_SHIFT
 * Dropped swgrp->reg print
 * Replaced ptb_reg contents with as->attr and as->pd_dma
 * Added "index" and "count" in the PD entries for readability
 * Removed Dmitry's Tested-by and Reviewed-by for the big change
   from v5 to v6.
v5: https://lore.kernel.org/linux-iommu/20210315203631.24990-1-nicoleotsuka@gmail.com/
 * Fixed a typo in commit message
 * Split a long line into two lines
 * Rearranged variable defines by length
 * Added Tested-by and Reviewed-by from Dmitry
v4: https://lore.kernel.org/lkml/20210315033504.23937-1-nicoleotsuka@gmail.com/
 * Changed %d to %u for unsigned variables
 * Fixed print format mismatch warnings on ARM32
v3: https://lore.kernel.org/linux-iommu/20210315031530.GA15245@Asurada-Nvidia/T/
 * Fixed PHYS and IOVA print formats
 * Changed variables to unsigned int type
 * Changed the table outputs to be compact
v2: https://lore.kernel.org/linux-iommu/20210312010932.GB29926@Asurada-Nvidia/T/
 * Expanded mutex range to the entire function
 * Added as->lock to protect pagetable walkthrough
 * Replaced devm_kzalloc with devm_kcalloc for group_debug
 * Added "PTE RANGE" and "SIZE" columns to group contiguous mappings
 * Dropped as->count check
 * Added WARN_ON when as->count mismatches pd[pd_index]
v1: https://lkml.org/lkml/2020/9/26/70

Nicolin Chen (6):
  iommu/tegra-smmu: Rename struct iommu_group *group to *grp
  iommu/tegra-smmu: Rename tegra_smmu_find_group to
    tegra_smmu_find_group_soc
  iommu/tegra-smmu: Rename struct tegra_smmu_swgroup *group to *swgrp
  iommu/tegra-smmu: Use swgrp pointer instead of swgroup id
  iommu/tegra-smmu: Attach as pointer to tegra_smmu_group
  iommu/tegra-smmu: Add pagetable mappings to debugfs

 drivers/iommu/tegra-smmu.c | 345 ++++++++++++++++++++++++++++++++-----
 1 file changed, 299 insertions(+), 46 deletions(-)

-- 
2.17.1

