Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54044FEE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 06:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiDMEUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 00:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiDMEUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:20:13 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D827CFA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfawpoyPrJ1Eb00j2Pm9pvyHFN2oQV4/1/Dwk3tex3E4KGVy7XyEPWGEH2VHgcsH0Bb1zt2PKRRoNxltfV3AraOYwyESP6eUljQgk2tNDMd7IX23dwvz5CIo+W6RYDANkCMVPvVSbCZ2Rr2vkiaFylmzoBsTw4/+NkTXXujqhBSK4uLrSjSdbe3GWbdhrzFDkRYTqx+2irMc3JSUXmQt8NRuvBpbDbThQ2y3GtXQYRgBU41eUOOTeXToCTJOWmtuKVdNX4ttj3B2y0acyrqwMOYYLoyFQyj1dilFd3Frdh42/UcAZk8pg6B+dgEiKTXDBi1J61ClbiU0DMAT66Eb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dixg6jFAlPeT+UGDhnY516ejVCvmVQWOWNK9DlYnwdM=;
 b=avvbg2b0uzkZ00OMdkCJ0DfgzZKORtVDUgA/bNmnn3/OPU7J9XC+Il/Oy1sCB9AocaVkw8oFzTnzUMwE8teZFg8h+92+NiyPADrIYlYsEHuoEWpafWVaJLikh8lShcn9iyGwOP9ZypFAwz+eptA0vf/BtiF8rBmgrYY7Zg4X/V5wnojRucWYx2ufxfDWBU7RYigh+JmbbxsapWwRaB9/jqYFTJPX6NSAhS6TWyXFlZoeOqASyHuyhzwPTagIqFazSAgZ+ABaZpbLw/qatWcIDmhlmZH9ZlCQdpmHSFKIOLsy5PfglX/BPLp1xFFh72GhnuqQ/uNPShBPjSC26U3gBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dixg6jFAlPeT+UGDhnY516ejVCvmVQWOWNK9DlYnwdM=;
 b=ALoILaBdo34QMf1REYocrqxDEqkqIITz9Ao4wZ6l9UHst1kqjDt2GNLqK3U67brIpmzIdbDGs0b0cyu8kl0kukkzcOoeSfCYVPh3L+JFcEPCtCNvXw+1aADC5s5yR8cwQDLgFW/nVILX7LBQLq2E1TpE32os0Win5rHh2AD01JLHlzSh5VMh752lD64ev2ywhEZTqkk7iEERjoKa/+Z99Gc1ofxP16oF6FJ8kI7K/AmucnGAGF1JADF80FWQk+2L4kYEFSVSXDMnUpkmFWbPUVYDsJgh5cYomyOaEGjTycGBULy1Q93YD1IAntR7lX3168XSkzUiYJkPXNvuhPxFRA==
Received: from DS7P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::21) by
 MN2PR12MB3149.namprd12.prod.outlook.com (2603:10b6:208:d2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Wed, 13 Apr 2022 04:17:51 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::2c) by DS7P222CA0028.outlook.office365.com
 (2603:10b6:8:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 13 Apr 2022 04:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 04:17:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Apr
 2022 04:17:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Apr
 2022 21:17:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 12 Apr 2022 21:17:49 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <thunder.leizhen@huawei.com>, <jgg@ziepe.ca>, <tglx@linutronix.de>,
        <john.garry@huawei.com>, <jean-philippe@linaro.org>,
        <christophe.jaillet@wanadoo.fr>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Date:   Tue, 12 Apr 2022 21:17:45 -0700
Message-ID: <20220413041745.35174-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a23d60f-b60f-4172-d852-08da1d049379
X-MS-TrafficTypeDiagnostic: MN2PR12MB3149:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31497ABF1E558AF1AA7957DAABEC9@MN2PR12MB3149.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WpPWD7KbqdSdvS+DyJn1aA8mNkO4TaCz19zotjPN2Lkgu8XH4KaT0nuRWMZu3RKq+W/i/BUfLFgTULGVbCmKoGERK4I5BVyDo/HSLYNBXeOzufIorzG0nZY1qTcQKU87IUyV1X2m8XzS946RyEMQ9RBPuLYsBJ/4cApm6p32tsD3QTFkAMenIXixICWNP3Y7h3vWtqqD+6VKCRBJ3U5/0CE4bi3rUAkzB+iycLfyTMrua/ASPccR5fT3pJBVwJsOVECuoEGOwpDucdr6N8V5qKRqchyiK1Av7sln1zMIpYt5Sxk71d3l+o2givwJ3Sw238JhNxOFIVLXJPALQMKX25684KXhBS2bTfnbm9X0wc/7PDcrhhGt3viE67rb28N4dTetpe7ExWTq7nZvcdyOPRL58nXLjDo0uDYgNT2obTufAJAxf1x7T6a/c7tCijUkLO1ytzhOki9Kf43un1JuAGZW458t6LUcuR0IxQKElbh26RfNiUlafBPIsGvorBF3o1mVpfm1qNExlHr/0PCIUaFvviR7hFYYIwtXUN1P3uEXneEyAhHeZudSGz6FTyBGn07K+l8YBIMrsLgCfvarCl61aftebERnn6UdqoWJIc/0z3a8g2ZtOyEeAydbtSzdi8pGPClGGnDAVeclu9uu8fqZfVWq+ku+OEc7prB0UKx6iWJp193k74iDT9UOjyJZ41bJlYYBLWppALfvQs44YA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4744005)(508600001)(6666004)(36860700001)(5660300002)(316002)(336012)(83380400001)(47076005)(356005)(36756003)(40460700003)(70586007)(70206006)(86362001)(82310400005)(4326008)(81166007)(8676002)(426003)(8936002)(2906002)(7416002)(54906003)(110136005)(26005)(186003)(7696005)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 04:17:51.6407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a23d60f-b60f-4172-d852-08da1d049379
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3149
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To calculate num_pages, the size should be aligned with
"page size", determined by the tg value. Otherwise, its
following "while (iova < end)" might become an infinite
loop if unaligned size is slightly greater than 1 << tg.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 627a3ed5ee8f..8249dad5ae44 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1879,7 +1879,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		/* Determine what level the granule is at */
 		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
 
-		num_pages = size >> tg;
+		num_pages = ALIGN(size, 1 << tg) >> tg;
 	}
 
 	cmds.num = 0;
-- 
2.17.1

