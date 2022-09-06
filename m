Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFB25AED50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiIFOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiIFO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:29:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D38D90C6F;
        Tue,  6 Sep 2022 06:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwmcgaHosj32WcCXocjJ6LNjuLbCSv5VuY/VVqAkPvUZWGri5aIJ4rflrNwBd/LlyKAhrmS9dVDheeWRfgH07YtwrZs7jinktSXjFwNz3CWSvNwg3UcOjCHjK0CZaWzRQ9k5VQC12yL11xJb4NkMpULjOxaEPlMHqgb2Lq+h+jeqor7DMvWPNksG8jwqwLenrr1PsB/N1Zxlqpa6NNv2KhYi37Eiga9tslmOPUg9zTRzrK23gw6H/lpnQpNwTFYeTC6REFRPtd9tMmXf5VaZgqUCFNuA65TzYuE3ppyx+za9ay9G/7s0BVdFwWXKxxd1NZOfAgQ2tK7NbkiYJ5Xm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N47Nf/3XmUtQI0vjqs2VhVAY+i2L6i3w33rZ6Lpb+ig=;
 b=gzt+9IpmJiJVHia1r+4Qmex0UYxwsUToYjaCvGt8Dqwed0QPClqN8+w6DPySDemowb0cCM5AoMjC7M+XUk5MJZsSaeNeSdozWpsXSmPDSpeWbe7/7FGU1Vy4xoyeXg7JYHs+/rrgs49p2HYVQPN2zGwoAtALzZqMGdYV5gGjN5Gwv4SEAimbsC6C9Kbe2B520YOXgUGAruXLX/5U2xk3AEK5N760+OKykh4F4bsiLsRYxav9MvPOvjxAGY5wd7rddfUEJLpaNodFpJAYDWDUBJY2Ae01os0DOMj02Y6Q0zMCugZOH0k7nH45CX5SKV9GeNoF6KDJYXWtSt9chZUamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N47Nf/3XmUtQI0vjqs2VhVAY+i2L6i3w33rZ6Lpb+ig=;
 b=B/zc6kQ5XTXuyGSqv/or9IOuSa00FJsj98VPpWyOkWpjmYInbJzI+AkO3I2sVcjaGmSCheQu75Xtc8ukMICNbP0i9CiPARl60SoNAmv4s0Nrjf5RTEFCRK+5zZ0zbQn1u0dbdaLn3SE+YtDKZzXeSv0+H/VKwu0WmXWy2KMkwGAIUkQ5fVk0VVzbMKZctTD2lIZVhcmxt64BzQLVgnpU5ZJnLN3MCaffelTF1lAzHX0MO7L04BVADbW/B/Z+vl+B+5rzAc+z16M5EOJys4nhChs1J7E6x81F4Zt4hwxtHHQYZq74XKbNV7ZVFjPNg5FLMVYT/iKAn9F4BR9C3GN0ig==
Received: from DM6PR07CA0086.namprd07.prod.outlook.com (2603:10b6:5:337::19)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Tue, 6 Sep
 2022 13:51:25 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::55) by DM6PR07CA0086.outlook.office365.com
 (2603:10b6:5:337::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Tue, 6 Sep 2022 13:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 13:51:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 6 Sep 2022 13:51:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 6 Sep 2022 06:51:22 -0700
Received: from build-petlozup-20220627T000321362.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29
 via Frontend Transport; Tue, 6 Sep 2022 06:51:22 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>, Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH] soc/tegra: pmc: Check device node status property
Date:   Tue, 6 Sep 2022 13:51:17 +0000
Message-ID: <20220906135117.341529-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d35beff-be06-49ef-9132-08da900ee372
X-MS-TrafficTypeDiagnostic: MW3PR12MB4377:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dAyTuT5S62s6G2ELgbAJHGY5W9P3FdO7ymJ7Kz26pddwbRKXGMBpXNkWzYQQ6QOYUAJCzujbWWFLQ3zSXre+auqs9aKp0j3g3v2fYERjXr/Ozf7ZK4cJ0Szz97n6ifLOx4ocyXokOpE1GcJu8f7x/d8FqyEODbuWQSh4vbqAknJBoo2F9tyFwpZFFEdu43lHqxcRNm2lnge5Nc91n7RB2/VENicHCB+b5tI99v+qWUjAClR/+L1Fe13PQtOzmIt3SLR0UWWJt2B68O9q9XerYDSWLf660SDf3uK7iuJlW1H8qywk+3bK2VjyXDWMaqxdzep0Z+MTq+5C84U/rsTsbnHJbqrmxPZbljFnB2/X/qE+RDxbAt/nl1rnahmygFe7P4ntC/pJsuM30vrYIax9navuJ5RPK54yd800bLa9tF0ACuNNJzaS+3xngHaxOvqIGY4SiMvIGoSxr22whgxQxTdODsSoAJLPcM5wn26JiS1r93XKi1UI+Fb726xQuTe+LbLfFxiBXCTNUyzqzZC6WKjo5tBxfuash6FLyySFB5VVtyggtz0IYhTsJb/Gzi9LfIkV94+LPsIb+gdscz70rCQHW5Age+5r/uZllwcufRNNJ67CRfKfOPeRqUlT/z7VDIO7dfVudOYH51nThpbqIQsoEopAG+7DuXsB3t1GWDjC3O/doZuIFdHcA2iLL2O4IQjS1HQyXpySShIPBcWrPMM3ux4tdMbDAIiIFR5KMjLBv422tCCPFCumrP+Pwg9LIckuBLwoWkIYUOWe5JXhEDFH2linKwUfjXZw4iFH9mjb8DVY2mb82utdMBk6g9oC
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(54906003)(70206006)(478600001)(110136005)(2906002)(316002)(70586007)(36756003)(356005)(81166007)(921005)(86362001)(82740400003)(36860700001)(2616005)(1076003)(107886003)(7696005)(26005)(6666004)(336012)(4326008)(186003)(5660300002)(8676002)(41300700001)(82310400005)(40460700003)(83380400001)(426003)(40480700001)(47076005)(4744005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:51:24.4974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d35beff-be06-49ef-9132-08da900ee372
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In early_initcall, check if PMC device is available for use
and avoid accessing PMC resources if the device node status
property is set to disabled.

Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 6a86961477e8..8c7b46ac6ad6 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -4295,7 +4295,7 @@ static int __init tegra_pmc_early_init(void)
 		return -ENXIO;
 	}
 
-	if (np) {
+	if (of_device_is_available(np)) {
 		pmc->soc = match->data;
 
 		if (pmc->soc->maybe_tz_only)
-- 
2.17.1

