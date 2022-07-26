Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C858B58145F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiGZNo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbiGZNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:44:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78EE20BFF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LONd1uIyREE+8+dPGo0ujFv8ClgwGjdH0GxnmSUurYLA1Y27bbyr+ln96iH2lxubc1S1wK8qNCmwzLX4Iy7Kmum1F4gPnH+A7EZvZgbAE3UEmjI+PRqcGj1mhcOAdyjgyU9G0H3WodO29az4iLbm1oazlLg7GzR1bC+njP7uG5wT1toaGiLh4XweCHMvPLngZt64WWwE8KSJQpvR8T3rLmAKxC+tgQuPFGxZ2Vj+OILKsr3qxOTyWY/geqogn1It3bFFBO77JyzOlpJBlCQ4fziDuDkgCnSz6xxkk9jp2kUx0BlfpTy5OX0Fy6bQCytbu8OADKle8t7GuWQxzLkXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFUO6rD5sWn9rer/9DVgBy1kTqPflPZNm9DLgQZg3QI=;
 b=dyFcpJrWIfd8xkEjLXUF4TRMh1c+6LpNT/LQPlcBrNUQ9G2EQjogXjlVEw795CMtqAlQiWUwIWel04hZNF/wm6oskj1RVhpLVY5reQn+OWHjgwR6ySkHXzLnFOXixOnqCVtZiuXRdqSkybs/hf7obtyyWSlhQc5btZMfDgaD3RyxklUo8ERUk81AeKtJcCfyUAZQYdNvsKtCQXDAYfFqNLL+ZONP/F+U0SNxr0mAIRWX7gWglEmMScxM1LBXSzcINy6QtyWJHguGOxORoG8rlfBT2qzpeGjmTCL6SKpx2rHa2UMbbps4Q6JovSIY53Cn4DCHPIhr8Cg/ckil0EIbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFUO6rD5sWn9rer/9DVgBy1kTqPflPZNm9DLgQZg3QI=;
 b=oPi/tw6N04bfvXr041MbmV8XZxlJSZ8nhe5IOkyZh6+wFZZ+n/hRbNDDivjcvlBPXlTk0FzJdfA/tfptuBaoD5wakEGwCLlPAaUGEtZsQQYRyk20IOE2/Ji4hRk4ss4rZXRYrodbhTooqknTf1XvZqpFdhoJzQg2LAB2L6ZB2V8=
Received: from MW4PR03CA0181.namprd03.prod.outlook.com (2603:10b6:303:b8::6)
 by MN2PR12MB3662.namprd12.prod.outlook.com (2603:10b6:208:164::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 13:44:12 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::64) by MW4PR03CA0181.outlook.office365.com
 (2603:10b6:303:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23 via Frontend
 Transport; Tue, 26 Jul 2022 13:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Tue, 26 Jul 2022 13:44:12 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 26 Jul
 2022 08:44:11 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <will@kernel.org>, <jsnitsel@redhat.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2] iommu/amd: Misc Update for Virtual APIC support
Date:   Tue, 26 Jul 2022 08:43:46 -0500
Message-ID: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47c6683e-a012-4f41-c0db-08da6f0cec7a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3662:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxkv64beqCmvaFCy/9M0jjHMODy7Q9I4WpB/+BEviej1+dBeTEHBrGA699Snb0SeiVn2bzvEgLgSLEwX3I9DUQ4++jB1orB1M0Q7FnNK8/7VgaYQBNNbK7noGZhvgd0773wY+u2TKqwI3LirXxMLDH28ZkKprqaXAfiSUg/W0GPJXIkHUI/xUFFx26CYcyc7C/4kmNMg+beHQr/LzfNWqTZe0V8tqMmKh2IyopcOl7nGzCvCDFbCzn12+KENoQwYNupfvnosS3GbNOuxvJJH7atA+aHiKVyPDvk/zRxDZMJeFQFk7JLkhh6zNi03p79qtdAZ+MUvGRHmKLAqHgcxDxNmeWAitGGyIZoESivqwdqusRwom32NLuR++Ai4t32zuXhkdt8dxPLXqcLzBZr5KrYLr08M1qbacR7tySh0EW954N4Ynp1LahXooihcdVaOef/A1vspHpoA8D7WSvdaQI0Id6InsHiE6I+ZHBHE0dtCIfF/JOmvaAwK0OcGQYSGm7rWFzDpq0RoM2f0tjYk4eTtTDoF936wUSZNvHyCw7IX30HBcdQmOQ45Z+ir/cR6UH3HreAeZN7RBmj18wJuZMAj+EgoDWXHZ9fE/CK+qivj6eYIB/eYKMtHXQY9XftwxC9AE4RkSI55R2IhRtf1poLQHdFtffpGJWiS8b/fM5sNYovcdlkgC+Jg46mvrUTJQRrceg/hOuWJoiG6LyXJQQqXIiupUHyWBh/XndnrmX5YiLKdhn6KctJs5hsQULSlCpgJ7AFHKSoisG2dv3dF5xpWdrAE6eopQiovW25qzBwNMaPxPLLaSbc1ZgZyoWZSVPLOgu04qcaqg1tDRjizqaIigf7FAJjMfz6AIWyr9ZA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(8676002)(70586007)(70206006)(966005)(426003)(5660300002)(336012)(47076005)(478600001)(8936002)(4326008)(356005)(16526019)(40460700003)(83380400001)(82740400003)(7696005)(26005)(40480700001)(186003)(4744005)(36756003)(44832011)(41300700001)(81166007)(2616005)(6666004)(1076003)(2906002)(54906003)(110136005)(316002)(86362001)(36860700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 13:44:12.2073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c6683e-a012-4f41-c0db-08da6f0cec7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, this series simplifies existing feature detection and enablement of
GAM and GALog features, which are prerequisite for Virtual APIC (AVIC)
support. 

Second, it fixes the warning reported here https://lkml.org/lkml/2022/7/20/1135.

Last, it introduces new enablement for IOMMU to support AVIC on
SNP-enabled system.

Best Regards,
Suravee

Suravee Suthikulpanit (2):
  iommu/amd: Consolidate Virtual APIC (AVIC) Enablement
  iommu/amd: Add support for AVIC when SNP is enabled

 drivers/iommu/amd/amd_iommu_types.h |  7 +++
 drivers/iommu/amd/init.c            | 94 ++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 30 deletions(-)

-- 
2.34.1

