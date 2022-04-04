Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17D04F1EF2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379971AbiDDVrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379226AbiDDQtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:49:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2DF35DFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlAEH4kE4/6pmz65dlvoFxUYE78VTjOk4wNrPeb5HFdJlD6HrJWaKiWvuRJ4UsBlNh8MgwAsjyDQbMqmadh24EKqZoCqs4uclF1QwLo29/n4dhoGbEI3uk62R4OycjDyCpZzeK9V9VQVMVeNkw5ZUozSjgQAE/DWZv6UQgqDmpjGXnfnYuX9SiWD9MlxvIG7t2qjwkr5rZe9ONpFYGSW0rqUGknWPFGHhDAugApPmOOe97BaAs19CL213MgIyMQ1JG070uChSrZPLklr5NZB+bS2SU1T/AXv/wUd0KCKmse4tn12UKN7BRgxYdgmZcRxgoxpGDegGJrKRNuta+apUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9hMJlCRvhfC9XCtymsNu68XxXJSh88huRpW73wHGmw=;
 b=J5mN6aoBvjargmLMd1MD7eeBv0WXE2T6ICSKwVAl5mGSkip+IodCvpMoafwivqDq/xKk5OWdCesxn/8iv0La/o+SJFMcwWCcyPlBiB/FEdAnm/Zw58k5qnsdbWKBgAk/1k4WSVxW7KDN9koLHGTuNmFNT3xcv6aC4Ru/f00HBfDRvnz52ViTCCK9650KQwUnRsSi/v5bbHc9AO7CHSeePnZadNL6q6ogLi+jJl40UfUxgt1FlZ6TxJS/QgMPJnD2t/PyYgNBYR5KG02cXbggJ/Q95LI7BIUaQkOCh4bfh1SOZPHR4WzpvvpGa+UgA1Phdi+D0cM0mCUq/Alud0Pcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9hMJlCRvhfC9XCtymsNu68XxXJSh88huRpW73wHGmw=;
 b=3CqnLlZw2017cJ8YJkc2uYbCjVmrz99CYTUz1jo+7PD2h6RgW9cAz+xbWrBKUG+jsLAP5XIXsgeoGDjtfoLoxqpHYLU7a7ajKO0rwZaP9ojUjsyaQ9EQGrgnFYYXNm37iqMWDJKv/giSMSevIlOgdebjCSn5G9gZgvz6KqFPzg8=
Received: from BN6PR19CA0078.namprd19.prod.outlook.com (2603:10b6:404:133::16)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:47:33 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::c1) by BN6PR19CA0078.outlook.office365.com
 (2603:10b6:404:133::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 16:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 16:47:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 11:47:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Hegde Vasant <Vasant.Hegde@amd.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] iommu: Don't use swiotlb unless it's active
Date:   Mon, 4 Apr 2022 11:47:07 -0500
Message-ID: <20220404164707.1128-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404164707.1128-1-mario.limonciello@amd.com>
References: <20220404164707.1128-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7ace693-d299-4422-190c-08da165ad0d5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4230:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42302C53C188B078CEC74BE3E2E59@CH2PR12MB4230.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFZAe04DMsCrohIHxHCpf94GyTovHB1w/RWjjlWdOSNL7m9/w0QZ1+fUKtJQqYWd6fzmOWNA8O5xKhb85MeTD3oQPu+4UN0ZyBIrO1Eff/3M4Ih2DZKJ2dRMv2W6YkKN4ZPDsiSjbL1L5ZZ3EUzV79MvaE6W+GESTMqE1W4BtJzfACqbm/RKHw1N8nfT+vFVJd1uOJCgfg7zGfCNHKtcep7QPF76rFjSYV/5eSberVzRKuIFUD84wmicza27SbpMl/Bv3yND06PU2lV85u5gvC0d6/IKWDo6/DntEgbjSC8s1n34oQmWtRk7eJIYBvohMcL8WCDxsRvcFW7vSpIP+HPXfcD4H0qVprO4tXbvA8yM0q2lcrFeaxM4B9lGqXeGSkcRgMmJUPXcGxY+Aeyx9FJOPuo3q5blHjFevVODix/eU3Q8jfjOU3NRy0OYQQtK+Y1+sDkm4+T3LOeUEHZjQ9fjiecarq6eFv6ou1lbMU3xw4LOwZCSmOz157bconqDy5ai8ZQBR4Q/tw/TwDjgnOEJbQqWjvgFwvWdXr6R26zZjn+saEv8gLsKOywA9jCbwu/aqZyHJaS9u3ciCot4Au/hrhlO9JVB42Sp/RRKJhFdR8Bkb6QRytxZ9b2sRaFQUVFUqV/23vj9pxA2F9xz/YQOXc+V+XSYoehfucZjR11Mcw3l5bPpSA1JeQNj7iD+xMYQst2tJSVLCvWAqCkaeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(356005)(83380400001)(81166007)(54906003)(110136005)(40460700003)(8676002)(44832011)(36860700001)(4744005)(4326008)(86362001)(8936002)(82310400004)(5660300002)(316002)(70206006)(47076005)(70586007)(36756003)(26005)(1076003)(6666004)(7696005)(426003)(508600001)(186003)(16526019)(2616005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 16:47:33.2215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ace693-d299-4422-190c-08da165ad0d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper function `dev_use_swiotlb` is used for various decision
making points for how to handle DMA mapping requests.

If the kernel doesn't have any memory allocated for swiotlb to use, then
an untrusted device being connected to the system may fail to initialize
when a request is made.

To avoid this situation, don't mark the use of swiotlb when it has not
been set up.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..92ca136c8a12 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -504,7 +504,8 @@ static bool dev_is_untrusted(struct device *dev)
 
 static bool dev_use_swiotlb(struct device *dev)
 {
-	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
+	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) \
+		&& is_swiotlb_active(dev);
 }
 
 /**
-- 
2.34.1

